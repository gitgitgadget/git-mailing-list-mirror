Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90210182BC
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750782513; cv=none; b=A3E2XhkETzkirdzeVtmM6XME6j3IlVHdOCVnuiyblW/iUV8lEockoTSuBvwnR/LTGpHxIYOub07QakvJwF7YZhzdgidP9IWF7PWJjr5XHT+/et/sZvCkxHaXc9mYekG3G3fYyJlafmJqsVzzE61ajQg0FsNzK3/8FdnE66I0Fl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750782513; c=relaxed/simple;
	bh=jgSp1JIry8A6T38EPzufHYVYn9ue2bLfR6lftflstNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZNfZlmmq1N9n7di4dmmA23g2F2MS4DdiGCcE9F6rbSLsC1S/friOP25b0ulHZ9vCweOsvi3ZiFnIBj1MmABsNaj/+3etCOWKClqsWjYwsMYbIXiN4y/ET+ZdHYrUs5apFTz82JUM0IL48INjabBH+GG6IWkGnTfr1yE73jm1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UZOmsG33; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cibfGpr2; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UZOmsG33";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cibfGpr2"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6FB447A017D;
	Tue, 24 Jun 2025 12:28:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 24 Jun 2025 12:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750782510;
	 x=1750868910; bh=l74NHqvcAgy2VL+ipYYGBALInLcN5KK2OyQ81GtD7y4=; b=
	UZOmsG33nOPgk4mgwhVIdWVwofh+juwhue/T6CCAYe+24oepfq/96o/BVSWbON50
	r0RPgE3U3kk729+Rdv0MVu1obgYpOX/akxfXHtbO+lyD6KY22ICRuY7VsebIHgK4
	ix7F6Eb2ae6u61KSTMp18HTLf+kQhLqIuEWL7eykacfyz1SR3Ai6Hk7pCUxwtA7Y
	yF40996itn+G3oICQEYhdlGPmLb4ACVd1k9x5AI6hIsr9o4Sw+/QH6kV4EGvg1tQ
	YyVbK5rZ3PqgZc3UrdnFSosCq1+/C7sb3y2iKzbteUvP//t/SMbYMN3G+cqn4rYS
	3DsoWwE51ixQi1UtWvMiqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750782510; x=
	1750868910; bh=l74NHqvcAgy2VL+ipYYGBALInLcN5KK2OyQ81GtD7y4=; b=c
	ibfGpr23DZKoujPWxHL9Hi5veajnUZhWlceZN34VP7ReSwgdjVenkD2MzogR9A2x
	8AaJIHskIegRHCpTuEbvljGZQZ17RaP6warNJAvxiUMTGW9qiYaxkMfvSYmC1GRO
	3X0qpiCTU2Iq8xvAzOJ0BqT/+sIPNe8HX82A/KzgE46/rF7s8g3oKt31qPayV7Rl
	P4LLVEoB939qDBbIeL4mMsH0/cF9e1CfHlfi8ApBt43popNc/qX5mztmaTUgmni8
	9Jy/ZnXHXYAQPh+8RqFMUV7WshBzFHFlPzCL2Zwb4QylX7OqdJRU1aeojuKJW0M+
	XfSSvm7NHR9hNaI7S/w/Q==
X-ME-Sender: <xms:LtJaaL7aS8xOBDmNYy4pM0h6Mh_y80729x-9kHVhc6scWAQnpxdkSQ>
    <xme:LtJaaA7z8NXSGngyhRTIXlTd64gn-TmzzmkdYmx-UyL5AayAKoE0IM1ptUmPaqf0T
    bUJYU1cWJMh7UbQfQ>
X-ME-Received: <xmr:LtJaaCdpPr55SmC5BS61WF4hFkG3Dyd86qGa_uqrob1BCi9P9ZV3B767ZxmkLQNGGEe-7sHueZ5svFtZkWaXHItn-0U5ewdpr0XDIoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtdefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:LtJaaMI74xkEVq6ld9YWNjWZm0geQ_NmL4divUOCXnNtVtOl37LV-Q>
    <xmx:LtJaaPKBjLzy3JRmy8-dEqtzzQrc29AzjMQj40yrZmzpwe0_2gjUtg>
    <xmx:LtJaaFxckawPfmRpIiAtcRrce5G-jDIv0Xb3evlplSD7Egm5iwkS1Q>
    <xmx:LtJaaLKMTHJIs1CpmARJ5m45fWpfLVlIOXxvB6EodzDI4GjW6SKf9A>
    <xmx:LtJaaKUgQx5NZUaxSsxNvMX45i5D3Ur_3st2mNXcqzHsWv-xXlPNWdOI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 12:28:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>
Subject: Re: [PATCH 1/3] compat/posix.h: track SA_RESTART fallback
In-Reply-To: <2b5a58e53ac68e39a72e23bb40b386366ff03485.1750774122.git.gitgitgadget@gmail.com>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message
 of "Tue, 24
	Jun 2025 14:08:40 +0000")
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<2b5a58e53ac68e39a72e23bb40b386366ff03485.1750774122.git.gitgitgadget@gmail.com>
Date: Tue, 24 Jun 2025 09:28:28 -0700
Message-ID: <xmqqy0thyuhf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Carlo Marcelo Arenas Belón via GitGitGadget"
<gitgitgadget@gmail.com> writes:

Two references to Documentation/CodingGuidelines

> +/* On most systems <signal.h> would have given us this, but
> + * not on some systems (e.g. NonStop, QNX).
> + */

 - Multi-line comments include their delimiters on separate lines from
   the text.

> +#ifndef SA_RESTART
> +#define SA_RESTART 0	/* disabled for sigaction() */
> +#endif

 - Nested C preprocessor directives are indented after the hash by one
   space per nesting level.

