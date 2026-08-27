Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7E47986A
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840565; cv=none; b=HSv/A3f8d8yvqq94uFsNk5nbssfE2T3aQub6A7lMRW9Utuab+qf5BzQr4VwImu9tWBLEmy7AWkwAe1JCrRD8Hnr0zsBqr/8ra3HvNI11hq3o+wgmrnkuB2lYZghTBQ+nIbeU9HCXeFI7FN/GH8qBjUCxtUl2gLJWW3OMWC9KklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840565; c=relaxed/simple;
	bh=bPfoOZMKmNos28qaKM2n2lXMEwwqGWPJWsE9L5UnMj0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XnM0+YTzc5DSzK4DO7I/YVXxBL0urJfAhVRc5ddst0z5n/8/RIddRa5shUC6quDuFZbKdMYGS11EgDrDxiCfiVJtbrfaEV3TrYjl9MzNQfZbUqf6ON/1i6haDePaEeTARq7G8XhBIO/VRvQhruqjeI+524A4OfxHF0M0oX+FC3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LFdigd8s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Um2wY1GP; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LFdigd8s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Um2wY1GP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5EFFDEC0121;
	Thu, 27 Aug 2026 10:22:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 27 Aug 2026 10:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787840560; x=1787926960; bh=qg/yCZ5KnG
	LasqIXzNPy6ERqzs+oSZCA24BnrjHEaXQ=; b=LFdigd8sicJi/fJE65e/mMpelG
	pMeOwcAyudo6XxglsplDnMLnc8jUsYRstA42wpzFCEY0UsvLRmo8fa29CJRf7pOC
	8awHeQ10GM3nIxxwRSNuLR5NweR+NG7LM8phY/ypKVuCHjK0evGU0xRhUTmbmNSW
	GiuVPREnvsc9AB03q0Gwr+luCggGmhA4qSnl2rlManC/eSRra4Tdq78gXlf1AsnI
	6nuT/gO9y1ibouB7GzA1h/jXBQJCX7t2QIz9f0HKwyQ3VF6FDSYuSCqN1+PALeX2
	w9uHJCKuVuoK1XlectHjPACQCIXy/BTRwM4atk5ViDd8UyPxBmhGkBiX+MCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787840560; x=1787926960; bh=qg/yCZ5KnGLasqIXzNPy6ERqzs+oSZCA24B
	nrjHEaXQ=; b=Um2wY1GPDjTJsMnluI+2fuHVNy7PfwsEG9QLdP9aAA6r6lwdvXI
	MDC2WMsOkxASE7CCDEGaVuncfIPHGUEeaLxjgffTTcNAxeAZ8VLaTTr7DWmaMgnX
	9YE/UnnSa8VDwL1DzmfiG84N1AscZp/gn+EMRx8dgMdBJpjpIcWXdj027DXmSG6k
	S4vhrbBVuO1k8UxeRHVFMj9RjZaZDT+PdEDk2mfTLwPaWg5DRE/RW8baS5sKYVUR
	jkJLZfkZ8TPz8JIV5C961dPy/Zvn3/tCz25e7ylnH65bCcdTVl0s89TfIv2kpt8U
	SRe7VB0po2yIV22/GrRoJ5eCO+ltuV4VHSg==
X-ME-Sender: <xms:MEiQahZP4TdriOr5JDEG0PuAuWoyqerIQI2bfK6O2xvIda9oHghWFQ>
    <xme:MEiQav1nFuba1a_iUVayRiP6B-feyPoRh67rEj3skUtHROBrlldSBqja-7KJcX-C2
    v_I0aV27XUmDRD4gq9FQpvL8r17yj9HNN0WjBRm0KG_ZgT1IUvFIQ>
X-ME-Received: <xmr:MEiQahWdsZB7ye2a9KYp-DS89oIPcD8YWsaIITxf1eSql5ObK5L0zpTKk-7iSPYADTZiyUdaNpw1DV8TBivD2AnfCu5ZKzdl1g>
X-ME-Proxy-Cause: dmFkZTFcUm84F6s29Z9AeuBq8OVVcQCT0UPL3J6LWifMt8lOwl1/iQFxjqAUCBJqy28cZB
    6JEO2m4TQVZVM50UtrpmLWHv0Re6Aw7RSYISvGJbmQskhC8V1GMfEvIxdrhByKR9a6w6I6
    xJYNNcSCCK2+4ekz8ptdM2f0XOFJGCKFbaCt7vuBMopvkPuOUPrXsQ69XwfR/ghTOHor6W
    hwM4Cxkv+7YG362xKFwZWvA6YBg6L6LiMLvLFvBNGup2lzK0k3Y865lB2qJ4AGKDcssnOn
    NzieSiXMyBjzjwSv8EnQ/37pPkJSubHAqkmuHxQ+d3FokqJ27sh0vbG1IzO55Bbzb0drPT
    eNBdQ5vtD2yiHZI8Tcx6DzQs0V6NKl+ksNukExSl0KtDoXAs824JZqHE6virVdNE0VIDVh
    wOXPr1EkntgJWHkY9S2qdINi5bSRAh7w+4CGmAX138il4FVpGU8QlhekGKnZEUOLlDz0te
    Zjmfq7xr3s2Kz+WIx5WLRIhhvBFbIw5LuGvS9+fu7IcJLzlaxVI7rrbEagqd+Uj6jHVDe7
    WmLOOvpT20u7PK+yu0PuFpyOTLGp5+FWxShXzGF2MeTZaU+Er4/3jUsBXJpquwU+EJzsbg
    ug2HVpw5aw8Beued7Bi10QM4t6pNVTyj4rO8kD4KvYHk/VKipvybqAcJnBqw
X-ME-Proxy: <xmx:MEiQapVD5xwTqy8lyUgoZt9CEMavf3A-7xz7Ot2A8WOtIrU7Tycl4A>
    <xmx:MEiQagcg7QIfYppC6cedIP1bK9Z0XZ92_gjh-YvYtYql43uat5B-Lw>
    <xmx:MEiQaiVuwuypD9lB8rnJi5AVXR1uigpkzmLlxVzc_5dvksnjQMgGyw>
    <xmx:MEiQapctrYvCrhLWmf8rJuosiebpDBPFzhh84g7MWwHM-2Tr84EPjA>
    <xmx:MEiQat9dcAA2PZZ-MgrA6BllS8etRUiIoNap_co2-azV0MI_FBZTuNi4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 10:22:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] die_for_incompatible_opts(): accept more than four
 options
In-Reply-To: <CABPp-BG2PJ7AyC2ctPuX0bmkFd_cGmNz+XtbjdjCbMrH4_d99A@mail.gmail.com>
	(Elijah Newren's message of "Wed, 26 Aug 2026 18:19:22 -0700")
References: <20260826233152.1703497-1-gitster@pobox.com>
	<20260826233152.1703497-3-gitster@pobox.com>
	<CABPp-BG2PJ7AyC2ctPuX0bmkFd_cGmNz+XtbjdjCbMrH4_d99A@mail.gmail.com>
Date: Thu, 27 Aug 2026 07:22:38 -0700
Message-ID: <xmqq4igfd4nl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> diff --git a/parse-options.h b/parse-options.h
>
> va_start() without a va_end()?

Good eyes.  Thanks.
