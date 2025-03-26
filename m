Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638E19E97B
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978044; cv=none; b=Di/pggH1AaAqpDVPc0vJKWEe81JX4xAcWWjvKn5bH3l+InjKq5gecV6hvYy11moibGwuI/7QdnY9zbuqwMxsY4ArvsfQgJ/0RwLx/tZChjjrp+BCM/Nkj3pL/tQidi5Q2YT+q9g6q7OWKfPx4i/ctw9L0jfo/ufd6FvbDz2B67Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978044; c=relaxed/simple;
	bh=moP6b2+ilRlPRiy25QRlujeOj4BxiJWbzWddNPBPUWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQb/a51MDvIwd1DtLe7+KspEmui6uhd8kwyR0ECiIN14iBKwNceD/E9IvWvQ/GQv/cFnIY9CW+x/0lIsbbWhb5oMet1Bqu9kdFoBUjBDFps3LmNDODLwOPIAvnH3mZpzQzOSZtKoh/sSbEj1awjLXkaLxxdXTPeebDLC8+rlCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fxfYczu5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w8kVEQNS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fxfYczu5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w8kVEQNS"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D6E1313838FE;
	Wed, 26 Mar 2025 04:34:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 26 Mar 2025 04:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742978041; x=1743064441; bh=bwbpmNUX9h
	7ehC1FhKzfKEnUbTrTn+IO8w4qCRe524A=; b=fxfYczu5tUSdg6D5l0/6zj8XtN
	axmMVaL+Qv3sc/aBEusfpoNdUj9IthDpUfINoyyxYCWcVBVOziKTQjALSnn4uK1l
	zMu6/M5Zo7vN13sda05dGTjUv1et7d1tQjNyP/9hQFIIvr82V/z/eULkXayvvjg7
	SDsV+yReW2L7IgZAKgF0jE8jSSEBmTKRsf8+C9vAyAWB107QTeZ26oYpQ3dqtyiA
	kstXVZhAR++zhW78IOj87w77Hw8fBXiHHvj2JpqvNaBrq6sBC3oQ6aF1gNAP7x1B
	m8+W5OM7cQc2ERH7ODyi76TZky2T1/t2YH/osv7T7LFHBjKJT2IQWU/rHDzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742978041; x=1743064441; bh=bwbpmNUX9h7ehC1FhKzfKEnUbTrTn+IO8w4
	qCRe524A=; b=w8kVEQNSRj2QaR4A8R1WZJ/4iwXpRTtOgESF5tuCUCKm+dNxEFX
	iZ0P2RNWnQ3xV8CkOT/LHbADe3+EPIisFqG+csa4DUApMX7DctrwNrYl0HSplrzD
	/cXfgxMODdulWkOWc4iLXo50VvfGBiUcwQzl4lkdTvmeig37dG4hdDDQ3gXdYX7o
	C3Nv/HlSa8hx8qE6BldfsMFS9VruB7Xdsv5+SFTXiHZIc3XGG5puttDLg214o2HP
	56YYUFaSwi1ZNOibsyn1jRPYgGQAwm/J39zAV5bF42F3+jZ4poCuaor1zR2rtWuP
	3k8e5KK1jwUJ6/Il3s9bOHYJbOEl84fR9oA==
X-ME-Sender: <xms:-bvjZw-AibsnjTW-6xhLrskmyOH6m2IbkPGvkv2skMkj852MeYiqHg>
    <xme:-bvjZ4scY7rzZq8islfaSz-MEaqe_lgY48NtaRKyGEMC4Hrusk1UyfNU4RqzHtApe
    hy48sDb3etBz7i42A>
X-ME-Received: <xmr:-bvjZ2BhXDkU6MVxnPYqcYlqBwT2g5M3tUM5TQConKYx15LxPJeiLFY9Bp_d4yuO32xdsOZN0eNIiVKfYoTHZgGTOgEOXCzDQvcLLxuDlrFQ1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfffgffefudfhvdejudduieejtdffgfegvdekiefg
    keetveekgefhfeduueetvdehnecuffhomhgrihhnpehmvghsohhnsghuihhlugdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehphhhilhhiphhorghklhgvhiesihgvvgdrvghmrghilhdprhgtphhtthhopehg
    ihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:-bvjZwciNbWXlgF7VjYgxG9QyehRWW62tKtLQEq8vgr5B-MZFAu9ZQ>
    <xmx:-bvjZ1OL6ZAVxGS54lklEUjqWjKo_4GVdyMY78wfgf7SLyiMFt6H4w>
    <xmx:-bvjZ6mAB3Ks6GaETXo21HCj_Pe1tiJ16E30FtPpvXetrLkYYklnTg>
    <xmx:-bvjZ3svM-d3kBmkx5i5u4N-SWa1ptIG0OQDJBDGq_Io1FhNB3EWmw>
    <xmx:-bvjZ4ffyBraWQa94TexHk7POSxa7amkAdtxj5Vvs9PHNIDRmpJIkZpv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 04:34:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf02af10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Mar 2025 08:33:59 +0000 (UTC)
Date: Wed, 26 Mar 2025 09:33:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 09/10] clang: warn when the comma operator is used
Message-ID: <Z-O79qs_iL0lYany@pks.im>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
 <91f86c3aba9d19d5df11661675fd6c2cc049e191.1742945534.git.gitgitgadget@gmail.com>
 <Z-OWp0NkjrMVQieH@pks.im>
 <9cd9a690-1258-d96d-33c9-53a3b0f346a1@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd9a690-1258-d96d-33c9-53a3b0f346a1@gmx.de>

On Wed, Mar 26, 2025 at 08:50:24AM +0100, Johannes Schindelin wrote:
> On Wed, 26 Mar 2025, Patrick Steinhardt wrote:
> > diff --git a/meson.build b/meson.build
> > index dd231b669b6..a7658d62ea0 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -717,6 +717,7 @@ libgit_dependencies = [ ]
> >  # Makefile.
> >  if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argument_syntax() == 'gcc'
> 
> This `get_argument_syntax() == 'gcc'` condition catches `clang`? What
> other compilers that aren't GCC does it catch?

Yes, it does catch Clang as well as the Intel compiler. The list of
compilers and their respective syntax can be found at [1]

Patrick

[1]: https://mesonbuild.com/Reference-tables.html#compiler-ids
