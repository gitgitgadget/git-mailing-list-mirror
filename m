Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F8434CFAB
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 01:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731745; cv=none; b=WOILpgKTU83OEAfDxafnsauOJTVfs+h0WJucb1raRn9f5AEdqBmF5iSKNqUCEYC2mPl61p27LGEZEgSRb48GfhiAthmxr66mEYKw4fr+j4oEn85rpCqBVR2X1GSnJ7SFFEPStkvM+qFI4FSqrHPFWBI5SvGkJqmI7EoF98skcjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731745; c=relaxed/simple;
	bh=m22dx61rPXpDsBaTXneIf5GYwM6K9Bh/3UcEqOU+xq4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeiCFkP7of4UVCz8X5TG9GmDjI+6JT+i10I9Ucb9CJ59KYuk0fw3vGvFkmeFCgaS/rRTMYT2JpHHww7i9mNC8HnzXA6FrOeMWFMi2szmUzfCeXEyjOGaPSqO/7F17WoG2S3eiAnCSvyzOPnKWRgT9hcQ6clzrrOx2ognV4XR9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=P/jKb0gt; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="P/jKb0gt"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b15bca7dfso2507798a34.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790731741; x=1791336541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uC7WelJhaO9GzJtHMP+nH/cv5nn5lpg8+60Spi/MWsw=;
        b=P/jKb0gt801TbjKE3dim9y+Mfm6xFfwJdr7H87s5PLIHpwm4RNAE2WVr/LK/02ZgYG
         smOdADn2Sy4vCUhraTr7+IOER2Z40JK+DfPWlZoygEi+pNltBOeFVu/wlESTJb5GqioY
         L/fluy5abMMRXzLQC/FT09G8P88cWA/cPvCk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790731741; x=1791336541;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uC7WelJhaO9GzJtHMP+nH/cv5nn5lpg8+60Spi/MWsw=;
        b=r5vJcj2UYmM/5SyhkhNtxjB0H22moWBOf28ChSIthDQmuZi8gik/3A6cZ7OC5hvDYN
         C63DQObSFn+tQaJDyqqLeLPPg/YvfmvlT8WhuRHSJoHCdhnIsYhvwDx9scTwx+DjJiwG
         ovMQJ0+54KOw0cf/ULH1Q7lObH899qO/ozdZMMUjUeOePEJczUUh8A+u0ZD+8VJyysez
         S9L65w8o+VSa7L/r/2qKz5SSNA33OuhbnCV1FxKuDfkGiyW8uqZ4OwwXFY79TL+i+mbn
         IuzoQuJzLRJ8kV8+nanfz2axl+K0sWy0yKECt3jVTgOTlgnt6JQgVuFSLTyLhDUHYOhA
         Jv6A==
X-Gm-Message-State: AFuF++kMZ51zUKyh3jUqVrFDgYwQraq8PxbRopap5BGsvwhA0iI655XW
	5ivnEijMBiMKOtXOg4wPW+GEHBrEO6GZ8ZtTgRTiA8v+WmHJW8pAa33nO+wO9m9H6yEKfQBBl2Q
	Dv8fkkMU=
X-Gm-Gg: AYBFou1wMqUaixlma2AhH3AjvjvUb4ngQGQlm21bAzuAfOG99gCci8bs5cnW8kdcYKx
	DM8hDRimlMOEMjUa8kimQn43xNtQ3sthXuN1FzIXr3eJpUnE80lgahNVNPM4vSAveOKEbpbgKhO
	R9mizoTxBsO1DW5hyToFfvkNgF2tjXlaPRAtgTl6ynXOvpnpPaLKDHY5dZyEZESEPOMkAH/1LQg
	I0JEgu4DoQVgkVfp0rhESlUBfXGMZSz8gJ+8BZnJ5SxoyOgX6KbEvKQFxEPsiZjgIKOQc+l1NNP
	7jrhE3xEZJZ2JUfQYgwcjj/VVwq52IJc4CsR8edprSJbSBJ5FYIv1P3G8njLjwvPBZME9leDoYT
	TLDkeehQQbMVYzg1+t/QoIQsEbdZQzr9GjaIWpsvKrZ8SC/N/TuoNh5DJQ241ia0WDQixJ/cUAP
	LKlT82Q9e90xEUOL6lsHVpxwi3PiD1YJ9LzoGrBcYQxA/73j9SQQsz/cPc3rHAHE8944fL2cTTh
	WebDFg+SkYqDUUQgcnzfJZqgZii1KTPnTxOvT1J9lc4lklQk5HF8yEKb/grNERGS5VaGBjOZJgm
	Bag62zWV0RoAJZN0PE8s
