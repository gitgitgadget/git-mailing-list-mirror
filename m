From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 3/4] Documentation: Update the NFS remote examples to use
 the staging repo
Date: Sat, 22 Jun 2013 10:46:26 -0400
Message-ID: <d668c4fac602e8f97a7abdb36a169b5a67bc3383.1371911897.git.wking@tremily.us>
References: <7vppvhye6s.fsf@alter.siamese.dyndns.org>
 <cover.1371911897.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 16:46:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqP5T-0003WR-If
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 16:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756316Ab3FVOql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 10:46:41 -0400
Received: from vms173011pub.verizon.net ([206.46.173.11]:50188 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642Ab3FVOqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 10:46:33 -0400
Received: from odin.tremily.us ([unknown] [72.68.80.60])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MOS00BC0UDKB110@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 22 Jun 2013 09:46:32 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id CCD29A3D882; Sat,
 22 Jun 2013 10:46:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1371912391; bh=vs/LTenVHyK+MHhTkrvtzTFTuK4UVgNYuj2419zDXZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=WD4PlfeAmOUhkCyspe+lcX7ji9aLbXL0nsUF0JdVtRDZcozmqmDGulr68yyXxcPrx
 UMgmr4cFBLhnY0nF3eBb36HBg5eoEZrSNs65WuWr3ct28aSDFteNdMedbxCf1ep4Ia
 uQZn5tr81ictncS2RR9upESdlO+bocZxVysicPEU=
X-Mailer: git-send-email 1.8.1.5
In-reply-to: <cover.1371911897.git.wking@tremily.us>
In-reply-to: <cover.1371911897.git.wking@tremily.us>
References: <cover.1371911897.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228711>

From: "W. Trevor King" <wking@tremily.us>

linux-nfs.org seems to have restructured their repository layout since
8391c60 (git-remote.txt: fix example url, 2007-11-02), and Bruce's
repo is now at git://git.linux-nfs.org/projects/bfields/linux.git.
Bruce also has a more richer internal branch structure (master,
everything, for-3.1, ...), so updating the existing example to use his
current repo may be confusing.

To simplify, I've replaced the NFS repo with Greg's staging repo.
I've also updated the output of the surrounding commands to match the
output of a current run through.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-remote.txt  | 25 ++++++++++++++++---------
 Documentation/user-manual.txt | 26 ++++++++++++++++----------
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 7a6f354..d007163 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -187,18 +187,25 @@ Examples
 $ git remote
 origin
 $ git branch -r
-origin/master
-$ git remote add linux-nfs git://linux-nfs.org/pub/linux/nfs-2.6.git
+  origin/HEAD -> origin/master
+  origin/master
+$ git remote add staging git://git.kernel.org/.../gregkh/staging.git
 $ git remote
-linux-nfs
 origin
-$ git fetch
-* refs/remotes/linux-nfs/master: storing branch 'master' ...
-  commit: bf81b46
+staging
+$ git fetch staging
+...
+From git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
+ * [new branch]      master     -> staging/master
+ * [new branch]      staging-linus -> staging/staging-linus
+ * [new branch]      staging-next -> staging/staging-next
 $ git branch -r
-origin/master
-linux-nfs/master
-$ git checkout -b nfs linux-nfs/master
+  origin/HEAD -> origin/master
+  origin/master
+  staging/master
+  staging/staging-linus
+  staging/staging-next
+$ git checkout -b staging staging/master
 ...
 ------------
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index e831cc2..4283d8f 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -431,19 +431,25 @@ You can also track branches from repositories other than the one you
 cloned from, using linkgit:git-remote[1]:
 
 -------------------------------------------------
-$ git remote add linux-nfs git://linux-nfs.org/pub/nfs-2.6.git
-$ git fetch linux-nfs
-* refs/remotes/linux-nfs/master: storing branch 'master' ...
-  commit: bf81b46
+$ git remote add staging git://git.kernel.org/.../gregkh/staging.git
+$ git fetch staging
+...
+From git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
+ * [new branch]      master     -> staging/master
+ * [new branch]      staging-linus -> staging/staging-linus
+ * [new branch]      staging-next -> staging/staging-next
 -------------------------------------------------
 
 New remote-tracking branches will be stored under the shorthand name
-that you gave `git remote add`, in this case `linux-nfs`:
+that you gave `git remote add`, in this case `staging`:
 
 -------------------------------------------------
 $ git branch -r
-linux-nfs/master
-origin/master
+  origin/HEAD -> origin/master
+  origin/master
+  staging/master
+  staging/staging-linus
+  staging/staging-next
 -------------------------------------------------
 
 If you run `git fetch <remote>` later, the remote-tracking branches
@@ -455,9 +461,9 @@ a new stanza:
 -------------------------------------------------
 $ cat .git/config
 ...
-[remote "linux-nfs"]
-	url = git://linux-nfs.org/pub/nfs-2.6.git
-	fetch = +refs/heads/*:refs/remotes/linux-nfs/*
+[remote "staging"]
+	url = git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
+	fetch = +refs/heads/*:refs/remotes/staging/*
 ...
 -------------------------------------------------
 
-- 
1.8.3
