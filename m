Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BDA49E5CB
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842234; cv=none; b=ZzZWOJWQzFm6nBUzKenXq29RpL12rZxIX7Zh745IiColrKKFxYLToqVWoTDHiL7h/AwJZDAB1WUzYQGjfB1oom76BujrOYeFZBOtqruTGZfPlki5ft+9VefZOyoEGw2qwOXlHpqtnA9CFEUOZjPn3ap2o0g9KBArF25pnqsJOwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842234; c=relaxed/simple;
	bh=yioNruSz53shK4MtXsGhDocWoIIi1jcEL9wvpLwZDhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nDKEtOBSpI1fAuycofSCJiVxSowI3xVhaTfM7NmJg6yiSADOO3btSR007wK7Atoep0DDmPJUIaY/l7q6cYn/i3JSm3DkkRAq69LzJ8kgF4QewqJndO6uw6lcUigto+biJeetEXOtKgxCab14gdgeX3K0mipXRgUVp7ziHVgeDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JnycSx4z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=seTRnsh3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JnycSx4z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="seTRnsh3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3CAA1140012C
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:57:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 12 Oct 2026 17:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791842230;
	 x=1791928630; bh=1/b3C/EH1xAqEBRnEY/UnAfANvAct8ovuATIF+0FJU4=; b=
	JnycSx4znUqCp1XIX7EZK0eO/2D6/qDF3sV0/PBtd9sz0WLUmiIWVqVy98PgP2qj
	mo4105OUH44DlN77ri6F0YyDaQYkYK5iKrn/0ZlabKbhoMiA4j4kIiU+P+wvLlNj
	UJ7utMM0VI6fqqKCoYM2857eKgKiF6VQ+LYh1a9ptqLowJaDnJJB/suBAfQlLuVn
	5y+fqvNIXZIDQWSU4/aDdxVuSif5q8hP4ofoAJQtB/OtbVj9dA6Cc93wNnU3Tgqi
	VHK/46BzHloFBpneXe/e6Os1xWbuf/cWisWURVdtJfEdHeY0M+EgzwC6BLoRstZ0
	SL1Df3H7/sTFUDpF2E7Zbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791842230; x=
	1791928630; bh=1/b3C/EH1xAqEBRnEY/UnAfANvAct8ovuATIF+0FJU4=; b=s
	eTRnsh3b00Lvl6JgGyzg3pBywOMb05hqvfUPSYmemlakZHZlwm+TS6e3v8Xir0oa
	JY7WmKJjYAjA42G5eHidN7CG4tcVPXXllRZRuvw+bbQyVsM9I7iugniz4gZcFFCV
	nvfFx1Et6PfNpW/xH1CTijVJnIE36PsmcZAJtxLuZSHYoQ7rOFnLJ3hdUv2sGjyM
	7w2XhhrmLwdXFoznMw8z8HzVcMw1YsPG6xcbhb/Mkq5EUr2y6shJJ0g4vRs0kASR
	1mhpIuf0pYoatLMAeNTt96PY7iMrGnsqzmIVtViKu2vX0W4SCKxcde5NWcBDtjDk
	eXg56vg2+Y1TbPICZkH/w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791842230; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:dc0jHVffndk2UociPV7ZGEEPXmbKOrOX8hm8hLjGh1xpFIn
	FJnj/xySTzeUbjVsCA2Fuh4k7kmshc25veNHTF0W1cSNSR7krcK1JgF/W8IfhFMe
	OwR09GfvbLcBSttgLFWhjXIF6f45UJKutkMNHmiP9JTuwZ839efeXW4qrLdOCrXW
	GFMn/dTg20apyuEoeMvNzoB7nlhFi2SdLENtCE8vonm6TzpmubDHWPgkBP4gghIZ
	GO4qyU4ZCffNP9kwdXrBlEBtoBX69HvpxZ8ZlEzDsnHbXZ+5O2nzNxTGwN/VyV7E
	6jCXkfTu0d+1f0jItb3x2lxgMNeyv+mEynv4w6w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:bc85N0XE+Vm9mV7taZ3NQeEUysSTMxZtAk/c6ugQdgU=:yioNruSz53shK4MtXsGhDocWoIIi1jcEL9wvpLwZDhg=;
