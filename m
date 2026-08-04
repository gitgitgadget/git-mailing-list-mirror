Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445093603C2
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 06:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785824396; cv=none; b=Q6ESkdGqf3rlR83KcRX0mDwJm2n4YBHdz9lGi/4kMnZX0LqYFnFTa7HDDFZl10zV3ZCUcyvJNCZDzsgSEmodQjXv8ygJCYbTptb5ZRfSIEV5atpMh296hdQI+4ML/ZA3GETsFGpdYH6foldP7rjLvdiEGZZe90Y3KR1+3j/T4BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785824396; c=relaxed/simple;
	bh=o3LQb5dU7Ut0LRSbQQ8R1eIiti180x0EcDS6+psyPkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igg8B4S3n9tq7z57xU2dVaFl2q03q08TAwviVaX8ECMZgw0IHRZPIe2Vz8mPtI6xsSikq6wl46AyURRAIrWpTrYNX3IqHfv0uBhb9Eam+1fV3t0AstsQwdpQXBZHA4nkQHcirKmJy3fn0yE0KgopAcakNZMUjy5xx6kxMwG/2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fjzvefN5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TgYHtSTb; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fjzvefN5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TgYHtSTb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E9D107A0138;
	Tue,  4 Aug 2026 02:19:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 04 Aug 2026 02:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785824392; x=1785910792; bh=9kQSP2LuVW
	qcx3V6XXsKJe9Tj61rBtZVDfIocTKqA9I=; b=fjzvefN5OU/DzisHXOLnwzgKfF
	rftryyhD4Wj5NHdeVwnvvGIEsG1QF7g6Tp6vrEB3MY97nMi+rPubKdNxHNL9sv1U
	YZnmxPhj0uzTF77hUARFwgEQ5p0LB6B+2AgI2zAvaYy4aluHngclq1SLgXR/7lqj
	YslnEtBtsfH/b02HDkI2tSGcOSkLBPRLv9/ELxs0aMB9cItJqHEkd+HSUivvC1UJ
	lH3LGFTYazVlnOo3LtG2yi/zY7KUAVM8Z8CPiMMX1qaG8Cu5G1hNqPqYZMBEisPQ
	Wwlyom6OeO62Rk77YkvylzZtC8kLLIgFHBfiOKs+K/ICfM2fTjtgoj4IZ4EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785824392; x=1785910792; bh=9kQSP2LuVWqcx3V6XXsKJe9Tj61rBtZVDfI
	ocTKqA9I=; b=TgYHtSTbE7hntIiDAgx1M41SV9JsRSmbKv/Ib6ltAC+JOgl8tvx
	prqHivBg+9LFI5U+t/wboFtobWe3VpUYZifpdeik1sLh18jb5qpHXB/nfz0aVR3B
	eywi9kFMcWAPH2csk7GRLeUzq3F+PV6QKD4Im7brNOvIlmU27WaYIGHS8blmkJ6M
	qtNI+3mcLpuNGGGSo2+eFAdXr++auMJeHTvTsHueqPKXIM2X7WcdybwSjRsKABQn
	o2qII4umFv4djPbFVy1rD0aGBKjVhy9Vv7XXQplZCTBK6egOhD4PS5Phhj4e7hq3
	qvJYzDgGT+i2ysIH0Pf9ZgGbeWgAzfPS0og==
X-ME-Sender: <xms:iIRxau1cqPMjrf5iA_bSvuS-J9vUkABRbnuRQY98yDzQVOUHaDCOQQ>
    <xme:iIRxan9l1U2sjI9uwLYAhYCRhqB0Eoto6Wtwkl6ihdM-hoXv3enwgMQeNybvWVKZZ
    0skXQE3bbXHMHBpsAXFY530vc-2TB-ajKSJc4f0vv-9LvcQ_TNW>
