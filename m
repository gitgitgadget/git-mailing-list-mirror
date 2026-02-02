Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707F36C59C
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042084; cv=none; b=Sx2qLh0cKHlf0OYTfzZsnyp5kxHgPgLZ9Atumn7/PiIGKC+5OeZTI8jRzLpna/CYiUTwAnW+aG14oUuTVlBrhfyg1Olsq7fVBIPR5rhPK+LT/A/r+Y9bWA4DBl1OP2SOVmLwHiKEDbe2JkJoTG8MJzXqNc+34A60yjte6v+m4z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042084; c=relaxed/simple;
	bh=6xkYH2cctTSQeYC19bjQfu27G5p2j+UJEX7QwEzzcdg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YvbqVjmW7f20NU02iFdnMQD5OVcOGwTtOoVzvOe0QVyxrHthEPyUod9DiqBfmoNQCsuUOH7uBPRdM7U6M9STFCEXYtqcwVlCUlWWU9TPWGDXu9Dd+D3o05zd+j5zsFW89rZa7IKHv6livd5sBndVu72NMSIk4ct9Ymil22F1yF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DpKZyVqN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPxyb3Ro; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DpKZyVqN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPxyb3Ro"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C8B41D0014E;
	Mon,  2 Feb 2026 09:21:22 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 02 Feb 2026 09:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770042082;
	 x=1770128482; bh=uB3XL0yCOyac7b53+b/9yWaQnxG3+HkczQJI5FHKN9k=; b=
	DpKZyVqNFGwkFhDEAWFCeVS9Tx3CnlaDUxUufAzwb7d/IngsyUocWIjYUMBLtNeV
	rA6M/84sSDyZsQ6DkXSpM64tgh8XoQSj1NvwRhVc1zYH3C9gnbha7C8kSdXLHsj1
	Bzo2Ii56rZtNLJxR7Xhax+kuGUrAxfffvvEF9fB/Tp3FxL1/lF7bNAEGAmoLO43A
	hS6GrqRf9KfaGphiRFqCCBdmdXNG8JJWHImQLeqYHpHtyT7CDjAlE1sQx+T3tQAA
	/3euJAcwq6BTlOMCjdpq5XHuYy1n4ikTq9ekJ1cdnqGBTi5UIEhUPiwGtz+/Fmw0
	LYhLh7kgheOLxITEmMDhgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770042082; x=
	1770128482; bh=uB3XL0yCOyac7b53+b/9yWaQnxG3+HkczQJI5FHKN9k=; b=X
	Pxyb3RoOelDNkYPJxGwUq6Lh4wDadXDd1uDDJB9az1S1FAs3H3vesNPiNJrX9tML
	TwcEl2HJQMKfgR51SC5kylyLDiD2Q3dLhSNwViwquqkkVaLDUttSVdkvvoXa93B7
	X2xTNqmqI3CHlGcsFP8rbbaZnpGuLpeItlzmDVwnLEOeqhzousa5kLKKBGzGGlBD
	6xhPGJPV7P+6W6BSUCgNZ1i44JZiXY/AEOWe351XqKw0s2cPIKt+jurPYbwU4fVM
	xJGlnCq+VheIg7kHgF9bfWiV+EZg7MrMQHA1h6cP4q/jBqs4ip+CpqAufGN+CfL/
	jxQBzD3cy+T8oBjQIO8Yw==
X-ME-Sender: <xms:4rKAaX993KwohnbVrIfSjM5WrQw5XKK8TiHa3xbJ1pkRpOVALoCG7Y4>
    <xme:4rKAaehcRGHAR6HLSZ8HvF_TGksdegX7CaHDADM9UpdRGO1JZhhIxYhsKCIFbQ5Od
    2qC9DBq7Yk7gliO9wHhORHDYHma9X6mineHsUDXpotidT52X-Xx-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpuhhshhhkrghrkhhumhgrrhhsihhnghhh
    udeljedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4rKAabn8-hf1t1783YccpOdrIfhIb7XxsVNMGnBaQtaHqKeBSkbGfw>
    <xmx:4rKAacrel_Zqkbg9MXV38Wf8WdneU3dF-kV7o26YzDk5LsdvzGjNsQ>
    <xmx:4rKAacGNTKwViD9_Z-2wFlhpcaZpKX3Qhi6955dgw3LTJzUGDR1YmQ>
    <xmx:4rKAaQwPdn5Buz_RkxI4-pIA3tlTcXfcOWXRh1-FI-o1dKha-rJq2A>
    <xmx:4rKAaTyT63nqGNyOKXZxrmJO-hFwaRfn-siqmndpHbWgNEZ7VW6b62D1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 002441EA006B; Mon,  2 Feb 2026 09:21:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlDtzHaItADV
Date: Mon, 02 Feb 2026 15:21:01 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Pushkar Singh" <pushkarkumarsingh1970@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
Message-Id: <1abb1fa0-3548-4258-95d9-0505ea446043@app.fastmail.com>
In-Reply-To: <20260202131921.15175-2-pushkarkumarsingh1970@gmail.com>
References: <20260202131921.15175-2-pushkarkumarsingh1970@gmail.com>
Subject: Re: [PATCH] stash: honor --no-overwrite-ignore when updating index
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026, at 14:19, Pushkar Singh wrote:
> The stash code unconditionally cleared opts.preserve_ignored when
> updating the index, leaving a FIXME suggesting this should depend on
> an overwrite_ignore flag.

The commit message should discuss what the code does without the patch
in the present tense (SubmittingPathces, =E2=80=9Cpresent-tense=E2=80=9D=
).

>
> Introduce overwrite_ignore plumbing for git stash push/save and use it
> to control preserve_ignored during reset_tree(). Add a test to verify
> that --no-overwrite-ignore preserves ignored files.
>
> This removes the long-standing FIXME and aligns stash behavior with
> checkout/reset/merge.

Missing signoff.

> ---
>  builtin/stash.c                    | 11 ++++++++++-
>  t/t3905-stash-include-untracked.sh | 13 +++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>[snip]
