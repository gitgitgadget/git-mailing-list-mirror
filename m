Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42628315764
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008793; cv=none; b=o8gCCNS4RjTnqNEgzHVw9wSMxHKveh+IgA/aFFoVKXlEg4eic8sRpuRW/iyFfC10sgV6xLePOxC33sGWU0zs0Zyw1KFOaTe4vyAwBteu25ktuqzw5l+g5uaJHb8KspYfCpgDKefyrLdxV94VIm0GBbd+GGPdJvyMLCmxgI6qq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008793; c=relaxed/simple;
	bh=gcGcS42q20DE1exg6RRLxsyXC5Py9xOBErDXjOcSujE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TQoqMX2OBDC51iuU1Qp+ZxCS2q0nsML9DSFTArDOiFF19D9Q+RUbzXvN/MRXvF/nmjKfK8zHcT61a9jWKGIh2WxzQ8CAJ3D2QDpHQ+qVUXXlQroK0SFxBJ2dkUXH5CoeKRtYzfvP4LLWwC7r0Rs2p0uY+4rWfXznlPagv9bZhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AE6r4bwf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gNdebv8f; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AE6r4bwf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gNdebv8f"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 72017EC0077;
	Mon, 24 Nov 2025 13:26:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 24 Nov 2025 13:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764008790;
	 x=1764095190; bh=j8CzsKo1j9Sn+geAgot+2c/nJaMZwQUiPvW/MgXDaHM=; b=
	AE6r4bwfh76MzYwhk5yUIhuNsVHZuc0ICZ0j3pZDj200ohfdF7LDVqVSNzDp++XX
	ufm0m9yC3E2ZsA2peU8CmW0ch8pZ88zMdOkwJILHp1TSKamR9xTJZWxjnsLumE2o
	eTV5vBzIiQRro8Hb0WLAidgfXXc/Ei5x8hueQHoLtRLGwih9I1ZTs7Zag+xZwo7P
	z40i6EAtkjhRlNSuqs80+GotwIRXAr1lz0DsbUWRm/5goM0moCFgAbhg4BAxIKsa
	S0lJlnF8huWz4sd+TgB+ZISHEt1xR1wOBv+oPYVDRAug2Z30Jwp1y0yZBhAOV02i
	lGAx0nQervIvRYVz9+kA8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764008790; x=
	1764095190; bh=j8CzsKo1j9Sn+geAgot+2c/nJaMZwQUiPvW/MgXDaHM=; b=g
	Ndebv8fcYyIg9nUge5ENZpc+OdK7g6s6mrBpHoIQVJ8tmQ134DJ0NUep1ZwodAL+
	Ls5Gx9AN+hohxTJuWLb1fumvwzuBj91gOBOlnoOm9N4hRk3r5vk8EkI6UoRX4aHX
	lGZ/2/G47nkZqZYY4zIM9kGQOlbSB+cnjZngURi0YHz/n9erKccyZ5wyzXhFQaHz
	JmhV7mfJ/TWjfFYXUSqlJmNjLUUXAJudup9LGDQeNlt0WHH32TlzqIxH57ejbVY5
	Z1pSR0oH8hOHCnFDDCBGMZVbKan90/Q/qFkUvHM9nHOz0d9KIIip3h7zgv2mVIuJ
	BA45cTcSWQ38hId8q+BUw==
X-ME-Sender: <xms:VqMkadLa1-iLNKVgIKKELhS8nDqkMfGPHA2k04liuKqgBizXsutEtA>
    <xme:VqMkacbflhwJl1frh2DohtWsqlN8pzDA2t93tcKhbkO00zA1P3q2ur5PASzWrT_bJ
    UWiuOw6-RItwxsRJpVLBwGrLGJQ77fH_99L3BtcUVYxo3e9eJCESg>
X-ME-Received: <xmr:VqMkafKum6CJfsS7vqY06ke3vzHS7mlWjSiV4Qt0srGS31M1hZaY6QdY9swEbFtCBlPpO0vsTEwUZIHrOFtCmIgNS2rBYKn_DXtm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeelfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VqMkaaBk8M4CA446srzuwk88mlnzckYjV4KdovMFz9hTvlkhf73CDQ>
    <xmx:VqMkaUoZ1KSytXMYdLd495jyVPnWED5rUorSCYJwNRs6zGKkDegeBA>
    <xmx:VqMkaVhKEqfJNwfxpdmtSmFuWZatiPkrPB4-NYo8SFJaOQL2BVlQlw>
    <xmx:VqMkaRB448284zU9Wgz1vvtGZDh0pCtjE4SmCpPqWmVeUU11x6tlzA>
    <xmx:VqMkadCHMLMd0RJE6dt8asEA5nXWjf20day5S_k33AnvwjZfimFXNdeN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 13:26:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2025, #07; Sun, 23)
In-Reply-To: <CALnO6CDm2K0Bn43gjXTvYqJ8gbX+8eZK1YPn1gwuThizK6d5VQ@mail.gmail.com>
	(D. Ben Knoble's message of "Mon, 24 Nov 2025 10:46:07 -0500")
References: <xmqq5xb0yqj9.fsf@gitster.g>
	<CALnO6CDm2K0Bn43gjXTvYqJ8gbX+8eZK1YPn1gwuThizK6d5VQ@mail.gmail.com>
Date: Mon, 24 Nov 2025 10:26:28 -0800
Message-ID: <xmqqtsyjxp63.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Sun, Nov 23, 2025 at 11:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> --------------------------------------------------
>> [New Topics]
>>
>> * jc/optional-path (2025-11-20) 3 commits
>>  - config: really treat missing optional path as not configured
>>  - config: really pretend missing :(optional) value is not there
>>  - config: mark otherwise unused function as file-scope static
>>
>>  "git config get --path" segfaulted on an ":(optional)path" that
>>  does not exist, which has been corrected.
>>
>>  Will merge to 'next'?
>>  source: <xmqqikf47ajk.fsf@gitster.g>
>
> Any interest in also marking this for 2.52.1? It's unlikely to be used
> much yet, but since the segfault affects several invocations (git
> blame, etc.) it will be irritating to folks who try the recently
> released version.

Yes, this is a clear regression-fix material.  The branch you are
commenting on is designed to be merge-able anywhere the original
topic that had the segfault can be (or has been) merged, by building
directly on top of ccfcaf39 (parseopt: values of pathname type can
be prefixed with :(optional), 2025-09-28), which was the tip of the
original topic.


