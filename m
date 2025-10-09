Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2932110
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760053732; cv=none; b=Ygzy2zBQLjQLuRmorY5efI4hcvTRe7CH6TImcajDg3MXEdbH1Oy584kLnP7D3vwYNJIz103jhUoK427VqfSzzmQSWu1TUQPCtZM9czwpkF7AcL/Qf6qvPCiIIcLGTLq+PYgve36X3/Iw57UxiNxEhuN/95pljOBfJY7Wq14zDeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760053732; c=relaxed/simple;
	bh=1ckBzbBqk3OlkWOa++is7r4hrpmEEGCIfQeIIVpFg6w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Umv+L2CnVEomEf1/EenDucSoyt51Caob9y+EzJdy7+pV+6Ha4/mSAZpWGSMy7XG8h/F2VF7MzX/M6PIBA2HZ0ox3sLG2wLHXPfrhmfoaaBCFZvHqRoLo7p1UB4yvMI6/4C8m5UGyjShyQek8zxlXzgKy4YHa2nXdtnsjKzBTsaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=iPufLzLf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lqUHP6vv; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="iPufLzLf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lqUHP6vv"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED3D51400183;
	Thu,  9 Oct 2025 19:48:48 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 19:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760053728;
	 x=1760140128; bh=B/KUoLStCc9j5yYar8IE7bWlMcXD9SXKTJE2t0C+bW4=; b=
	iPufLzLf8Koz/N4p8jXLSnrwzmO5nqbbLANFZQWddL8Mi1jp/QIfWzHuzoNTSYjS
	OC9UUZp6UCQKl8VMRM9OyExVKC7u1x2CWrihO+uFqATl758/jUYAIC1HW4m2Jl2i
	d2rwAYsbanPxOtnmpG+KEusymXiaVpH/KTOlPuQSzrMQob4/6kVaflVaApVZVRpg
	wI4Kwz6GeXD7NgCbcSL9of6mW4f61AtDduT8uEvQvpE6mGZp33rpoaSxD/y6akpT
	xQLWyWppa8kq5426NPqvExBHZojJVJJTLgyZ6mS1gOreJKQFIX+Us2NKp3a9/DUm
	JPS9TY4XMB1zlmgheE8xoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760053728; x=
	1760140128; bh=B/KUoLStCc9j5yYar8IE7bWlMcXD9SXKTJE2t0C+bW4=; b=l
	qUHP6vvhxf5ZdT3qM8Yack3+oev6EuIWiCZSlitdsSK59E6windlLJRhCc6+nGXi
	RNZMrAUAa4HEDcR1I4+lIYNnuBkaAaQDSBSk/3erfprCmdYrfDXoKiInG8tJisNs
	jMdpoT31PcDZaD2dcWbjkOuG1tgLyi5slAh1j3RqzqXXuEwYhr9UH93JSD6gCB7c
	mnwQUo12r2oa5wNvbtobnlM2dywY7/LwC8o9ksWaa2wW9ZgEhYQ5o3+EBmtPhthZ
	ZRKlFtFmH51YIIM9bXu+pLTBI9wopNXKwc1B4eCv+8f9li4EhI82FfOlvddSK9L9
	DiEJs6lpUUkMIcZdmiQDQ==
X-ME-Sender: <xms:4EnoaH5c8tRKKt3333xWpesw6NmgBWduTUZydW08LKIlcLVlxzF5-KY>
    <xme:4EnoaHtpAc653kUfIQob-ihaNHME-piENrUsfyDS4bgHu08hQF_6A6rK-28l-QNrY
    D2rW1_ZT5cpd3DihuX4vhy3et9mqPxx_xRkyMwfrJZHOJMMTwJQQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4EnoaGXVF1Yr3Lto-qdRxMyWhXen8OUN9kyDuDEYiO9AYE-P0Zv4kA>
    <xmx:4EnoaKUdxUmF_iMK1pIrBDhicHqPFsbXtve8lJXhYcvOqXiSSOZO5g>
    <xmx:4EnoaNdYDVYqrPxwIyD70Ox1MqaJJBw6YnwpSxM18KL46kc0Mm7Bpw>
    <xmx:4EnoaLV-RQSmiT_m7oMpuK2y7nUC30ZbiIUXMpkymw7NznbQYFrYwg>
    <xmx:4EnoaJwapoMHH3e4FFFdydU5ro4QgYnaxplJ_zh6xrcmPBDr2NScsZT8>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A4FFF1EA0066; Thu,  9 Oct 2025 19:48:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1uh5GjCrGN-
Date: Fri, 10 Oct 2025 01:48:28 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <02383db0-545a-4f4c-9fa9-30a819a30de2@app.fastmail.com>
In-Reply-To: 
 <3f3e5a87e834a6cd1d5d7769bdd2c0dcfaa4b6ae.1759698702.git.gitgitgadget@gmail.com>
References: <pull.1969.git.1759698702.gitgitgadget@gmail.com>
 <3f3e5a87e834a6cd1d5d7769bdd2c0dcfaa4b6ae.1759698702.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 1/3] doc: convert git-stash.adoc to synopis style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 5, 2025, at 23:11, Jean-No=C3=ABl Avila via GitGitGadget wro=
te:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> - Switch the synopsis to a synopsis block which will automatically
>   format placeholders in italics and keywords in monospace
> - Use _<placeholder>_ instead of <placeholder> in the description
> - Use `backticks` for keywords and more complex option
> descriptions. The new rendering engine will apply synopsis rules to
> these spans.
>
> Also do not refer to the man page in the description of settings when =
this
> description is already in the man page.
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  Documentation/config/stash.adoc |  29 ++++---
>  Documentation/git-stash.adoc    | 134 ++++++++++++++++----------------
>  2 files changed, 85 insertions(+), 78 deletions(-)
>
> diff --git a/Documentation/config/stash.adoc b/Documentation/config/st=
ash.adoc
> index e556105a15..7fc32027f7 100644
> --- a/Documentation/config/stash.adoc
> +++ b/Documentation/config/stash.adoc
> @@ -1,19 +1,28 @@
> -stash.index::
> +ifndef::git-stash[]
> +:see-show: See the description of the 'show' command in linkgit:git-s=
tash[1].

Okay, here you use 'show' and not `show` because this conditional
attribute will pass on `show` and render it as such, not as
inline-verbatim =E2=80=9Cshow=E2=80=9D. Bare 'show' is indeed better tha=
n bare `show`.

> +endif::git-stash[]
> +
> +ifdef::git-stash[]
> +:see-show:
> +endif::git-stash[]
>[snip]
