Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE601E4AB
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289498; cv=none; b=glXFXMo7A44dfxiavNDVtXDrVelvPlSiLGsKNd0I4znxGKCdpYp5u6U4Hi6aWC5EZrbT5vTbkwrjXt5xvVWKMP4HmdSJbyiMBh9W1bg3a3yQLLWDElYc3rB85hbWFRpc840DqhwMCkC1nwWBvHUn2Cav1BI8YH8SPA9moOE2aaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289498; c=relaxed/simple;
	bh=Y7XgUME74jEQ0mZh1Xdd5IKCfT9uyqSeQvECV/OvUS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bu/YgQdnUtyajsYwVf89NuASq7rxJaCXjRwzA4dCUE7pcJFHw1bA+JFYLgOyNrzLr9AjWd8P5HDF7kdbNltR9HwUtkshteOWe3T5HAt6My28y5+GmRR7Id6Wzf6zSr43A+cZel0vXxGxSaaQE44jznzNnnT6MgtZ2PkKm3likHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iXeYmzFX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LiDpHD/C; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iXeYmzFX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LiDpHD/C"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B11F9EC00FA;
	Tue, 13 Jan 2026 02:31:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 13 Jan 2026 02:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768289496;
	 x=1768375896; bh=xuOAIvk+j5OZxmLUfBn9/brOAHNwSXl5TtPJ0SOYJvo=; b=
	iXeYmzFXTTcVkDN55bLJilfoCqKe/VlQ68V+sYxIJ4ySGWD9jU+zfulFji72RwHF
	E1ddeEv6QursSNqwOeBt7Wmx6zOc3WSa0Jn00CPTxKQft8IINqqwdUO9PQtETmB6
	jlQwmdd/NrT1G5jDFGP5HjaX+goujKvxzLF2jT22dXK1CYWwl2k21Lj7o/hdHLx8
	tIom6O7PeHDCZM1ztICE1B33Ii2ugaGTFwJivNdeVvcjqE3ZbiIyF2J3vL0AHhdI
	9ZKncy/qj1nBlDqPq2eGPqYcXShstD/SPAzjroT9FwDX6SUdPoEjkZZ3v+SCoGFO
	ONURbfNz3qaw59tQ0mnRLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768289496; x=
	1768375896; bh=xuOAIvk+j5OZxmLUfBn9/brOAHNwSXl5TtPJ0SOYJvo=; b=L
	iDpHD/CZAsH3aflANHG5AW7kn8xiMlmD8t81zyKHFxW+4Df9eSlnWT4GE+H882DX
	Zzfd6VXDdbSwvViqIJEJaKFRkGp9doIxBbhBhbkFRbETukkGJ981qPXgKUW2r9hq
	z4fTqO2NBZnCBXbtJy0UV5uZ2/huSTktWS8QJT8+Ms7tTgC9nvwR9QMrbMPCVl6y
	Ak8K9qIfZpR0zunjj9n6wjQKWBr53rFxjk93DwHKxPCJMCCncmgWXm7AVvzYisW5
	AEiUxwc1kwM8PTfeMgCOSvDpZJ/bAlGNK1q/fZRnhpVkvL1iLsTIinNfK1VQBVz2
	nGDRu63+05oPC7o1Qrm3w==
X-ME-Sender: <xms:2PRlaQ4ls44H_Bk-skDs-4faSIK53pCKkaj054j4rxBgG8bScS3Adg>
    <xme:2PRladvFqr_RjZCbgoUBxD8k5RzYxd2xxNxF0xdbEGdWWe9OLKwC86St0iau5b95V
    D7LbFq12WNwgoX6nfKOzYUP0Ngv4fTw6aX_cKY6Hkl_Nir5EyOOvA>
X-ME-Received: <xmr:2PRlaa05riE7B5BxibrIPxD-lkQO83-5vMXKXQvtAD3GEqw0LcIrda9Zp5ngRgsS5suStoZGgdpJJozkdbHIYfoKKvIAagXDFQogvHRgfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeljeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetheffvddtleettdetueeukedugeettedutdegueeukeetheefueevvdeitddtveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsohhrghgrnhhovhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2PRlaeo5KkNmAvKC9ygnUo0kTSw1OXvcIjqAKwCqCQ1jHOmbc7AtKA>
    <xmx:2PRlaSJ7RR8HQ3KzTzrYaQ7yNUMbmjKuHdkuL1rWVIxY5QM1Q8dF8A>
    <xmx:2PRlaSTLjOeaS48rrSYo4p9k50YTnfVJknGqLMSl0XhpRX9unHH_LA>
    <xmx:2PRlaSPkPVwvtUN83Fp_dcRaBn8GxIA0j4EmFhaoxGBTbYYnLitQmw>
    <xmx:2PRlaS4mOPJ1cv0_5HDzXkqeMvcFH2Z9AnNDqbws8kFVXDmYDzxU67rd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 02:31:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 31f18771 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 07:31:33 +0000 (UTC)
