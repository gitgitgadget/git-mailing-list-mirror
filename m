Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E252280CD2
	for <git@vger.kernel.org>; Mon, 11 May 2026 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483165; cv=none; b=K/4TCAGwYssjPBT+hxeY3wWwhRO8qnbhwcKlrxDcu3jqJp3peUzABzr+Em7DqcNz4teBkuPCKLjT7s1e0W4WrdJ17AhuASWvGn47Pxrl/NJ3RSiVLRgl6x6Nq/z+WndObduIrc7WhqQMbShBe+ew0W9D0YLwvEoKMt6eBJHmU9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483165; c=relaxed/simple;
	bh=amY+/6HB4OVGCzd0WQGJorz1jE/+ZPwIYc04/uJBixk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGs6B4ei9jspU8QWBj7LfE/WcUdtxusiGYmYEPDg92Tdkf0o4LTCI2rwn0vUsYmQdVtCtrFU+5DpOmCz3Z7PF42nqpkv+cSNHWskxh1oCaeSTqETUPya12m5uCKa2Z78p3+PaBbnXFC1J6n0FISZyRNFKKg3Ln+9FVHAlxZ8rjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VEVnN8wm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hIL8W8Sf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VEVnN8wm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hIL8W8Sf"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id CA96FEC0109;
	Mon, 11 May 2026 03:06:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 11 May 2026 03:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778483162; x=1778569562; bh=nKzg9Rk87e
	eZomCROdbRAx+COw4L5jYffZGge/LwciU=; b=VEVnN8wmdCiJv/pikT+VLYYU+w
	gcXdvWkVKXdFZsTpZFdKroxCBc6i3jm1QepvsP0SdQA2vd+ls4197FKhmjdrgdj5
	qkMJiDrMq3ZafwciHGfPEz22sYUHbjdOPu6tboyq2V3kXaR2CxSfY2Pmk+7uqs6y
	mqSUIJkBKBBqJpazK5V6D7BzHgp3rYtuQVP8YP3EXnW8NVeP3IILBi4Cf42y4b7e
	RrTH9OLpfcVd2q04AFsm4XTIdlmyHPJAQCipfhYgnBnFOfWqD2+gI4y5xJtoHdor
	b7rFYihfEfr4+Z/aw8k6Vk+5AsZNBR7dxSfyhuFvfKq3gDc1SwNEFOB76Zvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778483162; x=1778569562; bh=nKzg9Rk87eeZomCROdbRAx+COw4L5jYffZG
	ge/LwciU=; b=hIL8W8SfuoXRn+kitjjDVOhYku7Ia8MuWFsNjns7DYdYgleKRlS
	4jZpUO8tp7vCfKGq3Q0EbTh7RnlmIMwBtOXsfrNsQTMdvoH+OqOBD7kT5UR3spfA
	j3vh7t8ClDjQqkq+Ly8NvdYFcbLedN2JC6685YqtBy+gISEZIgGGje1w3M4/Um6o
	F/oiYRgPsA/+qhlPmmd1WohkdOXL7ZCtdZw6R0tM28RhUJf0WQO+Jh55j0vjrtNP
	nS+YgAHnMoXl2VVsG/Ncma5lmMzoIQkNfiD1TpQeXWuo+I34F/lP8Pm760tQFXNs
	qJqEmcRq7aySFEjTO0/dfLLMKe03FEqlD/A==
X-ME-Sender: <xms:2n8BamIL0XCSbZvunVsNGfED2uf0fGE5HsgnwOb-wuN-8kuG3j3-rA>
    <xme:2n8BagbpYVL1w1Eyl9Q5woum_-AK2ZhYQwqrfkXesC9B1IvrujhFn-EZ5mUjZhSQ9
    raOpk5c-8mDu-DkkfdeMxkTkNkjhSMklGS0ar9taQ7PIlrsl7uQTg>
X-ME-Received: <xmr:2n8Bao931_vGxu2uPRTgy60uN8Y_Vz2oLzMcHClluyApXeK2wf8K1uNnQmFZLLAWFY8x9ak1h6KIHNpVPsjIlMzyd6yg5x1cITQDVNFn5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtsghovghgihesfigvsgdrug
    gv
X-ME-Proxy: <xmx:2n8BahbQq5iESO1ecpvpPUFI9zOP2XByOGKbYp6xgTE75vyzne8u9Q>
    <xmx:2n8BasMxGI5jIRj6wqe-7EBjtc4wcl0Xgc9PQ1YqjekumAvicNSf3Q>
    <xmx:2n8BatDBE4m9it2Nvj77epuUMLawmEIPqKjSlhT3H8YMTMdAUVyDUw>
    <xmx:2n8BajLBJJ1okF9N8ZxDohMIp-P0oVS45XstvYsZcaTstIQoB1tRTA>
    <xmx:2n8BapmZWSiEVnKxf_5uIKJ_4b-eCo1_rPR33edJ3Tay122Hgi2XlvXO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 03:06:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ea192c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 07:05:58 +0000 (UTC)
Date: Mon, 11 May 2026 09:05:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: enable EXPENSIVE for contributor builds
Message-ID: <agF_0x0yq78J-RFk@pks.im>
References: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
 <pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
 <2159f6a271b06d156134392ce3c44fe957c83378.1778228209.git.gitgitgadget@gmail.com>
 <xmqqjyta9630.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjyta9630.fsf@gitster.g>

On Mon, May 11, 2026 at 08:51:15AM +0900, Junio C Hamano wrote:
> diff --git a/ci/lib.sh b/ci/lib.sh
> index a671994bdf..4ca3ecef2c 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -314,11 +314,13 @@ export DEFAULT_TEST_TARGET=prove
>  export GIT_TEST_CLONE_2GB=true
>  export SKIP_DASHED_BUILT_INS=YesPlease
>  
> -# Enable expensive tests on push builds to integration branches, but
> -# not on PR builds where the extra time is not justified for every
> -# iteration.
> +# In order to give maximum test coverage to contributor builds,
> +# preferrably even before the changes consume public review bandwidth,
> +# enable "expensive" tests for PR events.
> +# In order to catch bugs introduced at integration time by mismerges,
> +# enable the long tests for pushes to the integration branches as well.
>  case "$GITHUB_EVENT_NAME,$CI_BRANCH" in
> -push,*next*|push,*master*|push,*main*|push,*maint*)
> +pull_request,*|push,*next*|push,*master*|push,*main*|push,*maint*)
>  	export GIT_TEST_LONG=YesPlease
>  	;;
>  esac

So with this change we now run the tests for all "official" branches,
and on pull requests. Which raises the question: are there any events
that happen regularly that are excluded by this? Because if not I think
it might be sensible to just enable this unconditionally, also because
that would make jobs on GitLab CI run expensive tests, as well.

Patrick
