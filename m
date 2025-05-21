Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90FF1DE891
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840261; cv=none; b=NEijH96aGmulIDvzU669HDH63Xd67FSZU8sEQJQUpwSio26A57Lg0Pc95nVy7TmeMOO6o2FDWIVzZxdLgP9ihkrb6sDXjRww6TKnSmBib+fC3DRFyYRft88D6sw5kwaisUqUn09/cRorNydrU9ihx0TJmv7jOnYi3WdemlpnxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840261; c=relaxed/simple;
	bh=BmcaCL+7EgukYkn6pM4/qi3f/fPJxBbzEdByU/bphIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FQRBeVDoYct1d2a9uaWWZeTrIqF/nR3P59YEuun06V7KCwulnAfBAT0i5pYwIYMfzHz1S5w917r8upchVATAslxUGdt8SBRB5RQjum7XYT7lOOhfrJvcP8XulTnZh0wmVOcaDAUtqPR5+aNZtfZY0e3C/DLikhQPEn4Qn2wq5FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dVrcbMWo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q3Ku5RhU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dVrcbMWo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q3Ku5RhU"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AE98D1140168;
	Wed, 21 May 2025 11:10:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 21 May 2025 11:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747840258; x=1747926658; bh=v233Wm/7u/
	tvK2Wb22XyHlfVDeK8KnEi27vaHm2kXFA=; b=dVrcbMWoF9qYwbYc9CeOBZ5RmM
	k+pTal6jvjNp2XVeVboM6puckm0MfA4hiuK5I7VElTNH13rqTb46qtELi1nvL+a9
	9QiKQrymZEIwbjYSF+ZO9XDTXWhcVgY9IN6q4cMAbP0WM9B9tHljOU3EPc5vtu8J
	ahuTkuM3cYhj33X6+5oW4ffQrFfOR46ZJI0Asyf7/jds4oxOWjrI6Slh2uaznXh9
	Wr1yVg9ouLEVvdZrR5m/KCBnu3ceZO5GXYUesS4U9kox2V9r3Qk+L8bFa6nSNTqp
	lDNHww9GwZTJD4gEVgDxYGkONHsolcVPHvy9GsnuaxW1Ux1G8cKMFGJ5mcyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747840258; x=1747926658; bh=v233Wm/7u/tvK2Wb22XyHlfVDeK8KnEi27v
	aHm2kXFA=; b=Q3Ku5RhUT70T7jzOEwfm1IQdO7+N47Aoh1Thp5di5olSn41izUg
	eV3D498raB+AZlMEfzPu5lvqkt9Q66QPrxhySseg2bXJM4u3nshWV4YxKWbNbgJb
	MSV7v1KDsp1FtDcPNpinohAApkYb2LVwjyzeVTdDqkylQaNB/gdvXeTT3KFss/IB
	czcmA3bHU4/GsIZJYTA72nIE97LRUANrxjrUm1dBJ8h1DOxH+EF4UiRSO1c5paJa
	chy59a4sI3kkAEpVAnIhBWsqbEUuOcagLniEiBGq1g0mYb0dZL7hmupyx7Hh4T9q
	+x/i1lh1tLTwxRDb7PJRLXSFMORo3jG5MJg==
X-ME-Sender: <xms:Au0taATchBzNJKNb60zMXM-3pH9pD88HDBpM3pbpe382Bcypjqp9tw>
    <xme:Au0taNxh4xVWqG5DLT6Rlc2tcH1eobfWIpJXIpMcp6jBy613S-Ascx11Z-rKRpetD
    4drFoseQSz-bq64gA>
X-ME-Received: <xmr:Au0taN2q7JHlYU5XonaD0G_wmS1JGVof_2bII1xgDOF9TBa3NmrsjIpEzA7Gnn3XPk5c2HVFRFqcVFSFBbjokjCCsVDakH5_HYUmmZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefgedtucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhh
    uhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhig
    rdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Au0taEC65jHZt6qs-0Pfr6cqfhHpTJxBg3Rs1FLMuB99qXlIBLX6iA>
    <xmx:Au0taJiR1vnXAjIuJVRfJ36KgCZjAJz1U1xHKPYh9Pqn-_ZrOEBWiw>
    <xmx:Au0taAoqMbAR_89vgWYfCDyldqniGM2l60mCDH8-OGKl7FL2hcr52A>
    <xmx:Au0taMhziRB7E4xqUcaJ0P7CJzRLGWZO_x4ZzLFbA664OPBEdplctw>
    <xmx:Au0taOjYj8Uq5LtllkdoK6xz1Y8ZP-YS-UAUo1hj0vwFz1RAyd5vyRIz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 11:10:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  git@vger.kernel.org,
  Johannes Schindelin <johannes.schindelin@gmx.de>,  Jeff King
 <peff@peff.net>,  Elijah Newren <newren@gmail.com>,  Calvin Wan
 <calvinwan@google.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 2/4] editor: use standard strvec API to receive
 environment for external editors
In-Reply-To: <aC2HF1VEosDMY_A2@pks.im> (Patrick Steinhardt's message of "Wed,
	21 May 2025 09:56:07 +0200")
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
	<20250520193506.95199-3-ben.knoble+github@gmail.com>
	<aC2HF1VEosDMY_A2@pks.im>
Date: Wed, 21 May 2025 08:10:56 -0700
Message-ID: <xmqqa576c83j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The order of these trailers should be reversed -- your SOB should always
> come last.

Yup.  The intent is to record what happened before the patch was
sent out with your sign-off chronologically.  Dscho helped and then
Ben finialized the patch by signing off, hence the author's sign-off
comes the last.

Thanks.
