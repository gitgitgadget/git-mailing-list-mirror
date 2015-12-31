From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/7] diff --color-words: another special diff case
Date: Thu, 31 Dec 2015 19:37:33 +0700
Message-ID: <1451565457-18756-4-git-send-email-pclouds@gmail.com>
References: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 13:38:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEcUc-0001Rk-Qm
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 13:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbbLaMiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2015 07:38:05 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34612 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbbLaMiE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 07:38:04 -0500
Received: by mail-pa0-f54.google.com with SMTP id uo6so130635457pac.1
        for <git@vger.kernel.org>; Thu, 31 Dec 2015 04:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kNAuhWP4eI2FoyVfiOD1OzDIoVs9L9s1nshdVHWV3ZU=;
        b=OKenaXpxBJO3I8IA1l7GD9eB8nJlkcwcwtMCKMbbPZOX4SoYKNENbc8x97Nu0bTf/z
         AJENvFG00NwJS8dJEfHT4DYDNC5RQWVkwBLl3bANj8spFrHNQcFxtVOOrYb34wHe3mto
         NoBavg2yl0kofRQ1b3888LJyvcayaxkY1yDNs3sXM/LwNeGVdQMgOGMKJXPJFURi72wn
         J/DwXKCKuFhG9MoPtwP8wTpg9ctJyIatNlAAcIbbShadiHDYWdNMHjg3MTV9nO4//GIz
         mWrKb6m5whrIyjEofTGBUGfWIksGovJzO7p19T88eTml8BdZGGXjZPvygOasnIgj+Hv4
         jvUQ==
X-Received: by 10.66.190.7 with SMTP id gm7mr41727624pac.79.1451565483402;
        Thu, 31 Dec 2015 04:38:03 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id zo4sm89288002pac.28.2015.12.31.04.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2015 04:38:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 31 Dec 2015 19:38:00 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283239>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/diff.c b/diff.c
index 8af1df1..1354368 100644
--- a/diff.c
+++ b/diff.c
@@ -1037,6 +1037,16 @@ static void diff_words_show(struct diff_words_da=
ta *diff_words)
 		diff_words->minus.text.size =3D 0;
 		return;
 	}
+	/* special case: only addition */
+	if (!diff_words->minus.text.size) {
+		fputs(line_prefix, diff_words->opt->file);
+		fn_out_diff_words_write_helper(diff_words->opt->file,
+			&style->new, style->newline,
+			diff_words->plus.text.size,
+			diff_words->plus.text.ptr, line_prefix);
+		diff_words->plus.text.size =3D 0;
+		return;
+	}
=20
 	diff_words->current_plus =3D diff_words->plus.text.ptr;
 	diff_words->last_minus =3D 0;
--=20
2.3.0.rc1.137.g477eb31
