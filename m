Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931352C3242
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868647; cv=none; b=EbXA/ghHNoaCLpu7sFWHVsCwKNvhedb9T7NaSIqS+uDxLF7+HDm2TM5nO88G6UTHq3VYQpn3+Mo6vipvfB/d/LYQxfN9Vtrglg+j8gr+UVsion41eCnEMXD8Wc7SXpwyyo+mvTzdm3pQM+MbPEJKJRS95YfNerS6F4jPFuF8Z6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868647; c=relaxed/simple;
	bh=Fh+zHAgKXPaAv3Xo0adS5VprNH3PBUhzTfT2nlCsDPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IbGy6OHeEIVSAS8v7M+rYoBXjyWGWmYbr7X4KLvs1HRhqhkjs8qOBXVUcQ7eCtKYoGB+6BMQ9GNGssC3+TiJ+CRm+pTzqfWeB2j1/hx3H8S5XzXe/sjNbbHxALlcnsu7DJ00lH5y9sUdn9b3a9vM5xeb5MuDrWbvYwp30K5tHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oBsvYuuP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Axf7gM5W; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oBsvYuuP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Axf7gM5W"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B3BD11400105;
	Wed, 25 Jun 2025 12:24:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 25 Jun 2025 12:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750868644;
	 x=1750955044; bh=Fh+zHAgKXPaAv3Xo0adS5VprNH3PBUhzTfT2nlCsDPw=; b=
	oBsvYuuPNTZohOtPi26vepMdmZ/E8w6yqJR4Jyfohw9KkmQN6/X71bGkFLM1j/HU
	mF642L3bGUsMPrY+uOTn7dogOLWUgBOHAgvPST0tsOGzYH1Anh/HTlkLwP8jrp1B
	YDZCR6NWp0Uckj5T+Pr0MlXGd2vTiEr0WxmMiCAClfwDcuREXlknuRlD8sbVaSz9
	SZXrJja5m2RLDnjjczXOyD3LrLUyDCyqkEjCQj5yzQRGatVP2aNzLZc5v/4ZDsvq
	gQ5+XE+ChM1hpoF6zkC5QQw+vw4FaAPqfoQVizuhB/CdM62pBKJKjsmpTyfKaCus
	fswoGyCBAah1hFrzAvSgBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750868644; x=
	1750955044; bh=Fh+zHAgKXPaAv3Xo0adS5VprNH3PBUhzTfT2nlCsDPw=; b=A
	xf7gM5WrH1Fc/9zT234MHmA+q0ux21b/OXVJtjS7/gL4w/oMAlP+6gIux4w3nwsb
	+0ZAfLh5TYYCNkXiVNXRkKJ2C2g4uMztD8tZ9laBZ4P1lMfjzeLrvd7qjeZdbcj4
	dPq6WIYhzOwylsTGxXbnajKkCxQ756LHjJlF/We6Ey/21ncOWQM0TsSvvjnWEmE0
	pBed2m3VcOUtvkwy4nEF7VrnIRv9CrxgX/ShMiGk3Z0jFu/y5P9vnmUzl4lPhMqc
	pGjJUolusuz/SJKm7hIpa4KgDdGPyINCasyrYCp8Calld0oDgRVnaS783dQX9e5W
	2CFEKi1NmrDZvYHhd+f4w==
X-ME-Sender: <xms:pCJcaLPBHiHF9_F1jK9l5VCV3_WZvG_ufLdSbedgMhhJhG_gFlgsQA>
    <xme:pCJcaF9nGc8jKnJrNZd5C2wfDtbp84zizE3apvpmXUD0O-MenHOl_qZXy1I2Zfxjw
    xxUlhcZpvra8V0h7g>
X-ME-Received: <xmr:pCJcaKS1pKU-l4pqD-5-oB8l4FAXYec6hXWInYVC7obLNn8-Xq28kSqiM-NdpcqfSRBgIYrGRvMU5gdHRbhiJRE8urq9qF5elNBgc3Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieeguefgveejhfdvgedvffetvedtleekvdegleejgeejtedugfejteejtdff
    udefnecuffhomhgrihhnpehmrghnjedrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilh
    hlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pCJcaPsaZnKdHCGdZtmw8tL4D0NH9DcLHXABuBbBr-wTEE9KBmUpXA>
    <xmx:pCJcaDfDXjdaudVN4Vx8_mOyHq_23GEibiScJQM8NPrxT7i_LMskag>
    <xmx:pCJcaL0kV-DnzFnBEnwVWiql1Vxf7HPlnLLelo4KKdpm4xRqUc41eQ>
    <xmx:pCJcaP8D9gaF-6OHq-pW55R1vQFcSZExWMwN4FbxlhMG4eXjUtYejw>
    <xmx:pCJcaLr4TeJ_RLbUN4pJzH_9b_0YIMV9MV5tPjIZotn1hHUddZETK9Cr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 12:24:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,
  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/3] daemon: explicitly allow EINTR during poll()
In-Reply-To: <907a79d1-da2e-4c8e-963f-05c6e313643f@gmail.com> (Phillip Wood's
	message of "Wed, 25 Jun 2025 09:39:25 +0100")
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
	<907a79d1-da2e-4c8e-963f-05c6e313643f@gmail.com>
Date: Wed, 25 Jun 2025 09:24:03 -0700
Message-ID: <xmqqo6ubx00s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 25/06/2025 08:35, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
>> This series addresses and ambiguity that is at least visible in OpenBSD,
>> where zombie proceses would only be cleared after a new connection is
>> received.
>
> There is still a race where a child that exits after it has been
> checked in check_dead_children() but before we call poll() will not be
> collected until a new connection is received or a child exits while
> we're polling. If we used the self-pipe trick described on the
> select(2) man page [1] we would avoid that race and would not need to
> mess with SA_RESTART and so would not need to introduce
> USE_NON_POSIX_SIGNAL.
>
> Best Wishes
>
> Phillip
>
> [1] https://www.man7.org/linux/man-pages/man2/select.2.html

The principle should apply equally to poll-based service loop, I
presume.

Thanks.
