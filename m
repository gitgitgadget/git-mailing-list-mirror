Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BD718E02A
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 05:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093728; cv=none; b=Ehw2LNBjcG8Wx/pi2D/enJSJv6JI9amRbZQtoFrVvvu2NWDDoThw5Dw/v8+yuSVna8uTX3p+l3viPZv73lPfCknW4jO/O5w1b3PV3kpiNJwvFPpYg80pmJQguPiA/ruCTP+vblFK5hQrTq2dMd6dFRDNvV4v2CuKZM0+iRXrEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093728; c=relaxed/simple;
	bh=4Dj1DVzOw6hsK1FNA7W765Hjxt962OWZ/p19f6Ci79M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZUKAgkh/BzPpe/kv29GJbyTMO44Uao6ggjxkLXdAt7ZsXXTuH6g4S2XpwL67EPXb/yo44lfgc+J4jIeAzHmNF0Of9WxtjfoLPR3weLB2aa3lh0tdzogHPGB4W0kGFMIH50Lkt2hOMHnLDwfsViaj8zdMV4z2NtOLSH8gSc5XKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l009jyLs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fCSibw9E; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l009jyLs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fCSibw9E"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39AB525400F9;
	Mon, 28 Oct 2024 01:35:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 28 Oct 2024 01:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730093724; x=1730180124; bh=XS5PGIITCc
	zcPGik3GYpKV13FUuA+FHtY2T2EqQnApA=; b=l009jyLsRBo+lLU9fRTzBizRvz
	1F5kyiVU0PI47JV9UoIMe1vY4BeDpallA4lrDaOOMpPOKK1J6LA4kBUdNXlrVZqY
	4qq+yiQrmyNL3tjId2XtuKy2lR5z8WfPhrKyLF+8RkxcLjWWBkKYHNbc5OraiTe5
	CNPisDvfgpRnvpVtGE6/zy1FBOPhkBparnNVqbgkcVmLfaPIkDgRC3UQb91mUymk
	fJL582S/+fe+/5DyKwxSzVz3aa705GflnWGOzmxugsCA/xoTH57zgj9XC2AeOK6/
	6B7eC0jIzUOnHaYVa+R2atHAkMfvBu41f25NZzTsZJmdnmNkP0VPv24MXCxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730093724; x=1730180124; bh=XS5PGIITCczcPGik3GYpKV13FUuA
	+FHtY2T2EqQnApA=; b=fCSibw9EHkjDXcKHIZO7iDOdjOGeK+GAMKz8+oat0xWF
	BSsCh9K5+XxnvGBkzQLUBzWQwKSwRvl+VurjK6uTkKVoytdfFXqTlKPXN9CMVBVG
	gmJJFfdSYdkSCglLgc1Pch61uwvMlGQRT89fVfGJgs3QIcZiThxDkjpQ+42grL+V
	MOBpYIpTiu29+6NaXD2IYP/XTdwUlBiO1wkENncjD8FEZXW0EdLLG6drPwYYkyFH
	3Tq4wcpy6po9b4AQXXbRHKyvmB446ijNs/MH4pTkhvTP17I8VAhWCFyjxAYObZph
	o3tlUnv5zmOREPEAksOmo/npej6lFcf3B7wNhXYLLA==
X-ME-Sender: <xms:myIfZ5NqvaDucJUBuatS7qIHvvUBbpgqTXJhGKile7uqLsYmBAQ7uQ>
    <xme:myIfZ7-O4J91E80f9PGixMLuJ7_1GrxB8TjPK_IftH_QdqgZUpr39d3KXKJFEb2ia
    0QafjdYDdNI9j6NAg>
