Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2414BF92
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223006; cv=none; b=JhZv6d4lYFQ7pj7g+99p3b7TNQ5xfnmg5K5UyEMoaaDW9DuNLji6n+D9jAKmPJusEDW9qsWz6rFpDoqJDJLGK+MVbhSrhTn0USzSsjJWIx32bqu6r1uDRpYKk2b6gQAQHBW60vcFoOT1JsArmIuQJsbrEVbzGIRlm42E04+VEjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223006; c=relaxed/simple;
	bh=T/A2WW+WvhWELouu+BsSQIWLccEiFR4idA6tkHcQ3CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYedROTr2mPj/f2c4vZIxDvpR0GGV/XiI6YBMo94gVxMwhm39MEvFOATnU4j1sWbQcnVnxpcRsIC1dZRDRlbPKm+GDpoR65o6tMWWthzzJ4bwJTTYqW5DxlaAVoZ97D4eaGVInTkQdGuyD0exmXWut8Hr1Q4G0UGZVaQsuJNBj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C+gsmhKO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0er8Z+5C; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C+gsmhKO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0er8Z+5C"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 24468EC009E;
	Mon, 12 Jan 2026 08:03:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 12 Jan 2026 08:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768223004;
	 x=1768309404; bh=M+13zFsr8lzZivleGB7S4akqWFcVKOKe0YejOQPsSlk=; b=
	C+gsmhKOfkZvuI41WepSMNZd3AUmrcpDcYjpgU5uYGTIpx3oAT4iUeDBKsl6OVUW
	VJzabkNo98QBLS3KY3dGxkJnSVoY9Q0PciEmY2v9QbZWgSbK7nOnUotNzfvc5ZJi
	KUXvyyQ+96zlJGx547FgzPK5mOsIbTJmRlZR/VSAIIwG7fZdFHg+r6HhfsuzF7KF
	HYrhrSgbGA81kXko5F+NjGCGaGeBIkllivNUHLLbSBtYzTQ8JqYjNV9pY8emX1v0
	dcWWjQZQLmeCq8siCGPdlcjig/nHnQAXLM+J1+n622cNcRIM7MhtEWeN7eGDhHVr
	2Jqvputt0pOCa6Ro0w7Bpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768223004; x=
	1768309404; bh=M+13zFsr8lzZivleGB7S4akqWFcVKOKe0YejOQPsSlk=; b=0
	er8Z+5CqRrC4IdcDIqD0pZxK6xB8dNVii8IIJKoNOBwscDNCjTTx2mb3ntX5t0LW
	2VCNy7qEhCmLrN0pINDMvPe1hvFQ4JWaStKNI2Rk+oSnSVpNLL02u6j5WNhSd3AX
	1lmkWaEgZ4DKeoUnXmixXbShTKRDHXgbb1SyeS3gZ4+fslJeI9Y2oKLQuGYmryD/
	8gg+aoNaq/C3K2OURFZHkW5lUZDDWcoKsXpQc4/QD0xIHp4G9X4jBP9FDjIDsEb6
	yTHzFzOLzJyzVfdqSvKVwY2bkrri86LTPnz/+ZmYSSd50o1PAHqZxJ9ohz/sK+p7
	05cnvDppj1hfWfZK8b0yQ==
X-ME-Sender: <xms:HPFkaXZh7AF3TwlVhSrBEg_VRS-xnDHuAhJwYsSYLC3aVBgJyj43pg>
    <xme:HPFkaSPuLhtt8zUkzsfa7re3e4pV-NLgAbshx7F3aUDr4uBO3xlQlRUiReAtid--o
    tBV9I6TwHz6qsiyQ5Qxe0uE7JEl9ruZ1a-NvgCATixvEhPsDrUYDg>
X-ME-Received: <xmr:HPFkaVUQhGfovEp1FbfP6uTESaMPDu7pMrf7iHJQmEDKfwWvX1tpaqplWaEtl0XNwItKayRhsBT1_R0Og2T84LKgCwvSAdsoWtcLoRgo_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrihhlsegsvg
    ihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehmrghrthhinhhvohhniiesghhm
    rghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehs
    iigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrg
    esfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:HPFkaXKP8bCPsxjo8dNFvIKbUNufB9JyMbvfpa7Vz_u_1dxhxc8_nQ>
    <xmx:HPFkaQoWXb2wcy534-f9LcL-LAgnwmOPFsIB4Vy5J96TXzf4G2xJKw>
    <xmx:HPFkaewvpmojqBAAb-T79l9oc6vLjBR8G5S_CBaSDxegHiSAntOfjg>
    <xmx:HPFkaUt9-VY8hVkbAalPlRJsQap-Qm2tG_g2zIzJ3ngbwq20igG1ww>
    <xmx:HPFkaRZyeSVoWp3MfCkVq2xAJ-2rmmAV7dghC-LCn4hHW8zeZg2vvvOe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 08:03:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3f50b7bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 13:03:22 +0000 (UTC)
Date: Mon, 12 Jan 2026 14:03:19 +0100
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
Subject: Re: [PATCH v9 4/7] replay: yield the object ID of the final
 rewritten commit
Message-ID: <aWTxF0xRiCm49lng@pks.im>
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
 <20260109-b4-pks-history-builtin-v9-4-8766101814c6@pks.im>
 <CABPp-BFXsZe5k-2qbkTfMaU7xxpViiHACOG+vwiRnf9xemd0QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFXsZe5k-2qbkTfMaU7xxpViiHACOG+vwiRnf9xemd0QA@mail.gmail.com>

On Fri, Jan 09, 2026 at 05:17:02PM -0800, Elijah Newren wrote:
> On Fri, Jan 9, 2026 at 12:35 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/replay.h b/replay.h
> > index 84bc8a7a5b..f8f9889112 100644
> > --- a/replay.h
> > +++ b/replay.h
> > @@ -46,6 +46,22 @@ struct replay_result {
> >
> >         /* Set to true in case the replay failed with a merge conflict. */
> >         bool merge_conflict;
> > +
> > +       /*
> > +        * The final object ID that was rewritten. Note that this field has
> > +        * somewhat special semantics and may or may not be what you want:
> > +        *
> > +        *   - If no commits were rewritten it will remain uninitialized.
> > +        *
> > +        *   - If a thicket of branches is rewritten it is undefined in which
> > +        *     order those branches will be rewritten, and thus the final object
> > +        *     ID may point to a different commit than you'd expect.
> > +        *
> > +        * That being said, this field can still be useful when you know that
> > +        * you only replay a single strand of commits. In that case, the final
> > +        * commit will point to the tip of the rewritten strand of commits.
> > +        */
> > +       struct object_id final_oid;
> >  };
> 
> I don't understand why this is needed for the usecase you provide.
> Are you perhaps trying to rewrite a set of commits whose tip is not a
> branch or something (directly contradicting your first paragraph of
> the commit message)?  That's the only case I can think of where this
> would be useful, unless I'm missing something?

It's the case where you're rewriting a detached HEAD. But I'll discard
this commit in favor of what you've posted.

Thanks!

Patrick
