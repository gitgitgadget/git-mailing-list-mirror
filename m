Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5ED211711
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316831; cv=none; b=KhCkgje7uqo817t5wn6kQPpunpnlDZThB76FlOr4peWBj3oZ6fXLIU1aKt2yrCs84fekSBwFSW7u2Dr53UWznwL12h8yU+OXfH/WTeX4rE7yMProxwqhr65GaEmYBajHN4yPIcFWy6QYj7+lIfaQQXeh98fbUBuYO79nnrgbH8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316831; c=relaxed/simple;
	bh=bEXN39ehZdCgGuUsdCeljZn7pIqQ8eVsPB0TgnbH1to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKV7JyWgDAI9jP3GJnUee9tFUlXz2wENufl3b+Vxo8shoJlWcGudvSQ8+pW7Lt3wiY4foUkRLZbWsP3NrMOEL0FQHQybWwO+2pwyK0l6z2yS6DSuiiAOlyU1oq3+WztbBir0S26QdkPgl5ya00ev3NA1cMgnRNJvPJ0mR7QQ7+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FITDn5Gn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aODbGt5S; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FITDn5Gn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aODbGt5S"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 00FDB11401AC;
	Tue, 22 Apr 2025 06:13:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 22 Apr 2025 06:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745316827; x=1745403227; bh=NerdeTgRa9
	IFWLBAv8NipusH8YRY9dtK27n8v6DDSrA=; b=FITDn5GniF+iBArIPbdyES4CR2
	cBLPNHX30UaVpiNCNl0OiVJv5PzieXzINBNYnLDEZ6rpnbByIE3fic49P9+a1eK6
	x+kCLGrjWKPKWkXRNkrGrRia/hC3vDE9fRXdCfx+t8N3cYnBt7IE/k1xACQrcKnm
	FG8fpzUuRk693k1QVwT6rF6FOA8CyvgtAzPinvL7G4pDd3PnXjvYJYXLy9E7QuTM
	3uXYHSZrUNbSd457RgMahqct+26Rvie5BWsVzXXBOxobNNqRCZFBA2RInig0dZ/2
	haB7vH3u5xEqSJicAfco+hI9LnvpCl4N8o6O6/4uSjqhOZQpcq07y8BgpNlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745316827; x=1745403227; bh=NerdeTgRa9IFWLBAv8NipusH8YRY9dtK27n
	8v6DDSrA=; b=aODbGt5SmhXalDoWnD/aFvLI3j2iXdYgr8bWKsNWWH/P88Jw+1X
	+GEOUOzekw69mHMO4EdcypSo5K3GkWI4Kgcm12Z6m6Q/7hwHACwD/1YTPtLCGpvQ
	D+4FXVVykM0wuGfhNKzdpvqNliyOvs2ZJ7aOT/ZfKKe0B4pJhOs8sQU0Xc3hSmnJ
	KiGy/Owb3SmJ74Ov30IcAq3eqQy56MiQjrz/ad761qgeK9fgbzgzbtSWr3B30EsP
	LG+SQ9lJOZoGX11pBKMPabBfzZn97aGyhlL5JYrR83ZTX+ahwqNkJQxqYBUw92H0
	uw/Q308LDTsR4k1Nz2LH9t4FpIWJPUJv2Yw==
X-ME-Sender: <xms:22sHaFQ9VJl6dENxxjL-JejVETT7dBkzJai36Bb4MyVt6QE9vg4uqw>
    <xme:22sHaOywXaEIsw5u1kMuvpy7B_z9quLKtQZVnZt18iuU9TEYnNg45_mNdcPLfc_iv
    v2gYioJlRX71HHpdg>
X-ME-Received: <xmr:22sHaK20yJrXPvpB6Mzy-k7sQUiGwcQvvLw7Su5FqARpyBNPPaiVzDaa7o4zp99V5vN1kFv4SvBcWBJ2dYj-HjMQmKCXTYUFkQahkvSEo4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrgh
X-ME-Proxy: <xmx:22sHaNDHJxTixGnScgXG7TSVFOdG-rCAEOyrjOzyky3Wmdw_XiX6YA>
    <xmx:22sHaOi3eCKICwwPL31NgrtxftAZG8kzrEpydMlksbQUM9Bs1L1BQw>
    <xmx:22sHaBpaZ13FDJw6tY3cqzZejA4w0cl0jTtwsSjArIH6hR_jnTpPow>
    <xmx:22sHaJhKiq7zC4YdyJ9JVK0A39yoJ5XWoBWieho7KIZzjo0rSZyg8Q>
    <xmx:22sHaMd81mhl_WV_dwVwJprlwJkERf9q0JYWxkVoC4DjJHhIqGV5AueC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 06:13:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b287cbe6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 10:13:46 +0000 (UTC)
