Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0DD242D98
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416467; cv=none; b=oLPOkq+qdiy4nUnP2vWU43f8l9/MGSdAqS+QBvUi9uBVSB2xYqKglfLnNSB4anG25iJV+pzblucw7qaqWzc+XUjX06tTLJggf+ktl/akxqg8cOhXhldMl8xDE5/E4Vt4i6gsygFWwRPFXnycBpL2FrzPtM1ZOU12Mb5jTShXVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416467; c=relaxed/simple;
	bh=KCPum/ZRDVavIi0Nm+vbcHRdmZz8qcuVv2QZVeALviE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlatL+gl/Lj85BgsQ2ClFpgxwt/U5CztXGmfeiq6zcLnqOtf1JoH6PAJ4xZZ2lChr4m3VIe1VUxrPEyrkNb9N8DXbnMVpy+ayGKjBGzXL1dbufc7SfLyJ/N5iULxsq1Ntx0mn85xu+O4FAU8BeS48VSH67wYUsvAQrbNRZI+CVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rgw0VsUm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hhYguLnx; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rgw0VsUm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hhYguLnx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 48A55254018F;
	Wed, 28 May 2025 03:14:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 28 May 2025 03:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748416464;
	 x=1748502864; bh=KCPum/ZRDVavIi0Nm+vbcHRdmZz8qcuVv2QZVeALviE=; b=
	Rgw0VsUm3KgUVBkgPiHiSj+djUulxTmdW4VMlJtFnk98Snq5i1Jt5Hw0ddueg3IE
	kpLibGYvT6/livc9p2daF9v7AoGty6LVPoLrORG0+0PEIHijJVCrHFCix1ea0QCj
	p/RAFuVACkE8ypM34E2Rxzg7fmn/d4LZtU2GSfMKOsVYwroBOBMA3nXMICOaMVoO
	ckjfkgwzmfv8iSgr+DGMUWfg5lDDPRd+QkrSoHGhR5EUHEkQVuXz26Tdal9LnhCR
	ixB7DJg/XrhkoiCB0n2saNN2iNJ51IthLV7TeDFZIOa1Gxx2FqjFWXTBQPXZhIql
	2uNW65gz3dq0/40Y+Io9fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748416464; x=
	1748502864; bh=KCPum/ZRDVavIi0Nm+vbcHRdmZz8qcuVv2QZVeALviE=; b=h
	hYguLnxmQbdiBCMRj+GjO7rvMTEGzvhHJcH/kXYej2w7kam6YDB7ZIYS4h/DwUHB
	Af3dUrODo+ctEUUC40IVkfd2qj/iI3cxHl2qSUW+9Ek34KJ92rvUb94ZrmdnOkfM
	3fvTOj+EAZhLN0nbtgiuBXYrDu67uuS7Dlt3OUKuRNM0EyoYuGh7vcj74yPR/WHU
	rXdfGjlHMkIvXAVU+zqq+rd1vL92p2OdCPhWg3XEdTIzDHylR/A99Py7k7p3bwTL
	fDAggswa1j/XormeRj6/2a1+P9VdaJaKHukeDjqi+7wHsctk+SVol7dav4J9BKid
	4A23uZ8ivH4GyzuSPUaRQ==
X-ME-Sender: <xms:0Lc2aO1ps12ZCAJp5VRPtLA2t4kZ6s-N1zGrwgWlxw5heYF3Or0kXw>
    <xme:0Lc2aBEkAYvqSAxp9EynZw41OAmV6YkYCACrT2XoxKnL_1gdq7-I-0lufd13V7C8G
    qMYI156XIICmwbkHQ>
X-ME-Received: <xmr:0Lc2aG757yoIcdZwZOIxQ8JqlWfgd5phksyNnV_xaAUvTxfSqI2V44bGb_us373wf8oSq2urAMkdUVGDdXxfTiPV-Ih4gLbU-q936Ym9XnI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdeigeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhm
    pefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtf
    frrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeej
    leegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhhimhiffidtfedtieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0Lc2aP1zkXy3Hw-LkUBe8SvgxKgmQ-9Lz3iStIrTZVe0lPPvfQ_2Xg>
    <xmx:0Lc2aBF1o0fASX5RVPz2z4yYnJ94vY7OZxrDykY5RKBFL9-zPQGADg>
    <xmx:0Lc2aI-6WIbXUMxi07pLERtYheMW_xBWDzOkgdi0gqikoR7mmNYEdg>
    <xmx:0Lc2aGl61Vtm80D05G3T6Pk5GAkbJAIg44fnz3EvaAHvrYgx_IucxQ>
    <xmx:0Lc2aAvKVqT73iGR-nLq_kEUqo1NlftRFFBetBz8dcgOsE28IRpxqnsS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 03:14:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 66878f1f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 28 May 2025 07:14:21 +0000 (UTC)
Date: Wed, 28 May 2025 09:14:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: oneee <kimww0306@gmail.com>
Cc: gitgitgadget@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] doc: sparse-checkout: Fix list markers
Message-ID: <aDa3zDadAK2j5R7x@pks.im>
References: <1C18C458-3565-455E-92D5-594520413D13@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1C18C458-3565-455E-92D5-594520413D13@gmail.com>

On Wed, May 28, 2025 at 03:19:54PM +0900, oneee wrote:
> Hello, I was wondering if there’s any reason this hasn’t been reviewed
> yet. It’s been a month, and I believe this is a relatively simple
> change to go over.

It probably just fell through the cracks. I've left some feedback now,
thanks for the ping!

Patrick
