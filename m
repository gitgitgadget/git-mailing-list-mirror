Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A938B7BD
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943020; cv=none; b=ckAfO5UNSslXnry/BPebK9AbuFPhBVDdp0LH/sYayp6mJCog0gDUlwKymwLoOi+xEsnT6QJjJTNiDYFbMmA1IGL94KfIfC91NK2zEjVNX8aV+gR/kK0FdlBDUoiPmkffDALmq+okBVsn47eLH8MvMlONbiK1UT9nndHpslGTbJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943020; c=relaxed/simple;
	bh=44102DE/wSCZ9P3/oMhiaxiuxQ+1pMMqfDYVNlJimmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=luwOnu4vpvwIg7X0uV5soJRxFHaRhnqR4xed+nVLtnfPgrQdtmZU0hT0SgkjncsRIdEkIYLuyQAbh4nDuFa+5XrDAWvcrnvyKDN9pdt/bV9Y0rG3kodUlaZKw5/4V/uvZjUCcDzVJJ+tknRPWlCMYFN1Ovgv2JOU5qDYewGtKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q1poVqM9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ph5QQXAW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q1poVqM9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ph5QQXAW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F9DA7A0062;
	Tue, 20 Jan 2026 16:03:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 20 Jan 2026 16:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768943016; x=1769029416; bh=ch3InMRrDc
	jY4nQ8o2ZZ/6DUkTZGoYh6HPwInzxGI7A=; b=Q1poVqM9AA3cP/tqq2IzAo3utX
	prvuSMFSUBdQ8I4+OKAQmPy2yYteWheGk32GjEA5nU/CiJd6KtzN57wBp28PC5DE
	kwX6GkXehtb32tctDvdAjfHFf9iFKsx46EIlvfRdt4Pxst847jCFYAPqMtUb3yQ7
	03y/smKammRbtDwsmsfDV1D24lp1PQ5XNwtiEyaC+vyJtqrJtR/9RoEmIuqFM2Es
	Mmf7Df3q1/omLyui5XYC4yn0u8MzmFoCuU62KHTfqZnu1p3k+HjMd+XddEDojbYV
	OPCRTXjCuxkHXH8p+o3fDmAbS4QcPZhTYl5GA5r/t2b6m303mW2q/32SAwQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768943016; x=1769029416; bh=ch3InMRrDcjY4nQ8o2ZZ/6DUkTZGoYh6HPw
	InzxGI7A=; b=ph5QQXAW/Tw3R+0H7x0LeZapkl+5wpKM7yD6zTKM4y1K95tYMAx
	tbNNNamWkLvmqjwGzsmfFJtJ8t1ygwkmIU0XM8Y3noIV5mnubnQNXYMeO9GqmFmZ
	ETxuHnHTtLUiCBmv6hzcaNlHWs84e5cx7p3hbncvMvROQyYI5kiYQy2kO6lfS4dm
	ZFLQXX02XGd45oxL2RcOx08EYHhBEHmuiWW77YLHebZTtvCgtSDPjeDGtKPgx60a
	SeLZoJHHcvbb8BjRckOtxk1zwnoQPQYKrZWwTTOYPuQYNtwuRUcoELBhhZJSfuFt
	qCDhnhRAHsgloVw7wzaMGFWCwlmYvl6Rq8A==
X-ME-Sender: <xms:p-1vaccI8fAMk58EocpR9D7TjkyXf5yx8Qs9TTX-9oeDgk8RezOjbg>
    <xme:p-1vabJEhGHIquQvl64jzRppuUBQOgxS1ozLjDqEMYxsJPHMVeP-3CCcjMqkeTaJf
    zPeBqSMYd1S9TMqZ68gggNW2VsoSFFJ2XBl_ht-d3yc78zpZdO3ZCw>
X-ME-Received: <xmr:p-1vaZJJCoCxkotddKGD1oMMOIm_4V6C4SLI8ZTvKzeM-iPsBuxFnXODqxF9L3P7q1pLcdxu1tT9MWfjjC618t2kgowaskDO5-LDoZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptddvffeuieekleejkeejleejueevtefhieffheefteekkeeugeeuvdegfeeh
    gfevnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohht
    tghlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:p-1vaaUNUVmLNrKvOYskVovcr93uA9XD5uRdCXCEh1SwJirT6A8LFg>
    <xmx:p-1vaSkLmWQI2TTsw4cuNwmVuT2GL156GZexFR_MsgXY75Et2YdtrA>
    <xmx:p-1vaQnnv68cn17zQGoMhnpTb2h0CCKA-YxUhGTUs1bAddextD3eFQ>
    <xmx:p-1vaSZVRzt03pZsOdnonFh3ECFghRacg1VSHwAAIRGPgsDyslZ1lg>
    <xmx:qO1vaebFYvg1CeWF_-PS1BuZwVY7uqQY3qZUPpnIgBKYRjg1Y-lif3dk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 16:03:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  jltobler@gmail.com,  toon@iotcl.com,  sunshine@sunshineco.com,
  =?utf-8?Q?Jean-No=C3=ABl?=
 Avila <jn.avila@free.fr>
Subject: Re: [PATCH v3 0/2] refs: allow setting the reference directory
In-Reply-To: <CAOLa=ZT5YwDXEs=wHqVcHqLNxen51-hucaPXOWQEMug3oWfxOA@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 5 Jan 2026 12:13:18 -0800")
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
	<20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com>
	<aVvVAH1eRxGa60Fp@pks.im>
	<CAOLa=ZT5YwDXEs=wHqVcHqLNxen51-hucaPXOWQEMug3oWfxOA@mail.gmail.com>
Date: Tue, 20 Jan 2026 13:03:33 -0800
Message-ID: <xmqqbjioxahm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> FYI: I did an internal review of this at [1] and mentioned a couple of
>> things that I think still need to be iterated on. Most importantly, I
>> think that we also need to handle worktrees:
>> ...
>> So you can expect another iteration of this patch series once folks
>> settle into their usual post-holiday rhythms again :)
>>
>> Patrick
>>
>> [1]: https://gitlab.com/gitlab-org/git/-/merge_requests/451
>
> Thanks for putting that here. I did reply to one of Junio's what's
> cooking emails [1] stating the same (mostly that I'm on vacation) and that
> the topic isn't abandoned but would be delayed.

OK.  The topic has been marked as [Stalled] and I'll probably eject
it from 'seen' soonish to declutter my tree, but it does not mean a
renewed effort on the same topic is unwelcome.  "Dismissed without
prejudice" so to speak.

Thanks.
