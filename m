Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8B402B9E
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152766; cv=none; b=socPk15v6VOzKc+LMZgMX985ReWcp2JynkHY8HN8mO1SOoXp5EdIv8OZHA9N2htoSxOIbpSN/R3Yt+q/+M5bzXqQsYPnCf7U+ePEUo8hgjd+mNDFxlsAJMyT5XliCqz/RJDS273zsdBTiz2QkxTipYS2ZNHazVSRHcoGIjDj5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152766; c=relaxed/simple;
	bh=KZsft9DdjQHj8zdHHQzLMTtSSiLMFm72/ESaQpDPdAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W8UBFEFZ9tLF62cRJ2DyVT34hM9xObRfrnH6Gg3tgTxMLIsh00WjAV720OhYLPJKKRSIISbTx6zFe1jChTQD9QWz/N9FKauS2IX2EJr0iSCPRKWj7I2Cc4lXC5lwv0klydfNEqU+e27Y5xc+WJ4HRNZm/qULTj75/jOiQy7UNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p9nPvDSR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K6l/F/SZ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p9nPvDSR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K6l/F/SZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 323897A00D4;
	Fri, 11 Sep 2026 14:52:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 14:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789152762; x=1789239162; bh=CFcYbSXTpj
	/MvMoAH8x1lEWl90gGp36K0SO3neqrIdk=; b=p9nPvDSR9KqO7ijfVkCGDgEelI
	kjhOgq/z909neepqmkhJy745pxBk+yDBC/E/i2Tn/4UFaV0hoxPuW4YOW6Y4p8m3
	eI3x0SaqXr/nUtb0wGfxllzhUA5zQ9DvpDDWl5ftWGfx/N0hRggjunZVzBafICZb
	iWoIGILuKDjHPCBNvqgftp4Gs8hODHhCPQCDaofaE77sj5P5z0YDr9VYy3sxJ2Xr
	4cqiun2sLefFFi4x4wqwfR/pqLgtV4XEbGvYBGTGgm8wcyCShcjEiKWvoBzjM4sM
	RyLc0Z+PtUatEdEB88sX5I8EBs5CrpWsz6UGLYfry/9p7gOT9h3kOUHbsgIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789152762; x=1789239162; bh=CFcYbSXTpj/MvMoAH8x1lEWl90gGp36K0SO
	3neqrIdk=; b=K6l/F/SZJb+rH/t+VTbf4SPQowkT7cvPNcCf8nJevJpWButha8c
	FXl3FtYPcBqjZNLHiM1U8ax7fZfTe+KUTi1/h8ueIuCduBSkxYKNuJy9Dcx3qvQi
	/0ErrhuzNhCAekaBFccRrxdWi/wsiN8JahIb9u1SajbRAjgdUpisqpwnnrF8pbED
	oHu1JG0u71XjqZB4CE04LcYjJcL+eGy9pA3yRbjtQnnPhtRqzQdDYFmvibOEMNpF
	Yd1ZGU5pW7cNClgew1W8NlVviAQcQZy1ePF/ZG6tfr/D5J/p9GSj/O2NXJzD/3hI
	fCMYV4EYKPh46uO1XoW5K36tZQzn+/gSdqA==
X-ME-Sender: <xms:-U2kasEgaJF3RumBiFmQ5SA7OWPD4ez4oDd9bYV60qNDruP-yReTxA>
    <xme:-U2kasUY3mnNj9IguiA2K_yaAPHo6hSxlDgisuZ0nnQ7nZsuHBK9weieIzK5BqUqg
    FhWLUOLuCT3E47XApwIaW1Wimnjmi2p_X4MJfYYSluDEt4C-LL5RV4>
