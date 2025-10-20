Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E15192B84
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978781; cv=none; b=hRnVeb8bpSMba6hQzBQQ/jeP2g1rq6FO5JnPYSG0+rjFPl009mQcxAtYYlMQIQ1fPb7Edh4LY5rOmsc1k6ZEqu3XwQJxgtGN4dNTvZ8c4yVw+VLdQI9OdcWtyETnZ8BTJb2RcI4c6y4VTixiD+yrcsEVgNOajUSm9qR78AI58OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978781; c=relaxed/simple;
	bh=Tabo9FjAPSdYo9BDj0khc+nr9vl9sELC8ugjUuQHHcE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ObEbKmWB9HWtITI1VKbukfp2+xPzxI80NjLvoZJqPdv1LniClXquVTxIFQlzSQzwmSqO5ImNAPPPt9Mq5nCOWWf8EFIGNJbBIboMcYvK8cndx4RmPdf3xycKvI1UjMzY73QUduvWfxueqrDddZSvAnMZ84R7JlqNfh/HiAL2wMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PVwnCXtp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GONfyr4q; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PVwnCXtp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GONfyr4q"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 966447A00F9;
	Mon, 20 Oct 2025 12:46:18 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 20 Oct 2025 12:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760978778;
	 x=1761065178; bh=VqsskRsQ8BGsISlPzbrQA27srRSR+XmyyWniEq7vN6s=; b=
	PVwnCXtp0pf0aXOZ7ddcl3E7lMSCSci0eVsqNfBZjOHN5wkUrGrb2RlU+aWdIbxv
	cAP1rqN7WknexjeoSuQXu6f+2QA7oFfL+2quNQ+TPrDD7tFj6NN/R6t7UEVp8WS+
	xMC9Ff/giJM7PyAuI61MdnmcsyFFUUI5q4zhEQt4moqzQCq4npoMb5+ALqmvK8ez
	Z4X/2JauqK7dfTwE5v+WFJTN91YqUQQ4LmcmRqUHriuZmGxYShUKv0BSks0IUKss
	CdnIN/1tvQh05I2L/Lud1g8PAlotCLsIUsnRaDDOsURBARnIN4NsRDhsqk+6KW5V
	JMnaDepDhDuIOO9SGPzZwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760978778; x=
	1761065178; bh=VqsskRsQ8BGsISlPzbrQA27srRSR+XmyyWniEq7vN6s=; b=G
	ONfyr4qZpnUHfdYNoRXuc8GGtBlLk3WFWwLEfETN7+akMeweB/1Mss/q4BZt18aH
	ZxeBWWENYfye7l5g+At9w2+OI6cGrGEgJxmoLtiOicfyTyH+hzuSGEaRn17qCR6/
	FMM0KE61J9vRSVXIZVnDDdZlSslI0fhKOZSGM5tRfPvyyaEnWDdixpUXAPnQqrEX
	GXjjhffgfj7WuMZx61Ovp/16YyeQ1GFwTwOE1T8Kq49jByNXAZyCK02yQyLiraqh
	sl06PbUgGlhzSviZ67aEtKOZ3zx78+UawB9Z44/XEU+5ZDZVCBKaPBppOBZbNqe1
	1B5JdScuW9cPpgg8js04A==
X-ME-Sender: <xms:Wmf2aI-_06ZYBhJHACrp8yZVWmgpMjEweBglHy1GsQSFcUNFzKrfsco>
    <xme:Wmf2aLjdpbsSYaWKCVCfkh3Z6P2OrmZ2J00GUHvkTI5ci0r6hxkM-0WmJ2ESLhqLb
    5NSkI7lcXyRU8XHvdEQERDx4eCNWDTw85kUa_Xq7P2dVGaBnqKuNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsvghlkhhiugelkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Wmf2aHiDnV9MpA-nJh8RXhC-bGyFGqw3hKXSicPhMz_N2RQC_8ebOQ>
    <xmx:Wmf2aFj0bwJXUTv_2yGkdVqgvS34aaThufEFTD9xPM4hmUR74tcNSA>
    <xmx:Wmf2aHLWZ2XVfSlUBMgc08TDdSBNLBl53hMcUNOOOzNr6HktlOvFkA>
    <xmx:Wmf2aEEU9Qg0nrOmIktCdmyXA_YxllzGgCAN7WPuaf9hgmGgSeykUw>
    <xmx:Wmf2aP3qQb-I-O6EovOtZT6zSoNiauA-18hKam8BUl15jjAwZrf9ibHG>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 184691EA0062; Mon, 20 Oct 2025 12:46:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATeKP54mJ-4N
Date: Mon, 20 Oct 2025 18:45:56 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Olamide Caleb Bello" <belkid98@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Usman Akinyemi" <usmanakinyemi202@gmail.com>,
 "Christian Couder" <christian.couder@gmail.com>
Message-Id: <4bd36d2e-7629-41bf-9731-493cf3bd151a@app.fastmail.com>
In-Reply-To: 
 <7da4fded535984faea52d5f88793d3c8e47c0091.1760869186.git.belkid98@gmail.com>
References: <cover.1760869186.git.belkid98@gmail.com>
 <7da4fded535984faea52d5f88793d3c8e47c0091.1760869186.git.belkid98@gmail.com>
Subject: Re: [Outreachy PATCH v3 1/2] gpg-interface: replace strbuf_split*() with
 string_list_split*()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025, at 14:07, Olamide Caleb Bello wrote:
>[snip]
>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>

Signoff should go at the end of the commit message.  You=E2=80=99re sayi=
ng that
you are signing off on the changes as well as what was written in the
commit message before that line.  If I later add mine:

    Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
    Signed-off-by: ME

I would be saying that I am signing off on the changes as well as the
previous lines in the commit message, including that line that you
wrote.

> Reported-by: Junio Hamano <gitster@pobox.com>
> Helped-by: Christian Couder <christian.couder@gmail.com>
> Helped-by: Junio Hamano <gitster@pobox.com>
> ---
>  gpg-interface.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>[snip]
