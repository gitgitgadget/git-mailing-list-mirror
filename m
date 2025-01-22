Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DAD215173
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737568588; cv=none; b=r+D+oxPkSOWgFtai0rnPxdPD0/GEiOKbsFKJwoz4Mh8S8bCkZNM63MXeKECKA4Ux2caQlwuVx3t0djukWqjgoOA9+UfeAUlEKhYjqyNhvxmwd25WC+gulYG8ePBAwgFBwn9OD5Wu/SoCTZxquOB9VNnNFIK57bEE2tjMKCmrQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737568588; c=relaxed/simple;
	bh=aMO+kWU5TRTFs2b0La5jIremVZeK6zWJUaqQphTB3bo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fe6wYpF/vtsutTuR15rTYwTbZslnRLLv+Lxfw5bbmnpAHlWXoKeK6tccx8kUY3G09SiWbklb5xJKG/FaM3JL0edXfQcEw6xV1VLl2e6PRTgjnW2KKznrrkiYTpvXj8sTmV1zdlg71R41nFlxITbstpus5TPzOLCDa65kJ3JAn6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v6xjHTFU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=geQ8W5MN; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v6xjHTFU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="geQ8W5MN"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A080725401A0;
	Wed, 22 Jan 2025 12:56:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 22 Jan 2025 12:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737568585; x=1737654985; bh=xentsfYRCi
	fsteqjx7f6YIR2lV4HulpuQHxAPDi5064=; b=v6xjHTFUGlNWEeaJcCeGa/ACV3
	2zEFrUIPPuYJU4TC+d6ZF+mzb41/xUkRdPspXfamAuJVukYLHEpCnlbv7yyzDPOB
	Ge90z9ckbjTSnQVHAw1dXWR1IT9k0upJYPhIitFLO7EGptNlfkcCryl3ilUzPo+T
	NuzcvIL3EU8hjCk7y/dayuB7b+Kht7RShImMWn4fPl6AK1iuoPaQ5mq+NJ0rhtfi
	mhS9t4bGkZwHIeRd/6WGJtQ9N+CpHrLvZk6fgTk1F9d6bR8UgKoaG9VP8Y64uE19
	nMjTxx19ZMzZ6QKgsGy5yrUr3v+LolBjZlYNUMZf646Woh/FigN5YeLhGJSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737568585; x=1737654985; bh=xentsfYRCifsteqjx7f6YIR2lV4HulpuQHx
	APDi5064=; b=geQ8W5MNHIdG+IgrDSM3EOrdP7UcpKwy5yXJY1QicMVyKxrVv8T
	fieP6ZfTsSu9zHzYqs33nnWy/WgWcmjUIXZbQ5ptCeZyoVokoq7H6X4M5BrEoW+Y
	d8/8h5kBTN1aNLqPLY+sfCi2HrOnXjZN1Aj2WXmuTOVtPBM2lbW7lTsyv9F8RAns
	lDWBV6EAmHjYyj64bV9e28J40/GQGR3q7vZvorvP+Supu3dVI5fMtUGNIa8xdiVz
	RV0xuEK7n26Ph5eO7Ue/VOAS1nUcJeXDUgp5btbc/ImdIpL0j/M/wZjipfOorhEP
	kNyUZO4YO6py1AqK8TtV5zDZ11YAMvLDyRg==
X-ME-Sender: <xms:SDGRZyl86tcz9-kjtiVgKXwkdnWus3UyAyn-sXHZSOLZrJyxZ-Juzg>
    <xme:SDGRZ53PJeZZLGctWDLhlfqvLx3AOcP3yh0R-0nxEwu2cKAnNU8fO6ssjP5H2ZVAT
    O4r3g9IpfLUY1rkfg>
X-ME-Received: <xmr:SDGRZwrMvHiGaqzH7WyaJQS7OzozxaYsYAhSoOKa4_Y9Ql9vwF60X_IwbQCWRF1vwUBsnMnGh6YDk_HccqEbgD8HHItZmhhj4R3K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehnihhkrgesthhhvghlrgihiigvlhhlshdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SDGRZ2lIzxF5JL5jsGmPIoxOiXo6cT8qSF_7s_eZYwc_lIegyI1KPA>
    <xmx:SDGRZw3vX9sAmZ4-rce3QDtvxPOjMbz-jJPCXWHwFBSriN68WTQwBQ>
    <xmx:SDGRZ9sSgb-dHllEtBUp_0EQIqFSoNi8yxbTu1Y7wm7l1cYdmfOAVw>
    <xmx:SDGRZ8VaZz_kyF0bJ9sWWYSO5v8o7GXQSapNy5vPW9RkGI4ujDO8NA>
    <xmx:STGRZ6o9g_W9tVyTMN_JqIRE9IvXUnp_IlPGZzWUVed63tLKwwImxuL4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 12:56:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  peff@peff.net,
  git@vger.kernel.org,  nika@thelayzells.com
Subject: Re: [PATCH] refs: fix creation of corrupted reflogs for symrefs
In-Reply-To: <Z5De17-Ed3K31kzh@pks.im> (Patrick Steinhardt's message of "Wed,
	22 Jan 2025 13:04:39 +0100")
References: <20250121215235.GA2753621@coredump.intra.peff.net>
	<20250122100319.2280647-1-karthik.188@gmail.com>
	<Z5De17-Ed3K31kzh@pks.im>
Date: Wed, 22 Jan 2025 09:56:23 -0800
Message-ID: <xmqqsepawx4o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> This caused a bug in Git 2.48 where target references of symrefs being
>> updated would create a corrupted reflog entry for the symref since the
>> old_oid is not populated. Undo the skip in logic to fix this issue and
>> also add a test to ensure that such an issue doesn't arise in the
>> future.
>
> It's a bit curious that you describe the fix here, then in the next
> paragraph describe why we have skipped the logic only to reiterate the
> fix.
>
>> The early exit was added as a performance optimization for reflog-only
>> updates, but this accidentally broke symref reflog handling. Remove the
>> optimization since it wasn't essential to the original changes.

Yeah, that indeed is a "bit" curious.  I'd call it confusing, though
;-).

> Okay, makes sense. The error is specific to the "files" backend, which
> might be worth mentioning in the commit message.

Indeed.

>>  test_description='Test git update-ref and basic ref logging'
>> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>  
>>  . ./test-lib.sh
>>  
>
> We could use `git symbolic-ref HEAD` to resolve the branch name instead
> of overriding the branch name here.

I agree.  That sounds like a more sensible way to go.

Thanks.
