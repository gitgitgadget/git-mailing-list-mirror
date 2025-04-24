Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D17DA6D
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745493202; cv=none; b=QGAytVgV95RjLyCWwrrXKbnniDRxCXOUVB722lV9QYu+5mUyTjLNUOMy2fAzZi1ksUoMm8p5mrJaXVUned9y4SPePwGArtK6sSPNcJv1xjwjjmGQOPuehk+Ket16fGYNMm3sa89eVlycQOoHs8fqR93Q2x0WKlXSIHeC70D0sas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745493202; c=relaxed/simple;
	bh=F0hMt3HOvkQtS8JPHi5OwHt4iOlvhXNm5tV28CIMOTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o4KgOa9RUWNuzDPzDbaWV70fweUyBbjQdT9l6XBinX8G+4Ggm0h6Ve6D3waRKsKGWDIVu4DL939Tgx61KYnKrlPeGCh6WIkVo8RWUZllTXWlTLVafQ8C+0ZZRGJ2kXC/p3/ZY3peUda1Ad8uvu0K4CIByGAIaIlPD2p5CPkV4io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NRTr12jA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ISQcfnx/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NRTr12jA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ISQcfnx/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B09C61380416;
	Thu, 24 Apr 2025 07:13:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 24 Apr 2025 07:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745493198; x=1745579598; bh=SQ84lXWST+
	2gPOt1Jqt/uSTN06aNtpnZKFeUIXXmKTk=; b=NRTr12jALUIjlBWAfMYtFT0ada
	A27gSnCnX9NeQhbyRuovuqLlJuHJ+r/uioN0LgBepdHugAXY/kMwGrksBqvxhDE4
	fVpBxGlMs+G2da7nq5SH4E4P2OnjHEzGj+uw4NYAnJHGNXnibC5wSCChqFWlW+Cz
	d2q5eAplJ7UwK3LM79G7pT4lCAag7hFHw4BYCZ8DDIXJcGOkR867iwtmf1MEdU80
	XYvEkThv7mcEU4VNYj8MlTB+JfVXdIX9PHtgfEwJQeDqrxYmH2UcjMhwXtjF+xfU
	fVmP+Lm7Um3FQ+2/segXV620RvlxEWFV6jlsVthddd5ZROpI5Ej5Tv0m0hgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745493198; x=1745579598; bh=SQ84lXWST+2gPOt1Jqt/uSTN06aNtpnZKFe
	UIXXmKTk=; b=ISQcfnx/lDadOJUFR0n1AaFPZARKb8oP93+SkBCnaG7Yyn2vikQ
	yL4Zqgr8K6ytbpXktuHd2EyooRWrmQ6CXAuqJ5ot1N/56950I5hum2q05GzuSYAf
	/zWRJoXhd222EkGAfm83W16SDGmaz9EtbGsOwpgIv03+DKS9gzrJM/aEGUcK5H02
	G5Sa34Jf7HfnRZyMlhDuzy8LBd4U171dL69jqVAhTDxk8b0mpXgYSIi4G6cg6rrw
	saS7IPOJLUzb6OlJ8pgHQZ6+m45w16/pWUTX4yBA2/Hv639q1nJ2g/LzI97nwGiC
	Gptl1WubOH4Ul6wd6r5/oHcTx5pE8B+ZQig==
X-ME-Sender: <xms:zRwKaPhWk8rXBHR5kfpqRzJ9OXpMKMzgNUnx2GXooF5khWg7FPj8rg>
    <xme:zRwKaMDzdCW6icv7bYPhpob2pKjLLlZDkZJFu-NZI6feoxnJ1dw15b0EkJMRcMJrZ
    b_WJx8ak6Byxfqfcw>
X-ME-Received: <xmr:zRwKaPGgKjKsIfQ09tqfzAeP5XlSmS2vRrrdzgHSWi4lTMuKt7TRcVlMeZ_Nh5xdA5SYskEIix3oIuTGVD7jfhoWuPsLnThkPJBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhu
    gihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:zRwKaMR4zkk96CjZUny7uCadTAZY_lEt1RJElbG09xYpI68yoScCFw>
    <xmx:zRwKaMxHXXaZPHoqPGyM_t0LOMnIEMmpnNGGoxXkWwIc-O3aWu2bhg>
    <xmx:zRwKaC52L829B6Y_Y4x8aklLendq7s6kxXIhj0Vn7QplyxAoBf1aBg>
    <xmx:zRwKaBw3aEroOxDVsp3EI1qxT6A4kCETsWsXr89JuQbCxF-ax3IFRQ>
    <xmx:zhwKaCTivX1XCkpw7L7J0lVykURa732ePEGcTlBMXWjWS0CiWjZ94OOm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 07:13:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Toon Claes <toon@iotcl.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/5] meson: wire up support for benchmarks
In-Reply-To: <aAm-pcIfrFt6mjlV@pks.im> (Patrick Steinhardt's message of "Thu,
	24 Apr 2025 06:31:33 +0200")
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
	<20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
	<CAP8UFD3Nr_f7WSzjv4AEKzH9Kpsf6soOd+VSO9ng=-ZSws6P3g@mail.gmail.com>
	<aAdK9gnXOO3ERq7w@pks.im>
	<CAP8UFD1zqAk1_Y0ECu4=iyeF4k4LagfLgHWkEr8iz8ZnwkVT8A@mail.gmail.com>
	<aAm-pcIfrFt6mjlV@pks.im>
Date: Thu, 24 Apr 2025 04:13:15 -0700
Message-ID: <xmqqwmb9vmlw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> I was more expecting something simple like:
>> 
>> if time.found()
>>   ...
>> else
>>   error('Benchmarking requires the `time` command')
>> endif
>> 
>> in the same way as in meson.build elsewhere we have things like:
>> 
>> if not msgfmt.found() and gettext_option.enabled()
>>   error('Internationalization via libintl requires msgfmt')
>> endif
>
> But erroring out by default doesn't really feel nice to the general
> developer. I'd claim that 99% of the time, developers will only end up
> running the test suite, never the benchmarks. So the default should
> match that and not require GNU time to be available, if you ask me.

Maybe a stupid question, but does "time" a shell built-in count when
"if time.found()" is evaluated?

    $ type --all time
    time is a shell keyword
    time is /usr/bin/time
    time is /bin/time

> An alternative could be to have a 'benchmarks' feature option wired up.
> This feature would be set to 'auto', and then we can detect time like
> this:
>
>     time = find_program('time', dirs: program_path, required: get_option('benchmarks'))
>
> This will then auto-enable or -disable the feature depending on the
> availability of GNU time. But if the user passes `-Dbenchmarks=enabled`,
> we would fail the setup in case the program wasn't found.

Sounds quite sensible.  Do what most users expect by default without
failing, let users give explicit preference, and when the explicitly
expressed preference cannot be fulfilled, loudly error out.  I like
it.

Thanks.
