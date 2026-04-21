Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1F03D9DDA
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801738; cv=none; b=Ykv0NlkNBJU0zCYQgKkOU7iIBAPGJgcuN7OxwIadGNKYXCKuPSM/rUqmQBu2fFmAZeK/0ro8o1buvfq/rujxAwhQ6q5AKGcN9H8CBRKHCsxszlWJPkR2rjFuw/i0yAecF+SkHjRgtR7dzub+GHAl0+pYMqcgMtQGNhUkWd+wCSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801738; c=relaxed/simple;
	bh=cGdYnayxaUVKLSx9uAZoJuncWtuHIANVVTlbbeuJ0jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM4W/SfNBZnMXh5UEUvfh6mN5iIpSUtXF2B27TLQ35m8Kn5y8M8h2kpUfdE/h159j34i/pnTgRnD7ONPk4oL0i/neXldw3lHWpC3b+wQ/ZxOu5rr0+m7eO+j0BgAbMm5EtQOBo8CRZPEfCbL5C050zMpZTc2II2+9bAT/Iul6YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=QPi4DoS+; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="QPi4DoS+"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dcdd1b492eso765567a34.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776801736; x=1777406536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSKr6GX2c5InLPznYbqhheAkb3wg7JOlhgpeeSfc65A=;
        b=QPi4DoS+eT8+R7ifoAlL0NktuGbCTtxqo4paQr2abzU+WVqvhzOAqxbea+O1AYfDQA
         E6tYlxbqVlT4i8r27OY+9xuRmKzVPPtHw37vNVXmSG/El+177o18WJ+0HN4hZKSrLuhp
         S+HbhkIWuX+vYdtxfyFjLafBNMQHDD72dqnfUBrHFbXPR3fh3txLQszBt2xd43Nb+u9A
         Q9X7TWeKqsdxbb9wkYeOjBTpaUShg6NPUzqnWOok8zBE/ncN1eaNIvD2vGRRZYLLO3pW
         /fcH0PeB7RLsQx/ctMBrQuem2bCKxge2mw8UbUmNaejchFZSesVEDQGdq3TKv3WNiGm5
         ikgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801736; x=1777406536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSKr6GX2c5InLPznYbqhheAkb3wg7JOlhgpeeSfc65A=;
        b=oAuaRonCkJQHzpDmgCgUwHya00waayrSOlHlIV/nEUEUcC17dB/AiGZiuFDb66Kj1A
         Q3z1C0Fb/6CfYMDtJ/Q7cyoXNZyWAXLQiyossQE9dJb+D8aSXbEr2ja0+/ckAKbomVEy
         jfVq6C8Pu3xywPdkl4CYj9e5cCA89YQ8L5AjvxV00zN1j1U/llGuhvYHTjKNQnQkEKVB
         zaaA6JYaX4QCsi4KdK0QUOrEyZhh/zynZw+bvaG77PlsSKqDWqb7PvHFqaISKXmvDYuo
         WZ6yhWB3bSCOa7rdQaBkeGBkehRXLm7iCZ7N9/NPFWMJeqZPxF66q664+NwgBss5EqTI
         apXQ==
X-Gm-Message-State: AOJu0YxP7Tyz9Kr2/51pwrir7fytYBXtK58rpfYrXDN3kBpO/tRiGZMI
	+3VZmYCrOPQJuZ93iyNMG+m4wL2qRplNphHtVusG2bK8wteGmU2oeFrnhg2c1E8bOWZizraxv+3
	CVkkOQaE=
X-Gm-Gg: AeBDiesGi60ow6lQLczzjwr1295bMZlOiCbpFY+3n8Y15b3GXB+ybpLS7aLJQgor2mA
	3oOsU1U2i9POf6brM7XdXT6SHShVAQiCYmtNNMvz4CZvJ34bUIp7UnA1a7kcPw49aTpvuQaorbR
	/Ov67krZ9da9YYHHFRbIyrphxK2iICp933HEzl2IfvjvqFA0yKWSNjyZ/a5s+G6LiSpVEIX0taJ
	8mMiCUDtNkcg0EuzmmtdIDH5O5ZAk4ttMAqXZWzUNMwvHGhXg4dwt3TuaZsXOnwJkuRgGJAeEyx
	WEbgq4MaS150/EjUdhwJ8jppVlIZA8gcODyaWIE5yRWgZka6AK3Kxdy3Lo4Khr9TgC55iZLOK8s
	9JM/w+u5sdGeYGOySF3MJdZLGlSLEqoWm3jf2wGA6EE0UUbdp1283VmIFp3T/kLBBRm6TuQeyk1
	e9A+DeOhHC8Kh/B6fG/ZwQb5ILENI6LDSLLBPbG7aNyj7M9jumjuB1FZv7H691+s1m8bJ0Szwwr
	AcCV/KFFn3XHcN6byuSNLoLb+/B8V31KO9vfwTJehd6wCBm2FWZH58rQP2YoufMaddLoRE9lUHf
	my2fy0j7OPXvl+90ZqPkPZrttWYlu5p4G6Kneg==
