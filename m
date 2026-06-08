Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A4937AA82
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922197; cv=none; b=T5WP9AEMf6tSABoFEzadKuvLtD7mva44+GlGY260PYtmnrSXg5Ofb6sX6xMwoe3SdRFuPMdfBw5lFBolYqxeg8hLxUPFk9loTSa6D1P3ZSmgamWPAY1Lyu1yflEx3njAZ6KWuK8ENU/PVxLZROS+lvliA/Wz4+de447Xl0Im/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922197; c=relaxed/simple;
	bh=3Vyt+hnxdq6N/ME5jhPOd70HmDZ2WSgPqc4pdeNYspA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SK0xlJfflSrujCtt2h2rUswk4Dd5S9h+nyxea2MfBMz8FjgcfjxGny2Qco0ot74eZOD3FGfNy/6aIxqg1xHEZnNaKz6bCfMZ/sCqshUSp+uSLyfKBs2RvkHDbkUxFW1cvi6fVU1gmESEdHwtNTvagZF0E/1gSy1fzMscgxhJS/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DKBKrM24; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JGx1pA6r; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DKBKrM24";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JGx1pA6r"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2EA32EC021B;
	Mon,  8 Jun 2026 08:36:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 08 Jun 2026 08:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780922195; x=1781008595; bh=Tj6O4Zq5+j
	natuH+C411yadDPaLRUrujsGQ52u2yvPk=; b=DKBKrM24DHiQEEgPDUTcukTVCp
	seTaT1+En4V151FV59cI5orc790VL3EeG7qgg8qlxbas7qX4opFhUxd/0/sbAz6X
	rd7QOA4gUNaAkFfnCafcX7Uu+KHxa/qVdqFTYftwhYiiYnDrDIGNS4NmlOyFvLup
	Z0fhFkj6uslb5BKsRH8gpZKmuUSGd67FZFH2dsKnc1XcNK07D8yium0KMsb8ACwv
	/ipdCat1rZeIJ5gYoyTWamnFKIWsrSWmX+S5WpX8uXg8nQrfJkGIOZ65o9cWSfAU
	ws1pAT7uHNDpaY+Ns9ozCbWAVMvgEfMrKl7UaGvlOjiZ3CDadrooFC99jIPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780922195; x=1781008595; bh=Tj6O4Zq5+jnatuH+C411yadDPaLRUrujsGQ
	52u2yvPk=; b=JGx1pA6ragEF2SQtX/hTZDHkPzq+zcfJnRCmPClRvSjDW7Ko+6c
	idm415ZqyQ7IiO1wwXt6n+iQqXkzyeB+dlPS3g/DV2M24ed8wa3GGotjVbCX+S3j
	fdKHyGRXIqoRjtiXf9HSCO+e1yl/WRSaYHQO6ag/FQULAdK0qupV/7Uq3EaiDsqo
	FVAdeRQ7g7F7B4zJFVxQmbC5pl0qOz4VHH+UyM3YlnClGjJR3KWAb+y3t47kLeOr
	FzP/L5T7rwoO5PZJ29+JQb33AIsxLhpll/WCfMah+TyE8NOQkVtxRJwuhGZ+QFO3
	txfLH0AVBV+QwwtZChlJWof2dRynmEzJT+Q==
X-ME-Sender: <xms:U7cmavQPpQkUl2k9xSNW9LH_OiunP_yOXRaUXT1p4_pPKgZuo2zMQg>
    <xme:U7cmanrpuc_61qhI7691ux3vTIm4-30fQawJUAsyQa_HmajXLv5paDhLCQ4rFQRHF
    4c72auW3s0uWS2g1FamDNFpRwn5NwrgfhmKDrZsZ1QO2TKpxw53Ig>
