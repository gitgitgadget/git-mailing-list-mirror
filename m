Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0DE82495
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037622; cv=none; b=cvx0awunpxdLIWbSMhta8N0aXMNKJg67FsWC4zXrqEDKT1pvqNCd9zDQdvQBo8Vyfe7GgYZrO0Z/JoVBPktorAsUHSSsR4LGg2Gclfn78e56zTxxNG6aPBNtq+brU5D53ScUqLXDMidIQEqWrAdhYZm3+V67Wkn1G8/+jNCwK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037622; c=relaxed/simple;
	bh=FlgsJuK7OE2YxBArBgyAv2ws8hfRwyLi3pHvki7RofI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lCBEZBFefuZTYy7jcuzs09MmPUJWkcv418ERBYufMPuMYzVK3mowiQtNAIrH6L6giM9Xg8Yeh5lze9zCcpJEUrXoPkp7/ozymOQN3H2jYGURptBprqEypZ9c88HCT0dGjgV71NEr0x2AuvVtmzEYNLxtY08LHMATaxTT2lzY6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G+Covewf; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G+Covewf"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E5CAD1E3E4;
	Mon, 10 Jun 2024 12:40:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FlgsJuK7OE2YxBArBgyAv2ws8hfRwyLi3pHvki
	7RofI=; b=G+Covewfp88DgUAizzVt+ekumHO2bCZHKW2TQIcU/iOgCVaLy18w3B
	RHWeLimkO0VwtyrJ7/E69ye/qG27VxxRPGRDAeMnDyzxDxB/ToGfOtRCLoq1O22O
	8Z3hnaB0yILYJl7p3waIhi6iOJCA/BKv9qbvx9+lFHBtUEj4sL81E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DC76E1E3E3;
	Mon, 10 Jun 2024 12:40:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 99A7E1E3E1;
	Mon, 10 Jun 2024 12:40:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t/: migrate helper/test-oidtree.c to
 unit-tests/t-oidtree.c
In-Reply-To: <20240608165731.29467-1-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Sat, 8 Jun 2024 22:27:09 +0530")
References: <20240605134400.37309-1-shyamthakkar001@gmail.com>
	<20240608165731.29467-1-shyamthakkar001@gmail.com>
Date: Mon, 10 Jun 2024 09:40:16 -0700
Message-ID: <xmqqed944uq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E9C4E14-2748-11EF-BD3F-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> helper/test-oidtree.c along with t0069-oidtree.sh test the oidtree.h
> library, which is a wrapper around crit-bit tree. Migrate them to
> the unit testing framework for better debugging and runtime
> performance. Along with the migration, add an extra check for
> oidtree_each() test, which showcases how multiple expected matches can
> be given to check_each() helper.
> ...

Use "LAST_ARG_MUST_BE_NULL" here, probably.
> +static void check_each(struct oidtree *ot, char *query, ...)
> +{
> +	struct object_id oid;
> +	struct expected_hex_iter hex_iter = { .expected_hexes = STRVEC_INIT,
> ...
> +static void t_each(struct oidtree *ot)
> +{
> +	FILL_TREE(ot, "f", "9", "8", "123", "321", "320", "a", "b", "c", "d", "e");
> +	check_each(ot, "12300", "123", NULL);
> +	check_each(ot, "3211", NULL); /* should not reach callback */

This one truly checks that the callback is never called with this
version, which is way better than the previous one (or the
original).

> +	check_each(ot, "3210", "321", NULL);
> +	check_each(ot, "32100", "321", NULL);
> +	check_each(ot, "32", "320", "321", NULL);
> +}
> +
> +int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +{
> +	TEST(setup(t_contains), "oidtree insert and contains works");
> +	TEST(setup(t_each), "oidtree each works");
> +	return test_done();
> +}
