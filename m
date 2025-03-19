Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05744255227
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376761; cv=none; b=jq2QIPxbedjUjpLQ/R66EKbQvupYTs4upvWc7b4jxeUbrYeKfoZXAqJtO9alrLGewFnLefP+GjWqGtgEsHW/Up/Yo+p2o0Ws7wXzNBlLKOzpFtnQSboVrOJ/pB7qEmYHET/dSp7Ynqi8Pj3VZ3dONQlZo/QEMFMtzoX2DDeQaWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376761; c=relaxed/simple;
	bh=bllSfGnW4RUPP7z4oJ6a75kD6wDOjUCHwTM6Y4eNu3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDPoFIyIVP7GTdX4yjWTVPp3+Huest2osU3t7YB5SGdcuNeI6DoT4wk3b1TYgW7neA06pyBr60CVh7D9j4F7/gyQ6QV/EKMUmX5t+Hfkpz6Dkb8kOZK6mifVHcHBC1ccYfX3yiwqDXwE9GKCKRUtDFDfjClFhFFOla9uEFfK8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FKR3tcJJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2JR0avZR; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FKR3tcJJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2JR0avZR"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F07122540139;
	Wed, 19 Mar 2025 05:32:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 19 Mar 2025 05:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742376757; x=1742463157; bh=YWET6RXOoe
	R932iqvY2sZTxoK6C1T07WWCj0+EMT1Wk=; b=FKR3tcJJ36nAeuNfCmrCd5ch9H
	/x7rgscrrwF2mnkoCNVTo92Rlhg7UxRHw1s9BmM3ObNBHt5rrT6zHMYahyojdPx9
	7R7H4d7o0J0dXxjnJQT/rJcEXI5RsDx9NTp0Lcv2yNhNJv88K/42R4M7vbxw8yQy
	35jU9NZGgxbqjlVDplz32qpfUT01HcQsxunQ55wMgZ2GudW8pAZVMdE4QpFSjMGV
	qJgo4p7fW8V33g+F+IwBeHPffjYZQh/BgImqvnUE+Y0g6uHBBASgtfLQT+qvtkun
	imkkRNQs9vBjAlpuSFOHq3X+AhODWgMh3noTHNfQRoQkdIHV+XrzMay6eXWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742376757; x=1742463157; bh=YWET6RXOoeR932iqvY2sZTxoK6C1T07WWCj
	0+EMT1Wk=; b=2JR0avZRSq452GYLe4VHM9Wbdz+aA6SAbr6qIFZSJUuyIb3YMh/
	sL3KKa4DvdOUTVUVA6ypDAo34W+re28DSYE7jmXVqz03Ze5hCpYZy7dMLLhnTWb4
	tBvR3CTgvCd32MFmd1ryhLOm0UfbYzBmRwTmiHORp0jpCLD2WkxbqXwc29clEtYa
	GvyAuggX1k8LxCecYxiTWwzkp9oIsuDXAX2ITo1X/aZw0JBPrz4dbQqaMv9Fra+t
	lLHux1zGtd/B7WeXI4+OlP3KQZYBLBR7HAeFfkEeeHiTQfyqyAFJB19JhvAq7bqA
	wnrb0W1wgIAZZrtTDg5bZzuBWgz5UkSk+9w==
X-ME-Sender: <xms:NY_aZ4lZ8gDUhD8d7a3OsCeGdjg1u9NJBncqi5X-3lmdJF6R1N0xvQ>
    <xme:NY_aZ31R48MYqH8KdFgikDv8JqA4lq2H9zyzK68iKx22w24t20N0-6SgM7M15HwGn
    -iCtHjozJJRae6umg>
X-ME-Received: <xmr:NY_aZ2pYnB8ZFqgYi2AthrTKKCVmm2qdCxWiYMcXyuw2O3jJyJx2pQkDuAa74nEaIhnsgI8EIp6q5aD6esPHp3Ai6KAFcCRq0gEo2bhK7kwi1Bz4Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhmhii
    tddtjeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NY_aZ0lNnJ-KL7ErWZZGCqnCdTQPXPcroHESjB_xiuQOalvwXQ5Ydg>
    <xmx:NY_aZ21CjCz1Wn9ZBOsz9AN0ZCtOGRdpaPk7wo88iWuEj76PQQqu3g>
    <xmx:NY_aZ7vSyD4F82IV0niC8sJRtY_PFtc8uopRF5IbFxDH9BrYEM6Kog>
    <xmx:NY_aZyVN1wnGUTEbNEwXIwmBfpNZ9JTbYHCmJmjql60QD7xcG9foXg>
    <xmx:NY_aZ7y0dFJPuVdmMF26GZntH7rb7H4PF6tHd_5WbhIrRqVs8EvG_nnz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 05:32:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 05cd3950 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 09:32:35 +0000 (UTC)
Date: Wed, 19 Mar 2025 10:32:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jensen Huang <hmz007@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] index-pack, unpack-objects: restore missing ->init_fn
Message-ID: <Z9qPMvclpdEIjQ3l@pks.im>
References: <20250318111616.113941-1-hmz007@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318111616.113941-1-hmz007@gmail.com>

On Tue, Mar 18, 2025 at 07:16:10PM +0800, Jensen Huang wrote:
> Commit 0578f1e66a ("global: adapt callers to use generic hash context helpers")
> accidentally removed `->init_fn`, which is required for OpenSSL 3+ SHA1.
> 
> This fixes the following error on fetch:
>   fatal: fetch-pack: invalid index-pack output

The change makes sense indeed. I do wonder though: can we maybe improve
`git_hash_clone()` so that it is not required to initialize the context
beforehand?

Thanks!

Patrick
