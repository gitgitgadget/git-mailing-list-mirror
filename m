Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC731C69A
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820248; cv=none; b=GlnWD4xx5TCvbMHOIfOMUv32uAZ9D6LQl6J3caf1T0k9OtBeeHHtAhz4HI9XrA8t+7Noo+5OOHLgYqJi5Q6ewnT6qVUDWRhR40Jj6T5i3jUzHhzjtbzGxWcb2Do2GddiUJwzv22HXbEWwSKpKa6aEv3EhnbI9qD2pFX3v1bvblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820248; c=relaxed/simple;
	bh=/ditJpCv853Dw94QGgq/p9TuhhG4YZNtQX9MdjcqzME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMATXDaaJlvzhvGRjS8BqVQS+fJcgfsrQH3M+L03uZhkYYMsi/WE3LYOr6N1j+YXQ+CeGiis3ModsUvBL2w8K2mgbVVnvj2SSJJ6czMTLYUM4YNLRtkdH2ABKoSAlVzx/fZBqAmITbWnHKkSK0DrHOtSMMK9OBLgY9DAs/qeLwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AnUpsxUw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AnUpsxUw"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so4897359b3a.2
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713820246; x=1714425046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeAIrBFPfRPY5OmaMda9qYOU9PUdjejiGenXMO19ZFM=;
        b=AnUpsxUw62IKWZeYgzxHnbpk//9rkkiG7hrEk1LiabrAkF9MXAhwQ69sVPg/4Pzp/i
         xj9inamqYqGKYHeUQtiNrEsRogaBo0zHKQzU4oFT68WHMwm2JDoec058npGjT5pjdDjj
         R9QD0zEXbdqFe7iigiD6ReDdawaTPThq3DsQPBDoeqGPSv5ydc1SXiGMq1DUIpm1LgWe
         d1OnF96Ow1j12TWNkbGC6qrZFtZcBPlBZlvsGuV99EBfA7sJPeue/irhXrw7iSSQAPvN
         N80awRmcQlYI46rXldhxA4Rq+KMLMqRojYN19Krvfs8GgiF7MEFcpBZ/kd5nxWDf2ohI
         8TQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713820246; x=1714425046;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeAIrBFPfRPY5OmaMda9qYOU9PUdjejiGenXMO19ZFM=;
        b=gK6UK5QXaofjxOxS+wlgVLP1i68ri+Ze8msM3dqqhLXTX78Z6nPKP6oioAEutqQYW7
         20snBc/irryUjLjDgyrwTjxonoUKBTwFvnSWKZEymXrdlog0TNUkWg41l1+Y/Sr9ybq7
         TpfM3CyBgTnULggORLIrr2ciadlHkTn0oMyk0cVTTp/K8HnxodQ/d6ovYy7opOwgvlP9
         EPq883nLH4X5Jvp83tRh4EC8ds7+JN1QArsrHEYuqFPVFtces1KOIL6zfHyNjSCqLe6U
         lhlXLw7LIQgQ3m/3BtKi8eFpnsefsR8vO5NKb0zZ7Ux/SlaGRaABcOK3VAxeA/l9rJuH
         UcAA==
X-Gm-Message-State: AOJu0YxUM3Su7moAgJAUnLrAWAJjJhw03RB3h9qcxNXFT5EwSZ8eRvSQ
	U8gJB3JIuQsBrCB2S2V3P2hGgtZ1FBwCiXaIFvVYor1Mr3ydEWD7vscSX84YaQ==
X-Google-Smtp-Source: AGHT+IFZ6ZyNOQkC7RMZmFXRoFwwe+luHzlX1y9fZGifMaz8ltcehwIpY8JdHLPVC1TNujj85Fu7ZQ==
X-Received: by 2002:aa7:8883:0:b0:6ea:bf1c:9dfd with SMTP id z3-20020aa78883000000b006eabf1c9dfdmr15621278pfe.27.1713820246031;
        Mon, 22 Apr 2024 14:10:46 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:9a0d:5617:e916:3f0])
        by smtp.gmail.com with ESMTPSA id h5-20020a056a00000500b006ed4aa9d5c0sm8301112pfk.188.2024.04.22.14.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:10:45 -0700 (PDT)
Date: Mon, 22 Apr 2024 14:10:40 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, avarab@gmail.com, christian.couder@gmail.com,
	me@ttaylorr.com
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
Message-ID: <ZibSUPezSU3ZV1HA@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	avarab@gmail.com, christian.couder@gmail.com, me@ttaylorr.com
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
 <xmqq34rmi28h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34rmi28h.fsf@gitster.g>

On 2024.04.15 17:24, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > The Git project currently operates according to informal, unstated norms
> > when it comes to making bigger-picture decisions (above and beyond
> > individual patches and patch series). Document these norms so that
> > newcomers to the project can learn what to expect.
> 
> It would be a good idea to write things down to help newcomers, but
> the thing is, that we do not do that kind of design discussion +
> design review + implementaiton waterfall here very often (a notable
> exception was the sha256 transition design).  I am afraid that
> "according to informal unstated norms" is an overstatement.  We do
> not have any "process" concrete, nothing more than concensus
> building among amicable parties.
> 
> Most of the time, technical decisions are made on individual series
> and by the time the consensus is reached on the series that it is
> good, the implementation should be finished, and there is no
> separate "implementation" step.  Newcomers would probably want to
> become familiar with that part of the decision process before
> joining the "big picture" discussion, I suspect.

Yes, as I noted in the doc (but need to emphasize), I'm not intending to
describe day-to-day patch review here. I'm thinking more of larger-scale
discussions such as "Introducing Rust into the Git project" [1] or the
spinoff discussion "Defining a platform support policy" [2].

[1] https://lore.kernel.org/git/ZZ77NQkSuiRxRDwt@nand.local/
[2] https://lore.kernel.org/git/CAJoAoZnHGTFhfR6e6r=GMSfVbSNgLoHF-opaWYLbHppiuzi+Rg@mail.gmail.com/

While clearly nothing has been decided on those topics, it seems to me
at least that they follow a pattern of "discussion now, consensus
(hopefully) soon, implementation later".

Or do you think it's more accurate to say that we rarely/never make
decisions without patches? Does that mean it's pointless to start a
discussion without a patch series attached? I'm trying to decide whether
it's worth editing this doc for V2, or just starting over with a much
smaller one instead.

> > One particular blind spot for me is how the Project Leadership Committee
> > operates, or if that's even relevant to this doc.
> 
> I think this is the part PLC@SFC is supposed to be of relevance:
> 
> > +For non-technical decisions such as community norms or processes, it is up to
> > +the community as a whole to implement and sustain agreed-upon changes.
> 
> > +Anyone with an interest in the topic is welcome to discuss the matter. It is
> > +expected that all discussion will adhere to the Code of Conduct rules.
> 
> It is very much worth mentioning CoC here.
> 
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 3f2383a12c..a04da672c6 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -103,6 +103,7 @@ SP_ARTICLES += howto/coordinate-embargoed-releases
> >  API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
> >  SP_ARTICLES += $(API_DOCS)
> >  
> > +TECH_DOCS += DecisionMaking
> >  TECH_DOCS += ReviewingGuidelines
> >  TECH_DOCS += MyFirstContribution
> >  TECH_DOCS += MyFirstObjectWalk
> >
> > base-commit: 436d4e5b14df49870a897f64fe92c0ddc7017e4c
