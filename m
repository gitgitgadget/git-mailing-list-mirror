Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12B22FF53
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622289; cv=none; b=WPaMrAJLALvXE6yv54YhL0pq8xs3C+69Na1hiwre62u8YwkqmXs+XJTEbcUJYVOkZwnMuj5lOkwWr8Qm9naNnpTgNEU3+UQDrDyat/MvDwKpIdWpYLEBOEh8ea8Bx5QLsf8RmJagz37f69Ra+QbRVN2uKrxBi7LIMlz5NWBB2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622289; c=relaxed/simple;
	bh=XhW+4pZ10Wf6fygk80cXJgLtc/YyPvj3YM5n0Wjw+hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOynljZSs1MbpIqrvajAD9Fo9uLfnyu2EJT0GT3qMuyKlI+Eqyjxi8xozpB2GnvfLdFHcC0Kv3wNLLe8TiGHi7y5lZT98bOs01Kzmpj300bX/z5Bfu5T8NnVivTShtKYCkTZDzDFeMRNee8Wk5Uxuu2j6bEX5YnG2UqWUjcgIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4j6VIeW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4j6VIeW"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-391211ea598so2501838f8f.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 08:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741622285; x=1742227085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOhr4UxpC64RoNaCHeh9tu80BVzhUhITemkTc9ogq3E=;
        b=g4j6VIeWGFQx0A8DtNdhHCFftshXB7lo1eyob/T7a7IhMIrYJTxUGvVG0BfmWIYKU+
         9xBEFXMfZstw9xjocYwYK/z0Z4daynmnGGIhfZkZRbjYXzfIIcx3VHUNpZAgVYlQQ9uY
         HBl4RIyuaY1X6dObex9eaUR6ANWBLhinUzD/c2TkImb/V1C1rOUY/dhoqG1n+p/JFzyD
         b7V7Zui0c4Ihzyh6dW89pRJZpSBpT7nSNtiA4MPBt2Tv8qah+Rmu5P6HQfjWO13c9Khu
         D9Ekw3sF/IpD9kqx+Jwo2QPT8c0SivXypGHoYCJ4GOha1sEAdcWIDtxPopCB2O4Ga+Kg
         iUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622285; x=1742227085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOhr4UxpC64RoNaCHeh9tu80BVzhUhITemkTc9ogq3E=;
        b=jawxyzUrQH+zfMjljebBbYCUeRhyHuhMneGK7Ab493AFnYS8w9hkRG8L2JiPKR2tyn
         rDyR440hPI5EARLmUWBBgBnoLp1x9+LsJg79X/U3xR+Ay2BAQdBWV9p5vHxpCuZLNXkv
         qF8DNLp49xB+6bsNgiE2+3a6/POk00KTVn/A6pvQlwApujl6WWmHT8DrAOO/MpZjP5Sp
         uPFU3CBP9XMQo4TzDAV9bz3H/hqlkMhXUgh2qdDlaOjgNxXCB8Np312Ip6Zw+Iy6JeoW
         3Zn2z60tZNtsyynZe4huxqsHstRojZd9c+ESkJ/Mhq/bHzpSEZnaL3bt5q39DOmu2KY/
         Q/ew==
X-Gm-Message-State: AOJu0YwAU0lhw+zK7+oY0uCPK/coWkgzaXwJMahfp+Pe52gVer4XIITc
	O9x5Ze4WUImWlL6DTehcj7CasnDpg1ccJsM2T2ieckoO73Ch5hR4n9Qk4g==
X-Gm-Gg: ASbGncsfMN8uujOQ2uj/JjoNLSQ0b107HXosgItNWzwEWw9m+h69tDl8qorHPwjtc2p
	FnxF5i9rZj2qGO0KF+R+ElIGO8n/pCf3fwH4MzKY2Ec+k6WOmX8Q2/nL6NHZoDpepGBoJR4NUyf
	jQ7+yKCLKsXJBDXEU1by9/oFKBeQthrIzbvgJ+qQkryM/dC951dZ7U4qHrVTWAfjE9Hetbuj3jX
	jm+Hfv2INC8ukYJC/rIlXUneRBOVRgVTX+zE/8MYLdHDEGTGzogkpbhSfwxvZj0SnZYngok6eN8
	UrPHbyCF8KnVZ0LAPPzuGUTB7qSF/m70D9TkepgvLOpHLvvGoy6Ni5L8HvVGhWhbLsMrWokPsT6
	vm1y1WQgsrWeUJtvIy5b6APi4TB8=
X-Google-Smtp-Source: AGHT+IE91qHGtAt+xg57GCDfAd13xmBA+E7y4ewEbaX2ByiTJ8eQq4IXz53lJkH11aBrXwOw37lP0w==
X-Received: by 2002:adf:a1c7:0:b0:391:4095:49b7 with SMTP id ffacd0b85a97d-39140954a39mr4412952f8f.25.1741622284542;
        Mon, 10 Mar 2025 08:58:04 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e4065sm15551831f8f.62.2025.03.10.08.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:58:03 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Luke Shumaker <lukeshu@lukeshu.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 2/6] fast-export: fix missing whitespace after switch
Date: Mon, 10 Mar 2025 16:57:42 +0100
Message-ID: <20250310155746.879481-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.89.g148d1db992
In-Reply-To: <20250310155746.879481-1-christian.couder@gmail.com>
References: <20250224142744.279643-1-christian.couder@gmail.com>
 <20250310155746.879481-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Documentation/CodingGuidelines" says that there should be whitespaces
around operators like 'if', 'switch', 'for', etc.

Let's fix this in "builtin/fast-export.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-export.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a5c82eef1d..2bf787191a 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -694,7 +694,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	if (anonymize) {
 		reencoded = anonymize_commit_message();
 	} else if (encoding) {
-		switch(reencode_mode) {
+		switch (reencode_mode) {
 		case REENCODE_YES:
 			reencoded = reencode_string(message, "UTF-8", encoding);
 			break;
@@ -828,7 +828,7 @@ static void handle_tag(const char *name, struct tag *tag)
 		const char *signature = strstr(message,
 					       "\n-----BEGIN PGP SIGNATURE-----\n");
 		if (signature)
-			switch(signed_tag_mode) {
+			switch (signed_tag_mode) {
 			case SIGNED_TAG_ABORT:
 				die("encountered signed tag %s; use "
 				    "--signed-tags=<mode> to handle it",
@@ -853,7 +853,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	tagged = tag->tagged;
 	tagged_mark = get_object_mark(tagged);
 	if (!tagged_mark) {
-		switch(tag_of_filtered_mode) {
+		switch (tag_of_filtered_mode) {
 		case TAG_FILTERING_ABORT:
 			die("tag %s tags unexported object; use "
 			    "--tag-of-filtered-object=<mode> to handle it",
@@ -965,7 +965,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 			continue;
 		}
 
-		switch(commit->object.type) {
+		switch (commit->object.type) {
 		case OBJ_COMMIT:
 			break;
 		case OBJ_BLOB:
-- 
2.49.0.rc1.89.g148d1db992

