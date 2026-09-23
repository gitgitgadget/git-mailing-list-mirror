Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D003E1713
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184440; cv=none; b=LOJ7Bs0B4YvOZsMf/vW+tQDJG27M//satrssyORAoc9qWQbTn2Yy0tMTLM2V64xWYqkRvOGlxlL1yKlaxB/aVNmBEKVJYUMWI7SgPsOBloRveHvDmM8+yJGlr4rENauefh1PpEl29yWQP+Fzdv1a2NZ0waoms8BOQadAQBf368o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184440; c=relaxed/simple;
	bh=ZgORGjioATfFAZXPCOaOyZwgmQEpeKDZ7+p1tJWlHi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IBDo7QTD8u9wUs61lNZkHn3XGiDtOWF4H0H1f3JRKIo4fLUIdHtRjPLOUYEp94QUai9mqNM3bRNDIZI4GNJ+BbSNz0FLeh48LM8suG6kI8fw/i8atgPD7cDc2I+Hsu1UTkNE5XJYcKxgg9PZMwT60YSfSI4G6oDwZ7wH0KHxy+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HV4Z22vA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vl9eoRl0; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HV4Z22vA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vl9eoRl0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 51EAB1D0008A;
	Wed, 23 Sep 2026 13:27:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 23 Sep 2026 13:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790184438; x=1790270838; bh=ZgORGjioAT
	fFAZXPCOaOyZwgmQEpeKDZ7+p1tJWlHi8=; b=HV4Z22vADdD8PPoCn6pz7ReNaZ
	CROOjM5TjWStf+ZFv93BqBLSvWX0DGwU3NG0V4cYbgahjCep/gSaN6ysDnt47UTS
	Uij0ANiLKdi1r+SlYj5bGLFbW236AL7CUB59dr43Mt+Cb6eQPexESLD5cy3Zja44
	J8yGFXWzpQYvsy9s5eKM3epKjtu12ZFwQEQghepfA2OcL7zO18u8PUvNQ5GLbL7L
	HPggDjQHK/oDJiGvRmC3e+HjmVbQY1nn9ELIiBocayxK73FAu5vO3HMiVFNYoNkm
	o5af8IqxmSWmsfGfwlOZ/TP+4r4Y1NSlRsEegi73NXBZ9s/5MiA/VHzXUx6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790184438; x=1790270838; bh=ZgORGjioATfFAZXPCOaOyZwgmQEpeKDZ7+p
	1tJWlHi8=; b=Vl9eoRl0umNY/T/Ml6yB5Tpp8nOH0Uke8PjtrqA08o9sgXohUMs
	gh//nGjkPE10DQDAMZg4XbgmiCBX/zj6Zg5zc59PTXEZFP2X3nDx5ygO7chyUEbN
	xuwwCKxw/hpNGXlsGVYx/diqyr3J3FbLm8ZCAdbrLp9DqiSchsQbT8xBAfyi42rD
	vWwyVyxUSp6fYu+2EWPdIzXO7L4dStYEJTpWOJTM6dyjcavpbwctPzQYITQoC57S
	487Wd0uOHXEk/M1pffqORTh1GewpDXeAIwZLqzmbbls9JS6B1OCIHJ7nS9SCnHHE
	VUflH1NCnRVAB3Dk359fRlJeR5g9UP0NTrw==
X-ME-Sender: <xms:9gu0agc3NRYsn0zFPV3nelnYzT5sQhLkMr82KorrIiTNior9PYyPvQ>
    <xme:9gu0akyYQEOM6r8y4WsU-zI7b63MOFIWMpHpplVyooPKtGmhNh2satHxAOg5H79s7
    88MEVeE9CkS_uJJ0MjIZmoZ0CUzY5hNI7oBgHb_kCBN1iXhp0KwBKg>
X-ME-Received: <xmr:9gu0alL1goC1VnKrrKbDbDdfhGnLmx3B8xW2xwVg0ruKSdik8Tb8ppnHRq8OneNHmmN5G_EoS_dbMgYnZPUaQ1yvX4UIIRXxkRSF>
X-ME-Proxy-Cause: dmFkZTEXg895MhX00wn6vlBU4YmdvyvX/yMba8Xn9MBinzSSVhk0clHzaq/59FBbf3XThD
    IwUavo3bYWgGBJFd8Nml9usdCPlT/YI4bBLQzWfWhZR4fEm8UY8ouvI8iqhSTqSH0zqetn
    Ez43/TnKTDWdOvMNkHgp/JmjKElq4RPWsWjA036ZW1OuWoyxsbcqoxaPyuGrX2jOwHEKK1
    AjILz/aDTefJfMUW3B3A7RCcGJIxcmGNUj0DHeFiEeTeSHSLo5XXvCS0h6sepSwetbCQcv
    MlyyvdaTdNEZpj3bkDagkKXf8SEytuSHS3jWIF9fdYf3nsUh4YtZpDVcZpcCtS2JLEoTsw
    wbEV1QG6C0XkDhJ5tty0d+hozS4WTLKxtpRSO/eVYgVJYKHAFfH7Tgt0nD3YpxulXposrM
    ogHZG5MsB5uMuacJEYXPxOkkhIobXCTyyjkAzWHl4+D+BvkKP9AKw29hYv3R+N/Rcg6MQP
    MOSM2V1trLA4v6CrvVC9KljqWsET7NhrHu6mEJ/ID1Ll5XPJm5SrjPPZKvoBOqTej88PHu
    wK8KG+jhiSFWplNve9RRPHNcRF0gMjuaF6iDsCoQZ3FOiYpaaYD4OM5yMGUCOTMmGJ5c2n
    i2U5pUKMlx/Wt5lG0V67JCrEDBU4HmA3dXNJ1/DbMpZ3vRjHbW0XILv2X3oQ
X-ME-Proxy: <xmx:9gu0amHVTrGOih_gj3e4actlksFZF2jgFsaXIggsmdRMGWgv-qpmJQ>
    <xmx:9gu0ah8wMqfiIrbIoBCZRM7eiouazFRqz1W9qMbVCiqSw1wtai8wFw>
    <xmx:9gu0amIN0JfAxPt3zRClmMagQkh3CLjZTWmSyfHXmfgF_pihGH-dFQ>
    <xmx:9gu0avu6-qpbVIO_LGYZ9CD6JZ1P1yKRZACXMP0vP67RMRuripnYew>
    <xmx:9gu0auyznRQilu9dwdWq4g1GV_DLC8UzJzL2ag0nl5onzgTYzFFu_sEr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 13:27:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 2/6] bisect: fix "--" detection when a term name is "--"
In-Reply-To: <CAP8UFD3sh9Ejfgv7CB33LRU_z3i662_+tjdW7JqwRrzexWX_Ow@mail.gmail.com>
	(Christian Couder's message of "Wed, 23 Sep 2026 10:11:32 +0200")
References: <20260902161047.476753-1-christian.couder@gmail.com>
	<20260902161047.476753-3-christian.couder@gmail.com>
	<xmqqse3rffr4.fsf@gitster.g>
	<CAP8UFD3sh9Ejfgv7CB33LRU_z3i662_+tjdW7JqwRrzexWX_Ow@mail.gmail.com>
Date: Wed, 23 Sep 2026 10:27:16 -0700
Message-ID: <xmqqmrt7c1zf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> In the future we can still convert bisect_start() to the parse-options
> API, and then use the early-scan API to look for "--" in a bit cleaner
> way.

Yeah, when that happens, I can imagine that we can make detection of
"--" to come for free as a side effect of using parse_options().

Thanks.
