From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/41] builtin/merge-file.c: use error_errno()
Date: Tue,  3 May 2016 19:03:42 +0700
Message-ID: <1462277054-5943-10-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:08:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ7Y-0000Pj-Eq
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699AbcECMH5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:07:57 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36702 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933051AbcECMHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:07:08 -0400
Received: by mail-pf0-f169.google.com with SMTP id c189so9663129pfb.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8n8e5obNaheWOFTACXc1S60e/ZpEkj2Kn4uPIGdZ5lc=;
        b=iChpSo24OzdUaowf5a7ZLN8ueJHRRDk+ldtMQZ0gJHg08zHHaf9oTkUyi842sKrw7y
         JMV1yCCqHckKlQS+Wx2MBP+gjuT0ldTelfi/RdAC5Pl+f7MFXtRUqRjS/ROvXATicvAO
         C0ZRzPAljpZUdGNqo/oG9D7I23O67wHc0wjcP126ONl772c4ZacGx2hlAvKC5wDt+COp
         vOlH1LnYUAszI9M54SW8v5FEv/HCCVMJxcRq+9sdyHTSs2X39hRTeaBw9s5F9bVpIAVt
         0oLx7uTeKwHJ5UYt1TSVQuw9UG6mGmG7bCFvU/XzFvNoDXySSYsAlLZf9jq7pViby3v/
         VadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8n8e5obNaheWOFTACXc1S60e/ZpEkj2Kn4uPIGdZ5lc=;
        b=joBhOXNc0jXRQ+puGDqyuqwy5FDv1t9k89Pll/I6xFLk4Bz+qxCPhC/o2L8t3T4DHn
         VsgpVs40+sDsniXq+JyTIJBt8SFQBqzrpzjUll7IV11+Z0bB7HS4xYgCe3XVtGypZ/Z9
         8OyDoDCXvy4wTJ2uKju890IkPWJpz90jQ6LFYnr3wqNvqFfgby33+gT4q79X5XPAQwze
         3KEO2mzuWwirWiI+TwM8Lz/N5ccHcvXbeRJhtUOPI17R6J0SikO1MxKIBhqcuEZFKgcP
         xEyhCnKN4UwC6mpR9hlKsQgDy3dwUKVAamwAnHAPd85m/LTxN27K0zJGlJ1HyDbQluJz
         9sIQ==
X-Gm-Message-State: AOPr4FVl/NG6PjjuigEyWcpKu70AlM+pYmpnCH4u6pkccaCbbhFhbDYCmrUb1avxbbQZvg==
X-Received: by 10.98.18.80 with SMTP id a77mr2843120pfj.27.1462277228085;
        Tue, 03 May 2016 05:07:08 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id nz6sm5464595pab.39.2016.05.03.05.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:07:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:07:03 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293370>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge-file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 5544705..13e22a2 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -62,8 +62,7 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 		usage_with_options(merge_file_usage, options);
 	if (quiet) {
 		if (!freopen("/dev/null", "w", stderr))
-			return error("failed to redirect stderr to /dev/null: "
-				     "%s", strerror(errno));
+			return error_errno("failed to redirect stderr to /dev/null");
 	}
=20
 	if (prefix)
@@ -95,12 +94,13 @@ int cmd_merge_file(int argc, const char **argv, con=
st char *prefix)
 		FILE *f =3D to_stdout ? stdout : fopen(fpath, "wb");
=20
 		if (!f)
-			ret =3D error("Could not open %s for writing", filename);
+			ret =3D error_errno("Could not open %s for writing",
+					  filename);
 		else if (result.size &&
 			 fwrite(result.ptr, result.size, 1, f) !=3D 1)
-			ret =3D error("Could not write to %s", filename);
+			ret =3D error_errno("Could not write to %s", filename);
 		else if (fclose(f))
-			ret =3D error("Could not close %s", filename);
+			ret =3D error_errno("Could not close %s", filename);
 		free(result.ptr);
 	}
=20
--=20
2.8.0.rc0.210.gd302cd2
