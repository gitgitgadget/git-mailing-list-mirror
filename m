Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB35274FE8
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698721; cv=none; b=I0AFl3f0SirEK7DGDtFFEt9B9KAIdqMpMcwVWkgEIOTuISAQ+PPYp25+5p0ObOQMhdf1sy77cZRFsGONBkUJZqbKbTqwf3YTbfhgt0cOabh76uQLBl120+ThfahV/WtloYS0aUDX4wyu3qxQeKG3erOt9q+Tpx78D1yORPKoaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698721; c=relaxed/simple;
	bh=UusogY8YxENmi5XhiT3ZATmmvR3jO8cNB9IVgraPEX4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pBLg6YkTjjAvmf2cB7WVeGn5cyJqd3WaOs7b+cO+SPjI1o55tItSGoBlhNtooB6Jgh+FEvQGZTiHaFYJxtjI877zdVk5PGP6n1S24mq8f4AyPC4RbsnNfUmpNTUilLv6+xUjZ7dvpuh3gwcqgXezy+w1NInAAwTALEwCBv6Ba64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MLx4ufpa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D2Zzogij; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MLx4ufpa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D2Zzogij"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA45A7A0104;
	Wed, 24 Sep 2025 03:25:17 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 24 Sep 2025 03:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758698717;
	 x=1758785117; bh=azo6XiZVBSnXWLAKHO+CuKtL02xm5PKt+QXu5zPEeFM=; b=
	MLx4ufpawUmPDSICKTCYy2URkRFg0DUna3IX4abrehAb3bULfhWLJ0cw1Ct3HwXg
	HA6XhI6S68QNJQdJ6wRNUjmWWjZTj+sCn1kUqWivZWBmUgONhMG8y4ZG5/4w4jPX
	2CeOGGhzKxIUaMm5OKqwhoZYAJAizc9jbR6wrDwjUmiuSpvJ9Ghzt4Eigr8lUuBM
	3ZrxNsVVTAGZt7VG+1UpvF9vGjfKXvEKARb8NjMX824sTKgwzxXyeSqVtiQKK7cj
	slxGjF0UYrFDvzLS1KHzbmXlkqopCOMqBoRG5uFXddGGHsxlLRaxx1cyW9HK7ojp
	JDTJZ+taID0vH+aPLzCe8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758698717; x=
	1758785117; bh=azo6XiZVBSnXWLAKHO+CuKtL02xm5PKt+QXu5zPEeFM=; b=D
	2ZzogijUUYMH0KdSSG+ZSE7SrV2xxTYdXChwAA+I2vpoPjKQdxdpuzTAc1S6fEDq
	nDCY5zZ+qakhoA+pnoxyIAnfQjOViP15nz32bANs6TlOLbrBB2dvTSNbIC+8yuRP
	0OrekllX9nUpigPWSgLkJUV6L8Op1oyFOSD70Nb/rGK7zdWI+ifebwr5yd5NDO/i
	lAaUqa5F7/0KRsa7Tnd2UL94DaNowBhbk1HPb8cIwfEOXnXrsRPDsF6ULdo3r7k6
	iK85oQGaofo1/ifLsVAxT4FSTW+b4bdoXwcgWCrtWu4+Lw4wnNuVtPQQD0oDy06I
	MzwGj5yOT98tLNICAR8gw==
X-ME-Sender: <xms:3ZzTaHQDLdcK_HgNapDQMsmeb5RVljSePILi_qdY-tfQsHMZvfHQV9I>
    <xme:3ZzTaDmEw7EWzdxxC3LSs6k0CfMhJpTZFYczuDmk-55-_hYiQXk1BIPsZ58hFAAR7
    P8AYtR_EakTEeGAPlgen00PTKp1kDRYw-fVwjh-wZLI0L7NNbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3ZzTaOVI6mdcdSF8jHEQmqR3rL39WCZc5Dh0GU0iOhDy2adWAUEArQ>
    <xmx:3ZzTaMHx-wqjC-tNgKPAa4MObXJhcMhNCR0ne3_s23p-J-JBqmdWhQ>
    <xmx:3ZzTaCcSe3nUxBNHmwUVu0o2-T2loDUNUDa_YIJHpvqu_B39VydhSw>
    <xmx:3ZzTaFIept22Y_oX-tEcCbY6_dT3znoX90sPtbGfgmeoW_kJBJ3RWQ>
    <xmx:3ZzTaKrapXlhgO067Her7FSMKPfonK7ieMgiPCr25Ldey8SoYIJG0sYL>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6BD941EA0068; Wed, 24 Sep 2025 03:25:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_F9T6DzY3Ns
Date: Wed, 24 Sep 2025 09:24:57 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>,
 shejialuo <shejialuo@gmail.com>
Message-Id: <b6d03748-8171-4df3-83fd-7f4025d9eb6c@app.fastmail.com>
In-Reply-To: 
 <20250918-228-reftable-introduce-consistency-checks-v3-3-271af03eb34d@gmail.com>
References: 
 <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
 <20250918-228-reftable-introduce-consistency-checks-v3-3-271af03eb34d@gmail.com>
Subject: Re: [PATCH v3 3/8] reftable: check for trailing newline in 'tables.list'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025, at 10:11, Karthik Nayak wrote:
> In the reftable format, the 'tables.list' file contains a newline
> separated list of tables. While we parse this file, we do not check or
> care about trailing newlines. Tighten the parser in `parse_names()` to
> return an appropriate error if there is no trailing newline.

Nit:[1] newline-separated + requiring a trailing newline sounds like it
really equals: newline-terminated list.  Is this moving from
effectively using newline-separated to a newline-terminated format?

=E2=80=A0 1: Since others have commented anyway

>
> This requires modification to `parse_names()` to accept a third argume=
nt
> which will hold the error value.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
