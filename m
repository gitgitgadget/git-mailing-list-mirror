Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63FB264FB3
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869542; cv=none; b=f2JzQOvNEE/wlkeA8YkPeSrc+uGD3e71c+hp2/P5uHBQTBCRP8JmHwa1gt3oo3A/ssx5ZY5v6I5KwA2JJfTWcsXJS4gdR9ItrafefKWgO5NMiJdI3InCDcVqRQA5vQRkOiNoiLeF5dhFpVWCsZfzpFbGxaWLe9qaj5PhRGjEiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869542; c=relaxed/simple;
	bh=y9WvMPbCCeiYeGMPQgtsXZK9FDP19x7UKUzZSb9i1Qc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AqPq4D62GBH0l0fTiF0Z1rzqi/lPGQpXL6gwIOFoZDOkMFuscAQlBjbNqCTZO/ZZPEtMblJm61FoHH+wOqucEXVi4P/S4T+18dzb0Ko0bpZsu6Swk5I6y/iczAGbi/qExgqsftQCtcNZYSlNpzruCv5wG8sHYizYGrIdoeLaWW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KKe7JcaT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ktA/DOvS; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KKe7JcaT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ktA/DOvS"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5916140008D;
	Wed, 25 Jun 2025 12:38:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 25 Jun 2025 12:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750869539;
	 x=1750955939; bh=bl/niHL1FoJai5XpFvXnoEZtvqwLWLErkWPOMzmwYRE=; b=
	KKe7JcaTijQ8wpRo1OwV8yryH6t+RcxsK9Ge5EcpQqsSDUgxlYyIsy6Rco3o0rdw
	BiebTw4TrZsaFWKtkQng7laB3qKtvwQ7+zXWHXDmE6SgghAbg0aWo0AslfoRVWEk
	SRTiJZDraQn5fSpcwd9YafN4Eg+CcWnuqVzyAMeJxfVgAkMBq5QhPZS5YYjtZDNL
	5sW0uRoYbQVOZhBDdRBmQQWFvK7mNHJimlGl03NqD8IDUzDdL0/nuspKwR/bxgSl
	ZeRyZMGGp16xrjVS3GLedNxG2sH/C1/oR3g+U4Uq1DC6MuxSNL5tFx3xYMLAdnxn
	9v2I1E26YKVWtLaNiUxrwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750869539; x=
	1750955939; bh=bl/niHL1FoJai5XpFvXnoEZtvqwLWLErkWPOMzmwYRE=; b=k
	tA/DOvS6n9EWwCaHxwdwoViQj+o9y0kZyyvRBLCOfRc2ueNUXCdqP1cXPcSfg5aT
	Hu87asTbDk/aLQlaxC73fxsraJ5Kpg1Ib+wAWM/9Hg2KjP7HQk6j67RUrF7Cou+L
	bVYT/tO32d40XwAieHmoLAOzpfg6C7LX+22t7JrzVx/6bRDioWYpI96Tz2HkVOk0
	EiUk01L3U8dJZNbAj1Dc0N+MsIKJTLPuo34TOUwb5p//TbNCmUMBD4YiI36nk3fF
	a7ELcGSGWqhxP7jTiZrjmw3Y51y+7fV8dFXHiNZD/RD3Bl2jn6jPWNF9ZPt3nYII
	dUMkFh60Lmy1r7FQVTGaQ==
X-ME-Sender: <xms:IyZcaD3hR-FtbQCcHTSZ1mM2R304Pj2jaPoYFQLr4RNEycy3k7atVg>
    <xme:IyZcaCHRKVKu9BNxudkQmBnPBs2KF6h8zTyfF6R26nEtL7W6BqlYZ9e98wY9Q_52L
    HUp5BreJ7Pwg23t9w>
X-ME-Received: <xmr:IyZcaD4Jfu3ei-IWLgPd0hA46yyIFnNY9l_aCEwtYkX_fzu11YOercLt8l0xeEknZ24Ywo-wuKez-9xo4fb1nH6C2FLee7WrvdoGwGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepohhpohhhohhrvghlsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IyZcaI0PA-k7tde2vYPi2Szq3LhZCHGiOCUUEdP1zgTG7fPEN96VYA>
    <xmx:IyZcaGERhs5U9JLQ76gyWHo4ZSNjmt8jAB7TuPJuoghwc0kpuQw-TQ>
    <xmx:IyZcaJ8oBQcdgOgR5LgGDX-u3J8L27q5sCRiycgkjrKp_pHbw_f2ow>
    <xmx:IyZcaDm34mZcqDz1-3UIt0wr8vVPQKeC56Kah2uxbmIvcOzznmAHfQ>
    <xmx:IyZcaNHDykakG4II7RgGvhBCtsgo8LiHeMIcyhnvGQgCt03glmM54GR6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 12:38:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?= <opohorel@redhat.com>,
  git@vger.kernel.org
Subject: Re: bash: unescaped `>` character when switching branches
In-Reply-To: <8515698b-4ab7-4901-bacb-1c47180c2530@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 25 Jun 2025 10:53:56 +0200")
References: <CA+B51BHEB24JNzOroTxFodxiuPJ1=Vj7KRFevrm2YatnTVuoYA@mail.gmail.com>
	<8515698b-4ab7-4901-bacb-1c47180c2530@app.fastmail.com>
Date: Wed, 25 Jun 2025 09:38:58 -0700
Message-ID: <xmqq5xgjwzbx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Jun 24, 2025, at 14:59, Ondrej Pohorelsky wrote:
>> Hi,
>>
>> Our customer has found a possible issue when switching branches.
>> Output redirection character `>` is not escaped properly when
>> switching/checking out to different branch.
>>
>> Steps to reproduce:
>> 1. Create a new branch and switch back to master
>> ```
>> $ git switch -C 'issue#1234>/tmp/dangerfile'
>> Switched to a new branch 'issue#1234>/tmp/dangerfile'
>> $ git switch master
>> ```
>
> It’s too bad that git-check-ref-format(1) does not disallow `>`.

Is it?  It looks like an outright bug in the completion code,
nothing more, to me.