Date: Tue, 13 Jan 2026 08:31:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v10 1/8] builtin/replay: extract core logic to replay
 revisions
Message-ID: <aWX0055xT2PKzgfa@pks.im>
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
 <20260112-b4-pks-history-builtin-v10-1-e3c6aa5b4cec@pks.im>
 <CABPp-BGOcMRerGpH5HGkUR4-DKPx+VmkWzqRt8qideZoJBrvHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGOcMRerGpH5HGkUR4-DKPx+VmkWzqRt8qideZoJBrvHg@mail.gmail.com>

On Mon, Jan 12, 2026 at 10:00:06PM -0800, Elijah Newren wrote:
> On Mon, Jan 12, 2026 at 6:17 AM Patrick Steinhardt <ps@pks.im> wrote:
> > @@ -253,6 +254,137 @@ static struct commit *pick_regular_commit(struct repository *repo,
> [...]
> > +       if (!result.clean) {
> > +               out->merge_conflict = true;
> > +               ret = -1;
> 
> Even if you keep the special merge_conflict field for other purposes,
> setting ret to -1 here still feels very wrong.  Negative return codes,
> and especially -1, is used throughout the merge machinery to signal
> unexpected errors like failure to read/write to disk.  Further, it's
> inconsistent with how builtin/merge-tree.c works, where both in code
> and in documentation merge result code is 0 == clean, 1 == merge
> conflicts.  I'm worried using -1 here could cause some nasty future
> maintenance headaches trying to understand the field if left this way,
> at least for me.  As mentioned in the last round, the ret value here
> should be 1.

To expand a bit why I prefer my style: it's extremely easy to get the
return code wrong. We have a bunch of callsites that set the return code
directly, and in theory we now have to vet every single such call site
to verify that it will never return an error code of 1. If any function
does, then exiting with 1 now becomes ambiguous. This is an error
waiting to happen.

With being explicit about the error code and the specific condition we
care about we make that issue go away. Furthermore, it also helps to
document intent in the code as it is very explicit now.

In any case, I don't want this disagreement to block the patch series,
so I'll adapt to make it return a positive value on a conflict.

> > @@ -306,21 +438,11 @@ int cmd_replay(int argc,
> [...]
> > -       die_for_incompatible_opt2(!!advance_name_opt, "--advance",
> > -                                 contained, "--contained");
> > +       die_for_incompatible_opt2(!!opts.advance, "--advance",
> > +                                 opts.contained, "--contained");
> 
> This predates your patch, but I'm wondering if there's anything we
> should do to clarify and/or simplify the first check.  The original
> form of the check
>      +       die_for_incompatible_opt2(!!opts.advance, "--advance",
>      +                                 opts.contained, "--contained");
> was created because (a) I had code that allowed --onto to be implicit
> in some cases, and (b) I was thinking only of --onto and --advance
> modes.
> 
> However: (a) we got rid of the implicit mode selection from my private
> branch, and (b) Siddharth added patches which added a --revert mode.
> Those patches caused confusion around the interplay of --contained
> with the new mode
> (https://lore.kernel.org/git/xmqq3460ocv7.fsf@gitster.g/).  I thought
> the synopsis:
>            "([--contained] --onto <newbase> | --advance <branch>) "
> implied clearly enough that --contained is a sub-mode of --onto, but
> apparently that wasn't the case.  Perhaps we can strengthen that
> understanding if we change the check here to instead be something like
>    if (opts.contained && !opts.onto)
>       die("--onto must be specified if --contained is")
> 
> Definitely not critical; but might be a nice cleanup.
> 
> > +       die_for_incompatible_opt2(!!opts.advance, "--advance",
> > +                                 !!opts.onto, "--onto");
> 
> Yeah, and Siddharth can convert this to a die_for_incompatible_opt3()
> call, adding "--revert" to it when he rerolls his series on top of
> yours.

Fair, but this feels somewhat unrelated to my changes. So I'll not touch
this part and leave it for a future patch series to clean up, if that's
alright with you.

> > -       /* Return */
> > -       if (ret < 0)
> > -               exit(128);
> > -       return ret ? 0 : 1;
> > +       if (ret) {
> > +               if (result.merge_conflict)
> > +                       return 1;
> > +               return 128;
> > +       }
> > +
> > +       return 0;
> >  }
> 
> You mentioned that you wanted to keep the merge_conflict field due to
> some future patches beyond the currently submitted series.  I wonder
> if it'd make more sense to introduce that field once you introduce the
> new patches, but i don't feel too strongly about that.  I do feel
> strongly that the place where you set ret to -1 is problematic and
> should be changed to 1.

I'll drop the field for now.

Patrick
