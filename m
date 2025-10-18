Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF55D5227
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 05:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760763744; cv=none; b=dEdnmVnRdLEYo/raD97U/5kjwh41Z/CT0XsR5f0uRpnY9vC8SsK94HfodFxPpVxAfJ5C9tQV8FMHcXSrRW2jGVma/uMtYLtbIoISFS8pvoN1aa548IwDdDktmPRmeVYOpt8dXJ52fGx/WNtsvt3pMJuk3yGpC5pTPDLIbATVqxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760763744; c=relaxed/simple;
	bh=V1gyRHZ1keUATl+Xy/X5pOFQqxRvdoIK8d0Q3etcw6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=en8sRjjZ36E/WLzyUfBSNK0oIOL9iIB87Dn1YLQ1AM9/JUnZ2svuYHotD77o+Ml9aH0b6na5LJUQrNf3QG8EUois3jpg0Udwj/Tcni2ZauJChhr2LE8CmqJMYuRJD2ko/D0WHJ9+v8H0waPjebAt0z2l71Hj+50yrxzRw9S2poQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IlB9UKid; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O/8E0VUR; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IlB9UKid";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O/8E0VUR"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CAA8114000B0;
	Sat, 18 Oct 2025 01:02:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Sat, 18 Oct 2025 01:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760763741;
	 x=1760850141; bh=xc5hNHdhsZIoIis+RoaWxBqLYmqFzQs3Sfy+cpSi2vQ=; b=
	IlB9UKidBpoA+hPpqLrIC1W85HRw7Lh0Pta9pm/ych4ZItRvT2oHuFoqlDYVD55Q
	/I0jbFkdJtIi1dzJ1r5XJGLOwiMidiRczctAmPmtRBQvsbnHdQqu8DMF/Is84QoP
	Gb4xmQuKWoKenxSTZQHEpft/2MBeO697Pq1oHNfcxYIif5scgQQALs/IRaNDQVsl
	x4PQiVV2adhw1mSxcWfX7mktFgpvGk7RilAtsbXsmhrf3tE6GHP8+rynwTwP7h9C
	Ss6Ze7Cq+UF+U0rTsUblmtV8m7WP4qvUbY1w8nCDWQeAnLfu1BxWqDdxGRGfqOvb
	pDCScLA6pBj7KB606565Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760763741; x=
	1760850141; bh=xc5hNHdhsZIoIis+RoaWxBqLYmqFzQs3Sfy+cpSi2vQ=; b=O
	/8E0VUREPsWd3ZdLn2tODt7ghcS6yOeRYlfp/BvTgQFiBrvCq2eNypCX9a192Sio
	RZIJwutFPJVcVPF1g/U0O2LFvw3cTSPUp6vKwAYWTygCmuFztNaI3NBhhMoSs5ZS
	Yxkxq7mLgc9DX4gYHpnW/oayFfE9meWukeYKsOQWf/0fcSEROHCjaN1p8xWrwE5f
	0nhzBvQ0WCc9/g4+sUrqoAxgH97T2S4Q+mDmWjHzGToP3QxDbpw4kbKH8pLG9cvL
	q7Mto5w6D5vAFFN4pVd8ljm9h/fZlnv+M07iOD+MYXtU79JoFatbXqOiQ+CwPR3n
	M/wRsVIEke1So6otadI2g==
X-ME-Sender: <xms:XR_zaDzD8W1eDHLeqRX-VkRQmu3Zbfj2HSgcOB0JvThzXa6W7f5YJA>
    <xme:XR_zaCTJ1mvH50vMYAdEGy0sV2muYMfHi_a4jQoZ1gVj_kiZS4hU2E7cFelGxczNh
    -I4JvS5ML6J19s55bY4GGejV1xudmOTRUJBAkjNvds9bNlYw8CoapI>
X-ME-Received: <xmr:XR_zaCUKRPYDTTI9M-B5KTMG9ZRGjwCYCxdYy_m6kybXBJqJq5igIpJDHU_UWg7xNhYpsuIcivblMHFa2PrbuPFX1WYByQw4Xx5W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeduudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephi
    hlughhohhmvgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XR_zaMadUUXk1xpOKEkcew5SDCuiuQ6le19VsxbzvMUGuYDvw3sc7g>
    <xmx:XR_zaA1HSavs-2o8bUYpJVJ15iO1bk8WAA_Ftvf0Tgeq-ji8js56-w>
    <xmx:XR_zaGg8m9gZlye_bQri14wRRHmKNBCMvfmI9H9p0Vf8zfwP3eUmlA>
    <xmx:XR_zaMY7KRpl8epXVQZ1r2co6gCGNhZj0hVu63J_ybrjEXZ-l4gKhg>
    <xmx:XR_zaJ1wRr9C98KreOdyVkDC4iJnv-9aTQHOI127jvlV9F0VfrQ7akfn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Oct 2025 01:02:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] diff: stop output garbled message in dry run mode
In-Reply-To: <6C994C9C-0034-46D0-8112-FF88773B5CF5@gmail.com> (Lidong Yan's
	message of "Sat, 18 Oct 2025 09:11:34 +0800")
References: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
	<xmqqh5vx1p0q.fsf@gitster.g>
	<6C994C9C-0034-46D0-8112-FF88773B5CF5@gmail.com>
Date: Fri, 17 Oct 2025 22:02:20 -0700
Message-ID: <xmqqo6q4x0o3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Lidong Yan <yldhome2d2@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> ...
>> Test that exercises "git diff -I<regex>" is in line with what the
>> original b55e6d36eb wanted to address, but given that we saw a
>> recent regression report like [*], I would have liked to see "git
>> diff --quiet" in the test as well.
>
> I will read Peff’s test and see if I should also add some similar tests
>
>> * https://lore.kernel.org/git/CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com/

Also I think the fprintf() in run_diff_cmd() Dscho noticed is a real
problem.  cf. <xmqqa51pz3ih.fsf@gitster.g>

Thanks for working on this.  
