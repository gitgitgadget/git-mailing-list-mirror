From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/7] diff.c: keep all word diff structs together
Date: Thu, 31 Dec 2015 19:37:31 +0700
Message-ID: <1451565457-18756-2-git-send-email-pclouds@gmail.com>
References: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 13:37:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEcUO-0001CE-Ss
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 13:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbbLaMhz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2015 07:37:55 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36391 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbbLaMhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 07:37:52 -0500
Received: by mail-pa0-f43.google.com with SMTP id yy13so59480132pab.3
        for <git@vger.kernel.org>; Thu, 31 Dec 2015 04:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=a0YHcaWDDxqX19uAQOwvN3pudNX23AOoy0jCEJtdy5I=;
        b=G29fJVAnCMyjVwLllE9jonI7gvUODpNQdFCDPAQfHZlmi2SuG59XQEmQ79/PA/nOpl
         5VdsB90DjSl9z8uFSVNgWl3SSqZRoxmG2iJZPT/P+UvHuogsnzQKBO7acm7K3XzPINYJ
         ItGpym/nbfmTtgk8ckr/MgnkRKhxcMzYhd0eD7vvsgHO5Fdt6PUWp4VS+HpdxIVxz7yI
         GMLoddtHc9TmHLg7eooJpvUffpA9qFHw029AjI4+STrqMVVz2Af/CkGuShwvLMiwKaXA
         RUinhJMVgL+BVmkiiy78niZdNOrMJFLka93RlpUj8vFuFHGd0+RKZEVlhg2RxA9qYfo4
         2YGA==
X-Received: by 10.66.184.15 with SMTP id eq15mr45005308pac.42.1451565471730;
        Thu, 31 Dec 2015 04:37:51 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id h10sm101640136pat.7.2015.12.31.04.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2015 04:37:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 31 Dec 2015 19:37:47 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283236>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 80eb0c2..dfbed41 100644
--- a/diff.c
+++ b/diff.c
@@ -759,17 +759,6 @@ struct diff_words_buffer {
 	int orig_nr, orig_alloc;
 };
=20
-static void diff_words_append(char *line, unsigned long len,
-		struct diff_words_buffer *buffer)
-{
-	ALLOC_GROW(buffer->text.ptr, buffer->text.size + len, buffer->alloc);
-	line++;
-	len--;
-	memcpy(buffer->text.ptr + buffer->text.size, line, len);
-	buffer->text.size +=3D len;
-	buffer->text.ptr[buffer->text.size] =3D '\0';
-}
-
 struct diff_words_style_elem {
 	const char *prefix;
 	const char *suffix;
@@ -799,6 +788,17 @@ struct diff_words_data {
 	struct diff_words_style *style;
 };
=20
+static void diff_words_append(char *line, unsigned long len,
+		struct diff_words_buffer *buffer)
+{
+	ALLOC_GROW(buffer->text.ptr, buffer->text.size + len, buffer->alloc);
+	line++;
+	len--;
+	memcpy(buffer->text.ptr + buffer->text.size, line, len);
+	buffer->text.size +=3D len;
+	buffer->text.ptr[buffer->text.size] =3D '\0';
+}
+
 static int fn_out_diff_words_write_helper(FILE *fp,
 					  struct diff_words_style_elem *st_el,
 					  const char *newline,
--=20
2.3.0.rc1.137.g477eb31
