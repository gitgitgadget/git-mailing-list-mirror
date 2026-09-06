Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E6625
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788697878; cv=none; b=cktOyjfurLX/ex821CXu1BuHPJRtt1tB/nSKOz12MKzKLDwOalBWrBrrDzCOk19ldYCl+3BZRggGWc4QGJ+v9kVfHh5K2xIpbrIcYe5iYHPkTQkYw0+ySFHzSz5Wk3cstroYherafcwwABRJwhmaNegHCtd5QhGarN9XNFjzhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788697878; c=relaxed/simple;
	bh=1U18TaRHGFmRBmQp8nkkBWi4fmqHGDe8StML0+l+pOA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NROH3X7IddF/xARehDBIptD+klfxTTNWiQG1LNm3T/D1y9IxFelnpDZnRTADsFFbqzAv7Dj0/xGu0ffMAyHdEFTHEDSRy7y7wL6GoBsZFnWkq6ljJS2T69aeaKmGswjeo7w4ZMAHq5cMg4n+38/Tj7DFCehvjQFtd8uX3aR6rWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YZ33N6Px; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wOlPZNpY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YZ33N6Px";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wOlPZNpY"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7F791400089;
	Sun,  6 Sep 2026 08:31:14 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sun, 06 Sep 2026 08:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788697874;
	 x=1788784274; bh=8zjYFYZzYlEJJaFDuORJWv+nIW7lopxHVfsnp+RwwfE=; b=
	YZ33N6PxiHulonlnGh4nnyUecM4ViRDz6I0WmHelfBPNFS/wg4KP77hTAlNrCWbn
	imyxbALcOs38FohRMkXcPHebeftLUNr6VOB2Xq1z/iXTnFyY50FiFqiU5Kx9cJpR
	kV/QzlZLbLEljiCmea7ZCuy0D8uP9qz3ZxzWpUnx1MNfGaOmJtMoGLAHzeUBjvgp
	V+uVfxrgTNtija2IAeeNpsawxA5iDPLNzryBJPwZh1nEMF1fTEqPGaz4h6QbzCbg
	ruCtsW3gnB+vYjbIuu1qUVELP3vvmdao0zdZgbE1b32O0Xeln2ckK9WIWjp8bfSq
	6oiccEgMc9L8kBnlk3kPLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788697874; x=
	1788784274; bh=8zjYFYZzYlEJJaFDuORJWv+nIW7lopxHVfsnp+RwwfE=; b=w
	OlPZNpYMT9ViCzcw+jYrheouB5/IWZ0jxEIYswYU/3H8m9rXWHv0OsTcNG1m/QBq
	MUDqCSMx8jHbyWWovIKJB0wgKDllu/KYW1eH+DVDu2b7LyhOSOS90yituLiDNCnM
	dtT9ZTHxvMRA401tcMfZQf+tDaNIVv9j8ZkR7+VWFamr3vsTgDyKaN9QhEVQPcsa
	pMEXDGXrnWy1B/M+XocwNXX+oFKieapZfqwqXoRMcQfn5VlgGUlirjtPTyMmkj/n
	0pSNj/JzkqQ81BaFUnR7QvXmNDMjtuR06Tml2F0ZEqTctWprzNW05hQ8knmMjtPl
	lYMCLChDqKi4pFC0qUk/g==
X-ME-Sender: <xms:D12daiKOrz2wTarH993keGHucJsM1jA2Yjgm4Cw6CTB7HgdyuyNFiqg>
    <xme:D12dak_kWFzwEzajX8F3-40b4vpRT6KmRwZtr8vrc0ghEICSGo3bY_by1M1RzjN6s
    2zsEUoikqHeeGs0yE6rqbzAsi11iMdcq1upJa040AKXdFJulVgkX_U>
