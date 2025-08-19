Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D621BDCF
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624745; cv=none; b=IP6npeDV7u/ogHgWVEmj/VLZ4L5ERAeNN0UxSGaMwPyd0PAxGlzCPRhfsAufhn1EXHoNMWwbICIAs5gf2lAyVrKwyGwbOQKRLVxgZtjOU4jmoc61olek6K+n/UQBlhnzFg0NDg2k8OXYEHgDqGTyH1r1tcEHcDygsDZDdtV2wZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624745; c=relaxed/simple;
	bh=2EUFD6Pibbbhs/IMYB+O/a1XluRl7wNpE7Qtw/K3vUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d7eAWVVTg4vZFhyj1R57FhIlLwlJrgycMXHmqei07AOEcpnFSuDH1wYfHQvhffeoTDMpisAxKiFoePIRc2WwZvs6ztoPNDASt0bV3aABi1On1mRztKceofpgoxRklOoGtDKGk6gwNeqljCTlNS2GnLDC36GGzNPQ2Z7o4ImOt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H7TqU6mK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PNP5XAEd; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H7TqU6mK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PNP5XAEd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C0F677A02BE;
	Tue, 19 Aug 2025 13:32:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 19 Aug 2025 13:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755624742; x=1755711142; bh=zQRLTsBisC
	hPJb4t+zscIQ7YOcBf6zntr/nLwNdrXH4=; b=H7TqU6mKv2/kL9W4E2Kmbn12bn
	miYzaAVX3t7ozZcLY3NktJUz0pRuDMX8RX4+tQrjqX08m3PXrMQmYldLnM0SQXFu
	JFFyS2IT1KTMwfvm/fntcPd+OXmhVIDswiDKHfvdSef4vYB4EW5zbecFUBiEAvIw
	Tdr6pYV0VQThWI+NiJC7k9PlOPu3vuvyrTZi/rgvhbWH1xtM7VPwsIAXc/+h8M/P
	roHYdK9vxdexc8/TPtMKpvOKqWZrRPf3oRR7nOE9koRHjQ6dV5UIQGcVc7WNxYqg
	u876WJ9dIkHxkEudR1XpTxpHgM57kkLU6pKZ1ok41mFkYzuycWDsogM6Et6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755624742; x=1755711142; bh=zQRLTsBisChPJb4t+zscIQ7YOcBf6zntr/n
	LwNdrXH4=; b=PNP5XAEdNDXvyfBd4xOd5mwm16wLcU1KQkFUj/+1Eu7dYFY0aZ4
	MrRjgM5QZPTsKd0d7bOSeJWYtjX5jgH7+FzUSfvhIYeYrHBV6dqvllhLVI/8UqDd
	+kfYMKZAL6JAVE4O1/o6dKd0qOWEVbPhVmnG3rnyv9XhhQ7FuZ016fdL1dFCwobM
	JpRBgLdonI6xfww3ZHE1v8jTAwxrv34kC/jEYpdgbbb2gNevgSz3b729HiIOUQZs
	Ypl463hzmwxpSgUunD0Zca5Eyft4Gxrzu7SsF7H6FnRsDIlFjGiX1ZsStPJ1nY60
	0xQOnhrSmCTnzSDmO14RW4+ilM+1jNQOGaQ==
X-ME-Sender: <xms:JrWkaP7EtGqK_hSZoVvgbTSDtO27iLyOvU-Kpu-Yn7Rrh1iCGR1qaQ>
    <xme:JrWkaIIcmuquJ5uK146Ovou7jpCzMheBZG7IC9Ebz2CR8xK8J55BFRGujhdlXj-5F
    yNbkJJFR9e5EWC3fA>
X-ME-Received: <xmr:JrWkaP5y3UVaag_6NwcmHYUPtgASjHdSPxaVeiZnDT9ejW9VgntsMcoGSEGHiKiKNjWhL_e_DlWQv5r3tbaVd3EVUKaPqo5QDq7h95c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeitdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:JrWkaLylI2UBvhjml2xoTErdtDpjIpaxE9O0x5LQ9VH6RPx7UC1XDg>
    <xmx:JrWkaDb69fKgo3JMzDnHqIZxMhWP71zYlCAB8iSeMI0BCJ2LgO3NjA>
    <xmx:JrWkaNQWI10zEB_QxooUx7tElczM8hrR-sEDWitzIZCBu148A4lGfA>
    <xmx:JrWkaNzwEXW9qxznyYIzzHF-g4wQX-H1cZmNsRTjyNZHDhRP3LNvsA>
    <xmx:JrWkaHtQITkj1svDbGxoJ_8xhsg_Q0t7TO5tpGBWohKG35n1e78M4uu2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 13:32:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/16] packfile: introduce a new `struct packfile_store`
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-1-1660842e125a@pks.im>
	(Patrick Steinhardt's message of "Tue, 19 Aug 2025 10:19:30 +0200")
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
	<20250819-b4-pks-packfiles-store-v1-1-1660842e125a@pks.im>
Date: Tue, 19 Aug 2025 10:32:20 -0700
Message-ID: <xmqqect7dxp7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>  	memset(o, 0, sizeof(*o));
>  	o->repo = repo;
> +	o->packfiles = packfile_store_new(o);

Shouldn't this be called o->packfile_store?  It is not like a
packfile_store is merely an array of packfile struct, is it?

> @@ -128,6 +129,7 @@ struct object_database {
>  	 *
>  	 * should only be accessed directly by packfile.c
>  	 */
> +	struct packfile_store *packfiles;

So odb has a pointer to packfile_store, which in turn has a pointer
to a(nother) odb?

Hmph.  It is unclear what this step has achieved (in other words,
there is no obvious thing that the information stored in the new
structure is used to achieve at this step).  Let me read on.

Thanks.
