Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1493F2253A0
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793011; cv=none; b=oDcg9Rzq7AFotQATnZEyD3m124cMpUb81icd67Tb9yJSppM3rUEw1Wx5kgRPrKrD1lxFqqqdyHUT2l7bvali0XHy9xZcfBMrkPx3bnQQHMFDYs/suH6TQFqB4xci0f8BpCFh+UymiaqwQ60hNraWQjrdgYqiXVlQxA1ZvekMu84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793011; c=relaxed/simple;
	bh=WTkPUHG94F0r3jDsyhrDq8b3xRezFyayyJEA9ITo9Zc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lr6pPU+nXbPlUil20xqKXkPVIIhZhVP4LR2OYu8ykl6OwIgELnipL7CZiqgWBrp/+53FWwpa14E/qWIm0+iCndHUI3dSKFfpuGUL+oNzMwRhY33WHC1gwdJQc1G/G9BkJMIaKK4SvvNygOggIwOtGXFqF/6jikxYR0ZguvAlfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l3FNmk9k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h57YlC/K; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l3FNmk9k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h57YlC/K"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 499397A0172;
	Fri, 30 Jan 2026 12:10:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 30 Jan 2026 12:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769793009; x=1769879409; bh=vZMzDFC7Ci
	qCOWnHLJkvgDro0exN+X8xkltX0bhQQQk=; b=l3FNmk9kNuXTZfrP/2hhRmkatC
	Q84W945XjUkQs+OMuLdk29pGNAtnwob8tEXH+uJAhviGTChZXf3+4uAM2ent11Nh
	gOsU4mqW9BTeJtVWwUjgORYm58eSvZvm06dZ9CN0ipJ8cIgZRtLEhMxDPYr6+CUs
	mQftCjiErYSOwNIlDk80CP8SvzhU2DAlUdjcswJ88tGF8kSy6x4KT+NVdiTy0Ubz
	12dREE2H3P9b/00sDW9zMwmjeL+IpsCQ7dPUyW7+jZJVC87OAuynrs4XSyNevuwf
	fV/XrvZQ6X3I47+HDYFDifJu1AFhBGAlBLOMhp7XXscn+H7j/maf8tH/SL2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769793009; x=1769879409; bh=vZMzDFC7CiqCOWnHLJkvgDro0exN+X8xklt
	X0bhQQQk=; b=h57YlC/KbojgtKQbJoNE/R9xjNdoClGTcK4XjP8k4aapISnJOtW
	IEtMI5kxbVL/Yks/GDilcWyB/5nbFMxY4qsOtGM086LWKJCGZTI8eeB6lTWBJLVD
	lpZWpVSef3ZnxySDfEXJ6XFwF3+tbgA+7YFJwYaAPQ5ct3M7rxXXEZKUKKqemrpc
	ghCGoBMi0nrwNfT6yzpMiNxl4viewQ7wy0vDOTIlBSoUAK4EKogSBMamk6a5NNLt
	q+JexqLfVG/6L22nltUPhWEljrdz3E+yRNGE8HOsbZoxODGlB0xmU6qrX38iTLEu
	4WECkC+6ciVTSg0OQTvXGIZF9wS7WosEBZg==
X-ME-Sender: <xms:8eV8aYyUHUwYgBdhBA4WpdRW2ONWVpE0KXz9tbd5FL-JPLqVYlf1Kw>
    <xme:8eV8aTLuSnCWJQEIekfHosrUlCzpqgDnZG2RfGJFlFcMsar8Low-HikgIAmoS825n
    kzydlAtRyfvJrN1kVuaXm5WGKqJBAU9dKqRCFVaAIUGXqd0DScH>
X-ME-Received: <xmr:8eV8aSrqEreUwhLiWULqAwuxcVR_Z9lem_0DpJKGYAVZnzpbz9EF4dgn1dfx_VbmkcVQ_Bm5ImfW7Y1oZmwNPNsXqUefbF85Bu__ZtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeliedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8eV8aSKayMHqodGenRAmuoig7QISmmn3FmHOWZHJXdzazvC1tOTJyA>
    <xmx:8eV8aXTpUYWl7SzNTpnCOCms7GJ6Nbpa7ml774AGd2TYhylWm2wMtg>
    <xmx:8eV8aRv4ii5hL8g-cNHowiduMbpsadhhQ7fPhShJ-EfuYwPU2EjMAA>
    <xmx:8eV8aYYtMSXiJ6yWnwt-vJbdO_JKbaaq2kFEsUxYKjsHcKPs1aTQrg>
    <xmx:8eV8aSYLLJrEux3o2wyWI0Gs5aKIdi0j2P8mmm_egOB6R_VDS590xITM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 12:10:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  j6t@kdbg.org,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3] t/perf/p3400: speed up setup using fast-import
In-Reply-To: <20260130162927.638672-1-a3205153416@gmail.com> (Tian Yuchen's
	message of "Sat, 31 Jan 2026 00:29:27 +0800")
References: <20260128160717.611391-1-a3205153416@gmail.com>
	<20260130162927.638672-1-a3205153416@gmail.com>
Date: Fri, 30 Jan 2026 09:10:07 -0800
Message-ID: <xmqqa4xv6n80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> Changes since v2:
> - Optimized `content_rev` generation by sorting `content_fwd` directly (Johannes Sixt).
> - Used `test_tick` and standard `$GIT_COMMITTER_*` variables for consistency (Phillip Wood).
> - Fixed typo "reversed" -> "reverse" to match original test (Phillip Wood).
> - Added "done" command and used `git fast-import --done` to prevent errors in the loop being ignored by the pipe (Phillip Wood).

Thanks.  Will replace.
