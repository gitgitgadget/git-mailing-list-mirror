Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E88D1531DB
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004042; cv=none; b=a01UqyH+1oUgzpIvbzh/a2QBek+sSrDqeV1ooT/gsgESWgsY2bZUYtFfPNfzmzWCrQEr+XxpYdENPuN+6fHQpqmovv0q3t2S8EdUHFGWYHBwU1DYDwx5F8JQ9IuM2nSd4yQNoQJZIzOtzu2Kaz6H7smyqpBrqO8wN1XuvAwc7LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004042; c=relaxed/simple;
	bh=oEQwTTbeM0bEr/fTZadRTcFv5CpirdRtswtuJTeEeMk=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V1pvYZ7AGfnT5UB0QcsRPPWY7DpDlXdsspBr3fRqGyHf6IYIsWQCQNT6P+YksZg6rEmWnXF4fqGZpyCWPXM4J7+/DIvoNcUdLiywj+F19+mIV0HleMiknpqRuWGsxEdyTUb5tYibO/qZMIwAV6QqsrxMqSOCJl3BTw5bp5geork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gUrxfl4E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=au3UKM7i; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gUrxfl4E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="au3UKM7i"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 606931140259;
	Tue, 19 Nov 2024 03:13:59 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 19 Nov 2024 03:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732004039;
	 x=1732090439; bh=oEQwTTbeM0bEr/fTZadRTcFv5CpirdRtswtuJTeEeMk=; b=
	gUrxfl4E527TRmndP66ypuFdRXu2fwftXMQwwfHqqrmowNOA24P5zAQAUfdvpyDc
	/3FC+RMkRnt79t4nExRl0hJYH1iv4dXW2dlgYjcuK5IBXp1zzUlHi1tQb11i6Tkv
	UzDeR/N0uxe2FGU/7BY8xrPrRXCYGDnL/5z6KgZ9r7TcegfpOUAD2lmAnk18yWdn
	4FbNMxSiu44Ys98YbDG6kXZOl4ZcsWjqAQfiyqRySG0mLWV3Y59gMvl28y/QHJ2w
	9n0vFChpzxVFLJbajJRMtMoXoHfU/47n0xy0wKp4/2U7zrodx+QcF9gEH2+JiWVQ
	MgRlNPrCuXdvNTI1HO0XKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1732004039; x=1732090439; bh=o
	EQwTTbeM0bEr/fTZadRTcFv5CpirdRtswtuJTeEeMk=; b=au3UKM7ina5AP6Skb
	71nbhedeCI/+LWt594FtmCyoQSVWdNWKe+JPrfMT0Kd/uRqnN3fzYf0m8Sr1LGwu
	xVpn4uaxZRck+rEFC8JDR7g1qROkTx7neptgD76n3j8KQ4jBCrtlHVgDv6krhS0M
	LfPVxkJWYz62G0y6iEoljjxDhkj0SayRgH6PmPZYFX8RbztdtZF3OpShTwXkHmcc
	AUi/DGgnfwah7Fcvv3PyNg1Ggk17v4eFfkbZ76nwihK2w5CGdbEpbYpkRD1PfpfV
	Lq3iAkqesZxeE56RCsicwoH4GcCc7rWyFLsMxz03Vy+IyWvjtdNRDvjtO5ad1cgW
	J02OA==
X-ME-Sender: <xms:x0g8Z9BfPBSCzkmZrJBi3lE-cVtWNUpo63vNdjCEfuDxo3mD1qD6A9Y>
    <xme:x0g8Z7jHf9dasbVaE4-F13elZgw_ReAM0QkLUQRcpXdbgKrT5NgIOty5M4GWO0dwi
    9WVqiV1rZhDptwA-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveeiledtke
    fgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghk
    vghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtoheprggpsghughhhuhhnthgvrh
    esphhrohhtohhnrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:x0g8Z4mx1zOGQyIy4a5gHqo5FjhI_xrYexla3btYM_HrGAPXDIZi7Q>
    <xmx:x0g8Z3wZh5ntAHm8UgtQMe7Hqw1_4Ibe5NYWT_Cl7SigqFF4HBA20g>
    <xmx:x0g8ZyQG_wEJjVEE3rzHwJrVZHdFx-2ANZxtsgE6ZObqpmbQddxZPg>
    <xmx:x0g8Z6aRMFt5LV4lAIXXiaaZmklgVYWw5fVej5gj8wL6lb21rxlKzg>
    <xmx:x0g8Z9czr6LMqzJTySgue9RR0yGPhMwx7ghIcdWe0AZfm7U8va3HPEJ3>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0D0F5780068; Tue, 19 Nov 2024 03:13:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Nov 2024 09:13:38 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: rsbecker <rsbecker@nexbridge.com>, "A bughunter" <A_bughunter@proton.me>,
 git@vger.kernel.org
Message-Id: <271da43e-22d8-4f67-952e-72d2af8f6b1b@app.fastmail.com>
In-Reply-To: <022f01db3a10$7fe28140$7fa783c0$@nexbridge.com>
References: 
 <4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlSI5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=@proton.me>
 <MBCJkxhVnx5AhlKkq15aTn5FYI6cG-wdqqwQ84mVH9zjf-YehSrRWPgd-UwdTMrYhS2Sgofbyn2bS7iMlANyyYf_Z6b6_e3FH0hRm5VYciU=@proton.me>
 <022f01db3a10$7fe28140$7fa783c0$@nexbridge.com>
Subject: Re: How do you undo an add
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024, at 00:20, rsbecker@nexbridge.com wrote:
> On November 18, 2024 5:10 PM, A bughunter wrote:
>>BROAD OVERVIEW
>>
>>bugreport[A], question[B] and use-case[C]. These are all related but s=
eparate
>>threads for the purposes as labled. Please do not cross-post or cross-=
quote. Focus
>>on productivity and solving these. You are welcomed to view and partic=
ipate in all of
>>these as I contribute more.
>>
>>use-case[C] - git question (short) rephrase with use-case added.
>>
>>ADD, ADD, ADD why cant they get that: ADD. ADD tracks files for commit=
. It's
>>already been commit : push failed. Failed pushes piled up. I need them=
 untracked.
>>How do you undo an add ( many adds): simple question. Without deleting=
 any files,
>>to repush 1 by 1.
>
> Once you have pushed an added file, your only option is filter-branch
> to prune out the
> invalid content.

git-filter-branch? Why not `git reset --hard` with `push --force-with-le=
ase
--force-if-includes`? Maybe I=E2=80=99m missing something.

> Following a commit, you can use reset --HARD to move the branch head b=
ack to a
> Commit where the add did not happen.

Yeah exactly.

--=20
Kristoffer Haugsbakk


