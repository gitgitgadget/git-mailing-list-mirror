Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913105326BB
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790676; cv=none; b=YLuNVCABSj+BKJ/uThLpE31ouCOc556KDVB7YEWL4Ybh+r66QGigPAKjJ6cBMXA2ustGnwCMCDcJbFFre7anO8CBu2fPeELwRLQuypcek6+4R7D6oKDCk39J4jMNfh96vw750wuyj9LCPKLuBOutWpIIVzlCmajp9tbHLxJ4qVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790676; c=relaxed/simple;
	bh=tXt9JqGfGOomGgWUVOEDuo4oBfMjkpRqwdnqt8mX5Qo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q1yPccHpQvF2ZZN4+mmhpPSkM0VZ/lAeKe5XR0sN24cIX34jaPfxNn9Cn9q7Cf8ocwxJXk4byjEhWbQs0l3qltw6z0n+FxdxBgUW3yfEKsX9+B/rK1Io4NU7qtbCm4abLJkj5RWgTfKX4CXtsi8D1DHomKY6xg3jKdGvoIq5fZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PY03x9AA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YWWbgnot; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PY03x9AA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YWWbgnot"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 95455140023D;
	Wed, 30 Sep 2026 13:51:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 13:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790790674; x=1790877074; bh=u5g+Pb1tn1
	0ehZ4vHd/oCdHWi8OdM2knOWlxZXKx86M=; b=PY03x9AAjUV8up1q7nLQ59bYc0
	Pjampr2oqzWuqokuuektQL+0u8H9PhqjE2rCF71ou/naDcHP102LXNehjhCfm/Bq
	FPXv/6jYyAEwVlHlMJFoI7c7PSiH7LdYTYcWVZ2NWyMmBm+I/LMHTsGPL+9KjpkB
	kB0kCC9uxs1m18irrDLydaSh+0nTEqRjJ2B+0x5VGxLrWezgF8ndrqgeGtlP7HZF
	V+NY1uQwzHhOtNx+Di6r4y/pfADjufKrrkECrRb6Ti6TOmlMm0yRghR91s+dkx4L
	odXJSLdUZUJ1w8SQtRjFbiYE61EAmO5MeMJnGwH5mAJhA9D7weoqHf1FCbRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790790674; x=1790877074; bh=u5g+Pb1tn10ehZ4vHd/oCdHWi8OdM2knOWl
	xZXKx86M=; b=YWWbgnotSoPZcjc7ITBBLat7gY2JGGUQuU9ft7yk8QWPrNynhm7
	epKkbCyFg1/3BVm6TTAta4B2Qg1PjztApwzxuFwQWBFmLjTE8+p/Xy0X/tDpdRMl
	TQgulLOQDWJsOlqL0u+1kqkq3SbaLTPZyGRt7aRf4PMrtEkkXqFbsWC4SCgMTQFH
	dtDEleyx8rIsLkg30+hanwwU/iQm6Fu2+bkNlZ4QGf+2c1bGGA3D6yXZVBxsutIy
	w6sCNtBPT5zEKROHxsy8vfsqK+IR8LRFnupz8EZRJagXzwU4LWmGyNwyTdpMzPne
	uMKQkoz88ConV42Z4K0D1KcgmK3uX/y0BTA==
X-ME-Sender: <xms:Eky9amNPVZu1QQc0f6IlumG1Yp90u1KQynt6RNrMw-B6alhWyWI1Hg>
    <xme:Eky9aooAW8kcCIovL2RIDBZWDNwtS4dWHXObL0x0JS3tDPiz2YUJtAs7Cy43-ygkU
    xY1S_R090IzTs8hR0VI-gCeObMNbkRcVTN_Gu0F3HANArd2aD9psJ0>
