Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9810C188596
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 05:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734067521; cv=none; b=kFidceUoxslQmOu+RkhyixJ4G9Qq08FXAEvvxaKnLQaaHQvT3VJdFjflZouAH2lMddILMM0p+Mv17JtiRCzOdsWZzHT/bDUF6fprSC+i+9OmmxMS0lLmWAKZxMcmxGWLeDFt7lZTAT79fBzrE2hgvMCTSMpOANQmPow8dn3zb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734067521; c=relaxed/simple;
	bh=T62ZnSr0eXJIn8FUnjrNL57bJH6cvnfT+qeM/2peUlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oge+9NzE/urQsiOcmtc6LOt7qItp5mMh4pnLU6+f8fxSVpOkUT7J1RZzJr8zPSZrqXrRo9ekTGMYGjUkNtD/5r+PUR9h01rgCmPPi+c/2aOHJwW2n6WdnwW2yVnJPA1Ylc9+jh73dMrAOcSuPx2bbMXdXL125X093cEexuwMUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dumjsDkJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wAvkIt6w; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dumjsDkJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wAvkIt6w"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A4C01383C00;
	Fri, 13 Dec 2024 00:25:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 13 Dec 2024 00:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734067517; x=1734153917; bh=oE4ykq8pdo
	WLB+KuqQUyjTmRRL8RbyhoBUDd0p3+VyQ=; b=dumjsDkJsHt5rqdOHOjoQScdRi
	bhfktBB3vV8yxNS8r0uENSmEGatBUAI5GYpBCNNE2zC+sY4U7s40Ur3bjiTjyTfA
	JPpaInz2OzAXsRHGTmbyzniasTWDOS+JGHI3Ny+2/azDksyGnjkR99xQSEGJDW/h
	xmfDgAyPDkgbNUxg03PVUs5MHm4b4VrGc1BHs2usn+hqSV2WN79L15QeHClOcM81
	6HPce1UTq2ZJ84HclYhANVJdewx3Thm1hH9qm75ACAHUOxhocRMtWCOanLtjJRtx
	UNdsVMZNgVgoSWO8oOgmbibWiRLERWpJA2nVQzqBzrfmKWFFlt7tbAeU2+Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734067517; x=1734153917; bh=oE4ykq8pdoWLB+KuqQUyjTmRRL8RbyhoBUD
	d0p3+VyQ=; b=wAvkIt6wMVIKLDQ4QxTRcQ9txyPzt77eUp5yfkod4mvug8TcmKK
	WQPtf2OKLRvQkrmn70sAWYHZWJ8mX7YC3BUhaasegJB/rz2MzyeED79Iob8g10zZ
	U5EQJrWz5bgD2PNFWge3Uu2+tw7ePOB42JR2dayyYnD2XxGV362ay0H5GtducBam
	l8z2ce2HT6DL67LNdvFzbsdhPl4aqGPJNTvQKXyzIr9rB6lIX00i4wLQ3y/ubkPR
	dr2ypi8jb0dJRAQj2PckhfMjyKrncfLQuZvfoRVCmyEa+eW7/PfG5uAaqrtz0iXX
	WsFZp9kRxoDNGDuVZqHPRuXMVALz54Z9fFw==
X-ME-Sender: <xms:PcVbZ5gl6iU68bYEbR1wfmU3U-aTg4wq4cwwFsC5i2HPJ_5VUAi4dg>
    <xme:PcVbZ-CtjkIgZmpuUpbJryuigHJjzl7VgqiJZXBDAWEwdSD3rHP7IkP4llwCBZo79
    3uWmmxIaZydsuh52Q>
X-ME-Received: <xmr:PcVbZ5Gg1wirdKkB1bmOHMgl3_Ycn1x3c3Ydb2fnA6QeV25BHQTTA1ba9FMl6kAVlxSquA82laPKOmQc_Wcd-LuGYBfbTk7WO2zX6Jda_q8f6dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PcVbZ-QPoYZvvjoMIxfFPxaGqRLPSRUz4ur9cy0wfcsS6BzJSqt46g>
    <xmx:PcVbZ2xgTqHB3xmv1pLeU4a8_jm4tsdcZHHS0W49EwJ3tQGDeOoFyw>
    <xmx:PcVbZ06ydiWvLDAXFhgjJn4Mni2EoP3Vxjlq4TDEc7lFPEf2K0NP6A>
    <xmx:PcVbZ7yQQQ5aAt_Mk8Hj2z3fgOJfVujJ0ghjPLnptMmEo73bDUM30g>
    <xmx:PcVbZx-PZDlcxSthXXDbqGID1r2PUEEmIeZ6st4yFRkB7ohKzTNuQd2A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 00:25:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a7c81091 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 05:23:37 +0000 (UTC)
Date: Fri, 13 Dec 2024 06:25:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/8] t/unit-tests: rename clar-based unit tests to have a
 common prefix
Message-ID: <Z1vFLQi9g9J8fCle@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
 <20241211-pks-meson-ci-v1-3-28d18b494374@pks.im>
 <CAOLa=ZRtQ2ab8_gf348eirDdrJYjSKm28aR6YPeY+7JE=77nOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRtQ2ab8_gf348eirDdrJYjSKm28aR6YPeY+7JE=77nOQ@mail.gmail.com>

On Thu, Dec 12, 2024 at 02:42:41AM -0800, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > All of the code files for unit tests using the self-grown unit testing
> > framework have have a "t-" prefix to their name. This makes it easy to
> 
> s/have have/have

Indeed, fixed.

Patrick
