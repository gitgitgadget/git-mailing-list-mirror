Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2E1B4138
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773265860; cv=none; b=j2cDxIPotpmffxfbsoZ2oNemu+0pPrDe4IIY7IyiUt1lekbcqRIIWQqM9o4Cgti979vzBgMYtcRb7VEC6ZI2ZWl6nTF4z9yM/xAW+9Uhyc2KUdjlI1OjmHDbrBmi+Ts3AthR5o+Qc4m3L3/o8xDduRu43577L5E2EKOV4BtrhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773265860; c=relaxed/simple;
	bh=bUkwcVe3zQwZqRbm+cdgqQmwCEnoWEcHZDFM2/IJdts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rs434tVH2S+BubDiU68Mm6H2JQFwzPkFJLoW9Oy3blxoZiD0k9gAvZqMMOp1lf3O7VMIYxi9igk2sD6UXUpCO73AcH4AAaG0OiKVu6m32zH68K70ET68KJhIt+MtjYQNPN09OFscXIxUGzYXbOSFni3ZmlplvjrjlO4iUqlsQBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gXkndndd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i4QT9qIa; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gXkndndd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i4QT9qIa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D8337A01D6;
	Wed, 11 Mar 2026 17:50:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 11 Mar 2026 17:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773265858; x=1773352258; bh=7/CJfQ5sxi
	Z6zEESITznHSYo4cwiQ6nP1aBzBeankyM=; b=gXkndnddTb3B+Rnj1cyGeyAALr
	mARSNMdtp6CLRf6God4GBXR6zjro3GJUqT0Q9Kr+M0RaWs20Dg5SLEoS01/HD6G7
	XPAHIkGx9baifbYbnoqhTgdSbWanJpp185uLxqdAtjiXnhjpFJx6Sd58Wf6od3XW
	t96bvdrYxFzE+rhTotPcw9gO27/GPBFwDuwNDDcBVODvY/J9w84zORFzZUhxRu93
	kfyRce9Qt/wCuumi8yKHwmxACs4AIWIvWStMWQtOm0cV6D0icvxjpILyxyuxNT9r
	2AMAlvYx7tmo8yJSRIEHefATYzSWTQjYWwaJwEYFe64UWSQva+58eg6SG4sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773265858; x=1773352258; bh=7/CJfQ5sxiZ6zEESITznHSYo4cwiQ6nP1aB
	zBeankyM=; b=i4QT9qIayrltsSTtvN1uZ2x0y9qke1XBckSDmGVwKdsoWyRzzLU
	nNoAncvi/nrg+6w5k2wtnbkHL97+ROpdOx/e0WFMdi7PEUxZIt8AdZxBGmOSu8fh
	d0OpID0OR1JAjlaxED+BSZiu9MQqtK9LqY2uVZSvVnNgP/mcX8vWgGffC9ju68J6
	TeR3h4K+3LDuj9uS4fx+VCNDckLUiLIRumCvyFw3MB51FcQWvYSYeKoYZy8bwW91
	20V1ZQG7P1eBpeKKg0lsIKoVOvKkqMQjz8TpQndw/ldkwHAjFx4k4NxXj1msaq2t
	gV1sY7uImrUV8fBCbs1AWHteRxFFKG5rXIA==
X-ME-Sender: <xms:wuOxaZzUguoY6733S8D1M6CQpFTKVMmXdvoDytj9V5XwR91D-96Z1g>
    <xme:wuOxab2OPN82t41jb0CIMtzkbJKlDe2h9ZWXm019HldGMVkT4xMG8tiYaHNv9pGxw
    nX90FJ3IVz98C0iIfp0hUJrycs5PoeLJS-FYVnCW-cNOnP7Z3ms-g>
X-ME-Received: <xmr:wuOxaW9pYHgdpAslRr-H03NAiKosr3nPaBvW3obQoteBhQjOlKdB4xe-s9tMazfscJ3MgN_xheYH57weSzk2evQdPUHUR4Vr3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthhtohepshiivggu
    vghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghmihhshhhhhhgrrggrrg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wuOxabpTp2HWx0OFoYXQCbI6rFpSN1pViKo6sX2dM27JmXviyo5nPg>
    <xmx:wuOxaQTyb-bQ4rL15mqdvw6t8BLdP4b7JUid55yjUpweckbSUs5vFA>
    <xmx:wuOxaeNZa1ZbCtQtzJgda0yL_GRQ4dqv7skFMenTYqa1gyLFTfnlvQ>
    <xmx:wuOxaegzwr56aEI8RP9_UfnSZV2PLvxp1HgnwbuxJS-4Zi9qSWjhFA>
    <xmx:wuOxaeuV_7pStl4I4EM64k07h3LHsP3MUuoTeuiHdufBXYGEsHPIPYr1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 17:50:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Amisha Chhajed <amishhhaaaa@gmail.com>,
  git@vger.kernel.org,  avarab@gmail.com,  peff@peff.net,  stolee@gmail.com
Subject: Re: [PATCH v4 1/1] help: cleanup the contruction of keys_uniq
In-Reply-To: <CAPig+cQ+HLjBjtGA9s_ZYYWNjRj_Bax5CkJFa98a-z=LoyEFoQ@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 11 Mar 2026 17:39:39 -0400")
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
	<20260228104654.80831-1-amishhhaaaa@gmail.com>
	<20260228104654.80831-2-amishhhaaaa@gmail.com>
	<xmqqwlzu43rh.fsf@gitster.g>
	<CAPvEtrf7gqyQYMcsii===kXY5Vut0EC_VsJ=xWUKNrq6YmA=nA@mail.gmail.com>
	<xmqqfr66m5qj.fsf@gitster.g>
	<CAPig+cQ+HLjBjtGA9s_ZYYWNjRj_Bax5CkJFa98a-z=LoyEFoQ@mail.gmail.com>
Date: Wed, 11 Mar 2026 14:50:56 -0700
Message-ID: <xmqqwlzikpbz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>>         sed \
>>                 -E -e "
>>                 ...
>>         " human |
>>         sort -u
>
> For what it's worth, line folding capability was added to
> check-non-portable-shell.pl by a0a630192d (t/check-non-portable-shell:
> detect "FOO=bar shell_func", 2018-07-13), so it does correctly detect
> the errant -E in this example.

Ah, thanks for correcting me.

But "sed -n -i -e '/.../p'" would not catch "-i", and that is not
all that unlikely, I suspect.
