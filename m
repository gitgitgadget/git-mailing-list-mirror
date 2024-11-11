Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34FE13D62B
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731294711; cv=none; b=ibUpl2M5MOlen6kG69sc+Ok7i8Ek19XJuzwibpxYmpGGltcDbe0IxpWMovN9FWVl0x5z+cQGNYiAkUPdaf94OPO31lhA8s8epdNpgdr7FYffYdX61YtfTM/QE7NPUkbtGUbQS3FvTuLD02Je2s02hhpZ+SGAA4vgeR/Bgi19GLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731294711; c=relaxed/simple;
	bh=qWM+hesimDo8ThqZhPf9/6ysudaojotqA1A0ZATGJlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xw5x6YwdMAaUONbfoloW4tWFdc9nsjIpnV0ALb5kUJaqKXpvR3ZO27fn7MBjgm/wVVN3pkbhFHOHnV6Ntlbvp3ccRn5HUIcsaiQZ8cKEnSLwdcrqKp0u4Xl8/f6bpnCJKA4seY/X3QlkuY3zfhVFEhFsVbMMSRiMf9njRfI/D3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hy3oTo/e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VFpbMzxC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hy3oTo/e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFpbMzxC"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90C5D2540102;
	Sun, 10 Nov 2024 22:11:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 10 Nov 2024 22:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731294708; x=1731381108; bh=2/r3FQgfld
	09BJ+HP6PgDJ+g7OUF04SqXZyG/T7vyK0=; b=hy3oTo/eUl0ZtzZ+Yhw0CG0k3z
	Wl0ljALEENtWtYPtpHbUCdbJO+XGb9t1vRaBe7oSk9gej4ylWO+ysnmXs91aLwd0
	KSK1XdYh9p7DTXdTS4rrOhBX9krpfWFlviD6sY4xRz/rR1ezFLf5U+DCho1awXJz
	i7dFo8ovVlWUE4xcQLP0J915woWW1EYCwdwrYhRRKuWIxalO19szidrOQky0/7EG
	bDwAs59bt5RxZn991X14uwzmMPjGaV4zaBNAA/3+ruyiNqXhRiRFGLT6fGpaNadY
	nm13SJfjaQnlYVrcZkKM/iSBFTS7OKNLg/LmVouQI/isByBWYNpQu0byL4gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731294708; x=1731381108; bh=2/r3FQgfld09BJ+HP6PgDJ+g7OUF04SqXZy
	G/T7vyK0=; b=VFpbMzxCHazbm/RjRhG09K9tna4is2AB0QHgDDQuF5fai5XKYhu
	m1/SmwKw0y+kD2MNlImC8MqXGKsputk9g/UQYH7g4RQqCOanZx9cmlWwi3Ajmvvk
	PhKl1kXJxfs5m72U+9jKEGHhXy7/WZJdOLe9ACMTamcivms10Y6cPsmCOx91IPBd
	517H5LKkhAJYBy2Fw7MXXp3B/oJemwESngzy2HnzG7miVQ8Lu+PnBbH8LQgHEHoH
	C+s1Df2vNKeIvDmvbawiRGrjPPXxChLkmquVC72uOvE3CSNhXCI+R/WdhWnBbmtm
	5OI3dr9DHGUzgr7sYONRW6VUS402LsrJzHA==
X-ME-Sender: <xms:9HUxZ0434z6XzdXzL2jYbkcvFLzHK1Tlpf94kzFH3QyVPXgMPC0jjQ>
    <xme:9HUxZ168TNKP-BL7C_9f74Ma8QmWNSz_2b-IA4teyUTWe-OvFuM3Wn5GRu-balNw8
    WFFde9YJ0Y0_TD6Qg>
X-ME-Received: <xmr:9HUxZzcA8Z2bv2HM-g9AHVI6xGeBoraOGY6cej50sQgLYMnNtY3BejesbxmTZ217wQr9bKTLvXycgAzc2-cNKQk8dMeq0nM6w6dV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehgihht
    thgvrhdrshhpihhrohhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgthhifrggssehl
    ihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuug
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9HUxZ5LtZe9lEu9AgwMryNCH5e4vsYSjxvSUQuail00E1dzx5D5oEw>
    <xmx:9HUxZ4IXs1xjq-SjAjFCjs4Q633JELmI7mqDezNPmgRAuKJ8LE9q0Q>
    <xmx:9HUxZ6xqHkhsPwQpMOAWYT1HzfxcxgUYIWdSDJPJEb51K07Cv51BSQ>
    <xmx:9HUxZ8KE9_mRpd4KI8miajK4d7d2YResqM8PVC2VrO5u7Ou1cZTdxw>
    <xmx:9HUxZ39kzOy4nUXsE2k4LJEBB4A9SHtc3W_GHh0Fc1zz5OZiL0_46QOw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Nov 2024 22:11:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Todd Zullinger <tmz@pobox.com>,  Elia Pinto <gitter.spiros@gmail.com>,
  Usman Akinyemi <usmanakinyemi202@gmail.com>,  Andreas Schwab
 <schwab@linux-m68k.org>,  Christian Couder <christian.couder@gmail.com>,
  git@vger.kernel.org
Subject: Re: [RFC]: Test Were failing on Fedora Linux.
In-Reply-To: <20241109190012.GA588841@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 9 Nov 2024 14:00:12 -0500")
References: <CAPSxiM9GZLKNbyCmgpz6b7Z-MLe8TfMaatR8FPNwvsHA411dtA@mail.gmail.com>
	<CAP8UFD1-HsYsPRQwWMo8ipf-VdqF+9=HUTTr4BhEArR=V3ucxA@mail.gmail.com>
	<CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
	<CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
	<87msi85vc9.fsf@igel.home>
	<CAPSxiM_h2yEZcUPP33q8HHdn6kqq7SbvzNq8eEFda81ZgY6R2w@mail.gmail.com>
	<Zy-IYwjb_RO5NW-s@teonanacatl.net>
	<20241109190012.GA588841@coredump.intra.peff.net>
Date: Mon, 11 Nov 2024 12:11:46 +0900
Message-ID: <xmqq7c9aihvx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I don't offhand know of a good portable way to ask the system about
> available libraries. But I guess just doing something like:
>
>   err=$(LD_PRELOAD=libc_malloc.so.0 git version 2>&1 >/dev/null)
>   if test -z "$err"
>   then
> 	...seemed to work...
>   fi
>
> would do it?

I do not necessarily view it as "asking the system about available
libraries"; we are checking if we can sensibly run things with this
set to LD_PRELOAD.  And presumably the answer was "no" in the
original report, so it is a very direct way to ensure that we are
setting it to a sensible value.  I like it.

The above did not work for me until I did "s/malloc/&_debug/" on the
command line.  At this point in the start-up sequence in the test
framework, we should be able to run "git" from the PATH just fine,
so it would be a good way to check if we can trigger the malloc
check with the way how we expect to be able to trigger it.

Thanks.
