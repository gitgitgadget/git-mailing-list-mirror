Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B838D
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782809146; cv=none; b=a6F4n8essMva1U2bTI0H+hpXoyUEkS6a1fUtCGx99Fhc75l0L+WBQuE5YNV6NOrT2jTy3v6j631cjHaBJkvdr34kTiA6YjTrUnPVXYKgxln/IV9xMkt1f7wwYAy9dW65nM2vPCovcZKy/g4045d7iFZYpmKoUR3YJpFhZBK2XYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782809146; c=relaxed/simple;
	bh=Z2wv9myUw6HPhy7GbQbXiaS5yB9MIZBiN63JULEMZF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ/d0I30OBlbubBNvNvmwya6SFQ/n0XlKyGpwFGupIMBfftVDgOV4FBX5he5Bz4QSKZpODlpklSSud9a70szd9hMMM/hqOYk1vwtj1bn7lwh9g/uQrt/68vpOIRL6iJtvoA5jstF+0oxbWJir7PH0Gl5L8TR4o074SxTMImTimI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hw3D28I6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=knh0lpPA; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hw3D28I6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="knh0lpPA"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 6964D1D0011C;
	Tue, 30 Jun 2026 04:45:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 30 Jun 2026 04:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782809144; x=1782895544; bh=NK5xf4QS2/
	VdTQ5EPDfz4UiMfJ6qnsuGO1aKdb5zxxs=; b=Hw3D28I6pg1HmXSVVzFJmSuXWA
	fwUg7bgN4Hepr5DLMgSV36wqgXM64bdcm25o+mWNtNCwNKERlobQ1H3qJnnXQYa6
	tVmInn7Xva4VgOBd/H6TeCi585zm7tPZXBBpthXqJL7PkNfSHjJp3bbo73WhHJK7
	b+TNb9OezF5WEn8Zhh1vKiPF4rMPpkxunzg3kLMoXZ7QMDE/kCjXA/ZIJTlsZWUR
	Z23pFEEswYBoimLKqqBxWUPcj7Jxz6hF8HF2n6eOvVlVitLJvhjBpj+n615ZeZbF
	I96nqX3Y/sMzHz2GsSd/LcUGZiCV5jKr9TVvwVjggIgmwhXymXcyKWykUKIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782809144; x=1782895544; bh=NK5xf4QS2/VdTQ5EPDfz4UiMfJ6qnsuGO1a
	Kdb5zxxs=; b=knh0lpPAgK3EzdI2v+1Iwvfs/Nilcpd2VunXYKx6rTXz3eiO1/r
	c0x9VjVaYMWr2xu2SIlM8pfNLbtwAtaazax5mq6GLHLHnk8XBEVNbj3qv80yE0fD
	yGT3vjSF0T3gdcZOoo4vD6rkCWxyB2v8jp6pLsRzXcOlpwH9RtuJz5CQyXoaDUkg
	f4VUr1fXEGsiDClPssRZRc2w51yIbay0c7UgXz213RGA0qVG99ZqT1WXDuvsKqa9
	i37YcCfrmWKA8UCRyZ9N7wzQ3tdqX/w5kGx7Ua8MGjV9yGzhQlhPcz2NaqpSFDJg
	rJLZ8PzAeM2eEMtQXrOwOI1Mw3TgkupRF8g==
X-ME-Sender: <xms:OIJDajwBiOWmsUTL0xxVHk4uUaivvFmS-ma6psKqBdVWl08j-HkAyg>
    <xme:OIJDahQO6O9cS5pBb6NCm-xRbBOmawFiKzhBId_9c5ANGP1YsqZE9Z8G2g8IUZ08L
    p5j5cCHgXRSDWS_RYkSTl-03VvPQn1sTbD4QD9r3fqap6M1e4I-ZA>
X-ME-Received: <xmr:OIJDaq_sLCmT1Oz9UcOUaqQNSuDFHy0APUm8LGWCJdHxlLBNUh0Lgauo2GSjfPph-pJJQa_aHdyACxV-YZ9LGslKR9tiz0VyYSkoyIXreijRzw>
X-ME-Proxy-Cause: dmFkZTGc7sxv2TGyzY2QPNUj0p4U40BkcTr0mOHVuNfYZjooiKFk72DOzzS16x8anVv2ps
    RoqpSxFiiJKKE49lhe84SSY/u8FOif5Ttc5Ig1j8Z2LfeJunDtnxFgNsyNxyvE1Ob8OR25
    f/WBhEN3ZibgEqwNCOSS0IhW/6a27vuxx9NxHS90NLXSKnFG1e0yg7pVcIONe6/exuGOrH
    XXFDheDF49zUNS4EWKniXgJ0Hd2zSThRkHxgBgIVnvcS8Jb/btQbtLmbs9HWOpl85AB0tH
    5kEt99HUbNJ4MdBA5k7FX7lE5EVH7h/Sxdvmh0C7HbfLkgBrPqG4qVxSZ5oNWZaNHRoOo8
    gnXrJEVIkv3nlj3oRjWsRF1C4f86DJTs14me3qJ5sBGlqTQqpDoHzFO72dQrx62v3Wpb3T
    vvE+q1f2KN59KY7EE/fJHSgOpiOSRWGQFehwbRPoJUD3fdgJLLJJvfZ1Q0rZB6kNXiPNH/
    KXlabsW3Ub6ew4SdNfE4Z3jMFQ+6JVaKgzgFvZUiZuKuhVtdGpO1FoPab+MYeGZ5oOpKAQ
    8yIbpnGOiJ6wDCCkF3vkUbXp1PEIdWQo671LsGj9mQaNWKMvcwJB0OKwO/7993PxGbxlfU
    RBIx6tglZqI83SwAAMhr8lOzrd0jxe4RjYBisg9/jYmbxd+Hsh5+zuVSqz+Q
