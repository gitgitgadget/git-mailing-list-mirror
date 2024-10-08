Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D3C1DFDAD
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396735; cv=none; b=s5iWChSljrcTH1k4Y6Haap8H55TfEPHBoMjEl+V0rmVzaMamVEL+GOoiZKtr/QjgpLOO64VClydlBmOAogBWcGJMpvdEM3lT5sERuckGJVAqxpog284PmvNCBuA5zLt32HiDey9wwElXys0LmmMNtOKCOWxCX2GCXGqAYueEjME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396735; c=relaxed/simple;
	bh=FWW0Yk4EjQQ1LYFwR1ffznyINczb6AXTwXpT8uITqmI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i4GK2ofcxQ48ciXIXiRKCqALZgdennyAaqXflnnrV1iqWdmBMbEEeGR3M8UiLsrTUV0jUYJBZaBClxDyz5gO4bKxTLE31yVIcz06UoO60A44vUdnwft+dcCtIZ/mfMen5s5f4T/OU2Sl3rhCo3kTTfFCFpPYYYwApuD22Cfy+fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwSxFzLQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwSxFzLQ"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398df2c871so6073185e87.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396732; x=1729001532; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+vaodEh/Yx/Ff4Tz8iCfMqaXhTzdOjL/w83oLvkHm4=;
        b=SwSxFzLQNAxKVG/NnKtJMTkfV5XITF4HuKESgl8W2X4JX1Hraecna8WW6UXwsyXuhy
         QAwWxEaNIttOdJy1MWwsLD3UFzZ17BIenWGZH5sQbgDWsuTUnqPnPraSjagOqRcuHUFa
         OTRdWoxaatjoP2GYMVmpjBk8Tmwa0nChYVwpDfO/58c6BzRgje2T//adPBislYjJzqFP
         W/avrU7SZzb7IhGYlwn7hAXshWb4Qe7Aq7XPgswyXdfVkOvyzCLArihqbSmn5JvLX0jV
         +BS3QwZdB1qjvp1lMwcfJ1MhRT5X6yKvbJz/Pc3/vdfmVedSRuqga1mF7Kl2xbU5zTRX
         8dgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396732; x=1729001532;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+vaodEh/Yx/Ff4Tz8iCfMqaXhTzdOjL/w83oLvkHm4=;
        b=UcdwkZisY91+qeYAzZ8WeIRqU2DpkpzHHoVJFY98qyx7AZ8XWCdIKQN6zuz23UbFQj
         q9eGAzwhPLydMLJplc6Agi2DVUHFQuJNdCmbcILzy1doMUXHbX+e8goHl9nNjeAuwZA3
         +nLVQI6mRLXWImcr0Fv2Uq5dz/8SXy4J+YnbLg4ssMXJ4u5NYwZDkzSNki2sa/JCojAb
         aKECEGaG6pbMerfH9bsDcAQLJ9N22x9hoGv4jqWl5v5ohsHZ/IrjdKFJW+jjHitAMX62
         lH72rwdFuNd3O6SG3koOAeA5Gnp5gBAtDCXhK0MkahjNj+vaFYBmIxLI6hPEkdCoWEAf
         duig==
X-Gm-Message-State: AOJu0Yy+bajlU+TjNNJpDD6dX9g3gYqzBaUHdWooPdnUkGjpBBYmxrLs
	Wwmy36kZZsCghHOn4rbgT1MZpqF0cF4q+ehzBSdzLrXldz6DIl5Dj3lMLg==
X-Google-Smtp-Source: AGHT+IGb95U3hBZxv4DA6Ht9rVKOCGzC1q6O9f48+blfcxt1AeqgKzdJ2dfVhcJW1N+Bf5zqGQRIPg==
X-Received: by 2002:a05:6512:1589:b0:539:93b2:1372 with SMTP id 2adb3069b0e04-539ab8c218emr6584004e87.51.1728396731410;
        Tue, 08 Oct 2024 07:12:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a997ee645fbsm44872366b.133.2024.10.08.07.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:11 -0700 (PDT)
Message-Id: <cd360ad104017ceaa9fb43ae036be79f767b557b.1728396724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 14:11:53 +0000
Subject: [PATCH 07/17] pack-objects: extract should_attempt_deltas()
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This will be helpful in a future change that introduces a new way to
compute deltas.

Be careful to preserve the nr_deltas counting logic in the existing
method, but take the rest of the logic wholesale.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 53 +++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fc0680b402..82f4ca04000 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3167,6 +3167,33 @@ static int add_ref_tag(const char *tag UNUSED, const char *referent UNUSED, cons
 	return 0;
 }
 
+static int should_attempt_deltas(struct object_entry *entry)
+{
+	if (DELTA(entry))
+		return 0;
+
+	if (!entry->type_valid ||
+	    oe_size_less_than(&to_pack, entry, 50))
+		return 0;
+
+	if (entry->no_try_delta)
+		return 0;
+
+	if (!entry->preferred_base) {
+		if (oe_type(entry) < 0)
+			die(_("unable to get type of object %s"),
+				oid_to_hex(&entry->idx.oid));
+	} else if (oe_type(entry) < 0) {
+		/*
+		 * This object is not found, but we
+		 * don't have to include it anyway.
+		 */
+		return 0;
+	}
+
+	return 1;
+}
+
 static void prepare_pack(int window, int depth)
 {
 	struct object_entry **delta_list;
@@ -3197,33 +3224,11 @@ static void prepare_pack(int window, int depth)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = to_pack.objects + i;
 
-		if (DELTA(entry))
-			/* This happens if we decided to reuse existing
-			 * delta from a pack.  "reuse_delta &&" is implied.
-			 */
-			continue;
-
-		if (!entry->type_valid ||
-		    oe_size_less_than(&to_pack, entry, 50))
+		if (!should_attempt_deltas(entry))
 			continue;
 
-		if (entry->no_try_delta)
-			continue;
-
-		if (!entry->preferred_base) {
+		if (!entry->preferred_base)
 			nr_deltas++;
-			if (oe_type(entry) < 0)
-				die(_("unable to get type of object %s"),
-				    oid_to_hex(&entry->idx.oid));
-		} else {
-			if (oe_type(entry) < 0) {
-				/*
-				 * This object is not found, but we
-				 * don't have to include it anyway.
-				 */
-				continue;
-			}
-		}
 
 		delta_list[n++] = entry;
 	}
-- 
gitgitgadget

