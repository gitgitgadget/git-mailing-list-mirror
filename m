Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBE731B83B
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782681961; cv=none; b=s4xzdHOdw72XqZgvYpZmwHrNOFJGAexHxiCd46/OatMJNAh1dhvBbyzifNVYH1s20krG55g2ZGSOMlrlj+GNqCiwwr//FQ3U36i6t58R8QIL1cE0QSL1fxZCM0vqsHUCnNgT1j0e9d3mLT9TIjNQoWJbpwMbDH141BqgSArZRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782681961; c=relaxed/simple;
	bh=xUEX9+FSSd+r/i/Ntx6gy1YqaMdo423ypU8S76DSfHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IeTsNBAEqKtM9ohoGyVPBdAN5FPPDCOfRLMlVKElIixqmEZxXgM0M6eAZIhaokRd8vehHLpCxemHNCJBDggEOXL7D0vtotKs93XieL4Q6nujkwziuit6NmjpLBo0dLd+WeslmTDk6aeR1pOk8piHSZc2sGplC3dfPwZBLxMIJo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cACF6I09; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eerYu/BJ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cACF6I09";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eerYu/BJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A569E7A00F6;
	Sun, 28 Jun 2026 17:25:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 28 Jun 2026 17:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782681958; x=1782768358; bh=WnluqNZDk9
	d2QOGG9jMPctxs0l1PdePXZUK23ax5iPY=; b=cACF6I09Vwy2f3Xt19elXJcMuG
	nqZBFFwQlArfZnGxwVmms0ri0uJ9Jcqx52M8myyjUxk14yhWNIeU6voTTdZ14dbF
	3luwu7kaNVLjtT5aGl/x7GEtm40rS1hXZxbioAhrqnXALQ3m6StMm830cpzr1Xfv
	tNwM/Mqu6R0h3/iEfsGdJEo6rsjNCeokD9kZK0BQbwLTXKZ/rk968x+dn0RLgOTZ
	hmz4XJ2/e307L1BOjAo7k9IM0vytm697QwgtJFMiJnC4OK7Ius0fQPp5IGnkVGAp
	qJceD+/1TQ+8KkAP6QHRlzGuZH3yFCr5KufnxM+Q6V0Hujoi0hNhhnuIIzhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782681958; x=1782768358; bh=WnluqNZDk9d2QOGG9jMPctxs0l1PdePXZUK
	23ax5iPY=; b=eerYu/BJFAOr9Qxe/bwincHAsYM0b0GIf2MChc1gdG/LssiPn5b
	zQksFGKjR8mPDCmY0G6gia+0tY3xnPHSLAzYas6qE6rZmwrh3uXPrlnHGgGS9PJC
	aYqadFjbQEh+h7D3TxiAJFMW3Ffo1b21OpqIhSPsWXYOjeEL7TsIq6jh9+VWZalo
	TpVdYNNsvdhdC+xmME86Gfc86O9774iDhIa/DKJjEXPlAeEYMl/LgBrWOJAYfhDv
	y83Zr6VSFtHxM8WDUUTS3Z0efb+MQ0TzJWbxMbisVHYOhI8votNXycPDWGOnSJew
	N0/+PY0u0cnQLyW5taozJbxn6aOxtibZ3vA==
X-ME-Sender: <xms:ZpFBap1NoIe8heqSq8DeqX4p7yc7l4sKbkapCTW37IUKLwGADpLpKA>
    <xme:ZpFBarmsyhrxMwpfpXTNRW_SA-yPXST9-SSWhQJfwWL7eXfnykCeXzO5ucMETEpRI
    5amrj4LdGk-mSmpU5G5YVKB9sJ83Pbz9nGpO4adFDEaqsCA8DC9Dw>
