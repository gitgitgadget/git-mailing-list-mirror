Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CFB328B7D
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731040; cv=none; b=LTkRdmo9xE39v/V5NkU2C8I8gKA2iaWJ3He0ghAhHTsY1P69xZYR/S5IaxOyUhiFQF2idATez8R7OBE9P+/TDQkTK0vNQjvw65/R+jLd1S6g8GeWB0vxRIh+NMzqnT/EEdnDhuJWSR8jjPD/IQz7ScZQnhHzfqxiIRbfmUR5MuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731040; c=relaxed/simple;
	bh=0IgN7B5nBAxupoWkW5v58hZ/0uioimmNUjPXm0uo1cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzL1zQmTEPb60V3+1v3XQaKei1X3PI0sCIXyCpXTJdp47rtMfryqKICLMCEM3hZP70e/NObe30MBm4chOimHAD7Qa/zUfEJI00Sjk13TyPPHlvhT3c8OSvJlW+3kVdnXuuCGKHMdivwU50gAMeo19tiv06rhadV0rB62gNQVBOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gvcen0Ak; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A13+HS35; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gvcen0Ak";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A13+HS35"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 98502EC074A;
	Tue, 10 Feb 2026 08:43:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 10 Feb 2026 08:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770731038; x=1770817438; bh=ZD+QX/Nmrr
	5tF4kFe0d8HI/jfDjUhjp3YG7PpdCrBcs=; b=gvcen0AkMxSGH4ydDHNCCssrwG
	iMeKCQ8SI0CEUICIoLetuhFfowWzHc6PXPnusSTen9kAu4C/kRT8fJ6pRuh/BkiK
	8Nlvn0ioMjDqsE94pK2thoRb5goPeV8Bv905b8utl23Uh+Qz0ri3sZCD8LR+JmcL
	7L2gxZjV2+uaJRn3oef044KJXWFsKi3QbhnXXmiVYnzo42vOl7Jq42QRSdzZS323
	YsLe/Z4KY3dXUZP+qrsBbwXZKkQfkBgV3i0A90Kug9BVN65gNm0gagVz52lfZ5G+
	8YMkvbXCCXKdTCIsF00/DopcG0PrEVaoLtLTmXMWyFmpMM6a1nTdCXiLD2jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770731038; x=1770817438; bh=ZD+QX/Nmrr5tF4kFe0d8HI/jfDjUhjp3YG7
	PpdCrBcs=; b=A13+HS35vuz641wVrCMXYJ2n4q/krjg516rdp0kk6aBF/+b0+Xw
	QScB2QOGViWL8OYLV4ewnlwYTBxwAucyo/c9IiBhJwgYGOt2fpJVKFT+ylFrQp6v
	NQFYi1eyUsGJCYuYpZt/fanr7TM0xH1s5lbg7ZTIirqVHnw4LpLCQDDyiyl4Xbbh
	T90ZZpcpbcb38+ioUY3hQBWVNGZgJVLFQjEDDHpghpJ0ZuQ2ctLf+ycsMRv8XzoZ
	ysRDXlOArRv2lc0CRdEaUyLfwEbRKY5rGGJ4xLA3fc7EQba9zxsNtwZX6Lb+sAHa
	YuWUQnogqpq0hM/M0VRXGIUdF6bV95azxjQ==
X-ME-Sender: <xms:HjaLaTPGPi5VanQ8zRbU3BZoAqCxcAhqX91KjCZldCIezH_Ul8WouA>
    <xme:HjaLaQM6ngbYPz-oAh5gJiWHxIsrHS4DzDY6FWGszXPenJQDGdCH0u7Xwv4dGutYs
    0w6ZJuGwtYyCCDQ0c9JfPhomFyiU8nn5tUf0CUNdVhRsmU6PPgCLho>
