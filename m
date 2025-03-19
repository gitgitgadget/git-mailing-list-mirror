Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745724EF61
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369121; cv=none; b=bozHf8OhYP+YRIC8tQdN5m+Hu/s+087Dj0qBkA7kpE0+fdI+3r2L4N0AiGVauLbAOZcS6Cp3atLYwjdeOz41RkGFS/0f2aLWkgS61ARpTkLkaEfMqbhyBgTtYvXyqbeGUZ4hrBA7UgE/b38YgfopwP11LuP9dZ3uI/OKs8Znqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369121; c=relaxed/simple;
	bh=Bh1EYjOdZwmorXY5gKtPfXBrXraHG7/arSeds7FWM2Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSFgeheOLV/Amil4HHxAuX433uZpWVF6IVXQUCPB94koFJwdZdKXPRNRSR/KT+K7Uca6Ls1eKx8iB7aqNJHLk4wiw9080qr0/FSh2iA7lLQRgBiveFgtHNfuN77NF0SGVUB9cOn3+5/IfWOvEDPEiIqlo+HULIpMf9gb+Sgi6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYLe34RN; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYLe34RN"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30c0517142bso57450051fa.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742369117; x=1742973917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cg3FKRnHjvhREnd6ibZefrlSHHX4d7SlDKdhUkdxTNU=;
        b=NYLe34RNlCj6t1MIMFmXRWX5qCl4eyq2I70yeK/56Pklxw6q5j5oUytxZ5LKH4awn5
         RSzIrf2oZWVZAlONxihouwN0vhKDy6xtChQQZm1mDHK/HrtAQZzU/bAzIrMAjxXuVQr/
         TpR6Y9jFqkwkhSxS+iCqVSK0oL5OCPnpJXkAd7CwoXu2NJf97x8/8Rr6FvZh7iWXVn1Z
         50GuyeK4l7rY3GKoDM9cTG/c2e2uhibIglx+xlRlJrYE+snIv0Q5nIByEH9ToxSolDoW
         pnWpCRoMjUD95qKnBZ+t8cir3gxg7FWHyrCXiGvGaqw+zY7XtaNQkw5bE2tkGQVFypXZ
         mMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742369117; x=1742973917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg3FKRnHjvhREnd6ibZefrlSHHX4d7SlDKdhUkdxTNU=;
        b=vCzM071g/xfqU6h5RjwpHzftC6NKv6NPZ93x5d82bRzhiv/3Hmky5zv2G/k5gL++Pi
         7BD+nJjOn5GF1oeOb+Df/0sBo2v+KhLv+90kB6NGWQSMqFCvzlYh+eEvQ5dmK42AQ2EQ
         GzE/8lKSeoJxJFXVLbJlWWJWITvyogWRLQ9s/YVLsCfoIutPGxcVRuI6Dh60CLn1l3q1
         pZWxEH5dqBuOGBJ8EVHxb5PK2jUeb0w6tXRro1U4HwLFagNdNFC8NYZqQxDjZ5AMzji0
         apFspZf1SU+GvxL3GP9W/wZ9y0JELeFQfWwsXgl2acIS/1SnWH1PXenxnqghqKGu8RlK
         jU7A==
X-Gm-Message-State: AOJu0YyHFCAxHOPK/OW2MTRku5Fo7R4LfmijlVpErKausgQDcbcXg1+o
	J152H6RUGFdVFSB3pM2EroV2EiGM9iWc7erINd0SLxGxKn88WlyWAe/kUQ==
X-Gm-Gg: ASbGncsUSKscVuJpPUiH2u1FJ4Ot5IQsFJ4ig9H00WyBKd/DzBR7EEPJMaJU6J8HS8B
	tXWAFr0XZYrsh9Bu+aimVOOuS6yMOU8K4Bdlo7fM7QsR9OerNtQTITMpY1tH7xY2rV48nHIMGjc
	dV8qZgIz/3Qu1Xfm0cME84IP/Jwkp2KtLt4fpQQKTzGVyitLswtl2lVD3hTHRDUx/y8SlLWfLCj
	6z/XJaWOaxW5HBOIxlLLW8g4UywyLXbIR1ERp3rwiTjrmGfq7CHVVUD0dq6rxrAlV8ydGzuVr7s
	hcGVhPPCwQDksOItuqNHYpicsbp0C7miTiRTzkiBFZhndNKrDTvauoVv8uXPwA==
