Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A460137E
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729428402; cv=none; b=tMdbYcW9RjJgOXo6v8weqjiU0r28l67DTHi3faHm2zPBURAUAmGRPMvPO1kky6Q62WauVzvBKkq+20oSWp1LK5c/xkZoN8csS+uGttorigEvLCmfHV5ase9p6gZRH1JczvS2KyR/oJ7cLI5SFSI4Bc31XoSe5Hqgo1NMBCN8T/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729428402; c=relaxed/simple;
	bh=fCV3QzbY4iihFYxW3LwKGcYkMg4lSCVtr34whGY1STs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=i0a4LTNs5W4CKn9eto34GL9rAba5CYt+ciXkKFx8/tsLGUqvXpbXeZ6Mc8hKTc+dyjv5QKpVnudNNkGSkM/FFbKv1eEzmL78FWxqUCWrPCdHnkDpXhBUIYWLPq+PGKSFzEEyHR3rabb+flN9O73wIUKLa2rmr7kEbX89JBjT7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=e7KaQhoY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cSomL3UZ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="e7KaQhoY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cSomL3UZ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 61E0613800C3;
	Sun, 20 Oct 2024 08:46:39 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 20 Oct 2024 08:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729428399;
	 x=1729514799; bh=cI58A6YuKA236oDD3/Qu9dWbRTgwoA5CdSHHP8OR4h4=; b=
	e7KaQhoYdWjgMrwEGeCJSUV/CbuP93eL6A1D7u/WPplihSYmzVlbXgZ67GmTEhda
	MUWH1g9iLrn9qSYVGSXZtoy3elovHT7MUNqHqi4+ZCu8s8Ztbk+RJHhjNEa7w7nO
	8fPsMOECsWpQMqgW/L0P4coi8Ix2IZLldxD5Sz6xcZe/HjpAjBnS4TbLtZ6IbuwL
	tomIZKfEwch9ba4Qeep/USjrAkjr3BF42thBuZJGhE4yF28JBvYiN9P0HY6N//+Z
	MjHYhL+wNj7t7YoG2E63LTwE9Ov9j9Tz5xOWAS25SP4TtBgSOActUHZhLa4sTmb2
	RahAN5BfXO/jHQqkT5I11Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729428399; x=
	1729514799; bh=cI58A6YuKA236oDD3/Qu9dWbRTgwoA5CdSHHP8OR4h4=; b=c
	SomL3UZwu5DfycsbKZK8lkCq6749rE7bI9E+HtANmwL+1h1LNR1vtTw4rQJzLg5G
	QnCTSdgCn830ud+XzZM5wfhxvhA5lMYJf+uEUb3OtUInZctZeJ2X7gFUo4c+NNCB
	EGEUC7kK19HE7M/iP0FjwHTcW+dbelC2B3JArztIMIRrtXU4VAFfE+3qNFIg6wkw
	4RsN7lFScmuBvz5qND6HOPTZSJS3LdHc0isO/YTkqLyRsDh4trUldBR6LnazGQDB
	iSTMetEwlgJQerOTBjc/fhJnf/iX15iwdKYe3z3+3eV8sZHNQcdZeqQF5jLrwvZH
	LI9nvsUaR05qDd0bsS+LA==
X-ME-Sender: <xms:r_sUZ54jV3MSlRWJZLiMBbbp-aTognKYJvfsdG31rF4KFPYXJkAeOtA>
    <xme:r_sUZ246uIeQHAQd4E1OKTkuRnVVYx-p43aukuLWal6M0MSr29N3aU5SM-mdYNFcn
    7yC76tSf1RnMbO_iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgvefgfefgffdvhfffvdev
    veegheehudetvdfgueffjeevjedugeevfedvfeenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhgohhn
    vghllhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:r_sUZwcNuIbhTS3eUwtwtNC0CMQzpQi5jlRDihQxQRPLEvjXgAiJ-A>
    <xmx:r_sUZyJCaRFckMDJDGW6XNAUEkvANyIrfVPPRj34KMXG9q1FyTQ_ow>
    <xmx:r_sUZ9J416rK5XQ_NhrJiwhj04xxgyL33jStJaQ7Br62OEL0cewOGA>
    <xmx:r_sUZ7y5yVLmqbujV-uvpD-HHW14oT-FTf5CU7bV7ObxcUn_3-0mhQ>
    <xmx:r_sUZ0UO9nqLlunQ25ekz2W4O5mO6-39RxTulsp7_RItpeOmKPFVD5js>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 25B07780068; Sun, 20 Oct 2024 08:46:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Oct 2024 14:46:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Andrew Kreimer" <algonell@gmail.com>, git@vger.kernel.org
Cc: "Taylor Blau" <me@ttaylorr.com>
Message-Id: <98c5e44f-42c9-47c7-9fa1-e6cc3b35cdb4@app.fastmail.com>
In-Reply-To: <20241020121729.27032-1-algonell@gmail.com>
References: <20241020121729.27032-1-algonell@gmail.com>
Subject: Re: [PATCH] t1016: clean up style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Sun, Oct 20, 2024, at 14:17, Andrew Kreimer wrote:
> Use `test_config`.
>
> Remove whitespace after redirect operator.
>
> Reported-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
> As discussed in:
>   - https://lore.kernel.org/git/ZxFyKXDCJkRZYYQY@nand.local/
> [=E2=80=A6]
> -		git config gpg.program $TEST_DIRECTORY/t1016/gpg &&
> -		echo "Hellow World!" > hello &&
> +		test_config gpg.program $TEST_DIRECTORY/t1016/gpg &&
> +		echo "Hellow World!" >hello &&

What Taylor wrote:

> Thanks, both. [Andrew] -- it's fine to do this in the same, or a
> separate patch in the new round. Thanks.

You=E2=80=99ve posted a new, standalone patch.  But what Taylor asked fo=
r was a
new round on that typo patch where you either squash these changes into
the original patch or have the typo patch plus this one.

At least that=E2=80=99s how I understand it.

This patch by itself doesn=E2=80=99t do much since the file is full of t=
his
style violation.  Which I now realize is what you meant when you
asked:[1]

> Do you mean that '> more' and '> another' should be handled similarly?

You were referring to other style violations in the file.  But I only
looked at the email so I didn=E2=80=99t catch that.

=F0=9F=94=97 1: https://lore.kernel.org/git/ZxKSFBl_pV2r99dY@void.void/
