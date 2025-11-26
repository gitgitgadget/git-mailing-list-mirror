Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1D2D94BE
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764191837; cv=none; b=kfKUMp1cqarCGdZEMENjcjXliVYXIT4HFNeMbYYAw9QqUACL1kAZtNRNpOKDgXSyt/vnzZcgptcHZU6xsKCMC0niiQIBhWeO/viPD1vhmk6MKx3mLTBuDkvkRa5MEgs3ZnaugIu59Q3kFI7nYeL5/HLB6wIL50Gkfu4UCkv0X6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764191837; c=relaxed/simple;
	bh=XHklAX0APzEamFcHxn7xfaCpWG/Osu7RyNs94lRs3O8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JBgiFZDnjtIAAt+IencRpGkkT7x9NHzB+4x8n7kzBSW4jl53wyS38+40w4CUSB0phPQqB6ggGMxgjmZI04fUY/My4JEdi3O8cUVYNfJtGBbQp/8FMb6cqOAoF33VUKpMgZmFhn21VSzZkdBgGR9i5nCDqdOJNX6bOBo2E9SfzF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iov4xv+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h72OW8hw; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iov4xv+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h72OW8hw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1DDEB7A0145;
	Wed, 26 Nov 2025 16:17:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 26 Nov 2025 16:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764191833; x=1764278233; bh=j+SnmfarXz
	bHLZkO1gRvDsWu/t/CsArumVmSUGgQOSM=; b=iov4xv+YUGi8UFJWx0ZDP1FH7N
	IBdfaMINilhx4DLAwe/bOGnkJUuojxocZMo1P2fndn8XdpsyB+vNrL6dLXvKE5Wx
	SVR4AG1alx6jmPVgwQE+PQJ0hqnhpltE/xYQ2uQqwyCEuxttdqAkCqx2oOD4Hh2M
	lFMlqGIrB9ZbHSVevjl/WRctAWYqA54yqoYsnvJTJHNkHiAKZUfG4F3Ux9fc50gg
	sICQK27tVEg54p9C4HGLPJXT3Awp6u3NwmpbwnbkHgeW3opbODDOPUxmF5jqv8rc
	KXuKMFmsfy/sgWMMlHYmMiu8+nWidiYTYckRRiO29HKK8yEoMLzsZCoGjyZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764191833; x=1764278233; bh=j+SnmfarXzbHLZkO1gRvDsWu/t/CsArumVm
	SUGgQOSM=; b=h72OW8hwEGWO75ETazQRYFgc+f0Mzq9l9GL7A1NMLWDcAS8RxVP
	luLf3YbhL8v6ne9Hi0x9bnPVz9Zww5thmRXVWRxMdMYts2H8tnyOrLDVOV5dDzEI
	vJLeHueCLSrY+5lw5bqFXGudF5AHUH82/0xDXGWfH0iAA6z/u/5co4vPl2NJk+hK
	nYlOWVZYikP/h6kWEl7FwdgbZZXsCowXXG3QQtMZQOD0xhIlht6WaZvOUcbZiEBw
	zn6ZanpAJmJ1/8+JxUx5Yh5qYxdnIJvM+eCgmDZ5PeBJPoA2gMufXqkQwVQSmGf0
	nejWHvKy9ew8O0ufWpdyFwKxh3tZoP0Q+gw==
X-ME-Sender: <xms:WW4naeAUfJ9eNjqs6WTUh4-MiACeW5xZiqo6v7GZwS2X6uqrIxH9nw>
    <xme:WW4nadtqlhGY9jfj10Y6cfLk2Lk3HxzQe1xxdVcgi1wrYSZApKYDOuitrsQTNVg97
    cNNPgCgNQHfG-vR_D8jJrVXp6FYY5UmWNL8aYSab45b5xLiQNANKg>
X-ME-Received: <xmr:WW4naU_JWiwN1OiG2jnqdeblFLLpd6tVt8qmO1HIC5vszheN9P2cEtt8MBEK6OAfVmQrj4T1aNjMXGe0fK6hm5_HDPAw4HvPk-cF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphht
    thhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhi
    shhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheprh
    ihsggrkhdrrgdrvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WW4nacTvdigfrbAwkonuNKzvqh07z01tsqEcxRA18FemkDOMjnz0DQ>
    <xmx:WW4naeXBOfmmzGumln-DwFtc3_fhshXmi5wM1RDaYad4EMW0DdYmvA>
    <xmx:WW4naW_Mx5cyImbWam_fYKrFsVXXJiRc3u1zlfJzg-90GRSfDUK9jA>
    <xmx:WW4naW1WzRzdyd7-9a2S18SqIKD7ccUXSjXz6Y0ZnYidZJ2pl0ocpQ>
    <xmx:WW4naYyTElVOLH7iCXJScTVxmGuAiyd2_2J6uEbbdIT2-dwTAsiEnm_M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 16:17:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
In-Reply-To: <xmqq3460ocv7.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	26 Nov 2025 10:41:32 -0800")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<20251125170056.34489-2-siddharthasthana31@gmail.com>
	<d563b68b-e01d-4b18-bd84-86f36e61a70d@gmail.com>
	<CABPp-BEF1RVs7n4xf6ihyPUmxrhgpG6VEpZLrX=MTgcBWBRbfA@mail.gmail.com>
	<xmqq3460ocv7.fsf@gitster.g>
Date: Wed, 26 Nov 2025 13:17:11 -0800
Message-ID: <xmqq3460mr3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>>> I'm struggling to understand when I'd want to do this. Why would I want
>>> to update 'feature' to point to the reverted version of its last tree
>>> commits rebased onto 'main'?
>>> ...
>> I was going to say the same thing, but from a different angle.
>>
>> The sequencer in git is used for three different types of operations:
>> rebasing, cherry-picking, and reverting a range (with a sequence of
>> reverts rather than one big revert).  In replay, these correspond to
>> --onto, --advance, and the new thing you are trying to add.  As such,
>> it should be its own new mode.
>
> This is a great comment that clarifies what the problem is with this.

Stepping back a bit, is it just me who thinks that the "--onto"
option is a misnamed "--rebase", and the "--advance" option is a
misnamed "--cherry-pick"?

Perhaps it is already way too late to remedy, but if we ever want to
change it, we should do so while "replay" is still marked experimental.