X-ME-Received: <xmr:ZpFBagXrpq0VupGfXhrl7FubNdSC2RAFwBY7UVuAXuKIOHn6POH8rDBBtct4wNQVOQNHRWHJMNe6u_UpOJefaAlXVXF62jRYTZDiKrs>
X-ME-Proxy-Cause: dmFkZTGdU7vWUK7Itx234/DK2v+sG6qiuY8LkIqJZ2AHt7Q/hvh5lSGv49oQVDLz4O6jx7
    xcXLdQGPKjmlIdPnyacoyEgvZg00WoBf9dx5fV4tdB1ty27EIw4MJHDq8WiVJdUgSOkPGM
    7trV2FHqHuPS1qOkN2hn3RchjsghmRpDSGhfhJ1ClzXwT1qknfGjHTJ+7Qy4PE1PdS6NBA
    c27C9sEiTAFzG5O223/lqzuRArXyUOsNuTHTJQgvUoptGMq57N2vcNzn0YGTgkT36/YcBU
    bA+rKQ+PwajRCs28kvZELsRQ1d0h1EA5fuFjGtTYdYQNVTVA7Jcotvhg6wr0dkCM4g/llK
    zvr5v1gEeavdvfzywb41wxnJ2qZO67IWmtlhMpTzU51l0NVzGr4XnrvCkn5Q19BzgPmVLM
    ENFPPQgnSsKG1ILNPY91luJL95nPP/Qk5rE/kNFtTJuPEOyc/j8OQ91kz86NUnssxmGHG/
    tYVxV1Hz7SMAff50vd5qnNmzVKLhq48lQfIYOi/7lP1gGm9Yo7Y8zB3dY++SVclztBCK3/
    3Xx55/oNJiqjedcR4xsM8/4VjXaGUGNXiB9E6r9UeTBOzqfZwSm05GsF3Ykt80MO4PFtmJ
    +6uTxHzRoPs5hqkYq9jvHcsjaEQng9/4u0dqbsGoo8BeF5XAYtPHy/j2H8qA
X-ME-Proxy: <xmx:ZpFBahtM6hqhbCNb8cqNmSK99PaFcpnTqO5YmgTI8vWTk1sg_ku4ww>
    <xmx:ZpFBajYDA40nAgXLE1iIYzjR1ThG8nvNgC_kSNdNuMdyAs0vgEjjxw>
    <xmx:ZpFBagUqLN8c3UjfG3VIGj06K0_McJV9UFTFkn-5pDBiGsNgpkiruw>
    <xmx:ZpFBaoSjm70yQZnS2Spp3wWyqNJeuo1HHg-y9BRjAK9D1TXN_-hq_Q>
    <xmx:ZpFBaiglMHjq-dImtwfJbGhjNjo6JYrxWzPWOlG544xI6uEa1PzZea94>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jun 2026 17:25:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Michael Montalbo <mmontalbo@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [PATCH 3/3] t5551: pack refs after creating many tags
In-Reply-To: <20260628080710.GC107826@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 28 Jun 2026 04:07:10 -0400")
References: <20260628075716.GA3525066@coredump.intra.peff.net>
	<20260628080710.GC107826@coredump.intra.peff.net>
Date: Sun, 28 Jun 2026 14:25:56 -0700
Message-ID: <xmqqy0fy1hnf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Jeff King <peff@peff.net> writes:

> So let's follow that recommendation and pack the refs ourselves.
> Unfortunately, this does not seem to produce an improvement to the
> run-time of the test script! That's because after producing this state,
> we perform only a few fetches of it. And packing the refs costs at least
> as much as serving a ref advertisement (both have to iterate the refs,
> but packing additionally must write .lock files as we pack).

Testing a pathological set-up with too many loose refs may have
extra value, as long as we are also testing the recommended set-up,
so ideally we should have both ;-) but if we have to pick only one
and drop the other, we probably should be testing the packed case.

> I'm iffy on whether this one is worth it.

I am ambivalent, too, about this change for the purpose of the
"yeek, apache times out while enumerating refs" issue.  But see
above ;-)

