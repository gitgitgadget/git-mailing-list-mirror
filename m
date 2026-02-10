Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381343081BE
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739230; cv=none; b=QHV2bAHJzu4MvEEaySlEgcU0dqplnlwZJbjT+xMOUyomlroiO03Yo3OF7kx3zfBT0FqHqcWPlKVAED4urYzaQvd9YwkFKdKH3sg4X8X4PU/TA+xF/4GnI9ihv/WK/dK+mSVSgo9z8xaDeTJDXv2ydMMpQatm+UY9zCWNfDiia7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739230; c=relaxed/simple;
	bh=1ARCH7rgLFt5l+xnY54oq0c2Ss45hZhUXU94n56lQFY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KRgCMONR9vffPnxKl4iW8F9wm0sqN2ZnNwsSaemaFhfojzgWXWu4dmOvyHdkS0cix/09+ITnT2lsSYYS6Cidt+jAVXBL5dpUMUUvZK4FaLvM+hGk2wiFl2L9ciJ6F0cNfkibVh54mLLSFV3klx8yShMx3jQvXSTBsXGAWh/xONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ha9n1Pi9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C/4VGYye; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ha9n1Pi9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C/4VGYye"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D9AB1D001A9;
	Tue, 10 Feb 2026 11:00:28 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 10 Feb 2026 11:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770739228;
	 x=1770825628; bh=1ARCH7rgLFt5l+xnY54oq0c2Ss45hZhUXU94n56lQFY=; b=
	Ha9n1Pi9s9wR7Wv2Z4G7YLdD6pCfEe2hvgW9Kd8zRGJFu7ElJApqek4FQ4yTqtEz
	6XIh0lts/5ywp50qZJ/rr0YfiRE7fZ5TQuYtyolzNc2Qe7TUnDs1rIQE+j/lLPyn
	EgYzMTnd+1cRZpRF5zM56XghNZGTiCee/sIkE+n0lCdk2kqp24CxctS7rShzXtf4
	+FqejRj4bKjW3vSa06xXj6caCbtKX8O8oBllWncg/SfSmNYZrWiLOog1bJqH/Uct
	2B85ZS5QtEg+Qn9ip5+qntJ91Gq7XOWXazkumFgMxFEoFRpw3sxlbYb+W66XRO08
	IXX7++6zdDtWiakjibPT9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770739228; x=
	1770825628; bh=1ARCH7rgLFt5l+xnY54oq0c2Ss45hZhUXU94n56lQFY=; b=C
	/4VGYyenoZc72wsA+U3dcwtzqBEb25gf/KRxuYm/T+LlCoy+rZhRP3clJaNhqKqX
	3nJPWJDXJjvFhkSfinXACkDhnTO6LbDZtQGPmEysp2C48yeTRfcfCesWEfFk9sJW
	waCy15UcmqQa+PVkRh/G3IBf4MyNvk1FNtjxbB2jSSu05+D7/ztCdK+fhsAx3Ybw
	7nCrAGD+/wEtewEV5HfwkY1AN10CUWQcBQ3WWri6K1rBdbd/rXzVjrUKLOia5HOh
	pLPUPsE+rL12UVvuwSUOIL/HsKm3ud/GEp/aJG1hENequkfkJ+UuHPKTWsOdfoy9
	QnpdqehxxqC26TZwdlnBg==
X-ME-Sender: <xms:G1aLaf--x1JigJVMCYmyRKx90ctRDJNRrEFMTGVWxrH8C0ld5XIJh3g>
    <xme:G1aLaWhASMV4jPAunU_wSDzjwCQfTXEZ6ygYJWzGg0-kR0HG-Diph5kdldwS93EQF
    NvjOeJlSDhh2pFlvPYMPygKl4s5lbYhKIMUgR5P7k2Eyo50mMYKZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehjuhgughgv
    rdhprggtkhhhrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrthhhvghushdrth
    grvhgssehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrlhgvshhthihosehstghivghn
    thhirgdrohhrghdprhgtphhtthhopehsuhhrhehrsehsuhhrhehrrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G1aLaZmKlZ6TmUVZHbRmV8SYeeaYc-na0E83m1Ho0jEMHQcSN0sk4Q>
    <xmx:G1aLae7YiqXh6DTvrgJtXpEV8zkhAgpPj8HkNEvlaZ9zxhqcC8R7xw>
    <xmx:G1aLafiMRg4-fEi1h9-_Yc4BDwvIQbDUccDc9T0Set4L-0H_GkS8sg>
    <xmx:G1aLabHQuQl8xWh1mGr51i3qYuL6zvMHIYFATb3rec_3xcEfhngofQ>
    <xmx:HFaLaW38szwCPoFEVZB_3fFkyZMhT6D-hyqiY2-Rml2SdlcmYkrtABbY>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6AAE81EA006B; Tue, 10 Feb 2026 11:00:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2LExlyUAPtc
Date: Tue, 10 Feb 2026 17:00:07 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Christoph Anton Mitterer" <calestyo@scientia.org>, git@vger.kernel.org
Cc: "Matthias Beyer" <mail@beyermatthias.de>,
 "Christoph Anton Mitterer" <calestyo@scientia.org>,
 "Matheus Tavares" <matheus.tavb@gmail.com>,
 "Chris Packham" <judge.packham@gmail.com>, "Jakob Haufe" <sur5r@sur5r.net>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <7ef28209-9953-4593-b1ce-11af5e8375bd@app.fastmail.com>
In-Reply-To: <83b776c4c3b6092f9714adc157ac6a38af1022f7.camel@scientia.org>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <format-patch_caveats.281@msgid.xyz>
 <83b776c4c3b6092f9714adc157ac6a38af1022f7.camel@scientia.org>
Subject: Re: [PATCH] doc: add caveat about roundtripping format-patch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Feb 10, 2026, at 01:53, Christoph Anton Mitterer wrote:
> While it's nice to see it getting documented (thanks for that)...
> wouldn't it be even better to actually fix the underlying issue? :-)
>
> I mean it's all but guaranteed that everyone reads this,... and IMO the
> problem might even be exploited security wise.

There=E2=80=99s a discussion about fixing it from the start of the threa=
d:

https://lore.kernel.org/git/bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7q=
k7dldf@fij5calmscvm/

Please use Reply-All. ;)
