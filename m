Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDAB36D50D
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670533; cv=none; b=JXmdL6nCXiLDitl6i5FQNh4nO9QZSTtRODEAYy5dLWgbpxnw9J+y42A2vThxPdkRJUc0XVMhgH/ZM6qLQh8rbJqdmPbohKegQ3Y9YzrGwgzqK0v0vEKcMzNeVgrANyUuJrad2G8eFHJ9WakCgJyPpHS83d/kB0FXvAVCYjsOtIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670533; c=relaxed/simple;
	bh=AmCNeg1l6V7o5Qz23kjb/B2Uxsn1z5GW5XRnohpYOOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kfmQjAhu+SRZQkShfpwVBkGZXG8Bo2F9i+4rrNwuMr9x++yL2lh80vJcciukDsNDTNLtZHt1OE2whZuIJ2DzAb/pPR7/GxHjb1Zpvd1SdePpmdoGp8Fq6cfpOCJyWztjP+1oqfuDB4yrjkyhN08lh5bQNANlSCg4lzWgA922E7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hzad/8Z6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JPTQG9MA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hzad/8Z6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JPTQG9MA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6D88140023C;
	Thu, 20 Nov 2025 15:28:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 20 Nov 2025 15:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763670530; x=1763756930; bh=fEYqD3y+L1
	KAlknP0fNhiKHiIbhA6T2wdb/YwM1rO38=; b=Hzad/8Z6ZsnSO6QlqAyKyDIqDN
	nzZo/44AYtXDBCP1ekouvpn+A8qMJ4pF6p4beonVXC+liyW2JFD/xs3Lpx+07QJw
	O9vxha+dwAKq/et/dfYPY9JSCM68ERV08PefosBk+s85//eiXK4yiBFUbrAn8Wja
	OhC9QdR5IltHW0ye8BuH/tKJy2b/bSrQvidnWQRU7+2gRRpdA6TImWPgTj8kBL78
	Jw7I9L/0J1w+jk5E242UOdwOzx6cQHEHMPcmWQYfG0dZpyvIaXjje+kjPb/7etyr
	l/tvtnyCqAadxSePydWk1Qmo2iW+OtGOCbp1iaT7tVEESFNS1YOI1aafciEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763670530; x=1763756930; bh=fEYqD3y+L1KAlknP0fNhiKHiIbhA6T2wdb/
	YwM1rO38=; b=JPTQG9MAJ5AG2sdgiGNLnxNNn4GFf9/zmmZjnlgFfQVzYwFNpBc
	3dGLD2j6vI0276CgSffUacFWMZC8Hl+IgWvPALP70QUTgqCwlYRSmpGgXNVnRt/u
	Y5AwHddmHU/qxutLMn1FehC6ZDFw5aqskUvuGqJ7r9BurGqM/k4wULgh1Y/xucsn
	QlSKr/kcn+wjkMjLxRxx8ir+uTJRlB9pHEbt0/iojaXnwSOEhb4pcJtfDEd/Yy9I
	lxF/51azKUSn2rlUOOJTmNQlIpDQspevZ6bmuMExKa/KIpdwCwBO7IlGn3iPuIxC
	3hjYnao3E1GR12Cu0OU7Wh/IjcyUWExGYhA==
X-ME-Sender: <xms:AnofaUl6l4MpDGkuTEKz3hQnp1F7rnsFYWbQDshU78FKOBkYzvfUxw>
    <xme:AnofaQaOdKD3pV442IgCMSgPGp6W3jANCXfYtQkZTERK3JjmYF_NBWgVIMei5t5tz
    jvE1WBDiV6l4FQfaQCtgvRJ_2E4R4Mo8IZJDIg3kI7OOOtDTf3L>
X-ME-Received: <xmr:AnofaXEVaJ7Lf5UCq7V-gI8rY3wzR3pvZJQTLr7LZK70CNx5s2jXcV03v4SAHJ1k-k9k6F7rWFnKK9nU-ekAvRmQXKrtd1KxcxCW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdektdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdr
    rghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:AnofaXaoNeikwVFl9FUQVo4xSTXlqjBTC2UWV4bQEs8F6YFFh5WkMA>
    <xmx:AnofaTyWGBEtkMUyxGXrlHwJtjyakKbJ2L00eiIla1hux0uPEcypDA>
    <xmx:AnofaRRXxL6UKffJkIrgdthLZ7p1lCqpGioUqaJ9AFH5LNZPiRNqLw>
    <xmx:AnofaYJ0BdLqMY2qdf8ts7qgO3I466hcnz_MiENDiHVHxbHLCpocog>
    <xmx:Anofad0IiDKHH_TRakNVH0iau6vrD7piuL0Fak-7TYF4nyl916zos9Jw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 15:28:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Sergey Organov <sorganov@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?=
 AVILA <jn.avila@free.fr>,  Martin von Zweigbergk <martinvonz@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
In-Reply-To: <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
	(Elijah Newren's message of "Wed, 19 Nov 2025 23:07:34 -0800")
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
	<20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
	<CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
Date: Thu, 20 Nov 2025 12:28:48 -0800
Message-ID: <xmqqbjkw78jj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> This patch series is a starting point for such a command. I've
>> significantly slimmed it down from the first couple revisions now
>> following the discussions at the Contributor's Summit yesterday. This
>> was my intent anyway, as I already mentioned on the last iteration.
>
> Sorry for taking so long to review the series now that it's based on
> replay.  Thanks for working on this!

With your comments and Phillip's, it seems that we are very close to
a good stopping point.  Let me mark the topic as expecting a
hopefully small and final reroll before getting ready for 'next'.

Thanks, all.
