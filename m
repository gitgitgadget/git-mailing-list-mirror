Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750A1DFDA6
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 04:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788236366; cv=none; b=XTgBUmLxPJtAYiTQWSBYtrfS/rq4QHqsmFjMwgP7tz8vPN77Wd8oCaUKwxUvpxuHvMQWi3dBFwV6JvchA/w6Z24+eUp8RU23J9lQijAt99PX3YvrWmg85gEdbJS2hZO7k8rkazUU4A31YgBi81b9l7EIRV7zB7IWXuhCZq0IEFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788236366; c=relaxed/simple;
	bh=BIfxoNo5Mid0aWnhLTK0BSrF3rMkNzUudiDWPLZSrUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WDD4AnAv25cwDMfZ6oMigJgG3+HgWfNpRu6YoIf7ex6TbQO/83CmaTnn0yo9HIZ3BjLGsoHLJmbthEZMesm4NEo7McxNOhBaG7MN5eHuT/zsUOLvnZzR4gHpyXZdl4CdYFmC6s9qEt1ZNolY4tiaThplGuRi0DoqKMu4fVPrIvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PxHnns7s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PaB4D334; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PxHnns7s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PaB4D334"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 867347A0140;
	Tue,  1 Sep 2026 00:19:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 01 Sep 2026 00:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788236363; x=1788322763; bh=ovk5d/dpxa
	TRiGuzTDiuuIwmjxn1Y9bvmK5DUH4YCfw=; b=PxHnns7sfgM5Paxd6PQl3YBmo/
	h+dW/RlUlvAYelKuY+t5JXgcCAXJSsNm6EoqaOixpNzQnzUERA2MSvBOQ7j5CUuz
	FJs6cuRQyMENROC1BPU/Mw5K6DSk2B99tQLJx0wC0bgG0Uj2+9YPJLed3CQTUMGo
	nZbe1VsuFcB1eKJlEDeDTkZzWRsiT297Fhz1XuIvoQsUBzFZ6moTCFCMeIRKIlNG
	fQsz2kHtHC6U0bKhGJyse17Ek+cgr7ofVT//1MVCjXJD41YiUBMPQMxGX2sTv/Ey
	YlEK+5xs9tdB4j1vXXChRpRekcQZRWzoK3Cs4tgXriUPFvMmV04KYKsEdERw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788236363; x=1788322763; bh=ovk5d/dpxaTRiGuzTDiuuIwmjxn1Y9bvmK5
	DUH4YCfw=; b=PaB4D334mz3emFLjCtTtsXBg3mxfudFvMJeszBo0PQSmrN7E5hL
	1rNZmJRkXhdn2aRFA62b+EfPmqdlgjMhfnVfg0BkHgTVbePgGnDb8NfiTqnPpSYe
	5Fwallh/0iBJeI1sqqsMFKpXcqnQxWwgl88QVlo8WbcVeRZZC+MgXh3UKE53U40L
	tCEDptIfisgXK5lrsbAoO/d7hanVcRzY8co7zz5+pccRe+K8ke4JefoS85amRt8R
	QacpCbxdpVzrIUZti6pBTl69kIeisbivSG9MDLawKRNOP07gBlddD0Flpr6UHCsd
	90fLfO56Mkilbea67xO3RwGGWX+WJRYtviQ==
X-ME-Sender: <xms:S1KWakf12b8x8ybQX3bpOIhA6iTpa3ZfkPQMGzbfwJb2UsPMgMa5MA>
    <xme:S1KWap56ECmp2rxwVslibDb7JS3bF3G0XzQ-FkjqoHByFza7ZCQyqW7ChmLsrNhj0
    35g8BxsYGvDdrjJzGoUqy-QB3gxOClc18br-HTimykiywmAI_fsEuk>
