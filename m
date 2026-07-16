Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C7C13AA2D
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179951; cv=none; b=hB4/X0XVHMaVMZk1vBr72WPElNZirwfMhCzN0iyqTGmOBysWqd0Yi0NIRnePI+MAnuiYEShs/70hWsRvjm1GwEZM9i874HTBY/mxU23un3KfMMdWeRO9A6kOr1O3TV0b8zGHhrKxihdXjQn/4z3q9fv/KEOFKF/VdvCCvafFwSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179951; c=relaxed/simple;
	bh=/qyj78hiPdFvmsuexUxTAvR39J5rozV2sq5XluGZGgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejQ19q7vf5bgcys4mdfjhe9Mpa763Rg7lDEJJkM7rBkiT6du21lgA73GjMyVRr+EkdPjlw8eNIJft+WEgSskP1ZAY98ZZLKbS+i33pfX15pbZqS0fwnYsGkvQJeB8d5JqwNWGq+Nzj0CFkfWIlyeb3TzqwESooUickIMQPOxhtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SW+DaLpB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nhh9hLTv; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SW+DaLpB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nhh9hLTv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 38DD91D0010C;
	Thu, 16 Jul 2026 01:32:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 01:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784179949; x=1784266349; bh=vjzO2btpuU
	Qkj3O55NOqykjZRXzpCNYspWBYoWrYSaI=; b=SW+DaLpBiyB24EhBnTP7elbL3E
	y4VbQvI+vYkus5aJ2cHwXUJYw5MnAog0LPx95rFOKIvhXfF1XL12RAiDvGNNAwaM
	uePmmZrLVHGx9DHNkjk9L7RclBs6svvZ1RSDXqp9tmHLWmohw5U4aKpradoxIoYg
	grH/v76mkbd5LgzRkPWav9/3IqexPnGfV3bP1UnDlePfl0BlwtpsAwiuWlHbqhKB
	8izfRc6aKlPZBDdXnUmqi5XJuemZKa311ULFm8v2ZZH+E4UMI0xHahfZL6i1k5Um
	oTqh2IhWzy5fYNyNS+X8Y1uads7iAe2WVe6W/GLxDegkiwffqruVlpYaKVPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784179949; x=1784266349; bh=vjzO2btpuUQkj3O55NOqykjZRXzpCNYspWB
	YoWrYSaI=; b=nhh9hLTv1j5OBzIiTGvR6z4ES+cFhLZr5EOukiWbLOM2iN6Og4X
	6rUYeLq5cYFEiR6RckroFHZOzEk9v+KMVsy8MZ5gdTfUhy2u8+wvj2vKvCfaNNmK
	5vsJgkbri2D2hC8jYmaFR9vAP/sBV6y0VGgqNCVgWC1fEpZLFIjcMxCzllXNXmOF
	Hs/v+ajREoG6DZbMrjpCBMoUqfQw3W5UBlij2M20UJjWLCMd10snaNhenmtVcYjX
	ldPPcGl3i+MbGpLsD+Dgti8TUJ4H2WzcLFgrt8rVOTaDS651GLhy2SGgj4Dmvw9L
	wtPJx0LScPsrh14FDlC9PaP3VOTVu4TPL3Q==
X-ME-Sender: <xms:7GxYaskXO0lZ4MtK05Gh8mvI55pM-lYmZovAKyVJ3-_RyP2gudMgXg>
    <xme:7GxYajSupTIFP4vc9WY644GbsbsWUtCOMNM2wbBOYC_b-0fk9E4f59LuLcsSUcF2f
    AK9iTBDfYqLzVWI8cDDfJd2H3TWIJULufbOM1Xs4fDGWnuGXAcnzw>
X-ME-Received: <xmr:7GxYaoDse096AaoIJ4IZUe4yPUfD8d_xP0_jI5OrauBj2olr0NRxwhR54zStzxu_VzmJ1o_bvX5Dvoz-SSZ5jV1Ws6VZZLEmmg7-x7Yc>
X-ME-Proxy-Cause: dmFkZTGwW/cOfQ01DyE//b6CZGQa8Bh+7x51sMU9Jt9n940pH0MFZo5PFEhXVqUbdZ7JCk
    Vqd3y9S0fCGSpYs0agf9vPQuPqKjEwN5WbzL0RBgo4chl0VEy6iCElIWxWDi8iH/30YL7t
    ipjEkVZhenQhCcTFiW1KDzqdwZdnAP8A0I4DjW+TO8A4CDhfGc3kEJZeDCdPx0ig6Fz2mF
    SSkLMWVDv4SP1wdKkPn9BsassRQZCqQ5rWjQtjiwdY7lP5iRFGALR4RpijU9D1ETYZpIbC
    WcDejWnGLoi3Ib0wFMlzOVwEsEFZoNhvbuyxCIMZ9C1GP/Zb24jOQ23xWYwCAbYx4KNedu
    thJ2hU+/eyYDs6ZdyeFAZFJOWDnPtTfsx59I9w28e6Up9cH1+MGTWjr7WEfCrOdrfM9N72
    98CD9v5421rmSlmKSWNxzF/T+xSIc0l6dTNkKUALIvVpxjNHAst0Ap7nQT0rBOqUKCGB20
    mSRlptP9acts6EMvY1eMj2X+AQjBifSBFZfJ4XUamok70t+qkSiIDTcj23XzIa+YW7QDFB
    hbNCNfm/mDkHgTk1LOaaQzDNEyWyjumslepKKQs2G97dL6k+gUjorCbJCEvRAneaVsAZzx
    IrwKHmDfUp+pgY/l4PgnbWAlHtW0m+Wevb42IIuger9LEl8NoC1xkm+I/RBw
X-ME-Proxy: <xmx:7GxYaiQ2CR3nseVqnAEmvfvzMZbEkVGwxG9pUrZ2LA_uElvpO9GJ4w>
    <xmx:7GxYaurgIS8NHKsRBw9tHgGY24c4TR0qbYg2_kf5uK0FsbZjjsH7Ig>
    <xmx:7GxYasyAyM-T3t2xIViwPKx0nW3KPbWFjWU4-lQytZlbUEsgQb8KtQ>
    <xmx:7GxYarIo-a1jWY7JUnK2poaWk0ZpU78XZrvp1gzpuWtWtp4VHGLSmg>
    <xmx:7WxYas4HvbgapB87el6ILg-7OIhXg1tQ0xu9rkgLZXXnG7F8Zeqfm_fD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 01:32:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76222803 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 05:32:26 +0000 (UTC)
Date: Thu, 16 Jul 2026 07:32:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/7] refs/packed: drop `USE_THE_REPOSITORY_VARIABLE`
Message-ID: <alhs5wDFGWbzp2Zs@pks.im>
References: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
 <20260715-pks-refs-wo-the-repository-v2-2-d00d364f5a3e@pks.im>
 <871pd4h1y3.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pd4h1y3.fsf@emacs.iotcl.com>

On Wed, Jul 15, 2026 at 02:28:20PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > There's a single user of `the_repository` in the "packed" reference
> > backend. Convert it to instead use the backend's repository and drop
> > `USE_THE_REPOSITORY_VARIABLE`.
> 
> Well, this was removed in the previous patch. I'm fine keeping this as a
> separate commmit, but the messaging is a bit confusing.

That's fair indeed. I don't quite remember why I split it up -- I assume
that originally I had to do some more changes? Anyway, I think it's
sensible to just merge these two commits.

Patrick
