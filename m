Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B401DDAB
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768868926; cv=none; b=Lc66tTpvqVJ1geMCiQ4qnrQ2U+VBixbGWIYn97VraTaVtsiw+UKv/wcxbVR/6m5sd/OqMaA5v9QW0VHDI6RrcURkdiwRd4NrtzbsKhWLFnVqUgZv8L6j92Q5Llc9zCkAHCjW3ej7E2DJKmXOFvZ3YxpCozslvHmvu60cM3pSPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768868926; c=relaxed/simple;
	bh=UYxHaBw3aUGXEsmxlfVk7AgwswNdE6M74bxM/KNVUjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NoJF+UlMNFMwXmouFaq0eykWpDTFuH1JE0FT2fU0SszmUg7/RinB55MAwiQ12h5sqee7gE+jDhwqNL9h662W6bFbvd2KKGza0eoFhgJkESVXSeyOmLFEBLFK+uN5vEOb89CasDigvhggb9A7mtRsa1gwDDfXLNWbwux7IM+H9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PZWXaKrM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=seJ0P6Gi; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PZWXaKrM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="seJ0P6Gi"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90AA77A0570;
	Mon, 19 Jan 2026 19:28:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 19 Jan 2026 19:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768868924; x=1768955324; bh=k+aWOBxrR4
	FAb1XVO5mLpS+ZOCkak7R716pPgK3zKCE=; b=PZWXaKrMTmAp/VsmBCp9Jjizp5
	WKWeZQc0cmTNv9nhyAoLgRSuuHrSY4rsQ2H7ol9nsFa4ti8+DGv86ybjgTK39mJr
	aicWLndO9vvbuWggUZwPZxBlZynPbu0ID7o+q6XaR7aVRMkZ6eLCndmGGXb4fgEi
	kO1N428ZyxE0OCGcGk6VFgV72ahZa2c1uCwJrM6fJgTJK9qR2QrxGvZHEdrXt27T
	D0fjMgVZweASzBU/EupgCd1wvNLQS9RsFgKrq0zKWb0SKKSqpe+vi9tj9C5n1icv
	UOp1qiskjxXh0ljKpDqfK/DMuCQ1/u50TPjSUaVS8vb1dIhRfsoYO66mglbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768868924; x=1768955324; bh=k+aWOBxrR4FAb1XVO5mLpS+ZOCkak7R716p
	PgK3zKCE=; b=seJ0P6GiQFY7M4jYC+8JEYaPMCSKnmkpifATtakhoPnX1S60uU1
	axlRGp7qu7vPtCNFKV9F8VvvjaOjpXTY0ipQK5hji4ejuKqaA1fTmhfjEuN7zPpd
	OR20oB9i/H+zOysaHt14U9FKznkQr4W2vTiiWVEfISLa3YJS7UvqNy6lncucr8Tq
	15BpBLzDeHmCCVcYNI2CZpbxnmoE+d0u/1aPZ6CvpwzdGWRTgRWNjdX4MWkXsn8H
	PidNYH3bV/nXmcdCuTmVWv05sU6c5pcrIk+gxXD5qZG5v+XYTK848cFJdMUQEG27
	B/dbJUYwcMwiUiItL6V7iQTll0IsOUOu7sQ==
X-ME-Sender: <xms:PMxuaUIFXCjE_nE8obfF4LmV7DSqmeRnTbFuhd0D0rOfoGYpnj3Gmg>
    <xme:PMxuabBv7AuwKypij6yVGIm69mpmhP6FE4gRHGeGqwaZ1Rw6EUIx4E6sNBKqAEd0f
    gotYw71HzfGBKKdzDzcs18IOZvv_Y3Gq73ZqI-I7qtgHFgfZgfrXw>
X-ME-Received: <xmr:PMxuadBAVrmNtqZBm4yJIltIvmQa4q5SojkPvNDOZ5erXucDFJKXM7tnRw70ycv7BOqFD_dRTLQl7Ok2HmQ0_AuQp7dHx8jktgGZm-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeltddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PMxuadCiVQ1V52CE3IusIKudcOX3oMRJRidhkSPtSLlhlpVmkgrEhQ>
    <xmx:PMxuaYrvkkpLrWMaoKHufb5Zl475pVD0MgbwgWVJCJfoi2sUdqeggA>
    <xmx:PMxuaXlT-kb1H6TC4g24lVwONw666WBh_eRXkamr04BUxH7xZnGyrw>
    <xmx:PMxuaYyIWVdZ45ch3jmiDF5nQiNikXMR3KXVKpiFa6DUJNrNQDi82w>
    <xmx:PMxuadiKGwFCHSFH1G2H86Y22_YvRzNXEF_AS8zQs5WHpqHbm30h5NiH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 19:28:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH 1/4] remote: return non-const pointer from error_buf()
In-Reply-To: <aW3QVkpPPHjKVNLC@pks.im> (Patrick Steinhardt's message of "Mon,
	19 Jan 2026 07:33:58 +0100")
References: <20260119051858.GA1991308@coredump.intra.peff.net>
	<20260119051945.GA1991523@coredump.intra.peff.net>
	<aW3QVkpPPHjKVNLC@pks.im>
Date: Mon, 19 Jan 2026 16:28:42 -0800
Message-ID: <xmqqikcx3z5x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> This function signature is indeed quite misleading, and I'd argue that
> it continues to be so even after the change. I guess the intent is to
> make it a bit easier to print an error in functions that return a
> string.
>
> I'm not really a huge fan of this, but it's not a fault of this patch
> series, so let's read on.

I concur.  "If they do not return any useful value, they should be
void" was my first reaction, but presumably just like "return
error("message");" is a handy way to give message while signalling
an error to the caller, these are used to return NULL that signals
an error?  I do not offhand think of a good longer-term direction to
improve this one.