Date: Tue, 22 Apr 2025 12:13:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] promisor-remote: allow a server to advertise extra
 fields
Message-ID: <aAdr2Q9jthNV699i@pks.im>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250414160343.2216312-4-christian.couder@gmail.com>
 <xmqq34eapfhk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34eapfhk.fsf@gitster.g>

On Mon, Apr 14, 2025 at 03:04:07PM -0700, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
> >  
> > +promisor.sendExtraFields::
> > +	A comma or space separated list of additional remote related
> > +	fields that a server will send while advertising its promisor
> > +	remotes using the "promisor-remote" capability, see
> > +	linkgit:gitprotocol-v2[5]. When a field named "bar" is part of
> > +	this list and a corresponding "remote.foo.bar" config variable
> > +	is set on the server to a non empty value, for example "baz",
> > +	then the field and its value, so "bar=baz", will be sent when
> > +	advertising the promisor remote "foo". This list has no effect
> > +	unless the "promisor.advertise" config variable, see above, is
> > +	set to "true", and if that's the case, then whatever this list
> > +	contains, the "name" and "url" fields are advertised anyway
> > +	and contain the remote name and URL respectively, so there is
> > +	no need to add "name" or "url" to this list.
> 
> As a description of overall syntax of the protocol, this and ...
> 
> 
> >  promisor.acceptFromServer::
> >  	If set to "all", a client will accept all the promisor remotes
> >  	a server might advertise using the "promisor-remote"
> > diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
> > index 5598c93e67..f649745837 100644
> > --- a/Documentation/gitprotocol-v2.adoc
> > +++ b/Documentation/gitprotocol-v2.adoc
> > @@ -785,33 +785,39 @@ retrieving the header from a bundle at the indicated URI, and thus
> >  save themselves and the server(s) the request(s) needed to inspect the
> >  headers of that bundle or bundles.
> >  
> > -promisor-remote=<pr-infos>
> > +promisor-remote=<pr-info>
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~
> >  
> >  The server may advertise some promisor remotes it is using or knows
> >  about to a client which may want to use them as its promisor remotes,
> > -instead of this repository. In this case <pr-infos> should be of the
> > +instead of this repository. In this case <pr-info> should be of the
> >  form:
> >  
> > -	pr-infos = pr-info | pr-infos ";" pr-info
> > +	pr-info = pr-fields | pr-info ";" pr-info
> >  
> > -	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
> > +	pr-fields = fld-key "=" fld-value | pr-fields "," pr-fields
> >  
> > -where `pr-name` is the urlencoded name of a promisor remote, and
> > -`pr-url` the urlencoded URL of that promisor remote.
> > +where all the `fld-key` and `fld-value` in a given `pr-fields` are
> > +field keys and values related to a single promisor remote.
> 
> ... this may work, but as we are defining protocol between two
> parties, in order to ensure interoperable reimplementations, we need
> to also specify semantics, what are the defined "fields", and what
> each of them mean.  Proposing nebulous "with this framework your
> imagination is the limit, you can invent anything" may work for
> other parts of the system, but not for the part that is about
> communication between two repositories.
> 
> IOW, we shouldn't be internally calling these "extra".  From the
> point of view of "core" they may be "extra", but to the developers
> and certainly to the end-users, they shouldn't be "extra" at all.
> They are all supported parts of the system with defined semantics,
> right?
> 
> Another reason why I hate seeing this nebulous "with this, we can
> send anything extra" is because such a thing will have a wrong
> security posture.  If we truly *need* to be able to carry
> *anything*, we need to make sure how values are quoted/escaped, and
> the code for dequoting/unescaping are robustly written to avoid
> passing malformed input and misinterpreting it as something else,
> which would give a new attack vector.  If we can enumerate supported
> fields, their syntax and their possible values, we can make the
> attack surface a lot smaller.

I agree that we should properly specify which fields are accepted and
what their respective format as well as semantics would be. Otherwise,
without such a definition, hosting sites may eventually end up with
slightly incompatible semantics. I also don't expect that there should
be all that many fields.

This raises a question though: what would happen if a field was
advertised that the client doesn't understand? Should the client simply
ignore such a field? Should they bail out? I think we need to also think
about this edge case and specify client-side behaviour. I think in the
end, both ways would be rather limiting:

  - If we simply ignored all unknown fields our hands might be bound if
    we ever had to introduce changes that aren't backwards compatible.

  - If we always bail out on an unknown field our hands would be bound
    equally, as we cannot ever introduce a new field.

Which raises the question whether we need to be able to dynamically
figure out fields. This could be in the form of capability negotiation
or protocol versions. But in any case, I think we need to have something
ready so that we can change behaviour depending on which features are
supported by a client.

Patrick
