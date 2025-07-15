Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55D2517B9
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595950; cv=none; b=DvSWezjZeElWLXawhGPdzv63JL3Kd4iWhv/JVEl0wBdAnlkHb3KAL6N+I0dWXWxzlUeWKuJkJ8rFovZRuAFV4Spb5lbq4thl43l9o/zd9vUvhYS8oilwnqiqbwykbMrt8/s8bGImrCG3DQnlCbuau6yKSMdI8waneTkWaIGTmG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595950; c=relaxed/simple;
	bh=PEixJ9U1YAtV2hV8vue7Y6fJgLT7rRy3c8D8axVgp+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRz3DuD/OayKQ6KS0ZG4IDH3RE7M37a3T/0cyZPAR49yF+HvvsLjrEuhhzBM2POxUEgRNYEzIf1i48FZup8LSbWEsiwfNkwzhgpVtasod8H73C0mhw2i5TdrAXfAklrOWqOwlP+vOVg02q1dAOgKuyvuIRbSAFSfzqyVsDR3gYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eltELln3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NT5RF8cv; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eltELln3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NT5RF8cv"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F188F7A01B2;
	Tue, 15 Jul 2025 12:12:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Jul 2025 12:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752595945; x=1752682345; bh=ksdBO9cZHf
	xqYk5FEBhEA5a48JLAXVOajuZXtMHMcZg=; b=eltELln3hs2sNlHp4VoMmyujNT
	QM8X/24OwlXbZle9xM2sQ1YKWBGXYXCjjXgOIPJPRPDCHy6WfoaRewC9agFYqt3M
	utT9WMtTygEMVr3kRK4YEpL3AJCD05SU5VqXvE3Jd/TySqkr6kRYgH/joiiKhj3X
	eeoHyEqGOSmXECkavu9kuRj+lEAlrGTB/n7ckZmv7gH0/V8i2M5Z/zj/FH6bdbqu
	LO9n6AUL+kZ9rAppXt3OmjqIb7yzIPzotbxLSKvplMFOh1XvagQVSAf/++V83xKM
	JziQ60WX2MrBFbf+leIu+YVH/vDB/i/nJuWw6U1o8pVmLTW5LqdpfrvOs/dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752595945; x=1752682345; bh=ksdBO9cZHfxqYk5FEBhEA5a48JLAXVOajuZ
	XtMHMcZg=; b=NT5RF8cvI/+oztMKV23bgUvUgiAVE4r0B6F6jM12qqy7V5XwcCv
	YXCxA+/cyYf/4AVaYGbKtQrXbFONubroB2zAXQdp2gXzr/aUczXKhO4gsJGC1ipL
	mZ6hb2VHjmrN9CeV28Ik3TRd8tB6BcD4q80F2w7e5F0Du12Hx5rcJoZci+WfaoZ6
	FPefH7TgYp7mOjjuW6mwCeZUNl76irVtCBPIZHYxERuoe/9MSxVkuvasZ5kHrH0K
	H5sw6Dog8zohWAqsYIheZgVDtoSG0dg90SGaFcJDECgFPGPj63LxRYZjt/dWjMji
	67oM8qOLng+R4rPwF4TDP7SvEMck9o44Z0w==
X-ME-Sender: <xms:6X12aBsF3STmM0s1wQCKkQT8jSgPoUo9j2xJWYh4qHfUZVhu9OUJ2Q>
    <xme:6X12aD6k1hDcoRrPmV-TmOhgcFZDc8C3U0eyRUaRBxR6ba0Uj6GFQFDizZUsiWNcZ
    IySWauWj_9hYhApzA>
X-ME-Received: <xmr:6X12aEXwsX6OTlwxRVnI6kXyhGOjgPQOTYwUQQid_D2puwKReRtTx3sIySXWS5Chg8exG8uczYXQgyI1RgR9D0JQtTnPQZYGwc09NEhlYz1CmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehhedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:6X12aN9eKK3dGv2Ep_bAERkWYzqzv3DZI6-1jP9VZIRsSUEgI70YUQ>
    <xmx:6X12aImlLfI8sQ__ewZbgEkbYIEJ9NMcafJZdwTYUDOtYurRgy6mGg>
    <xmx:6X12aDUkhytxFM4mgLQtlVH7OJEfgKoXx_wYyWbj1kHq_snV41rkpA>
    <xmx:6X12aNEyj88HbT0EHnKC4X3GazlG8LlYatdWhIihjjxo34nxiMSB6A>
    <xmx:6X12aLcSpP14lAsE0rPGWpyoZZIg9EO29vpbjL8vIKBR_HRVols1t6wf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 12:12:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d7faf39 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 16:12:22 +0000 (UTC)
Date: Tue, 15 Jul 2025 18:12:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: Re: [PATCH 17/19] environment: move compression level into repo
 settings
Message-ID: <aHZ94u-xULDDBb7C@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-17-62627b55707f@pks.im>
 <32fceddc-c867-4a47-bde8-c873279edbc1@gmail.com>
 <xmqqbjpq1rs0.fsf@gitster.g>
 <aHY7LYHqVj-ECf_z@pks.im>
 <f6479d6a-32a4-4a49-a75c-589978cb9a57@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6479d6a-32a4-4a49-a75c-589978cb9a57@gmail.com>

On Tue, Jul 15, 2025 at 04:51:32PM +0100, Phillip Wood wrote:
> On 15/07/2025 12:27, Patrick Steinhardt wrote:
> > On Fri, Jul 11, 2025 at 11:55:27AM -0700, Junio C Hamano wrote:
> > > Phillip Wood <phillip.wood123@gmail.com> writes:
[snip]
> >    - Not all configuration is equal. It may be perfectly fine to ignore
> >      some configuration, but other configuration may very much be mission
> >      critical. And whether or not configuration is important isn't really
> >      something we can decide, as it will depend on the specific use case.
> > 
> > So I'm afraid that there just isn't a perfect solution here. Does it
> > make sense to die due to a config key that isn't even used by a specific
> > command? Maybe. And if not, which config keys _should_ make us die in
> > case they are invalid?
> > 
> > The overall situation right now is a proper mess: we have config parsing
> > cluttered everywhere, and the behaviour is just plain inconsistent. Some
> > parsing is delayed, some isn't.
> 
> Indeed. My objection here was that we were delaying the parsing when it
> wasn't delayed before. Is it feasible to call prepare_repo_settings() in
> repo_config()? That would at least avoid the problem that moving config
> settings into `struct repo_settings` changes when the settings are parsed
> unless the command calls prepare_repo_settings() at start up. As far as I
> remember `git config` uses config_with_options() so that would not be
> adversely affected by such a change.

Hm, yeah, I think adding it to `repo_config()` might be a viable
approach. I'll give it a try tomorrow and see what breaks :)

Thanks!

Patrick
