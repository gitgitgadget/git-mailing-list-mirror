Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D4374CB
	for <git@vger.kernel.org>; Sun,  5 May 2024 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714951050; cv=none; b=p6wN6ks1cyRrr+OsIqJ6TkTDA4yAKUwLHtol22fdRKB0T8un4sfaTXWyWMu8PbswuJY8GSi94/cGUb8J+8vzHrmPFh/l1GJlBt/zKhzKF8ynQIfPYUvLodIs7Lpe5gx1mjomn3szbsZvo01GKL44uY6QLPiB+YrfIOcddw/hZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714951050; c=relaxed/simple;
	bh=5zwSWI6bXh/uCqGIt8Q67wDsh2s+Aebu9FcBmdis51E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=iNHwIVmHwict5GAViSTECKDYl7+sITM6bTKMzGQa39hBvuwEDOUCvfHUcTYF2Ag8WaLq+xP2rIaMFrqqzNGyoFROpPb1gnf/np1jnZuvIW03GqyE/2FNq0QiMsi/1iHvHPN4R9DI8FzMdM98q39eRyXMkdHcwQmDe2Rsjsh0kXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=kaaI5Zfi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=afkM+q4d; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="kaaI5Zfi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="afkM+q4d"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 9223B1C0012C;
	Sun,  5 May 2024 19:17:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 05 May 2024 19:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1714951046;
	 x=1715037446; bh=BDSB+LBES9IbTKFKawAzts3boXtkDqtNM++wK5BFKwM=; b=
	kaaI5Zfi1v60RzWrH4X7y5cQCey3ra4lQ7mlhCE8EFs3mQEy+tgLYWjxIKSK7vWk
	QJiyTShqYFl+2Vcj1dplqR5FxnrIBS4bmuUpS4HuOZg9EpoglAjDJdFqGU+dZLEl
	ji8ue9/iYDemph2PdpQvE5iL4YRjMwW/xNsgVEUaaK6ebQCKs5LMh5XYk7BZp4Ms
	KVFuSz+EmM4uHl+hza5MZFNPkze+i57okwzCWwmNxvEaKPVV79UKxk9/0XgMDspz
	WgPhbKYsIk4fQ275CUhkvV+umxUIOntenHTg8kuCF99WhAX/PYhdhIanI0rmPghk
	EDB9C3bcBLvK24+zXxmRzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714951046; x=
	1715037446; bh=BDSB+LBES9IbTKFKawAzts3boXtkDqtNM++wK5BFKwM=; b=a
	fkM+q4dOwnghB6pc2LMLqNTNR+zXFJhGK2b8enBT0ccWza5x91lsm0zjHR4hTzAf
	bxWEJ+ePoNRhExe+fZE7wj6mQxBMWJlh7pJTMDxuwgDmV84vNQMpjQikFDO7rccu
	cAujUwLNbCFVweHjqpu4P0AsHqUkIKdoX6XKN7/hNtl7Fnh2WBsqAGg9Wk7475J0
	JhfRcBw4gMffTyeVJqBwfY5ka3v3AWWy5KZ6jLMXb7QYFa6ERUJx712CDsgfJlmv
	nUsLGRK9rx2x2tTaRb/paqX8mwslOYYhx6PKm1olYeiHFFptWNa3Yl2o514D7rQm
	2gJXBAuX5zY5TfX7F0T4A==
X-ME-Sender: <xms:hRM4ZjVI4fIjUA2BrXgS5IWupfQA5xU5iJ9DqXu3PSVe28dOjmqNPw>
    <xme:hRM4Zrl4nZ9t-64LLb8455xlzFlXKa7VBV-qjopV5Dnw8jSHXPzmaLYxUBTh25G0w
    63Bhl-WQX60VXkUJA>
X-ME-Received: <xmr:hRM4Zvb0biAZg4eiGiKHZuDKYqPL9KmxI-eGkC-MKO4XfiH-1MtNcCe_9aaqp1v34unc7U2yKAIhCbkUfx1yicC_wllZ4P-QQujyj1Qe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdflrghm
    vghsucfnihhufdcuoehjrghmvghssehjrghmvghslhhiuhdrihhoqeenucggtffrrghtth
    gvrhhnpefhteeuheduleettdejkeduleeuiefhveehuefgheehvdeikeettddvveegieel
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrg
    hmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:hhM4ZuW8_uq-JNFKSfIi5vquuNUoFuIKnRxIXP50Uq_wYPzS2-0r4A>
    <xmx:hhM4Ztnvi-Hhln9eWZff9zuV5ppTTqaKdy66ot_FdBlyIyd9IKIUuQ>
    <xmx:hhM4ZrexBI1eozcXSdA-A-Xk3IiUDklvuL1Qam2k1FLKAEK58xwY2g>
    <xmx:hhM4ZnGm-zvcnGPC-XCFVsUW7yZmJSnc2qSxFDPqwClnpRXc0DBVlw>
    <xmx:hhM4Ziy_KSsDxoJ2nZ9zIBf-9RVXV17gby1puawFC9vBF2fp6cUcnal0>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 May 2024 19:17:24 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 May 2024 09:17:21 +1000
Message-Id: <D123EO5XLSAG.1DARNM0DT2Z74@jamesliu.io>
Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all hints
From: "James Liu" <james@jamesliu.io>
To: "Karthik Nayak" <karthik.188@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240430014724.83813-1-james@jamesliu.io>
 <20240503071706.78109-1-james@jamesliu.io>
 <CAOLa=ZSHPVbd2pweNz+MtkdWgsZepsExODyd7UNx1774TzWV0A@mail.gmail.com>
In-Reply-To: <CAOLa=ZSHPVbd2pweNz+MtkdWgsZepsExODyd7UNx1774TzWV0A@mail.gmail.com>

On Sat May 4, 2024 at 12:35 AM AEST, Karthik Nayak wrote:
> Hello James,
>
> James Liu <james@jamesliu.io> writes:
>
> > Hi,
> >
> > Thank you all for the comprehensive feedback. This is v4 of the patch
> > series to introduce a --no-advice option for silencing advice hints.
> >
> > The main changes are:
> >
> > - Two preliminary commits to reorder/clean up the options documentation
> >   and usage string.
> > - Caching the value of GIT_ADVICE.
> > - Adding tests which explicitly set GIT_ADVICE to false and true.
> >
> > Cheers,
> > James
> >
>
> This version looks good to me.
>
> Thanks
> Karthik
>

Thanks for the review Karthik!

Cheers,
James