X-ME-Received: <xmr:U7cmatKXdiXyX6R-idIFS-HCYlrgKbC9JessTgqZSGNnXsb7egPHPBk7wzKVsyi0_7MeoUS2eP7S7sgEN4r_YwmfQdo6l1tbi6jn>
X-ME-Proxy-Cause: dmFkZTGzn5Pcbeyl1tJTErhXKtI68njz9KlAeZyUSaSSX5oAwOEi4DoiIR0VOzkeju4ZuB
    yp2Ma+tONvKCvVUPCCJlLHUhix0tnaTqrqgG7ZYEFluD4IJJ+ewcld+0jUhpnRIAtOTRFU
    R3AettMmYxAcZon0yXOHlBaNOKEpYfoy6f1u6uOVxNB1MWZd+jOaB2OAYNqmAzOBt7sWUn
    GM83ib0FW2w0W1e2zCf8Lvkeu2yQBC5qFJVZymUlUp6CxuRwiqrsoikKAAs+65fSGwktXX
    Ka08VfZJwT+wjAvdFcfuqLKvSBEqTydhMb8ocdhnOnxwjvnS7L+h4HuNzTxDhfJ8SQxOtJ
    ArdwOxL/XK1DuL55/UgJ/x9b51tUtY7vThOZZ1tnp2SB2gx5xQ48ieOIHQoA04ZWCaL5Ae
    jqy1DM67voLgSoCqrq5vfkoSLCx9I9xR9qJuw4nlo2fCvcLO08/r8aP68GjUzsRszHf0Cr
    sqTuvGdpSseZVVEB0zcPCxEBHZdVrzLSNlHSOz621NWIK4BWwXlJkERAB5c72lOc1Wnlda
    ATDS7ETuX9OYACIoUhCdw0GMDU/xDCk1EHMQz0vcqGqA1hi+HR9q6GMbwmQOLPYPx0Zfko
    YoR3p6VY6Q3SiJ9AKja2V2oLOdDFzjwULctGtM5no8jwsuAYJaIU+qknYGxg
X-ME-Proxy: <xmx:U7cmaqp6Hhe54opJ3FzcfesadeuIuyU51MqvjgeHOergVJqCbz4t9A>
    <xmx:U7cmalyz_O-H1GgUtT0umk48WHfgpPiYQrABHm-TzZECew_YjHixzQ>
    <xmx:U7cmauNfiVwvhb8YlBxILlxROgGBEdHKwMEopOLJFd7L7Al2Gy-zXA>
    <xmx:U7cmaq4NIWiIkE2ROR4-rmplTEhGnF1-Madxzd4aSRH3F1GGsxfg8g>
    <xmx:U7cmask2mtLc7z6Wfb5rCVxt6PUTp8hNLICBxNPkcOW5_VGDsfv_wZma>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 08:36:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH] describe: limit default ref iteration to tags
In-Reply-To: <20260607-describe-tag-ref-scope-v1-1-653d232b86b5@gmail.com>
	(Tamir Duberstein's message of "Sun, 07 Jun 2026 16:51:53 -0400")
References: <20260607-describe-tag-ref-scope-v1-1-653d232b86b5@gmail.com>
Date: Mon, 08 Jun 2026 05:36:33 -0700
Message-ID: <xmqqecihyzse.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

[jc: Removing Shawn from CC who passed away quite a while ago, RIP].

> Unless --all is given, get_name() rejects every ref outside refs/tags/.
> The rejection happens only after the ref backend has enumerated the ref,
> so repositories with many other refs spend most of a simple describe
> invocation visiting refs which cannot affect its result.
> ...
> Both revisions were built with -O3, -mcpu=native, and ThinLTO using
> Apple clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro
> (Mac16,6) with a 16-core Apple M4 Max (12 performance and four
> efficiency cores) and 128 GB RAM.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  builtin/describe.c       |  3 +++
>  t/perf/p6100-describe.sh | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+)

Interesting.  How would this relate to and work well with
<20260601233727.43558-1-jacob.e.keller@intel.com>?

> +test_lazy_prereq PERF_REFFILES '
> +	test "$(git rev-parse --show-ref-format)" = files
> +'
> +
> +ref_count=10000
> +
>  # clear out old tags and give us a known state
>  test_expect_success 'set up tags' '
>  	git for-each-ref --format="delete %(refname)" refs/tags >to-delete &&
> @@ -27,4 +33,18 @@ test_perf 'describe HEAD with one tag' '
>  	git describe --match=new HEAD
>  '
>  
> +test_expect_success PERF_REFFILES 'set up many unrelated refs' '
> +	git tag -m tip tip HEAD &&
> +	for i in $(test_seq $ref_count)
> +	do
> +		printf "create refs/heads/describe-perf/%05d HEAD\n" $i ||
> +		return 1
> +	done >instructions &&
> +	git update-ref --stdin <instructions
> +'
> +
> +test_perf 'describe exact tag with many loose refs' --prereq PERF_REFFILES '
> +	git describe --exact-match HEAD
> +'
> +

Is there a strong reason to guard this new test behind
`PERF_REFFILES`?

Even though the penalty of enumerating 10,000 unrelated loose
references may be most pronounced in the `files` backend, skipping
unnecessary reference enumeration is an architectural win for other
backends (like `reftable` or a fully packed repository) as well.

If we drop `PERF_REFFILES` and retitle the test to "describe exact
tag with many unrelated refs", we could run it unconditionally to
benchmark the improvement across all storage formats.
