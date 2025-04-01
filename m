Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321991FAC48
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743507829; cv=none; b=e4IsroIcPGYqHd/HMpnNtxbWr8H7NS/WHsL2QyQkgi+LDXO1M0ahiWQw5DfUfGyTMVZWJUsemW+TkM+pblf0Qsad5vsb6RJ6041Ltdm+OCZmzyUX+BDHJv55wrvq27VBUpnR933CNvXr93UOtsC6Gykn/xnRK76HZqVvyPke3ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743507829; c=relaxed/simple;
	bh=ptx8uC7hJHbSkVvFPT01pGXdkhXxKeG4OH3mM8GZtiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4HwOOjsMvrWWThhnRb5etdLFqsQe9KhUZ//SDfF61tJAlAPO15UMI7o2hA0qfSst+k5mUMDHeFzCRUCSlHU45MffXjgPGggOvUuJtAF0Z5sUwIsWcb3BRi3UKj/KAQcipQ77W2iqTHwxvD20ZUbcpMcrVaQkan8SNNYKY18vHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WF1BDLYm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VIbXM8Ze; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WF1BDLYm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VIbXM8Ze"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FA561140213;
	Tue,  1 Apr 2025 07:43:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 01 Apr 2025 07:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743507826; x=1743594226; bh=Oipe1siCrP
	a0poI4/Uo96S5b5Azhy5CGYuzWhektRXU=; b=WF1BDLYmZlkeiGXe7J+KxBxt++
	YKFsWIiA2y6Vyou8fBZkBpKTtT6L6qjBqSYd1BmzCiYWNifUNe5FM3xkmqOPzoXS
	fkYUvraMlGMCXieDfq0EsDzYXhyaM0Rm3vYi4IliFkHqqQG9sjOKjl+EfnlHkpNx
	QLB0H3Ncywgp7Tnw9/tcDnKKIxTbFNFIle1slTCRBHWR+xCLvk3sGUo5tdkMUTXq
	jvNYFvP8+tq/i/Aom5osxWK2h1yxJGoNksJ+ttUZIkMID56lYjC2ca4DBqyDZ2h6
	GXjGCPAlEhAOCCa7eh9Maz9VpgEKpr0XZk/Ig4c9hxAA5Dh67h7Wsf279BXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743507826; x=1743594226; bh=Oipe1siCrPa0poI4/Uo96S5b5Azhy5CGYuz
	WhektRXU=; b=VIbXM8Zehg1Vopz06YJDKUjgWCVvqtyHuu0gSBVaa6eLryFY5Ld
	OyobU7FINXFAjJ1ka6OYGkszk38zz+yT3UiJFm5xygk2i3ulbavrMHnYAmAqo0z9
	NY8NYkdtFmC+/j52C4U/EQNheayKdVyKrMkwh3Qx7gQ+jrqM2pvr3bJ7+pvXKGPd
	XYBTOy+8MGAQ6uZ1jlyfp09SiQjU6NtDhya9O8mdXjU1j73rXFGJqjsXcM2NJgQD
	fYHfDb1fCSzj/q6xNb1SMA+7NM2t4p98Iaw19Oeh1D12DJ3wXCY+HPb3CvMFm27f
	iPjJ/1UsSa/OxZ9fSEIw8tpxxVMfAhZGPHw==
X-ME-Sender: <xms:cdHrZ0YIHWEt2CtAbETDdoQKYG0spJayxriaMnvdLN3vzq2zLcpqfw>
    <xme:cdHrZ_aFSQtmaz0leflMAWTPwVqdjHvjWdt4LJ3AhhQbNljbmzh6jPrxIgA-H4YO4
    e5jf_DHaMLKJEB0xA>
X-ME-Received: <xmr:cdHrZ-9l0aauHbnDJjknkO9TwC1PDZaz79uNg_oHZkPocnpaeGKWoHU3fBr1LQYoeBG--dtM8mN_HIm7T3AGO8O3XzDJluEfDMmuGF12lv2ErTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehglhgruhgs
    ihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopehtmhiise
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopeguvghrrhhitg
    hkshhtohhlvggvsehgihhthhhusgdrtghomh
X-ME-Proxy: <xmx:cdHrZ-qM9Ke_6JNeNjKj-nju__gR6Pk4egTBH44vdBvYKOKae5cONQ>
    <xmx:cdHrZ_r_tUlrD9do9ziXikSPPBqERjylZGFEnQcijJBo--hTRbVKUQ>
    <xmx:cdHrZ8Q11y25kmy5CD2gL6ZyoeICESmrzhbYMJUXONa_Kksz2h7o5g>
    <xmx:cdHrZ_qNPdqJ2AkTvxXP-WXirdvBLNO8Xh5XxwHFp2ZIHeFf3F2AmA>
    <xmx:ctHrZ7J5mFYb1ORNIOuZEjG0b6-LFItJScqFC7yl65SV3PvDhyjcA11h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 07:43:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 984a290c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Apr 2025 11:43:41 +0000 (UTC)
Date: Tue, 1 Apr 2025 13:43:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Todd Zullinger <tmz@pobox.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	git <git@vger.kernel.org>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: Testsuite failure on s390x and sparc64 after 6840fe9ee2
Message-ID: <Z-vRQ-FNv7WD02hl@pks.im>
References: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
 <Z-R_Zmr6kxCPLm-O@teonanacatl.net>
 <Z-Zr7BZL1UGqVxKu@pks.im>
 <4276c8d0b72f11f325482756d3bc251327d0ac47.camel@physik.fu-berlin.de>
 <Z-atRMGXHilZRTEL@teonanacatl.net>
 <Z-bCNdOOLrM2Chb8@teonanacatl.net>
 <Z-qKGqpbdaW9WCrP@pks.im>
 <Z+rcVY7KqEuF1wFw@szeder.dev>
 <20250401023358.GA1087913@coredump.intra.peff.net>
 <20250401031030.GB1087913@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401031030.GB1087913@coredump.intra.peff.net>

On Mon, Mar 31, 2025 at 11:10:30PM -0400, Jeff King wrote:
> On Mon, Mar 31, 2025 at 10:33:58PM -0400, Jeff King wrote:
> 
> > That would be nice. I think we've discussed type safety for
> > parse-options before, but IIRC none of the solutions were very
> > satisfying. But this sounds like a relatively low-effort approach that
> > buys us something, at least. I wonder if it could even be extended to
> > use __builtin_types_compatible() on platforms that support it.
> 
> So here's a slightly fancier version that uses the gcc builtin when it's
> available:

Thanks for these! I'd also like to spin this even further: right now we
don't really care about the precision of the underlying integer types at
all. While we could force all users to the same type via your mechanism,
I think that'd ultimately be quite awkward. Another way would be to use
one macro per underlying integer type, but that would quickly explode in
scope.

I'll instead try to extend the parse-options interface so that we track
the precision of the underlying integer and then produce an error when
the parsed integer exceeds that precision.

I'll send a patch series later this week.

Patrick
