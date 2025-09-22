Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24149C2FB
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758565066; cv=none; b=LRutXGawCvSGMggeUKq/Rw0BMNcWFJg/2JpFJqZBEyQB/SLZ9Y5PNFmhOgOMvcZeJ5MyUyxxQ/PiWct2Vw4DchjE0BxrjIoFB8ch3S2OeP3fAUEGMcZaTzGVq/R9ImIGkiY4HnKOdn/yR6j0xz6Hw04MjXVhJDLv2NJryXzPAaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758565066; c=relaxed/simple;
	bh=8ISJy6w00zPp7oeeIaC/SowhJHj2+ZxoyO6Z8WlvZvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GC7EoJs1w4ks97/jtRinW7Szeg/DhJaaCBEV3Y+X2Lf/Bn95X/gVPQVej+JfvPtmt/k9uOTa+SRojp8uYDJhPMq0waq7npmbzgZZrOEXytYiSJiS067qBivDdacGWpKQCluw3WEg8RV8OWRYXbzQtH/r/Lf8Ng2iKDP/L9XZCVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ij+fhdob; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i3ivoxHa; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ij+fhdob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i3ivoxHa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 298AB1D001DC;
	Mon, 22 Sep 2025 14:17:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 22 Sep 2025 14:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758565063;
	 x=1758651463; bh=8ISJy6w00zPp7oeeIaC/SowhJHj2+ZxoyO6Z8WlvZvI=; b=
	Ij+fhdobY8PbvkCPZxoTTyDmSmCVFwIfunqYaZ5qO1kEihanXflAkq6ua/WypJ+e
	NqjVmTBLRSYsJnXkeVUh0Ww/USU5Mp3M1tQJqQ9c2vufBWEYNnFfRD1T7Y0I4NMX
	mOEf4vZyg4ta8Xd3DFp889V5xtx+UDqXLKIwWFQKDSrf/r41fH19ZTtZZanTYu7u
	d8Z0EhU8YPgmPpjWZLEp6i0iogTSbEkg+gR/RLTSal2nhA7bVSAL0oRyAjxP7iXD
	chD76XXJyscezeJ3xX5/plIBcBYsJx4AcutjhPOp1Ur+M+hFdVXom/XnwSi2+0D6
	VdbG0Nd8JzJGoMLKp93Ldw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758565063; x=
	1758651463; bh=8ISJy6w00zPp7oeeIaC/SowhJHj2+ZxoyO6Z8WlvZvI=; b=i
	3ivoxHa9iW9lVHGwdF1OLzVIzK2ZuslbUqfNOZs39iP/PXXLqIR7gGx/l0rWj5Hx
	8cFk5cyGshc2O14MTxRmKWqwZrvmCmBf5RqIYr5LpT3oN/feZo/uw3T+kd2nVnpj
	ar8znOVDV2GtYCAXJfrNUJdlDXS563iNrbWOG4fVy9JVRNdDCBC40KBCJDjB/XEF
	o0nDds3tqoenUMlHuBqoVp9Gdj/jahgA4paMwWiZ7cqDZLmafohpV70Hb5t9wVcQ
	S7/8dfPybRSIEoycJcoyJ8xgWqUOMlaXqbAs6I4XT0WzS7x85w6AvkOmdmbvxnw+
	EU5ki5o1g39t7SMiAXfcg==
X-ME-Sender: <xms:xpLRaPRHdwQhzy6MCnijB2kjHYrf9M-8iPUlpYNBcvexJZLdrKaRpA>
    <xme:xpLRaHrBixlUI1hogAC2pl4tyBZVgKABoCXWSKstmVAhEJGVUaoK46SUT6i1KvQzT
    pETlX5LlyJWxH7L1TkntSW6MA7-3eCUmKcW8oiS4ayKdIG5WyefbA>
X-ME-Received: <xmr:xpLRaNKP3zsOhzjzLS2ZGRtlT0xwDUWaYCIUUibwiJ27YXPsLmdbtviwKgIrKCDjrIQPDkxHrVxZ0Vk5TraZxHd_pr4N6u4tHSJI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffgkefhhfetieffteehleehtdfg
    hedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xpLRaKoSoJDFgFOsCz0b_emEjlvQR_dLi1YCzl0Sio5URcIBIkKwpw>
    <xmx:xpLRaFxrujqVXBbNoKlJEcI_zwxPWWM1HzO5ov9d41ONR-Itcp9FZw>
    <xmx:xpLRaOO3oEJyxVwukSCMo_ASkybht4jHZuDAHjFyxN9Qac1w_eWmJQ>
    <xmx:xpLRaK6FIXnvHv8Vx67AXHk9yeRZeTvQXE88FLz4flHjtNOPmO0QHg>
    <xmx:x5LRaF6tpnwiLxMXWNRn46s-iKc7QJbwCyJlVOXb6x0K3JhE-T_wVBj7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 14:17:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
In-Reply-To: <CAH=ZcbC_ecyPeLS_0DfN3+w9RTqcrt6Je08RPXqb6pJVGaPjuw@mail.gmail.com>
	(Ezekiel Newren's message of "Mon, 22 Sep 2025 11:32:27 -0600")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<aMpODEpyaaVhFMO0@pks.im>
	<CAH=ZcbBNFSwU7E+P7hkQnt9UrMKiCRESgGvWPL7pRUa0i2U5-Q@mail.gmail.com>
	<aNFIozagGc0MoseL@pks.im>
	<CAH=ZcbCZXavx52521cFHdXZn=BCWBiR1aG10ekZVg3PVVJb2VA@mail.gmail.com>
	<xmqqikhav3i0.fsf@gitster.g>
	<CAH=ZcbCsKdZAPxBEPUMvE471ogTNptjFy7FFksWnJfnX=J-F2A@mail.gmail.com>
	<CAH=ZcbC_ecyPeLS_0DfN3+w9RTqcrt6Je08RPXqb6pJVGaPjuw@mail.gmail.com>
Date: Mon, 22 Sep 2025 11:17:41 -0700
Message-ID: <xmqqqzvytkqi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> On Mon, Sep 22, 2025 at 11:23 AM Ezekiel Newren <ezekielnewren@gmail.com> wrote:
>> Cbindgen parse's Rust and generates C header files; If a field in a
>> struct uses u16 as the name then Rust won't compile, and cbindgen
>> can't create the C header file.
>
> I just tried this in Rust and it turns out you actually can use u16 as
> a struct field name. My bad. I think that's a bad idea and should be
> discouraged though.

That's a great news.

It means we do not have to worry about existing variables and
structure member names at all while working with cbindgen.

