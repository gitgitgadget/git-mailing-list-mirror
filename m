From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 03/11] test-regex: isolate the bug test code
Date: Sat,  6 Feb 2016 09:03:02 +0700
Message-ID: <1454724190-14063-4-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 03:03:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRsDy-0003Yu-5g
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 03:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbcBFCDm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 21:03:42 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35634 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbcBFCDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 21:03:41 -0500
Received: by mail-pa0-f43.google.com with SMTP id ho8so42986692pac.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 18:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9QWTd4yHlzDh1+RwiljaOmHaAjgrdpm2PEF/uepoYiQ=;
        b=p9sAoymowSh4LxL9ggzcbeHpqfn6dCOCd688hbBKylbrIZHWMdVXQMhJeO55HaDH3R
         JezvtiKrp5TyojcxO3IuqG9u4Ez6VwR8Umc8yA3f0wLT20Q8JHkDyESq2dDovP9j5l6K
         PfALODwif2uB6O20FvwuVNYIOQvTzc4TiEOHm509NQ5dhcHp+qvkD0jOYJeJkvorPlDC
         ZE+eQlF5CvgXJ0BbeG0oEipNAzD7wObcPT3Nh+k7jUX6PxuqR76mavghGVFSJrh9dy1S
         HRHYFioIcco9QImME0adoM+NF6ONxFQjyzYwUURh06hk4KDZAtIMQGuYZ3RPEM7DChOh
         sjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=9QWTd4yHlzDh1+RwiljaOmHaAjgrdpm2PEF/uepoYiQ=;
        b=c2STtJhZjHUjNEYCZx6j5JJcMeduMPX89A39chG5Zc/pNq6VX9MDhRuLNkdppjM9tI
         465FDweuOxt3QVu82/MZbjCx2Y7BmXDgnPEXVB/EZbSi0b2tqy50IeUcvo00Po4ONAbk
         t+ybWasopw+B0N1v5qPCAc7wo16ZwJhULDN1fSp8/sTl4rIdwrd+j7NVuvaNeAEUutOl
         jXVYRjiECULJ5C62IOZXYrqTyPrPS2BdNlao4e2czgxRXKEoYi49LIhj2CndNxiYQT9M
         w1EAOgNZEsO0JRyYyfF3pnw0Md7WBbUXVWQqv9jC39LwtfJuxNhnr0yJbRVb5VC2FJfm
         ZkUg==
X-Gm-Message-State: AG10YOQABobu5kbgPMvCl919lN5F54lAOnH72eN9gdEbY1dg6vpmSpVpeDTW4ZTRDtozvg==
X-Received: by 10.66.218.73 with SMTP id pe9mr24322782pac.91.1454724220982;
        Fri, 05 Feb 2016 18:03:40 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 191sm27245259pfa.23.2016.02.05.18.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 18:03:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 06 Feb 2016 09:03:54 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285668>

This is in preparation to turn test-regex into some generic regex
testing command.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t0070-fundamental.sh |  2 +-
 test-regex.c           | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 5ed69a6..991ed2a 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -31,7 +31,7 @@ test_expect_success 'git_mkstemps_mode does not fail =
if fd 0 is not open' '
=20
 test_expect_success 'check for a bug in the regex routines' '
 	# if this test fails, re-build git with NO_REGEX=3D1
-	test-regex
+	test-regex --bug
 '
=20
 test_done
diff --git a/test-regex.c b/test-regex.c
index 0dc598e..8c51f5a 100644
--- a/test-regex.c
+++ b/test-regex.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
=20
-int main(int argc, char **argv)
+static int test_regex_bug(void)
 {
 	char *pat =3D "[^=3D{} \t]+";
 	char *str =3D "=3D{}\nfred";
@@ -16,5 +16,13 @@ int main(int argc, char **argv)
 	if (m[0].rm_so =3D=3D 3) /* matches '\n' when it should not */
 		die("regex bug confirmed: re-build git with NO_REGEX=3D1");
=20
-	exit(0);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	if (argc =3D=3D 2 && !strcmp(argv[1], "--bug"))
+		return test_regex_bug();
+	else
+		die("must be used with --bug");
 }
--=20
2.7.0.377.g4cd97dd
