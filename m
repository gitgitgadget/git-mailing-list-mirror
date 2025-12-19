Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D335950
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766129993; cv=none; b=ALVDWL6X8c5PKOlCTjk3FeBlD3NZBsx2f5MfbvU8HJzCiuWOp4W8TlrwtHyxSXoBDmrWmLdR2AQ0NEf4PP6U+gB6NPWarxerMNHYUfnKo3SeHK9fZl6cVeUphIx7Aj6bL9QBGneZeleBsBhUQNqUaHaWGlYOZvItNlS29zG2cXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766129993; c=relaxed/simple;
	bh=FtK22ozs+z/mS99fYdYUBXgzVmutMUi+2Zhh8//H1jw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=glbcAxA45KmV6JE6vQJADWTX+oGlXy2BGYjgS8xkXFVdtanu1enR8KMddoaqrRmWy/6tjI4KiwEUm4dYJSvEfd7z5XgbOKt1RNk5etDN9xFum7SMgcYvPSyesRClSn1IMrsFB43RHzpIUCTbnsF2gh6vl6IQsYd0ZJn0EJUcHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dUV86br6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LjsfUjBx; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dUV86br6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LjsfUjBx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 576351D00168;
	Fri, 19 Dec 2025 02:39:51 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 19 Dec 2025 02:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766129991;
	 x=1766216391; bh=FtK22ozs+z/mS99fYdYUBXgzVmutMUi+2Zhh8//H1jw=; b=
	dUV86br6UojsiS41+LHCyh5ldWkV95j0iJu5mMbB6LVqihm0CUU6Hd8lguOHJemV
	yGuL5YAxLRQE4kk49mjfFUvOsGvuWEGtwou9DSbyX3OvPvNiKzNa3KzNXYnDg42R
	Z1khp433j+T4NIU+TPb0dRY0UprxTIi3u/nPCJN1BBNJ+pyRvAM01qWWyX5TtSjg
	HUSn8IJf7ERj7aw3GAhmUI9mjxCY1TQlS1wCWZ9MK0KW9C4qZtfW6uYn6rAIhBUL
	BBvxkEuE6h+XYVH1AU0b0rYKzRGUVuprbhS7SpUaqHHL1rVzrXex4g6dYYzvWxci
	IRQqYSjQw8TeAMDXUWaE2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766129991; x=
	1766216391; bh=FtK22ozs+z/mS99fYdYUBXgzVmutMUi+2Zhh8//H1jw=; b=L
	jsfUjBxNs0c2bcrkMHG/x9AkRovRMbWr5xtghJqmUp0vrezs/7d/jnA9zb3XNBNx
	WczMbi6o3BQG2TRqG3Z+d3Xv+/MqnPTtqirRVG/2sdHk28AKrao5I+IbgnrcMahB
	c5UcfzB3VWK/G+0XAAQPMe2XB4AHjEis8O/S3jmOTwJe+tACE5n5r5po1/HkpV12
	LK0E0kqH98b8OEpb7bAy5WA8LJn+17pepvEz+82JrQMfBqZ7tEC4W0oQgfzwwWMx
	fhS0so8xiKeTu4oiMWOX+2XXcXCe7T2UNbxaaL/IllAZmbEPXC/ToKW6a8eQ+x0U
	rTuPDrmCM0Uyki20YvJxg==
X-ME-Sender: <xms:RwFFafbtMMTRqBz4bTD5D7uyjslfCbquWwP4NK3_vuJgLFXX_Us4sc8>
    <xme:RwFFaZMp9wxOHS63jObyoX2eY__TSong3E4V0J9--dn6y0ShyuZis_OpDVGTL9SPF
    fztHCV2SkXE4wxgP1Iw7CaRr0JJjRDNRWWCqbp8iyiSOwtL2cE1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdp
    rhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RwFFaTedvLzhAzhvyLjvZqt6979ycp9IkSj7G84HWSHmliCr2UPphw>
    <xmx:RwFFaauE4_eIRRKmjncBc_9jemK8es9RhBHTAvdH8gD58fe1QWrnUg>
    <xmx:RwFFacnbysHqXnGvieltEG_eFxrOaN02nop7d9fHr3aR6EgMdQ4pjQ>
    <xmx:RwFFaUyEHrSRs11IDw-VuVYDvwoCekYeqbikssoaGMc3rJHl9Jdzug>
    <xmx:RwFFaXqvgxeaXcxdKBfTaEtpuY6QkQ2hmVi7Laj9ZlOzwUKimsU4Tv-e>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0DF231EA0066; Fri, 19 Dec 2025 02:39:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVz_chKN6izs
Date: Fri, 19 Dec 2025 08:39:31 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: "Aaron Plattner" <aplattner@nvidia.com>,
 "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <4d084712-dc9a-4824-b840-4d78831d9da9@app.fastmail.com>
In-Reply-To: <aUPbgCSTgWJAe0wu@Carlos-MacBook-Air.local>
References: <xmqqpl8cxy0j.fsf@gitster.g>
 <a31e054e-0eb2-48b9-a802-3592a737d1e3@nvidia.com>
 <0e860421-8f8c-4bf9-8ad8-82fe269a7a9d@app.fastmail.com>
 <aUPbgCSTgWJAe0wu@Carlos-MacBook-Air.local>
Subject: Re: [PATCH] odb: do not use "blank" substitute for NULL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025, at 11:59, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> On Thu, Dec 18, 2025 at 09:02:59AM -0800, Kristoffer Haugsbakk wrote:
>>[snip]
>>
>> This project typically does not use that trailer/tag.
>
> While factually correct, I think the "why" is more interesting in this=
 case.
> anf the answer IMHO is: not, because it is not needed.
>
> % git describe 385e18810f10
> v2.52.0-25-g385e18810f
>
> shows that this bug is only present after 2.52.0 was released so unles=
s you
> are using unreleased version of git (ex: some development version, inc=
luding
> ones that are based on "next"), there is no need to "backport" this fi=
x, as
> the next version you will use will include it.

So the Linux Kernel (presumably) uses `Fixes` for backporting and/or
does *not* use it for commits that fix changes that have not been
released yet. Got it.
