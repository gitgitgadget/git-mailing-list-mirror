Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCC632ED2A
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324757; cv=none; b=Ly5eEW9MMZ1/v3LwEgVTCuh82Hri94I8ubjeGMK9XgVGksPWxioWQqbkmk/EOMyWynj7tMV+ugAJDuzvQ/vUnuJRx8L8q1wk2PvC5rjL6We3+/d0J3Nn3QjAl1x7mk/qCQjet1230KvIqdK2aYHgc4ibVmy4uFPcehwJrWE3AiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324757; c=relaxed/simple;
	bh=HyjEwgfnTnrLmGkolMj3gTU1TtKJqvo7OUz8/Rd4gYM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KaWimxVoqBy9+tn/lzXjSFnTRL0RAf//J0zC4Tgp+TVAeDas12YROi0SreF27s4kwvdjeh6sz/oFzA0+0U7QDnwiQZVSdDcQbY53P5MgJwtArKHEj2TBM6e70SzH6j+OhAGIkoE+Ds/Lsz9bKrnDI/YNKoyuxYY7vRqsPzJQCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=f4tN0bKI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gkbh8dym; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="f4tN0bKI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gkbh8dym"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 327FE140012D;
	Thu,  5 Feb 2026 15:52:36 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 15:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770324756;
	 x=1770411156; bh=Qdr2dmk7STK7K+8ONTxhm0Iaub0xXGiB3RvGnDL1cqE=; b=
	f4tN0bKI+Ul21SFeiNPxAkWOmP+5hlNgCppQqNDmVwPQmoXfhxEijbgNShKee75R
	nVQvLN01gO4jgjb444XXWZ9aflIBb4URo1YeHlLLbBMEGl1S21O4Zt9iLFYhiatT
	m4g+qJl2ujBS/n4SZQ1TKTVWAR9PV99NQKNgJfVGtUJZIcWdrZpa0ZU4lXyGyGFD
	WBzwg5+vouER2GrkM5eo48C9a2s8tV6dzZqpCJNZ54eyQcwaJJ+rUFkAUROxU8HM
	Vbw6psMXr3wUSAlsCe3venttBT2y3c82yIV7xw1HBryK0T4LH19PYX+Bm/os++zi
	2QauN7kugiePRUA8GsMJyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770324756; x=
	1770411156; bh=Qdr2dmk7STK7K+8ONTxhm0Iaub0xXGiB3RvGnDL1cqE=; b=G
	kbh8dymQCOlAqvv+CztwXPjHeDpdLKviu1hOamnq8QanTfRTZkyz3BEuVFZWNUIi
	6OyTVswBm5H/3ZVqWZmi37Xdk16J4EQku/S4qBe6CxTrZRbExjZ/MsBPcnbleLxY
	VPsaWB42EseGnvRPyDmUxZs6/3IlFcc5pc/nVZphup6ZcYLxB5LxUwpiEEJUwk4h
	4FvO6PR7UzlNiooYspsC2DSF8EwRDda7hzmeGcMvYuR+k5efdYb5COOOaK2I4uSv
	Fyl17R+wraoaJRy5J3S9jHzWg0dmDvoArpwEZ1/YZYwKgVtaLUCR20OF1YNK8Nsc
	JbiulGS26FAqrCJMuZ/+g==
X-ME-Sender: <xms:FAOFaRfZzEFTa2sp62IB3Xp2iamkI8nvnFCKqU_JVY-OMmmqB0mautU>
    <xme:FAOFaaDsBf4_BRkzgw2VRjnGWf2E67_c3Kag2C4KG7WhJxYwmIwAPLrnHCT5JexJT
    4C5Wyv2nbOh_k_chY_pEZRt_yDX6UYydYAlophB2-ozxkeZ0a91LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepmhgrnhhuvghlrdhlvghrtghhnhgvrhesqhhurghnthgtohdrtghomh
    dprhgtphhtthhopeihrghnnhhikhdrthgruhhstghhsehquhgrnhhttghordgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvg
    hvseihthgruhhstghhrdguvg
X-ME-Proxy: <xmx:FAOFaUBQBPzIP-mpUP90KQNx6lzqGrWv2bK072vTCMeTYidbFIJQfw>
    <xmx:FAOFaYDVkC4ip3Z0brsqtkDc4ug4FI8beGrGAuygd4rul9DzkMAcNg>
    <xmx:FAOFaXqkkfq3eaxELXu0Rpx4iUJKU-ZNwSU4O0BR7C02Vu8qxXxfJw>
    <xmx:FAOFaan9PPro-IQSodwGW1YGr8-7BAky8ggyKoC1e4v5Wt1nHvTihQ>
    <xmx:FAOFaSfvPPP2ecgHaNiKwW6rnW1fRZKUDHpZjj3L-f_Mn4ehYOE6stqc>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F08BF1EA006B; Thu,  5 Feb 2026 15:52:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArEMSgAokomg
Date: Thu, 05 Feb 2026 21:51:51 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Yannik Tausch" <dev@ytausch.de>, "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Manuel Lerchner" <manuel.lerchner@quantco.com>,
 "Yannik Tausch" <yannik.tausch@quantco.com>
