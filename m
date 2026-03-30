Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21A33A0B3E
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905115; cv=none; b=QzeW6YndUbvm8He40xkwPsdDRQpo3Vo911RfNyu8CQCv7vxOlWtsS4JMEZBHUoKmpLYryQMpps4JHd+AFRXqqfDnS3trKNnIJQ6NmIG42dG8tlkWakS8ccwKdylKKCgStDozuZufTSvDCkCulDIfC8EimXpNoZ+xfw3XgHTjbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905115; c=relaxed/simple;
	bh=xRWukLetiz8GoLNoWM/3orpg5PbSaeuIPWBVntnx9/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0yV3Ou33/1+UM86qHChw9xEHP/r+KRX5kfvJ/qi5HUjSDHzWyKIjJugWvid668LXYJIv5OJszJrFZpauwcioSnT3KcCO4/e0Z+CjFMx6eeXMwP7oW1oMc9eHjFf4DONAQoKatwyu/j14E1TPPVhPzzDhT/EDG/mgRy7zfmaxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SdBN9ELp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WzHjfXw5; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SdBN9ELp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WzHjfXw5"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A85081D00163;
	Mon, 30 Mar 2026 17:11:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 30 Mar 2026 17:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774905112;
	 x=1774991512; bh=IzJTUNM01w5ezGCEyvKVQjyeXfdHnbDfAGtlY2kqVgk=; b=
	SdBN9ELpp2JlUUE31C2G715RB2UuOnKsTHZMfr/MB0H34hS5UDZFQskM+YAUl0QZ
	+ATwz7RfYeJpT4JSe61FQLXOGbWc8o5CepIG4xKnbWbeG3veqcCamAbXhpVM5HHl
	FPklB6OrlLidhymFJnXDKwBVX4FrVD2vLOHRs6oJxhv2w8OCmR+mUMNiHZWFyXbU
	XOIxQ0H7DVuq7L+W/5437qfdZ3zboWeG7KprGrV2fkwJvNu2UacVvUMLjM6vilBx
	Eob2L0ta9JisHJLRKe3UOQcTYpQwf0fIshOSA9VcHfpZc9xrndwJNHQkp/8YJkJe
	5CERYvx1HTj3lAAnhrI/EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774905112; x=
	1774991512; bh=IzJTUNM01w5ezGCEyvKVQjyeXfdHnbDfAGtlY2kqVgk=; b=W
	zHjfXw5hLQm5G9MIl7sq0GbMY4sv6sSwOMrjfb7e2SI1tFXGmgQnrFLhPXV/Wgyj
	6dE5ufV4RhekDRwcBuL3fATze1ZWqGtcsjblvKZV/zXy0LyAldez4wmTmKvoJESo
	1VUIAOcdEjzeiUSFep5fsMfbsVpsJroba+O3DrePfNXAr5M/H+gCShe4fUm74XiA
	4QET7eqLvjsPSoKDTwLiZPii4+UwPqRaUWzUe37Eb3eXd1ZKD89nZ5AeZkLlOVkW
	wgHri9Bm8GFuRK+OkYu9mNPgfhM2IcUS4hUaEfkv3N19djgmbZELGX5gmncxJgOp
	FHGrezYEQGk5wQdr1Oy6Q==
X-ME-Sender: <xms:GOfKaeupXzdokKF3156NP2kZ4tLO0PWlfO8el_5oPWVKb5jYAz-rVd4>
    <xme:GOfKaaVhNRBZQO2KdsJNOvGN_rTiaTsWQN6iK77hwWVbKGjdJjqjaQi4xNEvQX-lj
    XX6_atv18BJ3LHVgiRS8p1VaFIqTPMfPWzN-cRY5bGhetevWF2HUA>
X-ME-Received: <xmr:GOfKaSFko5mbfBwMYohl8X869hwrj8IiQI-TWTZ7dg9xAc04fDNKdZRjh6lkoc7OfdLkFIrLPnAFXjhTdJCmotpUJufehSEFq1kN49edYGmzdP3LcDC9Irqvcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedttdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheptghhrhhishhtihgrnh
    drtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghkmhgrnhgssehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhhssehutghlrgdrvgguuh
X-ME-Proxy: <xmx:GOfKaU1ylKioTQFKIXn9xWf5V27-AjJPhaep4mGb9uS1fDVLcN4_hg>
    <xmx:GOfKacOV93-ta8OaaCQZqew7-vpITXS_zRPgut4O5ni3Um699chM3Q>
    <xmx:GOfKab5PuBqeILpCMsfzJKHXQh3U48ye1AXbC51H0A_Sjp86cd_ClA>
    <xmx:GOfKae3vf5V_Ny5FueTkVz8kcDYXhJhhOba79vbAsBGFJii1yVUu0Q>
    <xmx:GOfKabn_7OUWTJywKmOpCHhS81CzHN3Ue0zoAUoLY4t0NsCICRWek7BC>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 17:11:50 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>
Subject: [PATCH 0/2] doc: interpret-trailers: explain key format
Date: Mon, 30 Mar 2026 23:11:31 +0200
Message-ID: <CV_doc_int-tr_key_format.533@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com>
References: <CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: doc-int-tr-2-key-format

Topic summary: Explain the format of trailer keys (alphanum and
hyphens). This is important to keep in mind so that metadata is not lost to
simple syntax errors.

To facilitate this there is a first commit/patch to reorient the
introduction towards discussing “key-value pairs”, since that makes it
easier to follow up with an explanation of the *key* format.

§ Cc

Linus Arver as the author of the example that this change touches.

[1/2] doc: interpret-trailers: stop fixating on RFC 822
[2/2] doc: interpret-trailers: explain key format

 Documentation/git-interpret-trailers.adoc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.53.0.32.gf6228eaf9cc