X-ME-Sender: <xms:tlfNascztckZc4VNLRW4TGtNjgkzZDx0_jC7Vz0rTyzr6jtpzL1g_A>
    <xme:tlfNalOWTl-SbJ6KUCI8MWeKSjrETPXQLWUjzWZDC6SOuAXToxqirZlM_uR21FfXE
    Ignzsi4OA-mFeMhINSY6g5i7U4p48SmBhPdGTLZGmEkIpD0Hl8CrIQ>
X-ME-Received: <xmr:tlfNaiih8ite0uMs79bO9tDU4pff97II3RDkT0vNnffJ6rHXflZQTs0mQqUNMEWiQ5jJ4-d8YysN_P0OrAmURfdS3HFWE54VhtWV>
X-ME-Proxy-Cause: dmFkZTECkPlv7svgjyPpnmVXVMVAh6cC5FESStwcfPQ721OAWxTLpEqgaFxxAtz+V3gtS6
    NXBdmaBCthyOJuCFCYnlo2Tpfyrx0FLglbK6JGi/GNEy2v8aNVeqcF4K/o/WR6mmatdKbk
    bwrDdJSpoDaW2notjxavIFj6KcPYHtOXBLEfdoqJwYj3+XnZo3mnNiFqW7FyYMxwCufKl7
    FQkYxnBtp3A5HoWEnQW5C5T3Ttjj9cuiB/iMBjYcigyeQ26GRsCJTuskFulVLaiqM2bwb6
    iIhj916YXn81JrEi2xzYUVfzawy/cGi4VSF7RrlIwG1oyRIbZXyD60J1w4SRH3+6mN0WtJ
    7/9XCOGKmM0X0KAeEfAgXg1C6ZmM6RTlmJOE751P9bjD3KBBSe6c0IBNkXN6n/J0+mM6kf
    GxNp0I3xcQ2FlIuZEzwn0UOrOarnbkp6xyIOTY6dsr4n6TIVEY8djIwYuezkxSe4Xi0lq+
    a3sp4jBGccQFONqdNqefM0guNle2s1Q09s2bG3UB+7xUadodjagRoQ0Tee/pp+RST7YMdU
    BUmIRYR8Od4lTexsSPznh02t3H98vBpxEpNu50fgCBMBG77oPz/fSs5IQAk+EanHS8/tiu
    GVvMJO1ZC5xIG+4TGhDra4Czmv0rB6RU8/V9XRqs0qAuls1RxlPiCQwriiKw
X-ME-Proxy: <xmx:tlfNag2cGM06da6C8kgYYTM1hcLO7vi8LTHdgKLo10G541SPg87QIg>
    <xmx:tlfNakhV6z5Y-OyKUtUkB3Cx6kFnzKrzofxoUgdagSXIstxhK8R5hQ>
    <xmx:tlfNaodNyJUJU72gdKQ9Pukq6WuxRSz0ua0Wdlc0vjOjqEe2WyrWZw>
    <xmx:tlfNavlfT87ju4OwObMmSBcnEcEfYX-K4-K9KNfnWJ5_XLvu5L8OOw>
    <xmx:tlfNav57YSGH4IwAH57o4woKsdtrOCLp8lVO2ARh4kgGrNrhlyMxU8cx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 17:57:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Marc Becker <becm@gmx.de>
Subject: Re: [PATCH v3] wincred: refactor credential blob processing
In-Reply-To: <pull.2251.v3.git.1791840427937.gitgitgadget@gmail.com> (Marc
	Becker via GitGitGadget's message of "Mon, 12 Oct 2026 21:27:07
	+0000")
References: <pull.2251.git.1791553518774.gitgitgadget@gmail.com>
	<pull.2251.v3.git.1791840427937.gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 14:57:08 -0700
Message-ID: <xmqqik364m6j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Marc Becker via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Marc Becker <becm@gmx.de>
>
> Invalid target size check (bytes instead of characters) for `wcsncpy_s`
> already led to memory corruption; d22a4884 just hid the error by making
> sure the target is always big enough.

While I can parse each sentence and understand every individual
word, it remains unclear what they are trying to convey in the
context of explaining this change.  In my native tongue, there is a
very appropriate expression to describe such a statement:
言語明瞭意味不明.  It roughly translates to "clear language, obscure
meaning".

I will leave this patch for those who work on Windows to review.

Thanks.
