Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DAC389472
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783982931; cv=none; b=teZ4aaKbHTemyK6FQReJSpXXvSiXrqfQuODjjEus4FqcfdXjXM1UYdHF7vlgUzQsu+KRmxEj+FWlHBp8T4VNuVmaOMLDZlbRNe4JugdU+y6hggNS0GQGjrnjYV1SXUvfTAyLalMBdm+0TPYp8aT72hL9r4mFLD8LUWhEPLwUWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783982931; c=relaxed/simple;
	bh=VaaWyzTd8qmooKREBJyISqzu4Vu3r9IXwjIPbaECaX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X0Dc6TcccMq4y2E0wfP6hfJmUQ4pM4C26e/fWSWw7z/Fiqsh0y75PigaxayVWgyKfxJyHJAc4MyjHLdkp49EJxp/VQ+GsVdE2ltpLh3q/zlGi80//nzcPo/toP1g3YT/x+EwaiogIyr0jzulOpjJEYiRhawK2nOKgZ1ZraAmqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v3IWEHkX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KPOFxwRM; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v3IWEHkX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KPOFxwRM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0EC701D000AA;
	Mon, 13 Jul 2026 18:48:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jul 2026 18:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783982928; x=1784069328; bh=p4DxrM1JuY
	JG+/+PCHJd6QVkMkPbws4tANs1kfJZtLU=; b=v3IWEHkX9Ke14+00SYcRe+FVgk
	XIP9fAbR3baaUiczAbCtB+VRnVPxhXuWAbnugm9VzKVH2jt7AxLwMEcqJVe2xXx9
	kFSyi+ZRhBDB9oMaF+0MEObkgz3v36yKynTANMsTyinGpRTWydKpI4+Rs/3lIAWa
	PMCVpbU1eREHym+4TEw5ss0rAVgOWhy1X2ra+WHvBL2kbV8Yd4Fgzt1Hr9qnpzmu
	hY3cTFXB9nZXZ4Zex1k0RDz5wa4ZoQjLPyLVUAhq9vxNoHgWTpJssiUGum93JZiM
	1scKOd75hxVav820ooUCkE8H7AcfSi5NyMddQ6rLFeN0BljdhSxcJswrBMiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783982928; x=1784069328; bh=p4DxrM1JuYJG+/+PCHJd6QVkMkPbws4tANs
	1kfJZtLU=; b=KPOFxwRM/wX0Y2vUaCuFM70w+qwLOevnpo0UcQqHJVKHDGsJM65
	+OLGTF3sze/Gq5EtslRCCc39UYxHZl6MhTUGGuJUOCjKJ83qzFlkCiUHkJ7nKQ9B
	XOZ94m4ekbTF+IR6MxdrFXhr7VWtbE2MYHqaVDw5+NFPrEkrKjdomds479W/deSx
	G1OgpObGr4eTXHfI8mKARv4M0HtNS3hVKNsI7MrDugf/tfrP4+8ng7us4AA44eB3
	ZEbVFxLkYMtBgMo+oB3BYgAvCDFZzR3UDOnvEz7+pFyf9FfLEYnoGFh6JsnDpkCN
	LObtl7agshyx5Y427kP8cvtv42BB4UyeeeA==
X-ME-Sender: <xms:UGtValsvXbx7N50qTUwvXuAVKLJubOpz1CUDo-hMcw9v8Rq4csSzHA>
    <xme:UGtVahDM0LD0XAuUmISX4txk5M5yB47OxRvrC1rPNT8mNNC4t6aLc1nJO71s3m8MW
    tjDsXk3AVPBgJnyYoC4i7EN8CormH4StosDbEzIzWuvBWvfI-Y0Qjc>
