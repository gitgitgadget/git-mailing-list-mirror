Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8B2F83DE
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321858; cv=none; b=UDbTEOlgJDvyuraD+8hNWhxtFXspzej0f47XRXJu5Y6p0Tc3nofwnllKUOYvdiZS/If1KZs0B6yKcSjwpwKkKirpIO9UJA8lwpXN2Khe32vnl9zAMd9fAKQQVptLTedwVJ1MExNAirTixq9feUpc/1TQkMPB1VzTVB0HU4vtHHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321858; c=relaxed/simple;
	bh=54G2j+BlIPMlJRH+Q56Ka56gOxeNrNO4B7qJZKMd/GI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kOpZ23udU0lKAaiQG03wJ3M73j8r6jqEGHdRajCNA3m2ohrGE3fdWhgEHR2kXJfxhCVYD+CQ9HXGvbRn8IjrDAJHM5fe8wFyHNdLqWEiz0lAN5C5wve4UN+8EvM19/ylPO72y5d9QsrNkOmvCM/VGfdCo1hjtjooU9STtsw2Fgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c5pgrniA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FY3P8ozp; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c5pgrniA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FY3P8ozp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7C1A01D0019A;
	Tue,  9 Dec 2025 18:10:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 09 Dec 2025 18:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765321854; x=1765408254; bh=4B3flw97W9
	xPQ9Sh0c8okilpGhk37Mz5Jh7A3jalYWk=; b=c5pgrniAn8RXecrFH8T0xTCv46
	h5u136LLrWwNHSgIqC32btNyJEZtMyj5SJtVaw3dD4Rt4vz3R6UFLEyBS7Y4kga3
	JLebHl6VLRsxemhhtSBonQmuk/WsQb9eJ8CFXMKJiGfUTMphI/WnG5QGIZjc7mQE
	CWDMbGro9kCFyFS720C9NIgESRWgP5h/o7HSLPnd9wRq4i4Ugtj/lNDvnxrb2n/j
	7Nhq8q97nTWSf8yhuGDhiBHOzgl8SGomAxBzeg6TsW2mytU5nRrEnxpjO0RVCZeZ
	rOwXwensgICpvAeJSluLMkml5yWFAdOO9QLFJw01KJw76dE9bf+DxF2s9v0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765321854; x=1765408254; bh=4B3flw97W9xPQ9Sh0c8okilpGhk37Mz5Jh7
	A3jalYWk=; b=FY3P8ozpCFIiSXEQieJ1ShViWXTayz6Rg5ZU7LVFX3E4b4m7h1o
	G2z0e2vse/Urtm1JzZfMlHRzAPzAv57NOwFzfSZ/mWnEZVKsN9/+TYzsgsXFWlfG
	DgrGB+B9bR4uvzhvgyAf6RNx5whzZYIhsk8M1Bu0C9GWojRzAtRDDa8XWxjuwySL
	jEF2aEZBsI304RoLjwjlB9OruqqVkDWuAq6TJGPqagqzUlWlwsskjT9qQ97z8hvi
	WY/gTrWJhZ/u1Ot4UVuIKECGZHJ3Y1y7703dZGxMS4dMm3ef5/5tZQvB0i8ldef4
	bhQe/ikBH34KR9aJM4HcCFp32Neh0iXrTtQ==
X-ME-Sender: <xms:fqw4ab800Gqm8waFi2OyA2IGx8j6sChdQquxZgMvhFezvL_icyU3HA>
    <xme:fqw4afIG8H3u0naaa1Y3LaXuesXwXbonkSs38qJym0nv8HTnIqMyz__6Kpe9BV6Jr
    9h-vQJddmf8SA-HEFlqeeVoTcdkc6ouiJW26wG-vE-JdV_tM47sMw>
X-ME-Received: <xmr:fqw4aWZpBr2-GzjaU-t1IFJhX1XiVH89FrstqpAnnS52glwmVjzZfFREE-8leytFpC4W_KQOVzzZ_v7u8ALvLFK6q2vigW0iAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpefhkedtuddujeetteevheffvdfgjeehheffgfekgfejueekleeftefhjeettedu
    feenucffohhmrghinhepnhhothgvrdhknhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fqw4aRIIP8Uf8OEoxaivvWhSLEbBZre4uFFdO3FqUVKgnFUsA35w2w>
    <xmx:fqw4aUAXEBT1BZM9nqVePgnxuhnhgyvp-Dgi7xcws_ZlWzUKn8sYNg>
    <xmx:fqw4aWrnTvlJOhaCO6yRb_WrrsAIUZukzGjjxFfvHsr8EEn9RRcGkA>
    <xmx:fqw4afjNDLrQjSrneq4-Ba2gDQYj3gQWSS7Xh76WzLtf41J9aqTevw>
    <xmx:fqw4aXBZMJkxJCfVjYPFjHdJRZ6hFL1OnkhIO9lApP8QtDd33axp-oSC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 18:10:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2025, #02)
In-Reply-To: <CAOLa=ZTeEEntiQdCnDd6B8a_ppJrrZqdURhQJV=bNktnp0JqMw@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 9 Dec 2025 23:46:28 +0100")
References: <xmqqfr9jjrci.fsf@gitster.g>
	<CAOLa=ZTeEEntiQdCnDd6B8a_ppJrrZqdURhQJV=bNktnp0JqMw@mail.gmail.com>
Date: Wed, 10 Dec 2025 08:10:52 +0900
Message-ID: <xmqqjyyvi743.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> * kn/ref-location (2025-12-01) 2 commits
>>  - refs: add GIT_REF_URI to specify reference backend and directory
>>  - refs: support obtaining ref_store for given dir
>>
>>  A mechanism to specify what reference backend to use and store
>>  references in which directory is introduced, which would likely to
>>  be useful during ref migration.
>>
>>  Comments?
>>  source: <20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com>
>
> I'm currently on leave. While I do plan to work on this, my next version
> which is based on Patricks recent review will be a bit delayed.

Understood.  Thanks for a note.

>> * kn/fix-fetch-backfill-tag-with-batched-ref-updates (2025-11-21) 3 commits
>>  - fetch: fix failed batched updates skipping operations
>>  - fetch: fix non-conflicting tags not being committed
>>  - fetch: extract out reference committing logic
>>
>>  "git fetch" that involves fetching tags, when a tag being fetched
>>  needs to overwrite existing one, failed to fetch other tags, which
>>  has been corrected.
>>
>>  Expecting a (hopefully small and final) reroll.
>>  cf. <CAOLa=ZQ-O7V9qHbgeuQ78R1bHGDmGEM6fP5Kr9aC0AfvSF8MZA@mail.gmail.com>
>>  source: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
>
> The only change needed from the last review was a typo. I think we should be
> good as is.

Meaning that we prefer to leave the typo in, or just we won't die
with a known typo?
