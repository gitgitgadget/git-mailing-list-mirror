Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A74E1D6
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716945; cv=none; b=alTrAeNYvXMOYHy+NkklFgc6OoDP0oTZaMxCp3l7F4gkHmVyxIxicgR/d1eCi02stbQYMiw8j4d22KMv74CQDarxyte7KzuViD+CU4B/orpmHD1RMUtO2fptszX88fujfM/E+qcrxIMYoiH/7clvNo+HVDpPMaFHEvJPikWWugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716945; c=relaxed/simple;
	bh=yDISv2ZXP6y86P+xoj5Z0JmbVd+YpQ1yCKnZasLfPNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfaQoC7TVT8TgXxhA7Z2eQjlN2ykx0px74zMjbFMyQK2ZgiRYPAC6oRl5vSWVghvZ4P84XTp5+qnTa2HODiHUGubZNywRak7n0Em9d0L7jsav+whid3FdJhd2kfuI/QMDGPTAI2XKTPs0BTxPg0ifD5ZL3txbRs8jb0zzW4H9lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yx2EUtEA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx2EUtEA"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6c5a6151ff8so1250178a12.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717716944; x=1718321744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ao4LzkO74PN5hZFDIZ/h2chtMaQCzz5jqYjohOhyhA=;
        b=Yx2EUtEA0h9NaxhWHeOBqPVV0gV+ZwPkWhwRUrqFa4inecTslp6SDZlYY9sdOFcnqo
         xJwhvCe8KNziqqWHqatiPO6tpavv4kdOAG+0Hr+GzYsFhuE9yIQIivCjiFWZFUHkYPe/
         CND+XmSg9hrV0Z81drrGp+lvQQ5oNbjsIvxg2KTwo3oIHspTWAlbH95EehMJq16YDEE9
         K+xAbbo9uQrU3BQSr8CI+rHHGqlAtRfytFiD+3t6B7La9LENZOiuqTsheXFLmH9mfAax
         ETGqOAAKSKtuUdQbc1nU+RGsxMVQQxYg4bf9DIFRx3y2r8qvV70RIAtPnu8DgXZYmZVV
         XVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717716944; x=1718321744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ao4LzkO74PN5hZFDIZ/h2chtMaQCzz5jqYjohOhyhA=;
        b=Fcm+FXl3m/uJ/Do2hVNp3UeADdw3xhxyFnC6qUvwPo7salDfwsH062eAy1FeeBKRqE
         Ch37HqIM3cLbsgrxN/y3BpfADHcE/5CiKT+K8tUhus+EBEPoHiJ0Yu4m+gVdiHdmjvZa
         6vJj5c3wqaJhmnAphBxDbitND8naQXRQ4XFT6Yz4iP69PhpKPrcGNtcc/uvjZEOAyxvV
         WEATSVRAcxmXWuHVDiyCKa79o3/MuIsIAbnnHIvbjykWc3+GMDf7GdRcT/RzZEr+nyaL
         O+dP1CZHgSOgoGUziT8V8n3GJQFeYzAkx2UYOM4hBZn1oB4zeB4Qe0isVzNeViUW0DOh
         hfOg==
X-Gm-Message-State: AOJu0YzhmIFQtJ5rapfozWz2koqFUGPaabJsxaZeDoktxr3TXaXxtJoP
	vfHTbnyglwksxLE6bhA8Jm2dFvVz7cs/aJyPstaAfKLnMiDgyce/AbhVJmkDqRI=
X-Google-Smtp-Source: AGHT+IF1aAE9r2dlN2A9llx5NUSuoaGeTAeBHu8ifeFpBLdd7fK+hveOmbMJyDKSw+lo7kT50zENSQ==
X-Received: by 2002:a17:903:1cb:b0:1f6:502d:ca8a with SMTP id d9443c01a7336-1f6d03b7e39mr9906715ad.57.1717716943671;
        Thu, 06 Jun 2024 16:35:43 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76cf1dsm21153485ad.82.2024.06.06.16.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:35:43 -0700 (PDT)
Date: Fri, 7 Jun 2024 05:05:40 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t/: migrate helper/test-oidtree.c to
 unit-tests/t-oidtree.c
