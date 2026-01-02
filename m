Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B12690EC
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379956; cv=none; b=b4I5/H0bVH253SOS/91YVUORRfM4jFAwZGTeFkd/U+tNEVnowZdcbIA9hrKDkHrZ4XowsBP5Hp15itHvEVb05+bYTkUGbP4p76JPonz7M2vp3glE9qjvffdGrkLTpZojdwjJhm43m7k8+yL+UBe7iMhs5retaUvcs+MbovridNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379956; c=relaxed/simple;
	bh=HEyNqIJYfjOBEflwqtU4NopzasNnnCLjVoln3lF+xnQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MKhUrMYLq46YELcBwDARzeC2djEom7AdGzfKy00ysxp16SEruq4c25Z5BCoOER9e3JWCRTrR7iMe86wCHnjP+Ka7hv1xWxTWhPYQl7RxWHkqHX6kWPeUJPC1IFbb9zAoMm0WfirOWfuuuvgZZ/duvl1HYDr39wC4waOtjtf91ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgPny7yK; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgPny7yK"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c2dc870e194so4727336a12.2
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 10:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767379954; x=1767984754; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhv0gWA5xanXllA08oNAALnHyvppmEtJufCUiQn5emw=;
        b=QgPny7yK2etgLSOoFn7+Up6bEAJSGO6Oj+o4SokWOlc/+WBm+Qyz6wewtxb1V4nr7u
         MHUVX2n0JYej/pam7MfYqON9bPgdKtna7XB+3IvYX9wSQ6VIBcbV1yclN9JqcyooplDu
         CrDmBLE/WeAgpOb3pS5JYA40SnUhTG1LSJ7wsdedYXpZ7lcoj4DgYYTo5FQrne5FXNhX
         RymJRGVg0LaP90SUrwKYIF3oq/PyHVSB8zsG4pyLEiIC3gjCJ2wkacpqnWg9HV1HuF4T
         k6C+uO2z7gf0Ja1QVZ+bPajFcViaDsmgNY7pMGK06CbHXwkBOT3kc2vOuvspdPz5WFQv
         hJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379954; x=1767984754;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dhv0gWA5xanXllA08oNAALnHyvppmEtJufCUiQn5emw=;
        b=cz2DtTDIUtTOcv+FJCmexeFJqbIes3/LJsD/FYKVVYGKDxAQ6Fo/zK49szYo8xVHZS
         GvkGW9Fv1Pi/PyNl0nv+khXUnLHEyGzUZnV27/FFjt/jp2JYi5AoKCc5dzRgIS+lmgDO
         FeIFcPE8SWdZzG0n+tc2Iit9ZYRVvjBhZVPAQIMDlfntWqroPE/r+9tXiQ9cajmz23Yy
         P8+JA8jc9bU/lTpnoGaqfH6mr4G4csaUYM7EQ0dyMEoB4S6+CC+WKGvRsECb/RDIe2x4
         akhi1QGnthdjd1Ih1nWZ5OhEBt6d456732+FTxruTAgMZM37I6PNRcVHTes3JnjEwAjm
         MV4g==
X-Gm-Message-State: AOJu0YzQRL1gsSxyrejxoSrR+oUESwK/nYElgoU3F/6DSwhZU0fwr07N
	6woLpQ3K6hjc1IDKf64LUx1VjlD4Kmw/zonc1UoQWiwLC9LUbRIiuRIXbzPDGw==
