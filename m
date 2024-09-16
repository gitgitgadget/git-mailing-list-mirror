Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779F256D
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474048; cv=none; b=ugcye9NqI0ftdVEkQvQexwokhskldXojGqSikFfo17/ZJhTaEG1LWycqQ/kCeWmHhL2v+wmyiQdqdf2i5RXWNCmPfcNLMLrn7PST8J8ZSWW6ca2CH4fRepWneeV3oAwcETReQ6+ORQkOaMXSc1y96bdvQgG1TSvx8y75Kk9mGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474048; c=relaxed/simple;
	bh=1Mktu/TsCYdR+0pIqm3pHIVoJC+jYmRzGwDzzsl/VQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS22k+riQkliWL+VpyXzu+6pTkVUXaa6xHF632QnsoCkdMy8spxIHIcsNZ2We+23lRzMmWKjqIV06d0hkYYdxgmvVlZBERmGNnqOwgc1npUsxkoAydswjmZqJ24pzR8viGtCu69SeFhTMjuUWTS1/un4XasB5mLMLHWD2A9VmVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ade1y1YC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UcO6q2ff; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ade1y1YC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UcO6q2ff"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6CF0411401CF;
	Mon, 16 Sep 2024 04:07:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Sep 2024 04:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726474045; x=1726560445; bh=yq3HOe0k2e
	gpyeQNYD5woNJBN0UzKvZpyRJQTDFuiD0=; b=ade1y1YCwaG9HYwil8ZBWAxPeN
	bUZhtzDeG60k1iNh56cAj6x3S9HwEa0bam204iETMJfwMkgl5u5zu33XRuUeCxs1
	aElw4wb5fnYshJZDvHq65OBgQ1pFeIg9X+er0oMZdaUceTlfgn/82CGznY8NjkeT
	b1t8pxucPShd5F/qY+zbplbvRH9+q1PdNlH2p+5BdLHvYUHMyW+Dfqg+T/py1hyy
	LIlvIOG+SV5a5+1tal5OmH7uBXo9jUNE9iiV1IL/JQlqx3+C2K/JPUDmOf1KT5x7
	qvDnw2/YG04Dekxzf/ByZOPHJ+fSBfxmPBYF14t+XFD7TUFUy7cXjXH5bzTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726474045; x=1726560445; bh=yq3HOe0k2egpyeQNYD5woNJBN0Uz
	KvZpyRJQTDFuiD0=; b=UcO6q2ffxLUyOBs7ocWViX4g3E4AWFKWvHHbbDngT6tr
	DM4d+JqdJcEX+HAzr4D90423mbERm0ITrC8KFT1aOUpXlhKHiueX+Iy4rCzfaAOk
	tWnea1GwggMrxwU2x6C23EKNfNTLFpLiBZUFUxZWfHMGo3yuTEzV2jpqSutaf6go
	GI8HaD7/g3pxPOYwuOgGKl7o1Jvdwivp1Hbo51yJXGViurTXapdB0pTQ9C4ptEKO
	aKsiEdj1Ppu0uFrUGaphGXhNG6fbSned2bYfFUm10qaQvJeypcPJC/GGvYR95YEo
	si3IQe6HcU+hec6bhX81kLxzs9bRyu4uwwh0P5EuRw==
X-ME-Sender: <xms:PefnZkYE5QHfEtXlZfjnSFckVXaTmWwcO-R-6mHM04gKChth6aSxCQ>
    <xme:PefnZvbR13woTN_taIIBjw6jKDPxQcrP7r7-kh-ZoV2ZvCQfhofS9gmagaypOWRtY
    uRBE1ze5gFAukmYhQ>
X-ME-Received: <xmr:PefnZu_Br-gGaIOf5QbXYmKSbMG2DULzms9pswuLlCLoakt5lMSTLJ5zU19D2lrs4HQIeyjb0n2bBzdIVIco83W_zwlm34PAkCFX_vt0U3iSkFcR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvefgffeftd
    ejudffjedvfeejjeffheefhfeiiefhfeeguefghfdvvdfhgfdugfetnecuffhomhgrihhn
    pegvgigrmhhplhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PefnZuq4SUo4r_nGD0FUijAkB5_hjrb57QKf4S8K3T0cPy2IKEs0eg>
    <xmx:PefnZvq7gX1VQNI0RsNJEVHRpAlD4SR_rTRpelpVWFiRjbbRpavS2w>
    <xmx:PefnZsRBfpZ0Cw4x-i99D5z2PAdxTaoTBRHqTdg5Afdbtqh9n5pkaA>
    <xmx:PefnZvqpJY521lBlxqaQ81kxDLpj7_roRlPp4YHk1LJwJtCsL6Urmg>
    <xmx:PefnZuWbG_SlvSl7q3R_VPumRzSp4F79wKHvFQn-iwXW8oltMqG6UgfS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 04:07:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 61e487dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 08:07:05 +0000 (UTC)
