Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704CB2E7F21
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234321; cv=none; b=KdU5H7uqJiGeGbWLhQUthTGhxsoQ8PmHDwirt6jsXB5Z9PshwdoBN2cuD9GCCcwL1DvVRsf+DPLtac8z+p4kXdeXC1+oo0S7djwxug3sNlBJLVijim6WZ0ec/3jEkJhYaY176PPchOhGWUTUmFIUbAaYDbhG7R7A9ned0b0IpKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234321; c=relaxed/simple;
	bh=Cx5Yn9XJLV9va16Yj9lSK8noWxvLUbI0TJjG+ynQBZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uw4id4CNHQ5tIhdpIgbED7VW8DEfPB+Js5hTmmtkM8i33R8drrYwsJSRcLfiFRJ8meEZh/g5QsekwZvDf7ZJaDCYlRiXSvAROsHQU8HiZPkrNXJUoUZCLdYJ5h88TyXQ8RlWMPf8zvvPatbwMmqLgQjToa91CZ6fh8M4XpskfKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SA5fMT7J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m5x/ldQ9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SA5fMT7J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m5x/ldQ9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 90FDFEC011B;
	Tue, 26 Aug 2025 14:51:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 26 Aug 2025 14:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756234318; x=1756320718; bh=grmaceuuG2
	qzIOv1VDhKME7GftKJzE7JzQMC2uheTXw=; b=SA5fMT7JrFEWQ+HrgUKwUZ2qRm
	TqMZ8WpPKoapoNpZEuEGCxGWS0Z1sbs7dVLJTVvCpFggH0AbBo4YUHs7xB/AcEyq
	qnmyNwUapGbYW/+KvX4hTd/mZW6o7Ox0AomdzfRP8UN2txzkGFnFLyKHbmEYqhQr
	/KEJTGUrXB9kgh2TcUHjWu39zMZJ/DdeuWYq2kVPq2djbYrF1b/R0QPd7L5vX0EO
	igy5YemhjePE5DDgF2gaYJsyt0kv4K6lgvu37CPu6kbt8u0+cY2M2hp5j+iTCDTV
	YLEwxr85w0nX3phDR3M2/yuH3PYlwZgav2FBiYGCRqT5QSo6ptB1Z9mkUnMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756234318; x=1756320718; bh=grmaceuuG2qzIOv1VDhKME7GftKJzE7JzQM
	C2uheTXw=; b=m5x/ldQ9SOz5/vb2qdmLRSi0xFKOQZFJexeSwXPdYIT7/+eCsSs
	FoybDlw6Lgr0sjNQJgerM1H4cZtJ28b7Dbgf08ZRgd7neP6NRLVMUi82zC70IHzN
	RbAyPD6g/xt4Kv3oepN65fGDUGCtJHgTtkPao01syQ+Gcupr7P5XJYEZ7IKgcCBd
	NBhHVliyajGDwSwW6DEPmTHhYS2/R3HWzJnzy88dEmhUch3Ydt/VfYh9cY2twPPk
	ALVssbowI3a4zMWkF181f+VAVqL5zo5Doary+wb9LLiqrJDrWJXBCa2VPdguKtu6
	PihemykCbezlb7dMvzGpziSbPb1iQ2P3zsw==
X-ME-Sender: <xms:TgKuaDnsujZi8L7AGnVoo-uQtU5K6X4qNc0qKRMO7dkXI4xQzZc6xw>
    <xme:TgKuaBbYR97jboyazQvjKA-mqYp-dB6meKPhD_e6ojWxyePGMtRqeWAtFGHCt8kBT
    nOiN_OoP6XtYrLMvw>
X-ME-Received: <xmr:TgKuaGPTIlIz8peZLTOY99EjBbGY3mkvXldyq1UcY19Jm_zE0Ku5JWJ-LVj6FHkg75EffBOHxr2kqZbFT3CkamDGCBGQBJoWgFhlsyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:TgKuaOYoRKnYIN27KKf35OseowVoksYPTp4A8DwkMFr58berJwDlew>
    <xmx:TgKuaM1bYsWMgcNijpNx7G2bRyS-LOiKwML-tb3m1VeimJI622ZIGQ>
    <xmx:TgKuaMdXQlj6J2PEQImZp3OJiRk2T1QMGXzyhv-3hmp0YsEFLXTH6g>
    <xmx:TgKuaFEQvcf7zyVAXPWb56eNr75QbXOv4xj_1NzbXjq04uapV8paIA>
    <xmx:TgKuaO36s-XlttLdZk8gQ4YzOOEh6weldDLmIhKhtvmVQU9OTNcW9zlH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 14:51:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/5] doc: git-checkout: clarify intro
In-Reply-To: <xmqqqzwxkjje.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	26 Aug 2025 11:46:45 -0700")
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<a6125a0128937392af283033e63d2b04776caf2c.1756148933.git.gitgitgadget@gmail.com>
	<xmqqqzwxkjje.fsf@gitster.g>
Date: Tue, 26 Aug 2025 11:51:56 -0700
Message-ID: <xmqqms7lkjar.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> -Updates files in the working tree to match the version in the index
>> -or the specified tree.  If no pathspec was given, `git checkout` will
>> -also update `HEAD` to set the specified branch as the current
>> -branch.
>> +`git checkout` has two main modes:

Another thing I noticed but forgot to mention.

>> +
>> +1. **Switch branches**, with `git checkout <branch>`

Does everybody really understand what it means to "switch branches"
without further explanation?

Also "<branch>" -> "(<branch> | <commit>)", perhaps, as working on
the unnamed branch (aka detached HEAD) behaves very much the same
way as working on a named branch.