X-Gm-Gg: AY/fxX6rXuRrS7bxdm7dmuswuwtlw4n8KV5a6QnyshVJ/8d/Qt3zk1T/RKcEQtxtcON
	cfdMR/RJ1HVlAN+0nehvLz0xeAyj90uV3uUhkUblXfeWNvRr8SGo5X99MIPumWpZ+UF4cMP74PW
	uGZ7Js1R7JnxYK4lMX2peBGEU2JxVKJbA/DjKdi4dysja3OUpn32Xg8EqLwd2GINzsp7k3m5R4t
	0BwlVXSG32t4vuyPPwjga7EYklGEgMdo1CNbgnVIrUBTcxaX2YQm0jeKoImw6yCem1N/3lgGbNS
	vDfcmgMThY0/D3KlHevGLAzQR7CqHUfJvL3uIzE7tl73C0GYXtxHP/qzv5eJfBPL2dKLJkz02TF
	8AB4BQu0LHVkejtTT3DIqv5FmhcvVO8x/vMvBYlekWtWRlkA9pC2sPKaWi6kqIIYfTWUUuL4IY5
	3I/0otQ24v/W7OlA==
X-Google-Smtp-Source: AGHT+IEaQSsQaf3C1qckRVnzyN1FWNP8NhPHKH9yq0lvQYDT5rjT8DjEgBGbouYASUe5DjVvwpYQCA==
X-Received: by 2002:a05:7300:3e95:b0:2a4:3593:4668 with SMTP id 5a478bee46e88-2b05ebdd53bmr26182797eec.4.1767379953851;
        Fri, 02 Jan 2026 10:52:33 -0800 (PST)
Received: from [127.0.0.1] ([57.151.128.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42d8asm1616567eec.13.2026.01.02.10.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:52:33 -0800 (PST)
Message-Id: <65da408da9589420ec341368d0853e6183aee922.1767379944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 18:52:20 +0000
Subject: [PATCH 06/10] xdiff: cleanup xdl_trim_ends()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

This patch is best viewed with a before and after of the whole
function.

Rather than using 2 pointers and walking them. Use direct indexing with
local variables of what is being compared to make it easier to follow
along.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 0acb3437d4..06b6a6f804 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -340,29 +340,29 @@ cleanup:
 /*
  * Early trim initial and terminal matching records.
  */
-static int xdl_trim_ends(xdfenv_t *xe) {
-	long i, lim;
-	xrecord_t *recs1, *recs2;
-
-	recs1 = xe->xdf1.recs;
-	recs2 = xe->xdf2.recs;
-	for (i = 0, lim = (long)XDL_MIN(xe->xdf1.nrec, xe->xdf2.nrec); i < lim;
-	     i++, recs1++, recs2++)
-		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
+static void xdl_trim_ends(xdfenv_t *xe)
+{
+	size_t lim = XDL_MIN(xe->xdf1.nrec, xe->xdf2.nrec);
+
+	for (size_t i = 0; i < lim; i++) {
+		size_t mph1 = xe->xdf1.recs[i].minimal_perfect_hash;
+		size_t mph2 = xe->xdf2.recs[i].minimal_perfect_hash;
+		if (mph1 != mph2) {
+			xe->xdf1.dstart = xe->xdf2.dstart = (ssize_t)i;
+			lim -= i;
 			break;
+		}
+	}
 
-	xe->xdf1.dstart = xe->xdf2.dstart = i;
-
-	recs1 = xe->xdf1.recs + xe->xdf1.nrec - 1;
-	recs2 = xe->xdf2.recs + xe->xdf2.nrec - 1;
-	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
-		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
+	for (size_t i = 0; i < lim; i++) {
+		size_t mph1 = xe->xdf1.recs[xe->xdf1.nrec - 1 - i].minimal_perfect_hash;
+		size_t mph2 = xe->xdf2.recs[xe->xdf2.nrec - 1 - i].minimal_perfect_hash;
+		if (mph1 != mph2) {
+			xe->xdf1.dend = xe->xdf1.nrec - 1 - i;
+			xe->xdf2.dend = xe->xdf2.nrec - 1 - i;
 			break;
-
-	xe->xdf1.dend = (long)xe->xdf1.nrec - i - 1;
-	xe->xdf2.dend = (long)xe->xdf2.nrec - i - 1;
-
-	return 0;
+		}
+	}
 }
 
 
-- 
gitgitgadget

