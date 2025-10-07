Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF9E55A
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839903; cv=none; b=P5/+OAlHOkNXUR5/63d60zTC2vW9Qe1ZyHzOg92FfI3hmF+5jgjkwatRz4f+WqblJs3En5UtF+crH3wYqGxk6irAhHwzrY654lo1JaHhiq2EmLQGnIu1pq/VixZcq4FCUXewq4+CrHdRDJ0Q7HMwxTI49aIwpmTEzpXcDXSjKAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839903; c=relaxed/simple;
	bh=lz+ipoCecI5WcVDGbuZPyWS4Qo0mqL8xM/jLBvfyH6M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cAk5kvgfmwi1JfaQVEKLzHb/b08byM9zYMapmm3NdNIwB6eRUdjPmrJltw7Qxtz89DSFkUaD3VHr7284x715u3K4jXSn63LwtIMgg4lrPED8Gyf3KAWQbqDp87+4dUKwTOw9ngilyoypnaCqHQiwK2ybCSNdcRUTj09sB/Q8N/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MAdNcSRi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fowgt/kX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MAdNcSRi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fowgt/kX"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87977140085F;
	Tue,  7 Oct 2025 08:25:00 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 07 Oct 2025 08:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759839900;
	 x=1759926300; bh=W2QUNRa2NaRGDR6zRLW1pnX9usXHIBuM4Ji0k+a1rG0=; b=
	MAdNcSRimVjwLzPDBoFu/84xVXVLiX8waK46Wg7jwq/xC7Fo5RwX9yMRIPGN+htQ
	3l/v5nuVc0SqWbDYfbjLQguODVR4VBEUzYqCCK3qWeW2IFfB5m6nhoY6cI6fIFNG
	zAFKhc+tXu8NwcN7Hrlcady4jleayCqPHn80jq4iHtyhdD+IXy7X1OcPmmvBJzFa
	Gm+RAyDPgjQmy6yI2RXZIqHHFiG7XbGWo3vmnCPpuzG/u5FQAM8kvxxJ6GUgIdhX
	uRppWtIekev8IrjdfvNLuEMyxW9hfUqAtCQvUbXfFcuE+juM3X71+Z0LPSxVxKc9
	vViREf/mGeGXkmsojQb7UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759839900; x=
	1759926300; bh=W2QUNRa2NaRGDR6zRLW1pnX9usXHIBuM4Ji0k+a1rG0=; b=f
	owgt/kXgODt6AUGIitll6mWT7UFGIcYl+1D86n21FSWuCoo+E6DYMd/ihh/7ot+z
	S1dr3aVdsc4Gd+7jycBkr0eATj7vX7p3Xhr+Z/fPWLHJ7bfbtzWyC6ZRNh3feQSS
	76EpSu0Jw1Qrm8Hd2Z2xc16zJXLpuToleYPHoXPWTfixnf8NA83OnIsqXdvvOQQn
	sfQKjAdRNxxUzKr1CpHqL8hop1Fs2C1sHsABubx9JkTdJdViJAZVIWQJGBdUitAk
	Ip2Yr5ado6y3s+PA5cJ4lGr9xcRamm1WTlBINArRawEVGz+RPqENH4+gqSnyM+/K
	1kSeVo0e2qn+fVAihTbOg==
X-ME-Sender: <xms:mwblaGx81TnqGtkSdQzgzybAacONMaYiPTCmtzpfXQD65MJODBsLccM>
    <xme:mwblaNHVzaSucUCn62_DoZmR1wyDYJtcJfHAeS9qoUZUh6bYNkfsfOa5KAGTLFfo_
    OQVLBGt0dyZXkGLbRgqsRkMemFsX6x0hxqH1nCDGegvgHm5mF95>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeduhedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthh
    husgesghhmrghilhdrtghomhdprhgtphhtthhopehgrhhoshhsvghrrdhmihgthhgrvghl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdgrghhrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgrthhhvghushdrthgrvhgssehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepnhhorghhrdhpvghnughlvghtohhnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehthhhrrghnuhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:mwblaBDbxOdCBI5MexGNzKL6k8jmzTr75SrK1PApdZdRJsZMJaWMSw>
    <xmx:mwblaJ66luVjzlI2oTbsn3F2zFUmBIvqSM4xVgMGfMkc8Ve3Guvsog>
    <xmx:mwblaCsJRueCkQqDbhI436rhLwNu0mRpy94ti78FOzwQxQRGUsUwRA>
    <xmx:mwblaG6tGT6e1EknR6fr3q_2uUzOe2IF1N6D5Oqu3BD0wFQR1wUAxA>
    <xmx:nAblaGqqJtlaeNetGU4m1BxKBkUs3k4x_kljh2w90vlYAeGXNZNnSXp1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CEE851EA0068; Tue,  7 Oct 2025 08:24:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUtg28jYwm3k
Date: Tue, 07 Oct 2025 14:24:38 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
 "Noah Pendleton" <noah.pendleton@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Thranur Andul" <thranur@gmail.com>,
 "Michael Grosser" <grosser.michael@gmail.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>, "Taylor Blau" <me@ttaylorr.com>,
 "Matheus Tavares" <matheus.tavb@gmail.com>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Calvin Wan" <calvinwan@google.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Message-Id: <18d9eef5-a1dc-4d9d-957b-ae630f0a2b12@app.fastmail.com>
In-Reply-To: <xmqqms63ok7g.fsf@gitster.g>
References: <20250501214057.371711-1-gitster@pobox.com>
 <cover.1759094936.git.ben.knoble+github@gmail.com>
 <5c97f580a9e77c464bc6bf4ed9ea8546711c6637.1759094936.git.ben.knoble+github@gmail.com>
 <a687ec17-8ee4-428e-bae5-063716d59a08@gmail.com> <xmqqzfa3onxx.fsf@gitster.g>
 <xmqqsefvol7s.fsf@gitster.g> <xmqqms63ok7g.fsf@gitster.g>
Subject: Re: [PATCH v2 2/3] config: values of pathname type can be prefixed with
 :(optional)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 6, 2025, at 22:21, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> We'd probably need a preliminary clean-up patch to fix all of these
>> in the vicinity.
>
> So, here is the preliminary clea-up step that should come before
> [2/3]
>
> --- >8 ---
> Subject: [PATCH] t7500: fix GIT_EDITOR shell snippet
>
> 2140b140 (commit: error out for missing commit message template,
> 2011-02-25) defined
>
>     GIT_EDITOR="echo hello >\"\$1\""
>
> for thest two tests, with the intention that 'hello' would be

s/thest/these/

>[snip]
