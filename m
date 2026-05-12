Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AFB22D4C3
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546836; cv=none; b=pc+G3yapWwZb/XM2XBig4Qv6hRltcQzO3RyrV0fgp+VePElviHgqv8nLXBfRv9SF9tAq55cPPhdX2hApAy9M/o6POcdTc9WMReYPcs8GQCp15RgEqo52QVmf8weyCRc27nE5fXMx6NTXSMT04rlQBBEKOuUxqe9JuC2HO5MSsRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546836; c=relaxed/simple;
	bh=Ee9VajXNtiaDzVYI647nF64mrgzHCPwrU4JTPriuVwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMrtfjRdrbs0R892KOk5kMDOKsCnMOPq65qDfUOJuAgEi3nMdeeSl/CJrdcEguV5fhEK+aidF+0SOMJPZjvH2ak2nwQx3kQnb/4xKdboCN3JPPbsmrUa7cTxF7XYlbywC/mhWjTMxtBmeIbm+d/2AyDDUqb377uCzjnnKwR3e6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=mi6f0JXF; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="mi6f0JXF"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7c23248f3a3so19694407b3.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 17:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778546834; x=1779151634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=93SbTJj+9/tanqmznK3MOEOS68m3RPlgMwve8cJlkLw=;
        b=mi6f0JXFvCxSu5q2NrUu9s4QqNE21/dINgTuCnAzFO5wgTOG3XioTT8IdF+v2CNZ0E
         Bsohu3S+PvlIWPgAM1ifAYCbYd73E+Pt/k8wUnGSBoHyDyHZI5hKGl01xMMz3CdLx1q9
         QYR7+yXc8CN2VWSKm/9lRHNWYmOu1ww0fGx2ABjJh6yUp8O+u7CGfQnjQC/70C/nwayz
         V43/61VseH2WsUMv7O/sP4opo1zS5bKqMcB0O9Xu0EzwdhmIA/v+9ZfEZ3f9WdvjOIIh
         Ka/3Tv8A3/hlz6kkdA28i0jcKf4s38o644i6+28FWAU1cFAVD6+SW4oYokKinl0qFyFi
         FQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778546834; x=1779151634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93SbTJj+9/tanqmznK3MOEOS68m3RPlgMwve8cJlkLw=;
        b=ljSYf+DTlhTktK3E4G/3N5KuhX/mBt0pTJKoaZq6TXf+GhSGLFAn8P/OnGAaziqalN
         q6fOwfUf4XkpUsT2XcFdsWlfQCmSCOI2jokycZA0ONZ7TpFEIUXM23H1Yt+cOm9X79rj
         iORSZUO9F11+PR3AF7XNvzghb1LwTLDMIPQNzS058CciXZGOpsRYE1zaAGGCBEkcYkL6
         Is9Lk3M5IT32D/S73uuvr7pCse8BpQKP6kTPLQ4vUqJqnJOyY4FqloTC/lkfqLzrGmqn
         Xk+Y74QJOdS2o2qdr1MVHALw6VWaxQwUCnpjD2vvHXgsPOMXOcQQaX67KIcagqlHbw3o
         ldiw==
X-Gm-Message-State: AOJu0Yz9gNCtmj5usUMdJkNjeWpgOONwDXu6YgYVlmIo78+Vi5v58FK2
	WBJ+IdOEmkSA4sAe64WdJumZy/ly4H58BgXUrdU+gI99MCVNDzzyTOsKJzti/b/hk8fOxbbWWbq
	4jxK9epa2SQ==