X-ME-Received: <xmr:-U2karKXV7cyx5-T3qFJQlX2V00aluU0_Em6xITbvuqiY45g8Xga04gryuD-oi5ZIsL_BLhJ3KJEbUytFLQpgTYRAPjamcT0QGUE>
X-ME-Proxy-Cause: dmFkZTGoqQdwdhD0C1rSIKjDiyvTYYArMGxJntMve6DwtCOZbl5OFpDufEfnusw5Z3WcAr
    WZkrC7LPU2A4LvNnJQ4Xrv8YIAUXX4k3VFWTnVURXKmydiKggMrzbB+0agtxYcUzxy1/Uy
    /Tbu5YL5IgJhVBKFUDjc5ssax021QXXi8f16lrT9IcpSFnmPhYvYqwh/hGo98vyMVi6ANz
    AMljepBJiRJOEKxtFW4PYSJ+7bOUGdsy8OSFQ8Q0APmhsLfg3bsFtHkCXPJpJ58Nv5JZHs
    GZ5RAPCia4mNCIVU9Xi5fa9QzRo9BcmbCsfc80TrsHIpBHnX7UQzfEOK0IF8PFDqow95ck
    i/RdvRp6ksgD2RF1SxLd2GB5c/P0Qekisw/vSvVKziMfpPKpzJJ/n89hu66pE8FT2O/HRw
    6sKYtUmLG3WAcrnP3dppaIAYEZGQY11p9cN9dwgYcECv5cYruE/QoNn4FyPuGfUzO9L2Ad
    a7JiOPLg7cJ5s9GqfulOOUJzoTQW1GDUAQmS9HXAeGSyJTln/fNp1clRgMfSW2Upo8u7de
    9tnMVkqtFWvxCwR27BKWsxBRGQ7fQnqE5d2Wg6zEoIhvvM9QAuukIY56KMsLw4FkqIp1tl
    rXkTY8ln5OKiwBWsfyirFSO89T29DYQHhadvpF1t3K1R0BZWswOtusHLZ6/g
X-ME-Proxy: <xmx:-k2kas-Qzc9LZrk2Ak0CjiOQDEsak_hE1cnwGN71tYMA5-MgsG0E-A>
    <xmx:-k2kauLXtdghbMFsS0_Kzh9vL94n2FQac_jEOKzr9A4IuC0Viosgvg>
    <xmx:-k2kahlFUPSLtsQ9kJj-4-0n35-slIADhsRpG7llmjLpelPz2X3gbw>
    <xmx:-k2kaiP1OA2Lsk_EHY9_ibMZgblr1RBh3NXaEdjzUwHHI-SpgbDvIw>
    <xmx:-k2kamqQkEdpuGFaLOMIQ0InYmo6OHINu2RSHrDQF-9c_r-jqKpdW3b7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 14:52:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] range-diff: add --matched-only to skip one-sided commits
In-Reply-To: <CAHwyqnWkEaQHsp5GtYGL9qg-FYA0Ngt_+omdh8jmw4KfqfX6Uw@mail.gmail.com>
	(Harald Nordgren's message of "Fri, 11 Sep 2026 20:48:45 +0200")
References: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com>
	<xmqqik4bbt9c.fsf@gitster.g>
	<CAHwyqnWkEaQHsp5GtYGL9qg-FYA0Ngt_+omdh8jmw4KfqfX6Uw@mail.gmail.com>
Date: Fri, 11 Sep 2026 11:52:40 -0700
Message-ID: <xmqqse3faadj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> I wonder if the implementation actually can be more like
>>
>>  - give "--hide-left-only" and "--hide-right-only" as synonyms to
>>    "--right-only" and "--left-only", and deprecate the original;
>>
>>  - allow them to be given together, which will give the new
>>    behaviour you are introducing, i.e., skip steps without both
>>    sides from the output;
>>
>>  - give a short-hand synonym, "--matched-only", to truly behave the
>>    same as giving "--hide-{left,right}-only" together.
>
> Seems like a big change, and deprecated options are a pain in the neck
> because we can never actually remove them.
>
> If we decide to go this way, we might name them "--hide-{left,right}"
> and just not introduce a condition that makes them incompatible. Then
> "--matched-only" would be pure syntactic sugar and wouldn't even be
> 100% necessary to have to achieve this.

Or we can just keep the code and fix the documentation.  I think
that would be much less impact.

