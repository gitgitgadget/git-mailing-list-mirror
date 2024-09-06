Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C800F768FC
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725602573; cv=none; b=t13dHbMHiOF6sZoXjUE6zxb0zlR8Ni27RBw3/nnjOHWUZBCjBfDLYz7MrSpSXECxr9fOCImVgRP8xpnhQksRdwJs8+hDNXjtC6Paz+m1HveK1ebQ4FH6xzx2dSuMW15v8RBSa1xWHTxr7zXxqADK4X53rPkghUyZH+P0SjmFBfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725602573; c=relaxed/simple;
	bh=5i1zpskkxUNksfrH4WgbLqR8DAiQgPTz6kn3k58zDSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0ErnPxcHn05dtsTViVyS2lj0TJpiSH7S1o4RKTR6S1m9HPqDYK4gCPGozE/cXp1SNXmlDGH70QY+uOWo7Fy2s3yTaC4DQ79BQUF1W4w+hBiIaALU1tDLM6Lu0tXQ6Kiua5mCpsNWp2ly//C21ibCW/n1x+/ULHcDWSrSAVrqi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q7eXmZpe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZHLlo8QW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q7eXmZpe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZHLlo8QW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6AC941140299;
	Fri,  6 Sep 2024 02:02:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 06 Sep 2024 02:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725602569; x=1725688969; bh=Pstsj52I5z
	ByS1z5MM9AHdah7SEFVdeeuJEtlYoySX0=; b=Q7eXmZpespRaSsEYWqq/5Zl2/D
	raILmu1W/HiZm7z1nmQLhm5IqVEW9YPVwviDKOU0hJNuSePm7g9ODNC6jmzIzYct
	900kjmyN9eY1q2eculg7GGipPLD0RqjvTk0ioExukz/41BdABvzCOMtNU23o0tsC
	QvmRhi0Xd/fkyhWUkqg0gd5tw9mIKFJm2IF6nOJGjXAguwEOUbPZOboD+93/uFVv
	YuF+NAl9H4OWEkb/aeLOxnFuro9mkynXzkmM4Pk4doJa+5RJ87HukOjG/inOmCie
	OV2uzYn/aRUPuQPND7AljYHDRvEFapmhkNFVfmtE2QxL9EbfK81iLZ8l8j5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725602569; x=1725688969; bh=Pstsj52I5zByS1z5MM9AHdah7SEF
	VdeeuJEtlYoySX0=; b=ZHLlo8QWyG/nb93wgKDC+eAvFdByiN52IBxhtVxqlrZT
	NxUqawvzcNog6kFUW/H8Et47MP2PjIipMC/izUviSPqPVeWdH9YkJI82UbHtQr0J
	BDZSLkA3E7Olm5Vv1xQ66Th4BPd3/Yl7f1JqnK2Z5ym1ge1IA2JS4GXH+W1JrlDl
	JFLNdOvh8QBA8KVVGSkAHrW4py9htwu2AxHxs+a8zICRbTEaOPMgrmYYOvMW/BW+
	PW5fasw5rP1bbeVkAUWWZ08OooNQZYqncK2XC/uo3AoAA4N9ixG5jX+LOwq36qq5
	dSOqcpD1ef3cnLbC+zkPLjOJNhO+AazujydFCRkPvw==
X-ME-Sender: <xms:CJvaZnsqdPeD0FIbF0I4_Ca2WJTkcDRBKBzhsIavXj45Voi2frqh1A>
    <xme:CJvaZoe0-tVGM3LwDBwmIp8T9GjXxfjHaDN9Pc6-BWRVr2IzIR50rlmv1Yt3AO9Vf
    zemutKiN6FpuKeOoQ>
X-ME-Received: <xmr:CJvaZqx_xM8OkgOPFdtjKEVR60LBTTAseqCvPsBuUlRxRKJfsDH3QhNIjDtDxtFM4O5V7BxIev2zPaOJrgY7zj2sQTywXfBYlkmmwfQrUEZJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeitddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghhrghnughrrg
    hprhgrthgrphefheduleesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:CJvaZmNQ0iBARTf1xtEi9NP6L6GA-jOyK8Lv6mGCJj6ZtjciirYC1A>
    <xmx:CZvaZn_wTB-sL-fi9SDuVedC6d_Tgsd6QRCYZDIoILg8kkPa5x57wA>
    <xmx:CZvaZmUcz8vmJnJHT5iHGRzRrULHMM52sV4mEkHiJ7Fb4GslX3K3KA>
    <xmx:CZvaZodmaxANMhxqXHli7MlGd1kT86pukHSgNGSkpAq_CtHe20zaUQ>
    <xmx:CZvaZjaf-tE5vVSTX3zSUtMx-nKmoW7PYD8nRVF2kCR_tdARoUrZrwnZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Sep 2024 02:02:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 12985e68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Sep 2024 06:02:33 +0000 (UTC)
Date: Fri, 6 Sep 2024 08:02:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 1/6] t: move reftable/stack_test.c to the unit testing
 framework
Message-ID: <Ztqa-5HwvkEeWb4H@pks.im>
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-2-chandrapratap3519@gmail.com>
 <xmqqmskn9w3o.fsf@gitster.g>
 <ZtlafDnM-geVUTQ9@pks.im>
 <CA+J6zkR35jgmCuWniqDBBcTOW68V3Kzn1x8Yc5PZLHxO_cPtaA@mail.gmail.com>
 <ZtnHoNYbBh0Gkqza@pks.im>
 <xmqqseue0wnu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseue0wnu.fsf@gitster.g>

On Thu, Sep 05, 2024 at 11:42:45AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Thu, Sep 05, 2024 at 08:15:53PM +0530, Chandra Pratap wrote:
> >
> >> Should we get rid of reftable/test_framework.{c, h} as well?
> >
> > Ah, yeah. If it's not needed anymore we should remove it. I have a patch
> > series pending anyway where I deduplicate some of the functionality that
> > we have in multiple reftable tests now.
> 
> It is unclear if you are saying that Chandra should do the removal
> as part of an updated version of this series, or you'll do the
> removal with refactoring in a separate series and Chandra shouldn't
> worry about it for now.
> 
> After reading your message three times, I am leaning to take it as
> the latter.

Ah, sorry for being unclear.

The test framework used to contain some functions that were reused
across different reftable tests. During the migration we have instead
copied the necessary helpers into each of the migrated tests and thus
have a bit of duplication there, which was the right choice during the
migration to not have all migrations depend on each other. But now that
we are done we should deduplicate them again, and I have a patch series
pending that introduces `t/unit-tests/lib-reftable.c` that deduplicates
some of the functions again.

So my intention was to say that this is safe to remove as part of the
series we have here, and we do not have to worry about the current
duplication we have.

Patrick
