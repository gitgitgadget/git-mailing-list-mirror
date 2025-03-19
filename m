Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7D4257420
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391369; cv=none; b=u89R7mK5YPSKzXBI1MDqVTTpYOjF6mEKmI+MyIPwr9puK4Df7v8aeaArTadIgSxpM0xmseCIX9+wd9uujOnL+53psA/4thGNgMqdF8/Ne1rdXYEgLpNcZEYYa5VNPIeyihgFxNaUTivToTJA3/Gc73yN0rsJ5b1b+wmfQ+aE+UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391369; c=relaxed/simple;
	bh=lvTwKXXvvNIqO9m3Dm7ZrKJidYEmXex252/rZCAZKoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HALJojRmrNM38jV5ZLGLkB+fs+uWGpp311yZD11bsPt/J/pQNkmOTPS9BNlAnz+dxmm8wUg3OK1EXyhiEjqTh71CUID2FcjrnyM8QFEASKuaFpOwFG+wC7a1vv0zUVrNiOsz1VU39Q3gM79CqB+ihXiyW0yKBLSjBZJXSTLXzb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=juyUkGgC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5NgqrtF+; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="juyUkGgC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5NgqrtF+"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 50F94114018E;
	Wed, 19 Mar 2025 09:36:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 19 Mar 2025 09:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742391366; x=1742477766; bh=aqE8+6sA1r
	p9S7Z73U/VyTG1Lx7ujaIwFdupivf8a4s=; b=juyUkGgCD3mdi88i2NsT1E/ZfQ
	Qy4SL2PSoWNfIym2CyBYprYT4a/s/P61h0WM63NdPwR2TcvxnDwLY0FBMRcwdnFY
	wC+/2gedqQ4DoLIYG1LBRJyh9BTP/3PJ/8TaKjx/8Db04DKIY7Lfo4W1i9ZSO+Tf
	2ZkSsdU3em+2bao6sCCy9EICY5RsdWwokO3PpLVHDxvxn38zMdP++g2ZbTRWL/0I
	VLrDN3YaD3uKtIk6u1H+AcCk46TP2sAkjiH6yzrb3dXUqr88WMq3l2DOxS2wM/Yq
	1lXTwKVn+01z+by31pOlAOuEbKeKoba2lXFjlM4+8QNK5cxel4WcDn/jPBzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742391366; x=1742477766; bh=aqE8+6sA1rp9S7Z73U/VyTG1Lx7ujaIwFdu
	pivf8a4s=; b=5NgqrtF+5hrzbw38lh0sBZ5S/pA1qvvZe/kbimn0bbk0pwK28XR
	vRthfgI+WHnNnviIf78LrCvFx6tPbDtmkVIEx5LlYSdlLHfpob2gRUxUM6B5ifLZ
	B1ynfrcq4iWgCY/KAPwAFjCOxREmA/YiTSrzPZrVmVIbZIsrdwEvcjTF3JEC/9eG
	8PM+kWKEHwcKeRbMnZg9LH9l+Al6Y5lh4oo9a0dN14VkQiDsT6OR7o5kfMXKqcT3
	BnHtLMfE3KqnZwNsKDh1FFhypXTxdINKGTYf5ulK4ZroLkRjZIkkrjLtlFyDQCVo
	lL4+4i2DvFH0vc0XQkV0ozX75tzdnMGiEPg==
X-ME-Sender: <xms:RcjaZwqBmZ2rzCwKw8RjClzME8vg3Rcpo5_43KHIYGuA00Z8Yp-v2Q>
    <xme:RcjaZ2oJee3BUIAyRcJ8Ciu0Y4P53VdlHZ66UiiAN_VUQY4rpXDJT87Pqv9J0gYjM
    qbFL69RtM3tL9kFcA>
X-ME-Received: <xmr:RcjaZ1OWFmziB4L4hSRcOoW7vszR1NZbTRoU0ljiKoDpe4BIT2lIyMmKZaaHU0jnEzMv5NEtHgX841wniblA20-TGcVWxB5pKuD8D9W8-uquZQmUGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveffueffudffkedugeelgefggfdtvdfggfdufedt
    ueejtdehvefgfedtfedvleeunecuffhomhgrihhnpehtgihtrdhinhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghmsh
    grhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtseguihhnfihoohguih
    gvrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RcjaZ37_EyROZX1TR1CUMdp-LiNKyckjGfr6NbWBhywdsystnTPhlQ>
    <xmx:RcjaZ_7AelzHrZuFIXnolwiB-qUloEt5s9SWNjCEv-pb7XEamMF6ag>
    <xmx:RcjaZ3j8tljoGjUoOSIGHmm3nDbI4wwi_J3HWflkyKUj0NbHAo-8Tg>
    <xmx:RcjaZ57g-m1IUQHF9YRH3zPEjQGJSZ345kQAvggq2TDMv_-X9qNyIw>
    <xmx:RsjaZy2loOwB4hLxLRNWuHDDXZPiLZ9srACHb84AMK-hbW0jRNFLWJam>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 09:36:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 04dc392d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 13:36:03 +0000 (UTC)
Date: Wed, 19 Mar 2025 14:36:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH 03/12] meson.build: only set build variables for
 non-default values
Message-ID: <Z9rIQlUtutWPiPgD@pks.im>
References: <5d0112ae-98b5-46f2-91ad-35ed11358c3e@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d0112ae-98b5-46f2-91ad-35ed11358c3e@ramsayjones.plus.com>

On Sat, Mar 15, 2025 at 02:46:59AM +0000, Ramsay Jones wrote:
> 
> Some preprocessor -Defines have defaults sets in the source code when
> they have not been provided to the C compiler. In this case, there is
> no need to pass them on the command-line, unless the build requires a
> non-standard value.
> 
> The build variables for DEFAULT_EDITOR, DEFAULT_HELP_FORMAT along with
> DEFAULT_PAGER have appropriate defaults ('vi', 'man' and 'less') set in
> the code. Add the preprocessor -Defines to the 'libgit_c_args' only if
> the values set with the corresponding 'options' are different to these
> standard values.

Hm. Does this really change anything though? The behaviour before and
after this patch are exactly the same as far as I understand, and by
explicitly handling the defaults we basically have to hard-code more
assumptions. So in the current form I don't see that this patch adds
much.

What we _could_ be doing is to completely drop the default values in
"meson_options.txt". In that case we could instead compare whether we
saw the empty string, which allows us to stop encoding the default vaule
both in "meson_options.txt" and in "editor.c".

Patrick
