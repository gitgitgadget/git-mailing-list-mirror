Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3422D793
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735826; cv=none; b=u+0EOjDqtPQKBdU/fanrrcJywWUu7divAlC6N/sHSyMv3xkHkVE5PqVqS6kxs20cTr9twlhQEbf7coEZrPAA2LfnbsjGSXHKlmaif/fOIWK6jKsv2MNPNGILVS3uhefMqSwyJONqfaHqqS/E7CQptEDoW0+liEydyXQBVrn3rR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735826; c=relaxed/simple;
	bh=b+IhAcLgIdjzsMBJ0FbC9dZ3VEF/iMnOeM9x5BwKtOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I9Djuk9eTF/ng5vtxLKebyuzf/LiHZEjKrRmp7ftaU2dlhnRFYP+x21eeINfCDFmi7qx1ConN/RmdHMGU7j5mzqmw5QbtXCG9AluMP7IRavUgPhfawXPkkEe/r5BWA0qKZMi7Jr5m23KFl7yR81Y81HGKwT9+kWPzW1f67Cu86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Si1AOBzM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L9BxMqWS; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Si1AOBzM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L9BxMqWS"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 56FF17A0060;
	Mon, 28 Jul 2025 16:50:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 28 Jul 2025 16:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753735823; x=1753822223; bh=W75Bt3hHaf
	M86sbuTswu+SHJ65w/rrUcmTUT/9pbvPU=; b=Si1AOBzM7sNuji+W5LBFhspoSX
	KLEXuYPaAdpZKSnqlHM0QOw+j5asVLOQhxxQZbxmSaK7Xf1fvLkgAn5MJEXn6IW7
	rZuy+z7f2Je4pbbhPa/lHjpBk6P0pRDnJsl/BvUt2TWcZ5CU1lWyG51PqUd9H/X9
	k/CVDU+uIdf74dvkbIhjjpfkguNV0/CNih1Yo2qnThT0ie+8iUgAmyBTqQVySOy9
	h6U4cN7XHKWxcU/864AtWfaL0mPEYuoaPgPvrh0SdaQMquvZGovj7RnEq62Ixb8q
	f3lsQNJQznjzK8IRBqbJ3MhAks01+PR046Ejs1otYYOMnsxwOQD8diW0+nWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753735823; x=1753822223; bh=W75Bt3hHafM86sbuTswu+SHJ65w/rrUcmTU
	T/9pbvPU=; b=L9BxMqWSRnAC1MVes/kGVml9ugnGeNZdc5xSLxiyvQyE6DHHSSV
	9CPfb+VwWtteFFtAjX+O9HuH3Aq3ucjwnU5FpVnFyQVHFfgJ5qOLHYyC6J18/Gi6
	qeOHfty0Fbn/C0cFgeqCrBjmCsCfq7HzBrbONjKRqEy6SpkMpYAgGzXMRt/URQhw
	mKpgBRtybmG4ggPc8RCrmNJvEV5ROPRo57fFKNiWg/Khe8SJd8/vYaLkahz0rWmF
	+667+ZsWRWx/e1gJ4/6qB5BPm45/5/uxaPJfQnJaDg7dYELJXaL2i3LjNme6f91F
	crwpBx5yBSEjmbdw4V7gKIz598KgBEwf+DA==
X-ME-Sender: <xms:juKHaN5lAVtFY3FyX1PXje8de-95zTHpTx8fHzOG-9NTzCL5vKARRA>
    <xme:juKHaEUJBxvVLNICn1oyONdTL4OD0GvQr1d1Vtx33bt17oUCl6xnYmBEiWUq_ye64
    kO8DEMNL3L4HiI5oQ>
X-ME-Received: <xmr:juKHaEA-hYSKvAAkANS88Q0vmqLaNX-YzTHOxAijIRCcsizfjW0rd4hN62CCfYFY9NWiyq4_taV8DhGMgEc4aun2iR03fLAzZLFQBdY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelfedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrmhhonhgrkhhovhesihhsphhrrghsrdhruhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:juKHaL4UlI3VIWTigzUkmc-0HLcfPZciEMV3qZMhOYsA-aNQfx6bXg>
    <xmx:juKHaHxvBFFBngpu1Ctv9AEykSpPQxuDqZjG2YryhlZB0E5EscRRTw>
    <xmx:juKHaKxyb2yfuQK_7qsy0z5hKAlJgYcaVuTLa528ypXtCsrpOg5T7w>
    <xmx:juKHaHyFq7BTvvRDFEfvxOOxqKIL51g5jG--taXbwWU_262rIhpOJA>
    <xmx:j-KHaNFVmS8QbxecRw2aG2rxptJB72JOtckWpvB-Z2sS0Ulrhrv8zuPO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 16:50:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] xdiff: optimize xdl_hash_record_verbatim
In-Reply-To: <20250728190520.10962-3-amonakov@ispras.ru> (Alexander Monakov's
	message of "Mon, 28 Jul 2025 22:05:20 +0300")
References: <20250728190520.10962-1-amonakov@ispras.ru>
	<20250728190520.10962-3-amonakov@ispras.ru>
Date: Mon, 28 Jul 2025 13:50:20 -0700
Message-ID: <xmqq5xfcujjn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Monakov <amonakov@ispras.ru> writes:

> +/*
> + * Compiler reassociation barrier: pretend to modify X and Y to disallow
> + * changing evaluation order with respect to following uses of X and Y.
> + */
> +#ifdef __GNUC__
> +#define REASSOC_FENCE(x, y) asm("" : "+r"(x), "+r"(y))
> +#else
> +#define REASSOC_FENCE(x, y)
> +#endif

With gcc we can build, but with clang, we unfortunately get this:

    $ make CC=clang DEVELOPER=YesPlease
    xdiff/xutils.c:330:4: error: extension used [-Werror,-Wlanguage-extension-token]
      330 |                         REASSOC_FENCE(c0, ha);
          |                         ^
    xdiff/xutils.c:302:29: note: expanded from macro 'REASSOC_FENCE'
      302 | #define REASSOC_FENCE(x, y) asm("" : "+r"(x), "+r"(y))
          |                             ^

