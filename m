Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D43215023
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728420338; cv=none; b=DFwVZhXQHRhsv79wWCt10ySBEQH7MbqVF7ffM4eSFa3X3H2tBgElRqn3FrElwDlEhIOHD8iPdhvzpcf7MIbzcJpSEQk7yMPpl10Zifz+ij8V/Wa7O8rGirU/KWZnlVAqju5z8YG3pFqxHYpz7JAaVWdpNy/fCaSxnx8p+JtKwBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728420338; c=relaxed/simple;
	bh=dDNUMbM14+PJS41+onNNPwxWOmYDs56qQGFFatg909M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AQgXD/y7QQsgR+eqRg7zq92xIFGqfG5kiJFcuKyRGdymGW/7ykPmoDl77LKXvU1PsgSPuT4O6VAl4DJkESsIO4flZXCIW+S+XCHCcEhiu2CFflAxroCEChJAZdg6wnFr+HYcrDL83cktyM1DAVOnTIF+XUY15i0SfWETc3waBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lrc+AEkV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YXUOv624; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lrc+AEkV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YXUOv624"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A23B11401E9;
	Tue,  8 Oct 2024 16:45:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 08 Oct 2024 16:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728420336; x=1728506736; bh=rM7T243ZVn
	ys0zflVENv/KpokjzV0e+t8q1Lj7DOlYU=; b=lrc+AEkVu+U+q5B+bAzV2tBIl7
	jI+ONV+c8OY2opmZZvjnGXgxTiBACNl6fJDDER+/pdHd8cL9h6pOMu2aorX9GZ4A
	5Ci1Aq18j7Fi5iLF4g87BSNzNuMscFoWdh3tFWv7BBDDberF9zdndO/Vv1LePTot
	ZXnQINCsinQIEPDVOZ2spU/hBclKWAaAs4ZRH/SX/ZKhTv4CL7A3UU988LsgeuPy
	WPKRnrALHl3MiwbiUpfn+GzRhP/L5vho43e8vAtYvu2/Ap8rJHtwE+MnWkQDFvvo
	tM3CKJewsfVlHRHo+Ak3Q6zFOtqFrkCeRAsVq1FufI4NJBFTa7RTbyZcU4iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728420336; x=1728506736; bh=rM7T243ZVnys0zflVENv/KpokjzV
	0e+t8q1Lj7DOlYU=; b=YXUOv624vVmfdl3o4YSyVqAAoRsvyxKjmU4AAgpz8AbU
	uecUF/Mv7d9MZvtRFdiz5rI9dWGQTnxmT5nE/5L3k52iFmIEH8wS7tSgO5IpfJ9d
	gD0iG5LQTDItjd6KUgCdr5C53p+v3gX9Cb7qFoVGbA0/ExX3ukspmsLL+oPXhWep
	uop2jey1nlaTuvFyMKytVtbOsGP2vlWOGxqzHxM6wMaHl6+2Fd5AQT0V/+IV/cyY
	WLY4Pg74Ub1aT/OEfMXsbJPe/Io5FafBTBNpI8PYoN8gylzrZhAaEjGf+D4EdgU+
	5C71KwLzyiUxa2fSg/Rp/ObrNY7viumXjUm3J5+ZwA==
X-ME-Sender: <xms:8JkFZ8xzhuImvyqOM_2EsFMxf5kePk8D12GNq-DWo32CtaOu_QHOKQ>
    <xme:8JkFZwSyTi8ekMMA5uEdcbZ3IrPqZEoqbqrCCOBXL-gA9b0ro6qloJoNvaLv5doTj
    JYaftbPh72ZJwymIQ>
X-ME-Received: <xmr:8JkFZ-W7gWM7Jsfnr7z_mmalDmgx1ukDjIxQl7bQv81bP-mpvYre6Zk-pgr53604xLGbHstk46VBR7pfKMR51F8t-AqW1O0umGKl1RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8JkFZ6gqDP_eutuCbaPaEVYdvNPwkXZ7KueoL7xmBRVwsc6kdfsABw>
    <xmx:8JkFZ-DdpMVcb6zgvx0mQbN0xt_OnwQnx4vRqjp134vDoKWWQl8gHQ>
    <xmx:8JkFZ7JU8JEPlnCAuG7MG4N1oxuW_XMOlrTPSrqnufkYCqXJAqKLQg>
    <xmx:8JkFZ1CNIfKynP75Hnw6_9dkLvpupyxaVyWA8wQRtrWhBZ160cG1Mg>
    <xmx:8JkFZ5Pe98UEusxV1hvOuQ7mj0ZXP4HqDTouibZi2mXP5INFpt2kfMyx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 16:45:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: ds/pack-name-hash-tweak (was Re: What's cooking in git.git (Oct
 2024, #04; Sun, 6))
In-Reply-To: <f89ba1ef-4cd4-4963-8de0-0323216246aa@gmail.com> (Derrick
	Stolee's message of "Tue, 8 Oct 2024 14:36:26 -0400")
References: <xmqq4j5naozf.fsf@gitster.g>
	<f89ba1ef-4cd4-4963-8de0-0323216246aa@gmail.com>
Date: Tue, 08 Oct 2024 13:45:34 -0700
Message-ID: <xmqqfrp6z5ld.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> This topic has been on hold waiting for greater interest in this
> approach. It was the first topic carved out of the path-walk API
> RFC due to how simple the change was, but the 'git pack-objects
> --path-walk' feature is a higher priority for helping Git clients
> and is now available for review [1].
>
> Junio: please pull ds/pack-name-hash-tweak out of 'seen'.

Will do.  Thanks.
