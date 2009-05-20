From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] setup_revisions(): do not access outside argv
Date: Wed, 20 May 2009 18:08:20 +1000
Message-ID: <1242806900-3499-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 10:09:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6gre-0005o1-Fv
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 10:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675AbZETIIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 04:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755415AbZETIIf
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 04:08:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:39859 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266AbZETIId (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 04:08:33 -0400
Received: by rv-out-0506.google.com with SMTP id f9so100241rvb.1
        for <git@vger.kernel.org>; Wed, 20 May 2009 01:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=EvW5jp6/7R/UVsnOlFQBdBEgBqmYTQWOQ42ts39GwlQ=;
        b=K1kcncP2KtTmjQfd5UfHK874ymWHIWDNPBEkYmDTuUazANFYWnldQnfWwtr23V4Qma
         ZJkSpNT3eMdvOOXLXleBR75tacHvUsdEeqxelkSUzjiWbQUGB3SzAM1EQL5wmEMvZigF
         RBPamE8qhCBb7YweRiVRJh8qe+wWVtOfXNFIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=hPZREsoPx/JY1iFLGSlNciyDgU/mkPszZOcA17lFbVSlm325581K0rO4N9y3gqAiCP
         jMG+d80cf2vdFPfaHKXVUqh2OBlhzJRkHwsYyt4r3a5uiI8MvmKH0+euOdlei+b0buLJ
         rimsmQrYdXzLeDVSRGCdFXZhn48rmvMzX1EIs=
Received: by 10.141.2.18 with SMTP id e18mr371375rvi.140.1242806915054;
        Wed, 20 May 2009 01:08:35 -0700 (PDT)
Received: from dektop ([119.12.168.65])
        by mx.google.com with ESMTPS id g31sm2516245rvb.53.2009.05.20.01.08.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 01:08:34 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 20 May 2009 18:08:27 +1000
X-Mailer: git-send-email test
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119586>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 revision.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 18b7ebb..be1e307 100644
--- a/revision.c
+++ b/revision.c
@@ -1241,9 +1241,9 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, const ch
 		if (strcmp(arg, "--"))
 			continue;
 		argv[i] =3D NULL;
-		argc =3D i;
-		if (argv[i + 1])
+		if (i + 1 < argc && argv[i + 1])
 			revs->prune_data =3D get_pathspec(revs->prefix, argv + i + 1);
+		argc =3D i;
 		seen_dashdash =3D 1;
 		break;
 	}
--=20
test
