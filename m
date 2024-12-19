Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FD2594
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734588765; cv=none; b=r4TI4hNoJHNuyhDQ19u4yd1BG879eD41QHT3ux5DuPZBpjU5XQLWz/+S1rdzA8zA37XkZdCCfjvVsY2M5XUesQ7Z3C4bdPhpRytl0Y8pEVYHbJ45mht44NebJVLdVQ8cGL5wB24hUI+GEBNJAqQoWeBEQ7x0GOva2MbTjvh3HPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734588765; c=relaxed/simple;
	bh=XKiN4f/2zHwbovnDaxeO7GJ0YZaD1O+K3p0nljKIDQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dLiacRYYX7NwsIYOuRYjGA6r56NGr/3pcdIcWHVLGAU8Hm8OXkUdh0z7EIPG9x3XYhDtLkZxsWlEQdoQumdtAsNlZGb381InYOETwdFDbJYK8CTXPqpZuSwy9NN01wjTQ/czW7TeHDUP517mkFbL5VHMSwQFJSiBeXnq8gK1hDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MSDl2oUY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eOarVznQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MSDl2oUY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eOarVznQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CA7BD138010C;
	Thu, 19 Dec 2024 01:12:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 19 Dec 2024 01:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734588762; x=1734675162; bh=vRnlFDmEt/
	jL7IRSWqwXSCSzCuji8KoCZKjk4Zuu3TM=; b=MSDl2oUYjf8qMlfT/ImXco/OkG
	EMDZ0nbu9AVvp6Pv45LR7ESOzXUYtzf24k8sp5Xpf8/8tt2XRT0YvkJt8K9eEgcq
	DgXKyNt4HAOj6orBDqpQvApvU1Jxix3NQBute4Pnk80Ld+MUkWUsbnvcZ2ewu3+v
	CBczmdF4GDp4acAtIg9cxAfXApHX+UtzffzLwXdTL2DwPhq2jCE53wzx/IIGY828
	ECTZRHx1lwSWydWwO8PRycl7xkqY/dDZ64pqQ27JP+xfE94doA5tt6emn2k93PHE
	CD+Yc7AldcL/bRIE8VwtRj/jEh+t30gKiqZuqu2ciHAX5S1H4UD67tAoojVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734588762; x=1734675162; bh=vRnlFDmEt/jL7IRSWqwXSCSzCuji8KoCZKj
	k4Zuu3TM=; b=eOarVznQZ6GOTrq9bj1EWUyh4vdRcQkXOZEcJbDXSQRSo1IWR3X
	AKH/KjFZAyw66VbpAejZy593afXNrg6D1LOk9H6NSgJiYM9miiHY34bhJCaF8m7d
	UnXEazwG2b4yzb4lcsec9QliF9s1Gy6LVMUrKHPPiwex52QKCMqEQCgZalDVtl/1
	L9NakgNWYdbF2vYQTutddLXriKYBaYfMa51VC3GWLNKzs7xEmAyNHoNyiQtVcsKa
	A1pI8faYXPKCy2SOV4NfcFUKTScuiDgjUXhB0yzhtO3FfzoLWDluTHfWUhyyVfwe
	ixJBUmdRmLxkkBClk5dCLzgLHByWJoPuYVw==
X-ME-Sender: <xms:WrljZ2h2vmivZolwftlVkNeT4BAaIBApfpP3PDdGheAEmo-GADYTrQ>
    <xme:WrljZ3D2T1eCBMP1Ntx7_z4imKETqrh2l6ETFN3Cg14sUj3I7fVRFRVBHPrnYBDWv
    A25sRan69xc1GHTcg>
X-ME-Received: <xmr:WrljZ-HlFEtL3T3UFvXyzQl8qguBXSnDBmWDRr-0ucTru9Elk0UU6cfi1T7xoymLkjL7gb9TnyUPcvjeceG7njYwCL8WhlpOkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleelgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedv
    udegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhfuhhnnhhivdefgeesghhmrghilhdrtghomhdprhgtphhtthhopeguohhrvghmhihloh
    hvvghruddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WrljZ_RyvQydpn3vq1KWP0ps_JsLl2chVdiKnsEu3Bz6sYxmQmwTwg>
    <xmx:WrljZzzuJG9jqNZHahycfCkx6RuADqc8SivEEKrbcLS1ty-qD1Celw>
    <xmx:WrljZ97z-aiWq7LXVYa0DC7kfWdm2_iTLi6cBWPkrJ2ArzBxVTzBEA>
    <xmx:WrljZwzby0qZNwl3M7AI-WS_TvuHSzWPk0UZZngsV-NlyOnfFTisBA>
    <xmx:WrljZ6kIvfucY4rJ6lCpLCKr-pGDGWUbXd7efpL65qmyLvYVRbcHojqN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 01:12:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: shejialuo <shejialuo@gmail.com>,  AreaZR via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  AreaZR
 <gfunni234@gmail.com>,  Seija Kijin <doremylover123@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH] refs: exit early from the loop if it is not a main
 worktree
In-Reply-To: <CAPig+cTf=Lm_yNWQPq2SKfuROhSMMwNVXNmXhags43SRKonwxA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 19 Dec 2024 00:54:55 -0500")
References: <pull.1848.git.git.1734488445457.gitgitgadget@gmail.com>
	<Z2LOpOxu0oAY0DW3@ArchLinux>
	<CAPig+cQd=vc5rte47biFbR+w_DV2OhdCRpC2WH_dKsSi4wvZ2A@mail.gmail.com>
	<xmqqv7vgo4u7.fsf@gitster.g>
	<CAPig+cTf=Lm_yNWQPq2SKfuROhSMMwNVXNmXhags43SRKonwxA@mail.gmail.com>
Date: Wed, 18 Dec 2024 22:12:40 -0800
Message-ID: <xmqqcyhonquf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> However, although I haven't audited the code, I suspect the question
> "are there any linked worktrees" is rare, possibly only asked by
> `refs.c`. And in that case, it is asked only at the start of a
> refs-migration operation.

That matches my gut feeling.  Thanks.

