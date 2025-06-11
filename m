Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761851ADFFB
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655598; cv=none; b=bpWOU1tgUAOs2m5aLrIdV9vyvmGJ/HGxpx+I3WobjYapVfI6yBz35UnuqAp3yxjie2s9mkQamg3VfqVR+nmenH8Lbrdlzy6sKh+3R4KDcGDGOqYz0PI8wEhbLphwZhZhKCFF6BLepeaRkQ95UTI2CCAem8fdEiwjDFyX9ZXK6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655598; c=relaxed/simple;
	bh=l0JqrBP1XIoKhSebRZWU1PIA4xaMyt9V1zEI2BJ4JTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i3IfWGAYEIclU30hJMpqdOpPlW3gb/7YeNFEQGVCLDcDGW3p05+oC98SVMYB63GB+aF7EMhVn4XKWVifcGTxPBCdl3asEtcpcWnzwuZpyYwsAqVGv8vabqftm+LfAVt1VDybq/+7FDxRBJzs6XvFmXQwifPt6qu00LX1FwJ6pNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EQKkVx+V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nZ4e3sio; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EQKkVx+V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZ4e3sio"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9ADDB11400C0;
	Wed, 11 Jun 2025 11:26:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 11 Jun 2025 11:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749655595; x=1749741995; bh=l0JqrBP1XI
	oKhSebRZWU1PIA4xaMyt9V1zEI2BJ4JTU=; b=EQKkVx+V+GO0E6TX2ify5276cj
	TyhiFRq3QU6l29/QAFjd4MXINrxFAi2HexIaW9UjzlNo0E9NsvafDNykWC9wyv5h
	ZYemahfK71WFT2j3FJVCycbuDiy8YMKFEijl9WZjP401d40TcUgjqDDjn8pGxOPm
	rBQ9hmv0zOi9C5+nxohQnVmhpX/6BH1Y49xlXI1MeVdI5PeMU1e6wh6vfx56ek9q
	PsGKpDdDwYjvFqXiIDA0mULU8iP20qYX10FnbXarPeq+la3HEqndKnWNC5H6VIBa
	XnQsXqLO6yALHPnKYOqUJ9PzBd4XQ6h20DMErxmRYuHgrBJO4YAc4Uq1O8pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749655595; x=1749741995; bh=l0JqrBP1XIoKhSebRZWU1PIA4xaMyt9V1zE
	I2BJ4JTU=; b=nZ4e3sioRBvzjtDVASPax9HYy6s8a+RenXKGIMI90ioNM5owi0I
	bBgxiebNcRBPcyt80ZidfEFYYC50stmFFKIkQMaQpG5LSokIH8gb6b4Eid5lVnjr
	E++OjYJs5fMTpirRTOAqwV8DVBaggTJUydxDTOpkZsaGY3Uodb/bXTRAhaOnj71h
	fjh9oj55G/nLU0150/zu/o5Kg4uKUircjRFTsAjNVkAA9V4rgrmUT8i6wz5LIIcE
	oSalIcLklVJpmz7fBEarkMWXvndcJRHaTwBGZ0uhB3DoxtF1Fht2EJNMa7v0nkb8
	bwnjKpPrPJEcomSRZxVEDtOeUr7ucGycf6A==
X-ME-Sender: <xms:K6BJaNQTroEPtYs2GrFaeAgyiQS6FQWZTBOc1k_ofj4c2UCWFebhlA>
    <xme:K6BJaGwFVQRu90-0djXR_7V6W2Wji0OThsT9SbV4yQVwLGtLGMKuiG4mrWpwN81x1
    oC3mULKAP9Ja-WK6g>
X-ME-Received: <xmr:K6BJaC2vAtr9fLLw1_93-KmKaN2OhSN3e7vetjIJfOso-rsntMtQ8TwKTdduQ716YbHPjttXx0E2fYJxY7Bo5PdCwOSBF3r1ijmq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvrghsth
    grtggthhhiohhtthhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:K6BJaFBw5gTMmAfkL1NlR_CioraKuEJR8QJSzpv8zB0oMfE97EDK7g>
    <xmx:K6BJaGh2CUWGjgq1Mr0GPSwKfEyum5E3b0QSCGgJwM_KDE1GZIX_XQ>
    <xmx:K6BJaJp2L77FHGo99AdkkCg7Hweo90It-YbQCYe6JrmXUyJYLAzAnA>
    <xmx:K6BJaBhtWfPXHQ6eRFr6VyhTRP1g7Cc_FrrYadFLpV96u6hye4-MXw>
    <xmx:K6BJaCvqEqrxKcglDND6ZhXbNLHGq55s3QAlZnVmtrdBru0dMO62Lj95>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 11:26:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrea Stacchiotti <andreastacchiotti@gmail.com>
Cc: Andrea Stacchiotti via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] branch: move multiple branches in a single --force
In-Reply-To: <CAEgWtF_0JzZ24L+H-WoKFGaK6Hho-YYbutxSXRud4SK3HwOYXg@mail.gmail.com>
	(Andrea Stacchiotti's message of "Wed, 11 Jun 2025 10:34:38 +0200")
References: <pull.1992.git.git.1749546464346.gitgitgadget@gmail.com>
	<xmqq7c1jmgpq.fsf@gitster.g>
	<CAEgWtF-fNXaC88FWw5K_3ZpbvQSxAfeuCFy8kkrh_z16vD77=g@mail.gmail.com>
	<xmqq4iwnktyv.fsf@gitster.g>
	<CAEgWtF_0JzZ24L+H-WoKFGaK6Hho-YYbutxSXRud4SK3HwOYXg@mail.gmail.com>
Date: Wed, 11 Jun 2025 08:26:33 -0700
Message-ID: <xmqqecvqjo46.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrea Stacchiotti <andreastacchiotti@gmail.com> writes:

> Il giorno mer 11 giu 2025 alle ore 02:22 Junio C Hamano
> <gitster@pobox.com> ha scritto:
>>
>> Andrea Stacchiotti <andreastacchiotti@gmail.com> writes:
>>
>> > This patch aims to make repointing multiple branches to the same commit-ish
>> > easier, currently it needs a shell loop.
>>
>> Or "update-ref --stdin"?
>
> I learned something new, but I'd still like to keep advocating for a syntax
> like `branch --some-flag A B C X` instead of feeding by hand
> update-ref commands.

I am personally not interested in such a mode, I do not know why you
think "--some-flag" is needed when the command can figure out from
the number of things on the command line being more than 2 just
fine.

But my comment was targetted against "it needs a shell loop" in the
justification in the proposed log message, which is not quite
correct.

