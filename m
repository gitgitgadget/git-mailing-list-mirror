Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91528B65C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846556; cv=none; b=CFQT1bLwzH7nVnWalMczgOdGzd/Q8i9pDBAOzVbJmqeSHM1dRJjZFQf5aYVSqDK1aic9chLp4r51D+NSDVuI/pv+JRcEn5JCO1jOuggmpOwDGvCtS3H+TorpKoQHKrSbEUaHuGgbSJUFPNYcFC6ni6C3NGuj2JaRv62Uu/083nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846556; c=relaxed/simple;
	bh=KPI7BENcJQQKe3uBrz/qaykQ6lJVVdR1d0ZBVMJlf4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDNWxrpJSyaODVrFfQUsCxfiNNO9XiiqHZS1ev8L1RIXYg8DLvLV1p7H+vRfFElKj8JwYvlZFpccC8GrjCv2YweS8QYVDEqxyMXpvzf3GbepzXI4kLAqCTsdbiMBh/1O1x6E3Yp368x8Bc5gqC8RjVyfUzhdXt+kJ1sQeBkA78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jbgb0XLx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tjo1/DOW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jbgb0XLx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tjo1/DOW"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A0DE25400DC;
	Mon,  2 Jun 2025 02:42:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 02 Jun 2025 02:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748846553; x=1748932953; bh=B5EGe7a2zQ
	MO3Yv0rNf1vA2xr60+xXHJfJEi1Uqpaeg=; b=Jbgb0XLxvV4e96629v0+cqNM8F
	WFuGw/DVR2j2t12aFFOs/5n0UlL7C3u8WiYLg68FeklTlLT4xTbhoaUPOgXGtxZN
	ndDIwNEUGg7YyMOtBjDRmAlsdGGg/UOzec0s56K6ikvWcOvUctzLcGKpSXn3fQDX
	/7/hfthbdH5FrE5mI/LzYsomsHHoOI2RlQqdQ9h0nR8eIWcrEX9HwxrOhEkfo6Dv
	FV16/dTF9m3oRXgJWOHujDmZ/fJrp+ruc1wjEcaN9P966FX9OxKfmL9t4ADo2Euv
	IUWkXjAFpIFbqml7cWDJwPvbl26adPYIaodI8WItEpuIZDG4AGyOsh1NJBdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748846553; x=1748932953; bh=B5EGe7a2zQMO3Yv0rNf1vA2xr60+xXHJfJE
	i1Uqpaeg=; b=Tjo1/DOW2iosnWbG9FUwhwANjqv4grcXj/sIkCCwJoSkbFrddDg
	+GyUHbE6i6HXGbWkdJG1vzQHVpDPD2zKwwXVXk7l1vCaidK7VP2qmALlprs49nrb
	+s/WZtepftpaAf5+Hrzbij9FRhkB6IFC6FC275HlK+qCHaJQXtwYaKGhAdi18j07
	PJH/RSxlpcGiOFVHi548S+r6ncduZw9QYjSwCp5F4klwtU1W/2Kloaq5zfEoAXVB
	MNuM4YZThaOnUUcOPnvWSBNGg1eEhxQemHvvjpwd8COjkl+O1mAALtqfIs7jAJFM
	YE2CIKLlFROWYueRe5mJx8S4+mWYITMc5rA==
X-ME-Sender: <xms:2Uc9aC5BSlL05JhjrULQb5ZS38sX13bOl1bDv0AzLIguDQfQ934a5w>
    <xme:2Uc9aL4wiwIqNxw8DBnZMpf6OSrsjPKD8ToA-8fW1hMgjlDT22cinKj8Z_3MFQE4n
    V71vwPj5fuhHcFumw>
X-ME-Received: <xmr:2Uc9aBfNls0KgQ2PxIcJiX119y8AYHAmgK6ldhEWvkTtQ5vRlDKbXCQ87nWvunn9iP8PiiMRrw8sh_FrGXNHBwShmoGMMVjbxp52_yfWBJ6Rgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieeljeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2Uc9aPJoj03y91cQLFS-f25jYwaiIzLs1OPrlf8Yus94G9JhzTrK1g>
    <xmx:2Uc9aGLftLUikmlMWPdAq6dR-KWWJiAIu_msn5d8k-80pc-W8j136Q>
    <xmx:2Uc9aAzF80kSaACmeJu2ALCMjLNqR6apFY2c1Nq4jORMheha7MANEw>
    <xmx:2Uc9aKI_gQFD2Q9bNMTouj4x7ZLyp0mItQ6YtLqCtbe-qSMGSplcNw>
    <xmx:2Uc9aAZk9G2HdnG7LhkxD6syO-raVaGXLCiJmipuiWroLvird_7ZhJ1h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 02:42:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99773df1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 06:42:30 +0000 (UTC)
Date: Mon, 2 Jun 2025 08:42:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (May 2025, #07; Fri, 23)
Message-ID: <aD1H0EFE6lnWXBMs@pks.im>
References: <xmqqtt5au523.fsf@gitster.g>
 <aDV0jwaQ2DlcM0lZ@pks.im>
 <xmqqtt56ov4k.fsf@gitster.g>
 <shpx4piigp5sqgpbzx4vdgu4zdn7z3ykxhu2cdyjh5vpr6zbqb@rf2sxg6hukpd>
 <aDl-yd2fh4qVRB_V@pks.im>
 <xmqqwm9yf4gy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwm9yf4gy.fsf@gitster.g>

On Fri, May 30, 2025 at 09:28:13AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Yeah, I understand that confusion indeed. I don't think that the other
> > proposals we've got are a lot better, either:
> >
> >   - `odb_backend` was shot down because it may cause the association
> >     that one object database has one backend. But backends are per
> >     alternate, so there's a mismatch in expectations.
> 
> I do not see where that association would come from, though.  But I
> agree with the other objection that the word "backend" is more about
> implementation and less about an instance that is realized by that
> implementation, i.e. two such components that runs the code for a
> single backend may be part of a single object database.
> 
> >   - `odb_source` is better, but we now have the problem that we use
> >     "alternate" interchangably in most cases where we also use
> >     `odb_source`. This will likely lead to somewhat awkward interfaces.
> >
> > The problem with `odb_source` might eventually go away once we clearly
> > distinguish the "alternates" concept from the low-level mechanism to
> > access objects. But I'm just not certain at all whether it won't cause
> > more confusion when in most cases "alternates" and "sources" can be used
> > somewhat interchangably.
> >
> > I dunno. The more I think about this the more I start to like the
> > `odb_source` name.
> 
> Yeah, I do not mind calling the instantiation backed by a backend
> implementation a odb_source.
> 
> In any case, when deciding the terminology, we should look at what
> we currently have in the glossary and imagine how they should look
> like in the updated world.  Currently,
> 
>  - "alternate object database" is described as inheriting the
>    entirety of another "object database" (we deliberately do not say
>    that this other object database belongs to another repository, as
>    a standalone object database is a valid option).
> 
>  - "object database" is described as what holds a set of "objects".
>    There is no complication here ;-)
> 
> When treating the set of objects stored in $GIT_DIR/objects/??/
> directories (i.e. "loose objects") and the set of objects stored in
> $GIT_DIR/objects/pack/ directory (i.e. "packed objects") as two
> separate odb_something, with a vision that we may add different
> implementations of such collection later, it would be very confusing
> to call each of them "an alternate".  "source" may not be ideal, but
> it is the best among what we collectively have come up with, I think.

Okay, let's settle on `odb_source` then. I'll send a new version once I
have wrangled all the conflicts :) Thanks for the discussion, all!

Patrick
