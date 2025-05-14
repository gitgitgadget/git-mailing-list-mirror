Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D28C2797B8
	for <git@vger.kernel.org>; Wed, 14 May 2025 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227544; cv=none; b=JPnwbQufh1pmZtUwDfnpisnC1E+elmjHAjOHMt8+1B2GLHRWtIrCdkOJxNMRLzAJD2JeV6qsLgKQC4XNCPsxLzIhvkEy6ZWpAkKJoRuplvrYhOHt79b4Wkx/YtkqHJzssQXrmxgH93KHjuPHT+qN8yCLe/cywfxzKF55u+jtlG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227544; c=relaxed/simple;
	bh=PHq/si63FvaXWwxhzc23w4Li3KZBF/TJ9PMr041EKgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HEwsG9/e6McxPtodeS6yz06y3PvTueIaBV7bLY4yiI7dUFVbi7j68mcEdRjtstkJf8w/8UfT+eILdwkJ2dPzCpnZEeBheVOURUrlPhlzEkXgP31snDFKQAMV3OuweRyhDVHJrMLSTX9xUm5C5rks+/7suUKK19ixRtJvsbl3gU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g47xZ1O9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RZNLGAnH; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g47xZ1O9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RZNLGAnH"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9169F11400FA;
	Wed, 14 May 2025 08:59:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 08:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747227540; x=1747313940; bh=JNZm1tB9z5
	Gi3VbORlzMXQDE6TUVROXd5wE2GSh1jDs=; b=g47xZ1O9pY0TapGr5u8pvsh8mv
	36P8azQglyf9LzJflqRQnNiTqEirOFUXzG506A/4qQFaLcDKVLLLtwxs8rNWEKgw
	H8adiS2JjUOj+ci9QZ5FL5smoN9iF7Y0Iz2+fc9p0v8me8J9k80qPKjWOt2aiyik
	utxmTP3delF+V06OKMTO4omIYI8Pd/58fyrXhk+HDkdqfhx0tWdtkwgv/uGaSOJA
	L/541G9rlEDLKstn6g+cOCRACozyz3mRF81a/gdB17TVhpGz7zSQsSt5WG4h5FWd
	u2j1fYWFZ8Btg2iGe0OpSOaxy9xf/guO5RTJ96PIjG3ucdjL/j271fJK/yCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747227540; x=1747313940; bh=JNZm1tB9z5Gi3VbORlzMXQDE6TUVROXd5wE
	2GSh1jDs=; b=RZNLGAnHLgW1bEqLXJzUcU/KhGuHvvP8h9SIB3nBYK7EJmp67XY
	gorkedNcEi+nIbJVXrct9igN+7bzgXWdce3hiHl3oCYcG3/2SJ4nN5L3N5ScqI2l
	s40rOrk4zn+BDFmKLZqshBNvi04FFuSbtlX5NrRmtJfanV29zO/ZtgnoD/rpXP5b
	s99bMs90Kg+u7YyzrcNrcILnd7Qcp8c6Fbz6zGegTkaZGui2d6mPLC45yFEjWifI
	XQIx/TgvN9Z8h3rOtz9k6UP+rMpqEsHBE8kcfTeP/ZWcL+NH7nq1GZZOauqzUH1s
	n50jU95buUGZ4LofwHkudhweZQZuc3K9Ibg==
X-ME-Sender: <xms:lJMkaCrx3NJV7y-G1aHuvyLuyCGe-KvIqOUz_OwBmdGzVanFmHEJOg>
    <xme:lJMkaAqHbE9npDPCjYqQQMN2yYrBAzKgQqZFhiP0C1n9KX1GEsha4daZtcTpxM_6J
    EncJ03mStq1LpTCNQ>
X-ME-Received: <xmr:lJMkaHPTIHMvnV0sMI3RXCs18H11L6sjFCsWDy4dZ4wvDACYR7sOmLsDN-U4amb0_kyBND_W8quZEypSR3iLsb8WmzM-aYV8q2Akyiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehioh
    httghlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lJMkaB7G2m_D6FTzWmSWTj11jWeZNaXt2tEbB7D6HIf8LUVmrjrOoA>
    <xmx:lJMkaB4TERLoHb4L1WLsItdGDqk_y55LKGgHKqQjaOxGIuxepYVxxA>
    <xmx:lJMkaBi0AC21xmTELNHkvE_YkfVIryzo9gkdiRFEnKCoZ2eBdjHy-Q>
    <xmx:lJMkaL7P1xM32sCjK3PitfjJaKIHMu7m75Pi8r7lk1-vaOcxr_OgIw>
    <xmx:lJMkaMil3ba3UabuZPSWjoqEgt0lEEecmQk2GU84BDunIuhyj3r3wGiJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 08:59:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2 03/17] object-store: rename files to "odb.{c,h}"
In-Reply-To: <878qn0jonh.fsf@iotcl.com> (Toon Claes's message of "Tue, 13 May
	2025 21:28:50 +0200")
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
	<20250509-pks-object-store-wo-the-repository-v2-3-103f59bf8e28@pks.im>
	<878qn0jonh.fsf@iotcl.com>
Date: Wed, 14 May 2025 05:58:59 -0700
Message-ID: <xmqqikm3cprg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Do we have plans to extract the object database subsystem into a
> subdirectory? With us adding multiple backends in the future, I can
> image us having a dozen files at some point. So since we're renaming,
> shall we prepare for that at once? Or will `odb.h` always be the root-level
> entry point for the object database, and only live backends live in
> `odb/` for example?

Just like refs.h and refs/ directory holding code to support files
and reftable backends?  I think that is what I've been assuming.
