Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190BD479861
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240109; cv=none; b=A2tLB/NntmLMNv0PrtZNNw1OaAeVzUZVUfA2InQcnU/YoaOs5qkZ4BfZsVRctVtxLqQq2ciMTCi/EsIeWmkQH8yQyqr4c2dkmvnhsZvIn8VHHTEhYh84mXjkcYzUbBcfKDYisNLiQmcnnuBq8uMzV/wzoSPI2t7YSKeYcZj142Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240109; c=relaxed/simple;
	bh=oD9O3ngmIpdVKOLVGXIQTKk2bhobbOIvDgk51GLqQI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T2ehYKCwPcoakfqDkZbPGxB3VaMTDgBz6xI3XHd3CLuVD7Pl8mePhv+QyUz74GG/E1nrkAto4QUqct1JLntXit7qnnMesj1/hfhBBfJyH57EXLN4aowiAkWtJZXC0JZdqWUyn70rI4/TVHjXpLmgoPN9QBdSxUL3dDltqtCRHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EIMxbH63; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GQTCXVcf; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EIMxbH63";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GQTCXVcf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 23B2B7A0155;
	Thu, 20 Aug 2026 11:35:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 20 Aug 2026 11:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787240106; x=1787326506; bh=x813bnY7gi
	IPlkJa42UZwT/NKzvrS5Q4P6C16Y15WmM=; b=EIMxbH63Ev/d177+SDa3yESyg0
	TIX8uE+nVoS5yruCHebhMRUXypy8+yJcwv6NusxKzE7oaVyMVecbnSCyybMp7hcg
	L5IdN0n/I49y6rx5pOtwE1K4gNS3OsjWLTQXv1zNTxMOeQZ0QWfuE+dd6ob6N17R
	kCUJGEJtpo4u6LqDBFuNgVahFDJvoW7qjf/iQN3Iczhzl08A71HvLL8+COlG2NEE
	PQqSZETIAihhV/ZobKY8ociL5NvlX0uz/YqIX6CkAepWnT2sAX3d9Ra39XPJx1EP
	cSqMe3DbVI3evrarV2sBHw9zhwU4LMnY/qthAOXFQYHOXjyb9KYtlqm64IPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787240106; x=1787326506; bh=x813bnY7giIPlkJa42UZwT/NKzvrS5Q4P6C
	16Y15WmM=; b=GQTCXVcf2GJbHCIOw++PRIAE8uWj7zTxGNEWMzaQpuprd2n7prG
	R3zU195fSMyG6lkKabDtMHQdb3Mdm26Hy3gfe82m1Br6YguVp2guBVevVFAUjO6s
	DAj3fsoUcsjlqAquKx7ylEvk3K11lA5dMevre3nVVuZCuaZFvJ8wF20+d4LMbIyV
	DnMMYcRPPS9amlev7OFZn5xzsusVkD89ZJCNnh0WmOOzZ7VKUk2XX5uIUxyhA1az
	1bOQkodfCckbFiHYA3kARfoT56ACRAnnRjb4RDKAU3BHIT8PDbzY5pSWoT0t5Wt3
	qBVuTYt0vi6sRIK+FH82/5JJnXHzE38jyxg==
X-ME-Sender: <xms:qh6Hamn7Tw1QhQk5zgVqLbcCxQubIok_BceSA9B0OEud_iIiYi5CLw>
    <xme:qh6HaktI53TAvvAd_tpQVjlIXZH-9xFmJRU2cwXvrugBuvBHgiDp4u2iqh40yo8PY
    Vdf3TbFR3b0yOLyn_ZuIRePsktaO0oz85xvsMAABEeDMlwgzrTFofA>