X-ME-Received: <xmr:myIfZ4S5UARmemffR6Fi7PXPNiMLxNppUQH4QGWI0Gc18S9TZGMczmfm351wae7taqttesjZpwWi9is-yxKK0cf_dg5KjcsedtUCqxrin106Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    eprggshhhijhgvvghtrdhnkhhtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:myIfZ1sBnx8mhEfURuxF2dXuFD1EGsJ3iUUmKQR8M9wYcVDS5vL5pg>
    <xmx:myIfZxcaE7ibwVPuIXUq33DQ9pT9JzK3zeGvQUx4eAzggjfA6cmVLA>
    <xmx:myIfZx1irQniwcy6GodanV0M8dcxdsj-Sa_P1VkVdROdOSGaR_dBZg>
    <xmx:myIfZ99lUvB14-wDc1HFC0AYSsXg6rIzvU9p3sdpvFhSCKJttzbBZA>
    <xmx:nCIfZ6GjCGwo3lWeGw1iQ_EsSTOGOOJS8f_RWnvYP1kqHRpzVkEyEDuh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 01:35:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ca3c2fd5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 05:35:15 +0000 (UTC)
Date: Mon, 28 Oct 2024 06:35:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] show-index: fix uninitialized hash function
Message-ID: <Zx8ijtkn7y6eBQ-n@pks.im>
References: <xmqqzfqi4oc6.fsf_-_@gitster.g>
 <20241026120950.72727-1-abhijeet.nkt@gmail.com>
 <Zx7WaEn6nvtjhs/B@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx7WaEn6nvtjhs/B@nand.local>

On Sun, Oct 27, 2024 at 08:10:16PM -0400, Taylor Blau wrote:
> On Sat, Oct 26, 2024 at 05:39:50PM +0530, Abhijeet Sonar wrote:
> > diff --git a/builtin/show-index.c b/builtin/show-index.c
> > index f164c01bbe..978ae70470 100644
> > --- a/builtin/show-index.c
> > +++ b/builtin/show-index.c
> > @@ -38,6 +38,9 @@ int cmd_show_index(int argc,
> >  		repo_set_hash_algo(the_repository, hash_algo);
> >  	}
> >
> > +	if (!the_hash_algo)
> > +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);

Let's add a todo-comment here. The behaviour with this patch is somewhat
broken as you cannot inspect indices that use any other object hash than
SHA256 outside of a repository. This is fine from my point of view and
nothing that you have to fix here, as you simply fix up the broken
behaviour. But in the future, we should either:

  - Add logic to detect the format of the passed-in index and set that
    up as the hash algorithm.

  - If that is impossible, add a command line option to pick the hash
    algo.

> >  	hashsz = the_hash_algo->rawsz;
> >
> >  	if (fread(top_index, 2 * 4, 1, stdin) != 1)
> > diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> > index 3b9dae331a..51fed26cc4 100755
> > --- a/t/t5300-pack-object.sh
> > +++ b/t/t5300-pack-object.sh
> > @@ -523,6 +523,10 @@ test_expect_success 'index-pack --strict <pack> works in non-repo' '
> >  	test_path_is_file foo.idx
> >  '
> >
> > +test_expect_success SHA1 'show-index works OK outside a repository' '
> > +	nongit git show-index <foo.idx
> > +'

So how does this behave with SHA256? Does it raise an error? Does it
segfault?

I think it's okay to fail with SHA256 for now, but I'd like the
failure behaviour to be cleanish. So I'd prefer to not skip the test
completely, but adapt our expectations based on the hash algo. Or have
two separate tests, one for each hash, that explicitly init the repo
with `git init --ref-format=$hash`, and then exercise the behaviour for
each of them.

> >  test_expect_success !PTHREADS,!FAIL_PREREQS \
> >  	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
> >  	test_must_fail git index-pack --threads=2 2>err &&
> > --
> > 2.47.0.107.g34b6ce9b30
> 
> These all look reasonable and as-expected to me. Patrick (CC'd) has been
> reviewing similar changes elsewhere, so I'd like him to chime in as well
> on whether or not this looks good to go.

Ah, thanks. I've missed this topic somehow.

Patrick
