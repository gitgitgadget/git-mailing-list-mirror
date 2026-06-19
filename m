Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391E43B7B8E
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885514; cv=none; b=WMVlQe2yeozBfWLBieM4dHPDIF1vrZcuPeq3UOckdwELHTW7q46U1n7r+I6Ll/NzqmhFPXvPcwyyWz2epm2TDotPEsZvNr3b7Wh4q6CQLILwpp77UvG9txyBD0n35HiAvVL/kyI87Wuv0ZpFolWURYlabw8uUEPJNcPhFeKDxGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885514; c=relaxed/simple;
	bh=M5TWDfb6RMk4KMYbMolXyZka+rO2ySk2mlJ4f6KgT4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dhMnV3uD9qC+gEPjYra7rjPItqxN9DCudyG+hGn7MdGMCxafhUMPJgfK5KadeSubj4Z/5Va9Cv4ZLTEwlYt8uL5rSk8AbGkOgXO50LVbBAboF3ykRMxe1YzfOicThKSoCgfzenviZzZGoyDc4JiWtrm4yspMxjvHn6HfkuHvc/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fKyh3qhx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QBFOtjkR; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fKyh3qhx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QBFOtjkR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 954FB7A0123;
	Fri, 19 Jun 2026 12:11:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 19 Jun 2026 12:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781885512; x=1781971912; bh=mwzGUX6tN9
	9MSnSt+C28U6MWhdqbH6mO/rdcQHWanLc=; b=fKyh3qhxQWQWQ0Iw2M9Kp2oU2Y
	5sgYz5QVhqejYOnRcykNsFULTRinNtcZ97AOayfJfOfBPY6eHVSGhfHYNafK5gB+
	Dd3LE6wem/fUVxd6G9GORpYRvrQTn8vVVBf5AjnKLy9YdgJ1WFg/hYagKm+BnnJL
	eSXawtUrjwUrmJwrffZ47auIhnBwrut3zLn3pAk4GxZd7xwtWFDwrleOXKAAQBDS
	8DCzwlpVqmeN9QGKRMInJcQDlXoBEP9YNczgrWABXoDgBsBqtfsjiSe/SolNaPpJ
	37a8EnOck5J+aTWjGEFuKg7Teo3pQ0hUAaBnOqqdeLUz3luvYEHv9L6zYegA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781885512; x=1781971912; bh=mwzGUX6tN99MSnSt+C28U6MWhdqbH6mO/rd
	cQHWanLc=; b=QBFOtjkRf1+3kjX7xDY6hG0pMit8jU/l/gXbOq8SNGWlLB0klVA
	aCjrNL/WoDCAGJfqLI9Pp8fNjLer9zsD/5BDboKGmKzBB6KPsEeMU6vxOjV3G7ka
	arHvOuhMKRHy3t6hxKa6zb7QxzfNoWU7My4lsnhGd/pVTVfcN8shJIVPX96NJ8J9
	1nLYksxLo6pRDRu48tOFcx29l9UPCoIlwIZsG8OoQAk+Oig0Wl/wd3dy2GfDAyR8
	aPhH+bB9eiooNbqcrcnIKPusHUl2A+0uNtlYRLcC03A9x1zbgLnmg6557klQzASn
	Mb2hsh+86GBoBMKmCdWT3Ok5gD6P6IN6axw==
X-ME-Sender: <xms:R2o1amcY8a9HwsKjAuWzHc67tXjVBFNCjUHcd_FmDbTUXcvx9AO9WA>
    <xme:R2o1anHUtHHykmkXDauzu6mdUZjec6wrScfA21uCmAO3v7KqXvi6ZrFiFPUiMGYwX
    0N7jr_96r9YXi7aogmp4qhAqCBhk-38fuOptL4eibRLwQ7fljxbbfQ>
X-ME-Received: <xmr:R2o1av2MGlpixYa9giPiycZwVy782Rj0QPeZCiePGJ9TJOHt-axG2M9ynJGnjZYvWro6naOTP-Ec_ihQl0Vod4edStytKSs9Xu-r>
X-ME-Proxy-Cause: dmFkZTEAovaZkaMeqHNv4pvnuXDZJAsHBlkDZPgT7Q1mSK5vQVSp//N7HuVJXhCaUvyuo+
    KBaPYiwjBzklpO60Af+WIs6paNetKfdkFZq/jN30CSTHTR6DV8cX0ETvwpH/XXg1arHd/k
    /r3u4Vupk2wTwPbQz4PEXyVw7cW9HxCydr45319ywzatpaXUxyfCwtYJd/FBjvy2Ce+kDP
    r429mUXfXnc1FUbF1TVXPuk75v4+xw3b+4wrLcUgfYoWDZkpjEGQ586x5E4fbm6EmEgp+l
    TysYpego8ALU8+itIb7YCl7gOC/F2TPXdH9+fP/ZJPxdv6M9VVT9IUuPK9NlFkIu6b/xZm
    6Ym8D0hnVWEdguri5t3YZ0zJ1eYbMzw1jY4vfVcgCLEu2v2vd0knjuUSRRU2NwnrmlRKht
    vM30EreJpDlbF1I7BdaO6Lp+CBPVcYVFcBGt3eQg3P15280y4359LityEYi+v+V9OY5Nn3
    1oYy1smZ1+14oatS6VUAbLhuY3tlZPfpCasyIClMNo9anVuKKvPt6JAxGX9GTFNPGqmv2g
    086XIrsTJ4SRm375h+Y9KXH/MrIVZQNfhxOzCJlETs8uGsF2WQF0hnIZyRhKbz+LRUOeEs
    YTofkKAUye3m4DE+CXZR0N2csvSKG6+ISz3r/trSl9aR7WXqTCnArskH+t2Q
X-ME-Proxy: <xmx:R2o1avl_1hxn1U5Z2aETtnxRotzp-Q-t4KtoR1FLp6hPVf6X5JQPXw>
    <xmx:R2o1av_v7xr6GmW2RoZMEV8ElhBapgYr6ulr71WpAf2zrLv8Bx7UIw>
    <xmx:R2o1akqj2G5HsFzqj9Wbbdk-SG1KguA8l0wqfVrlUOz0rT__pZ5i1g>
    <xmx:R2o1aolKY9-3uvvPrOxRwUy7ZkQfSc524wfpAwT1WvrS1ybevqfdCQ>
    <xmx:SGo1am0zfgc8UlPt_-HMuOR9woKshBQwMatb7dTFHanDWryTqbg-TK_s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 12:11:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 0/4] history: add squash subcommand to fold a range
In-Reply-To: <ajU4JYYUTz5r-Xgc@pks.im> (Patrick Steinhardt's message of "Fri,
	19 Jun 2026 14:37:57 +0200")
References: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
	<pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
	<xmqqo6h7nza3.fsf@gitster.g> <ajU4JYYUTz5r-Xgc@pks.im>
Date: Fri, 19 Jun 2026 09:11:49 -0700
Message-ID: <xmqqv7beldbu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> There are two more modes:
>
>   - If a reference points at an intermediate commit then it stays there.
>
>   - We detect this case and reject the update. Optionally, we may ask
>     the user what they intend to do with those other refs.
>
> It really is kind of ambiguous what is supposed to happen, and I can
> think of different scenarios where each of the possibilities would be
> the best choice. So ultimately, I think the last option is the best one,
> as it also gives us a way to iterate.
>
> If so, a user would already be able to achieve that other refs keep
> pointing at X by saying `git history squash --update-refs=head`. The
> other modes can then be added at a later point in time as the need
> arises.

Yeah, sounds like we should detect and fail this case, with advice()
to use --update-refs.