Date: Mon, 16 Sep 2024 10:07:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] t5512.40 sometimes dies by SIGPIPE
Message-ID: <ZufnNwks26lYEPWQ@pks.im>
References: <xmqqmskbwe1a.fsf@gitster.g>
 <20240914064130.GA1284567@coredump.intra.peff.net>
 <xmqqa5gatb4v.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa5gatb4v.fsf@gitster.g>

On Sat, Sep 14, 2024 at 10:09:52AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > I really wish there was a way to ignore SIGPIPE per-descriptor (or even
> > tell which descriptor triggered it in a signal handler), but I don't
> > think there is.
> > ...
> > Another option is to selectively disable/re-enable SIGPIPE for
> > individual write() calls. That's not thread-safe, and I imagine may have
> > some performance penalty in practice due to the extra syscalls. But it
> > might make sense to do it selectively.
> 
> All true.
> 
> > +static int write_constant_gently(int fd, const char *str)
> >  {
> >  	if (debug)
> >  		fprintf(stderr, "Debug: Remote helper: -> %s", str);
> >  	if (write_in_full(fd, str, strlen(str)) < 0)
> > +		return -1;
> > +	return 0;
> > +}
> > +
> > +static void write_constant(int fd, const char *str)
> > +{
> > +	if (write_constant_gently(fd, str) < 0)
> >  		die_errno(_("full write to remote helper failed"));
> >  }
> 
> The _gently variant is meant to be (optionally) used while SIGPIPE
> is ignored, and this one is meant to be always used while SIGPIPE is
> not.  If the reading end closed the fd, the underlying write would
> fail and trigger SIGPIPE.  This die_errno() will not trigger in such
> a case.  But for other kind of errors, we die just like we used to
> in the original code.  OK.
> 
> > @@ -168,13 +175,16 @@ static struct child_process *get_helper(struct transport *transport)
> >  		die_errno(_("can't dup helper output fd"));
> >  	data->out = xfdopen(duped, "r");
> >  
> > -	write_constant(helper->in, "capabilities\n");
> > +	sigchain_push(SIGPIPE, SIG_IGN);
> > +	if (write_constant_gently(helper->in, "capabilities\n") < 0)
> > +		die("remote helper '%s' aborted session", data->name);
> > +	sigchain_pop(SIGPIPE);
> 
> And the only caller of the _gently variant with SIGPIPE ignored
> supplies its own error message.  It is easier for the end-user to
> identify than a generic "Broken pipe".  Nice.
> 
> We identified a helper that closes the connection even before it
> hears from us, so we say "aborted".
> 
> >  	while (1) {
> >  		const char *capname, *arg;
> >  		int mandatory = 0;
> >  		if (recvline(data, &buf))
> > -			exit(128);
> > +			die("remote helper '%s' aborted session", data->name);
> 
> Here, we found a helper that failed to talk back to us (they may
> have actually read what we wrote initially, or what we wrote may be
> hanging in the pipe buffer without being read).  It depends on the
> timing between which of the above two points we detect such a
> helper, so using the same error message does make sense.
> 
> > diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> > index 20f43f7b7d..d21877150e 100755
> > --- a/t/t5801-remote-helpers.sh
> > +++ b/t/t5801-remote-helpers.sh
> > @@ -344,4 +344,15 @@ test_expect_success 'fetch tag' '
> >  	compare_refs local v1.0 server v1.0
> >  '
> >  
> > +test_expect_success 'totally broken helper reports failure message' '
> > +	write_script git-remote-broken <<-\EOF &&
> > +	read cap_cmd
> > +	exit 1
> > +	EOF
> > +	test_must_fail \
> > +		env PATH="$PWD:$PATH" \
> > +		git clone broken://example.com/foo.git 2>stderr &&
> > +	grep aborted stderr
> > +'
> > +
> >  test_done
> 
> The code change covers both a helper that disconnects before we
> write the first greeting and a helper that disconnects while we are
> still expecting it to talk to us.  The test explicitly covers the
> latter by reading our greeting (in other words, it does not die
> before we do our initial "write"---no risk of the SIGPIPE) and then
> stopping without writing anything.  As we are waiting to read from
> the helper, we will see an error in recvline().
> 
> Nice.
> 
> If the test loses the initial "read the greeting", then some of the
> time our greeting would be hanging in the pipe, we wait in read, and
> notice that the helper died, to trigger the "recvline() failed" code
> path.  But other times, the helper would die even before we write
> the greeting, so we'd see an error from write_constant_gently() and
> die with an identical message.  Such a test won't suffer from any
> flakyness but makes me feel somewhat dirty, so the above is good
> ;-).

Thanks to both of you for catching and addressing this issue! Both
patches look sensible to me.

Patrick
