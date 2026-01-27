Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC34329C5F
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769495398; cv=none; b=jSfUXgiejy3ef6u+bDEpnomGobEvMY4dSTKvihUXuhY+yucnVeTXvy5HMHZsj3M61qTA+I14+Ik/2YZBe1/gCTzPhyezGnwsFYq5jg2khNNEBnGK51SXnR66Jnhq9jByeVXfkTTYM0Ix50D2QGS9QIyZrNKS58Ub0KZfcyeTmoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769495398; c=relaxed/simple;
	bh=99eLSI0okIexEOW7nePOLVvFcSopJK2vVywLK9bePCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/4G6ggu0SUTYt17NLVuZVKTgnoz7HocPnmGCtYzdb306yjcACqVPIEcK1l6/+XaXuuGRmv4o61Oamq/xRj3hGm66//r43b9LMpxNY5VXfZet9zg22m5MPeWHe6F56i0r9MRiiS5o7nAweWs4fqaN6rYzidoWYubt2rNCMTGKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S/mStkMn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UoCPlcWn; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S/mStkMn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UoCPlcWn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3792B1400182;
	Tue, 27 Jan 2026 01:29:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 27 Jan 2026 01:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769495395;
	 x=1769581795; bh=f15kjorqoLxpdPDNwpQcDiIta8RXZ5US57OGTDXrG70=; b=
	S/mStkMnUzY7lzUL5gZmyezOyWXorsZ9qaAA7nc3KJI5w8nan9niZ8Kyl/MrFDUV
	RNsuppII1e/emm7HIrSUWni7o6PQ+ZbfH94NtldILkSayDJ5aX+BKjYUetvy0Ycf
	dKwFwwXp5gS77AQ99K2ysPdv2/ESG8BUi8Gcd7fnbb8wjRpzUtr3bWmysQmkvyRA
	2Ruw07WK/FmlElYCLq712gIX0j+hLA1ijpmhDrqQl7tbW5U8aCNzLA+TM7CvS8qH
	uoBXsaN3DLeXLywq0gz02Wco+EzVTU143gOWpn1wL2Nk+FQdu5iQaNpX4mFoxGkk
	CWgKX5nsbeKon3YC8C1YwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769495395; x=
	1769581795; bh=f15kjorqoLxpdPDNwpQcDiIta8RXZ5US57OGTDXrG70=; b=U
	oCPlcWn1pC+fkNDqQD0n+WPl6ElXRXIGZInCG/gndpLK/8mumD/y0pNMaVmC3iHZ
	g2KJVjHQzuDak7eCJnV5v4U+4bcFf+tQSoVWDMYspZ4yUC2YfLSE8SaAZXKRUUFY
	gQxxLdoNFFMc7I1rovFSTXYhVIyChspzboDd7oHaMTJp1+nXCQ6rdbSov0IbWNTZ
	JCWBNIDnJUMYEjEg9zxQ4PBHp4RGK2BQRd+yqbNX+TWGXaOHRtLJrg10hIGi/R4X
	wsCGawD5yWB8wgOwQn14QfLjJmGfWt3gyTP4MeIvxxwiOij4rFcr1nxYwnLYW006
	Me2NE9eDiA1GHHIjGoizg==
X-ME-Sender: <xms:Ylt4aXWIWqjPogZjQwahISFm8X28QV0K9Y7JgiizmwksOWN-Eg6DRQ>
    <xme:Ylt4aXAv0_jJshSCr2TUFwKj2GNfvPsNj3cKE6get5MDwyPh50RPq3G2dlI3aCRc4
    dtzhHw4Ttt91iaJWTr36cqpvlGbd_A-Sbo5dlkie4PJG2E5SK3BOA>
