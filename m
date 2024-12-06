Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB00E200136
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487975; cv=none; b=Y275l3kTcZmrsf6F+1/UDCDTMMi+WMwxM6tgDNMcOlWGpt/1bGEBwmlYdBqFG8YD7Eb7+0ES0T7yTrsal35RRj7Ywl6WboAaSpzizQBFs06nLBs5nJha+ZoW6Zl1Cg51q9luL4GhJLByMgJrkb0Ag+Cqes/h5tNF86oQnfFsIjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487975; c=relaxed/simple;
	bh=dSYqBzcdN2ZWVaQmamxzKK2W8tVdEc8QlgMfD9r7aQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO+lNu7fi4V/AfJDatgjU97MpPsroInWNTb+wwTVdJvUGrlddWWjPMbeURvDd+OB9rv0kILoVC3Anqsr8tpwrxwpaGawOhZMj7gNzpEG+QsZ1qNIFKY8XKDYX5xuwTuYdPf70v6fNV3mH8LP+HWcNqEVqv8ehFTga6+hn2xulLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nE0grZLe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AUe0RIxf; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nE0grZLe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AUe0RIxf"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DBBD525400F5;
	Fri,  6 Dec 2024 07:26:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 07:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733487972; x=1733574372; bh=lFwvPvLzIX
	zEO31l+KP/i+mYpRcspP7X4uTP2d56NnI=; b=nE0grZLeCDy7uZrU7dEm9GqGCu
	agSy97VJvfy3uK+iYDtF/Tz5iLBzXDVTmUxXARmngGqybwp20CSiHqtHyL/TZZfB
	+DYt04Xale+4RAjtQ5AdadwV6yjeRWLDxbAzG7ZAfhGyFHgaaTjEc4L4ei801IkR
	zYyRo0P+yRYyHcakG6rRgCjD44tMIS49KmId01+IsVimpeJxuV1rI/9euV7tX4FX
	jeliBrXaa20bZWO9EjNwSm1/8t0N6yz8Jm72ajWci/fIaqrppBr7BaNb0x/XWoMB
	WtKR59+1CjIVZ8ttUrluA6txTV/8eCsue89ghYCil+3u5VBdrtYiuNu7NuNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733487972; x=1733574372; bh=lFwvPvLzIXzEO31l+KP/i+mYpRcspP7X4uT
	P2d56NnI=; b=AUe0RIxfgF03JeFAl8vT90Gfdj2GTwLjVE5dtYyGLkd3sdZGN0R
	QYF4sXU7qopbRQgRwjmRDJAYnBotJ+DK24+CvldGiW8PCXlv6m3KNFH7bHeAqqml
	CI3cMUDH5AYmD4k8dw6s5QgoXpo+YwJG3Cr3isS/maF50gCcZvM7dFUuSmKyVgVT
	lP4bAeYesEIAlw03YvrzaystpUJL0hPmOu7CBlYV/uULbZev980TUtlGSEtf6UOR
	4u8+Td/HVSQCZHvOMJIFfgTxaTDKkev62ubDSHTEHPK9ubauIzJQa0/K1iyA+B0F
	7UJJvooWKnRmJEm2Z5UJwFzkphyMvj1jbbQ==
X-ME-Sender: <xms:ZO1SZ-ibVLnrxa7MPKnoDxtldggx5z8j8bdMH6moebHjIZNRdFA51A>
    <xme:ZO1SZ_Dt7h5A6MbQHTqGnBMLlsbKi19FzOWKspMDARpLBRoUg65UEiY49tNZK2MgL
    -pxmuuklZHoZpPpUg>
X-ME-Received: <xmr:ZO1SZ2FHIUb_pWj58rVytPYDLH8Rtuc70YViUcq-cHQRc2V2cAGxiLrLgFaRhRt2GrFLkobQoprpKiZfP514woWmqYDkpGqDwtBx2zpA8BJbsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprg
    grrhhnihesvhgrlhhohhgrihdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZO1SZ3T2m_JMuk1KzgERlTsXZvk9kBbOzZLoXUBiOHZDRHDLdU8cSw>
    <xmx:ZO1SZ7zrB3Ppi6oNZAOsmeH0OEYn7iPt4SNm0p3MAKA-UbIaFUmsCg>
    <xmx:ZO1SZ17jYPLb5zmeJVP4GdRmDG9N8Yw0sDvt3PdRJwzmjVZxChjuGQ>
    <xmx:ZO1SZ4zUzNDiKQh408v4nW9r3LoADrUs23-arKzm46N3ThI88BVw4A>
    <xmx:ZO1SZ9volyPFIXxQM1WbtqnMpTTQwEuM48pWJClG10Om6q42In-4fMO8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 07:26:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de599459 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 12:24:46 +0000 (UTC)
Date: Fri, 6 Dec 2024 13:25:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Aarni Koskela <aarni@valohai.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH] object-name: fix reversed ordering with magic pathspecs
Message-ID: <Z1LtS-8f8WZyobz3@pks.im>
References: <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
 <9c7b9090-8cf2-4095-8e86-2c85b6fe407f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c7b9090-8cf2-4095-8e86-2c85b6fe407f@app.fastmail.com>

On Fri, Dec 06, 2024 at 12:20:45PM +0100, Kristoffer Haugsbakk wrote:
> > diff --git a/t/t4208-log-magic-pathspec.sh
> > b/t/t4208-log-magic-pathspec.sh
> 
> Yes, so here is that magic pathspec name.  But this test file has a lot
> of tests that test positional argument ambiguity.  Which seems very
> relevant to pathspecs in particular.  And revision selection syntax
> seems to be used to test how things are interpreted.  Not really how
> things are ultimately processed (that seems secondary).
> 
> The tests involving `:/` in particular seem to only be about
> ambiguity testing.
> 
> Is this the correct test file?

Probably not. I couldn't really find any cases where we explicitly
verify this syntax, which explains why the regression was not found.
I've added it to t1500 now, which is at least better than t4208.

Thanks!

Patrick
