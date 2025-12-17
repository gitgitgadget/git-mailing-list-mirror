Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECDA3358A8
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765955030; cv=none; b=KXPZQwvXuKxMY6WpfayaEYX4WQALwcHO6fB7uMNhysf4+lpcDefFEa5gG3OgHKSeb6w2lYBonJ20zGDl2u+uJ3VPxbnOKUV+EfPMKOYbPhHEpvMEuYx6Cpwjph5NN934FHhC7VhAVIB94OuDxXuqvhdJ+nLvmACqDfi3ErYi/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765955030; c=relaxed/simple;
	bh=hCaelzjuMQhpmCuEpYzu/bpE1GW44HdnxD3GyRVUXio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkjn9Y5umdG/RKkxP/L80/psL4MKlYOrkwetFGUs0ERLactQf+dO9HMG51LcenqCeNaOUIXe7Bfs98rE6OSA3+AdnksjcsuV3/7c95vsZp+UvvwWmKX6ZV5gK403oYIrebeLunHUT1PGZcoudzvbByV9fV36ns2F9CdPPBKVMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TeserQhU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J3hcFxGp; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TeserQhU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J3hcFxGp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 73CE91400150;
	Wed, 17 Dec 2025 02:03:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 17 Dec 2025 02:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765955026; x=1766041426; bh=I/wtWByDmW
	o2h6vEGmiUYWM4WE1+BxahVGtDwF77too=; b=TeserQhUga4d8ynzlnjMQnpwim
	/nXxZrQOiw6U5np+YTyDjDMARdCXph0MwjfSO/Mw+mKUBWh7Zf1FE9zUbg/wIgCj
	9sVeuezm6SWnwIeXLXgueYKx2Qo8Wh4n73aX8p595Nr2ahRfK0lfuyNEJIfPgLUQ
	Y9dnLQ9DF2WMiw6jjPvOs7aS6KihNJVXGe/KnKEyTrjFD9gCfl/Wo1l+0Vsi+bl9
	xIpYrLffqj7OMtX6ueMgjhBTazu4OUoUtvPP3vLKN9ir2cgXal1rYCv8OxWxejoZ
	QP34Pf1/+sk+C2LwxomW0tjKwpasFGiijh4tmG1HfiYE2rLO8oo86KzsWCqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765955026; x=1766041426; bh=I/wtWByDmWo2h6vEGmiUYWM4WE1+BxahVGt
	DwF77too=; b=J3hcFxGplBdAMBrNDdW8jRJQgjos9p48HfGBQlWqz9Wut2qvcQt
	ZPjwdtIRwCyUIMiiRyRxIM2JTyvLF3gcLCdTzFidYBBXdOms0YV00nPvR1679ytF
	GoGyyqPDqhl+j5oP4bDhVUPoVO/JzJf9t4h0Q65+K4rgJtRtcz1Ipc15vmB693GN
	vft6PL7Ddj9QU3V5z78x0D/IEO4BkR6ywals3YPCIHLsIt6IW9pXLglJ+yncLfvy
	kRg8HJ94yy1eH7U9fVcQhHxuU22gfIsOF+WcsWjonaE6QXIMDaiM4dH+1MNzNHxv
	tJEbRLkkSFn8JoHwHlWr2s4KhfHnDCvBKxw==
X-ME-Sender: <xms:0lVCaZSEHT5qlSVkGRKVTjeBUWo0DRa_uk00XTdc1-j2LZy-nE2bkQ>
    <xme:0lVCaZwrTevR7nI-i9CiWSohV5Spe049ZoO3cx4Q5d5X3Uywyim-6HIXywU1-MvXh
    CetYw4GGzA1PZpF5H9extZvnfdMGeax4k9UO6zhMJl6Tt5KgetNesc>
X-ME-Received: <xmr:0lVCaT3Hw24-lfxTn7Who5VVRWXZvTfkFC8ufk3P2btFVMB0a661oa3dVCRWLXDLOw8kLM8qeszvRqV_QmjIOzjdypJw5CLcdxfPYxDun18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegudeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peifohhrlhguhhgvlhhlohdrnhgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0lVCaf6wuHmdkwMF-yzBnRKUFCGPsDEixE-QMyKK3-66k7bGQY5Qww>
    <xmx:0lVCaeXFEN7Dn5hNKaNG7RKvqkvxhkvAFiQL3gCsE5oWHmqsTwy18Q>
    <xmx:0lVCaWBOovJH3Ha1FOX-ojZGutPmgxWresgfArA1OS3cdAIe1dRU3Q>
    <xmx:0lVCaV6y8CmtMVeTS8RkjgxNRVSvqvBVzOzEiiYcv_3akkDDbgTayA>
    <xmx:0lVCaUjIsXuKFrIgybpJgpym_zJRj2yVCZQjlcnuL1eQjeS-fgul9UKu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 02:03:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63954d16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Dec 2025 07:03:44 +0000 (UTC)
Date: Wed, 17 Dec 2025 08:03:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, worldhello.net@gmail.com
Subject: Re: [PATCH v4 0/7] builtin/repo: add object size info to structure
 output
Message-ID: <aUJVzVp9VB7tDfA-@pks.im>
References: <20251215205639.2700270-1-jltobler@gmail.com>
 <20251216173842.3357832-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216173842.3357832-1-jltobler@gmail.com>

On Tue, Dec 16, 2025 at 11:38:35AM -0600, Justin Tobler wrote:
> Changes in V4:
> - Unmark "byte" string in "t/helper/test-simple-ipc.c" for translation
>   to avoid conflict with translated plural "byte/bytes" string.
> - Remove some unnecessary translations and add comments to clarify some
>   of the added translations.
> - Some small changes to the tests in patch 7.

I had a last tiny nit that doesn't warrant a reroll on its own. Other
than that this series looks great to me now. Thanks!

Patrick
