Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21F43D4EF
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587038; cv=none; b=oqrSkq3BnSNa+9I6tYoUXiKqkhYW3REgDiV047GzEzBIBIkz69foPzuQTt3AnUwmd+E6O0d/VUdicNBM5AQSy4jw9CTHpOmzuM8UF7t4G/aweiqQFaWVDweTNJn3advhc0QmrZteUDWR67anUSo3+ridEeP+E5yZoY2k0zEF7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587038; c=relaxed/simple;
	bh=Nc0elRJ3hIDLv/NBd7DWvGi/KLFyfZhDA1Oxd95UHt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uqd5EOPD+SyfewPXg4iXNgKvc1fjlhhd9T2YcXMk0/bg7BYRejzeyBdKeb5KEwRT7WAr0CE21rHKfXbQtsZ+bRLMMs/s70p0WoTm6xMx+x2IMIWrZO6ETj236xoOK/DDrX88nbg6C6W3yUaWhQVRqMtSBindunxhn4k0ajuu5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r5XT4VXv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dKtdWsyX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r5XT4VXv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dKtdWsyX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2651714000C4;
	Mon, 24 Aug 2026 11:57:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 24 Aug 2026 11:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787587035; x=1787673435; bh=ekasSkdfiL
	vF74EZcN8xd1xMPNaxnbT5hCSLlVxmPwE=; b=r5XT4VXvjkVRG+ZchoV6AkC+XY
	WSNG/qqYEBMMEQJXpB772DAtGfhEqIOYGO/iqN9AQGbos0AC0aXmQFPblK5idqLk
	timrX9ky+wDflHzvivbWkOrnW2KjEzDefdtIr0BX4CrxA00otAFA0I9MjXQ2AnzV
	B+MX9HXGUDsSKepuqHu0O4wQatKMhlqYdAc2C03OLRiFmsSKYHeKjgMxy2O1iIoE
	JqhChCFdebKhHrq+TcUBUXqcbTZCK/qn9/Y3Z4DnTPb4OdFd6FrfIM79Lj5ARaoB
	qhq97d+0AJqJW7puWTOQuQZ5kBwbnmfjUT/0qnxjYNPJwMbMmOz5s2B5QIHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787587035; x=1787673435; bh=ekasSkdfiLvF74EZcN8xd1xMPNaxnbT5hCS
	LlVxmPwE=; b=dKtdWsyX3Eanv+YZUo6PV7vAMW+XpQK1d4/lJ1AWanK4ycd4nLK
	qUfhaFaIwa/tcv1I/OcNSM+TJyYYbRzNyvsPTeSdhzVeHm9Jl17eE1UGeyoxt7DH
	pALcfdZIK5MAOPQFpeGzpq4aUZVsVXnd/LPlr+Z16mjkXlfIHS3cuWQvi6A1jCC2
	RUqWIzGJPABRoILZSqKCHEjYZotuDnhqwXZ9R3Jkh1bE5VvVMT6WE+GoTM3Isso8
	nIIXnXf1OFbpUK9FkO2JAUL7WDUfOC+wVThj2XEKvHAyqXgQxpnuIJRmtdyDA82n
	QifIrfpVY+q00l1tC33wEXSpXKwOY25dRlQ==
X-ME-Sender: <xms:2mmMatxlzm9idXAnsOTLO9-dOosfYgzE6e8vhd0BCMSZWiA6tDoCpw>
    <xme:2mmMat905EfKuZDxHYnBfqKP0wo0H4l_WNE8-gUfCI1oXrFHWiU__eYbHpTcrjdZf
    --xs11f5pLpYx83wHbOKPJ_rrAg0iucncdYfJFlCshBx27j97SDNw>
