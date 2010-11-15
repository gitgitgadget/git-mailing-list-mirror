From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] clean: remove redundant variable baselen
Date: Mon, 15 Nov 2010 13:42:44 +0700
Message-ID: <1289803364-16452-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 07:44:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHsnU-0007qH-JT
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 07:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924Ab0KOGoH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 01:44:07 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33620 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0KOGoE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 01:44:04 -0500
Received: by iwn10 with SMTP id 10so6333903iwn.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 22:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=LP3Llsjsr7wlflpbGx+VO/BHxwknTi7UFKJbDEtVFI8=;
        b=j5a3K51374WpYnyP36MHvv+ZWmPyQQwqU8wMHEvkfwiUxD6xTD5wXhgNAFvh00gvix
         WwFFN2+rlWgzSeOi21bCloTUAYVBX6QHljWx83hrP23toR0Mvk/SiS8Pse8Xw/oMt8Au
         FFLJQIlYU4OWdAq4sbDeUEIuMXij5fiPIGpv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ood1HTbZ+p4vAFoMKHJk1pD3LszTKPznXvKgkU+cc5zjiD6LMjMmLc9YwAmdQT26He
         pzeta39FXnl4qC/pF8GDg6g+HJ905j7jP6qXK5FjocLjr+wm7u/9peyD2OMUmIfDpY14
         Skz2n/qBkYoMrKBZkzVd0xPDTSjROwPWqaaKQ=
Received: by 10.42.165.3 with SMTP id i3mr873386icy.233.1289803443914;
        Sun, 14 Nov 2010 22:44:03 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id 8sm7133079iba.10.2010.11.14.22.43.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 22:44:02 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Nov 2010 13:42:45 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161472>

baselen used to be the result of common_prefix() when it was made
builtin. Since 1d8842d (Add 'fill_directory()' helper function for
directory traversal - 2009-05-14), its value will always be
zero. Remove it because it's no longer variable.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Or bring common_prefix() back. I'm not sure if it's worth it.

 builtin/clean.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index c8798f5..5200cca 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -38,7 +38,7 @@ int cmd_clean(int argc, const char **argv, const char=
 *prefix)
 {
 	int i;
 	int show_only =3D 0, remove_directories =3D 0, quiet =3D 0, ignored =3D=
 0;
-	int ignored_only =3D 0, baselen =3D 0, config_set =3D 0, errors =3D 0=
;
+	int ignored_only =3D 0, config_set =3D 0, errors =3D 0;
 	int rm_flags =3D REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf directory =3D STRBUF_INIT;
 	struct dir_struct dir;
@@ -138,7 +138,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 		if (pathspec) {
 			memset(seen, 0, argc > 0 ? argc : 1);
 			matches =3D match_pathspec(pathspec, ent->name, len,
-						 baselen, seen);
+						 0, seen);
 		}
=20
 		if (S_ISDIR(st.st_mode)) {
--=20
1.7.3.2.210.g045198
