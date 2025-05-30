Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141FF4A1D
	for <git@vger.kernel.org>; Fri, 30 May 2025 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597956; cv=none; b=SpkkLZU3fG++pvnT1DylnKyg4naJeJ+ha+wOq9gQxsnz7u078ksRej0nZ13wSO+u0ZvIIUUamzhH7cR2OYNUrzQWxdspt8/c/C3rhp/IDcNynLd0tUVSDX+q1egzKv21NDrx79XcrdR5RrimSkllgEgfymk4pLcosj71K5XPeI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597956; c=relaxed/simple;
	bh=IiCIuRVx83v/UlobhUV5eBi8AsPzgvhq8zyHyQGVfVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3veEgZiZ5nvet+CgTPOsq5if3/SsA6Ia1WxgndY4g92xNDM2u/wxJmMLmfQZqUZRx+F/GENfmUWcO7UF3geu7j34XG+epNU6W+ljY8joS1z6Gbj0lkAbaNBVO5J0gsNwmr1Yb7EWyj/ElshuN5mUQyvYSiFRupv352Z4zxY+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qjVC0QiR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PDck1UWC; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qjVC0QiR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PDck1UWC"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED6DB11401A2;
	Fri, 30 May 2025 05:39:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 30 May 2025 05:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748597952; x=1748684352; bh=3yTRY6GcbO
	I/boUUrYrkHhjPpVDTSsIiGQnpR4T/yt0=; b=qjVC0QiR5wXkMpMAiLKojTwEx2
	LgTmJAtG5mwobMrEX9ghZOFbglgRvn8QP2T9IbLLHBbxHkK4ar+UMF7zFjI4VPKF
	HNbZtQrW+hkFPx4aPhZLYW2Oiy2QR+10qGwipO1xHedDLHxL9YqPiPfg5lQWQrjj
	9LgEiwNcQd+5GrW+tHOPCnrgeGeUo8JShTl2CPk6kFNfqgTrqdWRcr/glR/xbCo7
	dbb0IJssP3c3Kn4W1TRYs9pCkFyVDfokxJGalXN4NPllnAt4yBqXh6x5vMtT9feI
	SVT5azQBZwX8O1htA3kM6Y4c7kgPcsSmebuDHZICI+nZ7kktdIPAzIKF5RgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748597952; x=1748684352; bh=3yTRY6GcbOI/boUUrYrkHhjPpVDTSsIiGQn
	pR4T/yt0=; b=PDck1UWC5vl4NpYcnmzIs5WPJtlSGfzqEJNChmjaGDHr3p5Q+UV
	Z8kgNOksM4vI4DRbYc/TjKXa4i3OCuv1xljCnd5DVHgMWYb8yQ+W8O5aJI1A/TSu
	9PVt0bltcw381JaFR962jBEX2Sy+stukMpAVo/EqV/mxclKv7UGuTeZkePq1Nyk4
	oWiCn2DPonHrLGmdp369iBVveqYt3ncunwkkJcqJNadqyk8d015bVy1tPeIUpGy/
	OE9N+12T0OUQE4IcUmnL9BnZocwtC3tjAN6Vz2C6bGiY2ANcs6LJIbiMi1LHVJBx
	0tplPHhUVRyidvJz8+0witmsdTg3LEDB+qQ==
X-ME-Sender: <xms:wHw5aGcV1yjR8zT5TFCnFckZJZck8vvncDcu8_0qMpE-rGWulj6apw>
    <xme:wHw5aAPDuPXKM_8gnOuy4SPQuyJZmz4jHNjKl3I3ek6iXYA4409DNo05-UvdCtWhJ
    oqOBqnAjenCduz3ZQ>
X-ME-Received: <xmr:wHw5aHgSBPcZjCwgsnZ9hi60ysIsUJpGnab7vnt_bmb9pC9-9qEvs0ckE4dj2DHbVl2DSuiOxD96oCensEU78M5TO5LVivYKjsH8Ww6zNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkeeijeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:wHw5aD8Z1zDKfUM5SfVxsxdY9LV0iYVIuLMDR8gcl7WrhRU2haLAwA>
    <xmx:wHw5aCsenDDD9QJ6HIPR4x4u-N0by5ysUz3s7QMwD81fl_sFJsUJCQ>
    <xmx:wHw5aKEWHpD7T6ciY3p6FaHpTl1NJsdken2vGrwgjlx52HZZFfAqRg>
    <xmx:wHw5aBPaLVKQqeEtkvItZL1yBVs8_HxmgsTED7MsGs9arVYSOQHWXQ>
    <xmx:wHw5aFnOIWQq2Lbi4rgnrpjlh4ufSKB4cr3Qx8XOmE3K8c-NFxHnknKf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 05:39:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21c0c709 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 09:39:11 +0000 (UTC)
Date: Fri, 30 May 2025 11:39:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/17] object-store: rename `object_directory` to
 `odb_alternate`
Message-ID: <aDl8vjzdCJKoKXY0@pks.im>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
 <20250514-pks-object-store-wo-the-repository-v3-2-47df1d4ead22@pks.im>
 <tjsbotrnrffykmi3letktpb3bly4nqw4wxzyrszgbln7pznem4@3kwiq4zvaebw>
 <aDP_-VX_Rz-MqiAS@pks.im>
 <euflgbipchqi7jvmz4yzwzx6ao5guen6xmupkdaubjbc5ksgkp@aheynye35bby>
 <87cybs3mch.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cybs3mch.fsf@iotcl.com>

On Wed, May 28, 2025 at 03:18:22PM +0200, Toon Claes wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > That's fair. Between `odb_backend` and `odb_alternate`, I would probably
> > still prefer the former, but ultimately I'll acclimate to whatever is
> > choosen. :)
> >
> > -Justin
> 
> I feel you. But speaking as a non-native English-speaking person, I can
> settle for "alternate" because I can still wire my brain to give it the
> meaning we're using here.
> 
> But if you like another name, I want to steer away from "backend" as
> well. As mentioned elsewhere, a "backend" sounds like an implementation
> of an object database, not the instance of an odb. But I'm open to other
> suggestions. I've been browsing thesaurus for a bit, unfortunately I
> didn't find anything better.

This ultimately _will_ host the backend implementations -- every
alternate is backed by one specific backend. The problem why we still
wanted to steer away from "backend" is that `odb_backend` rather sounds
as if the complete object database has one backend that can be switched.
That's why we settled on "alternate" instead, to clarify that there is
not a 1:1 relationship between the object database and the respective
backends.

`odb_source` does not have the same problem as `odb_backend`, so I
definitely think it's a way better name. But the reason why I think that
"alternate" is the better name is that I think it will get quite
confusing if we have both the terms "alternate" and "source". It would
make some of the interfaces quite awkward because it wouldn't always be
clear what exactly we are handling at any point in time.

Patrick
