Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3B21505A
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737568927; cv=none; b=PfDNSsWt0XQnZHcOWy2Yj8uMDiEc13/GVwP9oGJ0oXTRohYvmG3wKsONPL0caNMBbOHfnUqyUYIWQJu5Ccqn7jGU+5Na+bRRbRSDnp04fBxQeHIn1IatDmHbab53RDOFIOKsGTGzz3bXk0fVL92NWQqnqL/F4EZblOau+KnFkjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737568927; c=relaxed/simple;
	bh=DDHZo7nsRk573iHR/2RF61G453Yib5/kjQc0Ch+sJVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ew6IfPXNWe4GZL3cv4IkS/2HSmZnsX7597ml1+A4ce1ncWMrpBWhZDLXNaroBTppetOUn2LIZP5jdSeScNNFqPvc9ofblmG3AbXiHmlb0GV0IxGklzvtwd7a4ZqgoDj0Si0ixPniKAAkYpmF2cU564fHeAWa1NhBy5qH53c1CMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N0rSpTw7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tNUz0W/P; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N0rSpTw7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tNUz0W/P"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C50D2114011F;
	Wed, 22 Jan 2025 13:02:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 22 Jan 2025 13:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737568923; x=1737655323; bh=O9bsMpnx3H
	EJy3jV9TrgWen6STjq+ttyt9PZumRzo/M=; b=N0rSpTw7hFls51waSDjkQ0IHYF
	dhnFINFUfA0AvHXLbpZrd4m3hbnNM9ONrPkFliP6aWC9pLW/2f0bWZ1SB6ne5jOD
	69d1p4Kx+dBBnl2H+Y1NM+A6tjNoFYb/uZdgKJEAmoBE+l7K9lcqCbD+oJocUvLi
	HGyf9q3q6Zb9ibe4un5Nc+iCHi5lFVq5iWrMvGfpVZsXG14ZDtRq4IENnCuX/Kha
	8LZTplWV0hWkXKTjrxjGccY+twcb1KFEvFRq61eG2Bvsd2zH3vLz/3Ds6AkdH0SB
	V48P91k/QOuIGv/8OtPxq0L8HB9s1+qMDZ7SRRNonwrlsJpyXNwJJxuCWvCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737568923; x=1737655323; bh=O9bsMpnx3HEJy3jV9TrgWen6STjq+ttyt9P
	ZumRzo/M=; b=tNUz0W/Pe0ZkJupDk2gkFpYcLzWRd/ttOAcVhFEUa3EUdLC26Y7
	M9+6NA3Iusac6vPbbyruemnISzrkZH9LzXuHBiEdU/LSyiuQdL37cecp3VeOl9vb
	kCP5iUvzZty6Lj8QUYH2ZmjYv9GdENLFK1+fh4cNM65Xb8Ab1zuS5sEo4Hd1QZk1
	7lEmjhGbBtzd64O8kXXa967gZBRuiHMLyoYCKgQES1gtsggMlq14xUzE9b0zyqtM
	XcRD72/sIa+8hVXz7OgjvEZMoUNxDem1hz74bNYEUTSWFTMbOHRiQJeWlR6vf4sX
	P+uVpVqBMOzpqyCTW7I4kX3UkSzCrxViYxQ==
X-ME-Sender: <xms:mzKRZ8FBSyfuSCVidkmABtLFmHkq3r7G9A-v1F9pk64-CB9PPHM1oQ>
    <xme:mzKRZ1WBAJzIcKoTArs9kmHdW25NcgQFFrprSyOkvANJCPYQTOVS5kypvBRSqZ-im
    6MdBgN7Y9v3tXydlw>
X-ME-Received: <xmr:mzKRZ2LHJcitBPnacvRT9THw0YZBCFCTQ27Jyh8l6VT-vO9fO6mxE37EBoUzP7tM6unOwWKsn-KJEVkNYh9CxcFHR8C9qv-aLUFb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvdeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mzKRZ-FcczgwftFz2ZCMAwfFuWXW0vc7QcXmzn440jy-FCP_GEL5jA>
    <xmx:mzKRZyV2QKhHXHoaYnZ2BfxgqdCMekQfUaMtldqXbMZGWpMvzt-PHA>
    <xmx:mzKRZxMomg5hm7nZIaVrf7CsEXjGFtMc56IS372hXYQDpto-PMEegQ>
    <xmx:mzKRZ52zxZXboS5gFpwK_EL3v5F7npDUr41LQgPJBS-IFWOHqtvkIA>
    <xmx:mzKRZ0cIWwyQnzzhCVuJoKHWqP3mizawfzIj7CckaorAMVP8McPvrRDV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 13:02:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] refs: fix migration of reflogs respecting
 "core.logAllRefUpdates"
In-Reply-To: <20250122-b4-pks-reflog-migration-fix-stash-v1-1-27dbae4602f7@pks.im>
	(Patrick Steinhardt's message of "Wed, 22 Jan 2025 10:48:06 +0100")
References: <20250122-b4-pks-reflog-migration-fix-stash-v1-1-27dbae4602f7@pks.im>
Date: Wed, 22 Jan 2025 10:02:01 -0800
Message-ID: <xmqqjzamwwva.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In 246cebe320 (refs: add support for migrating reflogs, 2024-12-16) we
> have added support to git-refs(1) to migrate reflogs between reference
> backends. It was reported [1] though that not we don't migrate reflogs
> for a subset of references, most importantly "refs/stash".
>
> This issue is caused by us still honoring "core.logAllRefUpdates" when
> trying to migrate reflogs: we do queue the updates, but depending on the
> value of that config we may decide to just skip writing the reflog entry
> altogether. And given that:
>
>   - The default for "core.logAllRefUpdates" is to only create reflogs
>     for branches, remotes, note refs and "HEAD"
>
>   - "refs/stash" is neither of these ref types.
>
> We end up skipping the reflog creation for that particular reference.
>
> Fix the bug by setting `REF_FORCE_CREATE_REFLOG`, which instructs the
> ref backends to create the reflog entry regardless of the config or any
> preexisting state.

Thanks for a clear problem analysis description.  The appraoch makes
perfect sense.

Will queue.

> +		test_expect_success "$from_format -> $to_format: stash is retained" '
> +			test_when_finished "rm -rf repo" &&
> +			git init --ref-format=$from_format repo &&
> +			(
> +				cd repo &&
> +				test_commit initial A &&
> +				echo foo >A &&
> +				git stash push &&
> +				echo bar >A &&
> +				git stash push &&
> +				git stash list >expect.reflog &&
> +				test_migration . "$to_format" &&
> +				git stash list >actual.reflog &&
> +				test_cmp expect.reflog actual.reflog
> +			)
> +		'
>  	done
>  done
>  
>
> ---
> base-commit: f93ff170b93a1782659637824b25923245ac9dd1
> change-id: 20250122-b4-pks-reflog-migration-fix-stash-d1fe7380f84a
