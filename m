Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A9D1DE3B8
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894959; cv=none; b=snxaVRSl9MN1WPW1tk48+mwoMTQMICPQKF6qn4eIMgzBWzE48c3Or7IVHd2ktszrrUjRjc2FlWLzdbbvLW9qzLuMsrdK7asiFjjFpag9TgRpUDlNYwtJS0RZXmkAYEninsfjRm/8X37dHmPUykrJLoxffZWtyv6dyIQYqSaZGdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894959; c=relaxed/simple;
	bh=apHvGkCmQwLm7+8SosqFcuM2TiqAZqM70TXjqU7S7fg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bgPniBaBHxJ5lqImw4vYyYhcX6/2rGuNk5yZsqa1/VKuiDpNsFbKxBlQ496ouiG09uNpZsiF6oDO/3jgZESMlM2eVwVQ278DQbx8CKeiauzqprMlljZA8JgPHKKmwzToOv5wQU1da3ElsMFKYkIhbapSBMtlTAukChXioXMJjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SNnrMPFQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M1n4ZM0n; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SNnrMPFQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M1n4ZM0n"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C762F1140073;
	Wed,  6 Nov 2024 07:09:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 06 Nov 2024 07:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730894955; x=1730981355; bh=LfdgVc3tcm
	HuCHkw5YU6PXQWELCh/eeQ4MPrYRAQfRs=; b=SNnrMPFQGp5hwfPOyWcAx/yyOL
	dk5pCM0ZLmgBysyDVFo0gdnSpumxXiNt9Zv9J9fjL+Hhqde546a9CpOE0YMCV+22
	t4xkEK5rd86ZgKMUp7hM1pcEIP5J3vieYswcTIdEO01BgIqQ+fbA9wi/c/8vcOyC
	TxMDA2HIBIhRw1FLDhV9N9woD0ks2/NALa59AV5CoayjrkN2j0JVnyuum48+rVVV
	fUlJbEFEha9f23LXJqigjHQPPHop3AJElMeEA9xLU7c3JtIeJNohBiK4KiFsDT74
	yJidHn71dWUV/Z8vW8WCuSVeZvZuP0tUcUW6znC6H8A6xDhr6VUvPdTTfQJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730894955; x=1730981355; bh=LfdgVc3tcmHuCHkw5YU6PXQWELCh/eeQ4MP
	rYRAQfRs=; b=M1n4ZM0nX189i9YgtmcCXR1x0PFSns+LAqCeXCNdoXCZgmMJgOR
	uIJd+Vbum3ScGTYniurhn9+npBvlG9LtoY09qZd2MYksDn0bMwup3gKvx5m469pC
	tYZPqROn9NKusmhXbnnTK5snX+H4ujfhwGWa5spHmmY9r1ngrIxeoWPlOmf++mVS
	GQtXC6iwLUq/F6X7N+76jyBaOGfXmwRixGtLqSoJ+qyZ/RXTHhurXQhpdvK6MRsB
	VSaf5/QRyRTzt7ncRR+cy30ksaQqMAvqV+Yp/F1ruSTv4eGEK8EmL0ZHwdJfSfdM
	LziCzw2tJuCLCHMLPIABKuWO/YRVKFNFXKw==
X-ME-Sender: <xms:a1wrZ-PTKFWHq-L_FoKLqujq59zra4qs1UlF92XXdyvdFhY-x-H17Q>
    <xme:a1wrZ89F-mc4gku8DbyMFH3aKGXHZA1HiliEgmZH28unOpuIYVbzpnl2OUY5bjIal
    IleVitSz-n2ysKGhQ>
X-ME-Received: <xmr:a1wrZ1QLfPSX6-AxRbHJ5h7YvwRWo8BaKAt6LsKgj3CDSMzoL0UvCR7_2kpko0tq5XKhsJgIYJJpd6libCte6HuNUotVAVHqLoIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedv
    udegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdroh
    hrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:a1wrZ-u2URl0KGqmqu58YqSNALoqMFs4cyaPsTrtyYqm9lCanpmKOQ>
    <xmx:a1wrZ2fICdnxJuiKAvPF45biM5w5sB_tV3eE4XuQjM42VyadFd_X7A>
    <xmx:a1wrZy16EcXOSsKhUdTWoIBFlilC6TydGLxkYqkJgBtfI9O9Xrg7xw>
    <xmx:a1wrZ68ET7bCJ3Dfk8waWOSAnwrX5nltvbdcyHQ0lauMrOI4qwy-HA>
    <xmx:a1wrZ8vhTI-wb1nlJLzE6WuW3eUrJ3aqXbzK7VxIq_-uHdHAXZHNd87R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 07:09:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Johannes
 Schindelin <johannes.schindelin@gmx.de>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/3] compat/mingw: implement POSIX-style atomic renames
In-Reply-To: <1483501d-d798-46d6-93f5-f5edaf915e99@kdbg.org> (Johannes Sixt's
	message of "Wed, 6 Nov 2024 07:44:11 +0100")
References: <cover.1729695349.git.ps@pks.im> <cover.1730042775.git.ps@pks.im>
	<xmqqwmhhow3j.fsf@gitster.g>
	<1483501d-d798-46d6-93f5-f5edaf915e99@kdbg.org>
Date: Wed, 06 Nov 2024 04:09:13 -0800
Message-ID: <xmqqmsicpnrq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 06.11.24 um 04:54 schrieb Junio C Hamano:
>> Reviewers, how does this round look to you?  Is this a version you
>> folks are comfortable to have in 'next' and later in 'master'?
>
> This round looks fine!
>
> Reviewed-by: Johannes Sixt <j6t@kdbg.org>

Thanks.