X-ME-Received: <xmr:UGtVasYXG2Yj_vLn7HmPPY5Q-8n-CPOh_OXOn1_299ccZZspasnH9TRSLe2hMHS-OH8bxwFtOpfRM_fse2dxeLsTuokoUVtZbaDqBic>
X-ME-Proxy-Cause: dmFkZTFCetwcXAhQHsSn6dhbgm7DyLhwk7e9MAhHq5TRk4bgcz/6sSOsoGCqcTs+ViAEtd
    Tg51rX4hi39izXQX+XaUYXh3F1TV19rsQaxRHowLgHvWaC7uTWS1BPoQ1u8UWcpaL3fxqb
    rf5cEXKbuut8KF6GqYX+sL4Bz5nlGV13egpoudOBSNAoIPB/1k1Vi6ghgdpP1nj9CJB9ii
    JZkLj21qi+K8K1oRz76WtDM5IVffacPg9pFHsdpcxPnLQfS9mdUQMI5X46wiLzoxI6QbfZ
    I/xY7OYW/0tut6/o+XcRgUHsuaq/G6idRmZYvm30TL8hhBX6C3Au+63fTOChwCoNC9R9G1
    RLlX0iqSf05QCVpuMXtnyIZkXP7eEOP8Bgb5u3ieWEfgMf17/qEEsn+YhzK2J6a8woehUb
    Ajy7K10VDLv5xHO+c3/yxM+2clquNS82kWerFlcnGz9p+ftTT6j0q3K+RyPfTCMuzFodpA
    LiENPhUAvoD7aasGWEc/ng1aZrgSfoARlf03CkDB4AYutzBu8TLwxLGOIBMeHBS1eGVOLA
    GvlyFALLonF6ERHLpB8WjSIUm750QGddbkqAeiIPl/MgzbESrZIqtnIqGFYpPha486IZRB
    O3Ou+/FKKrw0YKQ1rXvDjL0+HHV2v+KsqBpVxPDB3cpbgpYKmMcg4b8JxGaQ
X-ME-Proxy: <xmx:UGtVasW4-Xwtt56BhQl8bF2EB2VfozT6ogBEHSwmQ2jJZJgzl-4iDw>
    <xmx:UGtVarPZcD-vPPsxeYqOfoFLLFEaq54Vw5D_OiGM1fJEjGVpyBl1xA>
    <xmx:UGtVamY5SWP7fR7cCReDOi6YDaKY1LXmfJAq8--bPTlywQhUXzuVow>
    <xmx:UGtVaq8QzjacMO0QFM34f6Lzk37PdA2rBOKsZ37Xd4MISm74mWDKvg>
    <xmx:UGtVapi9IL6UgWDnk-9yu2tAXQ8w35hpVI8nFaK3MeGWrju19GTzZGs4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 18:48:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 0/2] packfile URIs: support concurrent downloads
In-Reply-To: <alVn7UWvdWRAG-Vv@com-76773> (Ted Nyman's message of "Mon, 13 Jul
	2026 15:34:21 -0700")
References: <alVn7UWvdWRAG-Vv@com-76773>
Date: Mon, 13 Jul 2026 15:48:46 -0700
Message-ID: <xmqq4ii2wlo1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ted Nyman <tnyman@openai.com> writes:

> Packfile URI downloads currently stage a pack at
> objects/pack/pack-<hash>.pack.temp. Two Git processes fetching the same
> pack into one object database can append to that file concurrently,
> which can corrupt the temporary pack or cause a resume request at EOF.
>
> The first patch gives each direct packfile URI download a private
> temporary file. Ordinary dumb HTTP pack requests retain their existing
> resumable staging behavior. A later packfile URI retry starts a new
> download.
>
> The second patch handles the related .keep race. When another process
> has already created the keep file, index-pack reports "pack<TAB><hash>"
> instead of "keep<TAB><hash>". Accept both successful forms and remove
> only keep files created by the current process.
>
> Each patch adds a regression test for its respective race.
>
> Ted Nyman (2):
>   http: use unique tempfiles for packfile URI downloads
>   fetch-pack: accept "pack" output for packfile URIs

This cover letter has

    Message-ID: <alVn7UWvdWRAG-Vv@com-76773>

but in the header of [PATCH 1/2] has

    Message-ID: <alVn-QmK3K91_tkH@com-76773>
    References: <cover.1783982021.git.tnyman@openai.com>
    In-Reply-To: <cover.1783982021.git.tnyman@openai.com>

Similarly, [PATCH 2/2] has

    Message-ID: <alVoA5-fDDPwKPZZ@com-76773>
    References: <cover.1783982021.git.tnyman@openai.com>
    In-Reply-To: <cover.1783982021.git.tnyman@openai.com>

And "b4 am" seems to be having problem grabbing the patchset X-<.

