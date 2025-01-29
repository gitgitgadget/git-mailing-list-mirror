Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB31FDD
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158645; cv=none; b=bfXBtGqVyp17TrTKmMmRYcqqh1UobsXw9oiXLiCApU7dfiwPqr0lw+f4DUxRP7pLZ6U7RpB+uqct8mBaaXS29imXhc+sF/bzZ/+2j936DLa1Gb9qyhWqqokMJ+rMMIsYWEDMFX3SYbt0fNKXS0Jk5Vw5vCyiUeKCk3qtHNWvud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158645; c=relaxed/simple;
	bh=mJy6CyyRAfgq7asjjRvwm85Py43bYVKNTIvahQCuqbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sINdEL5u92W4eMhxQwV01e8rbC2TyHhXiAipcGrjxm0NIZWimeusVA/aCuR3N7l1DDckg6nvLJXK+1GTwl7xcobUNoTcKWKRvDl1cGRWAXiUcDlEPv1+NzWbdJ09xIcs9r0rzihnZZrW9WHLC1rp8thfT/qfrp4NrpFvJVeK3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WHMiYxzj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l7EwWm04; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WHMiYxzj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l7EwWm04"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B607511401EC;
	Wed, 29 Jan 2025 08:50:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 29 Jan 2025 08:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738158641; x=1738245041; bh=AlY8KZLfKq
	kWS1835L63gyvs0RWNehdJmqJLZv8zEKA=; b=WHMiYxzjgYVsQTvrz4mMGY/ZVC
	f6VJ5vYuh4IslO+OWaAmR8vYl4LstzrAVLjNF8kSGtGe/YOAO2+5Xh/UHA2xM5aM
	GBn0ii5s26a1/4RIFdDvV4CM8sH6vpNcODbseFSATLLUUHE+zdTwoWWbah+TJWQM
	sA58ZViok8jxDE9idaJ1vP99muqkOpkXv8LRX90BfYVHh2RAdp8ZzIGYuTLZQWsA
	yNPNPUY9dCfC+KvmLhV71e6wMApiGkYZh2K6jkAcH55apjV2iPJXMGX4WiL7BZUW
	kjnRJyG7lyVPzkWE8WnNcamjc6Ogm9vsp6TVTk9FM7ukMn7nD8+QynuUkIyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738158641; x=1738245041; bh=AlY8KZLfKqkWS1835L63gyvs0RWNehdJmqJ
	LZv8zEKA=; b=l7EwWm04PLNqK5koBqThDn6jxjJUGqSYWZQEjfvffpYsI8en4ZJ
	i9YgoZTGNqW6K/8gHkpfRCeBsw2K8fhwQ1h3pyOKqpIiZcKOkim6+BaWbEpDYxz5
	syw1wd6geOyk+vkfTH8MInlpS5+7BtfqJ1a3KzW8AfgE2AcB/HqyzcyxucCDfePC
	9/SHq8c7YkqbM9glqqB1cfCbTBQ+0nUKFVCX2zu/cF9IOOavsyMOkIn+1vfBfAxn
	afGIBsK7Pubnch1s9WblionNmV8V0qza0iKrZ3+TB3DL6mJCeVjoQJKU875/V5mt
	ks7KL/vOtf+P0f2wIMnOKwcA69oxlit4G5Q==
X-ME-Sender: <xms:MDKaZ_v5DKIXgsbOn6SbrfiFcSKDn13DSoJ9VeEJ_fnlxiz5sVYfHg>
    <xme:MDKaZwcOeA3JkscKeEEky2dybyEFNkW78GLE7gTqlrK5wF1S3BBTKMaJTk6PrXq2q
    snQtfDEvWMjJzMkTg>
X-ME-Received: <xmr:MDKaZyybjJD9OsdNPGFBKDekRoj8TQ-wYEhrwp-vKDFuVvwxKEcVWXJ-muMEC-upVTHM4FMALAWQ2bUF-YuRP9IXdiz5tEJRTGNq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepjh
    hlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:MDKaZ-MFu1j7p1YmcBNWrQAydU5pVSAhGzSgMw4Dy9M2X8pmw9F3kA>
    <xmx:MTKaZ_83c1IvDBND0If35lrsP-gJcMLAT9nznWKFuHTvE9AK-d88Vw>
    <xmx:MTKaZ-WNWOFYZ1tAxYSFVZMbDOnNE6ATgh9Rkv9e2PIcnZu7IH5hzQ>
    <xmx:MTKaZwe66VnFfqb2y6W40tKRHIPsuRkSFtCID-EVVpXqqmSA4K2lAQ>
    <xmx:MTKaZ6kB1NvzWI1DKZSMJs-4erPEz_bXKofLdulk_w8-hW8dWEDX3m4V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 08:50:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>,
  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/20] reftable: stop using "git-compat-util.h"
In-Reply-To: <Z5nX2BEoF0YxYKTg@pks.im> (Patrick Steinhardt's message of "Wed,
	29 Jan 2025 08:25:12 +0100")
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
	<20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
	<xmqq5xlymu5x.fsf@gitster.g> <Z5nX2BEoF0YxYKTg@pks.im>
Date: Wed, 29 Jan 2025 05:50:39 -0800
Message-ID: <xmqqh65hloeo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jan 28, 2025 at 02:48:42PM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > Changes in v2:
>> >   - The splitup of Windows headers has broken compilation because some
>> >     of the headers couldn't be found anymore. I've fixed this more
>> >     generally by converting includes in "compat/" to always be relative
>> >     to the project source directory, dropping the platform-specific
>> >     `-Icompat/` include.
>> 
>> Nice.
>> 
>> Use of -Icompat/plat/ would make more sense if our sources include
>> a header file using the standard name of a file that usually appear
>> in /usr/include/ on a platform that either lacks /usr/include/foo.h
>> or whose /usr/include/foo.h is inadequate by giving a replacement
>> definition in compat/plat/foo.h we ship.  But that is not how we use
>> them, so I very much like this change.
>
> We still do that for drop-in replacements like "compat/regex" or
> "compat/poll", but for everything else we stop doing it.

Yup.