X-Received: by 2002:a05:6820:8119:b0:6cd:3fdc:a936 with SMTP id 006d021491bc7-6dc79734292mr902950eaf.83.1790731741214;
        Tue, 29 Sep 2026 18:29:01 -0700 (PDT)
Received: from com-79390 (vpn-centralus-01.tradc-corp.com. [172.169.249.3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81faf30f660sm1419508a34.13.2026.09.29.18.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 18:29:00 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Tue, 29 Sep 2026 20:28:58 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: [PATCH 4/4] repack: retain cruft packs in MIDXs containing kept packs
Message-ID: <e942c256334e4de31ec0a1cb2d5f8c7465d8696f.1790731662.git.me@ttaylorr.com>
References: <cover.1790731662.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790731662.git.me@ttaylorr.com>

When performing a geometric repack with 'repack.midxMustContainCruft'
set to "false", Git uses '--stdin-packs=follow' to copy (once-cruft)
objects needed for reachability closure out of cruft packs. .keep packs
do not need to participate in that walk, though they *are* included in
the resulting MIDX.

A .keep pack can contain a commit that reaches an object whose only copy
is in a cruft pack. When there is no previous MIDX and the repack writes
a new pack, neither `midx_has_unknown_packs()` nor the `!names.nr`
fallback require that cruft pack to be included. If the kept commit (or
a descendant of it) is selected for bitmap coverage, the bitmap writer
fails because the MIDX does not contain all of its reachable objects.

Include cruft packs whenever the MIDX contains kept packs. This also
retains cruft when the kept packs happen to have full closure, or when
'--pack-kept-objects' lets the repack walk them. It avoids having to
establish their closure before deciding which packs the MIDX needs.

Add a test that packs the tip commit and its tree into a kept pack,
leaving its parent in the cruft pack. The new commit's blob remains
loose, making the geometric repack write a new pack and bypass the
no-new-packs fallback. Verify that the repack succeeds and that we are
able to successfully write a bitmap.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 repack-midx.c           |  5 +++++
 t/t7704-repack-cruft.sh | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/repack-midx.c b/repack-midx.c
index 64c7f8d0f42..622c3c9d236 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -197,6 +197,7 @@ static void midx_included_packs(struct string_list *include,
 	}
 
 	if (opts->midx_must_contain_cruft ||
+	    existing->kept_packs.nr ||
 	    midx_has_unknown_packs(include, geometry, existing)) {
 		/*
 		 * If there are one or more unknown pack(s) present (see
@@ -209,6 +210,10 @@ static void midx_included_packs(struct string_list *include,
 		 * reachability closure if the MIDX is bitmapped and one
 		 * or more of the bitmap's selected commits reaches a
 		 * once-cruft object that was later made reachable.
+		 *
+		 * Kept packs may also depend on cruft objects, since
+		 * they are included above without necessarily being
+		 * traversed by the repack.
 		 */
 		for_each_string_list_item(item, &existing->cruft_packs) {
 			/*
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index f7f83e70ffe..02db2a06d9e 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -798,6 +798,26 @@ test_expect_success 'incremental repack includes cruft for MIDX bitmaps' '
 	)
 '
 
+test_expect_success 'geometric repack includes cruft for kept packs' '
+	setup_cruft_exclude_tests kept-cruft &&
+	(
+		cd kept-cruft &&
+
+		# Keep HEAD and its tree outside the geometric repack. Its
+		# parent is reachable again, but still in the cruft pack.
+		git rev-parse HEAD HEAD^{tree} >objects &&
+		pack=$(git pack-objects $packdir/pack <objects) &&
+		touch $packdir/pack-$pack.keep &&
+		git prune-packed &&
+
+		# The new blob is still loose, so this writes a pack instead
+		# of taking the no-new-packs fallback.
+		GIT_TEST_MULTI_PACK_INDEX=0 \
+		git repack -d --geometric=2 --write-midx --write-bitmap-index &&
+		git rev-list --test-bitmap HEAD
+	)
+'
+
 test_expect_success 'repack --write-midx includes cruft when instructed' '
 	setup_cruft_exclude_tests exclude-cruft-when-instructed &&
 	(
-- 
2.56.0.4.gbee41d2fc68
