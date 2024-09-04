Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78A13AD20
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432112; cv=none; b=GpFXZ5XYRW1uRQZY+xj/8oy1JBm2vpuvSW4l03TD1B1ooY+8+u2gpQIbd+eOcxSdSPmcfjFdeiKPFNGktLLI4NpzWrScB34yExnHH1pfYJ3IPZo5Tx/cIyRekG4nhExk+a3yz0MtFK46yQS4a/P8WQEWHYEfB2q2+mVu52aFMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432112; c=relaxed/simple;
	bh=o0jLTK59rNica6DBPUW/bRDtd0uHA1guuIV+iNyRgnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1xFe/P4ve/QOFobix8/ea7s5rfraUVWbawFtyVr3HKx6lWpfoRwUO/BejYas947V0LlEU8wp6w06yfKjC5+/eRUHTh5RNeePiYi/i+WBe6ZPwTGPDrP+vRU9+//FUTuNPC0AMxhRpk5i6NTQpAwNQuXCic9rZoqe+tpbxm+7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LFTTp/9E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hWNK5HSD; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LFTTp/9E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hWNK5HSD"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E35D114020A;
	Wed,  4 Sep 2024 02:41:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 04 Sep 2024 02:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725432110; x=1725518510; bh=bklKXrJHWm
	Xww7s11wWUgj8vIsYwjB944oUdqZBHCqk=; b=LFTTp/9EMUgoBcL2jRvAP4ceZP
	PnnbzC8eqCElms3ZHItI7klkuWHpkj+bWPva6zdQX8tQsynlF/wlBLWnOtzl1lWB
	Piv97LHd0SvSWdyRRjEWIofJQeHu+8PXmMgOKMr3Pw71pTpfpEhYOWmEI/UcTSqp
	ZDf6h1CMhFzuGZp5p7tRzwbCayIL3nSENkeQe+2KUnAtV+TyxMCbIDGe46QsU2Su
	laLez2HJfmRy1putMHbDTDl6hWBRYp0PjB0kJOTH+6Hk7nULQfWVKAO2j7D3RqtS
	1sXxgtx3ggxOfKZOsyXeksfcVrV6JEN6HZdv5490Rt6b0nZMai0rY0AWj2Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725432110; x=1725518510; bh=bklKXrJHWmXww7s11wWUgj8vIsYw
	jB944oUdqZBHCqk=; b=hWNK5HSDZb2L4gb5aw51bSTX+te7rAa5uDTDeRXAd3H2
	L02diCazifrtPgf5zk2SS/8tEsq+BQbQGEqR7M1iPzvLhGcXy7ke6huza0Tqu4/x
	H7pwYkfQo3BQJ8F1DLMDg2vHsuTLc67bHAJqQa0znlS5692FSf7g57wqwfowwLz3
	DbWFVAB8tLfY1vYIdGLmzRFzKCwZh4aeJ64lkc5lP5SO/QDv1GHmWFr5OIEK9PaH
	jye82m6buaWniSnKbRRmqmB8/B92UuVQ2qBD2mn6JVKA/jszaNGKlwT+1GPq5QQp
	oC5Ru3CizzGdicxg0dnFM85gNX5GlmBsPkuWvtJhjg==
X-ME-Sender: <xms:LgHYZjf6gZJ4lYHt6hR5wIu5bB8Vg1gRn4A0LRXuEE06Y87bUib1BQ>
    <xme:LgHYZpMPz8yIB-eMocE5T8NLgg4I04_V5bnKcfceKj03-L7jScc0NJadBtieYAF1c
    38Q2YqFFGR0EVWnTQ>
X-ME-Received: <xmr:LgHYZsgLDAn2hDeiLKkHGFeQNXztztOM7XBbQ5UOm4NuBR2QwdA9usw-6ts4Vk6Sl83CTU36X8n4EtH2uzSqgUOiRPy8efHPmzmloCBf9bVP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejffffveehtedukeegjedtuefhjeeghedtffetgfeg
    feeljeefhffgueehjefhvdenucffohhmrghinhepphhkshdrihhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:LgHYZk8g-j3cp9VL-d6saZuibHc8pe6iox8ptPka4VahlErI1Pw5LQ>
    <xmx:LgHYZvt_nqOXWF7OFZbZ0_F7jUy7w5lukgQUrus1dy4IWGSbsariVw>
    <xmx:LgHYZjGcwjeE2SoGT9xnh5ZoE7s5emAxzgQ6E1qGW-C13mgAY4PT7w>
    <xmx:LgHYZmMY-oOVujOwkjc-UKwTo03IMzExLjsPbI21Gf7_0_t7MtK6bA>
    <xmx:LgHYZvL21fbgJPxThPTDSOMiQYRAdq417MdOo-TSk_c6EVsgCnpTFO0G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 02:41:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 04afa546 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 06:41:40 +0000 (UTC)
Date: Wed, 4 Sep 2024 08:41:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2024, #01; Tue, 3)
Message-ID: <ZtgBKbEnL8xJBGpE@pks.im>
References: <xmqqr0a0fik4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr0a0fik4.fsf@gitster.g>

On Tue, Sep 03, 2024 at 04:01:31PM -0700, Junio C Hamano wrote:
> * ps/clar-unit-test (2024-09-03) 14 commits
>  - clar: add CMake support
>  - t/unit-tests: convert ctype tests to use clar
>  - t/unit-tests: convert strvec tests to use clar
>  - t/unit-tests: implement test driver
>  - Makefile: wire up the clar unit testing framework
>  - Makefile: do not use sparse on third-party sources
>  - Makefile: make hdr-check depend on generated headers
>  - Makefile: fix sparse dependency on GENERATED_H
>  - clar: stop including `shellapi.h` unnecessarily
>  - clar(win32): avoid compile error due to unused `fs_copy()`
>  - clar: avoid compile error with mingw-w64
>  - t/clar: fix compatibility with NonStop
>  - t: import the clar unit testing framework
>  - t: do not pass GIT_TEST_OPTS to unit tests with prove
> 
>  Import clar unit tests framework libgit2 folks invented for our
>  use.
> 
>  Ready?
>  source: <cover.1725349234.git.ps@pks.im>

I'd like to wait for a (hopefully) final review from Phillip before this
is merged down.

Patrick
