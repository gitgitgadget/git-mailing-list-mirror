Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2B1A6828
	for <git@vger.kernel.org>; Wed, 20 May 2026 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247919; cv=none; b=HFZDP5IEzv6sPBilthIhyaZAYYm59xSqgvVMLS4Mdk4OPcxFL/qlCQoMoWvmk22TaxohmQYrmcqARkVAHMv02jBnwl2cb3uvUu0fSGdjIx9/mhmBBRKLqgFjh0mRzv1gITNjJ9FENcHka8hirSjfCnyciAh/ZPcS2WdVMLmGfIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247919; c=relaxed/simple;
	bh=hqp4zmaYFHW6Z/oE+88zUuE7aLF0nUsa63yQWqoq9cM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uXEqm9VZWSlrJ1EUMyMNoSMeYT6tqJWFOfRoib8VoJ1OrClWgLkp3YXVlAcyny58ohXRSRz41dzGI1v6ew1pKJpc1M2y8vjFFEOx6okR4ohws9hVW43/JvTWEAZ/qoJu1eAIPgE6zVQODdKjEkvqNf9j3x3ryUxRvZ6ZFDuKeAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vtM7s60k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=io2rxKQn; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vtM7s60k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="io2rxKQn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C276B1D000BD;
	Tue, 19 May 2026 23:31:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 19 May 2026 23:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779247917; x=1779334317; bh=VdeEhjSVWJ
	Ku1Q+t1cipHVbM8C8sYB3aytPQwmh5AKE=; b=vtM7s60kOuo6W7hCTd0IYpQkBq
	o6wJ0sOQADhz5Be2haOpfFDRX5sRr0pm7vnckImvMIlAqM+0m8Z3XCXZoIGjzfm+
	0YtGVno7eh6usQlU5NUqCgdCOxpsodjFXD9l5Bfsn+3842N6xYBHRY+Gev8cKzed
	OL3RBd7WukzFsztgTwvKKwvEb9KD8n6GWvUOdhgzTlMCqjLfaXtQMY5PeWTwNDW2
	80iPRay4byDmEq/XWLC1WdagozGOK7QRIhd6anFEa83aAswiTPt2QKc6iIElyr+w
	AXmVPBMB2P7qwpaFk31NXcoqh1F7SSfnu18JTLCTJ3MKbnTcSsH82UFWM0Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779247917; x=1779334317; bh=VdeEhjSVWJKu1Q+t1cipHVbM8C8sYB3aytP
	Qwmh5AKE=; b=io2rxKQnucvnXL5gaKZKA74x7RudP0WPZkIPc/oclu6bRLrGf5Z
	u4f7KyW3j1eMRnjJvWwKZ3oiBhEkrcJi4r6Rawa3b4V66D5fxqgQlF3mRjKqaije
	Ix6ohxlfqOBc+MXe5mv2ovgDVnGKFmg34+jHWQ6TYlWB+Oym0sZ1pS+GXwZgg4UU
	HGJgSsSJx45R56JBVTX0aovQrebD6nUl95DQnyvwVQFXN98BmbPD+I/SoBUpt95r
	i4vLYSlko9U5iV4rer6jUCv2GBgmftr5InRxhDnCGJy84COmj1m5vK0sJxUFyg9E
	OE5p8duEIg28tC0rEBxxKRG7FGmISLbU7zQ==
X-ME-Sender: <xms:LSsNaiax13e46WK_FbC4rxurpWI-lFh9_AupstqUGkXNXmUqmlOYdQ>
    <xme:LSsNapHSdwqFbok84MgRWimveSqFWHJ9pQzc-4ww77ia7ygXiIsV7eUvchWVktWID
    9bF3fKqTKlcJpk8OhdDIdjFRJnSVlTtCtT_pCWSJ8Cb6cXJDJXgiA>
X-ME-Received: <xmr:LSsNamxIokAW3h3q2TMool2E5M3wabgkY3YvWFYHeFed7lPVnSMg185co35gXwjJcMO8hJK4yeXqF5KWvu0PDkwy9L8YT_UvlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdevleejtdduueeljeeugfeitefhteeltdefgeelheelleelhefgfeetkeeu
    ueejnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrthesmhgrlhhonhdr
    uggvvhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LSsNarlNp6EFHzWnAbzFa6zFuw3W25gBgc4d0y61JQ7dX0mH5LmoPw>
    <xmx:LSsNavkcEp-FlZhwtpKIg7Ztn05viHZy_LofJTv22Xdyqw-_BE2ZMg>
    <xmx:LSsNatwqejPgw938ML0XmbhJbtnUfb2F1NYlzcj4Ze3-n6wzXhgKvA>
    <xmx:LSsNakpeXgb8DO4VYjjET8B1tmScKxDSSAaPY0V97SCtBFSKRqqWSg>
    <xmx:LSsNaimrlOssSjWvbC18aIyim4Slaqk3o4WgEKFAg32J5JXY1ObZn5BN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 23:31:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Elijah
 Newren <newren@gmail.com>,  Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH v3 00/18] setup: drop uses of `the_repository`
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
	(Patrick Steinhardt's message of "Tue, 19 May 2026 11:52:04 +0200")
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
	<20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
Date: Wed, 20 May 2026 12:31:55 +0900
Message-ID: <xmqqse7m4uz8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v3:
>   - Reverse the order of the commits that refactor `is_inside_gitdir()`
>     and `is_inside_work_tree()` and clarify the logic around why we do
>     (or do not) have to use realpath(3p). The code is ultimately not
>     changed though, we still resolve the realpath for both even though
>     it's not strictly necessary to do so for the working tree.
>   - Link to v2: https://patch.msgid.link/20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im

Looking good.  Let me mark the topic for 'next'.

Thanks.
