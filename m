Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C82378D70
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136762; cv=none; b=ovw1hFBotunKKAnQDJkMrfQEj60CMD05RWUDf4fKyLy5ek5B/jUZfNbLh1fg11Af8wBGA2WjTtWL1hA/tcFCWo4MaapzNt4OdoYDlC4/TPgZppOuRE7VBdntUEo2/MzB/va4QMTj5A4ZHZuC6C1zFecLtj3V0bpUnsnmx2YSzlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136762; c=relaxed/simple;
	bh=4PAfOZEzHcqikrPKNITqzBRjGS8gh7jo/em+702tI3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=smGon2r1UY0sRwOKiiR1wBxAuiC8aG3v/npiAoyc9xA9+1P2tUyfYttxRbLKF25p96YSpTq/HigNL7xDOo1XxwnEx3Xg0IPQpOTEjP431rjsrm+TTSTlCvdGrdL3Bu9X0lnmlTMcas6hWrd0gfw1q1qzTqYDQurMiSois4EJaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W+aAvjjE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixr3h4aY; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W+aAvjjE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixr3h4aY"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 906847A0162;
	Fri,  7 Aug 2026 17:06:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 07 Aug 2026 17:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786136760; x=1786223160; bh=4PAfOZEzHc
	qikrPKNITqzBRjGS8gh7jo/em+702tI3U=; b=W+aAvjjET5r1lsiq7EDOfHHSDL
	LuW/GHFJLGtfkZ+lsVtVtN8eO9fnDu5XGntG0Bx70Bj2i2YjURuMKFLCJhG+rvPO
	NNPr9gTi7NBGXOSz2tPHDAks6K6MkOTngm/BKFUwO1lathnxOfrs5eOaV4Vc9ttY
	XIBAn5JmDP1Gq8FBFQNw74594oWmGY3LkKVZxdMQgnmAFAbxJuHJZ0iHTJ+SpfBT
	XjpmYz8YynuiwkclDSI1YxyrFXJIYVFNsryP8YfkYWPiJrqWwEXZaRQe0kXoDpYi
	A2ZVpHtNIUKAyVWXeB10Fd5FlvG6QHxsWq8FT+lpSCvQgQ8dMAwfM2p4XuPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786136760; x=1786223160; bh=4PAfOZEzHcqikrPKNITqzBRjGS8gh7jo/em
	+702tI3U=; b=ixr3h4aYAmfiXmB6waAGO5ntBrxekaDU1wioPMxnDEHdfob1Tf3
	kBHl+lSX52WRIjbQVxEaRGQnveaE8WtTwIr3LwrM7MK2hOLvgrP0y8BhG3y7FSlg
	4iWPyU2UOb5//5+rrPZx1e6maX5Ya5kKz5UYp8Yqk0K/oWu3lHOAoHErLeMbNvR5
	HIOAl6xtPIbVOoL5DXGVydO8QV11NfnWc/yxjo5l8vCmWmlQJESx7Tbx8nNazduY
	1ojoJFDzJMg7HuoykcV1RQjKVQGPXnkjgGJFoCOSgdHV4cVOWVHK0oYBWct/TLpY
	861OHPLh90FcRk/eKQT0qQh/2GfDl1s+NEA==
X-ME-Sender: <xms:uEh2aonsaJr5r87TLnTWlgh2m_OSwTRO9wkNrv8omulkIlgu85kWFw>
    <xme:uEh2avTDTZEiDuRShcBfPwIYmTWE0FIMH4EYvbfR5ZE4POnnZvPruYpFkwkQ9K6XT
    -7R83wtI2C67CqwrWd_OtxLcmbZH947nsG-4wyac6-weBmjy4fSvw>
