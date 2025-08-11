Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774521FF53
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949136; cv=none; b=C7023BQbH+1FIT90RO4rbDRJW512/SxrM/DjN3/vQtLz1gsQ21CN1oXYQrrFofFjYY4qCMDlq0RksianhbMWjKvMH2VVqyU3SAKnaA3LOS0hl5DjAY0E1L4P8os1/boWE+uhXfgh0HYTb2803lqQgVk7O3G7VdvXqGl2AK49dDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949136; c=relaxed/simple;
	bh=1Nd4vDapN8w+hVohXSGfZh2lhKMQrd/kiptWPDlIGT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JdJrxTuZnmrNAD7Vbh2V1A38Ko0wWBLgoXVI5Yb8KeN9xO3YtFGQcso2+WHnvmCl2/ifxXoXuKhh04kisDFpNZg1844U3vrZwEO+rrWeyTgITWrQATEHZfe77XKlyBNK5CnFO0kj2dgBwF1dDGMWo5InuOC0ng+eTrhPWckC0mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eTRkxdd7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MX4+Cu3P; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eTRkxdd7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MX4+Cu3P"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E9381400106;
	Mon, 11 Aug 2025 17:52:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 11 Aug 2025 17:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754949133; x=1755035533; bh=4yUe6iaUt/
	o5k2rDfSi/2YpyGl0NE+YW4hucJpoZlpU=; b=eTRkxdd7ZbIVYSD62rV+BPXZNq
	MjMxX9NoH5y6QiqAWUCmF5gXD0BnT2Nm7X0m3vUJcxS6zhiABQk1KkfJNidHIG4d
	EXIDPORWPNgq1wdbp2ZdmAZxPJ00HZFs1PdyTiCRtx24u5DLvIdpr804F8aWssSP
	YmL+h676JNUGlkBmcdi6CnszONdOGmX/9zTYesY4v7qeXm3/vag1pd2/d8nZY5I4
	mhkhoR6zURRL+PrLQDCYk0oNutqMWUBXOCeUnl6GDKP69Fvl4/dfuh+dM/DUmENa
	+7w+VCLUjYDh9zqmAQ0jVWI+KAqIdE0fk51uLfrxPzJR27OdiFqh/RMxINQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754949133; x=1755035533; bh=4yUe6iaUt/o5k2rDfSi/2YpyGl0NE+YW4hu
	cJpoZlpU=; b=MX4+Cu3PhNgrPKPIziF96ewkYWkIBqO1lkIhGZ6ZlMIiSg3pcFq
	VmkBJKSfBa+fRoFRra4ZCLPR1GxU9GzFMLXheMOjg/+CUgantj1YYmGyoIlPhKuC
	c1UxIkgfCk3ANxUQqZp5V/++vPfKNL5ppkY/nEfL3KP1oH0jVbqtzqLekfQSLWMh
	e27HpiuA/37HMh9FxZKWGhIhHFuB7x+vWlKkXr1VQjfBCkWdImJvGMwoAeY4EKF1
	3t1v/0eTqzcY3sK7+BdD5o/EM66AiZ8sGtjAp0I8ENfoxwAR5ZG5EfTlgHIiKJ2O
	aAYuaAt46HzRA3AKCkziZC/klp/0z/Hnshw==
X-ME-Sender: <xms:DWaaaNxZBKQYuhILzCDyLGUMgQUeDE5qZpOZgEIh2-uCmC3TYZ40fw>
    <xme:DWaaaK3GqUg9KvZJckLnWXG9B-LhgWMwNnTFog2evEGJxOEEEzivWwZe5CXjp1N0Z
    U_HrSKPp3wc4watBA>
X-ME-Received: <xmr:DWaaaNxz9DSEad5o8Cu264cprbaeWnK6D2PW5pJdBs4fVSqddyYjd5EI16jVBfPpb2hF9sXbjnz7dH8VfLIsTjB6dTspzp_Dzkiquow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeefheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DWaaaBHRsQpDkNaAK6-MUSJ-BgXxAsVaU9rEer9PkfVvdSYcEavWaQ>
    <xmx:DWaaaAaqhBu1JYylc_8Le_mKN9IZK4Oz5y9P8xtJInzthnnmW3701w>
    <xmx:DWaaaDAkoE3usVHCPKrnulVck2uVhXKiCOJdlNAjxZhmky73Oo25WQ>
    <xmx:DWaaaImDW3iNTGHcLW944L-4liAOwUKN7MndGR0soIaYStF8Vkluzg>
    <xmx:DWaaaCUiu2darCwXB1RchivqXu5kXiHBstgjj11HF6aS5t63pK_TGowT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 17:52:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Ben Knoble
 <ben.knoble@gmail.com>,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 2/2] send-email: enable copying emails to IMAP folder
 without actually sending them
In-Reply-To: <PN3PR01MB95972CAE853F4079F0F62F0AB85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Wed, 23 Jul 2025 16:03:51 +0530")
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
	<PN3PR01MB9597EC4C5DF97943587AEEB4B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95972CAE853F4079F0F62F0AB85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 11 Aug 2025 14:52:11 -0700
Message-ID: <xmqqv7mtzfuc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> +--[no-]use-imap-only::

This is better written on two separate lines, i.e.

	--use-imap-only::
	--no-use-imap-only::

if we want to pass "make check-docs" when the topic is merged to
'seen'.

Thanks.