X-ME-Received: <xmr:HjaLaUhBhfndoUjTl3kMkwNl5oIZ3cwi8S_VfV4aUWWxCohsgwPQfTTMCVH7YoMxANFDiSZs2zYDfbNai__vAcGk6OzL-xFUZaYuLpTGHy0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleelkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvmhhi
    lhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprggurhhirghnrd
    hrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HjaLadvpciNYn06fzChxgOFS9Uq8rvL-p-a-WumlvkxGQA1DJu8X2Q>
    <xmx:HjaLaaQooR1p4gn1spCgeVRQ6GyuW46rYhKnvLpBEntj00JdMqpVmw>
    <xmx:HjaLaZ0Fn2lnoZmotqAW6z643BLd7OD0jLTi44t8mvMDvFeZfAFKAA>
    <xmx:HjaLaXvNVp4O3XZ6KHwwSTpZcjXnEZPyKvxu6ZnNfG39xxg_v6LJTA>
    <xmx:HjaLafDBq9owVaTgMqYAm5aRF3jcP3hlg0dUvqw1ymLO8ve18CggvINM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 08:43:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cdb65ff9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Feb 2026 13:43:54 +0000 (UTC)
Date: Tue, 10 Feb 2026 14:43:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 3/4] hook: include hooks from the config
Message-ID: <aYs2GGTU6UJWJFOf@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260204165126.1548805-4-adrian.ratiu@collabora.com>
 <aYnu9gJATVJeKEjZ@pks.im>
 <87343920ny.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87343920ny.fsf@collabora.com>

On Mon, Feb 09, 2026 at 09:10:25PM +0200, Adrian Ratiu wrote:
> On Mon, 09 Feb 2026, Patrick Steinhardt <ps@pks.im> wrote:
> > On Wed, Feb 04, 2026 at 06:51:25PM +0200, Adrian Ratiu wrote:
> >> +	/* Extract the hook name */
> >> +	hook_name = xmemdupz(name, name_len);
> >> +
> >> +	/* Remove the hook if already in the list, so we append in config order. */
> >> +	if ((item = unsorted_string_list_lookup(data->list, hook_name)))
> >> +		unsorted_string_list_delete_item(data->list, item - data->list->items, 0);
> >> +
> >> +	/* The list takes ownership of hook_name, so append with nodup */
> >> +	string_list_append_nodup(data->list, hook_name);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  struct string_list *list_hooks(struct repository *r, const char *hookname)
> >>  {
> >> -	struct string_list *hook_head;
> >> +	struct hook_config_cb cb_data;
> >>  
> >>  	if (!hookname)
> >>  		BUG("null hookname was provided to hook_list()!");
> >>  
> >> -	hook_head = xmalloc(sizeof(struct string_list));
> >> -	string_list_init_dup(hook_head);
> >> +	cb_data.hook_event = hookname;
> >> +	cb_data.list = xmalloc(sizeof(struct string_list));
> >> +	string_list_init_dup(cb_data.list);
> >> +
> >> +	/* Add the hooks from the config, e.g. hook.myhook.event = pre-commit */
> >> +	repo_config(r, hook_config_lookup, &cb_data);
> >
> > There are cases where we invoke the same hook multiple times per
> > process. One such candidate is for example the "reference-transaction"
> > hook, which is executed thrice per ref transaction. Would it make sense
> > if we cached the value in `r` so that we can avoid repeatedly parsing
> > the configuration for this hook?
> >
> > We could even go one step further: instead of caching the value for
> > _one_ hook, we could parse _all_ hooks lazily and store them in a map.
> 
> I think this can be done, yes, though I'm unsure of the performance gain
> vs the added complexity. Since after the first lookup the config files
> are hot in the OS page cache, the next lookups are cheap/fast and we'd
> be shaving off only a few microseconds of parsing.
> 
> So I'm unsure if this added complexity is worth it or not.

Maybe I'm naive, but I don't really expect there to be much complexity.
Quite on the contrary: if we unify all configuration parsing into
`hook_config_lookup` I would even claim that this cache would almost
come as a side effect. We would simply iterate through all hook-related
configuration and build the map of all hooks as we go.

Whether it'd matter performance-wise... I think in certain cases it
actually would. The mentioned reference-transaction hook for example had
some worst cases in the past where it would execute thrice per reference
update in certain code paths. In the worst cases I've seen it execute
tens of thousands of times in a single process.

Sure, these are outliers. But such cases do exist, and I expect that the
performance impact could be non-negligible here if combined with
non-trivial configuration.

Patrick