X-Received: by 2002:a05:6830:3811:b0:7dc:e3ad:6088 with SMTP id 46e09a7af769-7dce3ad67f9mr733923a34.0.1776801735978;
        Tue, 21 Apr 2026 13:02:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dce20ff8c3sm1052458a34.22.2026.04.21.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:02:15 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:02:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 7/9] pack-bitmap: reject pseudo-merge "sampleRate" of 0
Message-ID: <f8a01cfb8932f031999621eafda4c2600067eca5.1776801694.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1776801694.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776801694.git.me@ttaylorr.com>

The "bitmapPseudoMerge.*.sampleRate" configuration controls what
fraction of unstable commits are included in each pseudo-merge group.
The config validation accepts values in the range `[0, 1]`, but a value
of exactly 0 causes a division by zero in `select_pseudo_merges_1()`:

    if (j % (uint32_t)(1.0 / group->sample_rate))

When `sample_rate` is 0, `1.0 / 0.0` produces `+inf`, and casting
infinity to `uint32_t` is undefined behavior in C. On most platforms
this yields 0, making the subsequent modulo operation (`j % 0`) a
fatal arithmetic trap.

This path was not previously reachable because an earlier bug caused
all pseudo-merge candidates to be classified as "stable" (where the
sampling rate is not used), regardless of their actual commit date. Now
that the date classification is fixed, the unstable path is exercised
and the division by zero can fire.

Fix this by changing the validation to require a strict lower bound and
thus reject 0.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/bitmap-pseudo-merge.adoc | 4 ++--
 pseudo-merge.c                                | 4 ++--
 t/t5333-pseudo-merge-bitmaps.sh               | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/bitmap-pseudo-merge.adoc b/Documentation/config/bitmap-pseudo-merge.adoc
index 1f264eca99b..6bf52c80ba7 100644
--- a/Documentation/config/bitmap-pseudo-merge.adoc
+++ b/Documentation/config/bitmap-pseudo-merge.adoc
@@ -47,8 +47,8 @@ will be updated more often than a reference pointing at an old commit.
 bitmapPseudoMerge.<name>.sampleRate::
 	Determines the proportion of non-bitmapped commits (among
 	reference tips) which are selected for inclusion in an
-	unstable pseudo-merge bitmap. Must be between `0` and `1`
-	(inclusive). The default is `1`.
+	unstable pseudo-merge bitmap. Must be greater than `0` and
+	less than or equal to `1`. The default is `1`.
 
 bitmapPseudoMerge.<name>.threshold::
 	Determines the minimum age of non-bitmapped commits (among
diff --git a/pseudo-merge.c b/pseudo-merge.c
index d79e5fb649a..75bed043602 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -169,8 +169,8 @@ static int pseudo_merge_config(const char *var, const char *value,
 		}
 	} else if (!strcmp(key, "samplerate")) {
 		group->sample_rate = git_config_double(var, value, ctx->kvi);
-		if (!(0 <= group->sample_rate && group->sample_rate <= 1)) {
-			warning(_("%s must be between 0 and 1, using default"), var);
+		if (!(0 < group->sample_rate && group->sample_rate <= 1)) {
+			warning(_("%s must be between 0 (exclusive) and 1, using default"), var);
 			group->sample_rate = DEFAULT_PSEUDO_MERGE_SAMPLE_RATE;
 		}
 	} else if (!strcmp(key, "threshold")) {
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index e27f9850dc4..3d0617a2e17 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -640,7 +640,7 @@ test_expect_success 'pseudo-merge commits are correctly classified by date' '
 	)
 '
 
-test_expect_failure 'sampleRate=0 does not cause division by zero' '
+test_expect_success 'sampleRate=0 does not cause division by zero' '
 	test_when_finished "rm -fr pseudo-merge-sample-rate-zero" &&
 	git init pseudo-merge-sample-rate-zero &&
 	(
-- 
2.54.0.9.gb905fd5d0ae

