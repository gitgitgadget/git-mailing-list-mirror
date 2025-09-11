Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D595C226D1D
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757625599; cv=none; b=qBsdFEZxVjCDdA3O3OU3Jv79oOVInzzK2UldnIwz4CJkM4nFPQSkZ1TYoZyiLtf+p3NjmJ+5kxvY1+B8w2Va6Ae4usrsKW/ylFiUp7VLT5BFHG5NBH8XW2WLDHzs2u4tt9YHUUJffu3oQ8fb6OYye56TdKAsRM11jf5CDSORb4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757625599; c=relaxed/simple;
	bh=dWOoP3A7EM1978g++rIz/7QVbQXDkGnqnoL9vc72cyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EHY1Ak6eA4VcmRhoB8y0ilVkjGurAIidKWjAqggANcL3AEDameEkqCj5WkT6vkIDbph7jZbYus8FyNbwdfqGx2k1GGZWYzRIffemnpW9OVYtjYxpZru2NBGHXqT8dxovd2WByHtnnETxNl9ERCXiSrIKl3rLFHuPbZXWtDeS9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=txmsIMVf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cXOx1kho; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="txmsIMVf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXOx1kho"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B23027A03C7;
	Thu, 11 Sep 2025 17:19:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 11 Sep 2025 17:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757625595; x=1757711995; bh=XwsyfGox+V
	niNUiTNyAnNV8PcWmtYtAW9AyWgs9AJv0=; b=txmsIMVf0EjYogn3hv9jbQyA1j
	Jr0L5a92qKGSiDpeCYcte3Mua5cfQrDLQy6LczBySCA0Pj5SHWoaCf6QXuSWTbGV
	BTBnh61eAxk4hamnbkGf1enPvI2cTjdphScE6C5Q5tTm98MQ94perVzWnDzpYZS3
	YHgkZOsCPGEtogDoL/KzVx7iGHASqTeRLRqvpye3514GT36GYlQiuXHKtA77XAMl
	ATjK9pvYhHtTFtJuLXhw2UDjh0oAqltX7EGOCEs7K4Q8F4UcNibQB4m3/zjOaYI5
	pDhpbJ7oJv/Zz+e2y6IaOJpAspgJxzkutMXEZCyPniLRmNmytPw03nLKp6rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757625595; x=1757711995; bh=XwsyfGox+VniNUiTNyAnNV8PcWmtYtAW9Ay
	Wgs9AJv0=; b=cXOx1khol17yU2UqpPYl8XLmNm//bou8hseyvOtLrIEmbMBC2TG
	B597FzRCNCO3mzEREP9qZkHyEj0USxeLyLVJonSPtozztaHaPr8wS1oNz1J2PCRJ
	1K99P405oEMplZuejIeEMbOxhzcXY6nGvYLr23rPauoL+TxCQglJtU/n2UBAZATx
	8xM8Zjq3azOowYpQ9u1rFJqt+ergf5225dTPMQIDgk7Wtg0jeZ7Ooi6+zDnEMbHd
	lne6eUAuqqPdz2GzBaKCVDUAWn8Skjwjgq2lCynMKOL3ys4Zjvqv/cDfe7tdSdb4
	Dx9ZZiNJaohEpj8EdOhU/AH7+3cdO+qiPQQ==
X-ME-Sender: <xms:-zzDaF785foWpDUgrMu230EgZmHFL0hDwimvAN5hE-AKDyM4pKTEYw>
    <xme:-zzDaAfElIopW-aKU8szdbjsgh468g4l_e2COBk-LMU0Gk0iT1LNIgBGutTNR2PmP
    7PACSRqToBnEUW99w>
X-ME-Received: <xmr:-zzDaC4vmQDW_SD4RVbuvNSQcbUT0mqHVAB84stAZTmBbdDbcZInOFNqMmWJwV9gkrxhGAAWy4FLREcDZ8kP5Wf-KO0rxtSpCxi4hNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvjedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptg
    houggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-zzDaPs-uYtZVnsSrcLe-ysk_Kk8k7otwImUMmQffxIfoGtGVTXW9Q>
    <xmx:-zzDaKiyJvgzSIrmD8nWh7jQBUPxCCwk0WhggTn2z3b8TNMbbGWZPg>
    <xmx:-zzDaCpdt0OiiFbCfk32iPxxrvWeLA3Xe1aJD13BDK6fc1GW6p3VEg>
    <xmx:-zzDaPth52_Lyl3bWTMdOTJ4OMOEJiEjzKJKZx-FH2rfyXKx-1hl1w>
    <xmx:-zzDaPqMvLnogVGXTHjt8UIvuXuCfZ5B9-Uundzu-wg4aHVZDVYOx-_t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 17:19:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
In-Reply-To: <20250911204404.GA1907215@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 11 Sep 2025 16:44:04 -0400")
References: <cover.1757345711.git.code@khaugsbakk.name>
	<cover.1757446619.git.code@khaugsbakk.name>
	<672253e0e7167c40290d1fef6d5076adfbe25d80.1757446619.git.code@khaugsbakk.name>
	<20250910051347.GA556174@coredump.intra.peff.net>
	<20250910154859.GB562601@coredump.intra.peff.net>
	<b39ba543-24ad-4bd6-be6e-dc1b8a416eb0@app.fastmail.com>
	<20250910183418.GA1157772@coredump.intra.peff.net>
	<eefc3524-9ecf-44e5-a6ba-1b4a0aff3158@app.fastmail.com>
	<20250911203256.GA1894340@coredump.intra.peff.net>
	<20250911204404.GA1907215@coredump.intra.peff.net>
Date: Thu, 11 Sep 2025 14:19:53 -0700
Message-ID: <xmqqo6rgofeu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Sep 11, 2025 at 04:32:56PM -0400, Jeff King wrote:
>
>> On Thu, Sep 11, 2025 at 07:31:04PM +0200, Kristoffer Haugsbakk wrote:
>> 
>> > But it turns out there is a regression in my code with the recursion
>> > detection.  Compare:
>> > 
>> >     $ ./git -c alias.one=two -c alias.two=two one -h
>> >     'one' is aliased to 'two'
>> >     'two' is aliased to 'two'
>> >     fatal: recursive alias: two
>> 
>> Your example there is a little funny; "two" is recursive to itself, even
>> without "one". We detect that case in handle_alias(), and we would still
>> detect:
>
> Also, I meant to say: good catch. :) I did not even think about loop
> detection at all in my suggestions.

Neither did I.  I am very glad that you two are very efficiently and
effectively collaborating on this topic together.  Thank you very
much and kudos for both of you.

