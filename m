Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9F1224B0E
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 04:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755665921; cv=none; b=n//BVTRNP58QZk//hoANDgWPw/lID2Rwc5bq3AR3i4H4J1NqaOU/h7wx6bhPUaPljmHnUi0XSXHrQZyWjqfZrWYY4bic6FB3IYYYmWL+MUHjLZdurlEBTQiisNJIKI/OwsjOCvy21BfL+dM6LRE3DFWRyp85i/HJ7MHQgaWVCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755665921; c=relaxed/simple;
	bh=nCQ7RzFEjADI2yMeqEFA0IIQc88NbLo/ytNVv+s+m6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW7OX0HukNfGQ3vLv/40IIKrTlaS8JM5/BdQcK3x1nK8RFs8o5IrjUHhmCDcuyazRKmt1Hd6cl4LnhSztJfYt6DkA+wCD8t41V//pWKkHSEYA1i0JxDLCTdJThJTWPfcwJNmzeln5Eje4pInEVXJ7xcMM6vShzwFTsiKHepKVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pt+2nDfo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C0cE8gZu; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pt+2nDfo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C0cE8gZu"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A09BEC05A2;
	Wed, 20 Aug 2025 00:58:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 20 Aug 2025 00:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755665918; x=1755752318; bh=AfrGfib2dZ
	A/luqmWxs07Jqj12ZXJ1pfRydub9buhuw=; b=Pt+2nDfoRMqKVyCdGGWCrL+mA7
	VlIRA7v2vErT5eSGrq8fycVW5hI3FIvvv4mIE+yPka6obSw+TpkqP/wJX0RCZFVN
	6kLTHlwn0LqmYUQaAl8DhTQkboPJ1ALqY6WKEkh8XocLy53tbP0N4tviMcFdGsJb
	qNjyOnh8s+X63jrvIWq9O4Ii4639QRPrZzbPK0PiaIVuHL0rdlh6l6q3dmgXSlW0
	WZxKDPpXwj/gRHctlBhRCrIM0WT0MzXrkYS8J04jVTm+beDKsEZY0jhNAvtQ2VPn
	blCRYFqtwBmvoaZdsydIvrh5sseYQsvSscOpjvdCpAIL6hr50KHmkdKfcKIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755665918; x=1755752318; bh=AfrGfib2dZA/luqmWxs07Jqj12ZXJ1pfRyd
	ub9buhuw=; b=C0cE8gZuBEH0xfv72oPuuTrL1ZrkCatVKXvStc0xAGbytU79+cq
	s2KilFGenKl9OxL7cKrbZETZt3VPOyHm4AHJk2dRwLQZpYmEJCdSLlMpjfWVKpME
	Zy0t+3blr0Zy1KfZpepiVEhRf4r5kLPeWxySSFP/7PgHXMoba6yuJkujYsPDg/Um
	65hwWkZosZSP1L9/kHO10hql23jSh0dvVZPm40KmQGCUEtAP4gbgrKnhP5VMjYBz
	Z2zWCtvEPkuWNovuWWzJZE5FDpWnL4CONWl+gSIXDURDajnCYCKCh6UBzJXkgT+c
	EZ/tPLCL96qNHfkgIrDFUOAkTHB/7GLDmxw==
X-ME-Sender: <xms:_lWlaOs-rCCHTtLV0PSjNPSRZ3FQ7BX7zBJ6EiL69h3WHe5ilPz7dw>
    <xme:_lWlaDriyqicOvZAVpSzWQwiL6S6uu0B0-SPM3tfjkype0LxyDXjMP6scPRoCzW08
    pf0hgXxFDOylMvR8w>
X-ME-Received: <xmr:_lWlaLm39CbVlIKEhjO1Hj59r4ZlLtK_2wAJR1jDhuezREzI4wNBWdj3bIkt1iVx8kWDrKaCAWNqawg7doQh72tKazIYtkFZBhkHyjEQfvkn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheejgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_lWlaHztlCkBila9WCXdaPNpAK_Vwh4Gto4TUg8Hj23fhBlENYsH0w>
    <xmx:_lWlaDlxrpWEh_ry_nRpmgk0MCx6wdRgE2BXhAB0YI6-DiibDI6eDg>
    <xmx:_lWlaAceIB8y6Rc-iS8WPd1NSyZ7_jp2Q7IuTEt4r7aqkM6EQ2T8XA>
    <xmx:_lWlaJoK7Y1LqTovBG9dvR40ZaezbDptIDFmq6reDFq0bXkMbVI-Tw>
    <xmx:_lWlaG-CCdmnXk-jcOFz-vn7hqMJZmyAv8FSsFoE4Y1fIyl1_2Zb3AZM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 00:58:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d33a1379 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 20 Aug 2025 04:58:37 +0000 (UTC)
Date: Wed, 20 Aug 2025 06:58:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/16] odb: move initialization bit into `struct
 packfile_store`
Message-ID: <aKVV-pycfcXgwMit@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250819-b4-pks-packfiles-store-v1-3-1660842e125a@pks.im>
 <CAOLa=ZS4vBPp=2=X98DwEk48qgFMHvM4BecUPayGAK1Wasd3=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS4vBPp=2=X98DwEk48qgFMHvM4BecUPayGAK1Wasd3=A@mail.gmail.com>

On Tue, Aug 19, 2025 at 02:57:54AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/packfile.h b/packfile.h
> > index 1404b80917..573564b19e 100644
> > --- a/packfile.h
> > +++ b/packfile.h
> > @@ -64,6 +64,12 @@ struct packfile_store {
> >  	 * list.
> >  	 */
> >  	struct packed_git *packs;
> > +
> > +	/*
> > +	 * Whether packfiles have already been populated with this store's
> > +	 * packs.
> > +	 */
> > +	unsigned initialized : 1;
> >  };
> >
> 
> Nit: I know this is moved from existing code, but might be nice to
> adhere to our format rules here and remove spaces around the bit field.
> 
> Tangent: Also this is something that is only mentioned in the
> '.clang-format' but not in any of our documentation, should we add it to
> the documentation? Usage seems to be around the same for both types.

Well, now that booleans are allowed I think we should just stop using
width specifiers like this altogether and instead use bool. There's
probably still going to be cases where we use those, but I assume that
the majority of users of this syntax is for flags.

Patrick
