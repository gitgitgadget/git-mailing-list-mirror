Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2A29CE6
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745005884; cv=none; b=h5sGbeg/P6Dvmf07Q6Mg/l8yQ6skWSgC0DPNA7c+tJhL09Eej6JofF1TwLaZbPvltQVHPLfdpi6adVCHEWmgvKqttWf29icF1VPNGu0c82EJmTMH0TkQacHLJYXucOwHeZBBtxYx5nBl2MEeye73rBklnyhR6sAHkHuPE3OaJLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745005884; c=relaxed/simple;
	bh=2uKWen0dx8NWMwIWaUjhqy4fwCy+UGZ4GLUkHbW6VtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DEJhvfF/1xxCdyvlRsU7M2Is79wfgHp6p9hbp8bNVhrJ6w6RoTSeifY2wW+Y8s8FZ1pz184v3VJQC5eD41py4Yg9sLdFU8FVh/9GNVajQDll8tQfm0WMxxIqbiE5FsxEQOzQg1Nb33V6JdIWQc6qxlc3Nte3CGLdAS9IPk6SeoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OPcAd6ec; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fKAYEF6r; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OPcAd6ec";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fKAYEF6r"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 989A813801CE;
	Fri, 18 Apr 2025 15:51:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 18 Apr 2025 15:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745005879; x=1745092279; bh=gzxijUqowz
	CBA4xb42uKXycjSJUBQqCDR3Z0O+Zm1p0=; b=OPcAd6ecrQDjrlRGWODf6xQiDT
	cRZ1i/XsbhPL67D9GgOFMgGYoOH5gp4p5WOidopsxPFhp/Uj5MyStfii2HnTeJIQ
	tF4iaVVHbPaqd+7NzkG3Zc3TbdxBtjFJwgh+jwGto9bX+VQoFT+WumSbss4zKwfo
	GP/ANxHwjgnJaAZLYjWJUb2cdsKfisl23Go6ofRqTSWCdgUL5vtLq2DbQh5Bh+1Q
	GUp6LnZAxb4fA0WJUE76IlXVIeHnOIrfRoJdwXbLDbH0weqLLaiPmcbJQUmMq20L
	RMuxr24n86aumMZDuiY5M4TEKWA2ZQl7GD45ogvEiZFyW12u0VH6aEYqNdlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745005879; x=1745092279; bh=gzxijUqowzCBA4xb42uKXycjSJUBQqCDR3Z
	0O+Zm1p0=; b=fKAYEF6r7dB5IcO/DsD+Mk9pHMHQVNZLlMWFGw7sIvcjiTOM4gr
	nOwqilTRPd6g1eEPdSTYLka6cENlD1YOXwpqlqL8n8rGI3Rm7BICUkkW9xKjGdAY
	hAYsgABrfi0me1lpB2FYeIPw9fAnrTTTyucaS764Yl6e1Kbj9kBfD4ljRhEeKyQg
	G1dHweU7YpR5TQojRlXMElnnJu0XfbqvUIePjdkHUh2edSbneYn/rKPN3BI45JTx
	LcQXge1BL/lgPGtmy+a/bMfYSpDmYlbZ8B0L5Rc5QSxGEGtxH5FHZ2nuRfvj0qmT
	dMn3vIe7uCHzZHvOuz9ioIzUaBF6/P/1hUA==
X-ME-Sender: <xms:Nq0CaEx1emBnV5uZVvgmlOastDx312p29HGh2F3lJizH3Y_uPGqhng>
    <xme:Nq0CaIRVjGvtgwKUtvxllPKdyDLmQncxu3ac4R1BxqZFW7XAcKrKOnUgxK0YNrQex
    IZXp2clUS0kb0jHIw>
X-ME-Received: <xmr:Nq0CaGVZpSQIHizudpqPex9vZlG42S6GA11yiD7SuxUrMl7cv1Z9zjg-bZH4CyzcHMP2Iy6VouE3RpAhEb5udg7pmz5FpfIFugFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeftdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:N60CaCg6t2xxXk6D7Fz_rtqPO3vzqNHYCmzb4Ji904ZyftuCObbEKw>
    <xmx:N60CaGB3Z3EwoXCC9NpD2I0QRKg2OvN6fEbzmWYCEua7IqGS8HXOVg>
    <xmx:N60CaDKwtAss3fMNndTtGTkTW7fHDC6s2sGvdmPdeAxMtSl7ZaYSFg>
    <xmx:N60CaNCC8Y7t8k8OEFZTvVTodWZLIWmnGGaXPMkUJt2oUd9_RMXm0A>
    <xmx:N60CaGOKox281Vj5Sbu3InbS3ZrgRYxk38Wpowhgu6KDu5CxmPXsYGSV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 15:51:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] t/meson.build: remove deleted performance test script
In-Reply-To: <4b2fdfd0-72da-4c36-8b8a-4ef514873d39@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 18 Apr 2025 19:52:01 +0100")
References: <67c50fde-d29c-404b-a296-9f0e482acaf3@ramsayjones.plus.com>
	<xmqqmscdbc6g.fsf@gitster.g>
	<4b2fdfd0-72da-4c36-8b8a-4ef514873d39@ramsayjones.plus.com>
Date: Fri, 18 Apr 2025 12:51:17 -0700
Message-ID: <xmqqbjstb64q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>>> If you need to re-roll the 'tb/pack-bitmap-lookup-tables' branch, could
>>> you please squash this into commit 8b0b5c7046. (the meson build on the
>>> current 'seen' branch is broken otherwise).
>> 
>> Unless the topic by Tayor gets rebased on top of what contains
>> ps/meson-build-perf-bench, which is not even in 'next' (hence I
>> wouldn't recommend doing such a rebase), this needs to be dealt with
>> as an evil-merge semantic conflict fix-up, which I did this morning
>> and pushed the result out.
>
> Ah, yes, I just fetched and found your fixup (which you did hours ago!).
> Sorry for the noise.

I very much appreciate your being on the lookout for any breakages.
Thanks.
