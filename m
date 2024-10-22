Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C931411C8
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626846; cv=none; b=CP1EkDwFTkhgra4ydPOMoHdxVaxGeAF3z62qV59tTmg5IlMnoPO+Kd+TfX67ohqt4WtnvI9InHAY//SYfDsKtJJcUJCEY05bG5UR73ym2sJiOlZGNBPImvRVLlorSj5UEWxLo8XIGBKnw6SdAmrEjCcatfdqwRHxbA+IyUWzS6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626846; c=relaxed/simple;
	bh=E/VgCkuNB54qP9WzeMBzAhe2hxMFlKAcACaUlDcNQmI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WTpW0j1ictJGDSC2jNNLCocPwL1pgRWCdwe0okrVm+/aMc5ho6GJ1FFKmNCIk9mv9M4fRzkgmnPo+dVJkMTgSslpvMyX8ubWvmPKjoF/NDXKxL5fgTWnYyyLlJaHlk0gjoi8L+K1VSoTEdgBRWnSoqG/j32v+ErPM4D9MA7jmIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Taax/oFY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DMiyyFhn; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Taax/oFY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DMiyyFhn"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F7BF11401C4;
	Tue, 22 Oct 2024 15:54:03 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 22 Oct 2024 15:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729626843;
	 x=1729713243; bh=UMnmuF+2HkozU4rqQLJCEGHSUC8QKxIiwnbFMhXedAY=; b=
	Taax/oFY96VRFdIdXFpxI9i15jrAeRjLXImpQcBhcz9UEEUoEqk13zPpaHeK2vhs
	JhCGlSrlujQwFNK4OrNhgOaatIcdcSIBFSYITJOvwyjE5d/Y8eyspXi7B0+fD72I
	znGTC4Juqi9bE41TKSnF6ihZEdVaIoxmbcSp8k17ABo5g/nemwbzzO4n2OBz+0/0
	CFtWqk5k9JGdowYCo3jQ6MK23e92jGtBZf6shV00fQl8gsLOnF7HA53GO2uVdHqv
	01mrT55EEHpTil5h92EE7pV3gaP6AgI0EnG9wMUEwrYP8pkeVsCQh207LLdIjc+T
	kQvc9jAgimK9SstntNyn1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729626843; x=
	1729713243; bh=UMnmuF+2HkozU4rqQLJCEGHSUC8QKxIiwnbFMhXedAY=; b=D
	MiyyFhncZ4zvkSnMHLXPpdwfhyJsXsSH7pK8VNc4zSm1gRFwCsXOvyRz0nDvu5PD
	caCBmTDBRsDNr0Pvuo41zbMY4y/1LlMMFFj2kTM0EBXDtVmX+xRfmBrnrs8XUAoH
	1PqhSRfGNop+t3NUit9cz6AuMgkFbOGVzHmRuQ0zkk6GvBfTnXWQe+JdEDyfLL3X
	9gV2rDYVXR2Vnk6r5z0ZyCm6Yhj1sKJumbWTjPVv32SL7d7rkkABI2NlH9+W6orr
	Q4Wm+L+8DPPmFfe0C5ehxH4AjA0+7YXqRaeihjlK3He1xAU3E+vJt8Ld7GTDPFcd
	x5RQytmsImOQpoRsieixQ==
X-ME-Sender: <xms:2gIYZ_wzYsow7EEaMrOZPn28MOse2Gj1QQtI6T6ALCcB5AawJnBD58g>
    <xme:2gIYZ3SmyiJ1rfPMkQMym_xSbtAuHPtmkb_WNSE6vEm6u7a8-zSZv1M2OgRu8XxtQ
    1r7w_ySAVZs6i1xrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeffueeuieehheffjeegtdevfeehtdfhvedvgeduledtffehjedvhfejud
    ffheegleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:2gIYZ5VvJeShf83bsrNzYeCnqsNOX66lpdpabnJ271Isb2QYg8VFqg>
    <xmx:2gIYZ5jMbx4cOSgHULIBvoYerWD5scYf7hf1xvo3w0Q6hNPO8bqBvg>
    <xmx:2gIYZxBxzg98tOiC87cZ7dczQfWd7Vw2ZSlJ0IYT_q5X7D2Qx_PaWA>
    <xmx:2gIYZyIgIdDxtGsEd3GzL14AgyxZlWmwNjGuGV2nfYIWAFvV-zC3Vw>
    <xmx:2wIYZ7C1ukkUQLe25Gfd0Tfa5M3gagpbukheGKcDRwmwEXzBuzogKioy>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 81612780068; Tue, 22 Oct 2024 15:54:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Oct 2024 21:53:41 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>, git@vger.kernel.org
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Karthik Nayak" <karthik.188@gmail.com>, "Taylor Blau" <me@ttaylorr.com>
Message-Id: <79c9cd6d-7bcc-4014-91c0-149505f70136@app.fastmail.com>
In-Reply-To: <20241022194710.3743691-2-bence@ferdinandy.com>
References: <43d44c82-b93d-4ac9-a5ac-ae5f70982cfd@ferdinandy.com>
 <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241022194710.3743691-2-bence@ferdinandy.com>
Subject: Re: [PATCH v11 1/8] t/t5505-remote: set default branch to main
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 22, 2024, at 21:45, Bence Ferdinandy wrote:
> Consider the bare repository called "mirror" in the test.  Running `git
> remote add --mirror -f origin ../one` will not change HEAD, consequently
> if init.defaultBranch is not the same as what HEAD in the remote
> ("one"), HEAD in "mirror" will be pointing to a non-existent reference.
> Hence if "mirror" is used as a remote by yet another repository,
> ls-remote will not show HEAD. On the other hand, if init.defaultBranch
> happens to match HEAD in "one", then ls-remote will show HEAD.
>
> Since the CI globally exports GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main,
> there's a drift between how the test repositories are set up in the CI
> and during local testing. This issue does not manifest currently, as the
> test does not do any remote HEAD manipulation where this would come up,
> but should such things be added, a locally passing test would break the
> CI vice-versa.
>
> Set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main in the test to be
> consistent with the CI.
> ---
>
> Notes:
>     v9: - new patch
>         - a bandaid for the CI issue noticed by Taylor (cf:
>           https://lore.kernel.org/git/Zw8IKyPkG0Hr6%2F5t@nand.local/), 
> but
>           see
>           
> https://lore.kernel.org/git/D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com/ 
> for the root cause in detail

Why no signoff?
-- 
Kristoffer Haugsbakk
