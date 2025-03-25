Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A0258CE6
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906615; cv=none; b=YsHPIgy9SqX9tsPCCaCkbaucDp33N+E79tMPDQfIvckVeBN3RkSkhsbZKujGUDOFTU7t20eFA+dhvr5H3pxPtMGGvDQMM/PCxw5/hrvMjq5CaV10sKDeBAiDSxdoKp2yfF3MKk6LT18ZhmrpC3aGf7gponLC4hwye3Dpb7fcd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906615; c=relaxed/simple;
	bh=nuaEIhoxo6V+ODG0SJu/S8bqcmWAv5I3gXCJH5A7nJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bi5wKXGkkVZvvQ7uNVyODRQtGpSGBNj9eVeqPb8wqXYuiFCMhEGITZsEbaesrICoDye1W/zjcjPxTL7+PF9FfLullmQjbucIgns6Rnq+W76eyw4kmRnp4ctdkkYEM1+/kJoWyXOE8tL+WcMrUxp201u10FyXbesYvrxP9OOnrm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S97HE2er; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PhG4s85+; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S97HE2er";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PhG4s85+"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D5E0114006F;
	Tue, 25 Mar 2025 08:43:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Mar 2025 08:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742906612; x=1742993012; bh=fhcsPM2LrV
	FP8fTdRJQ3RdwhdU/0JcVfSAwdMncEl6k=; b=S97HE2erW2ZWFyq4Qvm/1FTZEh
	s9yOxsCawahFcEdxDCEH/PybVd0t/o1kaejcMXYBlNQhOF8dRFX/bWM/ZKat2fzz
	7GXDJYYmp8EN5OEmXoj4yqv7P0vs86Beqh9zGkTOtWn5RDA1nSwE5wzGezWdHjH+
	4rg2Hco5Z90LEolXSkR+xbj3o0qb4kyAqqGymmZfgyh+iKZdkZC2s4MyFkCS7qEp
	H0pVjdrIu+iSfJ5kDALpjyQYvDPRGsV1yXaTjXIR8H1b40aVg2uRioOQ+OnZk5p8
	+qlD5yFgt50C83HA+C190ZKx67y0hZRIPZC8I0NYajtdu/stPbIaZx0PbRKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742906612; x=1742993012; bh=fhcsPM2LrVFP8fTdRJQ3RdwhdU/0JcVfSAw
	dMncEl6k=; b=PhG4s85+hYGX1PRUwCtHxJ1+EbBUZJsNu06Wg60Zm/0+OnQwMGn
	nlnXX+dnFCucuRATWWwKl9u/CyLjOFR+DOxWEzGUEWsscoYp3MTb42rn9+8g7yyA
	ljiOK1VAgQLk3ZQRHjvEUtyfZxBK5ZW2wystT9DU0VEC77y0pOfj4el9H0XDVFpL
	b9WFE8wuwlgN3B9bm+YNbpqqI7OO3wCRO+BBuma8CF+O78OJlUm1vQM2TiPyzuLz
	vCg1vjVCrvxfAnhCWOZbhcSJJzr+VU07f9wAg2ac4eKE2CMRmANuOjCk+IBUQu2R
	bwWOEL6s1s/Tv5fDLeqMXb4pzejNIjvwdUA==
X-ME-Sender: <xms:9KTiZ5HRAPajw3ivCO1c7HL441O65atn_pUtkP89evFRjFGtTjxmRA>
    <xme:9KTiZ-WcQ7I7My6HGJkuEy5OAXmefMtAuv9CoqFa0MR9wamS8zS1gqHNeQhzgNSq6
    NhxoqwVXKadcNBzmQ>
X-ME-Received: <xmr:9KTiZ7LjO9aPUcSyNAcqr4WYML_4YvN-RDBlPmzQw6coC_C48124D5f81aTbxJHKHifI2gNmYGUEZCY0MGO_qEPhcD0FYnT5uMeO1nM1wHxHNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdr
    ohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9KTiZ_FKDY_kN-VYV-aQJBtiyHLIuK-bX8EbvbXtDS8mPnT1cq0n2A>
    <xmx:9KTiZ_UybSrU6otKQWsVpHIrwX2oBmfEyx0QJoBD5tVknEh_cPHjJA>
    <xmx:9KTiZ6NsCR39dvDsE7d_nHSMPfMiqy9MmBum7JngRzbwrbBRlj8GUA>
    <xmx:9KTiZ-1Ef8dV6kqSDGuQl0yJ3gqFM9ChAakl7MJ-6XXGOrJ39NMO5w>
    <xmx:9KTiZ6Sj525MhF5t9SYbpQZAIdZoKSJAFvv-9Zx-YTlUeSzD7lbJYIg9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 08:43:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 064d3456 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 12:43:30 +0000 (UTC)
Date: Tue, 25 Mar 2025 13:43:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 13/20] t: refactor tests depending on Perl for textconv
 scripts
Message-ID: <Z-Kk8c4INZilK8jM@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
 <20250320-b4-pks-t-perlless-v1-13-b1eefe27ac55@pks.im>
 <80c2e84e-6603-4e96-8934-8219c55d4d36@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c2e84e-6603-4e96-8934-8219c55d4d36@gmail.com>

On Mon, Mar 24, 2025 at 04:16:22PM +0000, Phillip Wood wrote:
> Hi Patrick
> 
> On 20/03/2025 09:35, Patrick Steinhardt wrote:
> > We have a couple of tests that depend on Perl for textconv scripts.
> > Refactor these tests to instead be implemented via shell utilities so
> > that we can drop a couple of PERL_TEST_HELPERS prerequisites.
> > 
> > Note that not all of the conversions are a one-to-one equivalent to the
> > previous textconv scripts. But that's not really needed in the first
> > place: we only care that the textconv script does something, and that
> > can be verified trivially without having a full-blown invocation of
> > hexdump. So at times, the implementation of the textconv scripts is
> > reduced to their bare minimum.
> > > -cat >hexdump <<'EOF'
> > -#!/bin/sh
> > -"$PERL_PATH" -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
> > -EOF
> > -chmod +x hexdump
> > -
> >   test_expect_success 'setup binary file with history' '
> > +	write_script hexdump <<-\EOF &&
> > +	tr "\000\001" "01" <"$1"
> I guess it is fine just to handle the characters we expect at the moment (is
> that what the second paragraph of the commit message is referring to?), but
> the script it was more tolerant of future changes to the test data. We could
> always just use 'test-tool hexdump' here like the tests below but it is
> probably not worth a re-roll on its own.

That was my first version, but it required a bunch of changes to tests
all over the place. So I decided to simplify this test suite to do the
bare minimum.

Patrick
