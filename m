From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/9] grep: break down an "if" stmt in preparation for next changes
Date: Tue, 14 Jul 2015 20:24:33 +0700
Message-ID: <1436880280-18194-3-git-send-email-pclouds@gmail.com>
References: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
 <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, plamen.totev@abv.bg,
	l.s.r@web.de, Eric Sunshine <sunshine@sunshineco.com>,
	tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 15:24:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF0C1-0006KQ-6z
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 15:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbbGNNYM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 09:24:12 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33756 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbbGNNYL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 09:24:11 -0400
Received: by pdbqm3 with SMTP id qm3so6070802pdb.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 06:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ge6akOBv2UFVjNAoFaKDt6CTNklIJTNYzhI+rxrrEvk=;
        b=0ftzwOiVnJldZprns4u7YoqNmkxzEZlMqONz1CL1n2xraqE9mcw1p9WtPWNnm2iiF8
         fGtFJKsRaRpXe8LrLrIpHWrK790xyq9oHUaUVC9aVO71vyPuTQgXmDixtwbP3zuO5vQs
         MuE87iie24JH24ehbPeGKbxc2mb3VBf0tidfJ7VlIme0r5p72MeOmaNK3SJ/gdq2z01Z
         U+U0tsBcfrnBC3t3Tjg6YujZYO0BEgvHpT/L6LHqU8xUs1pv2RWVIRIeWqpdtQwiddsF
         L/Z7GssnlHoiMhwil35e4+XVNOgf/f6/CFimvv8IHGv41eOrOPZ3bF08fiOe+Xqdk22Y
         T+og==
X-Received: by 10.68.229.40 with SMTP id sn8mr79103114pbc.59.1436880250863;
        Tue, 14 Jul 2015 06:24:10 -0700 (PDT)
Received: from lanh ([115.73.59.196])
        by smtp.gmail.com with ESMTPSA id b12sm1434034pbu.20.2015.07.14.06.24.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 06:24:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 14 Jul 2015 20:25:02 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273954>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index b58c7c6..bd32f66 100644
--- a/grep.c
+++ b/grep.c
@@ -403,9 +403,11 @@ static void compile_regexp(struct grep_pat *p, str=
uct grep_opt *opt)
 	p->word_regexp =3D opt->word_regexp;
 	p->ignore_case =3D opt->ignore_case;
=20
-	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
+	if (is_fixed(p->pattern, p->patternlen))
 		p->fixed =3D 1;
-	else
+	else if (opt->fixed) {
+		p->fixed =3D 1;
+	} else
 		p->fixed =3D 0;
=20
 	if (p->fixed) {
--=20
2.3.0.rc1.137.g477eb31