X-ME-Proxy: <xmx:OIJDaopJ9P-UpnHmPZCo1-sjzyG5rY3rz3hatXDHWej6miv9XetCSQ>
    <xmx:OIJDannJE9YDbcsKhXF7m_oQB4W09YX5neCNBUiu_-A_WU3834RcCQ>
    <xmx:OIJDavJpkzTlmzNlR2BV4zoUtjN50w7YLKcnT-_HrQb0plVRbeqLLA>
    <xmx:OIJDasw6oDYHU2Akj5KYy5G5LPF1rJKdSvk09IKtKTIEn37MVKc7aQ>
    <xmx:OIJDaviva7HvC-nAI9yP5bnXyGmy6IGcmeJNgU-spu3989RxiaTIGNSN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 04:45:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a1667ad5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 08:45:41 +0000 (UTC)
Date: Tue, 30 Jun 2026 10:45:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] builtin/receive-pack: stage incoming objects via ODB
 transactions
Message-ID: <akOCM8qVi2r9YPsF@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-7-jltobler@gmail.com>
 <aju_AmlKVi5UZaiQ@pks.im>
 <akLLB_J-pvJ7iR7c@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akLLB_J-pvJ7iR7c@denethor>

On Mon, Jun 29, 2026 at 03:25:18PM -0500, Justin Tobler wrote:
> On 26/06/24 01:26PM, Patrick Steinhardt wrote:
> > On Tue, Jun 23, 2026 at 11:19:20PM -0500, Justin Tobler wrote:
> > > Objects received by git-receive-pack(1) are quarantined in a temporary
> > > "incoming" directory and migrated into the object database prior to the
> > > reference updates. The quarantine is currently managed through
> > > `tmp_objdir` directly. In a pluggable ODB future, how exactly an object
> > > gets written to a transaction may vary for a given ODB source. Refactor
> > > git-receive-pack(1) to use the ODB transaction interfaces to manage the
> > > object staging area in a more agnostic manner accordingly.
> > > 
> > > Note that the temporary directory created for git-receive-pack(1) is
> > > eagerly created and uses a different prefix name. This behavior is
> > 
> > A different prefix name compared to what?
> 
> Currently the temporary directories created for ODB transactions all use
> the prefix "bulk-fsync". The temp dir created by git-receive-pack(1) is
> expected to have the prefix "incoming".
> 
> > > special cased in the "files" backend by having `odb_transaction_begin()`
> > > callers that require this behavior provide an `ODB_TRANSACTION_RECEIVE`
> > > flag.
> > 
> > Okay. I guess this is to retain existing behaviour where the temporary
> > directory is created lazily everywhere else. Makes me wonder whether we
> > should eventually change this to just unconditionally create the
> > directory in all cases so that we can drop this new flag.
> 
> It would be nice to not have to have a flag here, but if we want to also
> keep the existing temp dir prefixes, we would also need to keep the
> flags.

Fair. Makes me wonder whether we really need to keep the exact same
naming for this temporary directory. This is so deep into internals that
I'm not sure whether we really need to treat this as part of our
interface. I'm rather inclined to say it's not necessary.

In any case, I think it's fine to defer that discussion and keep this
as-is for now. But we might keep it in the back of our minds and maybe
simplify this in a subsequent patch series.

> > > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > > index 19eb6a1b61..ee8e03e2ab 100644
> > > --- a/builtin/receive-pack.c
> > > +++ b/builtin/receive-pack.c
> > > @@ -2326,7 +2323,8 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
> > >  		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
> > >  }
> > >  
> > > -static const char *unpack(int err_fd, struct shallow_info *si)
> > > +static const char *unpack(int err_fd, struct shallow_info *si,
> > > +			  struct odb_transaction *transaction)
> > >  {
> > >  	struct pack_header hdr;
> > >  	const char *hdr_err;
> > 
> > It feels a bit weird that we sometimes pass the transaction as
> > parameter, whereas othertimes we access it via `the_repository`.
> 
> That's fair. I was trying to avoid the churn of wiring to all its
> callsites, but it's probably best to be consistent. Maybe it would be
> fine to just create a transaction global like we do for the reference
> transaction?

My first kneejerk reaction was "no", but then I noticed that the global
variable you're talking about is local to "builtin/receive-pack.c". So
that might be an okayish solution.

Thanks!

Patrick
