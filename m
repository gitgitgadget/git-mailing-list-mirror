Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8728DEFA
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429602; cv=none; b=LU7XrzZ3hjEH5vap+7GeP/WcwQKSE+Sj18RjGgzDZORKH+svOcUpTH9RlYsLzkMPAG1JhhaWE862KkAXfDnyqVstEnCweTlwTpXw5DLUthOJ7bwXeUkQapN5S3XPLnyQyIT5H9M9uiJBkr7VvAhBYrScM8afRoPg9MAqWd/xnok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429602; c=relaxed/simple;
	bh=PR1u0yOvY3ACq9xLXpMSeFDMms2W+dbJ8fN+WphITVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ToCTjGjW8myuS7gwrFjI4anPhvpBHuPJgAZZsuMw/ith7Nv2E0UweLjdMAw5XJSTqRRWq1x/AcLdp0UKpY75W0QCYnsRD1eHIb+GrDM3kHTGq7l/HHPvZ6Crl1TxvsAIc/smu7mY6zGVnr3eta4s6t1lDjnxKrbsGgLcs4A6bAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C6vug2EY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IWFOBmz6; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C6vug2EY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IWFOBmz6"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D1E411401D0;
	Fri, 20 Jun 2025 10:26:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 20 Jun 2025 10:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750429599; x=1750515999; bh=pNVhSpGiBm
	aLneNxnG1NbUC0Ka5VGV1PXH+yT4rISbg=; b=C6vug2EYBQHqHusrtY9RRTBLO8
	hm4ye3tVLEUJrS1Bh8efFX7LQJaAlJC8hGCjnc02/MIr0J++Y2l1alqVZpwnE2iY
	hH6S3e7c8xx9Lx4psz7eHIMJf2mQWd0/gdlhu9WGhIo4A6HPc7COaoBTVrWWLs3C
	hfZsDK6guekL/duUMEarGebUJeMjMS+14+vQrDVhFB7tbNBcMg2LLqcBiemvTlis
	kc5QKyV32tI5Zn5zhjdGmlAhzFNmqpSIh8+WMh43so6lErO6ugHM7JC38Xfi3aO9
	xclILWK36vaLSOoja67tF0P1NPqG+ghtMtcv8GM1UzurtsIeAO1/cgRHkCkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750429599; x=1750515999; bh=pNVhSpGiBmaLneNxnG1NbUC0Ka5VGV1PXH+
	yT4rISbg=; b=IWFOBmz6/WNlUaQtYA+kQTdcZON3zrIVo7A/0YE3dpZWDgPORP2
	BXiFC1j2mwRwEXTDNtorbbpSsyYjQKJ2NY0rtGRKM0S5lnEoKm9sNb1sQgOrG2co
	qNfXg7tnGzJZxS6x2zaKgqRzFw8N+eA4es9qdNcbHfJ/JyAtdH073QaTpy1LmuCK
	llcNfg/uIm450Q+xe7rovppYliwOJ+vjYaZbE6/gGZB5pixfheFpkH+uVNznu2VR
	AgODM4zoO8QMezeNIFPetOtIgXu9b7Y/0sbmRWg77brDpi/ojWinBrWpi/76mD+O
	wP2JyiFtAMu5WH/lgVYwmeTI01mxQwBnq2A==
X-ME-Sender: <xms:n29VaGKP_VsLpkXIRsnFl5bjkjmba95063prrTLVR2s3jLX0bbEEvg>
    <xme:n29VaOI0FmyJeVn0N3rQmIhkGxam3O4imujWFHSHViJ94IV6DG27-2JP5XBf4plHR
    oYoi810ZMswgI_ZZA>
X-ME-Received: <xmr:n29VaGvor6wVWSs-wEnP70BjI1ELbBodMJy19whkg-JMnE-Y_AVEG1haSowkG_5-XDJZ-_7OloShJHIJ8ybk0z6Hi5lCSxjmK-SZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:n29VaLaDPeNlv2YO7GBbmptWejULWAGZYDp4TCE884U0v6UUiQWuIw>
    <xmx:n29VaNZckoGo_DeX7aiqJg40x_z0ycWVJncWbMyM-rkig__XeZ-58A>
    <xmx:n29VaHBn6FTxM3y-cfGftb-fmwvEoV_T0kh4OZLSN1uovP6kwCtoIw>
    <xmx:n29VaDY8wOGfe-_N5DiSK9vqAGR2jU2HcQDmYUaQdpzmThmIXThTHg>
    <xmx:n29VaAnwxgcHMPayWu44LfjMi6I-lUSSYID4Y6z1qcMn1Ifh0CNO2Y5s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 10:26:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 04/10] Use original hash for legacy formats
In-Reply-To: <20250620011943.586596-5-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 20 Jun 2025 01:19:36 +0000")
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
	<20250620011943.586596-5-sandals@crustytoothpaste.net>
Date: Fri, 20 Jun 2025 07:26:37 -0700
Message-ID: <xmqqcyay7ale.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We have a large variety of data formats and protocols where no hash
> algorithm was defined and the default was assumed to always be SHA-1.
> Instead of explicitly stating SHA-1, let's use the constant to represent
> the original hash algorithm (which is still SHA-1) so that it's clear
> for documentary purposes that it's a legacy fallback option and not an
> intentional choice to use SHA-1.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/receive-pack.c | 2 +-
>  bundle.c               | 4 ++--
>  connect.c              | 6 +++---
>  fetch-pack.c           | 2 +-
>  pkt-line.c             | 2 +-
>  remote-curl.c          | 2 +-
>  serve.c                | 2 +-
>  setup.c                | 4 ++--
>  transport.c            | 2 +-
>  9 files changed, 13 insertions(+), 13 deletions(-)

I earlier expressed my puzzlement, but this step shows how
GIT_HASH_ORIGINAL may make sense as a transitional measure, letting
us tell between "This place in the code uses GIT_HASH_SHA1 simply
because we haven't examined and inspected it for the purpose of
allowing us to eventually switch the default" and "This place in the
code we determined need to keep using SHA1 even when the default is
different".

If that is what is going on, after the whole-code transition
finishes, we would want to rename _ORIGINAL back to _SHA1 for
readability, as in such a future, developers should not have to
remember that we originally used SHA-1.

If we call use a name with SHA-1 in it (e.g., GIT_HASH_MUST_BE_SHA1)
from the beginning, perhaps we do not have to rename _ORIGINAL later?