Message-ID: <dohbd64jxuahelut63esztozdozqrhx5rgv5m4t3wt5gz6v6kv@6q2aivlcvxcq>
References: <20240605134400.37309-1-shyamthakkar001@gmail.com>
 <xmqqo78dka99.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo78dka99.fsf@gitster.g>

On Thu, 06 Jun 2024, Junio C Hamano <gitster@pobox.com> wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> > +static void check_each(struct oidtree *ot, char *hex, char *expected)
> > +{
> > +	struct object_id oid;
> > +
> > +	if (!check_int(get_oid_arbitrary_hex(hex, &oid), ==, 0))
> > +		return;
> > +	oidtree_each(ot, &oid, 40, check_each_cb, expected);

I think I mistakenly kept '40' from when I was testing, but it should
be strlen(hex). Will correct.

> > +static void t_each(struct oidtree *ot)
> > +{
> > +	FILL_TREE(ot, "f", "9", "8", "123", "321", "a", "b", "c", "d", "e");
> > +	check_each(ot, "12300", "123");
> > +	check_each(ot, "3211", ""); /* should not reach callback */
> > +	check_each(ot, "3210", "321");
> > +	check_each(ot, "32100", "321");
> > +}
> 
> Testing "each" with test data that yields only at most one response
> smells iffy.  It is a problem in the original test, and not a
> problem with the conversion, ...
> 
> BUT
> 
> ... in the original, it is easy to do something like the attached to
> demonstrate that "each" can yield all oid that the shares the query
> prefix.  But the rewritten unit test bakes the assumption that we
> will only try a query that yields at most one response into the test
> helper functions.  Shouldn't we do a bit better, perhaps allowing the
> check_each() helper to take variable number of parameters, e.g.
> 
> 	check_each(ot, "12300", "123", NULL);
> 	check_each(ot, "32", "320", "321", NULL);
> 
> so the latter invocation asks "ot" trie "I have prefix 32, please
> call me back with each element you have that match", and makes sure
> that we get called back with "320" and then "321" and never after.
> 
> Come to think of it, how is your check_each_cb() ensuring that it is
> only called once with "123" when queried with "12300"?  If the
> callback is made with "123" 100 times with the single query with
> "12300", would it even notice?  I would imagine that the original
> would (simply because it dumps each and every callback to a file to
> be compared with the golden copy).

That's true! I did not think of that. What do you think about something
like this then? I will clean it up to send in v2.

---

struct cb_data {
	int *i;
	struct strvec *expected_hexes;
};

static enum cb_next check_each_cb(const struct object_id *oid, void *data)
{
	struct cb_data *cb_data = data;
	struct object_id expected;

	if(!check_int(*cb_data->i, <, cb_data->hexes->nr)) {
		test_msg("error: extraneous callback. found oid: %s", oid_to_hex(oid));
		return CB_BREAK;
	}

	if (!check_int(get_oid_arbitrary_hex(cb_data->expected_hexes->v[*cb_data->i], &expected), ==, 0))
		return CB_BREAK;
	if (!check(oideq(oid, &expected)))
		test_msg("expected: %s\n       got: %s",
			 hash_to_hex(expected.hash), hash_to_hex(oid->hash));

	*cb_data->i += 1;
	return CB_CONTINUE;
}

static void check_each(struct oidtree *ot, char *query, ...)
{
	struct object_id oid;
	struct strvec hexes = STRVEC_INIT;
	struct cb_data cb_data;
	const char *arg;
	int i = 0;

	va_list expected;
	va_start(expected, query);

	while ((arg = va_arg(expected, const char *)))
		strvec_push(&hexes, arg);

	cb_data.i = &i;
	cb_data.expected_hexes = &hexes;

	if (!check_int(get_oid_arbitrary_hex(query, &oid), ==, 0))
		return;
	oidtree_each(ot, &oid, strlen(query), check_each_cb, &cb_data);

	if (!check_int(*cb_data.i, ==, cb_data.expected_hexes->nr))
		test_msg("error: could not find some oids");
}
---

Thanks for the review.
