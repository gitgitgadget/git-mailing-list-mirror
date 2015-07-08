From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/9] grep: break down an "if" stmt in preparation for next changes
Date: Wed,  8 Jul 2015 17:38:32 +0700
Message-ID: <1436351919-2520-3-git-send-email-pclouds@gmail.com>
References: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
 <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: plamen.totev@abv.bg, l.s.r@web.de,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 12:38:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCmkC-0006dn-Ch
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 12:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934914AbbGHKiT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 06:38:19 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34952 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934356AbbGHKiP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 06:38:15 -0400
Received: by pdrg1 with SMTP id g1so12243142pdr.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 03:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ge6akOBv2UFVjNAoFaKDt6CTNklIJTNYzhI+rxrrEvk=;
        b=GY3II+3C5id5nz3gbmOnZCKLrkNsSNHHtmKkDCrB75G10rRNzXdTRhKONkwDe1Zh+q
         oy2B3wmLT52D79qfS0FavUPV7zmgJ9ytHpyQQPJvGcuiAKYOZV9ouZcJyB9cyD85C9lS
         j3LXhjLO319FiTePx9tEvBU9vdi0i+FuRBjiXZfdqWty05kFY/VY9dmtclxgvafjsykd
         JF+za5NDk9HL/cV1Jl8+HRB2RXqx7kpmq16Hp7Giq1MR5s4w+OPgd05c6m34gwb2P36I
         A8g65RF2yQMTLPm+oSbAJ3qw585alxgZ2nNDGDNXLxU47nxnlSXRcMAK2C1X8XM/Oiim
         7m+w==
X-Received: by 10.66.146.132 with SMTP id tc4mr19131441pab.124.1436351894709;
        Wed, 08 Jul 2015 03:38:14 -0700 (PDT)
Received: from lanh ([115.73.45.219])
        by smtp.gmail.com with ESMTPSA id m2sm2067886pdp.4.2015.07.08.03.38.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 03:38:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 08 Jul 2015 17:39:00 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273659>

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
