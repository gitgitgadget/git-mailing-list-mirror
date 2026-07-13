Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BEE3093DD
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960086; cv=none; b=MXqX9AzOK1gnOq7v5DPHlEZofSU40pTveQ18vpPNYSCdpzZoorrhe2e7WM1v1t1m6CxoFAJjHp6FSZbN8pe33uf2DSKKbU70NtaIGnf/HTPryzWsq21HisCRoGyMDNpoF9YonBZrFt3jGmV/+5fb0gJg/DXtwZYbPGLOnQDIrPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960086; c=relaxed/simple;
	bh=4KBcAR5Vfl+gQx+tb8EMyEniHmsHTUyRoJUaYJrmd0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PfyeMFCxGUXjoZa1GkHQD5YyKeSGrLFTh8AtcXrLvpsKSw3JaGe2w7A7cwnd+XVd1a/9GvLzJfBhSbYGzWODRait7HhNJJ7ZVwdoqW6BBOKFtczKDleBh7FymumdMDB3xNIP7RbJkqR9sn08PdBYfSft2VHgxoNesJvyIk3xo6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XfKHdJG1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ewQVKeFu; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XfKHdJG1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ewQVKeFu"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 524B21400181;
	Mon, 13 Jul 2026 12:28:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 13 Jul 2026 12:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783960084; x=1784046484; bh=QMyb5HTu7Y
	FmmvSOcvb4YJ/dlo93/B2EEIYQ1VrsjWg=; b=XfKHdJG1fnmCZMkdWR/G2i4h1F
	1W269MLyUY+JMD2Vfa9/avldIFgCqL2MpXG6Vaq/HEF2gYbr7GKyneJJJWtxDN0a
	obFIdbLDDLBSPOLwnAVJLcewtRiCDY3UR7osUdkv2y4t9WU8XJK2AdZsLsJaX0wO
	LBY6VTbh1rZ7COaEzQJhTQtEm/GJ5cmAyPFFsdHsL/HIY5FzbUpAOGCVYkUur07Q
	VF/TViqGqSnWUv2xBMxtHYIALF+oKqlQFCIfNRtcFniHbkpy1AqQvBgDFErChxmy
	LQ5xSaemSXBEGBYspoyF+e3V6qpLrk5H5a8ojkXAXgOY+fcr6unalBLFw5dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783960084; x=1784046484; bh=QMyb5HTu7YFmmvSOcvb4YJ/dlo93/B2EEIY
	Q1VrsjWg=; b=ewQVKeFu3HIg3mR08vVf1WiG83ZmSS6sOIki4vZf4TCNZkvWCaQ
	lbCMU7vLKP1IJRgOFyqAi4f07I6Dix/rIwBhUImttDlKmeSdjjCpMKH9FoiTfu1/
	Wtnd9Q8K2Yb7DyAYiXxghCEaE9H9IlDBmYR2xRk5KJQGK185Cau4fFy68TzpQATl
	OsMR10xxQLkUQ0tssEONx4BA/aN4it8SEEymfaJphUKgO6llMzvdmZUdCHQfR6V3
	v5fvuwWUL3YmGqEOnSKWim3BMGDFJw6AULbnhf3iWetEO84aTqZPNGhFLU+nQvjK
	nKRKp1SPNQ7Iwn1OwC5vwd6dylgqtnSkrhg==
X-ME-Sender: <xms:FBJValop3Iy64HludWHC1kxRiEuaM7rCPg7a7wVbufryBaL5npE71w>
    <xme:FBJVavFurqOjSP5tY6-xK-HFZjj1InMGClMkv4TnMDqhmqrVYBXUY4R9Qrn07ELHY
    1TIa9vviqthTM6IY2gcTB0KSxP04UfzCMBpGhjYooqmqiZD_C0HPg>
X-ME-Received: <xmr:FBJVavnKm-EsP0cZLV6KWP3TwU8HAdIIDoStBXsDCBY0FiEIvJwY_0Drfl1_2fSg2WYKj3DlbW-sph1ydhCE1YPWuJYfaDodxvITuQY>
X-ME-Proxy-Cause: dmFkZTF7t2Cn6MpKm20ZKO9t/fANSlJFIj1iUffTvHxDGx7hE8ADv5CvxxSqcMy1TzN7L8
    d9OlUGN8CQZOH65Ss3M72cTRK5V/r31AABJR42OvCH3fF0M/gtVsN7d0FUpz/dRuFuD2PY
    8l68VY79kasdDrlbWTB/eZC1iMTH5sHk6x3XtdPo6lNAPumc8CutVtY84+3yqYdN1wJb4Z
    7P9YbdlZO3r/4b0uO3vBebT8X1wdh3bJE0DwDkiy6fcqbAAZf56dqNS0LeHVZC24hxomuq
    K71Hsk+88TRR5wGozX4TO5+2Pw/QkuRcHv/ZgIhkm4+OAwVSCRQ2NS0op/9lJKOKdrICih
    1K34vV3Nk3w8Or3+f0lbhVGHCb3pXRvURylLkX88trTGgUkBqKVfRDDPiSPIlKp3QtHAP+
    ogiik1eYWnY9O+NUc3WaFCG441DpVRakOFEk86YT7vBgxn6fB6qoDqQkcqkXRcuHaGDJvd
    KcFuQJ3wrR4qSpwfcKy3FkFPv0XzOOAr8kM/e3g+RQUDK8TkTnjTQLyh5RNWfaq+FSkoX7
    ACAYEc/HdlztyVTkR/AhWrtIPfSkOSc3g6QnZqA0s4Nbfcmxk/hH/1HHTDa8Bs5b3GT25h
    MUAPj7ez9Vh/0Btb4ShzD6HWCCMi4lBavOnFxr+myRovcdN40TZ4qPrzgvig
