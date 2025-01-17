Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC8276C61
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737095240; cv=none; b=KfHP0RAAO9JRmK397x+GqABroVo/FdLj3eMFbYgU+5mH3YMMfXiNb1g8u0yykSzJo5csPK+WP8UimddjTwo5hsH/zv4dcLMgsF0rhsXQ4aUqYv6loTtFKPOTCyQvozpjtU96zYvr4JxvsNJz85wE9aPw88RQn8dXoWOwoHl3vj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737095240; c=relaxed/simple;
	bh=pqKhlRYTnKoeRYYmSj+7xhhbg2sc7akS/Nl2+Z/0r+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqdJe1Erx1nJXW260+DujGh6Mj6Z0q9iWeE3aUBhmuYIfVE5etJviqqMzLXax+29K+q9V6i0wiEPqhfWHmOu/aLbOBVkWno7XwF5vrTgYvYo6T9j6NdVH95eB5Ev1KZjLjBcdRkDMvHwKL/Id5OkKkv4eNiZd73RP+y6zoA06Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cPiOZ1LF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aSG+JK/q; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cPiOZ1LF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aSG+JK/q"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D45613801E2;
	Fri, 17 Jan 2025 01:27:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 17 Jan 2025 01:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737095236; x=1737181636; bh=pSRHiXYo/I
	xHKJjq6AyHcbnvuQOYXx5ofwgx/2V1KA8=; b=cPiOZ1LFva2b8cEnj7gO5A64GB
	v4/uCpmATQVi2482AnQMEhjJV6QoZmJLU6zY/vi3d7wIjHRIytjTMedhfHW1h+bY
	1GISxGyZca3E+kOLrQToMtNKSVXBbeVIbGrrOefOJ6gqGe5ge1icYcGCBIc56Hkk
	7NoHf8miKNccr7JN+Cz0e8L3P+CK4Z6dLTrQKma/yRfgnRdPV7BmRfzgnh0c1U7e
	K/KtwnTONyKf5aomALMEFUBI8z3FpO5LP/LHG2S4BqlO6WOGDIigQjFduZL0qzl1
	ZK0NSkXsuKvG5A7wUH8qrV+e1ZdFgNKS9a/hlGcMW4+gf1cajGyMzsJUOeMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737095236; x=1737181636; bh=pSRHiXYo/IxHKJjq6AyHcbnvuQOYXx5ofwg
	x/2V1KA8=; b=aSG+JK/qWOvjXxnGGJowCjwQ7dFpQQ/u/tUPcCPt6AxbcrgPGEf
	ozzPLIML1aidVnZw+ptbsDUFtpasorU5vY+WGw2W5zyd42tOXBAchnDl1ZIXeRsW
	fSt7bRnmYyVlcqUdPEu4oeMNf94JebrYsCs0eoi32Mmi88TwUqtJ7CpyymSx/7Eg
	g2RhbM7UoNpY2/6Ctn77AbKDG4L5Zc/TtgMja3O42eQ3BJPMEGgU9xNLH87X3cPX
	+DNGqYoJr2lEo3ct/Ym56DmfK39HBGYz+Ndpd2HXpVvvtPJ4U8YW58Uz7qWqQ+lk
	3w2E6ayAJ74MUVQSVYfgm5Z/Z74SeTkfXSA==
X-ME-Sender: <xms:Q_iJZya7Ur9gqF_LAHeMELSPNrf6G-q3qB3qyU2RXxOTl_GeTE5_hQ>
    <xme:Q_iJZ1bvW40gdSS-2M-Msuto_wEQRln4_pszt7Z_Bn0ZlnmbGjFFFbXc49fbyUxb3
    E3bGnz-EvZ-rE-LhQ>
X-ME-Received: <xmr:Q_iJZ8-D1Pfko2NaldGWN34BD1nSTgKN_P05xqRLDrnQMTH_wNojo4yReZli1NHZ2K50S7vqbSScKmyuUaIzKVD7g1bvKVbur9YYvc2eyd_uCd8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeivddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Q_iJZ0qFn70Z9Sfql3869SNqetScsHEC2oJQVEw1m_--NIVuL7LiYA>
    <xmx:Q_iJZ9oAKFdlS8xbqRIi0ou8s9udqaPU9QQAY4pWnVVUjDtv3sUmUQ>
    <xmx:Q_iJZyTVqmKiVttZSAGJwK_IpeKG0fci0c_HIDgVNhb5d37lyr6uew>
    <xmx:Q_iJZ9qpCKa6DOIZDnVlk6dCB06534jx44oVh6_bMnp2WQJg8gsyMA>
    <xmx:RPiJZ0U7Q-LvT4kxHCQZsr-O46OumEWda50_OL12cKY2mJS9TPKHmDM6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 01:27:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b2e80e8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 06:27:12 +0000 (UTC)
Date: Fri, 17 Jan 2025 07:27:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/4] t/unit-tests: convert unit-tests to use clar
Message-ID: <Z4n4MxQ8FT-w6QLW@pks.im>
References: <20250116104911.77405-1-kuforiji98@gmail.com>
 <20250116161559.91038-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116161559.91038-1-kuforiji98@gmail.com>

On Thu, Jan 16, 2025 at 05:15:55PM +0100, Seyi Kuforiji wrote:
> Range-diff against v1:
> 1:  00bb4d2880 = 1:  00bb4d2880 t/unit-tests: handle dashes in test suite filenames
> 2:  59abf45f08 = 2:  59abf45f08 t/unit-tests: convert mem-pool test to use clar test framework
> 3:  6e01da141d = 3:  6e01da141d t/unit-tests: adapt priority queue test to use clar test framework
> 4:  b397a5f131 = 4:  b397a5f131 t/unit-tests: convert reftable tree test to use clar test framework

I think you passed wrong commit ranges for the range-diff :)

Anyway, I scanned through the changes and saw that all my feedback was
addressed. I've got one more proposal for the first commit message, but
other than that the series looks good to me.

Thanks!

Patrick
