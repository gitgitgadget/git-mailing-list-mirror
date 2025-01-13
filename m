Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0301E526
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797655; cv=none; b=oN8tVZvCq+Sz1ER+dhop0GY9CDhOATDk053nlKD/PPEvlhGEBPHx3QmU2I4BNwcm350lRbBxnQ2Kuvo73D1Bol/6IF6oLByOtV/BJzMMCUFtr9TJFU8e8yAXbzZno7Bns2bRN+RI+ED/uA2YWJkg+Wu25sRNfhPGWBp/oxOlNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797655; c=relaxed/simple;
	bh=WWDV195GgEojFQqwbzOetoQqvB11oJPWeU8WQd/DZSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PelvztebVn4ojTSdxgVf+TMafuqpK6Mjp6ASzXN4hrpZ5wwejWHjTB9vjxy7Xr5sUMct9FfpKdSlM9TePIb0Hz+8P+JlBlFtLwH89hhT8qZjT1WUDGwU+kMEAUxR7zrBJSO4wcQXpl4Lomxzsnq2YjYRgzYnmNMrZQsuQiGUMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SlQ9NKiP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hBdb5G9M; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SlQ9NKiP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hBdb5G9M"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 88B0D1140100;
	Mon, 13 Jan 2025 14:47:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jan 2025 14:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736797652;
	 x=1736884052; bh=QHHp/0CrcH3Jk2pQemrQOy4FlPNynxuDBF2wmUwhong=; b=
	SlQ9NKiP5+WSkuQQ+rsE6M3jTg4ZRdFTrJnSx+yPeIFUX3N4XnXs9qlxL7gBflDV
	FJjHSfrKyLa9NKHmnjhBhGpkQOeV1Iz6H3R1d8pFw6obsSCgs5YK2TtKa0fgZegf
	c6HfaHJmlMqZgU+mRbjf1lDdR159mR3qpx/JRo7hpvihMHoxZ2j8uFnI2u6KKlM1
	sBznpg1elaUjtp8xSW37tyApBCdCSOxcm61uQUGkeqUl/8k5uKIoP7VyG/id4lJq
	Na6qQRZuEKJRI4wHy9neXDfMWPXSF6slMJ2sojlIsIsxoz0b0irnVnZnNuFWgYTs
	g7ynctzsainRedHHz/Z+mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736797652; x=
	1736884052; bh=QHHp/0CrcH3Jk2pQemrQOy4FlPNynxuDBF2wmUwhong=; b=h
	Bdb5G9MgK8sKUX38Z5+ATxOoldcVp9PW0dj8gZiS4Amiq8KdWRrz24ixlcIk3mm9
	cY/+s3Khe6C/v6QqDZ+DHloFUw9Ur1qH4Ici+43CXN69qrAX23zT/4qgx/gHjH3T
	/4Z9ksQk8h/LZWdzr/nLwSMhS9pU+NBfYzqUQ+5sv//hqmyNmb81eYggbHHac6yZ
	t5VrHn/2QBDBE9MDcJ21LAqHH8wqLhVoNJx8tRKTo9PipMUreF0mLKovnvFlibyH
	BTBgcKE9sw3Sw9coSfMXgT8j5sS7reSKb43I85zxn+c6tsqVVSz4om5xBwRPMSQc
	6l/aBfWsJwKPjRstrlHuQ==
X-ME-Sender: <xms:022FZ6wOtK9XFzsnhyz8Tns2wqHKcVJb5DeTim5Vxh3mzH9k98mEeQ>
    <xme:022FZ2TjXotYZvtB-iBvQNkfzbuhpE6h950DF2cuqtcl2GY7vUNSNwgh57UyJWljY
    s7WojxDRnuIwJA7qA>
X-ME-Received: <xmr:022FZ8UBQ-e9WMhJAKRygTB8P5x6VkTdugrjh_yEApQ7uHQnamdWnq9PXOsHHXsyVfkS-Obg92TdB-xjpnPUM-Dqt2Z5_6btj97GEpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrg
    hkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdho
    rhhg
X-ME-Proxy: <xmx:022FZwgrnmcqCpAMMjciPr6FbtW9ojSC-e_YUsTxO1ahwCJ0ZUuAKg>
    <xmx:022FZ8BGpRCCsVS3zemf0T5v1O9Yz7o76hn-aiE341LRWaFMjuZUWg>
    <xmx:022FZxI81s1zaTaihcmuCBdqRayf_Pf9DNSxKANrBWmlXtOMV5CJCw>
    <xmx:022FZzBRZY3iu3zgIyFVVYe_P7mTO31f3ILwhliaeZjza0-dwP3DJQ>
    <xmx:1G2FZw4J6yOzgMJ3CbwX8VbtAyi_xk_SKq9GXVjJhfCf7ZX8sT_qqJYG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 14:47:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] connect: advertise OS version
In-Reply-To: <CAPSxiM93asot47GgfK3ExNWd9M-4fjbWzRWQ=koCFdA8rNwD7g@mail.gmail.com>
	(Usman Akinyemi's message of "Mon, 13 Jan 2025 23:56:29 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250106103713.1452035-4-usmanakinyemi202@gmail.com>
	<xmqqfrlvzzcd.fsf@gitster.g>
	<CAPSxiM_0h7OyQO-Of8YhcOt4KbtuoKXe111ZCvsLf5y+OgCHaw@mail.gmail.com>
	<xmqq1pxdnuxo.fsf@gitster.g>
	<CAPSxiM93qVjoDGBRaGAv1-o3oiKkEE0mtH9ERTN9dVxvZpCczw@mail.gmail.com>
	<xmqq5xmokn0z.fsf@gitster.g>
	<CAPSxiM8KYpmoSYaWciF_KrtHhUTPj543q9mgio+qdeB-FHeDUQ@mail.gmail.com>
	<xmqqldvi5v5v.fsf@gitster.g>
	<CAPSxiM8kWoAXEvAVtp0C9NUQaas3KN=TMBA-p9o6+8KDQbmBUA@mail.gmail.com>
	<xmqqmsfubtt8.fsf@gitster.g>
	<CAPSxiM93asot47GgfK3ExNWd9M-4fjbWzRWQ=koCFdA8rNwD7g@mail.gmail.com>
Date: Mon, 13 Jan 2025 11:47:29 -0800
Message-ID: <xmqqfrlm8pim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> On Mon, Jan 13, 2025 at 9:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>>
>> > Actually, in this patch series, there is a config option called
>> > `osVersion.command`
>> > The specified command will be run and the output will be used as the
>> > value for `os-version`
>> > capability.
>>
>> That is essentially a "you can throw at us any arbitrary string".
>> So my recommendation would not change.  .format would not give us
>> much _additional_ value in such a case.
> Hi Junio,
>
> Thanks for this.  So, from what I understand, the feature and config
> option introduced by
> this patch series is enough, no need to introduce another .format
> config. Right ?

Yup.

At least until we and our userbase gain more experience with the
feature.

Thanks.
