Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3D8BA36
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339648; cv=none; b=BRomVoLOq3qTlNa3xYUBAeVNdJSKxbSJF+1MJ/K8tPPcjzWjMEq1P3r+knCcrhQ7/Nv/Qp2RaO/r26NQHnP4aWJVGpooK/Q3w7KnR4LuqdnAN3RdDLLd50dQ+JlnU4kbHEHTs5W+Xj3ANZGrDGpxuxvWqI2NOBtIlwKbD1w3qdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339648; c=relaxed/simple;
	bh=QUxQ5Lt8cLBKE3mwcA8XZfACyifMevbGChDvMgPtnYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7+bhDgbmrYqQHlS2rr2AG7LfNxkgUUqYpfCgRLgZy1Ebb0WjEciFjGQMiokIzAXWxy2NB+dg6O1p4rE3jw0+o6jO9rXP2TKNrtKlzkS0AjvCqYmTWmrdJOkfdbV0F2RvAMKWwm+HNAOrJeYpJtTliBcL/DnYDPzD0El10spT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QJnjRBOu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eZ3uoRGU; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QJnjRBOu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eZ3uoRGU"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 542B57A0207;
	Thu, 24 Jul 2025 02:47:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 24 Jul 2025 02:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753339645; x=1753426045; bh=6FjMgcq+9P
	qSFTAd3T1X+AYyUHJYxfvoezakdyhYJ8Y=; b=QJnjRBOuH/6GUJRqrsClFrs6EU
	+sfTIf4f7eBXxVBRHTNekqjDS2lQ8vmAUfB8gKU7uKx12s31Vz0BL62lB29rcLQI
	obpJosiED9G/2z3Xjx/nL55ZB6E5bJcyWEe7nh7gR0lCJoupKPTr6ZbmfjsrcrgL
	yN8CP4D63Kya44ocRk/Lq9HhtKcotgWu9OArB+P2n6cPVVt1Yd8bn8DP3+Vab6VN
	Z+TJTtEY8iBiSE4EDL1fA/6vv+yvD7KCUsScVkVM301f0pTTy1OQJys1srFC1hWL
	+/s8CV/i9vSFFRha8V10PnkqgZ7CqB3vVGgqMTTGsFnRz3jR+E7bi42y6+gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753339645; x=1753426045; bh=6FjMgcq+9PqSFTAd3T1X+AYyUHJYxfvoeza
	kdyhYJ8Y=; b=eZ3uoRGUpaMTz+h41VuNRxaTaKopRj311LCI00b6GT2bHmSPdh2
	nwPfqGvnsN1HZBBg6/t+GRU/lq/hM2E1Ydx7k32RDqZ2UXeSBV+XyWXYrww1Thme
	0WYYW8HSapI1hVzW6IjYawwr87gnGV/6LkvPgqhZbMcQ78kZyScc75h6KLYgQfHM
	3+psxoJHDXlWMZMXbE/oo8QtRckyRHfrQfNohR/0651rAvVJw0p7tA4TduXjG/2B
	FSD6+zWizq+erbBCNZeUM3X4gxSRUTrz0O5Kw/S5cfbO6JBhcoW+ULTVCCgLGGn8
	hjosG6qw33Hmc1T/Vhdjjq5ytPRdV9KKoIg==
X-ME-Sender: <xms:_NaBaMCov2SkECxPDk5YlAqRClpcShMGZLCJfFWaxqJdlxRUadhKxg>
    <xme:_NaBaH-PeNWBFIekBorpS50rKic0zVS3vDbLBvvGrLxB-WOuJhboZAXkO4ijkJav6
    gOZts4e_fH5EIbP-g>
X-ME-Received: <xmr:_NaBaPKA6-6HCrZvTVSWWJM0Yxmnhos78bmofeJ9zVauDw4AVaV9V-vOJidnRBYFHUgman17rF30Oik2B7D3iyUotmA4TbtDVHLQMdUZ8Zs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejleeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhufhhorhhijhhileek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:_NaBaIhmIpNoDMNXNlSPYznuBbycBI0n2T2wXMugdMDDa_HnCVuvsA>
    <xmx:_NaBaH6-UB66wpo6ZlwYSL-PAGcv6lnwLHne_S233TQ7sDwNRmAsAQ>
    <xmx:_NaBaIbiwPYARz4mKqduURH_H81G53MNAcWKJC4z3OsZhLeZ8ONQHw>
    <xmx:_NaBaE4BzuiJgbo-Mb0834Zb1_Hd19wc_10YAwluPzEtoeLUv9EJkg>
    <xmx:_daBaLSoYnjoaYPpOpHJxOIQaT5fF4xK3pKHL99FtFAQblGGSgoh48gb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 02:47:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52136bdc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 06:47:22 +0000 (UTC)
Date: Thu, 24 Jul 2025 08:47:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 00/10] t/unit-tests: convert unit-tests to use clar
Message-ID: <aIHW9rW-VkhkR8nn@pks.im>
References: <20250605140644.239199-1-kuforiji98@gmail.com>
 <xmqq5xfimw7i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xfimw7i.fsf@gitster.g>

On Wed, Jul 23, 2025 at 02:30:25PM -0700, Junio C Hamano wrote:
> Seyi Kuforiji <kuforiji98@gmail.com> writes:
> 
> > This patch series marks the final batch of our existing unit test files
> > transitioned to the Clar testing framework. It covers all the
> > reftable-related test files, and is part of our ongoing effort to
> > standardize our testing framework to enhance its maintainability.
> >
> > Changes in v4:
> >  - some code refactoring and cleanup based on review.
> 
> Nothing seems to have happened to the topic (other than one obvious
> breakage pointed out on 06/10) and it has been more than a month and
> a half.  What's the status of this topic?

Sorry, I completely lost this from my radar. There's a single line
that's part of the wrong commit, but other than that I think this series
is good enough now.

Thanks for the ping!

Patrick