X-ME-Received: <xmr:iIRxavPjMjNjycfK412dATceifWGYWJ8ZJLZz4XHxR3yD0EQ_bACHs8TRj6xXeW19D5vMsR7d0IoYXnHO5ByNMoMOI9_f74g98iUoT6d>
X-ME-Proxy-Cause: dmFkZTFEcIP0mIo/0/YEv0UyoUro1uDednvPbW3EgQqzPqXUZfRXwo6KoXYQkjNWBvp0ir
    wKUiide8zfvMVmw6tQOOWpDybgc9xcpXkAlQJ7MO3vRsIHo5D9sTq/UZcNhspFN6TBgsb4
    xZVz6WuH0gYRu3HIJz5pMxA3rzsO1Rp36WUBMrLR5j1xa3rKBrOxVzMelwW2Okf1Xdm39d
    9DU3HMBGH7s6y/W9sd3lDgkQga26AW+y2joctFSHrjK1czg5CIni1EGDZ4IaLhLykhG6M0
    ozENGTDpcaAE9GqrHMVULAoZe3+/RCL1YPpbthmiOtNbedOUr/8wEcahpAzj+UaNwUNoRW
    PtPc9jDuDs8jiYqb0fRHsVfDPqfI8GaJ368Mv04hZ7QCZvq92YR7nm91/IWDoKrxKyC19Y
    qAdPSPtcIvSgrU9OvnLUdZSwFKEuabUWtBm2AbtAYJDbt4x+JNTeRHbkvVuVao+Wz/tTnX
    08jQnE1FWS8JpWfKGONkVrhSWh6KWzZOEkoDyKC8yXTUc1kbk775AyZjSHUIA5tM4NA04k
    s2rNwJnC+QFWWRx/UV6EfQtk8WnB84A8aGDOLlKnDKynGwCX50t2ws+0keMEbt3Lpxn6/R
    5S+qHoJ1SMGe0QwmpXZ+zWMxu4ZNhNlgrcgJBaQHYtpCcmlftcoBk6BO5dnA
X-ME-Proxy: <xmx:iIRxareKHOmOyQy8eNZdvUT8T4SJt4LKgrvnXy-cooYte14fTynYqQ>
    <xmx:iIRxauU2ka27szRzA9Q_URvixu3IfPkYi0luv6Cdddp5OrUtZPnyvg>
    <xmx:iIRxajh3PpMM9zyafsWg8ARAdjcOHV-G_d6f4p-6N6dCrVjT3RqkBA>
    <xmx:iIRxat9ajp4m48zceTFPMFzclsURvYu-TWHbohTx2Oxk3NLqbRM_bg>
    <xmx:iIRxas5tlYKzUTHzULbbFbmVtTe0Ahnd2_m_6HoEeKDeqHbWRAcTpJnC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 02:19:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id deb121d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 06:19:49 +0000 (UTC)
Date: Tue, 4 Aug 2026 08:19:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Wolfgang Kritzinger <wkritzinger@atlassian.com>,
	git@vger.kernel.org
Subject: Re: Performance regression in connectivity check during receive-pack
 (git 2.54)
Message-ID: <anGEgUrzzQYzEK_K@pks.im>
References: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
 <20260721035733.GA581473@coredump.intra.peff.net>
 <xmqqtsps76f1.fsf@gitster.g>
 <amCuLpT6vYzo1GF8@pks.im>
 <xmqqh5lrrplt.fsf@gitster.g>
 <20260723104943.GC604358@coredump.intra.peff.net>
 <amLgMqkqxR8mKIbT@pks.im>
 <amd4yR3EEn_fVZcm@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amd4yR3EEn_fVZcm@denethor>

On Mon, Jul 27, 2026 at 10:45:46AM -0500, Justin Tobler wrote:
> On 26/07/24 05:46AM, Patrick Steinhardt wrote:
[snip]
> > I think overall this could simplify some of the design, and it makes a
> > bunch of issues that I have been struggling with go away. The devil may
> > be in the details of course, but I think transitioning towards this
> > should be doable.
> 
> I am certainly a fan of this direction. We do lose some flexibility in
> terms of supporting alternates more generically, but I'm not sure
> supporting alternates of different source types in the same repo would
> be something we want anyways in practice due to the additional
> complexity.

True. But if we ever find that we actually want that flexibility we
don't paint ourselves into a corner, either, as it is rather trivial to
introduce another source type that allows us to mix and match different
sources.

Patrick
