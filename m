Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD664254AF1
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745017355; cv=none; b=HVxPAa0mRgnnyiuij50L1Uj8r3QJKNONg5b4LejqvndTi7GQGhhzz3xbNSc8dTC20/P3jZCn65hZ37UQUN7WfT8fVgbJRQyzhy6kZBDtJNygPlOz5I3suzfePO5rZZgxU2eR31xkWsIvYBvpCtlKAFgLI9s8O32Ra31Ndh2sm0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745017355; c=relaxed/simple;
	bh=fZG+jkFwZHySgYRd9sdri0Kp5VURSJIbCEbUCxYDaAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GMSKOtZihW4nA34f1J6ialR9y7zZTljWEnieSON1CWFgODadi40gWHErnlzQuiSEpLMg/Hg9vgj7m/+ERBWKGu82zqa4vHmZ0ajMeM3dU1LSeIn8sixRegHFRoKs43I8/4P7gcdCCHjh8IdCyVfRySWjL4X6CmxmgjrbkHmwpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TNpaovjO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xb61Hi0K; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TNpaovjO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xb61Hi0K"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A92E813801F3;
	Fri, 18 Apr 2025 19:02:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 18 Apr 2025 19:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745017351; x=1745103751; bh=HYENM0Qwd8
	F6ixvIDoyoSQGv7q2nTMIMeTMRFspBg40=; b=TNpaovjOflcAbbFFULXoz9auKA
	Gem3VSzYYf1Zz1Su87e5xh6iAKruiJY8v15ze4H57/SJhl8pHG8ZwotYDbRgDHAG
	VWOuI44gUJJMXGMyvbzDuOW4HO5RbP7UGlq5BXBgPCVGnfNW62W9NaZLUJh1th46
	TriW94oYuBTKvjXQGcYeQ9wOXPLbOhoVK+K3aXkcVSPXZxJWq6sBzuWLSuZJl3Ia
	PBmDK65tAz7nBckdsAKvjmIO0Ey1wUhT7NAOW5V/oHTxHhyR4hQ9+dKBoXGp6PWj
	Eu+I9ogLN69+KJiGFQD1LHtCrGErSHkIpOaz3Z6G7MEXXn80lJfzigJnEbew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745017351; x=1745103751; bh=HYENM0Qwd8F6ixvIDoyoSQGv7q2nTMIMeTM
	RFspBg40=; b=xb61Hi0KkebvuuGXvJ15gSaQ5YAgGGrj4JCKVjRh2Xap6fwc3op
	qm5gNe3KJkZZh0cbSza18JlntYPE8yYyUr2xf5DIdzFJfSGIbeT0F0gmcuyH8dck
	MX2GdHFjCu47/lOql0/TXEjkkkbt147iXTF+J1jseeeYlnaCTLJz4q1vf7PBqKeS
	KQTWB0jfNQkEp601FjD0dCO0IIwAIq+fwCd+LxasyhHy55sW0dBXILEkfOcHiLFz
	GCuxfm8iyE+kSeZvMA/RuvvIi0r8vv2CB4LpBCEgwGZusCkeihJBVdDibCEm7g6z
	A+I0+Vrk9tgZy0HW2/qcCwXYpTYHpPuE+9w==
X-ME-Sender: <xms:B9oCaKWwuj81vhsrVy8ykuJ69YxbkDMJArJuHwJkVgx4P2ei_12RDQ>
    <xme:B9oCaGmQQxNXUN50IjL0ps7O01zEuBKTNYzaNmZ1ICMyX_HCeVCR_UCHo5Q2pyV2H
    AbIEMvZ_OOmcjt-0Q>
X-ME-Received: <xmr:B9oCaOYqrw3hTJDHEuJvRNNUvwIMz7xUDkegNzeDneZk0NZZgLrSYOnlTosJDwEOSVOkAXtbCvJLjUfWSUetUzTqRQ1xz-U7JeUy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeefgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:B9oCaBVUC3nOKoea3p1v-rvKMitWzHWzh-nph6Gbe77ifwm4wZe7ig>
    <xmx:B9oCaElv_azuAQuNi0lcyWXGCPMaZwwwbKC7Oi2V4i5JcC7G3qSHPA>
    <xmx:B9oCaGeUFsA4ceZ1rJTsZX6ZE0BJ0CEo-mzIcRYLk2KFSeqqd1hNSQ>
    <xmx:B9oCaGFLg6Zfj5ybIhfza_7Jmq7fm_PxiBlZ1UTNjFuJjSAPR4lK4A>
    <xmx:B9oCaCTncOJsetcdIOhpIdQRweG5xkPznJ6ahW6Sd5emRgjBJEDlWbfm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 19:02:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/5] meson: wire up support for benchmarks
In-Reply-To: <Z_-Nu27GeW0o2E0f@pks.im> (Patrick Steinhardt's message of "Wed,
	16 Apr 2025 13:00:11 +0200")
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
	<20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
	<xmqqplhdo5ji.fsf@gitster.g> <xmqq34e9mgot.fsf@gitster.g>
	<Z_-Nu27GeW0o2E0f@pks.im>
Date: Fri, 18 Apr 2025 16:02:29 -0700
Message-ID: <xmqqcyd99ipm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> This one
>> 
>>     https://github.com/git/git/actions/runs/14406901394
>> 
>> is from last week without the earlier iteration of this topic, which
>> fails a few meson jobs.
>> 
>> linux-meson job that fails with
>> 
>> meson.build:689:19: ERROR: Command `/usr/bin/git -C /__w/git/git ls-files --deduplicate '*.h' ':!contrib' ':!compat/inet_ntop.c' ':!compat/inet_pton.c' ':!compat/nedmalloc' ':!compat/obstack.*' ':!compat/poll' ':!compat/regex' ':!sha1collisiondetection' ':!sha1dc' ':!t/unit-tests/clar' ':!t/unit-tests/clar' ':!t/t[0-9][0-9][0-9][0-9]*'` failed with status 128.
>
> Hm, curious. These lines have been moved here by kn/meson-hdr-check, but
> the logic already existed beforehand. I've Cc'd Karthik -- it would
> probably make sense to investigate (and ideally also fix) the issue as
> part of that series.

Indeed.  I tentatively kicked meson-hdr-check topic out of 'seen'
and the CI seems to be a lot happier.  What is curious is that in my
local environment 'seen' with meson-hdr-check topic did not fail for
me.

