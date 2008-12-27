From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] grep: support --no-ext-grep to test builtin grep
Date: Sat, 27 Dec 2008 15:21:04 +0700
Message-ID: <1230366064-1306-2-git-send-email-pclouds@gmail.com>
References: <1230366064-1306-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Dec 27 09:23:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGURo-0006uG-Oy
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 09:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbYL0IVe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 03:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbYL0IVd
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 03:21:33 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:27750 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbYL0IVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 03:21:32 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3764552rvb.1
        for <git@vger.kernel.org>; Sat, 27 Dec 2008 00:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=UF/Cx1b/lFM/fpJGgkH8NZEulbI+vtNhxKR/arTDtSE=;
        b=FkapKRXqwScp7O12wZSsmwLdaToy7BZJ4rHsygOHXOeELk79pfmwODaP97Drfo9uL3
         a/umQSCb/a173vamRKaRv73MrR+ahVMywpUBwGZzqe3o5jrxGH1WD4ZvbKgcE6qPka94
         IAHwJAM8vkqOpxF2pDDb9isa3NWBYp9oG+sQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CIISDoAISFm0o/0DIbS9oCzC0B0miKBuKhr8Md+Jj4EOGA8H7goTeUNuEwiNByjpxT
         yychySjKg05kIEF8A0AA7O/MNRuw7iDw1kk39HFGXD32XWgLmAHgcGy9roLSIsYdhXZy
         Kc1PHxXiTRoV09r1cIuuqUzR1q7ggrjvqDDmE=
Received: by 10.141.203.2 with SMTP id f2mr5659642rvq.97.1230366092630;
        Sat, 27 Dec 2008 00:21:32 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.192.118])
        by mx.google.com with ESMTPS id f42sm2385488rvb.8.2008.12.27.00.21.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Dec 2008 00:21:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Dec 2008 15:21:11 +0700
X-Mailer: git-send-email 1.6.0.4.1116.g25b13
In-Reply-To: <1230366064-1306-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103988>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 used by the next patch

 builtin-grep.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 624f86e..3c97c2c 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -20,6 +20,8 @@
 #endif
 #endif
=20
+static int builtin_grep;
+
 /*
  * git grep pathspecs are somewhat different from diff-tree pathspecs;
  * pathname wildcards are allowed.
@@ -389,7 +391,7 @@ static int grep_cache(struct grep_opt *opt, const c=
har **paths, int cached)
 	 * we grep through the checked-out files. It tends to
 	 * be a lot more optimized
 	 */
-	if (!cached) {
+	if (!cached && !builtin_grep) {
 		hit =3D external_grep(opt, paths, cached);
 		if (hit >=3D 0)
 			return hit;
@@ -545,6 +547,10 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 			cached =3D 1;
 			continue;
 		}
+		if (!strcmp("--no-ext-grep", arg)) {
+			builtin_grep =3D 1;
+			continue;
+		}
 		if (!strcmp("-a", arg) ||
 		    !strcmp("--text", arg)) {
 			opt.binary =3D GREP_BINARY_TEXT;
--=20
1.6.0.4.1116.g25b13
