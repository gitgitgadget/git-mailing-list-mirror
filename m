Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178154414
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405683; cv=none; b=tLu4wajbTlh0O5WmCb7yS1nfw4DJAC3xHvSsNZNCGJSRZTVTmcuIIJWg8AT9SC7TRNHK9uxFSLDVEDoVZ3zLRViymlqQSYy7MGMxVtGIM+G0CqwVUaTW3mq44+ffazzxojawSLgJaISyTUxEIxaBhpPD8CHyJ5N4fCha6L97b8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405683; c=relaxed/simple;
	bh=R7gK5YXoIffYz/fe4L8O368XkVMAeKZP7LDF9HQZlO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ji2B1UlqI1VishdS00F0yEQVNj5rwJZDBFmt+JgAmmzJo4LaE9mgGOldminVKWhlee1YhdkJBrECwdp5p2rotm7pdT9aDvNBpAJVKkLUHoG39McjSjX/wTHT/k4d+syHTwEMRR6AdRz/G5Z2wVEtsQpe63HsNV7OHSuhURSMz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oQ2HgcI3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OFErc62a; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oQ2HgcI3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OFErc62a"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 33C96EC008E;
	Fri,  6 Feb 2026 14:21:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 06 Feb 2026 14:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770405682; x=1770492082; bh=KU2U4+i9vq
	nxExoIt0ZgwjWNfJCTfsau+rqTKfM3OGM=; b=oQ2HgcI3+3CgF0KiTEbIYT38vg
	FiF2IJoPI0iuejEL73L1Uiekfh/wG6FsJw05bxitF3yUOO1PEegJ4Q3Gart154Gk
	WGNf0cqdyiA7/RE+1LvVC7YSD3ho/51wxld9FuYQpXmr4HoqIPOHpNCro7uqcsoJ
	Fuatj/gcZNMx5nqcUMkulKlL+p7+1+7HmSiDENmle3jGq6QxxVucCVS3F32I+6az
	ZeXDygs7hWZDg3vGdGmPQQ6gC0N5MrPG6mQd//MLFlVCoo/z6TOmuAkMdt4YLrl1
	1ORMA0XWeRNRpyUnyy+KJPYn3BexExIOckFo0jrwuvdBl83SuW74aK5NSUhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770405682; x=1770492082; bh=KU2U4+i9vqnxExoIt0ZgwjWNfJCTfsau+rq
	TKfM3OGM=; b=OFErc62aRkQoU4TT2UwNdYJJY7Ac+MUjhvbYSnwpC0Si1efN3x1
	UQU57qncR/0R3AaH7mcXicodQnDERyTdBd36QPA5qcM/q7oAIa+fPgF5ohgvUYuw
	laumAl1e4jErFWS/cf9maCyuMQEEBRstUqWccF4CKmbqRyZu+XOgSXqz2gFWkhzD
	tZlCGSTgiKdPu9+YbIZmP8SAtPoLip10BdpDZEcgPApxXfmUySuk+KvYMFmEoUw5
	mi0QRKBo1uNPEP74RcXbdoVfDWF9SQDhUnvkJhopPEjWRZuf+hA6AqeZY7JlMP15
	hgHv8uTqryfQqh+zMFZoLYHgzkITeSwK3WA==
X-ME-Sender: <xms:Mj-Gaf_0zyzpWdUi0m2KoKhVoNmipyfsyBYVP06VLyY4O2w61TBqbw>
    <xme:Mj-GaYRRiF9CeeYt6X6gOZDpBJua1qOD9YrSTxTK9NxhjKrYx8j-nG9JlHalKZrGa
    VMv_iCVn8GPLO9reAly6S2Hs711I2OhLhnqZVG8kzAKQSk31QIjcA>
X-ME-Received: <xmr:Mj-GaReGnTc4y-UzEzlrQYdEnWY_zB9Gv20ko69dRanY-Gy_V-1uvLvgIEdlu17JQlTaj9s0ayDNuQBoUh-fP2gciY2e6ojAiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Mj-GaSTDM_T39x0fa3SnG7FYHW3OpsBxAdcS3DCB9CQzdquVp0xuNw>
    <xmx:Mj-GaVJGqvTUJWuL2W8JfJz_eMDSRHDx54EYM_B0neafMp79ow22Ow>
    <xmx:Mj-GaXIUSPDQkatF4oJvpSW0MY8JaX2AAWXCtNnS8iwTAWwgCsfqRg>
    <xmx:Mj-GaYiJ51mHpQ-rXO_ycKvGJnCjKQek4yaWa_Ch5g9z06KLODCn-w>
    <xmx:Mj-GaRlxi35cjnRjHJY9gn2de75x5SQVsgFfrpmgAAfN7q3eIz7HOKrd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 14:21:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 2/3] add-patch: Allow interfile navigation when
 selecting hunks
In-Reply-To: <24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
	(Abraham Samuel Adekunle's message of "Fri, 6 Feb 2026 16:56:14
	+0100")
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
	<24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
Date: Fri, 06 Feb 2026 11:21:20 -0800
Message-ID: <xmqqikc9ekzz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> @@ -1566,11 +1589,14 @@ static int patch_update_file(struct add_p_state *s,
>  						: 1));
>  		printf(_(s->mode->prompt_mode[prompt_mode_type]),
>  		       s->buf.buf);
> +		if (s->s.no_auto_advance && all_decided)
> +			printf(_("\n%s All hunks decided. What now? "),
> +				s->s.prompt_color);

This gives an ordinary prompt for the hunk and then another one
after it if we notice everything has been decided.  I am wondering
if it wants to be more like

	if (!s->auto_advance && all_decided)
		say What now?
	else
		ask the usual

?
