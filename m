Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550456D1B9
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717778277; cv=none; b=GF9wDFKFyYz8PcJ/BVHARn60qvF+/ZcLk9Dq+QegwQZJ/GEfWRds4Kg9fA+3USODp1bHT+WoOmmdsnNWKp7N8YsayEYtUe6Zk5Go8d+ZhYNdudaxp5kcHalMKEX5Vd9GYlu+aHXuOhqzegDPc7RdMCK4J9RMmimTBBtzyKeo++k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717778277; c=relaxed/simple;
	bh=wmkbui2995K/6lgMlgy8g7NSYHbfO4wHzlq1u2YKDD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O1r+GOI9lipl8CZB3rz67QQ+74C9QW2BuYK+b8Ina9Jl/pvs90BAcELO1a8TMkPDEzDchmSM0LX+FZ5pUqZcz7VYqSvjxq5VPUd8UBnDVNMis5hogF11qSS2xyItI7zLGiwO6zt9ibZEhbRaYVig8ajLf5n0SOkDOGrekXromm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qGcTStbI; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qGcTStbI"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F740376BD;
	Fri,  7 Jun 2024 12:37:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wmkbui2995K/6lgMlgy8g7NSYHbfO4wHzlq1u2
	YKDD4=; b=qGcTStbIYdpk/d3acc57+01Qxn6ECQj0fnDhlJI/TD4vnWRTV6gm+o
	TkHt8Ne5KSXEzveFUkP1LXVvmIAgXI+x91/sfoPSsJQ2xy2h9QTm+0BUXCI3ZV27
	Ko9usiWbV9bn1/uD8hnO2eWlmqmGhgJVIJTW2DC6pv83K5T7+cyWY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3603C376BC;
	Fri,  7 Jun 2024 12:37:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9203F376BB;
	Fri,  7 Jun 2024 12:37:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t/: migrate helper/test-oidtree.c to
 unit-tests/t-oidtree.c
In-Reply-To: <dohbd64jxuahelut63esztozdozqrhx5rgv5m4t3wt5gz6v6kv@6q2aivlcvxcq>
	(Ghanshyam Thakkar's message of "Fri, 7 Jun 2024 05:05:40 +0530")
References: <20240605134400.37309-1-shyamthakkar001@gmail.com>
	<xmqqo78dka99.fsf@gitster.g>
	<dohbd64jxuahelut63esztozdozqrhx5rgv5m4t3wt5gz6v6kv@6q2aivlcvxcq>
Date: Fri, 07 Jun 2024 09:37:53 -0700
Message-ID: <xmqq4ja4g13y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4A1E974E-24EC-11EF-9786-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

>> Come to think of it, how is your check_each_cb() ensuring that it is
>> only called once with "123" when queried with "12300"?  If the
>> callback is made with "123" 100 times with the single query with
>> "12300", would it even notice?  I would imagine that the original
>> would (simply because it dumps each and every callback to a file to
>> be compared with the golden copy).
>
> That's true! I did not think of that. What do you think about something
> like this then? I will clean it up to send in v2.

I do not see a strong reason to have a pointer to int in cb_data, as
the caller has access to cb_data after the callback finishes using
it so check_each() can check cb_data.i instead of *cb_data.i (or i)
at the end.

But other than that, yes, it is the direction you would want to go,
I would think.

>
> ---
>
> struct cb_data {
> 	int *i;
> 	struct strvec *expected_hexes;
> };
>
> static enum cb_next check_each_cb(const struct object_id *oid, void *data)
> {
> 	struct cb_data *cb_data = data;
> 	struct object_id expected;
>
> 	if(!check_int(*cb_data->i, <, cb_data->hexes->nr)) {
> 		test_msg("error: extraneous callback. found oid: %s", oid_to_hex(oid));
> 		return CB_BREAK;
> 	}
>
> 	if (!check_int(get_oid_arbitrary_hex(cb_data->expected_hexes->v[*cb_data->i], &expected), ==, 0))
> 		return CB_BREAK;
> 	if (!check(oideq(oid, &expected)))
> 		test_msg("expected: %s\n       got: %s",
> 			 hash_to_hex(expected.hash), hash_to_hex(oid->hash));
>
> 	*cb_data->i += 1;
> 	return CB_CONTINUE;
> }
>
> static void check_each(struct oidtree *ot, char *query, ...)
> {
> 	struct object_id oid;
> 	struct strvec hexes = STRVEC_INIT;
> 	struct cb_data cb_data;
> 	const char *arg;
> 	int i = 0;
>
> 	va_list expected;
> 	va_start(expected, query);
>
> 	while ((arg = va_arg(expected, const char *)))
> 		strvec_push(&hexes, arg);
>
> 	cb_data.i = &i;
> 	cb_data.expected_hexes = &hexes;
>
> 	if (!check_int(get_oid_arbitrary_hex(query, &oid), ==, 0))
> 		return;
> 	oidtree_each(ot, &oid, strlen(query), check_each_cb, &cb_data);
>
> 	if (!check_int(*cb_data.i, ==, cb_data.expected_hexes->nr))
> 		test_msg("error: could not find some oids");
> }
> ---
>
> Thanks for the review.
