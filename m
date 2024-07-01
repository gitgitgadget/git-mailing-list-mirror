Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C63381C4
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868485; cv=none; b=B51cazO5CyhpoAaQR+S7CkROAZHGyKeHrtdFv20KgV0uh2k+ysY4l8vlc6CaoA7yF7+i9FE1r+WW5UbWh6O5sKvakdD1eAPGetfiseXW+ed0NX1KHAjJr0wnuH7MARqzJVcNhbDmnIjnEAqdyTiDx3K/ANJetZ6gfL++NPHMvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868485; c=relaxed/simple;
	bh=b8NEr0oHqvO7+T1Fmv/8DW01fxksFLE9wAmk9Pc9goI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TxNWvZAygw8re9jHJlwmHbww6upRDOL8mlN3BYUlX2aE03Yk8k9/Mnu7zMeBR2ozkjhdifAJIpsGFfcjFZ469qJrx0KuZ84nMbdyUV+aQztrZO/c00RW4FuZ8imGi4Oy3rVrOkRbTe/vYnmvn9IeeuBTg5PrJTvIywdI2vwFhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FVd+PGmy; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FVd+PGmy"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B10E22BEBF;
	Mon,  1 Jul 2024 17:14:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=b8NEr0oHqvO7+T1Fmv/8DW01fxksFLE9wAmk9P
	c9goI=; b=FVd+PGmy+q5vNJphrWwqEN1Qls0jix8TyBcAfjry2uGQnG4cuyBJ/5
	j2GnV2jXJ79qwdTtAYZXgIiIvZCssffCozs4x2pm6Qoh+yDRtrdQWMJp8XJJ7tb9
	YHz8Tm3aoyonBNe1DfGdENAEvCFzYLqz7b82DOesHIFGirgmnghJI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A73C92BEBE;
	Mon,  1 Jul 2024 17:14:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BF7B2BEBB;
	Mon,  1 Jul 2024 17:14:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  Jonathan Nieder <jrnieder@gmail.com>,  Josh
 Steadmon <steadmon@google.com>,  christian.couder@gmail.com,  Phillip Wood
 <phillip.wood123@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>,
  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
In-Reply-To: <20240628122030.41554-1-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Fri, 28 Jun 2024 17:50:21 +0530")
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
	<20240628122030.41554-1-shyamthakkar001@gmail.com>
Date: Mon, 01 Jul 2024 14:14:35 -0700
Message-ID: <xmqq4j98vmpw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EBDD5C4A-37EE-11EF-9E60-965B910A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> helper/test-oidmap.c along with t0016-oidmap.sh test the oidmap.h
> library which is built on top of hashmap.h.
>
> Migrate them to the unit testing framework for better performance,
> concise code and better debugging. Along with the migration also plug
> memory leaks and make the test logic independent for all the tests.
> The migration removes 'put' tests from t0016, because it is used as
> setup to all the other tests, so testing it separately does not yield
> any benefit.
>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
> This version addresses Phillip's review about detecting duplicates in
> oidmap when iterating over it ...

Hmph.  You seem to overwrite key_val[i][1] ...

> +/*
> + * Elements we will put in oidmap structs are made of a key: the entry.oid
> + * field, which is of type struct object_id, and a value: the name field (could
> + * be a refname for example).
> + */
> +struct test_entry {
> +	struct oidmap_entry entry;
> +	char name[FLEX_ARRAY];
> +};
> +
> +static const char *key_val[][2] = { { "11", "one" },
> +				    { "22", "two" },
> +				    { "33", "three" } };

... in this test, rendering the key_val[] array unusuable for
further tests.  Is that intended and desirable?

As long as t_iterate() stays to be the last test, that would be OK,
but once somebody wants to add a new test after it, i.e.

	TEST(setup(t_iterate), "iterate works");
+	TEST(setup(t_frotz), "frotz works");
	return test_done();

the setup() for that new test depends on the key_val[] array, whose
value fields key_val[i][1] have been modified.

The TEST(setup(t_foo)) pattern is done so nicely to make sure that
everybody is independent from everybody else, preparing the oidmap
used for each specific test from scratch.  It is a bit disappointing
that we are now invalidating this nice property.

> +static int key_val_contains(struct test_entry *entry)
> +{
> +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
> +		struct object_id oid;
> +
> +		if (get_oid_arbitrary_hex(key_val[i][0], &oid))
> +			return -1;
> +
> +		if (oideq(&entry->entry.oid, &oid)) {
> +			if (!strcmp(key_val[i][1], "USED"))
> +				return 2;
> +			key_val[i][1] = "USED";
> +			return 0;
> +		}
> +	}
> +	return 1;
> +}

Otherwise, the other tests looked reasonable.  Looking really nice.

As I expect things to be slow this week, being a big vacation week
in the US, we may not see much review activities this week.  I'll
queue this version in the meantime, not merging it down to 'next',
in case people start comment on it next week.

Thanks.

> +int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +{
> +	TEST(setup(t_replace), "replace works");
> +	TEST(setup(t_get), "get works");
> +	TEST(setup(t_remove), "remove works");
> +	TEST(setup(t_iterate), "iterate works");
> +	return test_done();
> +}
