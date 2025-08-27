Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F263431F5
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286502; cv=none; b=oFtyWaAVYUxemA+45QrEu7NbZowqI9/P2VKkmbMX89AiTedhqic3jv6bwKS6XLqI9f51Qf+KhlclSb0yiTyG7xhOsjnP0RZRyLHEIWGFadXZqA2Ak4ihNB2vYYiNDR8WO/fE/UORonbsBsEayiEmUpg2RseVp4slTRwruzedc00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286502; c=relaxed/simple;
	bh=pTsHo71tu5V7kH36DK4JYIe+sG0IgjBQ7KU/fj5haUs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Qb++Cea/pv76Q74gAlxU9nBDC4O/pIfrWaaiHGhULPenC3fQ2LrKf1zvgiVThi0e+kCk58fRzvrHzmBPEgdKhI5txJk+yNhImfbSW9RkKTCjqeVLsetT73dtRdeQkK2j8jmYWjmR83Z4Bm3AIxAyZkACoCCej7Ska9fSu/TgNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GeO6b6+y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hR3aNNke; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GeO6b6+y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hR3aNNke"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 503791D000C3;
	Wed, 27 Aug 2025 05:21:39 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 27 Aug 2025 05:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756286499;
	 x=1756372899; bh=BZM4jdBOvXOIHg9o2xYHUi14FM7QLPPZ5EiArSkL5GA=; b=
	GeO6b6+yAReONOhnHQ0JiW5JqVv1KtoZRjDLIyLRqsme1cbmWXxQgL85iOmIQFSJ
	LGoKbdsp/Ym/NFh1J3+hMDIWDBhcScLp8puqndUh7Zacc30lK1TtclFv5RkZpxar
	yP2Ir9slJ77mB4bf/ZzL6GstRYuE/0v3WIW+dQDPSVYAojHxRpXmfhhp6MLN8u3V
	39d+A0Av98HnlVvAFtn0heK0LllHEzjCuZTdgJivZZbkvzXHeYZNzIZuGc3zZK7B
	gpijCNDPud5Gtc3cDC0kyQP37IpWOuRhW4BCUFIDlbgj1UJ4M7R8PAust8nXxzyz
	Sd2cx0jT7yfgqB34/7IrRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756286499; x=1756372899; bh=B
	ZM4jdBOvXOIHg9o2xYHUi14FM7QLPPZ5EiArSkL5GA=; b=hR3aNNkeNUa8WoY0G
	KEaLE9ZSDKdQ+qSkf2qyCas5kJIE1LiX7rj37EN1/h+DsSbvaKlaOpzT5KOhpdeV
	uVtIy6zDf3Tgs/Sxl9kdbQp5Rfierh+7KSYao0LPB4QOy4+d8hO69m1FBU4vSoP3
	1YGEQBh2w9xsaotAoC3YqPhiKPA/1/wCgVUat2WHBqWF0UC0jRNfcg0gGkjFPzln
	kI9ieA5uAWDl+8CkFvtWYSLOaC4tBogwoFEbq3MFVQRuiu7MUwab2r8KKkKT3QEK
	3AGscjGaNGRXmxvQKp6vcwuB7uOa8pIwFyqPqA0J8Cz32RWCu/8MFPTQnlT54akY
	mWVOg==
X-ME-Sender: <xms:Is6uaPFw2kT63kmcmNWhdaDR0zSwuqQZtcuG_X808aBwQW5pGoV6NG8>
    <xme:Is6uaMW4nPbaKvndHvC5Ag3ybV7eyzvI1fj6h06qWZdkcjv8VJ89Ve2xLmC0yI77E
    CUa0jxaFqIF9s67Xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeejjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdfgffettedulefhfeekheetgfegfeejveeikeeffeeikeekhfev
    ieeltdekgfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:I86uaHL0-WgPr_HxwXO68jxufl1BDp2blADDBINe2U_6krfN3uZGDA>
    <xmx:I86uaEH-6WKCCovARWHTNh9xZeGT2jQZZHXz0iz1DtmrVq8MguQgmw>
    <xmx:I86uaBqTk7dQ9nk7M12phVkwi-2g5bpswzXViZnCyetBhlAzTWm-YQ>
    <xmx:I86uaNSwi8MWiP7QHZeFol6bGOfgMk-neGmuCKGgzZZnppS-Zkw83A>
    <xmx:I86uaMzz_JiRcbWKAKpenAh0pHcwaPqJWgDFFtj2QR_zGdMtQgiMTCnt>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E062E1EA0068; Wed, 27 Aug 2025 05:21:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AG2JU2cNsOGc
Date: Wed, 27 Aug 2025 11:21:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>, git@vger.kernel.org
Message-Id: <57a79b29-0e65-482c-b0a8-1e73744ad5f6@app.fastmail.com>
In-Reply-To: <20250827080702.GA3572995@coredump.intra.peff.net>
References: <20250827080702.GA3572995@coredump.intra.peff.net>
Subject: Re: [PATCH] curl: add support for curl_global_trace() components
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025, at 10:07, Jeff King wrote:
> This patch teaches Git's http code to accept a component list from the
> environment and pass it into curl_global_trace(). We can then use that
> in the test to enable the correct component.

s/This patch teaches Git's http code/Teach Git's http code/

SubmittingPatches =E2=80=9Cimperative-mood=E2=80=9D

>
> It should be safe to do so unconditionally. In older versions of curl
> which don't support this call, setting the environment variable is a
> noop. Likewise, any versions of curl which don't recognize the "socks"
> component should silently ignore it. The manpage for curl_global_trace=
()
> says this:
>
>   The config string is a list of comma-separated component names. Names
>   are case-insensitive and unknown names are ignored. The special name
>   "all" applies to all components. Names may be prefixed with '+' or '=
-'
>   to enable or disable detailed logging for a component.
>
>   The list of component names is not part of curl's public API. Names =
may
>   be added or disappear in future ver=E2=80=90 sions of libcurl. Since=
 unknown

s/ver=E2=80=90 sions/versions/

>   names are silently ignored, outdated log configurations does not cau=
se
>   errors when upgrading libcurl. Given that, some names can be expected
>   to be fairly stable and are listed below for easy reference.
>[snip]

--=20
Kristoffer Haugsbakk
