Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FAE299927
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888988; cv=none; b=M7gkv6hHLyqljKhEqotZb89siSP92IKGEhX6CITrNnI6hPfFXlC3fHWFGczlnKjx40fobLguqD1ArZ3inkO6xW9Z7ITnNSMw5+OU9pv4bs8F1lkXfrQljymZcXlPcHs2vhBGTHqTTOvwJqTqlxNcA0DRePdxQpAUuqsxJ/pN9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888988; c=relaxed/simple;
	bh=x66oV/exBQ7njzt/np/TullN6qrw/kmlcrV0AsDdOC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Scg49q9rNQRQi4o+kuQKfgf1MpYAaP6/s3lnA1yy2g0FLqZrMgYjkwd8zC4o44kjbeHlxeL+u9liBkbGMXb8Tlo+3G2ukEdhNjyNqi4kT6oqBjI5BDhrG7zDmTr7SwRhhnfqzUrdP6mc2baM9TDSdez8/DqTBOX4Zt4KteI9iQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FNPCdyDC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NMHZo6Wr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FNPCdyDC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NMHZo6Wr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E023EC0109;
	Wed,  1 Jul 2026 02:56:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 02:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782888986; x=1782975386; bh=Ab1HzoBZq3
	P/QhtWmJeAOhQynKAUELvmpWNPgd3i3f0=; b=FNPCdyDCDk7a5ycNYDj6mpOj6i
	9CLzBxiyDBP+HwcTwn1Gw9tXqXqvYf+9YU1choj/RK2t5MPLqp2FSfvIGFzfJlZd
	AGmcl6ph4cA5rs4zJPVYGZM5xg44BJl5549r42LnkAqjyyEk7r0YH4r8N8NSS2vM
	Axrdwilc87HaCuxZ9IBmGs3t7yf17/iuiXxiDhqc0MA04CJRT2o35ahFPuWRVdMW
	OmhTCMXdM9LsjXpKAYEVR1DLkvEUL8EwIDQ5SBNO/qeMr1xHjgedPlHFfgWwrsNs
	KPl3FNWi5l2YXajGGMTnhVLtSpwmmqqMLObkCZ1hAoAK83LMoYAAXdn/cA6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782888986; x=1782975386; bh=Ab1HzoBZq3P/QhtWmJeAOhQynKAUELvmpWN
	Pgd3i3f0=; b=NMHZo6WrUPfFlm4aFvmNUu4Y6d5CjVuONTeHirEfzQoz4g5GFrS
	gMdzAlMYbKI9Hak+AkfcKEEYdejqUOQV6hp19ZqOvHiPzoU2olaKRviwUeaYhtRJ
	aK4iRkO4FU0q0c9S5Z7gGc2rcB1KTLJ1nfc/GRkydHIDGdsFAaFkwb6OJ3O/TrLD
	lHV6LTn65FUF/kHtbqtjchtnQa+3vtrxWOnfqz3RmSK/sd994io/3qyXcfpg5wGy
	yjLscf5cO2PH6QdbiIr2PacWHqnw8Pat5PpTxsmKvGJvSsRZ15dsCnSXbiM2926d
	PTHuTRzGLYqzeR0IqSOUNVgNBK5NFMimW1Q==
X-ME-Sender: <xms:GrpEan_WXulSlaMTDs2UOjgFbADsHSQkw6M0FHjmslnW3K2zFA8Gpw>
    <xme:GrpEaqsuWtS70pi85OxbYysM1YAwdQaS6sNOlyyvrV7Oh2Qcu3ieXInir0bBFUMt5
    e8FM1da9gip8Krp5fwPKAk6cCHGV64sEKx-kEPkEvchkNxB-W5YNQ>
