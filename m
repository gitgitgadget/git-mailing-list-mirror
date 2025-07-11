Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF961DC994
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752260132; cv=none; b=UOAXfz6jD6CQTFmKHEc5guYw2gypuD9dOoNYhgYX2rmHi3pXZNx7RAh40fFzLpgoI0vl8PnSxHRO0DFJ2kmRgi1Ths6vYqfUlHZ7gXWGEjM6c54qzO/j2wKg4wJnN0E4xnJ+dq95o2qdffYGsQhu+OzMyoQorYw75Z4KOz+mTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752260132; c=relaxed/simple;
	bh=OkeFeVVMJ8ehlnoIJA+kEwLjg3ZtshQHU38SYIxNT4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=csfR4PvjFK61X0t2mi/s24glmZkUyJIY6DUYh6tvkiZSkwKisdi3tE6taeEN5wvZcwnEE+eoSQrDIvBPnOu4ByNHbA9PgUY4WbHbFEOAcriyJjBinlfXqvsk3WZq8QNCh0p5GDoC+I9hLWZrwC5gvT/jZafdI1JFoEUZZQ8hyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZxfLJLG2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e5YJngOe; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZxfLJLG2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e5YJngOe"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EFD567A01EF;
	Fri, 11 Jul 2025 14:55:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 11 Jul 2025 14:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752260129; x=1752346529; bh=OkeFeVVMJ8
	ehlnoIJA+kEwLjg3ZtshQHU38SYIxNT4c=; b=ZxfLJLG2/qcL991JZv09UV8Vey
	0a/coRjLEIsQMPvhGGPDb2fqz3kZJFZxD0ch9ilSTobmI76MnaJOSdk7jJ0F8qg2
	hAE2AKyI6f7tOlyhuNdCfp3neYVfrcDob5IAYEJeFxGfnOyCOjFQnxJd+U+dDUNz
	Lxa3fGnBQJOUhJCb3MPsoa9W07sh9KLj3p3Pf8Qv/DP2UNvH/TFJiHJtx7G8l/xh
	JVWiEa8xM5/01n2n5WNZl5mUWmBLeIYtGsaC9/Sug1e8HF3eWGxR7tD1sY2eaO6U
	7FJ/ww8KmYTNY1PuBTTGH10KUYE4AmcgNX5QmYPabZzVRZWzVxsqSk94qnoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752260129; x=1752346529; bh=OkeFeVVMJ8ehlnoIJA+kEwLjg3ZtshQHU38
	SYIxNT4c=; b=e5YJngOez5kagpX1D8IyZ860IppeQcrD4L/lwSGI0xyrAlWM5hF
	djF/72gv7DIM6EU5m+Bmm0Gb35fQVNqO1P63zIFdzX6keNbKkt+WeL8baAglGK0A
	iznBMhc45bD2LdI+LeHrZhIi7sy8xmbU0gTsI9hMYfJ9efV3mehEtePi6vJKpgsd
	jlOfgXjg1syZvc1UoO2V0V3AtpQuzCLQC+pJKVlM1DHqKU1au+KtkuZVrrbKKXnP
	yuazcq1dv2tlNuYtozDXWmQk9cwf2hhf/v5Rvl/7bxDlIscjTsVk0pDxMHX2j0Gl
	wFMTWq2MUGpUU7RDkXWhQ8OqxxXkrjnkSaw==
X-ME-Sender: <xms:IV5xaPkBInSWLRaI1avIyARulnMo33dtrGdVIsi7JI3WaXAvEakp2g>
    <xme:IV5xaOUf32LaDaIam4EbjD3SBSa_4iO2nhj0cgjRePXcsuxcfP05yY4wbVbUtoEfm
    tNILrDEeEdwd4x9fQ>
X-ME-Received: <xmr:IV5xaMF8ZRJQkd0Cdkw03i3jb9fLeBuLDwERMf1FLszR7BBs2d9sSMBZ_u9eDAC4BpXKvHtqKUXVwq3GvVYQJVZGKqOrc652H3-DIXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IV5xaCdBTZiSPAmEdMLHmBjLhtJ67s4gey2X2Vt5Qshndvx9-usb5Q>
    <xmx:IV5xaFIhXifZzrDw8GIPFLsPlH_c1PijrBp4Q563BABBc3Of7r4sWQ>
    <xmx:IV5xaPEj1X4GQVFqXhLLQxJjM4fUOc5rYPNGeG1WB1MM43_DW2gc5A>
    <xmx:IV5xaAAVqJZaXK-3sWasWBH8_3GBBRSKrDSdObBTNHldLtY7ovQV4A>
    <xmx:IV5xaF3ZwgwqXbJQLMjUWUM9_LF130XZC6T725wi5n51uyom8zn5RqI2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 14:55:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
    Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: Re: [PATCH 17/19] environment: move compression level into repo
 settings
In-Reply-To: <32fceddc-c867-4a47-bde8-c873279edbc1@gmail.com> (Phillip Wood's
	message of "Wed, 9 Jul 2025 16:26:54 +0100")
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
	<20250709-pks-object-file-wo-the-repository-v1-17-62627b55707f@pks.im>
	<32fceddc-c867-4a47-bde8-c873279edbc1@gmail.com>
Date: Fri, 11 Jul 2025 11:55:27 -0700
Message-ID: <xmqqbjpq1rs0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I do not think adding prepare_repo_settings() calls all over the place
> is a good way forward as it makes it very easy to introduce
> regressions like this. Our builtin commands parse the config at
> startup for good reasons if we're going to move settings out of
> git_default_core_config() we should ensure that they are still parsed
> at startup.

I think that is a good guideline that applies not just to this
series but to other topics that attempt to move globals to a member
in struct repository (or repository_settings)

Thanks.
.
