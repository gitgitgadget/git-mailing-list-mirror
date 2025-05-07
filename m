Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C384B1E74
	for <git@vger.kernel.org>; Wed,  7 May 2025 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746657724; cv=none; b=GQFllkJUl2yQUMJu/6Iy55Ib7uI4z7ELbQbNg3gnNgwDGcnFrHalKNmb93c0ogNhVhZagAhrraafg1RlZBfIk3stulJ911J0sRREmekJWiTtm+KzMjSLhKo08arWAhCd7XPD2IA+5v2DxyV0BBEHtAPvZuPS8xKBfZlhJ+MNSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746657724; c=relaxed/simple;
	bh=8SJO+zGLUX3x0sOhxHLUpqzCRq00JXk2tC8ZNJRUqm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nKzIYFf8Py6Y6ouRaGc0+M/sOgwbEYkw/AtrByIy1r3L1Qpll8br+tmq6Q4NNAoIXOtbzM/M+YHqLibTE4pED+Pkr3ioJOKDgEjepZQ+UHtkZBtVEl+ieY9vORmtXXd+k7LdA+v5vVxyEYYw2O2jYwCItXunqQ6bU5e73sfeNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NSJCqxtF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bGS0PC72; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NSJCqxtF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bGS0PC72"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1289A11400B8;
	Wed,  7 May 2025 18:42:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 07 May 2025 18:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746657722; x=1746744122; bh=py4olYoF0O
	uAfAKx2NTM2cVb1bd9BxNiea5ksj/NxiE=; b=NSJCqxtFxnwlsq4BOt8ItxJIYy
	yaxMSmwLtfzElmESp1EqDq0cVwmJ5UhiJ1TyHeLTLxH/c/0c5hZAKTXJChU0glfx
	nnOS3+CgrUIsxsEmsU7+lFpy2F0M9lXPxs5VCtJGy1aVLWnkAB7wfKveQVtGN2ZT
	bNueSgvcb7Y/o8MY6YVr2BMoJkUNvs/oFUMm6N5raJwpCxxuZ7B8v3jK3ZoLr2F7
	LiJ/D7lutHvAPOPaDSO/A19s7RDC95DCCcA45/SuPN3JQuZI8ZvoE8SAoR0wYEie
	ZwwL7NA/G9jT05GjGAciFwLOBMvofnpTmXwg8Ix03/3zaG7z/Ou7eU0ojlhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746657722; x=1746744122; bh=py4olYoF0OuAfAKx2NTM2cVb1bd9BxNiea5
	ksj/NxiE=; b=bGS0PC72E/50jpcja/M04/wOMqw8sl/jlkz+OntsfwQLP3MrOCD
	1wax9MAHkwssJd/5d6nqefs1TVEDIpQDyPYCbqRJ0JhgMUNFDV2ZF7yvh34hsx9o
	gGFQvYYNJN70I2hahqYdb41Zd786opo4WHH1vpTBcvnT/Gk2kHGA9ZisB6yurQex
	AJq8SV71TlcdgWA2sOu3pPLLvlH4aN/0L5pxdp5vuZ3+1G+ILevC0dHc/ebQ8VKv
	bM48JfAcKF0dJm0NyLbn6SuJsQVqpgJVT+eYdDNN5cgu5dqYco04oE+1sKiebcYA
	1VoBdL69gxVJxcU0J3XThXKqOM+4JwaKZRg==
X-ME-Sender: <xms:ueEbaPLASvMGmgO183RjE-JLnPBtAJTWu6wZ7iQ3pAr6CXJa16VnXA>
    <xme:ueEbaDKvO8PqezdKV5Jv0IW4cQYGb_5gXl5ZqCyVggnKFmbgLMwzj99B0Hd417rar
    fFiPJrib-Momy_NZw>
X-ME-Received: <xmr:ueEbaHvcSJVbCpx5w4Trx7ZeZDihMPRIK64ziiffX3UipprWNszwsufaJDpw6JBMY2h4xOblsZSYLuosqcW_u00Lxpc8X8d0rZVT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguih
    hthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ueEbaIbOYzZWdfxVuEGajRUybOWpDLHoRdFPLt1jrtRG0U0OBXXbhA>
    <xmx:ueEbaGYX16d9I2okFKmwtYUZ8LeZzxudjp6BJCLOKRJKNzpfs_yT7g>
    <xmx:ueEbaMA2iTz7Zf-Abl7UgPO1VSWp59EvlUZHaZ9ZRhKlcqMFaaHgKg>
    <xmx:ueEbaEZhOnkm1zRMAG1XXQBBrLp3MYO3QnxylwctLYeqk8G56yVoNw>
    <xmx:uuEbaOtLgf8oEWMHSB-CMHzA_o7t7L_xOA_snFqr4_P1ElMHO_h9qSsG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 18:42:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>,
  sandals@crustytoothpaste.net,  Julian Swagemakers
 <julian@swagemakers.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Zi
 Yao <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 1/3] send-mail: improve checks for valid_fqdn
In-Reply-To: <PN3PR01MB95970B9EA9BCAFA8A4140F70B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Wed, 7 May 2025 12:33:05 +0000")
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95970B9EA9BCAFA8A4140F70B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 07 May 2025 15:42:00 -0700
Message-ID: <xmqqzffo9h6v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

>  sub valid_fqdn {
>  	my $domain = shift;
> -	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/) && $domain =~ /\./;
> +	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/)
> +		&& $domain  =~ /^(?!-)[A-Za-z0-9-]{1,63}(?<!-)(\.(?!-)[A-Za-z0-9-]{1,63}(?<!-))*$/;

Yuck, can we do something about this overly long mess?  

If use a temporary $subdomain = '(?!-)[A-Za-z0-9-]{1,63}(?<!-)',
would it make it easier to spot the repetition in the structure,
i.e. /^$subdomain(?:\.$subdomain)*$/ and make it less error prone
when somebody has to touch lines around here, or something?

But other than that, looking good.

Even though this allows "foo.local", on "darwin" it is still not
allowed, which sounds like a regression-free change.

Thanks.