X-ME-Received: <xmr:GrpEaqCO4S2MLljf_nNxgwfJIWdgFNnzYPetBXzcF3bIf3aXDrvk9Ci6yykjm_0jWBJjNwhC8MRexhlwvK4HX_1y1R97NQGuDszRnmkIo4M>
X-ME-Proxy-Cause: dmFkZTE9ndjbSRtMlcUOqYN0RSMFe4EofFGH33gDnuajVkMF630Z8A+gzg8T7osxUOB8OH
    Va3zwc4KOJ1v3H9Ej9jmbL/dQ0+241bZktM0Cs2LPmUqUuvIRa1SCInVW4v+gNfAeNHfY5
    tXyj6Xzh09RfUD/2mOfuXFBdMm3xBoBR8kqVK7Zu8rrvl3oKe4cemLNY//pdSsSbfm9WEG
    YK+N3ImXROh4Wz0gyAIuowiNZ1HBTB4ERso8wAe7bNxJFWKWTytKKWz/7zehtmgtrqOBNv
    VaELCUimYJCUe66M7aCPXhsa6gRBWBKENQrP9gy9oGLSz6bkeTysILySlsW8YsCDZ6rLXB
    moiazPZEZfQT9N/bzxKKPzmNKhtMCKD3PJpBwz62XKbm1ltQ6NjaHqFjZtKVeQKCIG9cNW
    gHchuYULiniw+4lFYmzoA4MsJykSMHN/jk9r6tQPnddzutd6B+NJkX4qAleAXs5XcELkK0
    WH//0TBDVahy17zvHmg2yrBmG4qyOnEZiiWNGBWJs43CNbXsu+ytAjkV61YlTycrVrd24q
    Ksco8TeOX/nTeAPD1pOu4h+B6QXg8Ze06fck5Rva9CcEN1AQyfkRbr0/RAF8ETxnDzl3NM
    5vdYtvZZVaIZ8Z3D+b+FUQ0HtwE9ojpvcrW+dVfYO/TWio6jUZXji4hk8IdA
X-ME-Proxy: <xmx:GrpEaiWIzUOvjtl9-FRsyamZKrxDhAFgOKBJgX8eaIXkE_oFFG1xzw>
    <xmx:GrpEaoBrMczjoRAHQ9GAPONd6i0yxhTmFedyEi0i8T45e-L5onRsMA>
    <xmx:GrpEal8TNsA0_igf4wrGMNMiLSmhq9Y8a3yoryqOKDrOaOQ-fQQelQ>
    <xmx:GrpEavGs7DGR7Do8EfTnFhRixEb42a0tgH1rlmJVoijIHBCnhlxH8w>
    <xmx:GrpEat9x9XiU3l3O9tqSfPGPfaYA4pU03gCshgS5Mg_Iu1b8i2qLySGF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 02:56:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df90c555 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 06:56:24 +0000 (UTC)
Date: Wed, 1 Jul 2026 08:56:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Michael Montalbo <mmontalbo@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/3] fixing expensive http test timeouts
Message-ID: <akS6FZGSmwAA8Gdi@pks.im>
References: <20260626051657.GB3138423@coredump.intra.peff.net>
 <aj5ZaZK7xylfs4Xw@pks.im>
 <CAC2QwmLkHUymvtYbjY8aQO9_VogvaSXdbb1_DSZtcBttGfN0tg@mail.gmail.com>
 <20260628075716.GA3525066@coredump.intra.peff.net>
 <akIfsaVMB_S6kfJQ@pks.im>
 <xmqqldbxz9z4.fsf@gitster.g>
 <akKYv3nqX0BXcavu@pks.im>
 <xmqqik71xqtc.fsf@gitster.g>
 <akOGzAq8Is7ghgIM@pks.im>
 <xmqq8q7vsukl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8q7vsukl.fsf@gitster.g>

On Tue, Jun 30, 2026 at 12:21:30PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The pipelines of the official mirror can be found at [1]. We might for
> > example add something like the below patch to our README.md to make it
> > more discoverable.
> >
> > Patrick
> >
> > [1]: https://gitlab.com/git-scm/git/-/pipelines
> >
> > diff --git a/README.md b/README.md
> > index d87bca1b8c..9ad77fdf7e 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -1,4 +1,5 @@
> > -[![Build status](https://github.com/git/git/workflows/CI/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
> > +[![GitHub build status](https://github.com/git/git/workflows/CI/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
> > +[![GitLab build status](https://gitlab.com/git-scm/git/badges/master/pipeline.svg)](https://gitlab.com/git-scm/git/-/pipelines?ref=master)
> >  
> >  Git - fast, scalable, distributed revision control system
> >  =========================================================
> 
> Oh, nice.  We of course do not want to be heavily involved in
> advertising offerings by commercial entities but I think these two
> sites deserve one line each for their continued service to the
> community ;-)

Okay, I'll send a patch then. Thanks!

Patrick
