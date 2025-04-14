Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7234D258CF6
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617303; cv=none; b=hr3ZoSki8EswOa0hAR8FSq5+4yG+FNUD2z/Fq5zbSV/lvnTndxclLLQ2hRu0NcxgWspIJg5xkBKdhpOgnwfig16lp7XEmJcg+3YQa7EFig/fVaEOYfuUPc07n7qKjbLOh5pOVdIFUYhl7Spk/+z8Ey2ua8V9thhF+WIrATbdjSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617303; c=relaxed/simple;
	bh=9nWejUIg8uqF2pT4yEU2aXvnNzr/rCV01YXWhn+E3JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpvg/5jo9te1JnroR7v8BpoDPpQW41XnECf2Rhj/WKpI+e+G5JdZCyGXSTGqd+zS5jFMGS0Zu5eLcP3QhkjyOK1r9TdJ19qF8AWN1yqMXtUy6yKR2kZOtSYy7WkUsm+B7GeG8YFMJNEISD7qGjPhiCm5vSca1hkeectSprAhE9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KpYlnnhu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wp1CBb95; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KpYlnnhu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wp1CBb95"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 90B2A114014D;
	Mon, 14 Apr 2025 03:55:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 14 Apr 2025 03:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744617300; x=1744703700; bh=9nWejUIg8u
	qF2pT4yEU2aXvnNzr/rCV01YXWhn+E3JM=; b=KpYlnnhutzYMEE0jOyHPL9Dv80
	lepzi4quzEt/NtWtI18quP1cfymejz9wUq5iz8pNULiG6uZozFXwQEdYZWEqwZlu
	KvS4G+/bFloBUfPiw44xleA22fXnZqIcgBW/+vYTXqzah7T5gnY3hd9c6iyeVIUw
	4cZjFx548a44j2nAnB+MCs/AyY5/I+geqDMdmkgeA9rr2d4HoCSzfHHy5k13O3ic
	24GPGXs+eNlixpAEdt8R9KWwi9/c1P0a3rvcnBaiX/oyRF9SPcPHGaU2Z5zeGbeY
	6ALGWb6pLo4+ePm0kkFeUVRNmqpfdRK8wCEoWwh7gJXac+4BviLx3PWhEGfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744617300; x=1744703700; bh=9nWejUIg8uqF2pT4yEU2aXvnNzr/rCV01YX
	Whn+E3JM=; b=Wp1CBb9552NSk+UuvMO233Jdc05rl7cA/2s+X8iZQluhnCRlWlE
	cEGOCe8spIxPqlHHdZhtYJwGJe1bs+jXxLfevv+gYd1PpAXmc9mswK4YpTi2Bw5m
	VqA/I8l/dHx0+DzPfCy4mVHyMjSe1hooafGwrZ2J/RAu1g5cUCXjkNnwCsqpCzo4
	Jkj58nWkfOxsgYxF8cxqAU637QPiYxppdgAJ0+uiBY5wBmCd2GJIWA1K/Ua8Mh4B
	J/kqYTJmzJBMdgAOtf4ZHVrZadqrxcoGMiCLAQF6x3mfIu4dX0EN9P352kAYGbus
	ImfolE/OBhUbvzp7wOJJa0d/m4pp6kk/gmA==
X-ME-Sender: <xms:VL_8Z-fDCLwCpd7aH9p4EYIKmi5WuUigIV3L_eIjN_0wHFKnhXgqxA>
    <xme:VL_8Z4MPpyJQTxQl9jw_OhqrDqm538PciokW5wXfZdONT9OJ-6NPxe4GgPt2FClRU
    FR_rPF72Ol4ggaX6w>
X-ME-Received: <xmr:VL_8Z_ikNbexBRS93hlthy8uRjCrlQsU6aOlN_aEEbbwW_fENjF5MCkVoenvWijnvRHSYT4b1_tGt4-5PhtWm-cm43iHmJXWL_gZrGOdAzbv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddttddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesughinhifohhoughivgdrohhrghdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VL_8Z795kZ1wybhTUXUw3x8ZrsCkYFdldKGH9VpJQgi_s8Bifk2L8w>
    <xmx:VL_8Z6s0quS1Fe3CT2uP4CAWADAzt1iQU4AAe9LpmmSv3_dlk3lcpg>
    <xmx:VL_8ZyGrVKCcwC23tqLqh48_2li2tH45wK8TaL8BDi9OYKAK7KSzoA>
    <xmx:VL_8Z5MU1ijHSb-11pqOfvyCbJxTRgevWsXvvAx4gx3E6IegspUerA>
    <xmx:VL_8ZwFUoO_RLHscZIvmLVUMb70FMwJ0yQDms0Sxa_6xKcYYsf1PqVSC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 03:54:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ead2e962 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Apr 2025 07:54:58 +0000 (UTC)
Date: Mon, 14 Apr 2025 09:54:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH v2 04/13] meson.build: set default help format to html on
 windows
Message-ID: <Z_y_UWhY2RK3nBMm@pks.im>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <34349bf98c5b01dd1b73065448b616517bb784a3.1743859985.git.ramsay@ramsayjones.plus.com>
 <94a3083c-fcc5-4489-8612-c15fa781c0f9@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94a3083c-fcc5-4489-8612-c15fa781c0f9@ramsayjones.plus.com>

On Sun, Apr 06, 2025 at 09:16:58PM +0100, Ramsay Jones wrote:
> [Just a note that the make build includes 'info' as a choice, but Patrick
> made the decision earlier to drop that for the meson build. Also, there is
> a 'pdf' make target (I think that made it once, years ago ...)]

Yeah, I just didn't find any distros where either of these were
installed at all, so I didn't bother porting them over. Which doesn't
mean that it has to stay this way if there actually are any users, but
this might also be a good opportunity to gauge interest in some of the
more esoteric parts of our build infra and potentially drop them if
nobody complains.

Patrick