X-ME-Proxy-Cause: dmFkZTErR3XSXp7lDk2XihXr4GPu+sS1C1CgR6t3XGBmXQEtHEWI2parZY3GoeqBdlxG36
    ztoCVwHZpWYllrza1WelNUFT15AeGb0yvp5gdU4JdQmFB4Ax/RGpER2OXW63q1hKC/BO75
    zlWVcfDCfaOeK+YlwQWtPdRmcVAVDVtvs4NYmZXGF76QB9q69lKCKpezX9ZJ/iKmSq3yPT
    I0YhXBtbeqh8+5pne5C9ZjNVl1xIS1tFpVH8gUmP9Vvboe1YlwHkc5++hJhgR9yT4arZW5
    N02tKgRRoc+3tjAMLLNLRCYBb3WuuPFYb1K8wKXDyj3NEL6xK4ifVBNOIYKrIe1bjPaEjF
    NGdFmITezqJQIXbQIYzs2j7Rveotf5ylx3I4fCGJDdNAmpfd6efol33lZZYQ4B/2ex0Mq6
    oeIX5rvNWOYCwLi8n5pEEPXBc+6NIV5LtPAqqejsm3ONF3TOAJP2nNbhglGFOM3zXaf7oD
    IjTmgg+JwywEorG7JIKYMqdmqTP/XTrvmRjL4Mfq3ELyRvtkyJFtBmWf5Hd4ECrI2b85eN
    0H/5hKkzX4c5vn5/Ys/EeIh1Z6Xc53gEIy6HuKRLQZFPUvfZO8jqWVUxC8n8E8M+9ObJTN
    2cyt76of3mfZN4Wrw9ox+iNDQS985/OXt1T8DGArytFzCJqQFe58bWo+9a6w
X-ME-Proxy: <xmx:EF2dakP9h94GkN-VwEUTECmVTKwYvgT_QvbTZv5OiXaaDMfK4LyD2g>
    <xmx:EF2dascx1gZJO04RWFa1RBiVPYAGTmsH-urlczA727FfqNgXo4Cmfg>
    <xmx:EF2darW4dQTorgbWPH3BegPRN9ROV3ikuXpRmk__Ps6MFZ6Gz3WYLg>
    <xmx:EF2dasic6uqQUU5ZDvWRY9xTq2iZ7QC98HiV0CyjEfxprPfe6_-l5A>
    <xmx:El2darjAwKPHDU1ilEZ_Hf435cklgwqR-PwvuTh-Wtp1DWO3zjzInPFK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 067D122C007F; Sun,  6 Sep 2026 08:31:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABzAPUHUW1Mc
Date: Sun, 06 Sep 2026 14:30:50 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Tamir Duberstein" <tamird@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <63821ef1-1234-49d5-b359-8631764457e1@app.fastmail.com>
In-Reply-To: <8f3bab63-3b37-4492-a39e-95e610a15a07@app.fastmail.com>
References: <20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com>
 <8f3bab63-3b37-4492-a39e-95e610a15a07@app.fastmail.com>
Subject: Re: [PATCH] ls-files: filter pathspec before lstat
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026, at 18:02, Kristoffer Haugsbakk wrote:
> On Sun, Jun 7, 2026, at 17:40, Tamir Duberstein wrote:
>>[snip]
>> Assisted-by: Codex gpt-5.5
>
> This is more of a Git for Windows trailer. The Git project doesn=E2=80=
=99t
> document its use.
>
> An aside here but these trailers attributing specific LLMs feels like
> etching =E2=80=9CPeter was here=E2=80=9D under some table. What benefi=
t for the project
> does knowing that it was this version of Codex or Claude or something?
> A link to the prompt/conversation would provide provenance and show how
> the LLM was used. But three years from now, what information beyond the
> fact that an LLM was involved (any of them) does this offer?
>
> I can understand the benefit for the companies behind these LLMs to ha=
ve
> these attributions in OSS projects.
>
> I have done the same thing in our company repo, crediting <LLM> for
> authoring or co-authoring or helping with a specific thing. Using a
> =E2=80=9Cpeople=E2=80=9D trailer. But the intent was just to show how =
some LLM was
> involved. So I think I am going to switch to the following trailer for
> our company repo.
>
>     LLM: Yes
>
>> [snip]

The Linux Kernel has since then simplified the mandatory attribution to
just =E2=80=9CLLM=E2=80=9D:

    The requirement to identify specific models used in the Assisted-by =
tag
    provides free advertising to proprietary software companies while ad=
ding
    little or no useful information.  Change the requirement to simply:

      Assisted-by: LLM

    to capture the fact that an LLM was used without tracking which one.

https://lore.kernel.org/workflows/87qzkuahlr.fsf@trenco.lwn.net/#t

See linux/816d9992 (coding-assistants: simplify attribution,
2026-07-01).
