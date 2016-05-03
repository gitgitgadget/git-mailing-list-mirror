From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/41] builtin/fetch.c: use error_errno()
Date: Tue,  3 May 2016 19:03:39 +0700
Message-ID: <1462277054-5943-7-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:06:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ6N-0008Cq-BV
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014AbcECMGw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:06:52 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35294 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932897AbcECMGu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:06:50 -0400
Received: by mail-pa0-f46.google.com with SMTP id iv1so8846984pac.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OHE3lpm+4jZj9KMYYuNEM1cMi3boqeb9aePEronky/4=;
        b=AWmjAcdJiadLaNA6LgnT6zASJx5MQbqnw5uBdaFKv4YrVIPSWWIsWkhfnZNDSEbFvv
         vXfhGguJr5dEih+5hHRfeDytUM5wc9XpXz/bixkB/l24uwzug833REEtXsm5FvJ3xLin
         G1vqT3Wb0ZSetr0bHTB7Anv5wVrS1mALyv2gVcU0AI5gRPFRWneEDNotnvuEeR5htAUx
         ymvWrJSjrrUGmcYURKXCG4IJsWUxTlztFXaaquwGrQY+XvSr109BKupslALmjO2gp1aK
         cmc9tBY6BMGNPakd4qRr2vD/FGH0k6cDfKX+/pW4+B1Tc8PGJrCHy7eeHkB221G6SZiK
         2aaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHE3lpm+4jZj9KMYYuNEM1cMi3boqeb9aePEronky/4=;
        b=Tv4s6y7ys0Vd4/DT5p23G51kPi32xYFWFrR8ERHLoRLT90fns5XKw+ueS++XnS5Qr7
         up5ZOEs9MYcil+c2VL12X/8YfaS2AgTFLkijbZBLpD6r59BsMgzcpERqqO8QyvSHZYes
         fCbxdI73DY0u/VWZkPO2+y7Bmnj8o9ei22pm+lThRGJdqOhcneiqaZ0uT9AGoHsWXZX6
         x8nOtXLl39t4ewA7jlidAF3gGD+pfNS3r2Y1At1UKQo3uyI3JwwgKYODPmOoWSkxqyMh
         7n9gXYX/UP1A76daxf3zOiPeRWkqJmKr9G8Ly+m6Sl924OkO8y1EstUywMtSdh37etsa
         qMJQ==
X-Gm-Message-State: AOPr4FV2zOLKFrMljSvPBD7OJC4vtKQ+geZOKLA6GDRy2mQGs4mTTieaMJJcz3USyO07dA==
X-Received: by 10.66.65.109 with SMTP id w13mr2840976pas.142.1462277209485;
        Tue, 03 May 2016 05:06:49 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id az6sm5453659pab.43.2016.05.03.05.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:06:48 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:06:45 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293358>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f8455bd..1582ca7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -607,7 +607,7 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
=20
 	fp =3D fopen(filename, "a");
 	if (!fp)
-		return error(_("cannot open %s: %s\n"), filename, strerror(errno));
+		return error_errno(_("cannot open %s"), filename);
=20
 	if (raw_url)
 		url =3D transport_anonymize_url(raw_url);
@@ -848,7 +848,7 @@ static int truncate_fetch_head(void)
 	FILE *fp =3D fopen_for_writing(filename);
=20
 	if (!fp)
-		return error(_("cannot open %s: %s\n"), filename, strerror(errno));
+		return error_errno(_("cannot open %s"), filename);
 	fclose(fp);
 	return 0;
 }
--=20
2.8.0.rc0.210.gd302cd2
