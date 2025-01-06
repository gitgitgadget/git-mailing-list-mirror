Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECBC13DB9F
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178673; cv=none; b=jAxhycPxCYJSG5DRAr6UUnQoBu4LSBke4MazQ25+raYXMkcZT8jxy0tvpMq7rJPb1bZaA1rlQTxVSvv29n9hBFDvgeWG/qnYELoRvgZ+mwfX9x07BJDURPLkv4a7kTFUyPrCG+YKiill+SDNWz/Ej3mRf0/f9yyn6lbWGc23GRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178673; c=relaxed/simple;
	bh=zoecONq8yPyuXmScnoCOFWGVEw8UYB7qXjHOhHCY6jM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hvUbcmPrbL+RsWkrVpdsu1Zmj68gl/03kinVDP8G1Fas5mCrAOhqseDcW2O3idPKZ0b1wNIW7td+ZnFPrONWJ0UVyUCJpnhTBMIGQ2kZw/hs0d0nnHuf/ZFUJZ1vyfLqg/EqMVPYRKkw7SdtUd5vmWVvrcKZluiydC1WaFYU6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=t3BHfab+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HbVaZ82r; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="t3BHfab+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HbVaZ82r"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECF9025401CC;
	Mon,  6 Jan 2025 10:51:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jan 2025 10:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736178669;
	 x=1736265069; bh=7P1+OL9RufLp6QXu6VMuV8GrJP+6YiM4qgs/bxWygkY=; b=
	t3BHfab+CyNWfdh+DV6aD6LYFDcwLtRFpNtGkwlNi/WtEhuVnsHmM38qZisHwJ+Z
	gh+62ieUt6vGcaKmp6a2sQZRKmgYsRxXtakSOyNoriO6mlWIKbFCKV4458pn/qXU
	8dUsj4O8Bk1onQhIm4MBuaMdgVaLSA5oGnAeTwJ0pzwP3iOxYxqoE3Mi2pcTs620
	zm5OoOW6X69FtTiAYK7smnsggXpgLtf7qDG3iMzmk3+vqEao22Sq4DbgEL82Eerh
	pSpDB+nFrWbCK7NzCygwV1pep+FcV5egiBMptIdYi+pamgw44idU++E3z4O3K28O
	v5O0ECTTWU9LTKlw/qJpfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736178669; x=
	1736265069; bh=7P1+OL9RufLp6QXu6VMuV8GrJP+6YiM4qgs/bxWygkY=; b=H
	bVaZ82rIG28EHM4jWNlMMTARbqgpCmxMGUo7sB/Gu9Njbo8XgUaVg4Q96pBEzknh
	I4PlONENEwQIq4CORiCkPGJC8KJGfS15FnB+yW8HYuw57y1KedOwwcy+G1CCL3dL
	dT+/b5fLnd/AtxvAZU8UQD9mq1WNCC0WAnffBmeHlXikql9MA1Ss6YI2WUGDcHgY
	BBcyxzwmmO3Su3YnSGtvk1mKU9shzfwn7FZH0B0FWt09jI/RCjss8+Rpl1+uX3fl
	t1FlIlfHzdNao3NYaZBzr7BjfRlrPMTHW/dTt5Bxir2ZCDSURN42ik6oxvY/RR5Y
	5FacftbP1v1OlKoLMrbNw==
X-ME-Sender: <xms:7ft7Zxa5lS9fA7_ekaamTg81geoApTLU9WA92A1Rc8kcxTgsUXhtBg>
    <xme:7ft7Z4auR8NI7fL8pwjY0i9Bf2QhhuaclKxNpLacoatcTPi8eTTXeQgSqqO7BbACY
    b5B7XCpjbf7IqZeLw>
X-ME-Received: <xmr:7ft7Zz8LOpv8VHA7ThwlC7Kq46m9b3KfcALd7gZxEJjdklez3IOdKcNioXCH8_sUmIqwT7RfcWge_fs3PEmlEKYtHXtRgwqARoTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirg
    hnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7ft7Z_rPyIKGTdAhAkffJ2b0uh3KnThQh40SXPpHtIFuWe8yzHmVzg>
    <xmx:7ft7Z8rtFt0d1EEafCZAKgpkxMojZtbFOy8BW-rsE8vWtRJgKUPszg>
    <xmx:7ft7Z1RXhZ8itYfQ_In5NCupYcrtpqAtXxPZfalzWMlCGy_1ObvDAQ>
    <xmx:7ft7Z0o4SYRSKb7YBBxHrwUw_0ltjiyR3AmoaHfgVxZyhCeCpfLbaw>
    <xmx:7ft7ZxBgslkXLhQUja4jaPT5801zGGLaYCx48olI9JqF59YbUbMtgtFj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 10:51:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 2/5] ci: merge linux-gcc-default into linux-gcc
In-Reply-To: <CAP8UFD1ALC2f9iQady35MCdm18V3u9+b0iRhgx2Zd_UTeCY8vA@mail.gmail.com>
	(Christian Couder's message of "Mon, 6 Jan 2025 14:25:23 +0100")
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
	<20250106-pks-remote-branches-deprecation-v2-2-2ce87c053536@pks.im>
	<CAP8UFD1ALC2f9iQady35MCdm18V3u9+b0iRhgx2Zd_UTeCY8vA@mail.gmail.com>
Date: Mon, 06 Jan 2025 07:51:08 -0800
Message-ID: <xmqq7c780wlv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Jan 6, 2025 at 8:51 AM Patrick Steinhardt <ps@pks.im> wrote:
>>
>> The "linux-gcc-default" job is mostly doing the same as the "linux-gcc"
>> job, except for a couple of minor differences:
>>
>>   - We use an explicit GCC version instead of the default version
>>     provided by the distribution. We have other jobs that test with
>>     "gcc-8", making this distinction pointless.
>>
>>   - We don't set up the Python version explicitly, and instead use the
>>     default Python version. Python 2 has been end-of-life for quite a
>>     while now though, making this distinction less interesting.
>>
>>   - We set up the default branch name to be "main" in "linux-gcc". We
>>     have other testcases that don't and also some that explicitly use
>>     "master".
>>
>> So overall, the job does not add much to our test coverage. Merge it
>> into our "linux-gcc" job to reduce our test matrix a bit.
>
> I understand that the subject uses "merge" as the space is limited
> there, but it might be better to be a bit more explicit here about
> what the patch is doing, which is:
>
>   - making the "linux-gcc" job use the default version of gcc provided
> by the distribution (which is ubuntu-20.04) instead of "gcc-8",
>   - removing the "linux-gcc-default" job.

unify?  deprecate (the 'default' one)?  

FWIW, I do not think of a better way to phrase what the patch is
doing than "merge X into Y".

Thanks.
