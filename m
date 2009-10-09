From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/9] Documentation: clarify branch creation
Date: Fri, 9 Oct 2009 05:19:40 -0500
Message-ID: <20091009101940.GG16558@progeny.tock>
References: <20091009101400.GA16549@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:14:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwCUv-0002is-K7
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760596AbZJIKMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760589AbZJIKMF
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:12:05 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:48528 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760391AbZJIKME (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 06:12:04 -0400
Received: by ywh6 with SMTP id 6so6100112ywh.4
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 03:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qlpUiP+FfezdN0/rzQvjIbxKXpISrW+Qy8DhRyqhd6g=;
        b=uQpLTWGdrBtvQfNFTPgJuiQ+XO5OiRLEB5jNXX1X+JClGUw1J/6vgc7ELMsJnYAIlX
         bH8H7aRvanBQqvuEy2b8XUM+Lu42v+kNMVvEm0BHjkrnMYY0hy+GD5sIPGXMyBCgK5sq
         lYL+d8au7c1Xiy3ASjL1d8meXxnBKNpToHxHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TnySwTjn0jHtyAFlsIwtyvwzoxNwQYdnGpr1TvJ4sQAyWsumPLWj/fNkUCpzICVrJV
         1Frv/aqXIc7mLD71dIO/80AC7p2iioph7wSrKsEv3h6+HKNeR0IqW6s5REfIVqLVN4jH
         ZCEchP56McAej803vTpDi1TW7Q6U47YkbSGhA=
Received: by 10.150.29.5 with SMTP id c5mr4500003ybc.34.1255083088227;
        Fri, 09 Oct 2009 03:11:28 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm448391gxk.2.2009.10.09.03.11.27
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 03:11:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091009101400.GA16549@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129762>

The documentation seems to assume that the starting point for a new
branch is the tip of an existing (ordinary) branch, but that is not
the most common case.  More often, "git branch" is used to begin
a branch from a remote-tracking branch, a tag, or an interesting
commit (e.g. origin/pu^2).  Clarify the language so it can apply
to these cases.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-branch.txt |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index e8b32a2..990f782 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -30,10 +30,11 @@ commit) will be listed.  With `--no-merged` only branches not merged into
 the named commit will be listed.  If the <commit> argument is missing it
 defaults to 'HEAD' (i.e. the tip of the current branch).
 
-In the command's second form, a new branch named <branchname> will be created.
-It will start out with a head equal to the one given as <start-point>.
-If no <start-point> is given, the branch will be created with a head
-equal to that of the currently checked out branch.
+In the command's second form, creates a new branch named <branchname>.
+The branch will start out with head pointing to the commit
+<start-point>.  If no <start-point> is given, the branch will start
+out with head pointing to the tip of the currently checked out branch,
+or the currently checked out commit if no branch is checked out.
 
 Note that this will create the new branch, but it will not switch the
 working tree to it; use "git checkout <newbranch>" to switch to the
@@ -149,9 +150,11 @@ start-point is either a local or remote branch.
 	may restrict the characters allowed in a branch name.
 
 <start-point>::
-	The new branch will be created with a HEAD equal to this.  It may
-	be given as a branch name, a commit-id, or a tag.  If this option
-	is omitted, the current branch is assumed.
+	The new branch head will point to this commit.  It may be
+	given as a branch name, a commit-id, or a tag.  If this
+	option is omitted, the currently checked out branch head
+	is used, or the current commit if no branch is checked
+	out.
 
 <oldbranch>::
 	The name of an existing branch to rename.
-- 
1.6.5.rc1.199.g596ec