Message-Id: <fa7fc215-03eb-492d-9af4-457482c56a48@app.fastmail.com>
In-Reply-To: <3724733C-FECB-47F5-841C-84DE9792332D@ytausch.de>
References: <48B1AA62-D7FF-439E-B770-1127E1EE0E79@ytausch.de>
 <xmqq4invm2dk.fsf@gitster.g>
 <3724733C-FECB-47F5-841C-84DE9792332D@ytausch.de>
Subject: Re: [PATCH] merge-file: honor merge.conflictStyle outside of a repository
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026, at 21:27, Yannik Tausch wrote:
>[snip]
> From bed0035d38072c67e0be8eedb0cf98da936cbac6 Mon Sep 17 00:00:00 2001
> From: Yannik Tausch <dev@ytausch.de>
> Date: Thu, 5 Feb 2026 21:09:52 +0100
> Subject: [PATCH] merge-file: honor merge.conflictStyle outside of a re=
pository
>
> When running outside a repository, git merge-file previously ignored
> the merge.conflictStyle configuration variable entirely. Teach it to

Preferably the message should discuss the code as it exists without the
patch applied in the present tense. (SubmittingPatches present-tense)

> read from system and user configuration files using
> read_very_early_config(), so that users can set their preferred
> conflict style globally and have it honored even outside a repository.

The update to the documentation might merit an =E2=80=9Calso=E2=80=9D? I=
 dunno.

>
> Signed-off-by: Yannik Tausch <dev@ytausch.de>
> ---
>  Documentation/git-merge-file.adoc |  3 +++
>  builtin/merge-file.c              | 11 +++++-----
>  t/t6403-merge-file.sh             | 34 +++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-merge-file.adoc
> b/Documentation/git-merge-file.adoc
> index 71915a00fa..773037aa14 100644
> --- a/Documentation/git-merge-file.adoc
> +++ b/Documentation/git-merge-file.adoc
> @@ -86,6 +86,9 @@ object store and the object ID of its blob is written
> to standard output.
>  --zdiff3::
>  	Show conflicts in "zdiff3" style.
>

You need to replace this blank line with a `+` if you want this to be
the second paragraph on this option.

> +The `--diff3` and `--zdiff3` options default to the value of the
> +`merge.conflictStyle` configuration variable (see linkgit:git-config[=
1]).
> +
>  --ours::
>  --theirs::
>  --union::
> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> index 46775d0c79..1b6e16b9cb 100644
> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -95,12 +95,13 @@ int cmd_merge_file(int argc,
>  	xmp.style =3D 0;
>  	xmp.favor =3D 0;
>
> -	if (startup_info->have_repository) {
> -		/* Read the configuration file */
> +	if (startup_info->have_repository)
>  		repo_config(the_repository, git_xmerge_config, NULL);
> -		if (0 <=3D git_xmerge_style)
> -			xmp.style =3D git_xmerge_style;
> -	}
> +	else
> +		read_very_early_config(git_xmerge_config, NULL);
> +
> +	if (0 <=3D git_xmerge_style)
> +		xmp.style =3D git_xmerge_style;
>
>  	argc =3D parse_options(argc, argv, prefix, options, merge_file_usage=
, 0);
>  	if (argc !=3D 3)
> diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
> index 06ab4d7aed..9df9f878c8 100755
> --- a/t/t6403-merge-file.sh
> +++ b/t/t6403-merge-file.sh
> @@ -428,6 +428,40 @@ test_expect_success '"diff3 -m" style output (2)'=
 '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'merge.conflictStyle honored outside repo' '
> +	test_config_global merge.conflictStyle diff3 &&
> +	cat >nongit-base <<-\EOF &&
> +	line1
> +	original
> +	line3
> +	EOF
> +	cat >nongit-ours <<-\EOF &&
> +	line1
> +	ours
> +	line3
> +	EOF
> +	cat >nongit-theirs <<-\EOF &&
> +	line1
> +	theirs
> +	line3
> +	EOF
> +	cat >nongit-expect <<-\EOF &&

Some tests in this file already use the regular expect/actual but there
are also many one-off names like expect.c/myers_output.c. I don=E2=80=99t
understand why. But I=E2=80=99m just thinking out loud here.

> +	line1
> +	<<<<<<< ours
> +	ours
> +	||||||| base
> +	original
> +	=3D=3D=3D=3D=3D=3D=3D
> +	theirs
> +	>>>>>>> theirs
> +	line3
> +	EOF
> +	test_must_fail nongit git merge-file -p \
> +		-L ours -L base -L theirs \
> +		"$PWD/nongit-ours" "$PWD/nongit-base" "$PWD/nongit-theirs" >nongit-=
actual &&

It seems you might as well break the lines for this command further with
some `\` to get closer to the soft limit.

> +	test_cmp nongit-expect nongit-actual
> +'
> +
>  test_expect_success 'marker size' '
>  	cat >expect <<-\EOF &&
>  	Dominus regit me,
> --
> 2.52.0
