Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19677394E91
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781645180; cv=none; b=Gtyw1gjfAaf9FrvEJqqyO3Kcgtfuv4pGckpAZ4527QjIYTT59+Rk6qxeQE2tFQhVT2+LnJl3f8lBtwJMBk4yevOdy8QLQ/ygISUpClgfXncmqroDZvpCjSC/VxB0xP9BAXHoH9RkmvxtLuTdaNXWOpXhEMv00En7uJbUiY1Ks9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781645180; c=relaxed/simple;
	bh=Lv3vrRbvSQGTOrUZxm6CSWiW1LtqByjvHzTNOtJBfXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WiDQxLrPrzSXNyJBleQNlkTG1+j64Z4+b7VOsWB6+IW+Wccs58jHmrDaSNmdZelU9JoC227mcgGIsfEA9MB+E/lOACSiGS0uTR/E+xOnM++Q/gYriM1ExeeodHmm0gnBfNaNhZzB6odRrp9XHC+5yoNPRKbYaHNrwvTstuU2Nrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bUdcHNJY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hqi9LkUP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bUdcHNJY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hqi9LkUP"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CC66EC0190;
	Tue, 16 Jun 2026 17:26:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 16 Jun 2026 17:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781645178; x=1781731578; bh=rk00i+MS5X
	3PEqtw1a1svMw4hKWpXb9WYcX0AXpN7tY=; b=bUdcHNJY49Zr6sWmXx9Hmf95xa
	8NK6j+fTRo+irI7/RUQXEywYo0lsr5V9gP+42OyOWh8/CDZCjKeGTYP22RAgllGU
	glUNISCmhDoSf4YJFPmgEkl79s3xanmlvRUfMQN1QoiohrzIdrU6dbKR2ir4GOkM
	I1BylNBEigTktPjdZX/DqEIbEqS777g546nZsK8tcSz6vwvHRVKjo2sVhZGx0vUt
	Q01XfZw3W9ohSEcaHxhr5Y1QhntbkgeljRXAnr9HDScxEA2tBtf5JpF9Gw/5+ZfC
	LlDZCWIsMMcjYegB82XKsEalBdKNFvYwSdGy5LFEqUIZ9vKB/PWRgynBrX/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781645178; x=1781731578; bh=rk00i+MS5X3PEqtw1a1svMw4hKWpXb9WYcX
	0AXpN7tY=; b=Hqi9LkUPtP/pCn008AE98DrjuoBeo+yIe4xHu5gLEylolGWcC9F
	+f9u5oEo/SEw17Bldlx8WZdDMOJP/ZLgIQLBasOTTG5p3431yGkOrHha/v5ZRjty
	yzmD0M6BinhY3SQgFqBCucCeaezXf0ZjyTq7B5CMK8OZT+Es5qQkmeQCpUdEdyQQ
	OpFG5BI1AI46lVxERLcMap3x2S5msrt8pLG69CR8i5v/OkzXbK9gc1/QXwPd43jN
	gcpNnLdyTkfnkr31LV3QXSKoEeD2DKCbGpra2oOKpRqLN6XabWyG2WS9BZBOkJZk
	P7WkMbMlpQ4QqkLydvakSy+vEwHUwcJQhPg==
X-ME-Sender: <xms:eb8xanK9YH8iIOCXE-k1xLUuxBoKQapxybBh59nBYHu6pjg_394YNQ>
    <xme:eb8xau1W7p4QM30kPhL5JAwt2cJGYdDuOVkSA4R-zbWYoAtnOLNQg4q-OvstJW5TI
    Y5L3U3eNjcLo6V7aMn_vpkofUOv3kiGTfhnKo1CrEwJ5SL-HOX5>
X-ME-Received: <xmr:eb8xaphL074rNPb4wxY5pbOJpJ_1eJ2BWLhhLzAuWhhCNBqfoEWsvOuY79_0ye9AlMrWnbkYjNGib4ABRcJYMpL2rpnU6FNJCGai>
X-ME-Proxy-Cause: dmFkZTEncEe54OPjcAvdO2ZSOTpSbVaoFmQ/1qbBIFFg25Yf6Cn1gQDxq/k+n8B9nl0URS
    k0LM/vtGu9Inyhi9FWzYsppy5UyRJtCJb7+maR7EtejNWN8NF0XLm9A0hf+T2dxP+u5bCZ
    hFP+f6o1pSPSVYtTNacHuSYUH0dvTlxROXJrVcghT5zAVIJbhK5PtGTlcJ5BNqIpoNOtiq
    19c/yeL0jxAbPAdWVhRvB3aEam82zvx8dg9B4KbBwWhkqZQQrrlACKzxwVxP1RNE5FvQzR
    fmYJlgz3rY4OVnul8Qqvu+CMHJOsxfyqAlPW9WJBbaQWyBcPFpwt5smwkFMxvEOxnEsaKF
    EWu//11vqdDFf+AUOWVFeH6Wzhtv9tr2QxDWbXR/+wrxUwBTgLCNIX2hsKjB9+eWMfppCt
    kiu+5/U/kLSLNOTKGN6cUYKU8LoWM2ezEWoOaCxzOirfVYXViE/zQu/xs8wGiiWxSWi873
    6Hd5r4qzhimcYbuBqOKGIlwP1SbBB1DctpohTyHlog5f1EtOXb4C+rebh0ghogUKfc/fCY
    /aKQRSPVyct3516cthWAQrmUDBvUWKOUsEdlXG7jQQfhR2Dci1ELMhcUmmlun7J30Piea9
    9YLLUS02vLkQDpugkcPdZ9xOs3lOy840ZFeK11ASyHBLDaZkWX27NU3N/WYg
X-ME-Proxy: <xmx:eb8xanUv73kukiTw5maJQ57cDMWboF0Q5aDNAsL-tOyLWImSuaw63w>
    <xmx:eb8xagUizGsDACtUVJy7AD1mDEEv3R6LG_HKaALHXxEb_C18hx36ng>
    <xmx:eb8xavgYR44wkg0nveRlRbw9-OFeVnmVzLVj2AQdTfIJ8_EpPFSEXg>
    <xmx:eb8xajboXJf8194uxUbOgSKLHqaJf1fsJhXA0uVY_K3gF3bwuyX7Pw>
    <xmx:er8xaoAz5C5jnPows18jAJ3SmB-M1npPaEybR1dfpmDibJlj4Gw_hng_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 17:26:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>,  Patrick
 Steinhardt <ps@pks.im>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/7] patch-delta: use size_t for sizes
In-Reply-To: <66a642c39e7755755fe388af7612ac8c9bf41a5a.1781524349.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Mon, 15 Jun 2026
	11:52:24 +0000")
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
	<pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
	<66a642c39e7755755fe388af7612ac8c9bf41a5a.1781524349.git.gitgitgadget@gmail.com>
Date: Tue, 16 Jun 2026 14:26:15 -0700
Message-ID: <xmqqwlvy18js.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Widen `patch_delta()`'s three size parameters to `size_t` and switch
> its internal use of `get_delta_hdr_size()` to the `_sz` variant.
> Then propagate the wider type through the callers.

Makes sense.  
