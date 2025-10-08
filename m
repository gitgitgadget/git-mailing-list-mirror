Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB712F0676
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924425; cv=none; b=AqHDqec0OvdZ6AWRs6ZX1I3sJXlvR/kmko7R+OV4fuSKqEeSXDAFP9QmgHtPkL9NygiQ3Lou6qQ52vjqmDmc0LicVCsMqK9pxucRtCbyFUuwis81Ju1gkrqIVVigDHibPYVyTbFzoLVV4PwzeeSxYtpza7vnyLOO0556BblJuOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924425; c=relaxed/simple;
	bh=7z9UEHcOhXA1hkviGhJ37eRNU+JJlfc2NwwaF/Qe/dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3N8ogXMtK8QWrJQ+mt40tsT7WfRQ9eq23lBL3Id8WjDV6fGitQQLf2HqfqeLKHu6nHrc5T3icKiUq/NUllX25gAE93yg3Xl8frD82s+1PqrHDFuZi4VIuYOaetMaKQrJq8rhcd1cEpNWg57GDuntBNjmDD4v643RR2Xin89BGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ErTwiTgh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UIyeTO1l; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ErTwiTgh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UIyeTO1l"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A0687A01DD;
	Wed,  8 Oct 2025 07:53:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 08 Oct 2025 07:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759924422;
	 x=1760010822; bh=v8lXiJN2vcJICwvof6zFLjbBAzlQ8ByhNa0yxi5TGZk=; b=
	ErTwiTghsZU3i4fvYOHvLumXjq2d8V+Utwuu/RygmuQMpBgyjQ7G2Y6m9LZl08Z5
	h5unDoxm0RDHLvrloVKQ7R9mUJoFo86TkV3rF790PjumUoCozOo9XAbfIlzDG1A9
	zxAQj0leM9E3ecryDdFDi+1MCrOqQ9VC4Pj8d+w68pTdMxn0fhsbbXS3YqVIauvV
	cteZwOn+Pa+l6xL9spg3gvtmPq9PYuVECgUaxTgPUCHynO8UQqfGoRTC6tkIc/10
	81SJkayGUP3dxJPISP+kCSxi2tdlzYwtHuYt842MjzV0Fl7RaBnW75MWoXeMa7q/
	qAovONeF3cwcEWeP6p48Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759924422; x=
	1760010822; bh=v8lXiJN2vcJICwvof6zFLjbBAzlQ8ByhNa0yxi5TGZk=; b=U
	IyeTO1lCQVWOu9ANXyuvI8+ZA059QO5hIAGsWPRjRe9oncbSzUK1cpnnvlrfZ5qI
	9/KmTx4bZW7bQSThNkLlkJjV+FeIWzAllLoog/fT0hhNJBgUgczZSeVcqYPsJz6b
	nb+OlOJd1CgnqUFe2j0pXoEelLKuYj26kowuvBcRcWbRyt3SgIs5FDeVFGHih9Ws
	TT0kAw/LZbGHJfiiVfPPofJKi/hAWFw0PrdtO5AbzwNKXuRuya5mc5uCDKa4PY2+
	7SXirEHSpJthxlElA377FWvELGJjN7ksd6Nkj7JgJtAKKof6bEhD3OAUv+Q07yvy
	nHKbwBzVx7EvVxE+ASN3w==
X-ME-Sender: <xms:xlDmaCPceyLdxaBcnxxq89EFZvS6uq_QpL6pWUrkDW-ebK-i0KSPLA>
    <xme:xlDmaAAoMc9vW4z_U5Ljp-1kpl3uGvX_ToKDLGBOvHt8gG6h296mZVsol9DZSbXJE
    ZmG-55fj-fru-yZY_Op-ZuGv0SORZcI-g6Ld_svmyFi999Pc8L9MpA>
X-ME-Received: <xmr:xlDmaPfFatXpNtaEBRe-FbJkFaXuFxENvV3-_4ytE8LqQnwzO7tsVB0NdcLAfsttjN4suoy2YMo-HaJvMiwZ_uGokD0cxpNUG77Wt3mG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheptghhrhhi
    shhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:xlDmaPNR7_JA4nUUJBjOrU-HxNat5dz2ROH0q5S0U6vdJCU5sh2qvg>
    <xmx:xlDmaPLEyOHBhiawF-fTpIWOQU0l3HJaT-whe5iwWdqx5wMOncRlqA>
    <xmx:xlDmaPJEPc-7Du3YiNzxhlB_61RmNVfBE-YBhZwbaiFWcqpVXNlodw>
    <xmx:xlDmaJ4X4zaMgbOtu1Fm2AbW_y_6ucz-vsDVUiJYlDVcPwLVg6sWxQ>
    <xmx:xlDmaPCW2CRupom7rrcNv9_nzrfi33NGanZnT7PU4QlcVtPqaDBmuDYu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 07:53:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 36b092cd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 11:53:39 +0000 (UTC)
Date: Wed, 8 Oct 2025 13:53:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/5] fast-import: add '--signed-tags=<mode>' option
Message-ID: <aOZQwBZo90Gjn85m@pks.im>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-6-christian.couder@gmail.com>
 <aOYPYEk5sT6b1kuS@pks.im>
 <CAP8UFD0E+5K1yL1rj5jXVMX9hQyoA_sH0f=fUP6aCj==TtfAbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0E+5K1yL1rj5jXVMX9hQyoA_sH0f=fUP6aCj==TtfAbQ@mail.gmail.com>

On Wed, Oct 08, 2025 at 12:50:53PM +0200, Christian Couder wrote:
> On Wed, Oct 8, 2025 at 11:21 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Oct 07, 2025 at 02:29:58PM +0200, Christian Couder wrote:
> > > diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
> > > index 85ed7a7270..b74179a6c8 100644
> > > --- a/Documentation/git-fast-import.adoc
> > > +++ b/Documentation/git-fast-import.adoc
> > > @@ -66,6 +66,11 @@ fast-import stream! This option is enabled automatically for
> > >  remote-helpers that use the `import` capability, as they are
> > >  already trusted to run their own code.
> > >
> > > +--signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
> > > +     Specify how to handle signed tags.  Behaves in the same way
> > > +     as the same option in linkgit:git-fast-export[1], except that
> > > +     default is 'verbatim' (instead of 'abort').
> > > +
> >
> > Nit: I would've ordered this after "--signed-commits", mostly so that
> > these two are ordered alphabetically.
> 
> In the fast-export doc --signed-tags is before --signed-commits. Also
> in the previous patch series Junio mentioned that historically signed
> tags came before signed commits. And the other options are not sorted
> alphabetically.

Okay, makes sense.

> > > +     case SIGN_STRIP:
> > > +             /* Truncate the buffer to remove the signature */
> > > +             strbuf_setlen(msg, sig_offset);
> > > +             break;
> >
> > I'm not familiar with the signature format, so it's probably a dumb
> > question: does the signature always extend until the end of the tag
> > message? Doesn't the tag message come after it?
> 
> Users can add anything in a tag message, including signatures created
> however they want and copy-pasted there, followed by whatever content
> they want. I don't think we need to take care of those signatures,
> except perhaps to warn in our docs that Git could mistake them with
> the one Git creates.
> 
> When Git itself signs a tag, it appends the signature to the tag
> message. See do_sign() in "builtin/tag.c" for more details. It looks
> like 2 signatures can be created in "compat" mode, but the compat
> signature is added into an object header, not appended to the tag
> message.
> 
> So I think this is the right thing to do and relatively safe.

Okay, thanks for clarifying.

Patrick
