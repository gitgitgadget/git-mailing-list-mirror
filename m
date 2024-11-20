Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FB156872
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091761; cv=none; b=JT7+PvBYK8lG6bKNjCYYvreGT+ZBsA/XphQvuZc0/l8iuBWCu8lQV4nRU1bjin0vJLLtta8CPVyLRLPGgnyZ/k0Gdw+VXzr83/2jYtMAqaAGzoxC2naplGlA1g0IaH+shvO5COPS1zo9hrD5ju6fJ0PcMbxbASR27A5k/MHbGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091761; c=relaxed/simple;
	bh=Wg9+reXhQCcb5BFUEhkYhCoS0s0CbeVXOABKHO4eA0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/g1A/gIv9k8fuMWgXnnTxkwBjJhFhiINoWVkfsJZFUz4j2mkUys+iFMQ3U4e5Wiy+/yIbMH1wo5yA4YAWdI22nAQbbygKPX7YUJNFoFoBvTK6LkMD4LXMsQrcCmo9HQfWMnRQDiZgkGzOSrKFPPwA4PqRd0IuVzfVhKUzvnuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mEkWTRTj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i1hQFXRW; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mEkWTRTj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1hQFXRW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 533C01380713;
	Wed, 20 Nov 2024 03:35:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 20 Nov 2024 03:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732091757; x=1732178157; bh=wkhkV0DW3u
	oAYEEuqy5ADZ4ye1VBDeklDOQx/XNdHvs=; b=mEkWTRTjShwHTWd5cH6VfiZUNV
	U8avCgjfA5Mv2rDVEEHl8TEfKTcIjeV0ikyIavxJCtOD9Tr2QatGFD9C9Hh44cFP
	mP8QPxipvzPEWiuiTlUj4j4BQjeMxoC9hIk4JvJ+gcecuuW5mes7AqcmjJJsnxZW
	5aw5vsB9CJ99Q2FfsxWh6QKv4xcBV8/QIU0rIVml+hvVZ/gZE7XAXFbMWbhNrtxn
	X0rF4LAlEbwQUv4CBxXDg+xc8CH5TLXcgMsMBi4FImqcyVS9m9iVQgld+ZBtwjs3
	3091jfvoD4YBJ1DswL0Kuq0NTmomsQtISOuAgG0bsG4UuFExfzrJ3v05p4Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732091757; x=1732178157; bh=wkhkV0DW3uoAYEEuqy5ADZ4ye1VBDeklDOQ
	x/XNdHvs=; b=i1hQFXRWJ3oJb1g/463zkFnqqzme9wbUHkMaiRlqiQ0I93gHXdk
	k/cEuLJQrO4z9kFWKD0vzCzKgsa+qCKd1cftIZEuU3RXv4oNzERhxkNG59JV0Zjs
	mTYxiz+P6xVblQpwxRpTBu1htxSnYa7G12vmsf4QzMa16Ed6vqYw69ALgqMVPmG0
	fb8LOWV9VrM/AMLfxXKp8zqDYNJu7Dv1V0w5MnSpw4UT06IhjJsbho7ly3JcrtVG
	nvoDQE8SfB09144Yq5mTOxPWQkMZ96wCO95qbQGtvxAsIUtbOzmIwYNDge1gMxmD
	/EPpYuKMA+SiXDowYNSmJTVDnmsKKrmGGkg==
X-ME-Sender: <xms:a589Z1aJL6vOWbM4228J6xK3zRWWkbxbOKldup58l-23lNmBQ4RFnw>
    <xme:a589Z8bZ3g9CsDl_sqrQ484FDIf-59XGc54Ig3WewM6EouDv6TAqW0mpGCagjlbKp
    Q9O-LtprcCJNnRQPQ>
X-ME-Received: <xmr:a589Z3_1cmeoIrW5C1T0khF-5BZLnY6k755Y936dccCkQLLdNgUkW8JQgQNv7oZDbdegetcm4SaOPIcmjIk8xuMog66FDx_H1B4Udx-6ysrg2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtth
    hopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvth
X-ME-Proxy: <xmx:bJ89ZzoNegxUKTmAgBbAX2HJeWQBW8k6muF07WsILkHLAOfNo6m2IA>
    <xmx:bJ89ZwqClbES5qZeHqCZzBTaMAIe98hV51hCAJMr-lPer8edRp0b9Q>
    <xmx:bJ89Z5T2m_3Q3ApW8u-ijjIq12E3ISZA659zStkpozhpUqHUIKL4CA>
    <xmx:bJ89Z4qG_jXjaGJFEP_cpEu8PzWebtwINFVNjFtU7qAzhX6dHIm2YA>
    <xmx:bZ89Z1TWLBbYvNJiXcftShmXu5oXzV10-tX8sdns7czdTrX-WaevwgRL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 03:35:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e7044a15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 08:35:01 +0000 (UTC)
Date: Wed, 20 Nov 2024 09:35:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: [PATCH v8 02/23] Makefile: consistently use @PLACEHOLDER@ to
 substitute
Message-ID: <Zz2fXw3Nc5WM8MNX@pks.im>
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
 <20241119-pks-meson-v8-2-809bf7f042f3@pks.im>
 <7b826bba-11cf-4f45-8292-937522dbaf29@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b826bba-11cf-4f45-8292-937522dbaf29@kdbg.org>

On Tue, Nov 19, 2024 at 08:23:20PM +0100, Johannes Sixt wrote:
> Am 19.11.24 um 12:50 schrieb Patrick Steinhardt:
> > diff --git a/gitk-git/po/vi.po b/gitk-git/po/vi.po
> > index 59674986604891d9901e87c163e61dd39db14184..184430dcdeea7cbb76895840f84a889b6abc20bf 100644
> > --- a/gitk-git/po/vi.po
> > +++ b/gitk-git/po/vi.po
> > @@ -5,7 +5,7 @@
> >  #
> >  msgid ""
> >  msgstr ""
> > -"Project-Id-Version: gitk @@GIT_VERSION@@\n"
> > +"Project-Id-Version: gitk @GIT_VERSION@\n"
> >  "Report-Msgid-Bugs-To: \n"
> >  "POT-Creation-Date: 2015-05-17 14:32+1000\n"
> >  "PO-Revision-Date: 2015-09-15 07:33+0700\n"
> 
> Is it essential that this change of the gitk-git subtree is included in
> this series? I think it does not hurt that it is omitted. I can pick up
> the change and apply to Gitk independently.

No, it's not, I'll drop this change. It's kind of curious why we have
this placeholder in this file in the first place. None of the other
translations do, and I couldn't find anything where we replace this
string.

Patrick
