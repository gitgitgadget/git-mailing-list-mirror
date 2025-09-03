Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7ED7262F
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756874243; cv=none; b=W8sxmIT9otohQIlSEzM4Tc24Aw+ZqX47cmH8CDZ3wB5TcnAys7ogKeaz78WWJ1MshgykAyPxjRIF3SwoyshMLTOEiIgJjoj1SFhOKVbcSkJzf15DBo4G/ibzJZwYFt1Pz3gYse0lv+bNoWFaSy3RMaFgx8hIzdGa8LV3+S57/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756874243; c=relaxed/simple;
	bh=rF/vtxH8esHRwIW7AmujCfVfIRtAX25srU0CuFlz9HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nftQd1vdHLlLC5922FUdh5qYqzCR9xZaCQgxLWL5mPP4ElhHzzJjBY+aA35hFmGL2OBdRB2fRhZMYfszZZ9W88ZCJI4qdNurv+GGiuA1zYCfHWwcjdxf1CqnjTGlCZrUEpONiwbsSnS4qisS1ecaPVCvmCABtN3IOA5LFpuMOuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bxQzIOSi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oTjn3d1m; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bxQzIOSi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oTjn3d1m"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 15133EC0337;
	Wed,  3 Sep 2025 00:37:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 03 Sep 2025 00:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756874239; x=1756960639; bh=H/EokLJk2e
	rfbN1je5r5rHOEnEI6e4gaZ4CIla/dPEQ=; b=bxQzIOSiXvItpaQHuxcFlbCgdB
	HOsdaGuoT6jDTM8UaYSCCSuzrsv90LYumcjl7HEv51i4rXlBtDleCQnc2M/hf00R
	0Z6OZRb8pJSeQPrzN5tB63eQ7JyBc3HFC10IC4fM235ZFLYgHJIS9NsBnUFLSVs0
	nAUdcduoN/8dOL9B2t5qWOG8/jUT/JQGvLMnZFv2/EdAiRMy1yDzNbmBzS9MesJS
	8QpYLAhxbTHu/ZtGUVNnpzUxZLIX2TxEd/7Ix5bsxhCsqKffKliILS4ImjtsNRbt
	3Gytif6W0T5rmp00i+Gg6sHXodu8awnrTOxs/ZF+b5KZjixWgTrgKEcZyLLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756874239; x=1756960639; bh=H/EokLJk2erfbN1je5r5rHOEnEI6e4gaZ4C
	Ila/dPEQ=; b=oTjn3d1m+1MTmGl5eJuMPKKFf6AfA89Pe4HN+02UI7TaR1QZ5/N
	J9bJt9JRk9WSrsMjLOn5Wti8wBjhl7z+VTkjdmEvQtNRSX9dZk6/syxj2g9K0f/b
	OTRQfoKRd7ptwIdiaUdVylrl3c30RF0VzO4G1s7YF4qa5T8W0B8Nr1J5VjABMyE6
	voBsvNUES9tW6uXXM3HOsW4w2aAyyHi9a9TB7qXm+LVXOWav3Fngq9HrMZLmdHMx
	qlIgq4Xh5ZC8VwUjM4H0CT5UuDGB/0UzJkBASVL+0Sph5M/01CR9xcyRNAHSFcfo
	VoEtj/cHhwC3kk0Orb9w10QIx8VGV6QdHNg==
X-ME-Sender: <xms:_sW3aFQi4mIx5PO-rgFXk4LNlXv4Z4vWC6EOViJuZujs8dZCUgP9Ug>
    <xme:_sW3aCAeDveLw_RZkK_7r1XJqbIbYu2fOYHEp-I9lE8_blBwPijgxLQ_tY4_uPIMR
    j7nSqCPc_geJQ-dNw>
X-ME-Received: <xmr:_sW3aEQXXk6_8nLpkXovbyJ4s5zLmrZXSPgvmopq450G6yh4Kp2-ZV272mhdr_9q8_17MjtnWS7fFipqeufX_At8rVg4X6hSYl5ppg8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    mhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:_sW3aIp7CLzqH8R8UPUQPc658bh4p1BQMOqn7fjaiqu8-_Nf7H7lsA>
    <xmx:_sW3aOwWZEjcmrhQTXXF238PbIFp4w2UBovRo26Jf9WFke-sMUIOog>
    <xmx:_sW3aFLUmPbr2FDpQE8_kn6RMOMxxsCd3WZrSm2tKf_Q5zZ5PAf-8Q>
    <xmx:_sW3aILTmohplz4WjUl_Ui4sAzVcFiHPmOW42EY_VqIAeqekGylUrA>
    <xmx:_8W3aE86GjR8lDwU5UGwRZoLLs0EWO0L8KTQTsFXJSR8R63VlfXtvpDa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 00:37:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bce1193e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 04:37:15 +0000 (UTC)
Date: Wed, 3 Sep 2025 06:37:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Subject: Re: [GSoC][PATCH 1/5] builtin/pack-refs: factor out core logic into
 a helper
Message-ID: <aLfF-GWlp3ESnSU-@pks.im>
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
 <20250826073645.1074397-2-meetsoni3017@gmail.com>
 <aLbEWSHUotkmSiCq@pks.im>
 <CAPhwyn1qm3CmYmupEdCzisdAC_uteWeBN05oZk0dqdPCty34yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhwyn1qm3CmYmupEdCzisdAC_uteWeBN05oZk0dqdPCty34yw@mail.gmail.com>

On Wed, Sep 03, 2025 at 09:26:37AM +0530, Meet Soni wrote:
> On Tue, 2 Sept 2025 at 15:48, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Aug 26, 2025 at 01:06:41PM +0530, Meet Soni wrote:
> > > The implementation of `git pack-refs` is monolithic within
> > > `cmd_pack_refs()`, making it impossible to share its logic with other
> > > commands. To enable code reuse for the upcoming `git refs optimize`
> > > subcommand, refactor the core logic into a shared helper function.
> > >
> > > Introduce a new `pack-refs.h` header to define the public interface
> > > for this shared logic. It contains the declaration for a new helper
> > > function, `pack_refs_core()`, and a macro for the common usage
> > > options.
> > >
> > > Move the option parsing and packing logic from `cmd_pack_refs()` into a
> > > new helper function named `pack_refs_core()`. This helper is made
> > > generic by accepting the command's usage string as a parameter.
> > >
> > > The original `cmd_pack_refs()` is simplified to a thin wrapper that
> > > is only responsible for defining its specific usage array and calling
> > > the shared helper.
> > >
> > > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > > Mentored-by: shejialuo <shejialuo@gmail.com>
> > > Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> > > ---
> > >  builtin/pack-refs.c | 31 ++++++++++++++++++++-----------
> > >  pack-refs.h         | 22 ++++++++++++++++++++++
> > >  2 files changed, 42 insertions(+), 11 deletions(-)
> > >  create mode 100644 pack-refs.h
> >
> > Shouldn't that header live in "builtin/pack-refs.h"? Makes it way more
> > obvious that it exposes functions from "builtin/pack-refs.c".
> 
> I couldn't find any header files in the builtin/ directory. Also, since we
> placed the for-each-ref.h file in the root directory in our previous series, I
> decided to do the same here.

Hm. Honestly, I'd much rather also move "for-each-ref.h" into
"builtin/", as well. The logic is not part of libgit.a and specific to
the builtins, so I think it's preferable to have it in that directory.

Patrick