X-ME-Received: <xmr:uEh2akCvly1cIY-wLQESg-d7OnOWQFNQKf2xaexeoGqQX1cPoKWmdxgwU9AgD3A346wcOlV0YltX9Q_E3sEERb9OT0YsWgkPUA>
X-ME-Proxy-Cause: dmFkZTFXuuSsBORLnAhas12xLcXfNhq6UHTW1HLX47FJ+BTmnZxH5Z52WHAi01IoeyI38O
    aHbUIEmQPuRjyrFGEW9sdcWOFC3cEtS3YmwQH8M9jjSVaaY2WsamILgYcAWkErjs/gEjyD
    ccrOTaRX55AKMnJ7mMN0Vq9Cl2gnZNCsi7EJYmOnu5Q/DDZvJKOf+kGMeleCvPp98ZcH02
    3r2TOaFaDwOerrrbpgqJzzYxI9Jk3saoNqni5fW6Y8SMh6Zx/NnU2rLMOlaEtTdTP5y/nK
    pW1z2XMKQsFego7csttUxaqm/BqAMUzBQkAegUlId37qx5EcbQq0+3XlJXZbqnNtU5GBcp
    iWdMxePpicfxuUrR/t/J4b21MX3DF52q0Vj+FBQboa6zSUo3uMKkpMZU993jgDWlkMKVY4
    7nitFrnagwVz0qalZRGvb2twhzIOiN+KokK/Hpn/IWZqd2RtFAcVOPOyPQQTIs8WaFiky5
    ntUoyEtmU+ZF0exhgBHdj9+M6FKqERYboLlW/wHMOsAEDRVUPiGK/8P0ECvB3JuOUyShKw
    gzwDgribSxmAlFFCj2Lgy4DKr3osVm8taoBR7hJYlvFbr880O+7kpSbrvkXcP2OP31+6Y4
    sMz2NsSCp5/KmeaMmv8Q9NsQnEOXdMDexUkCrQ1F5NE+WDN6+oR9cfZIBwyw
X-ME-Proxy: <xmx:uEh2auSh06j6bZTLDvfCPRwY-mM0Hkz5__uckXxPYDoTB_qLe0eRpA>
    <xmx:uEh2aqpBIGYi1QLs99GIkAACv3kXJFsL9KLVSpaJfTGw9eTQepSx6g>
    <xmx:uEh2aowyBHYd500dEA1XXdWiwsTX8PpjIaDLXs94SI2Ppe3F71wA_w>
    <xmx:uEh2anJXFnTvNjl_YyjikAfTheHJI5oXC83TJ_hxhsU90cWcl7dTIA>
    <xmx:uEh2avY7nuCbidnO6CED6CKLWd--0s0Cn__KwJXkbLJIAUYAV-zw_nzt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 17:06:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] odb: make packfile generation pluggable
In-Reply-To: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
	(Patrick Steinhardt's message of "Fri, 07 Aug 2026 12:45:06 +0200")
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
Date: Fri, 07 Aug 2026 14:05:58 -0700
Message-ID: <xmqq33wpej49.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series makes packfile generation pluggable.
>
> Note that this series only makes those parts pluggable that are required
> for the transport layer. The other parts that relate to packfile
> generation as required by our repository maintenance is kept as-is, as
> there is a bunch of options there that are way too specific to the
> "files" backend to be portable. This should ultimately not be much of a
> problem though, as maintenance itself is already pluggable in the first
> place.
>
> It's a bit of a shame though for git-pack-objects(1), which still isn't
> usable with alternate backends. I tried several times to find good
> solutions for making it fully pluggable, but due to the backend-specific
> options it's an utter mess. I want to eventually address this though:
> same as with git-refs(1), I want to introduce git-objects(1) to care
> about all things ODB. And as part of that command we can also introduce
> a command that generates packfiles in a generic fashion, without all the
> cruft that git-pack-objects(1) has. This is part of a future patch
> series though.
>
> The series is built on top of 2c78326f81 (The 11th batch, 2026-08-05).

With "--no-ref-delta" thing in flight, this will not play well with
what is in 'seen', though.