X-ME-Received: <xmr:Ylt4aQzbR76l6jLovOTULpzb5yJoRxzMocvUgewfVl50SoKGQ38kkFoYrVBM8sy4Qck9orKl4PNpO4vJjGOkUzRlnKDpRTyJqHPlXfPhbdsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    eplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:Ylt4acCPP9OZrhJA2VVb1SAPkSv56bJB0OB-4bgHYPFfjXCifWIyzA>
    <xmx:Ylt4aVYwmHyl07P9KBDyAdEDDS6cL-BKCQLzkFnxJyZJUmTFe7QIFw>
    <xmx:Ylt4achZE_a7szvM7VY5A_qeSDTdzvo0QzCUJCP7QcOA2Uy7h2l3Rg>
    <xmx:Ylt4af7zGctl0qYEcr6oj1rYT0M4BTgTxFkncF6EYGuTBaNylSjm1g>
    <xmx:Y1t4aUpyV0ng8wkR_2s67QlzhVORDjGbMU39j2BwSuQJY77f8Ik4sJO6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 01:29:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b5b29ad0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Jan 2026 06:29:52 +0000 (UTC)
Date: Tue, 27 Jan 2026 07:29:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] odb: drop gaps in object info flag values
Message-ID: <aXhbXQo6taM33m-1@pks.im>
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
 <20260126-b4-pks-read-object-info-flags-v1-3-e682a003b17c@pks.im>
 <xmqqa4y0jop7.fsf@gitster.g>
 <add7c86f-9d5e-4136-8c3d-a04df523487b@web.de>
 <xmqqpl6wi6n4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpl6wi6n4.fsf@gitster.g>

On Mon, Jan 26, 2026 at 10:13:51AM -0800, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
> >> I wonder if this series can be restructured a bit to demonstrate the
> >> benefit of moving to enum a bit more prominently.  For example, even
> >> at the end of the three patches, odb_read_object_info_extended()
> >> still takes an "unsigned flags" parameter, but it is meant to take
> >> this new enum, isn't it?  If we do the "#define to enum" conversion
> >> (without renumbering) first, then "unsigned to enum", would it, with
> >> appropriate compiler warning flags, already reveal the existing bugs
> >> that happened to be working OK as potential problems?  And with that,
> >> fixes in 1/3 and 2/3 would demonstrate why #define to enum" is worth
> >> doing very well.  And after all that, we can renumber the enums in a
> >> separate and final step.
> > With -Wenum-conversion you can get GCC to report implicit conversions
> > between different enum types (like in the backfill case), but I don't
> > see a way to warn about conversions from int (the fsck case).
> 
> Yes, that is why I suggested "unsigned to enum" change after doing
> "#define to enum" conversion.  If a caller passes an enum with
> HAS_OBJECT_* to odb_read_object_info_extended() that expects
> "unsigned flags", it would not be warned, but if the callee expects
> "enum object_info_flags", passing HAS_OBJECT_* enum to it would be
> flagged, right?  We may need to give the currently-unnamed enum with
> HAS_OBJECT_* a name first.

You can get it to generate a warning for one of the callsites:

    ../builtin/backfill.c:71:9: error: implicit conversion from enumeration type 'enum odb_object_info_flag' to different enumeration type 'enum odb_has_object_flag' [-Werror,-Wenum-conversion]
       70 |                 if (!odb_has_object(ctx->repo->objects, &list->oid[i],
          |                      ~~~~~~~~~~~~~~
       71 |                                     OBJECT_INFO_FOR_PREFETCH))
          |                                     ^~~~~~~~~~~~~~~~~~~~~~~~
    1 error generated.

Unfortunately, the other callsite wouldn't see a warning because we pass
an integer constant, and the compiler doesn't complain about that at
all. It also falls apart once you start to OR multiple flags together.

It would be great if there was a way to tell the compiler that a given
flags field expects only enum values so that it could always warn about
misuse. But I'm not aware of any way to do this.

We could of course start to take a more heavy-handed approach and always
accept an options struct instead. E.g.

    struct odb_read_object_info_options {
            unsigned lookup_replace : 1,
                     quick : 1,
                     skip_fetch_object : 1,
                     for_prefetch : 1,
                     die_if_corrupt : 1;
    };

That would give us full type safety, and it would be impossible to
misuse without getting a compiler warning. Furthermore, with designated
initializers it wouldn't be _that_ awful to use:

	if (!odb_read_object_extended(ctx->repo->objects, &list->oid[i],
				      (struct odb_read_object_info_options) {
		.skip_fetch_object = 1,
	}) < 0) {
		die("...");
	}

But I wouldn't exactly call it ergonomic, either.

So I'm not sure whether this partial protection would be worth it, but
if you think it is I'm happy to reroll.

Thanks!

Patrick
