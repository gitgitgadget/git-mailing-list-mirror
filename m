Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A52BB05
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868781; cv=none; b=HOmQIWljicahGNsVAxCrJJdhU8VINA0coDv+OsNfMw+gkVZrQZ4Xth6n9/ZqhfQMHFKXVFF+ZCoP0DrqU+2PgN5SFDKPu6nKqD1oCXbJhdTgaa06b/4IwmD049zUet3UQer+O6OXG1xkPMhZzFSS4aBsACmC36+o7v0KTrl6Mh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868781; c=relaxed/simple;
	bh=36v8NRJ6iOaBQLoWYa0yMq+unqgIyNdBpsgwr5YsdzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FPkzQqlguPIntoxHzbdxk+IwhG0IN+qawbt7+sT/hnFBakAxXS6MzpyMtiJqR3K7WVj/wqpXsRKYVhd3S8JsHBP1+4iJPQUI7lXzFqUb+w0dVdDM9g8fLiKxqSlW0myduQWnwoSuUpzRheOXKgO6Akfj9SE5d9XK7r2mPn4/iX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JhsBp4Ce; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JhsBp4Ce"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A9EF2B1F4;
	Mon,  1 Jul 2024 17:19:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=36v8NRJ6iOaBQLoWYa0yMq+unqgIyNdBpsgwr5
	YsdzM=; b=JhsBp4CerDwkFptQ8ASow5CzgkmuccbJd2cvm0r1Gzp1gl9w4waLT6
	Bkzyerivohx1e8XNl5BrOfQzx3EW+C0DyCJwY8g2ugRuE9yS2Hve+dCPgd6s+00c
	bQDCQwsUI6mvTjFYmuNn83aFxat1oe7VcvU36ND7cMduF0X+Esb3Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 322F42B1F3;
	Mon,  1 Jul 2024 17:19:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA6382B1F2;
	Mon,  1 Jul 2024 17:19:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  git@vger.kernel.org,
  Jonathan Nieder <jrnieder@gmail.com>,  christian.couder@gmail.com,
  Phillip Wood <phillip.wood123@gmail.com>,  Christian Couder
 <chriscool@tuxfamily.org>,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
In-Reply-To: <hxld3ldxomitv6hjuxq7munhppzie2nm3eworng6jnhf3suikx@rh6cunbz4vcz>
	(Josh Steadmon's message of "Mon, 1 Jul 2024 13:32:30 -0700")
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
	<20240628122030.41554-1-shyamthakkar001@gmail.com>
	<hxld3ldxomitv6hjuxq7munhppzie2nm3eworng6jnhf3suikx@rh6cunbz4vcz>
Date: Mon, 01 Jul 2024 14:19:33 -0700
Message-ID: <xmqqzfr0u7x6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9DDFC180-37EF-11EF-9B48-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Josh Steadmon <steadmon@google.com> writes:

>> This version addresses Phillip's review about detecting duplicates in
>> oidmap when iterating over it and removing put_and_check_null() to move
>> the relevant code to setup() instead. And contains some grammer fixes
>> in the comment.
>
> IIUC this corrects all of the issues that Phillip noted in his earlier
> review, except for checking for duplicates, is that right?

There is an attempted duplicate checking during iteration; the test
data source key_val[] array is (ab)used to record the already seen
keys during the iteration, which would work but is a hacky and
unmaintainable way to do so.

Thanks for reviewing.