X-ME-Received: <xmr:S1KWavWDmaA-zJju5QCmpogLel0ARhDKaR3GddKs52MXG4zkGA3c0O2ogfKA8k7XJpV9qKttF-vJLMGSwO5a8sAPSRCQuBuLEQ>
X-ME-Proxy-Cause: dmFkZTFJRvhlX4HGOEnvpNY6XmpC5Ni2Oc/Wi2PpUySkM3hPQDha5WYg2MoPIRoHf/idOB
    0qHXMIZO4gL6QQvannYYENLUk9Q7Jktmrn6PdSd0tcJsrw+rftjIADHfQYjREjdTdEjL+R
    Lj4cvh7aCo9SmLS3uitrQYKJtwscZBudd3yEGmWcEOpstG5e/0bJ4Jh2HuD7FiKxLodYmf
    HoDy4mXCXjD5qzOKoU+au/IjmB8OQyFiBJVXHB5ADQiT83TIAaiUrKndM5JB+Z9+U7LRBj
    jyCBtnMxkHVIlxxMfWjiEwLIZm2wnNMM9/Um7/CwuZ4Ofb/BJg1SS33SKve2EYBfoDFKNb
    46Rr3uFrh0y/breahWTtffzlw052QdBaIisf58kPDqDO8P/w1wRlmdfoFbCIuBLQe8T1Az
    QAkPRE9K81rnnpuwNwZiGXM0SsNpcN1H1G/x5ifXqIzK3yBNG6TlqLo19gPfVV/HbajmD8
    3j2BBsXxPb7wV4jy80hMQX1nMMJpmVSmDJhziJoivq1fDIPvGclqt1xhf29A0G7DPsTH+V
    sYIbqib+KKy6M45bLwPGaUrkl37atTJmbi+JS+PYCpJB7Iw7sDrK7sNZW1qxgO13enea+P
    VLbalgfPR9NvQSH4wPFqVFLgHTw4tSFRkAkRXAUATAglvTO+IThYdZf30Q6w
X-ME-Proxy: <xmx:S1KWag69tE34jNmfw71K6B8rKCHiz3J0nZ6J3x1eGAMc3wuCLVMP8Q>
    <xmx:S1KWairiLEvDmSDrGIsT2KS7sNkABsNg0lR-WuVbFNpEjmLKuQtCZg>
    <xmx:S1KWarkmNs-w7YZK0AhSem_MVl8z2IIxakrD-0L1Zcb5zj7cvG7BfQ>
    <xmx:S1KWamMpbQ_JscF_nXulr_Go_8UYPYg-I1gvHxuq3H40PaLatQCQrA>
    <xmx:S1KWalaVzev09Hc9ZuMho9FhfP_gk6q3Y51ldhXLd6Y3QbA5xOLVgl8T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 00:19:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Gusted <gusted@codeberg.org>,  Jeff King
 <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 6/6] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
In-Reply-To: <20260831-toon-speed-up-last-modified-v3-6-2bbb864acf93@iotcl.com>
	(Toon Claes's message of "Mon, 31 Aug 2026 17:18:46 +0200")
References: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
	<20260831-toon-speed-up-last-modified-v3-6-2bbb864acf93@iotcl.com>
Date: Mon, 31 Aug 2026 21:19:21 -0700
Message-ID: <xmqq8q5lvc1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
> index df73c7d0d0..75b18ee83b 100755
> --- a/t/t8020-last-modified.sh
> +++ b/t/t8020-last-modified.sh
> @@ -290,6 +290,32 @@ test_expect_success 'last-modified with Bloom filters and --show-trees' '
>  	)
>  '
>  
> +test_expect_success 'last-modified with Bloom filters and top-level wildcard' '
> ...
> +		GIT_TRACE2_PERF="$(pwd)/off.perf" \
> +			git -c core.commitGraph=false last-modified -r HEAD \
> +			-- "*.c" >expect &&
> +		test_grep "data .* bloom_queries:0$" off.perf &&

Ah, OK.  With GIT_TEST_COMMIT_GRAPH=1 exported from the test harness
environment, 'git -c core.commitGraph=false' would not be effective
here.  You would need to do something like:

		GIT_TEST_COMMIT_GRAPH=0 GIT_TRACE2_PERF="$(pwd)/off.perf" \
			git -c core.commitGraph=false last-modified -r HEAD \
			-- "*.c" >expect &&

> +		GIT_TRACE2_PERF="$(pwd)/on.perf" \
> +			git -c core.commitGraph=true last-modified -r HEAD \
> +			-- "*.c" >actual &&

And in the case where GIT_TEST_COMMIT_GRAPH=0 comes from the
environment, you might want to be explicit about setting the
variable here as well.
