Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191841C2EC
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222311; cv=none; b=GuosBnPurNzNWmQ8UakjEcUUIz+gp5SI/O8yrJbbfV2ciYG7l/G2KEjQxz8W3z22lth54l1RmH0m9LhqvtmKbNg1TrSZA7dUrBC10vUI7/lo3v4SPXmzmlP0LqJQKmsvUc2X3knFX/2fBvNOkDUmgiCAW9T/1xVUjdfZCh/I0W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222311; c=relaxed/simple;
	bh=sPltjPZALAQB56x+EnBKh3NI+/HTKZrug8UGqlM6Atg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PPIMUdQd8HWqFce6Jt69kURwXeZz6iyx0zcC8z/k/dXGTkOoYbGQy42rAruQAJ/1/h7zS7cGgA3X1yACn3iZudCYLJUdN+djxYmxBnlcV9RQAC8f4Bb8bvmeF9bDG1gObQXSTZWDr6GZ+8CCvlRpAi59DSd+0MFci2WeiVRZ/YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KMVLxjgl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gRmu0hO3; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KMVLxjgl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gRmu0hO3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 434B57A0137;
	Wed,  4 Feb 2026 11:25:10 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 04 Feb 2026 11:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770222310;
	 x=1770308710; bh=sPltjPZALAQB56x+EnBKh3NI+/HTKZrug8UGqlM6Atg=; b=
	KMVLxjglifbThs5lk+PkZDxVOvfSo2pq6rY++TdrQV8LRCVrWgbHypf62jJ2RBHY
	SyjRUw2jFfxRFVg81MmOROw98SilP1Bl04169GAWXfZKm4gek0k394/nv8cg2ATk
	2xcSIGu5Vz4W8fWRs9Q3f5M0/5o3uONZhsRkTJsc5zSXDB6lvI1JqjEJOfPoL3uZ
	im/YaQGu+1DoWB2hAcIXh41V21Po7j00V8WbC5/KA5AFTo8WDcNjCwOScYJFrrdN
	+mJk3udNwZtzGNFBo0GgB1jfsxX2L7HTC+nGKDhp9Hete+k14eWCvblq0mEDMy9a
	eiCKnXdzIjiWCL7C4o4Kjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770222310; x=
	1770308710; bh=sPltjPZALAQB56x+EnBKh3NI+/HTKZrug8UGqlM6Atg=; b=g
	Rmu0hO3VXyLcuRkXzu7/cebau0BOvRNAfkyxfQagTBR3YWBHTSapSudkpjMNdli3
	f0Ff9Qt+n/9+AURgDqbsRrkFREYa8vq7IEek3CNu5g+FZLKM6T7v6ULKdPxbwnK/
	4LpbAoZOG/aG1g4MICFhAuMoR3RqGavszlBwH93U2C+rO9zIKzvqMJfoEN9KUaI2
	mU+sN95Aa91PG7bpLCUrVKqi2HBfTjFJ/JbIHYsCy3LPp7Cudivn8u/NM8cvUPOn
	1ODlvIwjcMoQI4p5YrPdOCWukgmFxt8CYKJRmME2zI28YyFBFTcSFpvIIJH1oyGy
	gk6l2XDMcgL5LDYytWiTA==
X-ME-Sender: <xms:5nKDaXNJ8ISET13TfwS4rWzjQKeMOerr1JjkhIzXUEP0ijXia3-7eHU>
    <xme:5nKDacxr38dxtqNb9Ai7WouLS8qsfATdav3p_fI7OhFnPc587WqKSbavmBnY96WOh
    3n8GIaSjEKx3qa5yVGnlS9QmMLHV7yem8sm506FJwycuWrFdNU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:5nKDafIPFjkxJdthNyi8LwegP2ZkWVcbLbGecjgO1Qr7YTk9CdCdPA>
    <xmx:5nKDaa65mpiUptBuAJeOBnOX5E6H367OOmw9MN3S_GIAdatwf6h5yw>
    <xmx:5nKDaazefHeuECyfxiKkV3YW_k5Ym2fvt-mltr4QiSf0oiy-mDLhMg>
    <xmx:5nKDaWbYWokC0Byo12p3iWJb-_qqW-7HrGK7VQlrLIXPTxf5uMh0lw>
    <xmx:5nKDaWGVj-TKJ1j9Dixs4BJtdUvxXjXp6cOIfHQn9rAu8QBsZF0Kr-JJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EC8FE1EA006B; Wed,  4 Feb 2026 11:25:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AXMcA4Iy85D-
Date: Wed, 04 Feb 2026 17:24:49 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <24d69fa4-bcf3-4297-b75d-5e45a8ca50da@app.fastmail.com>
In-Reply-To: <6480aae2-d2f2-49dc-b8da-ec7cfcfbda30@app.fastmail.com>
References: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
 <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
 <6480aae2-d2f2-49dc-b8da-ec7cfcfbda30@app.fastmail.com>
Subject: Re: [PATCH v3 0/4] doc: some more synopsis conversions and fixes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026, at 22:44, Kristoffer Haugsbakk wrote:
>>[snip]
>
> By the way. Sorry that I managed to reply to the v1 1=E2=80=933 patche=
s on the
> previous round instead of v2. I noticed only now.
>
> Too much copy pasting.
>[snip]

And here is a trailer for the next round:[1]

Reviewed-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

I will of course look over that one as well. But I think I will be out
of nitpicks by then. :)

Thanks for doing this work!

=E2=80=A0 1: Context in https://lore.kernel.org/git/bd07e62d-b185-4d1a-9=
bb5-7c075d6508c2@app.fastmail.com/
