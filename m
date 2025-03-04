Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B397327D77D
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110255; cv=none; b=NJrPpbBC9XsOETOJDf/+gWYqGdgn4ehTwSqBOw/nDfqJjmr7Oei1qtQ0BcW2/RwHIrig2lKlRlby9XlCTlvZDMG7UmlfMrY+qdEhNB5ZvnSoswgowz0H3ieJCfBRluPEs3Cn5RHvHuV9e/a1XWGwu3NvWyKkgm6JqmCb2PQZi8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110255; c=relaxed/simple;
	bh=VekZS0SBU0HSjtWE97DVdA2m0rcg/h8/r3pGAEnr2ro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qwQ2VbuUR5JpNqKRXGavXvtIToY37IK/vHQ9Lm07dru/sLDdfApTrsWPwbt+2+tJiYi+6D+IjvtU+IlU3G3VlwI44rWuyb5rE+8O5r+k5sYTT3dKPKl9Zc5a0axlbAeB6tF2a0Wd1DcMCnWkTfuG0fIvnEsI8I2k1rndf0rteAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ivi15MVt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=THIRAk/e; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ivi15MVt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="THIRAk/e"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8457211401A1;
	Tue,  4 Mar 2025 12:44:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 04 Mar 2025 12:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741110252; x=1741196652; bh=zEZO5uQIa+
	2mPY+HpaErv5bRV9qTyekfbdoz5+XE8pA=; b=ivi15MVtRUP560snbxMkeWBSrC
	/DAWDm4oMdCu8cQYaYzsndgBitjB8LSvGEIqiVi6bgQfMjdY8ixv3nTNuygv9NpW
	3325NGhzqZlYHpTyBRhs0Ak4/ez6rIutr9mdb0RmUuVPG6YY2ax2QCJ0XD8UrNLK
	atXxHAA6cRXbVGPF52ZtrWYUkQsT7g9aKD6e6OtF03AbndtKsWb2hOwZJ9zPSBbc
	v0YQnyttMwS4QQNfOo/xNsOPyqUdkwrpstk5FKEg3PgYJmUZkLENw2UEYL6jghxO
	M3gsxB0TUzVmtLtFEyU/fKNPcJ6uJQD/GxKxR0AX/YnjnHGGVwkz+80UYKcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741110252; x=1741196652; bh=zEZO5uQIa+2mPY+HpaErv5bRV9qTyekfbdo
	z5+XE8pA=; b=THIRAk/eSyjplcaf6VK/w2Iq5I4azTZr3coQV7V4N5ccmr1TDKN
	NQD2gy0lsnvqVkZR2XY+2B+Ju40A93WabhVrtVfB8IytquSZrsn2YYpyVXxtEXYT
	558XUZM/p1yJqgYOlJpLs79LN8cwDSRTz+tpRNuUTabnUlmqVlhSBczUy3NRYoF4
	K2j9H/Mpf3FzZBFClcX7mjs+oZUuDIzA9iaZk8pbGwuhptEcTBSAWZpQ54sInprX
	KF/FzNuSldrt59zA9tRrDyFP7z61dq/2aHfTUrz2Xn/H/JE+RJ9eALCtTAMLON7Y
	4wDfORWmQJPMZmyzkcs1sUipXL2gWnyhSWw==
X-ME-Sender: <xms:7DvHZ8Q-9amqoPawoCURP6Zk_aUD2gGas2CqjS5cHUyLzpJXVlJJGQ>
    <xme:7DvHZ5ztddD9Tw9rECRHIr0O7NOWVYnyFupHCl9anBSJS90AamH6Ah0BWAHL_HOcu
    fRAAEmZrDgV7etZrw>
X-ME-Received: <xmr:7DvHZ52r4ABtES0a2lAtJPSWSeRIr5tqUn_l0wnAs8H8HRZYtMSLuyU-IP8SNv0Sz4FUtXE75s7dyhT3paAVCDMFO64vYqwOPqyn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnhhimhgrhh
    gvnhgurhgrtdeltdegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7DvHZwCMd9nDOCqScoKLCTxHD1F4Rgd5ce2qpOapJ5_TCULygT0VXA>
    <xmx:7DvHZ1hg8kv3c52i1G4hHXHctQKnVdkiKeOlG57t9Zp3mpDGE_4MUQ>
    <xmx:7DvHZ8qxyLqvGilLIFqZYYGkKUHvGNC6lzIqQas-jZL5vjF4zmP9-A>
    <xmx:7DvHZ4jABFxD7RNSwz3WGLOTuObf-OniUhvZxnyb_YZf3b4Xzbn8Tg>
    <xmx:7DvHZ1fYynCpdrnvBfh5yDNvrIChB2zRReIpPLd0VMmqTTYya7gP8jIx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 12:44:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mahendra Dani <danimahendra0904@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/1] t1403: prefer test_path_exists helper function
In-Reply-To: <CABGrwBBaHzM9tE6vWkuMSZuUbHVWwCZVTgkvMb04C=NYyGCLAw@mail.gmail.com>
	(Mahendra Dani's message of "Tue, 4 Mar 2025 23:05:29 +0530")
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
	<20250301105838.1481-2-danimahendra0904@gmail.com>
	<Z8WD2MeHpOH7Ni8A@pks.im>
	<CABGrwBB1-UiiPEOptN9csVP1WYg2X=SWeMxxiyDfz02VmDp1vA@mail.gmail.com>
	<xmqqldtlt304.fsf@gitster.g>
	<CABGrwBAaN3U8WCtPgd+UjVjsoBniCawWV3U+WdKOzBdG5LxmAg@mail.gmail.com>
	<xmqqwmd4r9jx.fsf@gitster.g>
	<CABGrwBBaHzM9tE6vWkuMSZuUbHVWwCZVTgkvMb04C=NYyGCLAw@mail.gmail.com>
Date: Tue, 04 Mar 2025 09:44:10 -0800
Message-ID: <xmqqsensr8r9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mahendra Dani <danimahendra0904@gmail.com> writes:

> Yes, due to the use of the "-f" flag, it's not necessary to explicitly
> check the lack of file using `test -e`.
> But if we drop the "-f" flag, we will have to check the lack of file
> using `test -e` or
> `test_path_is_file()`.

Isn't it the other way around?

    $ rm -f nosuch ; echo $?
    0
    $ rm nosuch ; echo $?
    rm: cannot remove 'nosuch': No such file or directory
    1

