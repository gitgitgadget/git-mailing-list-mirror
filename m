Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689122046AA
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744040965; cv=none; b=Ik71OqLVrI21E6K6a1TEL/Vysp2DvCkBjVfrC9Bcp1ky9QsjJ2cEhlPmo86+1Ht02C9GPk1JFKck7DREKt+kZTqdX7pMOqDnJJQraA0krYtrEsHVBWyfPntcI7gbUL2ori08jyLvFa3aCEUnYT5of+gM80J+3P/ezH88ux1bkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744040965; c=relaxed/simple;
	bh=MdKftGrUitbMfO1nmQv898/3k7bb+0xxsjBnoeCKR4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sEOPAUeRu3wOq2UdDg/PMZ2e95BtVW5YbtqUMbGkqzkPtQchT6kS6t6Cx74S7xwNPDd0cBLrUrjB3N2b/IqKJP2So+eZoF+9ViylM0k/iONgDokBhSoBi31SHG4EHk4r2blv/8ByRJLW3xyFXYnlgjVRpb4bsNBSJfzOjqwfg3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=frqQST1G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=klTz+kw8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="frqQST1G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="klTz+kw8"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 57B7A1380141;
	Mon,  7 Apr 2025 11:49:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 07 Apr 2025 11:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744040962;
	 x=1744127362; bh=mB20gH++S1phsWfOkYeXhvFU1lnbcKA5nzvFUXclhds=; b=
	frqQST1GtuQidqd81TT/KK9UkveQkWDog1xCwIG/WORFPAKyLyl6dKm2rbTINh64
	spizqjASqW89v2KoDcAn/kxoQSAsdxF3n9G00wmQomEBydIsOTIf4AgO3ShBTKoZ
	rtJbe0dTtdklSoVDAr0TId0tMTEzvlpZ7RdURL4y97PEnFlmjer0mOi3tMLHCTBm
	ldm4QReM1a79XSEO26srjoIMAc4PA/hV9i8hbaTr5OH8MMfqzCbzq+ayXOohZVYv
	hXwoZy1b2x/BUK4ETgLfhTyIJ0FYtCYMVrbssRy7uaAGWg+49VURzmmU21RkteqZ
	lGoVldz1kKRYUIbY3lgRYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744040962; x=
	1744127362; bh=mB20gH++S1phsWfOkYeXhvFU1lnbcKA5nzvFUXclhds=; b=k
	lTz+kw8QEM/cdiEaqtc0aoCwZDZxKyVssLEEZCHCeOjGJo+EXJDE6eUeGKaZ6VTj
	NXTcKdoAQY+Amvfp3Svgso2mI7K/hA1v13/rxPogdHt2Ugp1EoF6ilrg1eTPz1NI
	SIgEfZ32koyWYluLUofsIHTkROB8t7DUBmk1S6P4r5GPBWZrJuCvhryfddTmXHyC
	edsqqYg+N0xweO2Y7RLabKKxITTquDZr9RmkB4xgvQ1yQtD7iHI1WFcd/LnQ/8ed
	G8xSGRKpqQoaiqaoWlsKfQWttnA4Oi0TqvwgN3oJHV2HH4wWevTmWFj+iYbl01lI
	IuCG5wKlwbMt/489asEuw==
X-ME-Sender: <xms:AfTzZ39XEam9yKFAzunq_MDqIXb1AgNmOWb3vxO1rQpXdUQvV_elPg>
    <xme:AfTzZzt3CKRTpArXjM_QZT3YDX6nz-1ph4JtwalModY71m1feTx3GKHX2sCLFuIN2
    SYO1xFt8_cobQY8GA>
X-ME-Received: <xmr:AfTzZ1Aefn62Zsm-i_EmK1B7Qp6LT33P_pTm6mki4pFSRwlZBGJgrKsuTLlI8xYcjbgo69Hbd2Zr0QBtoszl-1VLICyvpZmHhh6V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehushhmrghnrghkihhn
    higvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomh
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:AfTzZzc0ksFEzH_lZKYGQBmZ8cAZG2TiRKePlcuc6VONqob2YgQ3lA>
    <xmx:AfTzZ8NpIdfuRq4Tvu6OliaYhdpDOuyajOh7VbqkcCrKkhpBubd8bA>
    <xmx:AfTzZ1nW6bhMPwSHWmvCHpSCGOZrhbWjwy0OpXXNWTwdLZGB3x5kgw>
    <xmx:AfTzZ2vLzQynoF8u77NhW3F_EV0cHH1asFw1kJjzRs1ntIsfczY07A>
    <xmx:AvTzZ3m6cDDGd0a9NbZRpIehX-wjcuExopEdz8yOdCGD0ALqJ7yLoseq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 11:49:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  johncai86@gmail.com,  me@ttaylorr.com,
  ps@pks.im,  shejialuo@gmail.com,  phillip.wood123@gmail.com,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/1] builtin/update-server-info: remove unnecessary
 if statement
In-Reply-To: <CAPig+cShdouOzG_jKz_Z6+bSprZ5ZEsx9wZR-_LuD1P2kaOWwg@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 6 Apr 2025 20:24:18 -0400")
References: <20250329120327.105925-1-usmanakinyemi202@gmail.com>
	<20250406121513.154084-1-usmanakinyemi202@gmail.com>
	<20250406121513.154084-2-usmanakinyemi202@gmail.com>
	<CAPig+cShdouOzG_jKz_Z6+bSprZ5ZEsx9wZR-_LuD1P2kaOWwg@mail.gmail.com>
Date: Mon, 07 Apr 2025 15:49:19 +0000
Message-ID: <xmqqa58snf9c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Apr 6, 2025 at 8:15 AM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
>> Since we already teach the `repo_config()` in "1a764cdbdc
>> (Merge branch 'ua/some-builtins-wo-the-repository', 2025-03-26)"
>> to allow `repo` to be NULL, no need to check if `repo` is NULL
>> before calling `repo_config()`.
>
> Okay, makes sense. However...
>
> By referencing only the merge commit in the above message, you force
> reviewers and future readers to chase down and locate the actual
> commit[*] which taught repo_config() to accept NULL for `repo`.

Thanks for raising this.  

When referring to an entire long series as a whole, a reference to
the concluding merge might be more useful, as the topic name
(hopefully) concisely summarizes what the topic was.  However,
referring to a single patch series, or a single step in a longer
topic, ...

> To be
> more friendly to those people, you should help them by instead
> referencing the commit[*] itself.

... this is a useful general advice.

> [*]: f29f1990b5 (config: teach repo_config to allow `repo` to be NULL,
> 2025-03-08)
>
>> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
