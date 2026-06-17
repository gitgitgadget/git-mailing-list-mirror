Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FCB3E6DF5
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698422; cv=none; b=VLv+qlr0EXFav5348ZxtdvkDgDaJRaRg9SwO8HeY/h3qtZiZ1gmbGGBnQ4VlS7RKCguy4XBS7jOFCwPTcaltRO84Ac4AwNyMpVpjfSbPIhd1kMSiDulhSzF3s2dnQuXOB3uD5NLCJkZTuyWnpY7CLZQTDSGpw0RQ+BCW9KnUzVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698422; c=relaxed/simple;
	bh=F6OApv5tz8lQqI0BLDv9NnxZXCD7g6InJ2DkzJWuIbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ge8Z+tg6pz4USevhV3yZ+gnm4ZXVzbMN6mNOJbaFJ2O6mvCHbDG+CI1DP4r8cvDLYptWgrn2J0BB5VKJ4TEfnCOpX0/RczPReYvwBc9HBzHkJYma7I2gmbJcex7Cz3k3J+c9DfsevU1bZv2L8wFBqjhsFr5z3fNoN54vI7gavF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FPejiZPY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dy2frTJJ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FPejiZPY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dy2frTJJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 043777A0086;
	Wed, 17 Jun 2026 08:13:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 17 Jun 2026 08:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781698420; x=1781784820; bh=hTRM6VN5w8
	CpLn6DPgQI3z6kZq6b3wBWjSDCf7EGNNk=; b=FPejiZPYmlhBhc9dTkkbP2oLX9
	wVspSc8pRMkiZXfn9zS7XVXXbF33g5qZSGYHrfc535gwFqfp1BH10kFZmQ7eR9Cf
	XNwLzvFsD2xGiAquBnrexasSXr2DlBa7de4vsp6NHMsJfDAoQvIyL1CJMei4Z065
	Vyt2rLBd8cq6LDoPZK4ab2fok9PlRu7UAGC3G3UibsAw+efINqHwgPZo6Bm1zIH/
	gPnyX2sN7yyvV38xV1igKqx4l4/GZ0e02RQLlr7aAkMLOsilTc+fqqQK2Qlup5vw
	kIrVErLGiu2Jfz2suDoenVWehCWN2mO15qd+3s0HBXz6fQGdSUlvIOd5nUKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781698420; x=1781784820; bh=hTRM6VN5w8CpLn6DPgQI3z6kZq6b3wBWjSD
	Cf7EGNNk=; b=Dy2frTJJnd3oLV/0JnLuqygpuk5trjdqrHSnpnUCceEbT52jH0s
	XtBlG3qg7aDy//J/VZytvzw2tyaLSWnug0TGJ9ekA3EhyNeKpzoi+7DO1TDZWtHj
	gUjoSJ33qtE2HsX2jzqohDyqRif7rYaYRu61XnnfLZs8HKGio1EqMcCgWy+jjT/Z
	vG5K7TA1LZ3+kmrXpHPhpjqmJRtRRGso1v6SH5efNM8ZSVnO3XZOTYbzyW+P+ih6
	WYgskDlkcBPnklQAC2xJXO4H/Ec+ccsg1LLepZv/l6LZ2HOh7WWTG8jbme/WMuXf
	1G/tooPq5S9Vb49yNsTMIbq5ZcgXogjGZpw==
X-ME-Sender: <xms:dI8yau8grNc4hCF6DFt4LREDy_hMIAa--qQTaBECztPVEcxYe12BLQ>
    <xme:dI8yamK3Bso6J2fj0_CGtZI8_hggtS7-UCEc3hAiH1IW6oxGWunuskHSV_7TTCD_v
    KrE7RTGNWhu5ZzzC9z13O8PKc97OqLFv_8izrbXFCl1DG0ARwBF_A>
X-ME-Received: <xmr:dI8yahYpdExRcCOYWdMbnWWRijOBNu-B89QqQ6T1sOxJu-RytJpNapz2Z8Sbpcnd7R3N-YzgPr366q-1elUpmdkhedpvtmClBDVr>
X-ME-Proxy-Cause: dmFkZTFjUq/pk23AU21HfPQjHvHXR8UKlqUv4Jf/WizKAGAmQyGkZE9xSsn0i8hMSUGVkO
    xo4JIwqpfXxHNAbZNEIaKhEsJin9iLJ3lODdQAq12piSsB8TV9XBjv0T6DDnGK1cQP/KnQ
    6YgOQtWBdxDIbKRI1cx1326FXysD4yXruCj7d0CVwFYbpOUOPnvJa8G90sa/Ae4NvpBixm
    Ch61G0x2uvHLHvPmYaft+UD4LYKsov/rzCtUtICA+28OS0+wb/uPAbqyZhkr2tijEjXw1z
    FwOcxyH2n+36MNTrZA7cqvIRsNORQJZ6Gp+zNsvpgTxyv1DmDzOS+7c/FonRn2cGINTVEr
    bUDdly/oddMvMhXa8KOgcPl92lyfPNJ7OZM2pM+vFVqR82R1h+sAk/hbWh4twyJFXAfLwU
    OMQLPkj0D+n1Cn/PSA9WTlxh/gJVsVF5v2rDXv7Iq8J7+TZPxUOyQ172OhzRFc/xr09sPK
    xJikKVf48gV5zxKjGJc51FIRNo3b1JGex4r0FlvW3wr7l5TGZRw1jE0xmKVNS2Y7HmvfrD
    xJ5hhU/Io4vNyQCSGSAhN/H0IuloU/ClzRa8FlJXzPmidiHaLjHP2aD9QPGg7rCRGcUbA4
    /QDdB6L+nRPSmm75Ir6hwPazd8IDr9QrjNSxKSbAbBcI9c90RXaXFwgkJNeQ
X-ME-Proxy: <xmx:dI8yagLGccd4spkHO_7nAt97RaQ302m407KCqUZKQaT41GfzMr9u9w>
    <xmx:dI8yanCWkNPmWGA0TlfdGQ5GZwVZOP0MM8u1b0nkYi8cCVsSsCo0wg>
    <xmx:dI8yatouitU4jV4ASKQJUD-zpR-U6biM3WdwtQKrYdrUXAcgk-aUDw>
    <xmx:dI8yaqjYuLydcPdTNk0lKSkSFxHXCLFf5wgVJ98W4TvGzot-_nuhcA>
    <xmx:dI8yamR-qxFiDCVmoTcmPsslVJgAcndIYAmRnccGtgqCLwfLBBrG_iBE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 08:13:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] builtin/refs: add "rename" subcommand
In-Reply-To: <ajJMqayXuie1FyIW@pks.im> (Patrick Steinhardt's message of "Wed,
	17 Jun 2026 09:28:41 +0200")
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
	<20260616-pks-refs-writing-subcommands-v1-4-9f5219b6109d@pks.im>
	<xmqqo6ha4jw1.fsf@gitster.g> <ajJMqayXuie1FyIW@pks.im>
Date: Wed, 17 Jun 2026 05:13:38 -0700
Message-ID: <xmqqse6lz7nx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> If we rename a ref that does not have a reflog, would it leave the
>> ref under the new name without reflog, or would we get a reflog with
>> a single entry that marks the fact the old ref was renamed into the
>> new ref?  Should that be controlled via --create-reflog option?
>
> It would leave it without a reflog. In theory I agree that it might make
> sense to introduce a "--create-reflog" option, but that would require
> some new plumbing in `refs_rename_ref()`. So I'd say that we can add it
> at a later point as needed.

OK.
