From: Alex Riesen <raa.lkml@gmail.com>
Subject: trivial: O_EXCL makes O_TRUNC redundant
Date: Thu, 5 Jan 2006 09:58:06 +0100
Message-ID: <81b0412b0601050058y27eb492fu9a24f99e32e9f439@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_9688_5972949.1136451486540"
X-From: git-owner@vger.kernel.org Thu Jan 05 10:00:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuQyj-0004lu-Sl
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 10:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbWAEJAK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 04:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbWAEJAK
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 04:00:10 -0500
Received: from zeus2.kernel.org ([204.152.191.36]:16345 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1752120AbWAEJAJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 04:00:09 -0500
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.194])
	by zeus2.kernel.org (8.13.1/8.13.1) with ESMTP id k05907rw008544
	for <git@vger.kernel.org>; Thu, 5 Jan 2006 01:00:08 -0800
Received: by nproxy.gmail.com with SMTP id l35so1077934nfa
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 00:58:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=bI9tXyzXrLyXASyhKV4bxDDXl0GoJG7KzB7WBn8VsaJoTzj85u7jYMjNC4lBJN4R0PYqmmjFQzomSrpoGxoaHn87l7uzWzwcmEwLByrXB8Za9zsgNmOeuxDD55othhN/pR7CUxkOHh/wQBSHfHdMNfaJOpPZxnupWiCFWe6BdGI=
Received: by 10.48.245.12 with SMTP id s12mr675246nfh;
        Thu, 05 Jan 2006 00:58:06 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Thu, 5 Jan 2006 00:58:06 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus2
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14185>

------=_Part_9688_5972949.1136451486540
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

------=_Part_9688_5972949.1136451486540
Content-Type: text/plain; name=0001-O_EXCL-makes-O_TRUNC-redundant.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-O_EXCL-makes-O_TRUNC-redundant.txt"

Subject: [PATCH] O_EXCL makes O_TRUNC redundant

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>


---

 apply.c |    2 +-
 entry.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

4d5e4d8d468c0eedf489104e9f02f86c635c8ac2
diff --git a/apply.c b/apply.c
index d5e7bfd..9eba034 100644
--- a/apply.c
+++ b/apply.c
@@ -1588,7 +1588,7 @@ static int try_create_file(const char *p
 
 	if (S_ISLNK(mode))
 		return symlink(buf, path);
-	fd = open(path, O_CREAT | O_EXCL | O_WRONLY | O_TRUNC, (mode & 0100) ? 0777 : 0666);
+	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, (mode & 0100) ? 0777 : 0666);
 	if (fd < 0)
 		return -1;
 	while (size) {
diff --git a/entry.c b/entry.c
index 15b34eb..410b758 100644
--- a/entry.c
+++ b/entry.c
@@ -60,7 +60,7 @@ static void remove_subtree(const char *p
 static int create_file(const char *path, unsigned int mode)
 {
 	mode = (mode & 0100) ? 0777 : 0666;
-	return open(path, O_WRONLY | O_TRUNC | O_CREAT | O_EXCL, mode);
+	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
 }
 
 static int write_entry(struct cache_entry *ce, const char *path, struct checkout *state)
-- 
1.0.GIT

------=_Part_9688_5972949.1136451486540--
