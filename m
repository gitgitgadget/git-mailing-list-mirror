Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2269A1A9F96
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848179; cv=none; b=V5wBeDN42hhL24syLyhpXczYkZB/JrSnEh/nEPNY/M67/9wY/2MuljOJGc/liS2ru/9gQMZsjlg9GYDKXGr0PvihvBOcvYhVIi8hLmigFlIter/5E+MCSfK9quYbi91Hc+sB1jQA7xqRTeaRc5XEA7YWatV7cbCw1CBVFxYbjb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848179; c=relaxed/simple;
	bh=Q1REJRcr5DrgmO9MJl2kUB69yd228E8oZrLNcQhLeFE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XEABJACMVr9VYplI/vsysFOiYN2YoyC7aMEo12gCLhlf5DjtEnra2WtpFv2ZktJn7Yc87QdJKnUY3rPQpukLCi+lnUkI3Kzt21JIBIPmOBXbnxmHH625O9nkhAFjoinZnj0PO3bWhZSy3+V7AGuh8DzRJdfDhHYaG1utDAcDhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=0J/0sWmV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DdoIfhdx; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="0J/0sWmV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DdoIfhdx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5445DEC0096;
	Sun,  7 Jun 2026 12:02:56 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 07 Jun 2026 12:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780848176;
	 x=1780934576; bh=assODK1O4xGc4zf3zg4XfGB5HkeejoE/doMmGUlA9I8=; b=
	0J/0sWmVzpTD0txQwr/RgmVWe6Kh3LjfqVkqJ1UyXXfYJ9JlIgUOW9zLWXOFrwlp
	CtN6hsKOopTzHiyq6JYk/TcQzDCBMGKSdCCDXL4S5aVNyfMAYbnkZ5tjOGgtcSQn
	tQtwWixr0JJ66TUWxSM056p7HEWcMToHYcynn2+8Kv65NDc6r8zmSjGpjeBBuMso
	MhyGKt/zVb6DKnNsQfcGbUi0g91GygNdRCoJCU7hLdMdVg1ves6rKXgwfUWQrgh0
	+egzLUrNow93yiBwIyCzBglMsfqrDkYUlPp8gQD8efy4stvv9mtWQPsjm9fv0/RZ
	iEHUh6gtlJplcKmzdi5mnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780848176; x=
	1780934576; bh=assODK1O4xGc4zf3zg4XfGB5HkeejoE/doMmGUlA9I8=; b=D
	doIfhdx9CHjuVF4TDc0K2ZNT0eBIyf3I1JBoGw1VFf+Dh61vdFut7AEkwotAFoxh
	JodxkUfb14GrJhLlKp6wb0cz9sqdlQjSwuMhCvIKAeoqmBE3bG2lOjOcR20+sGXG
	GXKpnTDKR8PeNJwoFApeRiQcQigFuTeN8GmnS5wV5pXC6DbhqT2Pf4sCxphxZ2SV
	RTssHBv1lwm+g6lIPkbf/BKUcZ8dVV4CHWv/PB9vJkYCZZeFprvfTsVW/vGPk1XQ
	KelCR6saydifBamjVwceH6ZsDLV2oQag2nfw2lMNkjfKiLF6GHuF1KwH2IyzxQ/c
	FWIHeXQJelOicMpqYgqnA==
X-ME-Sender: <xms:MJYlaomBeU9Yp7DCr2qlBX7I4Sfe_RHtRcH3_1doUy9FT3HQ7qyf3lI>
    <xme:MJYlaioR-BTjktCkv3bT8xewrRbbWLaM7e8JkjxqdtmQCjMm1GeAQQMe3OfLaFOzW
    yfSsqdaDvpTwQ_04MFO4xxJcO902bneOXej4hXvcY_PXO9_VKSM-Q>
X-ME-Proxy-Cause: dmFkZTFwd/0oTFYyRAmk+9ZTmtt71HXiO1yS62RbbtjHdyxyNP5MrZibeTj/n73X3XZv1u
    /SGfJomT1vVkVvxW7t5HYj+NFT14AOXrvdz037CtWfDB6fWq85onhLsXr3lLAN3QC9s1mg
    gJWfYervBUjAY0QR6zPlbrK0Zo8KRmkQ2NPtWBQiIHg7pTSJPC2Z/0jEYoAjtGziOJOiGk
    /Zg9wr1bnCZBieO8wgR+L/KZXTubJxgVfZW5DkycvIxi4b108a0vkI+9wy1QmLDJzSxYE9
    TvEgpny3gBmr4ie+ZDdo+BZpuEZTf5MhRAas4s1M7/SQZOeiOMfgEjNzdlmXPoUebJ22Pg
    s/g0lnHDLjcl18bothE6YY+O9MSUrQe0qAt88g4BXfChHk4FksLfdwRVbhvBjiRhpPWmFA
    IYhbQ96QwgO419wGrSG+ldwVE9lA3mhxVKob6IVthJPZQm0CwqpUjksvJ5oLV022tt4wyM
    oK05zzL+LBKt3EI687Ja1xVi0RaI68tsV/1MSeOvpUWjzN/xpHoP2a+xT3gGCkitgmiTU2
    ukxX7SLVGetvH3FtxaHNVp6b3XMD1kKnK331xsUNJH1ea4huKYRbJXZZk7bhiiy8zzKfZS
    wRPP++j2C/N5h86msuhQOQkPsR1CDmTcZTJkP3XYiHLZenCWo33AHG144iGg
X-ME-Proxy: <xmx:MJYlagJkYLTgZbbsREzEKuaMQ3wtkT_PUa8_BBSR2P7L4oiV3LXRqQ>
    <xmx:MJYlahqLXdreCnKKsPR1_oKQ6wYW611r8wQE6NYCT_gvM_L8aWkh-w>
    <xmx:MJYlagxT2wEdtb7cfSR2ZgL3EoX-sIzaBVqH2ASXUhd0xpRXa4z17w>
    <xmx:MJYlatN9C9LWOcwIyrGj1L4FObG0_GxCLmcGBlbX0I9YbMc-S0JKmw>
    <xmx:MJYlagfEpVI-cO5RI1Nu0pQcgs_WQmn07lY4tN1_FCCX9kBnxKb1AwKl>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1223D30201A6; Sun,  7 Jun 2026 12:02:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABzAPUHUW1Mc
Date: Sun, 07 Jun 2026 18:02:35 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Tamir Duberstein" <tamird@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <8f3bab63-3b37-4492-a39e-95e610a15a07@app.fastmail.com>
In-Reply-To: <20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com>
References: <20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com>
Subject: Re: [PATCH] ls-files: filter pathspec before lstat
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026, at 17:40, Tamir Duberstein wrote:
>[snip]
> Assisted-by: Codex gpt-5.5

This is more of a Git for Windows trailer. The Git project doesn=E2=80=99t
document its use.

An aside here but these trailers attributing specific LLMs feels like
etching =E2=80=9CPeter was here=E2=80=9D under some table. What benefit =
for the project
does knowing that it was this version of Codex or Claude or something?
A link to the prompt/conversation would provide provenance and show how
the LLM was used. But three years from now, what information beyond the
fact that an LLM was involved (any of them) does this offer?

I can understand the benefit for the companies behind these LLMs to have
these attributions in OSS projects.

I have done the same thing in our company repo, crediting <LLM> for
authoring or co-authoring or helping with a specific thing. Using a
=E2=80=9Cpeople=E2=80=9D trailer. But the intent was just to show how so=
me LLM was
involved. So I think I am going to switch to the following trailer for
our company repo.

    LLM: Yes

> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>[snip]