X-Gm-Gg: Acq92OE/RQrLMZOr8+hRwf5WspyW7lagCeKeV6Gsa7N9Yg7+CcCgLuXDqvJme0omH+/
	AHOLc9I+PzAKHELzayzHDzyjRlW8fpngZ8U0TrHFt+GyLlR3FHs9Z+wUu8gVJoHR0m77EXtZt90
	qfVW3CrA7F4gdruTvUVuSSwSenFwhZHQFf3s3sijEwIihW1Sf0Z+Bh73gaeuzaJJKlbtGZJ1Ned
	1UWANvWB7rKreuAeE9JnZ7v01IpBvf21DqOaY+zhUjEcf52qRjr53t4hTAinWBe5v5sPsKm+S6c
	gY/md1858TIXdYs3X97dodhOXtCR6AwLYibmXzmb2FVv7dQ969ZtIjsqBX7NZ42+BH+5uneyitK
	tlSle/KReIGlJ1k4HNPvAgziwD5IyiXgkTNcwws3dvYAfMW8LMfrnjj0AWKg+OswNaFjgstMs0Y
	2nb7jBKJokZr1Er/9TbBnjmL/vgX3MZASWZe5HfraTfYDMZZFRn2jsHP5gQH69dVDCFJYUPvdEg
	eD4l+fitZFp+JMiFqHBEGvyOiGrBJdeEZp8YBk7VW9VtMVwe3wEl0Pz56dstuFVPThvcbfiAPv8
	pkhdZ5/Wo6mhrAUW
X-Received: by 2002:a05:690c:7108:b0:7b2:bf20:cdc3 with SMTP id 00721157ae682-7c55d11cef5mr8235607b3.0.1778546833897;
        Mon, 11 May 2026 17:47:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6655f443sm160630017b3.19.2026.05.11.17.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:47:13 -0700 (PDT)
Date: Mon, 11 May 2026 20:47:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 9/9] pack-bitmap: prevent pattern leak on pseudo-merge
 re-assignment
Message-ID: <9b17dab2cf745b78eae4c0da2cc2c0e79b7c0b3c.1778546804.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1778546804.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1778546804.git.me@ttaylorr.com>

When "bitmapPseudoMerge.*.pattern" appears more than once for the same
group, `pseudo_merge_config()` frees the old `regex_t *` pointer
but does not call `regfree()` on it first. This leaks whatever internal
state `regcomp()` allocated.

The final cleanup path in `pseudo_merge_group_release()` does call
`regfree()` before `free()`, so only the intermediate replacement is
affected.

Fix this by guarding the replacement with a NULL check and calling
`regfree()` before `free()` when the pointer is non-NULL.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.c                  |  5 ++++-
 t/t5333-pseudo-merge-bitmaps.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index 75bed043602..22b8600d689 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -150,7 +150,10 @@ static int pseudo_merge_config(const char *var, const char *value,
 	if (!strcmp(key, "pattern")) {
 		struct strbuf re = STRBUF_INIT;
 
-		free(group->pattern);
+		if (group->pattern) {
+			regfree(group->pattern);
+			free(group->pattern);
+		}
 		if (*value != '^')
 			strbuf_addch(&re, '^');
 		strbuf_addstr(&re, value);
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 5bfbbd4214e..305d6771082 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -662,4 +662,33 @@ test_expect_success 'sampleRate=0 does not cause division by zero' '
 	)
 '
 
+test_expect_success 'duplicate pseudo-merge pattern does not leak' '
+	test_when_finished "rm -fr pseudo-merge-dup-pattern" &&
+	git init pseudo-merge-dup-pattern &&
+	(
+		cd pseudo-merge-dup-pattern &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack=$(ls .git/objects/pack/pack-*.pack) &&
+
+		# Set the same group'\''s pattern twice. The second
+		# assignment should cleanly release the compiled regex
+		# from the first without leaking.
+		git config bitmapPseudoMerge.test.pattern "refs/tags/" &&
+		git config --add bitmapPseudoMerge.test.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.test.maxMerges 1 &&
+		git config bitmapPseudoMerge.test.threshold now &&
+		git config bitmapPseudoMerge.test.stableThreshold never &&
+
+		git rev-parse HEAD~63 >in &&
+		test-tool bitmap write "$(basename $pack)" <in &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 1 merges
+	)
+'
+
 test_done
-- 
2.54.0.76.g9b17dab2cf7
