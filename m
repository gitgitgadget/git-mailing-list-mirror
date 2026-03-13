Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92613223328
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 04:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773376181; cv=none; b=HdUuJTHlpAsoIEdXBFFsRerGuq0fm9eS9DefLgBl6UPeJP8xT/CZRlegeSEo9DdqxzRcgHfkg7hvr2Jgu8jpqU04d9Om3coRuN4kM7thfXkC94yoMcQf9TSuQTdK960MYyiQkOjs+7Mk3uO6Pi28HjO9TwZQiC1NzBzlVzrCxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773376181; c=relaxed/simple;
	bh=Ss6CX24wqgzF0CorWmNnGbjjt25KOVwQTBzYjkmvTH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dfg98wwhxTu2+q4AxI4fDDWODw4FIToXI6t0/JjsMHai9PRVnWngrjFWsUDxg53g3ACC5hY1+IxSSPbyMPuGt16B6xcHYEeWMs//DUmwtcvKYLB1jfuxrmssKd5hJi0AtzU7K051y9rCGAj7VXSTcMGjmgGEadbMQZ3zzpF7KSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AFOMGv9W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s8+eVkU0; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AFOMGv9W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s8+eVkU0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id ACEA51D001B9;
	Fri, 13 Mar 2026 00:29:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 13 Mar 2026 00:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773376179; x=1773462579; bh=4rOVrZq/M3
	ssIuxB5RxAzoKhynwQ6sZep2vl9zYTasQ=; b=AFOMGv9WXezuNTUDsuAS+LS/sd
	DHLKAW6xvgZKStp4SKmUPoHtqZdQGjadhlkH9jZG61u5Y4pO5dJKGvfS/jXXi/JE
	dFtbgFaXtHGNMlqkWSr/hL/OQtK5NjpjsfFhmjFo1Ld8iqTg6BOd8a1uf6yb5cV/
	TgkqQP7BLXyiwsu0HYsMZRnogIRokJTQMs7IryaXKAwWzQN2dGRsHAK4DjfxmF+l
	lGzyL3KxmqleiRDouVp8QX8Hnq/bujvtJPFGUPmTfQb5xmhErIWpJCX1G2cb6ST5
	nVRwrIwOPhuM7HG0RiixGm8sR2I1tivWMA+JdgvN8qZeqfO5irt0/4ks4U2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773376179; x=1773462579; bh=4rOVrZq/M3ssIuxB5RxAzoKhynwQ6sZep2v
	l9zYTasQ=; b=s8+eVkU0Z2Od2iXWMA3lEYcJCPXnt/adaV/esJoixFVw3UvyAug
	KVDuOd4I8ZZkjcM55X8aLfgwY5m7Nxhp4I6rEbKlrdpPuylVxsw32Tz+LDZzBKPK
	iWy1cj7wz8tcxpWdl2ZiFpcnA1DiZ1asO59PXP/0wYoEuoO3Q0LaljY4Jt35MaE/
	RwuzCdEECSwgJH/Y04TqAS1+0EYk+mZCcaHDKa1YnpRFZ+ZgkpahLyXCwoF6um6z
	3CIf9iHdGY85XcF+L9bSyNlOcuvybJEz0GkAcUA5aRSVB3Krs7OF4eC7opizP6kP
	jj6oJMr5Yls4D5bV09ueEbjViqJptW9ymmg==
X-ME-Sender: <xms:s5KzaREaVhiKqCiejRmQTcMiJZ1kdrK_34c6uZXfrXKK98lQZSjwOw>
    <xme:s5KzaYljjnw3EulXxRbfy4-RdAyYkCazUG_d-96XuF7oAJRPnF0gVn3tvxo3eJJ5b
    X9Ay4Tz69qZnpyJwEczzc1uGROFBQW58sRlEZ3K2ThzpJ4EZnz0vA>
X-ME-Received: <xmr:s5KzaVZTnXEajVbuXvrzh5-y6Tt_obCrZNNr8uJMI_33z6EOFIOGMAMGq3_tSnECY2TzfZKAmLJnqFtYZneRg8VbrSvX5k97Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:s5KzadEt067B0BLCp49brHP0KRRxIMmGsbShH12tim-DZS9nACSsLw>
    <xmx:s5KzaWIcde0y495VL35YVZyFRQwAVKIqjhUdEh5ICEttiSnHKBlaoA>
    <xmx:s5KzaYOBAsvfv1xHsHoK_ehZm_a3vJ7LWAFIeXZ2UeR-0QuiGYp7KQ>
    <xmx:s5KzaWkyCyPKMqLEwCDG6_TVQt4THmQsVEydA4w-roYnXLwu0gzZ0A>
    <xmx:s5KzaR-SPfPrBAf2UoiDtkS2NO00KR3L00_RccSE8bmohvuE2GWpaqbm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 00:29:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net,
  christian.couder@gmail.com,  ps@pks.im,  peff@peff.net
Subject: Re: [PATCH v6 0/3] fast-import: add mode to re-sign invalid commit
 signatures
In-Reply-To: <20260313013938.2742124-1-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 12 Mar 2026 20:39:35 -0500")
References: <20260312192228.481134-1-jltobler@gmail.com>
	<20260313013938.2742124-1-jltobler@gmail.com>
Date: Thu, 12 Mar 2026 21:29:37 -0700
Message-ID: <xmqqy0jw8i8e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Changes since V5:
> - Fixed a test that was incorrectly referencing the openpgp-signing
>   branch when it should be using the ssh-signing branch.
> - Changed warning message wording.
> - Added some parentheses in a conditional statement to clarify operation
>   order.

All three of the above look familiar ;-)  Looking good.

Will replace.  Thanks.
