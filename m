Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF341DE886
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925748; cv=none; b=Cs/a+WEIdRSNm04Rg4AKDvBOnZkoEkityDjKm6XuaUjimbIcI/shAx36JP8hIhbTSIlRMrSWyEdWnsY8oSHzCBORPrYpzCUZQzbr8XLT32IbRN1TKGlos7KUoqZlF2NpAfBxk7TREx6RAhNOWR2sSXAZfDncu971JglNM8Y9Lfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925748; c=relaxed/simple;
	bh=YISG4NxYcjK035/ZHbwnyyXdgPD6/cCM+RJIlQQ2+5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg08efIPVX8eD6PPQgNc7mhosdAJo638jO9qN/LNOi50YlijrNPo4KdWuITBkfXPxFbU2lSL9h638Ch/gaYiqk96PiIutCNbx7/BJZ0gMyPh3MAZshhDRbBH0RjKpI6234hu0fWZt2UX/yr9xWNisX8D9ZQihhOF43EBOHoUjwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ILGO+jdq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=osxtLIeK; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ILGO+jdq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="osxtLIeK"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BEBC41140120;
	Fri,  7 Feb 2025 05:55:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 07 Feb 2025 05:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738925745;
	 x=1739012145; bh=u28W4ZtobAZnnhKgb6tZGdt9u3QgKf6JJ6qas78vd9I=; b=
	ILGO+jdqf9dYgszfpwBIIcdI0uBykP/jUANcgYMYncy7QwiRfwspi2pC5ru7f6Bg
	83AxHp6R91bIAICsoPW9HrjrJ7GbRdf3vNabNP0dkxCIJP6HiYMZjKmFI9p0nGql
	wSeH30INLtd2T3u/FR9aD/15o5TxBuwuJBd4Qt85cpuk78twrNGr5Fn2gqRGAzsR
	6Cp9NAHR6FQbiuSClavlSNCVRSBhxjLV18mmHljiFDnCBVObr6TR6HG6uYlCkIth
	blVgdy9w+bXvaaE3V7GLk/X0i5OTHJ0Vv+tgk8e7COaWPg7Efdm9caA7kTWT2JOf
	MP1hKC/aOTpNDQjHcQx6Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738925745; x=
	1739012145; bh=u28W4ZtobAZnnhKgb6tZGdt9u3QgKf6JJ6qas78vd9I=; b=o
	sxtLIeK99RZ6w23LWGY8HDP/vdTr/h81fOohqt6nJZCq9vkzoygUsej2ZMM44SqC
	LSECEDNe1c+lKWe6kFFhg++fm2BB2TJodtkVcb857pMqZEktjbNSgKjU61UR0fxx
	Bk6w1IH2eKNMOjoTox3siM1ja4xSRrT1jyY/fwAcId6/eHYyEm3gn1mqvSqgtTlf
	SuwAzRNubgzr469IXApKUajACE+mjHgSnwPEsrUVxA8t0j+xhv/MmGQXkqsHHDUc
	bAjgxPDb9AG8j44zD/3RARpjbO+wjM/uJ9fBL2EfxHuZmaYMaG6pqXwK83A7KQXB
	0mA5U72sC3zAIdSBzPC8g==
X-ME-Sender: <xms:sealZzNtoG2i90G4bHSeTCm4gKx5_Pvz7AOiRgwJLenHZzZkZ-qXhQ>
    <xme:sealZ99sZPwFBEOFvHVKec7QTuRXbJAAt2Pvsc1XP7_sB_saq-P6KD1OIrL1yk_Wq
    o0N9iZHQ5JpHdKHig>
X-ME-Received: <xmr:sealZyQNh2dp5RKE-bSGaPcWhruhyRsTHpGnPyccAvoc0w4dkXkYqXG4S6VCkMhoMBO099AGON1LITNyfZLnBZlK70adYnmPHWZ67i4ugAU3QMMJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepueehueffheffjeehudekteekgeeuheelvddvfffg
    heduleegledtgeffudfhhfdvnecuffhomhgrihhnpehhthhtphhtrhgrnhhsphhorhhtrd
    hsohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgr
    rghrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvg
    hjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sealZ3tcYgS38P8V2t3yePNxc91KWBHPFQlHUDALo4SO7CXsV9TYxw>
    <xmx:sealZ7emn2R3KpriHsTjL_lWtCpJ7AO-LeYbI89wyQHtqSJKw1NRng>
    <xmx:sealZz0CXSthi_N3xBelU261nVfFfpV6mY1K6IvV_bVxmVXweA9Vgg>
    <xmx:sealZ39Tdm-OoS4cH5B2b1AnHtZIjtC1vN7je1FHw6qNz8RGFj57Dw>
    <xmx:sealZzSFH11fXwdg_2d4dmrH3T3VLsio3myXJ8MtuGGNQ8e3I0QrPNRr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 05:55:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 64dc2264 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 10:55:42 +0000 (UTC)
Date: Fri, 7 Feb 2025 11:55:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jialuo She <shejialuo@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in GSoC 2025
Message-ID: <Z6Xmrfut7jdsVAfg@pks.im>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im>
 <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
 <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
 <CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com>
 <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com>

On Fri, Feb 07, 2025 at 01:02:25PM +0530, Kaartic Sivaraam wrote:
> Consolidate ref-related functionality into git-refs
> 
> - Mentor: Patrick
> - Co-mentor: Jialuo / Christian
> 
> Refactoring in order to reduce Git’s global state
> 
> - Mentor: Christian
> - Co-mentor: Karthik / Jialuo
> 
> Machine-Readable Repository Information Query Tool
> 
> - Mentor: Karthik
> - Co-mentor: Patrick
> 
> Implement support for reftables in “dumb” HTTP transport
> 
> - Mentor: Patrick
> - Co-mentor: Karthik
> 
> -- >8 --
> 
> Let me know if this sounds fine to all of you. So, I suppose we could
> pick a maximum of 3 projects but we cannot pick both "Consolidate
> ref-related functionality into git-refs" and "Implement support
> for reftables in “dumb” HTTP transport" at the same time as Patrick
> only prefers to be mentor in one project.

This all looks fine to me.

One thought: From my point of view I'd strongly favor extending
git-refs(1) over reftable support in the dumb HTTP transport. So if I
had two applications, one for each topic, I'd lean towards applications
for the former topic. That might easily cause unfairness in case
students aren't aware of that.

So unless somebody else wants to be main-mentor in that project, I think
we should either drop the HTTP transport tropic, or communicate our
priorities clearly.

> Based on this, I'll tweak the ideas page to mention that we could
> pick a max of 3 candidates.
> 
> BTW, I've just submitted Git's application for GSoC. We should know
> by February 26 about the selection result.

Great! Thanks again for handling all of this.

Patrick
