Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15311E50E
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933803; cv=none; b=jFqGpBtPlrg5i5KKBJx2aGHXFkptn017NgNmCjoj2I3jsj70kqWiW1cR715J44tnpEjRrCReDcoyrXXZ1BFqTjT/ebc/j2anT6xNp9OUwPLCnKmUJcGuAn5rkM14gdBOICfp6blC6genmwSSDmsQraQ3JQzjxYLLdZVdVyjjA/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933803; c=relaxed/simple;
	bh=y14JXaAr2RQz1THV80PLL8DDe/7wqeHFaLxDDRmNdWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfmyElSOcHqeuBpm5Ma/ijgPJCdo6cxrckVsJtHerNjAtu5nN724v9v8CgAZwBjSSvs5pUZ+X6z0lC6vxfeU4j6U2DhCwvB14ZSAO/xaN8ejV7QPoG/+R2bjuYG035T8VM42oQGsDUAb6DKzA6hY2XQSwpmLIGesRpNR2/g6fCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mFFrW93o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RI2K1MpE; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mFFrW93o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RI2K1MpE"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C2F57EC00A6;
	Mon, 15 Sep 2025 06:56:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 15 Sep 2025 06:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757933800;
	 x=1758020200; bh=CGQxnpjh5yUQVx3dB/7nZHTNJ/L1JSsv6lD6S+992kk=; b=
	mFFrW93o5cyP74mT2pCLUhIQPYgRp68P2Fr+AxDLlv6Qhc8DiPa5VULc4uOGSIxM
	zjbQ0J1EV2kkiKIDvsdah0Cgy9HjccB7Ylnq3ImRqmCpLKaS2bqoVVdzAggQcRT2
	dZ6gM15nw9gCs497tZqrdI0i7ftCPAXYAyn3/E3NTKj2MJNlZ6pk57DAWF+ghEiM
	ib/MbiN6LY9EA1rD08d8a6+Cm35h344dEYbMjCRBL+2SomBgWmnvqxbO9FOdakcj
	CqhoQtD3v/zR58k/kKOk8fIjkqpM+E3W7cwGV7LHt6xyuhPWpQP00+vkqAyJaPhz
	H1PIj8ik1S+wfhtyDTB0jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757933800; x=
	1758020200; bh=CGQxnpjh5yUQVx3dB/7nZHTNJ/L1JSsv6lD6S+992kk=; b=R
	I2K1MpE4PIgSP19ifUHhBeQG3KbbKFPt/nzCOsy1K0j1LnKVu4Fa4R5G5Wnskib+
	g3keD/2wIF3alEpecvsIjA5ya1V8g6bsOfbHfXxXfwK8wPl2De1AKy4ZuAiZwPCt
	2yqFzLKoZZBCJGMOmrbc1h9EvbuyVXW2nnIQSSeY9W/ZyjbARKdSsRuHoz357rz6
	fifGFzDbDI0WPP1xYRpBliziCuJfebFvX5LMp8dJ/3pCxdZ9bmF+0SMdQQk2xc16
	khf8XG8YaCD3CLFk8PKaorjckdhXh09I71JS30iqwoQNx3bD/Z61EjbufmitgU3o
	afNq8aGaRtSzUli2ntcew==
X-ME-Sender: <xms:6PDHaD_POg8GFhO7cMcHnKIQ624X62coutgwftbNXDGLwUQYiRzBuw>
    <xme:6PDHaMqV3ZVUtd9g4OVWFdap7kAonYa6BbGD61s_wi6XtRjba7vUanlgk7z7Q5vgF
    wv8jBRc2vDRmQcUYA>
X-ME-Received: <xmr:6PDHaMpgDZtoAGWb8wBdGyWEaCWSvu1bfQi-XyQWXVyIMJPD353W5Pw3ByxD7n20JYSa4hQeDqJ8QBnehT8JLl7JGO9yVQWVrbE7n3DzXX5NbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegthhhrihhstghooh
    hlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhs
    thihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstg
    hhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:6PDHaH1AHpju_xxBwaIB5Eyl7rfWaU7AbflpALw07DJmZDXxqTg2Ng>
    <xmx:6PDHaCHBxaxMbeMpTumQU723UOlHlsd33npT508zmMufcf2WAG2XVA>
    <xmx:6PDHaKEx5mbdajCRE51QeUolTOhls-LWKu4D4epTY7i0buFyOkrquQ>
    <xmx:6PDHaN6nuTGV6Bg1DBSMpo-nQHWz-h0SzMGXDs0yAPaT4n9Kz2yYVA>
    <xmx:6PDHaC_sRi7m4g3Mdt_T86ovp_D83rg5nhwY6cdFuz_oEj01W4hRSct5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 06:56:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b8ebb2d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 10:56:37 +0000 (UTC)
Date: Mon, 15 Sep 2025 12:56:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/2] fast-import: add '--signed-commits=<mode>' option
Message-ID: <aMfw4rboBOemzvr6@pks.im>
References: <20250912124042.2523683-1-christian.couder@gmail.com>
 <20250912124042.2523683-3-christian.couder@gmail.com>
 <aMex06JNPVeHaw_d@pks.im>
 <CAP8UFD3-3zjBBHP-Y9nLO-qEyhkWhD_pxFZhk6rzrC31LanDMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3-3zjBBHP-Y9nLO-qEyhkWhD_pxFZhk6rzrC31LanDMQ@mail.gmail.com>

On Mon, Sep 15, 2025 at 12:17:33PM +0200, Christian Couder wrote:
> On Mon, Sep 15, 2025 at 8:27 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Fri, Sep 12, 2025 at 02:40:42PM +0200, Christian Couder wrote:
> 
> > >
> > > -     /* Process signatures (up to 2: one "sha1" and one "sha256") */
> > >       while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
> > >               struct signature_data sig = { NULL, NULL, STRBUF_INIT };
> > >
> > > -             parse_one_signature(&sig, v);
> > > +             if (signed_commit_mode == SIGN_ABORT)
> > > +                     die(_("encountered signed commit; use "
> > > +                           "--signed-commits=<mode> to handle it"));
> > >
> > > -             if (!strcmp(sig.hash_algo, "sha1"))
> > > -                     store_signature(&sig_sha1, &sig, "SHA-1");
> > > -             else if (!strcmp(sig.hash_algo, "sha256"))
> > > -                     store_signature(&sig_sha256, &sig, "SHA-256");
> > > -             else
> > > -                     BUG("parse_one_signature() returned unknown hash algo");
> > > +             parse_one_signature(&sig, v);
> > >
> > > +             switch (signed_commit_mode) {
> > > +             case SIGN_ABORT:
> > > +                     BUG("SIGN_ABORT should be handled before calling parse_one_signature()");
> > > +                     break;
> >
> > Let's be defensive and convert this into a `default:` case so that any
> > unhandled value will cause a BUG.
> 
> Ok, maybe something like BUG("invalid signed_commit_mode value %d",
> signed_commit_mode) then?

Yeah, that should do the job.

Thanks!

Patrick