X-ME-Received: <xmr:qh6Has-8o-NpiTGOcFJH2zkFrZuIIGr4dILcAMm-ZV0WHCUzvzYMf-hOXegz399tS1umsZg9a6xCIcy7wRk2mE9oZctM2TiyKw>
X-ME-Proxy-Cause: dmFkZTGvvf5qtEaicqmbt7zEAsVE+uQsJFUvpiD8ek45WvaDapmbE2aH2rHOTEU2zhORt6
    5Hjx/ZBWTeLCZVItAxCHMMYf8Tud6jzYn+vhaWYD7EOdches4863seVdJo5ofEUJYoob7p
    rqM24RnW4OzIakJq8XiSG/Kg83Owoyxsyv1rCuCmDXjjTb3WsapZXtxPOdCtSQ56pOxZ8r
    CG9gKhOLm4ueBn5TFMsgmqba3QEy7FKiukPyL4h7bwii3h/7yo6aN+MGy1vbRbqpyUfc3X
    kkG3yo1hCaHVZKm4IFA7WIjxfOTiOtUjONueRZN/jugl5sVgSzb4JBdWuc3+054d31ZQjF
    VHvRbVukoNyczRW+ALuABHZAinabwQhBndFk26UMj/lzE1chdTIGrzuDyWomX+9GPENjRK
    WHS7/9HM3htgf/ElmYP5rfSvAgu4dJ07np2fjGTTbzxxy3x8Q7f1ACXMCYxQ1iul0dqMyM
    97XoMWzUJCbEZM+m5npH14s9s7hZ01Oy0CHZzifUuM2rzq7OVzHEtudQuRaSEWD9Qmf7g+
    YJ0WEf3Zg2x0zjGrFWHkcmAeWeC8UlMYdo6pc29bJ5AzdJYQDTgYCJ5FlAgDW0zLka99UF
    d6a1kFySLDo0mFH2MSgdgdMaj9JU3NkvihSa/hwzTMfdtOVG6yJzOOUSU2PA
X-ME-Proxy: <xmx:qh6HamOIzh61HPii6qC3CrvycfwsG9qfSgribp4p_1PKS9eHpels8g>
    <xmx:qh6HaiHB0nbxQDZKe40SeFsCHOOlruQDYQnbUQMi8RJXBitSnAalqA>
    <xmx:qh6HasQ6qJ2qvRimqOo0S9Z_aLlM-TDZeYuvtWBL0kfUx63C4_Nn7Q>
    <xmx:qh6HantlVsAd8DJ2xC0yjjEPoUszrbsPiIlA8OItIC5Q-9eBu8gy6w>
    <xmx:qh6Haov9Z-04Ty8awdwNzR9XW2YaxIJBs9CcfnBL0lEMwBOteGeIo2nU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 11:35:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  friel@openai.com,  git@vger.kernel.org
Subject: Re: [PATCH v2] pack-objects: trace pack bytes written
In-Reply-To: <20260820082102.GA2973952@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 20 Aug 2026 04:21:02 -0400")
References: <20260817233914.8740-2-friel@openai.com>
	<xmqqo6f02q2f.fsf@gitster.g>
	<c6a8cdac36d2202055d637ebcc97e484122cdcd4.1787158152.git.friel@openai.com>
	<aoaTjWMSO8og_iFw@pks.im>
	<20260820082102.GA2973952@coredump.intra.peff.net>
Date: Thu, 20 Aug 2026 08:35:04 -0700
Message-ID: <xmqq4igou7o7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 4a5fcbe5f5..0fdff72f41 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1413,9 +1413,9 @@ static void write_pack_file(void)
>  			 * If we wrote the wrong number of entries in the
>  			 * header, rewrite it like in fast-import.
>  			 */
> -
> +			const struct git_hash_algo *algo = f->algop;
>  			int fd = finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK, 0);
> -			fixup_pack_header_footer(the_hash_algo, fd, hash,
> +			fixup_pack_header_footer(algo, fd, hash,
>  						 pack_tmp_name, nr_written,
>  						 hash, offset);
>  			close(fd);
>
> ...
> But fixup_pack_header_footer() actually recomputes the hash (as it must
> if we tweak the header). Right now it does it using the "normal"
> variant, but we should be able to use the unsafe one (which my diff
> snippet above would start to do).

I am amused.  This is an interesting find.

Thanks.

