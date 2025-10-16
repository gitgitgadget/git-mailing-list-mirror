Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7DD1A9F83
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644725; cv=none; b=aTB6INWqiwnXJzzMnYDlkNFCa9i3UY8ORqAxVx2FX6TvhzZ3kybQFZgXSOTgpsNX4FWLNqmiMPeQdEVE6ZMhW5DP4ko01WIE7oAMWAti4n8tbn4u2stc4RjFc/PGXwvMfG4+BL2tNMQhOqGvsoNcyt5QjMzvXOmozL/PBCLrtMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644725; c=relaxed/simple;
	bh=EywLOxSzuvcgoE84cnEAOm41gPbCVdTcFKrwNzdcX3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HectjtFDXDKLq9sH+nPa2vxb87H6wsnF2rYGMX2qls4biIel/6+m+m8c9HJQxu2FbtAjmtFVLyP02Onr8MDvGjHQ7xWicy64itDADlbZtLbCC4Kjc/Gi2jYXU6tBzWdI3M4+yz1p/yvTMNjSrMYAbUbmifkEGfJB00+flQ4UneU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AkHRU1wf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T31XLHpm; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AkHRU1wf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T31XLHpm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A172F1400116;
	Thu, 16 Oct 2025 15:58:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 16 Oct 2025 15:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760644721; x=1760731121; bh=bQtsVH/Vb/
	op3m+3ac2PQzc3uGkQ5kwflpcoLg9oHWA=; b=AkHRU1wfX9Hyj5hroIytjJYqSn
	jwIAUJjg+uTxU/GbdZV7d3vDkOm6JNV7ly/ZDDXqbt8U0VVy6mKNQRtSxJJrSTC3
	31MdTfaFKYuj1xdWEH/jF7q2XORmU7rS9Oxa0s9uhW9dJGCzrKBGfYJK5FmUwMEl
	21M0v+X0tSVv+0itNg84mZ+yX7B9AQ8NLRFuZNsyNRuUMX1vNox//bPQD4RT5pdL
	F/OnkYCRfTuaTMvx/EXT9t7Twakjjn+QNK90JQwWTMG+HDk875LOuK7ex0vqdHzY
	RDVe/ymcFnW6PIQu0ZVFQ3Txf9JFprVi8dum25std76TaDrwalvrjOFkd+fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760644721; x=1760731121; bh=bQtsVH/Vb/op3m+3ac2PQzc3uGkQ5kwflpc
	oLg9oHWA=; b=T31XLHpm6gXdNGhLUFgs16sEQc2OjHaQrFkdFN71+QIEFduQ8Bp
	0/7KgwNf/SnY8DgvqMZ/7aikuLASrozeJR8SNZqwsedx4QElTF6yU3+wQBb6d32q
	BjLMMeRQTU2qUA1nFhQPNfrCEhMRYqKlrZLucrnv8dKkShfFqgR21xXsxPay7SmV
	OYul3JKbihtsg43lpnh7WpPs7SYn9UlYCPPRAXUUh05HM0A598DZ1JNFlk0HJAyn
	ssoQy4uBjz0oKspqDwiU0EvYo6/mNa1rd0tM7S40vBsbD2wyJK4UFDGZlney+l5s
	DqHW2mhrJpjdYb818oQoaL4f3pflyKwNruQ==
X-ME-Sender: <xms:cU7xaENJWF_j8rXtgGCexAur6oYbGiAsiSzOBg9kiYD4oLeQQkRUSA>
    <xme:cU7xaCZb_z8amifojS1lzF10v7Oot35ctqcUAE1XecxY6EGrQBhLa21sA0WyoGD2i
    49HnX4WkkRiEqsAIKtAWxLy7E7FLlRLrXgsfyV-kk4R-ACSiWRpxg>
X-ME-Received: <xmr:cU7xaIr7I9tnLpidcwUR8lO9zOSrTpmM-4FvA9ztC27pUoy2gg2Fjb9en5ialIJfPppoRFNndImbWitH4EjDWZsTHn-TA-OZfmW7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehl
    ohhhmhgrnhhnrdhshhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cU7xaGaZUhoHO0ytkmLoTlET6ltvPUA7DyJ-aWynwq59V_gfVtltVQ>
    <xmx:cU7xaARwZrPX87FfCZV-dJAVxDHn6XC8vIKKm82FOjbc8T4whQrHZg>
    <xmx:cU7xaN7KgjFXftCtzKTpRSPhhr03ag-mr7k5EP8IXQycGQTLlKitKQ>
    <xmx:cU7xaFzebo3hwa_jZaynx_UtNKGTUxznXNToExezbPDufCGecQ8whw>
    <xmx:cU7xaLH0vVLbOKOgN-0vWuY_-kYgMVXIXMoGWyjvA14h2maWawfINmBJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 15:58:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <git@lohmann.sh>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] setup: allow not marking self owned repos as
 safe in `ensure_safe_repository()`
In-Reply-To: <20251016053322.44495-6-git@lohmann.sh> (Michael Lohmann's
	message of "Thu, 16 Oct 2025 07:33:22 +0200")
References: <20251013094152.23597-1-git@lohmann.sh>
	<20251016053322.44495-1-git@lohmann.sh>
	<20251016053322.44495-6-git@lohmann.sh>
Date: Thu, 16 Oct 2025 12:58:39 -0700
Message-ID: <xmqqjz0u39g0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Lohmann <git@lohmann.sh> writes:

> Git considers all repositories as safe, if they are either
>  - explicitly set in "safe.directory" config, or
>  - the user owns the repo

If you are going to reroll this step, please add a few more cases to
the list above.  There are other code paths in setup.c that does not
call ensure_valid_ownership().  Treating an explicitly specified git
directory as safe is one of them (there may or may not be others, I
didn't check).