X-ME-Received: <xmr:2mmMaljxjkQL6QkPSNtyN47wHYmHXwpbCgmJRj9mojCBOZM3hg0DlFuopyg9Z6rkxF4eNe2CR88kcH0Wi9fCQPBVPIeVNgBtxg>
X-ME-Proxy-Cause: dmFkZTF2w8iQ3gpmIwU8Gylsrj377l39FCJ/YZS95Jl8NSnPJfFiO1NLNFH5EHppZDVIKH
    Cwj2lMOL7tdMFpizJdJ8kcKIN1L70Tm73+sckNnXGtQY1PIC9XQttUNrNmDvo2+/TQQNBm
    e1dYsX9sJmsV30PjXQMAMOc6VFFlN/GPu7c1tTe9i/Bw7QDwlo/WthfDWHqMYBP5lnTdmU
    W1PNOF+xZu22hTEe718jpuVTpPWl9MFucExzG/0rHVQhjtBxHCHCyEsAtBjLqhFRiQMB69
    FQYKw5rlcxhODgCkuWfp4VrdE1hMqoXgGzxOKI6PwGDBI5swki9ba0AhsoXN5zN6vKYgkE
    bjm0ztj7hNromPCP3l2KcQ3YkRKnHGSuWg2r8daziVgceDG5rAAinizi/3StQpIqay3LPz
    INXlZyrRh0lljY6BLjzgE0SvYNvoAmaOuhI9eNWLubWoOGT2KB+xNFz4WQ+0lqZZ5Uh++y
    52c/JuLEKCFTaEOu8vt/lLAGes89fFr81kxGXbH8QoRqf+jYzshZf1NmhLeNzdOmQUF9LR
    D8PEozSFIqC1U7gwTvnQ8/rS+zgHGb7s6cbRqro78OTB8+WX00mHYs6iZbv14ZOYvXXIxv
    DUUsa2D5rnUJWXmomSH4y9CigddOTc1UAI7+29x/2UkBLWof2CroYnwkgctQ
X-ME-Proxy: <xmx:2mmMakEyH719KU1EFl5v-tIuq1loFN4LtndIJ2eyCpdbqyU2nPOYMA>
    <xmx:2mmMak8nNbM3OldKeiS9fYoENurpC8FXcehuQT6AT9FBAw_zrx1tOA>
    <xmx:2mmMaryxL1zT7HN444H93ILyDRWgdWpR6C0gAy1xhtatCGzerQ7w_Q>
    <xmx:2mmMagNT2o6zXCvxfHIwlEZ9qUy6p9TsGWXDflYeiSXpm2rRnXmD2Q>
    <xmx:22mMauMqV-N3adksis3Gsu0chgYq2EE2O8REouoI1hm0PK8NFQvbhItD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 11:57:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/3] hook: introduce the report hook for
 git-receive-pack(1)
In-Reply-To: <xmqqv78zr0pa.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	24 Aug 2026 08:35:13 -0700")
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
	<20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com>
	<xmqqv78zr0pa.fsf@gitster.g>
Date: Mon, 24 Aug 2026 08:57:12 -0700
Message-ID: <xmqqo6erqzon.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> ---
>> Changes in v3:
>> - Move out addition of proc-receive hook doc to 'git-receive-pack.adoc'
>>   into a new commit.
>> - Add a new commit to move out the response generation in receive-pack
>>   to a new function.
>> - Instead of die-ing on non-zero exit code, we modify each reference to
>>   indicate that the hook failed.
>> - Instead of correctly listing out the protocol, link to
>>   linkgit:gitprotocol-pack[5], as the protocol also differs between v1
>>   and v2.
>> - Link to v2: https://patch.msgid.link/20260821-758-introduce-hook-v2-1-e90e2f7ac2cf@gmail.com
>
> This has some interaction with Justin's pluggable writes series.
> Please help sanity check the conflict resolution I did near the tip
> of 'seen' when I push the integration results out later today.

One more thing.  'report' is far too generic a name for this.  There
are other features that plausibly would want to create their own
reports.  It is understandable that one can be blinded by the
thought that their invention is more important than everything else,
but please resist such temptation.

Thanks.