X-Google-Smtp-Source: AGHT+IFdSdPcLfW51N/qhsnA3G6oVMB1UKJCx4B8hx2oXgnLpQhQSrRuM01QLoyZbMwHKYr2MbcUHA==
X-Received: by 2002:a2e:3c0e:0:b0:30d:629c:4333 with SMTP id 38308e7fff4ca-30d6a44b527mr5922561fa.34.1742369116484;
        Wed, 19 Mar 2025 00:25:16 -0700 (PDT)
Received: from localhost.localdomain ([217.116.228.14])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f209d6esm22089541fa.112.2025.03.19.00.25.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:25:15 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 4/8] pretty: fix parsing of half-valid "%<" and "%>" placeholders
Date: Wed, 19 Mar 2025 08:23:37 +0100
Message-ID: <7d6b62006ecaf7db159e8db0c85455ed58027ce6.1742367347.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec
In-Reply-To: <cover.1742367347.git.martin.agren@gmail.com>
References: <cover.1742367347.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When we parse a padding directive ("%<" or "%>"), we might populate a
few of the struct's fields before bailing. This can result in such
half-parsed information being used to actually introduce some
padding/truncation.

When parsing a "%<" or "%>", only store the parsed data after parsing
successfully. The added test would have failed before this commit. It
also shows how the existing behavior is hardly something someone can
rely on since the non-consumed modifier ("%<(10,bad)") shows up verbatim
in the pretty output.

We could let the caller use a temporary struct and only copy the data on
success. Let's instead make our parsing function easy to use correctly
by letting it only touch the output struct in the success case.

While setting up a temporary struct for parsing into, we might as well
initialize it to a well-defined state. It's unnecessary for the current
implementation since it always writes to all three fields in a
successful case, but some future-proofing shouldn't hurt.

Note that the test relies on first using a correct placeholder
"%<(4,trunc)" where "trunc" (`trunc_right`) lingers in our struct until
it's then used instead of the invalid "bad". The next commit will teach
us to clean up any remnants of "%<(4,trunc)" after handling it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 pretty.c                      | 18 ++++++++++++------
 t/t4205-log-pretty-formats.sh |  6 ++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/pretty.c b/pretty.c
index e5e8ef24fa..a4fa052f8b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1121,6 +1121,11 @@ static size_t parse_padding_placeholder(const char *placeholder,
 	const char *ch = placeholder;
 	enum flush_type flush_type;
 	int to_column = 0;
+	struct padding_args ans = {
+		.flush_type = no_flush,
+		.truncate = trunc_none,
+		.padding = 0,
+	};
 
 	switch (*ch++) {
 	case '<':
@@ -1171,8 +1176,8 @@ static size_t parse_padding_placeholder(const char *placeholder,
 			if (width < 0)
 				return 0;
 		}
-		p->padding = to_column ? -width : width;
-		p->flush_type = flush_type;
+		ans.padding = to_column ? -width : width;
+		ans.flush_type = flush_type;
 
 		if (*end == ',') {
 			start = end + 1;
@@ -1180,16 +1185,17 @@ static size_t parse_padding_placeholder(const char *placeholder,
 			if (!end || end == start)
 				return 0;
 			if (starts_with(start, "trunc)"))
-				p->truncate = trunc_right;
+				ans.truncate = trunc_right;
 			else if (starts_with(start, "ltrunc)"))
-				p->truncate = trunc_left;
+				ans.truncate = trunc_left;
 			else if (starts_with(start, "mtrunc)"))
-				p->truncate = trunc_middle;
+				ans.truncate = trunc_middle;
 			else
 				return 0;
 		} else
-			p->truncate = trunc_none;
+			ans.truncate = trunc_none;
 
+		*p = ans;
 		return end - placeholder + 1;
 	}
 	return 0;
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f81e42a84d..26987ecd77 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1130,6 +1130,12 @@ test_expect_success 'log --pretty with invalid padding format' '
 	test_cmp expect actual
 '
 
+test_expect_success 'semi-parseable padding format does not get semi-applied' '
+	git log -1 --pretty="format:%<(4,trunc)%H%%<(10,bad)%H" >expect &&
+	git log -1 --pretty="format:%<(4,trunc)%H%<(10,bad)%H" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log --pretty with magical wrapping directives' '
 	commit_id=$(git commit-tree HEAD^{tree} -m "describe me") &&
 	git tag describe-me $commit_id &&
-- 
2.49.0.472.ge94155a9ec

