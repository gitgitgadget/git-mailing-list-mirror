Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67C825EFA6
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820387; cv=none; b=XvUqusaf2ao7gn+V4vbYlo8E1z04sxNqQ42zd81ZdgUL+53ndyA/DFKbJbxQGZ9z2iwlOktG1n7SeEzqQE3j+MLDjzyhzVeBXEnhWgVpEnzUdQ03kIpwJPJ1Ew8meEw2j/oktAX7P8BG5rXfo0XW76ESL3V5NTR6XIFa3OR3t60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820387; c=relaxed/simple;
	bh=hCqcVeQrOAZH1/rUTZYaKf6wohzMpPgWdsjzl4X5Ilk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbKUG32PX1Si9tNdi2YwB/aFK2UqjjL8tkPgeZOKN0/v0q8l2/scF5YdmxkipX2axO24QNpSd1csjVBXSByyxI4x9/cvcKslpGMm6dJaYgJwZP2ot4lHYKoRxBkIoZdil+45w7lZKk0dy9XrNpgn/jh8POiBY2Hs7osU5hzHWdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MPTzT0f7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b4uKFmFJ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MPTzT0f7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b4uKFmFJ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D82D11400D1;
	Mon, 24 Mar 2025 08:46:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 24 Mar 2025 08:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742820384;
	 x=1742906784; bh=R3A5n5NThUO1D3depnQEeJoxE7C1e2Rgt6NzbhRCICI=; b=
	MPTzT0f7br1lPPikV36jwQ0eLzjeoU6WrvR/CtN3yB8BlTn+693ThXsbNH+40GoJ
	wdD/nq0eDOKx4+ETvbEQbcRQSRf2pZqdpxIIpF7dODEqwisHW2mt4R58P5TXYD9E
	Qtqy/iEptY9SKQ/ghFfZ8b+pZHSoVDQd5xGeiL2Je9ob/xCpkTxzCRStcwP5qvkV
	Zlk5dcLjPptNiQHnKprtGAp6a67jJur4ffIWjZVNPU39pwALRdyEECtv5nPTqcZ2
	pHcVhTq/8Nf4/kGfpQggxfBJj2prsX4DJS4gTzKUJC6PndsJoRUEE/78k5z5C3GZ
	RpyI5Q9qzLsWC6nXNPsAHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742820384; x=
	1742906784; bh=R3A5n5NThUO1D3depnQEeJoxE7C1e2Rgt6NzbhRCICI=; b=b
	4uKFmFJRtk5Pw/igWVYVvEbVAXaEz/Q/5G38gdhK4bfYCZ75cr+jm0CASMYxh/uA
	rc/cnvAOInl8WDetbH6kT6mJOl3GrXCKT/lldGm9OCJFIdSQnL6E9ruKM9yMPc1I
	BLVIABdUNAnDliLqY95oam8HbBo/jTI8KiJpM9p6dyczhR2EBn5nY4HRiulTvhng
	nGw7YJwMenc3+GKrMFRJav0EW7jExbIgddyIVjZtxOfb7yVAja2aShAVYqBIV5tE
	nyM55/Q1T5NzGYfB8OJ/4apOd8IlSxVXuOAe5QclUlA18NQhuXWrLDgqIFwa1RAz
	UNs3+QEKvdGsuhib0+4jQ==
X-ME-Sender: <xms:IFThZyBuy0bYtnlzoCMTBG-Sn7e0wdEymUfYvQRixWwj2S0pmKERXA>
    <xme:IFThZ8i_BHfWJ6yIyTL_DY7Bj21Kc_HBr--uOn782ZIEndMGe_Yyby84SIX6RK6s9
    r0wjiF1c5jUqlZQzw>
X-ME-Received: <xmr:IFThZ1mwEyUf3r80KscG9OUusggivRdaLxFzf-i0evJ6LblGSIsychTY-Z0XC1oo2kbeZFs-lsHoCgnBoqNKJv2lqzMh8CWxqtxh9IKNgdnhjXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtgho
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IFThZwx4wX7O6uOH4PuhPLpuhtn1vqWhWPitfkSkXpItKF5EB--Sxg>
    <xmx:IFThZ3SpjhneKQeZcUaAMV_0OGwesW1rihnEh9aX-S0g4UMaOBfNxA>
    <xmx:IFThZ7b60l1ZjCK-H7P0B-sRfjCNsAvuIuW7hUMOMwwS9ms240qMNA>
    <xmx:IFThZwTVeeb5jb9zUEMbt1AXsk30iGRRnd-JLkFBkW1QFT706gJbZQ>
    <xmx:IFThZxfB302O56dK2RzYmnMMl9Yk_DAhlQPfJeO-fF6Bb1KoGEjt69x_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 08:46:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 316acae4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 12:46:23 +0000 (UTC)
Date: Mon, 24 Mar 2025 13:46:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 15/20] t/lib-t6000: refactor `name_from_description()` to
 not depend on Perl
Message-ID: <Z-FUHrbyv8B1_Twp@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
 <20250320-b4-pks-t-perlless-v1-15-b1eefe27ac55@pks.im>
 <CAPig+cTE1K6bt-4v9sv9ywF7wwc5Od8s5scnLsvYPFGBU5HDHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTE1K6bt-4v9sv9ywF7wwc5Od8s5scnLsvYPFGBU5HDHg@mail.gmail.com>

On Thu, Mar 20, 2025 at 03:41:11PM -0400, Eric Sunshine wrote:
> On Thu, Mar 20, 2025 at 5:37 AM Patrick Steinhardt <ps@pks.im> wrote:
> > The `name_from_description()` test helper uses Perl to munge a given
> > description and convert it into a name. Refactor it to instead use a
> > combination of sed(1) and tr(1) so that we drop PERL_TEST_HELPERS
> > prerequisites in users of this library.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
> > @@ -109,13 +109,12 @@ check_output () {
> >  # All alphanums translated into -'s which are then compressed and stripped
> >  # from front and back.
> >  name_from_description () {
> > -       perl -pe '
> > -               s/[^A-Za-z0-9.]/-/g;
> > -               s/-+/-/g;
> > -               s/-$//;
> > -               s/^-//;
> > -               y/A-Z/a-z/;
> > -       '
> > +       sed \
> > +               -e 's/[^A-Za-z0-9.]/-/g' \
> > +               -e 's/--*/-/g' \
> > +               -e 's/-$//' \
> > +               -e 's/^-//' |
> > +       tr 'A-Z' 'a-z'
> >  }
> 
> Can't you just use sed's `y//` function directly instead of having to
> separately invoke a `tr` command?

Ah, of course, will change!

Patrick
