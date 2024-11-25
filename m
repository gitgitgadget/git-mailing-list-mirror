Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9D84A2B
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 05:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513969; cv=none; b=XZLeeAqr5ANnaLHMG0JSFidRnB/KKfDbV1RzwjCUyrweE+Md1q3iBmiFheS+JdQd3O4pMt5SX+noIfBwBtjYhxILgruC5wYp+Jma5FEIMg5FDbF4aVH+TARWY+wx1GC9J4dVGv3YxHulUKFlCjazKaTML64gaNUxG0TmwJjGf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513969; c=relaxed/simple;
	bh=dvfsH3tMq1f36jHMWy7NAVh+mlOST97AkgLxJ1WBqvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpJKJYZxHi8Gam8J8/TIzv2isR134JpHiCyJzjD66SmbfamgqoMWjWeyEwhUbHTyf2+EoHwljdWlDxqIYZgWfkDznBgoDm6Ib32lHQT/qWCTmWeSIVAzwDCmXEZnYcVzHZ5NzaEBwiHMYaxc8VHU4s57CiT/0dyymDtlVgcpOaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h7WTjpcR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YJV1MFTr; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h7WTjpcR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YJV1MFTr"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D60C25400F5;
	Mon, 25 Nov 2024 00:52:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 25 Nov 2024 00:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732513966;
	 x=1732600366; bh=H/uvTEPl8NPXdkTPTylwvK6nSJpVIaHSMmTD3bIp2Nw=; b=
	h7WTjpcRHjvZD7ocl5wxqCMlkbHrY2XAoN2i7aLpM0YjbtZbrkKv3Dtxmed2BZtv
	etUaJCA/MUbcmX0qwvNwhEVr9IEfnYsF0ldlauUQnaE5P6muhSrQBX1shmN6aIRl
	F77DdVbvbgRLA36h9ZwTU3OXVSgx0dcS1TyJkRjEtVesJN/BQ42j2LB5hSFd6iHK
	w4dx+MG1T4z0WG1g4xndkiHqsJhsREB6FGXCTI0akL0WTbLR2XOiZ+QnbrOvknEp
	LefdPw27PWNrvRZG3eGNnMYWQ5NwIzkvCRvXzyiAfdz6VBhxCnFXBnWrysncfY8D
	MwEyTVnsxrqGqvQB2XL/YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732513966; x=
	1732600366; bh=H/uvTEPl8NPXdkTPTylwvK6nSJpVIaHSMmTD3bIp2Nw=; b=Y
	JV1MFTrXTdh2KN63PvAH5Z7PFdTWEvyvEZI1Sz1pOsdFt2tNarYfIY58lAC3QgrK
	QMokD3t2iI0GhGL4YJmxSI2UXJyeDINLmGRDSHcF8dksxtIhKlyXqdTJG6h6Cd0k
	LHzftUBn7F7QBCRZTd0I3BkDrf2unz5lx8KLgOeRx6LojMeqx77IJtuV/RhjNVbr
	2U+GS26/7GblDBwCtvtH3MogB/37yivw0Sb3lZ7WS7aqp+CVnJSMWqyLqgs/X9NY
	iVTP0jV8w32HAIyJn6NTNFAzd/4QTOLwqCtra6OE2d4TlG4+FYloe0KyEmCfQEvH
	XA459a2ZEtO2RrqwMK8hQ==
X-ME-Sender: <xms:rhBEZ5VoaI60B5P2gzlYhYL6CZSXcEUKl1OGud5cUgy55Gjaor1h6g>
    <xme:rhBEZ5mBvFfa0_KOK-vuS49M8cTySUrAjDBxpEYCg6lpI3R8BKQoM_CRSyDdP-kuU
    MxhEhsbWRfJ8SguWQ>
X-ME-Received: <xmr:rhBEZ1b8Htb6fk82TnJh3d7v7QnrHcVStw93ZjUMIQPyDvf366MjatLFBzaZ7u1nXf9PITDHDK-_TuZvrUUcQiHrS3ISmBbi7FRVatMHCw4pHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhkshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeekvdevhfeujeelhfefleekhffgffevffelffejudev
    iefffeekkeehueffkeeugfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpkhhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rhBEZ8UgEnqiRXTxhlhwJbCTB-s878CPu3XdFkA8TivS4P0y7Mn_ow>
    <xmx:rhBEZzm2CIuCYANlKz5M4Zcl3UXlunsR1VJ-MxyLYgYgKBwGqhuCZA>
    <xmx:rhBEZ5do3_G5c1o5MomZJiriBZJkMoySZZiGY7PYuoXThA8d6yR1oA>
    <xmx:rhBEZ9HD6IOYDopmzZ9r0bYtlCYng47NNArK6jZt_yjhwtO7e_kKwg>
    <xmx:rhBEZ8CbxgN-C7gB0LCe1s9qviRDzXqKhaaB7tvwCMI7uuWjcqvMi31u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 00:52:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b556774c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 05:51:45 +0000 (UTC)
Date: Mon, 25 Nov 2024 06:52:33 +0100
From: Patrick Steinhardt <pks@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/10] refs: skip collision checks in initial
 transactions
Message-ID: <Z0QQoTIS4ytoGsUM@pks.im>
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
 <20241120-pks-refs-optimize-migrations-v2-6-a233374b7452@pks.im>
 <CAP8UFD0i+ayKYwEitf7DYA-Hxo16d89LtHv2i89rHh9cPWR4LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0i+ayKYwEitf7DYA-Hxo16d89LtHv2i89rHh9cPWR4LA@mail.gmail.com>

On Wed, Nov 20, 2024 at 11:21:44AM +0100, Christian Couder wrote:
> On Wed, Nov 20, 2024 at 8:54 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > diff --git a/refs.c b/refs.c
> > index 0f10c565bbb4e0d91210c52a3221a224e4264d28..d690eb19b3fd7083a5309deb98738547e4f48040 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -2324,6 +2324,7 @@ int refs_verify_refname_available(struct ref_store *refs,
> >                                   const char *refname,
> >                                   const struct string_list *extras,
> >                                   const struct string_list *skip,
> > +                                 int initial_transaction,
> 
> Nit: Using 'unsigned int' instead of 'int' might be slightly better as
> the type would be the same as "transaction->flags &
> REF_TRANSACTION_FLAG_INITIAL" we pass as an argument below. It might
> also make it slightly simpler to convert "int initial_transaction" to
> "int flags" if we add more flags and need to do that in the future.
> (Other functions add an 'int initial_transaction' argument which could
> be an 'unsigned int' instead.)

Makes sense, will adapt.

Patrick
