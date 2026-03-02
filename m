Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C036D9EC
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470258; cv=none; b=b+yiKJwGafVfE7ReQRTyfutdafB9JD/7tW1u6NilrJnkSa+HBK9mOCmnxSdODW36WikL+aThqWdlwqXA1Mw5qmVwpkT25JWX8jDBYHGYeAhdji7ygVFJzTs6cwijfuPMpJWEwYfKPFuGBhJx8e0cArsnlhWgDsNMsHNkB0Iolps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470258; c=relaxed/simple;
	bh=xhLdOsIyvAh0CbhRIIv80GwrlHhRwu2WX+uF4uiY8Ww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J555er92e4FOIiDwGT6ttwKP8nXTSoLaiLvsqYgT9bRqy2kHigYPj3fldc5ZbEIUbeQjdafzVYEGUuZ56qfGYHX0tcJQlIgMirC2OeYOgCUAyqhD2tc7FntkEYQ1sLQN6+qY/eTukcj/YDf/Ji6fsPpZvM6grURQjlQfGFyL8Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d9/j34ES; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TIarV4P/; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d9/j34ES";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TIarV4P/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68ECA7A025E;
	Mon,  2 Mar 2026 11:50:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 11:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772470256; x=1772556656; bh=XWUSfMpBSZ
	gX8qxVm2pLmqAURVw+XIZC9Fi3eMgeqwc=; b=d9/j34ESjJ7EicGazBiSA9mMew
	ziqpnhNzhP+vK8y8eCEk1wFxnin/KqOLp9gYEhDHzt/zUVzVQbp1Ey/ChicnakDD
	GP7kQ2cklbToIt0c8qi/sLr4dB7Wk7iNL39rk3qBGk2Bx1lIAAPwKbzstXo6XHef
	leOQBrDcG+trJ9hY9ML5rTjPqR1bqaswpyxQZ5nzsPKNdiUlQ961MAskh91gifcG
	sCv2AQkvYNZ+dYbBxPDx9AXKGJVO1mMey6+qKRNn7bDxmf4LKx6ul2G+mcoCBj9R
	7zTDUOu/Ej8N7FuKEtloJjxz4/tZuQVQyNUL4FLHpd0zKBexwgdxFyPBwfaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772470256; x=1772556656; bh=XWUSfMpBSZgX8qxVm2pLmqAURVw+XIZC9Fi
	3eMgeqwc=; b=TIarV4P/niGByhUqud1LK8akHMIYG0ojQG4MK4p6zY/R3058W2o
	H7IFzqDKRMt3/7xX5ZwZHuPxwOGr6WspVZ8N+HBclShvqAyGkeASI7mtQVro1PaP
	xqO2BanKST2v2xVuhJR2upT0mlEdxLbmEiYFfkKImaTVnZSLlyceMZ0ndB9vSAh1
	7lo3uAciFzqQ2efvsHp2ucOCK7HDlF02Ka3VAGrDwGIcLJfUlTyzq4pOkb6ScZb9
	QCCAz9Ja+sIA0VT9+RmSXJogoLjaioaWAEYwQBHXenJ2SRL/qxCTwwIbTyRYNSHS
	J1srdLDzkyjnenhKjzUNo42e8NvCqPd8y+Q==
X-ME-Sender: <xms:8L-laVjwYUfVjrXS8qkh_AHpleCC67o4WvXbrRNNb7SOTFeBWQGV5A>
    <xme:8L-laUCDq7gVJNkWdkHpCxHQnakerUnkvguVI4D1uDC9FYQLkxDry51JNxKNjKbUB
    LS-v7W03vWB4J9ZQoDihFsFMzHMQsO6EAF30s93Ibe0lnIH9m5hWA>
X-ME-Received: <xmr:8L-labvwMGChYUoxNhzF2GP0FYmrWkS_P_lGZPFcxHbnfoZ91ZI8LkSLTuJinqDXC2IUG-P1jmHi6cqOeZLqtzwwLFC3a8FDUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphhushhhkhgrrhhkuhhmrghrshhinhhghhduleejtdes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhhnrgihrghksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjthhosghlvghrsehgih
    hthhhusgdrtghomhdprhgtphhtthhopehprghtrhhitghksehpkhhsrdhimhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8L-laYd_OuRWElSgtYszT53BWAvmNwKRsyWYDX_3hSIIhCb2Pg0kMw>
    <xmx:8L-laQ_nsuDytA8rEiVya2Zfsr69HRJMx4zVpG08i-drJRS8sntJgQ>
    <xmx:8L-labS7S555Fcanvk4Hri2EeHoqpPr0yGIB8pem0frRRhUxYTxvmA>
    <xmx:8L-laZp48BlgsW8cIxoHsfCga_WuNmydezmyv25h7wzs46QsT22XDw>
    <xmx:8L-laV094KAphS5gc857S5bwh60KWz62d99IhIRsV9xtDVnRYHtorkFi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 11:50:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>,  git@vger.kernel.org,
  karthiknayak@gmail.com,  peff@peff.net,  jtobler@github.com,
  patrick@pks.im
Subject: Re: [PATCH 0/2] repo info: add path.git-dir and path.common-dir
In-Reply-To: <8D232FDA-E286-48E7-8E41-ADC6645A9BC0@gmail.com> (Lucas Seiki
	Oshiro's message of "Sun, 1 Mar 2026 15:48:58 -0300")
References: <CALE2CrTt_2-9C4zCrZPBabtsWY=+Mk-bH4Jaemk=yHtfpoLjfg@mail.gmail.com>
	<20260301134412.1072596-2-pushkarkumarsingh1970@gmail.com>
	<8D232FDA-E286-48E7-8E41-ADC6645A9BC0@gmail.com>
Date: Mon, 02 Mar 2026 08:50:54 -0800
Message-ID: <xmqqtsuy2n0x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>> Hi,
>
> Hi!
>
>> Following the earlier RFC discussion about exposing repository
>> paths via `git repo info`, this series adds two new fields:
>> 
>>  - path.git-dir
>>  - path.common-dir
>
> It's too early to send this. The first patch wasn't accepted yet
> (and I really don't think that it will be in v1)

What's happening here?  To me, it looks as if many people are
stomping on each others' toes, adding path.something to "repo info"
output on their own without much inter-developer coordination.



