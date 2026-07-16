Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C632B11C
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226905; cv=none; b=md05TW/fEZQghEi9Pe6kd1LJWEzl8G862W3JtE1MTyv2xEbd2o6FRFicF0tXz5dLO5stJ64Tw/J0cq3xZ2MQffvKXtrS1vo+2eT+dDRQEuCJA7k1DmK1h5KTGeUUKBzGV5JHOEprxNXgy4j68L/4q7rVKsZoWellEzuJA02gTuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226905; c=relaxed/simple;
	bh=GAl08xeyqUWyO1rEzL+Lb2NKJpEYwNjWZQLss1KdDSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YJHHmXPfsVlno5pkVz2YrVKxZVh9bVAbkfHh93E7Eg1IO/G2DzjjLE1GMZ2RjKujQEs7zRJ+h01YnXn38axlVMzNk+qnBBZtHB8ngjNPBJMERygyYvbncHp9V/uEHCcYjKPZeasPbXXs4BXzu1OI+u8/7dWLjOl2puELsTcaqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jG+iWQHN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G+FCM/NO; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jG+iWQHN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+FCM/NO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 826A8140005B;
	Thu, 16 Jul 2026 14:35:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jul 2026 14:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784226900; x=1784313300; bh=pqQ3Dc7XIc
	IgU87FBz4tzKEGAJku3m5E75gxtzruzL8=; b=jG+iWQHN36f6RDUfxLHzweOgxX
	PCNJetCmICqz85WziVYsTwh4Zti5CVeFtYHDDAZhcXlnKywEEXg4f3holuXmm5BN
	Gd5a0lzKF5ExqxvCVDWpvRLjJ1cg9AFgsLjBYIXLIcnsrHLmxDZ11SeK7Vi5NLGK
	BZrxeFd2tN9thOaQ+0B0q3OHhqK13CDUnzQ302isJJiZLkhiX9Bsro8CmTQ1U0Sv
	OTjI/HvrsazSC7sQxjUQ6jEret2nki1wUspX3yjE3yIy0cFzPs2PMgutq/Vo/TPx
	9A/o8+/Li5WELfFbq+uvlgN4q4iz28bYRj1Uaf0D8NgjK7hezHMgBBbLQXbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784226900; x=1784313300; bh=pqQ3Dc7XIcIgU87FBz4tzKEGAJku3m5E75g
	xtzruzL8=; b=G+FCM/NOPhfgGYssg61A5iZWJbiOG4t2sYHKHOBMJlonoPjWK21
	MegUaXV9oYySr4G3vuZFvPWCKK68nUsXPe4MTwwL1Wgn3GJTEsHosHYR/aU24m9+
	n/kfqmgEkar0N8KVkyvgxPQHA8c75eVJu4IzYq3YUaIRWDnI4C5M6mefWtJdoRl/
	w8pShhJchWs+lrrflahqJlIkiZF4Su0pRtl9Hx2HrXSf3yTOXqj7ChlXSAnH/m96
	lMuwjHYWm2XVATMKSapIQ0O1laprJ6UOFoHuTbXMis46Ukyex7MY/Ku1Up57NX87
	qpMrJ7X9YIwD4K7CNZyvM94KQhAYVcRx1lQ==
X-ME-Sender: <xms:VCRZakAtHP7IhlRg1MWk1TWcvw5Bf0IXr7zVqyjFAzulHLQU0EqxAA>
    <xme:VCRZatiE1RweEkhCwfjaHH-_22YLsdDzdji53J1DpV_H2ooBJJwPRSbJ00jSzQ_oK
    kQHfLD-zT5SXp9NwxPTSCBRu7MfU8KxF3G8Z8XUKltAtXx6fUM7Ig>
X-ME-Received: <xmr:VCRZasmtTVHXfb3NsM5agy-vP3xQtkoEc3d6iJPG7IFuqQ1h0dycoPjgB-TijYcNdx2-qaBgaSSMNdNtrx4rMUYAKSbWNrH_aav3gzE>
X-ME-Proxy-Cause: dmFkZTEEkG0Mwy5aoYZYj7hNjL4sh6IlMHje1s0TtzMNuqriLM4IbgPnXG0DQUrVYKWZA4
    F7eujzheOOuXXYtVKuOQUhdSVdEgwvynJPyXN7nizH0LeAaAJLqn3/kXhxfVlMKI2sDFQB
    sGbPGS6GkFO2bV5JRplKUZIvERfHgdeGi6GYm0cH2tlg52fUcSLFhfvSaMfcP9H88h23/2
    Yf8vKEjzn4MASgbTf8N1hShnRc5VTGqjYaNJVXm+HEQkZWCsEGERzfyEYg95YTMl6hBOoR
    I/OdRiY9rADMCnaq4ZZD5A1Q5BOM5e+j/G1nuU1M+zpS7z+K6j/iPdy8Tz2bO1G71RDzM7
    7FWidqJoSW60HROhfoxNDG0dOlfW1bN/PUNVlRRyKOFcti/I4ThInB597xmwQ0EPUaAuPw
    bbtQQkqsqIizJ8Vv9wc0u7GTzr6yHzVGnm56sn5nypf7OY9LCPxFRNolY+f8CKy6+sykzW
    XbR1qw9dw5/dT+TjeX3/o5DtGrYaGxpI510frwcvCaPoA04c05d4UiPReqj1vnck9em6VP
    FFSxIqtdVMJpQAK1b6LrAYBD1R/Jj2RQtBDdnPma7qBc6KhN2LY6IMCvDdUNzWKCqNhwAI
    raNfVhXPCUs7PmZrfDWt4dZDkE9GBQhN427YDK5Us69mppW5b37PoqpIfvrw
X-ME-Proxy: <xmx:VCRZapqiocT-7wtmgsRN9EWM7U-3DIPu7IVjkzTnxFPQkaSxCclY-A>
    <xmx:VCRZalHNIRDBel2h__84SWNcjugencxNmXJIA6UY55LnCoZr-ev0tw>
    <xmx:VCRZalx_HRAFwJO2QJflcBMbuypHQ2kjnUy8EHQeTkKst8dJavCb8A>
    <xmx:VCRZaqr1thWQDZ1dtPkMj6sqqzEzwy1wOprdncDNf0nL_2EkDQHDLQ>
    <xmx:VCRZah_2cOOaBb0JulEqmmp3Vj7VEjSIbawpTsjwH7EJjOpBUViqoal5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 14:35:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Some wincred fixes
In-Reply-To: <pull.2182.git.1784212072.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Thu, 16 Jul 2026 14:27:49
	+0000")
References: <pull.2182.git.1784212072.gitgitgadget@gmail.com>
Date: Thu, 16 Jul 2026 11:34:58 -0700
Message-ID: <xmqqzezqg4vh.fsf@gitster.g>
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

> These were rolled out as part of the security fix release Git for Windows
> v2.55.0(3).

Thanks.  Let me merge it down fast.

>
> Johannes Schindelin (2):
>   wincred: avoid memory corruption when erasing a credential
>   wincred: prevent silent credential loss when storing OAuth tokens
>
>  contrib/credential/wincred/git-credential-wincred.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
>
> base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2182%2Fdscho%2Fwincred-fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2182/dscho/wincred-fixes-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2182
