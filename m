Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7A126BE0
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726948491; cv=none; b=ZVDvluPjKNkwH6iiLsQSW0V2e6t5sFsfXOmodUGP7hMHw+EvBvD+wANYA9K59FqEKjeuoIEKSgCnWS2Yj9DjT3/Of9aPSXv2+Q9JMoWEHvVfGQoD/OYHJotAmFCEozw8Yk5z5juwriJhABiPuIZ/FFO0QRcC1P0d+H9VYkZm22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726948491; c=relaxed/simple;
	bh=sxogt8oVbic7J5bw2W48rPKei8ntLKIjySf6oWygJL4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HU96knUiOmx0qq9kSneSiT/kRiHcojql/uO0+nWLMtaIvgMcUK2lq/193wwXOfC4cCVyeGfVvGoNu6ium4HYzV6UPlJB0ZEgrz3n++adg4DTTGXXnQyawLhVfiSea8AVbCH90+kLBVSLki4/+hvWc+ITv5MsiWz0isnXpiQ3fwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MsxmFYOa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mT3BXW8n; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MsxmFYOa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mT3BXW8n"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C302113801A3;
	Sat, 21 Sep 2024 15:54:48 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 21 Sep 2024 15:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1726948488;
	 x=1727034888; bh=yQ6y2U7yBC3ZzoU/hyv5UObqpHV9VQ/AoMVfbT5/QIg=; b=
	MsxmFYOa1fDTb0DTFDf8tsKuhuJEAw6is7STfOVnwRj0pVq82xj3PNCGyLjkykzU
	0UAS/cntxO2vMDYTDYWVxAc47iwQ2a2dKyMxOeoK9Aae2vlGJwhU7sb3GSMMef1o
	76TcQl0ymxTzQLZnPNvE52VsQSOzwxD6qM5FjFQ2Lf/3ViEqNX/0ZSyOeP6sba10
	VUr/XnsrHlPnl+QSjSLSdZjkIV0jmuav1C8wN6zt2p4Sei+2Mhstr70uCFc9cceW
	6X23Gksp8uIqqObdqSvhC1yxmVjHTz3xMLakzSfZbzK7vy+pTrtHH8KEvsvRckhr
	bUyNQNfa6FcFOCExTO2KJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1726948488; x=
	1727034888; bh=yQ6y2U7yBC3ZzoU/hyv5UObqpHV9VQ/AoMVfbT5/QIg=; b=m
	T3BXW8n+BizXTKoRE2S7QFOSYdk15QXVKvFEuP8PD3xSqJho3gGxRxpSdP7rhfuf
	XBFz5o7fi7Gg65GHBjVicDw0sU5OfsmnnxaJTY8o/qLDRQ7OA5+pqxRtkHmPYWoV
	fb5FhpsseSmUVm3fpUSVak2pBGUVrd+z/OD5z7uUW1eQi/7Hz3ZDdg9nkR4pgiEP
	nOYgAxrkYbP0HPrXqM42YUYnVTSdy80OAbTT7qB6M+kEJOAfuCJBidJXO+eD7tiA
	lCO6eN8Xth/deFkXK4AdG/6Ttv2LCug5XrzDlsL/FVsk6NA+WPQ++7PC18JYc+gk
	7rxc8XUwxmfslccpP/UVg==
X-ME-Sender: <xms:iCTvZgQx05dVteX7K_FT2LyPuXNtIYahcBUxO3lgu_83HPBapFHAInE>
    <xme:iCTvZtySm1LaHc14TqkL6U5744_M6voFjb-KRJto-3qbVn0IDi5uuSA0bQgRjhq6d
    hMPacJi2JtrxsjVpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelhedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhufhhf
    rghlohhlrghvohhishhivghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshdqsggvhi
    gvrhesghhmgidrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iCTvZt2HXxSj-5f6jGq7nHkXanWcPy6EJc07ojr_iR3JbMLUNAMo2g>
    <xmx:iCTvZkDTXKvG1cCYqcuOSCjr-Y1xmtnAMAgklwyHXhPx1gsgE-xfhA>
    <xmx:iCTvZpg2ldd_g5yWNStDlrH41INcbLmmuLl92o7GWFuJjH40BwKOIg>
    <xmx:iCTvZgprm36r3-o6Y9cuKSZuJJRdQ3hSC3VNt9BKyxBGPUsp3xGb1g>
    <xmx:iCTvZpcAB22lLBabmNHdpGulSdE_HuA8MjNoom7xbcpipX0v4Eyh89Y_>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 717B5780067; Sat, 21 Sep 2024 15:54:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 21 Sep 2024 21:52:50 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Ruffalo Lavoisier" <ruffalolavoisier@gmail.com>
Cc: "Stephan Beyer" <s-beyer@gmx.net>, "Junio C Hamano" <gitster@pobox.com>,
 "Jeff King" <peff@peff.net>, git@vger.kernel.org
Message-Id: <7601dcef-e256-4e20-bbd4-75955e5a45d5@app.fastmail.com>
In-Reply-To: <20240921150855.31574-1-RuffaloLavoisier@gmail.com>
References: <20240921150855.31574-1-RuffaloLavoisier@gmail.com>
Subject: Re: [PATCH] am: fix condition check on fseek
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024, at 17:08, Ruffalo Lavoisier wrote:
> if fseek() is success, return value is 0
>
> Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
> ---
>  builtin/am.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index d8875ad402..a7727fd4ea 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -589,7 +589,7 @@ static int is_mail(FILE *fp)
>  	regex_t regex;
>  	int ret =3D 1;
>
> -	if (fseek(fp, 0L, SEEK_SET))
> +	if (!fseek(fp, 0L, SEEK_SET))
>  		die_errno(_("fseek failed"));
>
>  	if (regcomp(&regex, header_regex, REG_NOSUB | REG_EXTENDED))
> --
> 2.46.1

I don=E2=80=99t get this change? The function returns false on success. =
true if
it fails (not zero). You want the program to die if it returns non-zero.

It=E2=80=99s hard to wrap my head around=E2=80=A6 =E2=80=9Cfalse must me=
an =E2=80=9Cno errors=E2=80=9D =E2=80=9D

If the original code has a bug then I don=E2=80=99t see how git-am(1) co=
uld work
considering it presumably always checks =E2=80=98is_mail=E2=80=99.

--=20
Kristoffer

