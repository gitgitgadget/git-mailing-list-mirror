From: Igor Mironov <igor.a.mironov@gmail.com>
Subject: [PATCH 3/4] git-svn: support options --username and --commit-url
 in branch/tag
Date: Tue, 12 Jan 2010 03:21:51 +1100
Message-ID: <4B4B501F.3060101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 17:22:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUN1p-0006PE-MA
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 17:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259Ab0AKQWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 11:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209Ab0AKQWA
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 11:22:00 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:42534 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab0AKQV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 11:21:59 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so392511bwz.21
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 08:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=4TKQ03gPN+kpAwzZsCXm4R77UuAtj+H3Xwi95GQ3Qy0=;
        b=rSBwIerZbxOI0CCk4T2Geo66WJgwY2Lbl6e1iSjI/pTxu3INlZjHjN//4lwDKOFyw0
         I9mTk6MRANajtXDymb83iLEfEXQbAmqU6DIafo8UTQe46f/4btP0THZo75OrP//50X6v
         moFGt0gYvI8LgaoY6aSvNp3LHas8vPVzdwm10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=htlBLKqTfVltW2mCwnA7+jk+wqRFli+pjSe0q6NElZ/SxRpTSI32xVWnXp5FFbJsXd
         iMOPEFFh8EzTjarOm34j6sEt4ZaPj0Hojw2AaD7iF3kIuu+2ntjMupdmzAInWiwpphbQ
         Yld4f7M5rsV8YL4efbgktmlxK6yr5DHoFmx+8=
Received: by 10.204.48.132 with SMTP id r4mr1315627bkf.158.1263226918488;
        Mon, 11 Jan 2010 08:21:58 -0800 (PST)
Received: from ?10.54.5.111? (ppp121-45-186-233.lns20.syd7.internode.on.net [121.45.186.233])
        by mx.google.com with ESMTPS id 16sm8924360bwz.7.2010.01.11.08.21.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Jan 2010 08:21:57 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136637>

Add ability to specify on the command line the username to perform the operation as and the writable URL of the repository to perform it on.
Signed-off-by: Igor Mironov <igor.a.mironov@gmail.com>
---
 git-svn.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 3bdd8d3..0da6c67 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -155,12 +155,16 @@ my %cmd = (
 	            { 'message|m=s' => \$_message,
 	              'destination|d=s' => \$_branch_dest,
 	              'dry-run|n' => \$_dry_run,
-		      'tag|t' => \$_tag } ],
+	              'tag|t' => \$_tag,
+	              'username=s' => \$Git::SVN::Prompt::_username,
+	              'commit-url=s' => \$_commit_url } ],
 	tag => [ sub { $_tag = 1; cmd_branch(@_) },
 	         'Create a tag in the SVN repository',
 	         { 'message|m=s' => \$_message,
 	           'destination|d=s' => \$_branch_dest,
-	           'dry-run|n' => \$_dry_run } ],
+	           'dry-run|n' => \$_dry_run,
+	           'username=s' => \$Git::SVN::Prompt::_username,
+	           'commit-url=s' => \$_commit_url } ],
 	'set-tree' => [ \&cmd_set_tree,
 	                "Set an SVN repository to a git tree-ish",
 			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
-- 
1.6.6.106.ge2de8
