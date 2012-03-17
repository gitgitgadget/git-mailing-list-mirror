From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: [PATCH/RFC] Add "first parent" to gitglossary
Date: Sat, 17 Mar 2012 01:47:44 -0500
Message-ID: <1331966864-31687-1-git-send-email-nkreitzinger@gmail.com>
Cc: jrnieder@gmail.com, gitster@pobox.com, bfields@fieldses.org,
	phil.hord@gmail.com, Neal Kreitzinger <nkreitzinger@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 07:48:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8nRU-0000NF-M6
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 07:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab2CQGsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 02:48:21 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48325 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab2CQGsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 02:48:20 -0400
Received: by obbeh20 with SMTP id eh20so89461obb.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 23:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=q3Z1pAXABNqy7QKbEsByn/1teopObjQlRJ8skYUdMQc=;
        b=NzKeudNDGr141k+h7FknaGr/ToZKYajB9pa8ytIQ2gOWtbooeGCeiHLgh47rHRTy9+
         VUeENyouvTpPpQAo86Vyn73Ty2lgSvkfdQ2lh+rueoM8FDv82YQj3HMqgTDOf+30PpPg
         dgIRCKJCKb1rwqq40oH+U252wHjAKYNSxr3h/9siG0wV92Wl9cSSTchIIKQ7+A7amN/0
         8b43TvzZT8GFjJ9P+3JA+z0WF9VMLR/2XTzcRkbKiCE5HbOiGI0b6Vd32xsGauKlmi8N
         Ppn6GoYx+6JmdH0sKYcmPb0+eSfIs/xAATOHy94JUtpp4e/aAqd0rjz4iKNYXvOM87S0
         tQ2Q==
Received: by 10.182.227.37 with SMTP id rx5mr5328694obc.53.1331966899397;
        Fri, 16 Mar 2012 23:48:19 -0700 (PDT)
Received: from localhost.localdomain ([216.58.158.66])
        by mx.google.com with ESMTPS id 8sm6976120obv.19.2012.03.16.23.48.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 23:48:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193309>

Add "first parent" to "gitglossary" reference manual page.  Use the
definition provided by Junio Hamano in a git newsgroup post[1].

[1] http://article.gmane.org/gmane.comp.version-control.git/192523

Signed-off-by: Neal Kreitzinger <nkreitzinger@gmail.com>
Tested-by: Neal Kreitzinger <nkreitzinger@gmail.com>
---
Hi,

Why I did this patch:

I wanted to know for sure what "first parent" meant and not incorrectly
assume that I knew what it meant, and although I found it referenced
abundantly nowhere could I find it defined explicitly.

"first parent" is a git-ish term used often by git people, especially
by git gurus.  It even has its own option --first-parent for several git
commands.  However, the meaning of this term is never explicitly defined
in the documents that use it and the reader is left to infer the implied
meaning.  This glossary entry explicity defines the term in git-ish and
human-ish terms for mere mortals.

How I tested this patch in /home/me/git/.git master branch:

PWD=/home/me/git
$ git send-email ("from:" my linux user "to:" my linux user)
$ git reset --hard HEAD^
$ git am /var/spool/mail/me
$ gitk (commit looked right)
$ make doc
linux gui: "open with FireFox" for files:
/home/me/git/Documentation/gitglossary.html
/home/me/git/Documentation/user-manual.html
(IMO, they looked right)

I attempted to follow SubmittingPatches, and assume that the above test
is sufficient to ensure a properly formatted patch and to provide a 
"Tested-by:" tag (let me know otherwise).

v/r,
neal

 Documentation/glossary-content.txt |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 3595b58..d0abc7d 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -146,6 +146,30 @@ to point at the new commit.
 	i.e. the infrastructure to hold files and directories. That ensured the
 	efficiency and speed of git.
 
+[[def_first_parent]]first parent::
+	The mechanical definition of "first parent" is that:
++
+* A merge is a commit with more than one parent.
+* When you run "merge", you are on one commit, HEAD, taking changes
+made by "other brances" you are merging into "your history"
+(whose definition is "the commit-dag leading to your HEAD
+commit"), and record the resulting tree as a new commit.
+* This new commit records all its parents, one of them being your
+old "HEAD" and the rest being "other branches" you merged into
+"your history".  They are recorded in that order in the resulting
+commit ("git cat-file commit HEAD" after a merge to see them).
+
++
+Hence, the first parent of a merge is the HEAD the committer was at
+when he ran "git merge".
++
+Given the above definition, the first thing to realize is that "the
+first parent" is primarily a local concept.  If you are looking at
+one commit on a run of "a single strand of pearls", it only has one
+parent (i.e. its first parent), and it is the state the committer
+was on when he made the commit.  If you are looking at a merge, its
+first parent is the commit the person who made the merge was on.
+
 [[def_git_archive]]git archive::
 	Synonym for <<def_repository,repository>> (for arch people).
 
-- 
1.7.1