X-ME-Proxy: <xmx:FBJVaqmlB_zOpibgluEY9o1SiWZOTsrXpVueP3HpvyMydcnJQ-D6dw>
    <xmx:FBJVaovaRN47r31zDHS-1PechfOdSc98uDr2FO6PoTQt-1O8f4181A>
    <xmx:FBJVallwX4yJ61Qt69juacR9wLABvblg6UbpeXmcbjhKwmctfXyyqw>
    <xmx:FBJVarvVcbHBPVuVHqQgnd4rMbnxXCLipLFV_JYEibB3880miHS-qQ>
    <xmx:FBJVanMp6Z6A8KHou7bhu4F4rp_9Se7m0txDkQgsD2K8iKer32EMx0_9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 12:28:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 11/12] builtin/gc: fix signedness issues in
 ODB-related functionality
In-Reply-To: <20260713-b4-pks-odb-optimize-v2-11-9c2c3ee94b38@pks.im> (Patrick
	Steinhardt's message of "Mon, 13 Jul 2026 07:52:14 +0200")
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
	<20260713-b4-pks-odb-optimize-v2-11-9c2c3ee94b38@pks.im>
Date: Mon, 13 Jul 2026 09:28:02 -0700
Message-ID: <xmqqwluyyhv1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> There are a couple of signedness issues in ODB-related functionality.
> These are not a problem because we disable -Wsign-compare in this file,
> but once we move these functions into "odb/source-files.c" they will
> result in warnings.
>
> Fix those issues:
>
>   - In `too_many_loose_objects()` we receive a signed limit, but compare
>     it with the unsigned actual number of loose objects. This is fixed
>     by bailing out immediately when the limit is smaller than or equal
>     to zero, which we also do similarly in other places. The warning is
>     then squelched via a cast.
>
>   - In `find_base_packs()` we compare the signed size of the pack
>     against the unsigned limit. As the pack size is always going to be a
>     positive file size it's safe to cast it to an unsigned value.
>
>   - In `odb_optimize()` we compare the unsigned `keep_pack.nr` value
>     against the signed `gc_auto_pack_limit`. We only reach this code
>     when `too_many_packs()` returns true-ish, and that can only happen
>     when `gc_auto_pack_limit > 0`. Consequently, we can fix the warning
>     by casting the limit to an unsigned value.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/gc.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Yuck.  The -Wsign-compare strikes again X-<.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 3207182488..8cf3781313 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -430,19 +430,21 @@ static int rerere_gc_condition(struct gc_config *cfg UNUSED)
>  
>  static int too_many_loose_objects(struct odb_source_files *files, int limit)
>  {
> -	/*
> -	 * This is weird, but stems from legacy behaviour: the GC auto
> -	 * threshold was always essentially interpreted as if it was rounded up
> -	 * to the next multiple 256 of, so we retain this behaviour for now.
> -	 */
> -	int auto_threshold = DIV_ROUND_UP(limit, 256) * 256;
>  	unsigned long loose_count;
>  
> +	if (limit <= 0)
> +		return 0;
> +
>  	if (odb_source_count_objects(&files->loose->base, ODB_COUNT_OBJECTS_APPROXIMATE,
>  				     &loose_count) < 0)
>  		return 0;
>  
> -	return loose_count > auto_threshold;
> +	/*
> +	 * This is weird, but stems from legacy behaviour: the GC auto
> +	 * threshold was always essentially interpreted as if it was rounded up
> +	 * to the next multiple 256 of, so we retain this behaviour for now.
> +	 */
> +	return loose_count > (DIV_ROUND_UP(((unsigned long) limit), 256) * 256);
>  }

OK.  It is trivially correct (if rounding up is correct, that is).

> @@ -456,7 +458,7 @@ static struct packed_git *find_base_packs(struct odb_source_files *files,
>  		if (e->pack->is_cruft)
>  			continue;
>  		if (limit) {
> -			if (e->pack->pack_size >= limit)
> +			if ((uintmax_t) e->pack->pack_size >= limit)

Here, just like in too_many_loose_objects(), 'limit' is of type
'unsigned long'.  While it makes sense to convert both sides of
the comparison to an unsigned type, casting only the left side
to a type that differs from the right side puzzles me.

Presumably, the other side is of type 'off_t', which is signed,
explaining the desire to cast it to an unsigned type.  But I am
not sure what happens if 'off_t' is wider than 'unsigned long'.

Otherwise looking good.
