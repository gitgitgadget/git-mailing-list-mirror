Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A01DF254
	for <git@vger.kernel.org>; Mon,  5 May 2025 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438740; cv=none; b=bXzj43m/EJ/Dnyz5OOJ2KLfDkLS+wVNuzPDBYFsxzlJygWwIj2Ew9DEcdIAZi5PkG4rzgkVHaHv1muW/DALPL4bCIzv/zVjpPsRYPB2u+OCflHXVvBaytTV3HBcvSN+peheAPjZtdoktgbV/TLqjjV06D8bBTOAgPyAxpxBdMM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438740; c=relaxed/simple;
	bh=6sZ2K/RUclelWHbti5/sGLM9Z+gzspAt+d9a4QuLfaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKxOpMdrIFihkT84iNB96NGxuSsIARQUVPY10ifdPs5mwE03kAPNYgZSKq5phNFeDjTqpJNXx4SRuj6SyuxdAG6P5S8uMfBQoGajGkWUgMpm4MmZda9JakKsKWBYZOYtzq57T6eOhavpDfZAHiHb+dUwVseKBKWQQBfwWguwL9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=u/SFheqv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCuMnRaV; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u/SFheqv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCuMnRaV"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 57F012540268;
	Mon,  5 May 2025 05:52:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 05:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746438736; x=1746525136; bh=Q+gRGeOwZ5
	s2ca4hXa5CEaTl7MWs9dZXPK5Be3S9f+k=; b=u/SFheqvgppsgeEuam6/h+ZvHD
	jMvwKfsJkwRG5ze0PX9drLnEFpRKUEO+MNWtEOrK0TjmShGYFkI8nsvpo8vY+hdh
	1Ad7Z3k3vyGEpxJurGF+Ap5WytxlMkdwo0szN9nAiVuF0VvB+TCWq2y6QcSGc6by
	B2Z8kX/XUmguzyyg7LjgdaaFJnocti9967kJmO5OnkrPmduZdpZUmNLIyJD5JPcx
	LJHArUtAAB5+pLa9L6878Fkbp3VKjjoNIIy2YJcl3WAsIR7Ccl9pHONDfI9avzgW
	yDkmw0XBh5e1exokCnIlFkVNac3dDI72tkip2YfDM8JAkLAxVKpFJD73KtOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746438736; x=1746525136; bh=Q+gRGeOwZ5s2ca4hXa5CEaTl7MWs9dZXPK5
	Be3S9f+k=; b=cCuMnRaVEMW0en/9vG09I/GpUFyXVtpE4Izq6dBQVT/klqU5U4F
	AM7ENdOwzfQAQNS6fOoYna0lrErvKbo/17PbldIVOVMxviWUjHuRT7GZet/lAzVd
	0xCSSPbbUDS5zN33UtTyyTHurq/hibSQKE5GWJI9R5UKCmEW/3UFei1RsrjLdQKg
	Gugdec16a3splsQ6ECd5aJpcgB8MGitxK211CPiLeIFLAqWRWDX4kEFDwstY3Oyf
	vrvJ9zWSAjbcTwLy1dyUoQPFGT91TQUk3zlC7mX9uZlam2kM9RLlVTnvYNlC+LRi
	4/lXbA0HTgboy831NnuMtJP8YpoXPu+/Ylg==
X-ME-Sender: <xms:UIoYaMovpwqTu_TB3aoSQ_a1JklpkRb12IWIq8QHEUlVtt_frIY3vg>
    <xme:UIoYaCrxTEAXfvFPbcUb7le8O3EWhIvjP4sUbzJzMBtE4ePR4ByRwkgPpib_Fc-yf
    KC5Um0lOL-qRSBTyg>
X-ME-Received: <xmr:UIoYaBPDhje_q-jwVA4B-orD0-bNB24GReYow0lK7e64fy7RVupDrobomr_RjvFzqbpL44vzGXfNrbCS4nwIFREXltw5Dn1NsimLIcPd7TB_Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhhf
    ohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhk
X-ME-Proxy: <xmx:UIoYaD6NC0w0WCtThQiVXFS41MkDPEv9d_-lhAYThZfDBxR29-0tlw>
    <xmx:UIoYaL6bPPewDk0qhO2XnqlyWTffCVMUxSa8Ns2R2UiO9SxAEPQeOQ>
    <xmx:UIoYaDigyZBGloEcE7vUrA21hy_jRSwWW6EbK_yMBA3fHRKnYhqj0g>
    <xmx:UIoYaF4ZCYLH5xuSV5lZv8nDbIJWUff2WpM7apW-Pt-SUJ4AJrWDTg>
    <xmx:UIoYaKe6T9oeDKqjEOte8upNqMfQTzS-AqE8ynHqX1zS_rrE1Sd_22d1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 05:52:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 265f24db (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 09:52:14 +0000 (UTC)
Date: Mon, 5 May 2025 11:52:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 09/10] t/unit-tests: convert reftable stack test to
 use clar
Message-ID: <aBiKTU0AfgZnOtHy@pks.im>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
 <20250429175302.23724-10-kuforiji98@gmail.com>
 <aBSXBv0oPOXpfC2i@pks.im>
 <CAGedMtc49Mur-M77krEZ7NbomKn1bTW-q1MuweQa0=Vh4M-hvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGedMtc49Mur-M77krEZ7NbomKn1bTW-q1MuweQa0=Vh4M-hvg@mail.gmail.com>

On Mon, May 05, 2025 at 10:11:18AM +0100, Seyi Chamber wrote:
> On Fri, 2 May 2025 at 10:57, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Apr 29, 2025 at 06:53:01PM +0100, Seyi Kuforiji wrote:
> > > diff --git a/t/meson.build b/t/meson.build
> > > index 756cb2a2dd..8fa00fc9ef 100644
> > > --- a/t/meson.build
> > > +++ b/t/meson.build
> > > @@ -1102,7 +1102,6 @@ integration_tests = [
> > >  # sufficient to catch missing test suites in our CI though.
> > >  foreach glob, tests : {
> > >    't[0-9][0-9][0-9][0-9]-*.sh': integration_tests,
> > > -  'unit-tests/t-*.c': unit_test_programs,
> > >    'unit-tests/u-*.c': clar_test_suites,
> > >  }
> > >    actual_tests = run_command(shell, '-c', 'ls ' + glob,
> >
> > Okay. Ideally this would be moved into the next commit where we remove
> > the infrastructure for our old-style unit tests, but we can't because
> > the glob matches nothing anymore and thus causes an error.
> >
> > Also, we have a "check-meson" target in "t/Makefile". Don't we have to
> > remove unit tests from there, too?
> >
> > Patrick
> 
> You are referring to this, yes?
> `@# awk acts up when trying to match single quotes, so we use \047 instead.
>     @mkdir -p mesontmp && \
>     printf "%s\n" \
>         "integration_tests t[0-9][0-9][0-9][0-9]-*.sh" \
>         "unit_test_programs unit-tests/t-*.c" \
>         "clar_test_suites unit-tests/u-*.c" | \
>     while read -r variable pattern; do \`
> 
> I've hardly taken a look at the `t/Makefile`, given my very little
> interaction with the file throughout the test conversions.

Yes, that's the part I was referring to.

Patrick
