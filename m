Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176DB22DC2F
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850318; cv=none; b=IBr6sJCsoC05D5rlLDLQG0Zndy3zZ1ZC9bbgIPiBvs3osYkMlt0oQ6sBk+W597OwepXO8uUYQ83Enw+3W238Yb3kcOGZ291jpDITAtPkhDulsy9koAW7FfruMbTJO02AwOweHQo0M1m2swLETcytxTkcfTV7L8DYbdV41ra1uNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850318; c=relaxed/simple;
	bh=J8yiAaN4dDiirB9Qb1iS24l6THc8PmV7LlZT3+bqoWY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gu85pNgft+6dmgAKjVdeTJt022bHVzIdkziolfLQR778aiiFt36T522EcICStAiCuZOiNunYpCrEM3JJ7gAPJ65ZLysDmN4xMUXTGgOWJjisDYd5bkRqO5aPJiwqMxD9WAW0/YmXj/51H47IJULVgi/xGhqa6ONMEHzy9phyDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ScFxgpZ6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J4Br4V3H; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ScFxgpZ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J4Br4V3H"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 306141140263;
	Tue, 14 Jan 2025 05:25:15 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 14 Jan 2025 05:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736850315;
	 x=1736936715; bh=EKL05lN3W14c1eanMsE7J1lJ65FJj40LKW/HykRTxRY=; b=
	ScFxgpZ627LQaGvzSz1NlYmPqeFh3NEaEHDJeGKe+p/8qXU/kPYAP3l24WieuRsA
	8mT+XsywfLVW5LRzZ7lVabACVoGt0JOT196Tqk4skVNt2Q9FHJ4m1Scq7bwZV/z8
	VmfQdBOMjZYcpW9ouAPmV9fsnd2fMU4y0FzRvTpS4jgVDL5ZSRmM1qYm71oc41bi
	2tBhz5p8Wh4HSHKjxsCp2lB3jLmUsPzk9e5zFHeII5zDH1EjBC2eN3b5X9KZeJ+6
	6913PRS+ds+e5qEjdh0w7FvYu5uGRiXEMheyvGJ5bwfu2drkJyEjp80x8QVdtLQo
	LmLI8HK26iAec87zTb7o1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736850315; x=
	1736936715; bh=EKL05lN3W14c1eanMsE7J1lJ65FJj40LKW/HykRTxRY=; b=J
	4Br4V3HjU81CJpzp6aodwwx/VzgpXYWTdrlViwBaCBvNiXIj8jrXxGvU9sjJbtzp
	I6d2SCWLt/S/qo3onjh8PwQTVsv2AW8OCla7Wc/cruJKiF5XfRtwISGPSMigH2af
	JJiEMZJ2tm5OtRqfjDzpLYM9IgjKaZPQpi2iNEq/lTVqBdGJANdzPwZ5kphgLrQP
	STXpPCQrXzeUipoV7rPUdc680WtInBXLHguLzI7vEuawa7S0Q2bXr5FylKSpE5Gt
	VBuJHF3Mgwuz7o1AqI6WwLJmVUaoFMYOWAfx13U4lL0gObfPtNGAZauSnWx46XSc
	66t6PcUD03V545xFLa4Lw==
X-ME-Sender: <xms:izuGZ2Gfqu6-HgLesUUOgAS53fznKFcR4E68YE31T1Cl44waz2o6i60>
    <xme:izuGZ3UeOT3i2X9wGF2-1r1qYdOSqfyoumu3uGL8M6yckHRSuzVn3gzZIH5_owHv3
    XHnYnjM_yRXmfKZ3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefhuedtuedttdei
    gfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:izuGZwJu6-MtiweTZ5vmgrFuzXyjTh7V9WYUnowg6epFMquIvL_0xQ>
    <xmx:izuGZwEPz_pYgAL7kW-Trc0Wzid7rViGStn8jlYEiAQpRaImP1jyPA>
    <xmx:izuGZ8UN1MDo2dEFW4jZFWFoof4LU87CnTL4KSTV3bIwhFIqgPYpsw>
    <xmx:izuGZzN3K6ccLxchNNqDzz1xM8M66DNVWysQ7xq6YkQLqqSPSdGN9g>
    <xmx:izuGZ3eZftTeifVCZvMQjoiVtHWP4mM5lics7pp5kmJcDbFVek2OxUx8>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F3EB278006D; Tue, 14 Jan 2025 05:25:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Jan 2025 11:24:53 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <b0a3889a-9d7f-4663-bb00-b1b457931fcb@app.fastmail.com>
In-Reply-To: <xmqqv7uiac0m.fsf@gitster.g>
References: 
 <e5b20f9ceb437a82c422136cb81b05a0521cab07.1736682716.git.code@khaugsbakk.name>
 <xmqqv7uiac0m.fsf@gitster.g>
Subject: Re: [PATCH v2] Revert "doc: move git-cherry to plumbing"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jan 13, 2025, at 17:56, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>> This command might only be considered plumbing by way of the plumbing
>> contract that says that plumbing commands have stable output.  But
>> hopefully listing this command as Porcelain does not give the impression
>> that the output is not stable.  Output stability was in any case not the
>> motivation for moving this command to plumbing.
>
> I do not follow the above reasoning at all.
>
> It is not like it is a crime to intarctively make use of a plumbing
> command, or we intentionally try to hide plumbing command from them
> by making it deliberately less accessible.  "git cat-file commit X"
> may be handier than "git show -s X" for some people and that is not
> to be frowned upon.
>
> And what you call "might only be" is really the crucial thing to
> consider.  If we want to keep a tool's output stable and machine
> readable, we need to mark it as "meant for Porcelain writers", and
> classifying the tool as plumbing is a pretty much established way to
> do so.

Okay.  I understand now.

-- 
Kristoffer