X-ME-Received: <xmr:Eky9anGRNvKJu5KMcZ1zM31OSuE_8-IsQZW0VY6Mh8A2gjPgo7zeIlAuZwkr_shU8mqlZFUkQ6bM__EGiEa9CECFtfXXzJpXW4tq>
X-ME-Proxy-Cause: dmFkZTE37C4oLYo4FvCkaPSnBjC8Hy75LU3+NYqs4iGJZYQoG7b4xs9e5D2NOjIqMY2id5
    KC5wv7XY+vlXF3zARHnEPPYUsAXu8XSPoHGCwcWXkXgI1u8yRgYLKiKVqQtgfSKeq9tfnG
    VIrhNhKEF71X5QeYtDiTOUIC+uBKJAxuziKKPcNedsBZcNNODDKBKkHpPKP9Nb6hTcGVZS
    GKLY9bb3Dpe+HvnYTZkUUegyZRW/FFvTniv/R+x+F9siQXmks07L3xj4EIpcbe1ieG0vTt
    nTVFFVHUQ0snf038b/cSm6durlpW23lwT0n3YIttAGsIebfPNeHissDAJ7cNv2x9JI5set
    swPT3RvZj7niHEEIrCwoz5DE22pNgjdHS0DEN4nxDGZtmiw2GZgPS/EGFiSsNc99HAepT+
    Rh+Ouf2d04jIFGssEzZeHqiW3k4MxacC71CFXhXQoqRfMZqRIqPLeHxXOcO2TgE7cq/QQm
    ZiUn0mnEJEM94QF86oXv8tCcb7gpf7tV7rWb3ciBjlau5fzUUu4NVtW978By1qjg3GDz9K
    crX+vQbiMDmQ3H6HdKIR2vm6sczBPGEcldeuFIbB+ZE7gOyzgbhDiJg6GbYWeAf67ypOpt
    ZMa3NnoMCUQ3ifU3BDCl5BmMBVY8o7/KafYcG4SqAy17ooANu6/fMuuVxibA
X-ME-Proxy: <xmx:Eky9atriAB6u3Sn1Zs97dMTwVk7o2_r-qYnzo5tX1R1u5sih3cnvYw>
    <xmx:Eky9agZCniV2BodHIaKXWw6wXHvtqKbtwY8Fz85wyfU-auUVxBz_pA>
    <xmx:Eky9amWfa9R_FSZGspGvuBKTthWshh4llkiGPDasCI7eKIShWo1osQ>
    <xmx:Eky9ap8SLLj-5AcPZqWSMisI9Iq1fiTDpQKFkHHrE2Deu06t9jjYNA>
    <xmx:Eky9apJo9fAGtUWwUlG7i750BPZHmfFyj_9QKzPWh_i9UVPQd3XHZOvP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 13:51:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Ted Nyman
 <tnyman@openai.com>,  Elijah Newren <newren@github.com>
Subject: Re: [PATCH 2/4] pack-objects: ensure tree/tag closure with
 '--stdin-packs=follow'
In-Reply-To: <6348667e2e3fe63aeb139888e877dd8447570253.1790731662.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 29 Sep 2026 20:28:49 -0500")
References: <cover.1790731662.git.me@ttaylorr.com>
	<6348667e2e3fe63aeb139888e877dd8447570253.1790731662.git.me@ttaylorr.com>
Date: Wed, 30 Sep 2026 10:51:12 -0700
Message-ID: <xmqqcxtubpbj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <ttaylorr@openai.com> writes:

> @@ -4574,6 +4603,9 @@ static int add_loose_object(const struct object_id *oid, const char *path,
>  
>  	if (ctx && type == OBJ_COMMIT)
>  		add_pending_oid(ctx->revs, NULL, oid, 0);
> +	else if (ctx && ctx->mode == STDIN_PACKS_MODE_FOLLOW &&
> +		 (type == OBJ_TREE || type == OBJ_TAG))
> +		oid_array_append(&ctx->extra_roots, oid);
>  
>  	return 0;
>  }

Makes me wonder if this function will always end with "if ctx is not
NULL, then depending on these conditions do one more thing" like
this, or if it would change later.  If the former,


	if (!ctx)
		return 0;

	if (type == OBJ_COMMIT)
		do the commit thing;
	else if (ctx->mode == follow && type in (tree, tag))
		do the tag or tree thing;

	return 0;

might be easier to follow, perhaps?
