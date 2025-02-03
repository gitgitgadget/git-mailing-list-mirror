Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC31863E
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738561235; cv=none; b=T3GOIQQIy1jqJVSDjOzb+8kwtw7g3ZyIzJuJHxkvDxQRpRwSWA+fO3+ZW/CIuLBiZfx8mevhIBb4Vmv5uGE0BSXQ/oHOiZUNtdjuoquNUwYegbmsExnV9/quLGN4p0t73bIpWvyCAAnHu2jWAWF4Wz6VU8tSjrw7TFegMcmJdrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738561235; c=relaxed/simple;
	bh=NDli8d//O1ED5nharBWRyBEb7hTSNVOky7zVFFJW/LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rcbtv/DFIpCJcu2Qq0jL6UBwyXMaxfhPXV2uodFNefhuq4B/LcCixgKwbUUYi23UBZP+OfKSrG+dzqw7h3tHh7OxxEF7W9utfWUXRaaNgS4E8Q1bUICxByT6+fmJnzuWVvGFDUCAqid2b4yCbZTHpEMOdzTUqDkticbW4rV49I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d44tKqBJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HC5eNT3e; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d44tKqBJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HC5eNT3e"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CD57114011D;
	Mon,  3 Feb 2025 00:40:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 03 Feb 2025 00:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738561232; x=1738647632; bh=XQuhntA0Ie
	tA0jta+yrERWAIDp7HotiyWF5SPEQGLkQ=; b=d44tKqBJCegD4+kbhG0iwDGLkJ
	6hJlPp9QGm3MgGxmQNhWx2VEAZKOZfPCHxEnROxoukCdskLIhMJwdK0pkPZMJieC
	ZPPs1XoTszxs7oK+DgyrmRghXI/KeFfFUp5E0Tfa0u+bbSSnDV9kvRH9po+yZLCz
	kmb8544oHlmb9BvFLjUuZ4JYcd4AImxCq4HlbU7ub5Zt3xPqEsfcoPzXov0n0cBF
	+820uXT4kRsENtTnALzRbs6nr6I/w+yG3alV3JEFJ5QT/fxWNEC2c/p6mWUyWZn3
	PeCw9wXEpmzbEpOB1Qt1OxJd+2nO2TTk4+nxbcf6sRX5QvJ2x3K/RW3L2Tqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738561232; x=1738647632; bh=XQuhntA0IetA0jta+yrERWAIDp7HotiyWF5
	SPEQGLkQ=; b=HC5eNT3epCxNp1dZZMlUlZH2wVYCEKDJwR6wPPNTw0KySgwIRvM
	fTqsflvsQTBcvticdvZ3O0xoqTP+tHhThxBC+lsiG85Ns0ApzHue/W2hFZwC3oYw
	kUol+dqNuqlVBfaBBkbqr7Jjy+2NaxF7Pu4+1+fAde1iQd55yqQZP/AX3YE1HIoc
	Eu9cviGF4BZw7RlDEKOF49vYsSY9ClD4yJ/hLoCyCJchF09qgm/lMf8Yu2Ibnae7
	5d3ID1dZsVghvwjjBI+2PK3FWNcKa3FRPS8qwmCdhygvsd+OUaXsDCTgR/OqgObj
	t9JUVZMOJ7+vACpLx+pEMZ269G8Vl5/kxLQ==
X-ME-Sender: <xms:0FagZ-xXui7_P3NliO9en_zcKyu36P9CA9LCeCoTdrbNsCyuJB7jeQ>
    <xme:0FagZ6ST203A8E4rlJeapk4tJ7qtt4zPrrr7ETdVlA8hOgF5HfM4C8BxbRdujFlYv
    VA-hDiayHvZOKbxtQ>
X-ME-Received: <xmr:0FagZwWNs7cbXhEa3tEcuSK3vDKSgSAWoyOdv_MjvP0lnefAldcuG8ZnHExTRLucxHJAkkiZr2FGvRhNPSg8eR25ki4ssyDBBDbhGD41IbxxNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0FagZ0j1pCM6uDA3toG2zX4uEbDgZzqql-m24CZmhOouOUqGTQKk5w>
    <xmx:0FagZwDkPixLU2RWYJq2Mo6FqOYdSoxgjVQiudpgzSlNfJbs48q54g>
    <xmx:0FagZ1KwhQjIbtpfTf4cwnW6XeY0LNSB1wzrLktzVnfF0bJv8BG1lQ>
    <xmx:0FagZ3BQi9dQHbbmI4jn1gmAp7ZS5kUObhTl3Q4Ox0vnpyzqBIkslg>
    <xmx:0FagZzMOQXF2XOQhtMY2qOzYxKGaQ8wR4NZonWzILNM_InNFjd5-sBpo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 00:40:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3d43e54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 05:40:28 +0000 (UTC)
Date: Mon, 3 Feb 2025 06:40:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: undefined behavior in unit tests, was Re: [PATCH v3 3/3]
 reftable: prevent 'update_index' changes after adding records
Message-ID: <Z6BWw0PIANPAcVA6@pks.im>
References: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
 <20250122-461-corrupted-reftable-followup-v3-3-ae5f88bf04fa@gmail.com>
 <20250201022409.GA4082344@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201022409.GA4082344@coredump.intra.peff.net>

On Fri, Jan 31, 2025 at 09:24:09PM -0500, Jeff King wrote:
> On Wed, Jan 22, 2025 at 06:35:49AM +0100, Karthik Nayak wrote:
> 
> > +static void t_reftable_invalid_limit_updates(void)
> > +{
> > +	struct reftable_ref_record ref = {
> > +		.refname = (char *) "HEAD",
> > +		.update_index = 1,
> > +		.value_type = REFTABLE_REF_SYMREF,
> > +		.value.symref = (char *) "master",
> > +	};
> > +	struct reftable_write_options opts = {
> > +		.default_permissions = 0660,
> > +	};
> > +	struct reftable_addition *add = NULL;
> > +	char *dir = get_tmp_dir(__LINE__);
> > +	struct reftable_stack *st = NULL;
> > +	int err;
> > +
> > +	err = reftable_new_stack(&st, dir, &opts);
> > +	check(!err);
> > +
> > +	reftable_addition_destroy(add);
> > +
> > +	err = reftable_stack_new_addition(&add, st, 0);
> > +	check(!err);
> 
> Coverity complains that this function may have undefined behavior. It's
> an issue we have in a lot of other tests that have moved to the
> unit-test framework. I've mostly been ignoring it, but this is a pretty
> straight-forward example, so I thought I'd write a note.
> 
> The issue is that reftable_new_stack() might fail, leaving "st" as NULL.
> And then we feed it to reftable_stack_new_addition(), which dereferences
> it.
> 
> In normal production code, we'd expect something like:
> 
>   if (err)
> 	return -1;
> 
> to avoid running the rest of the function after the first error. But the
> test harness check() function doesn't return. It just complains to
> stdout and keeps running!  So you'll get something like[1]:
> 
>   $ t/unit-tests/bin/t-reftable-stack
>   ok 1 - empty addition to stack
>   ok 2 - read_lines works
>   ok 3 - expire reflog entries
>   # check "!err" failed at t/unit-tests/t-reftable-stack.c:1404
>   Segmentation fault
> 
> So...yes, we will probably notice that the test failed from the exit
> code. But it's not great when the harness itself barfs so had. Plus a
> compiler may be free to reorder things in a confusing way if it can see
> that "st" must never be NULL.
> 
> It feels like we probably ought to return as soon as a check() fails.
> That does create other headaches, though. E.g., we'd potentially leak
> from an early return (which our LSan builds will complain about),
> meaning that test code needs to start doing the usual "goto out" type of
> cleanup.
> 
> So I dunno. Maybe we just live with it. But it feels pretty ugly.

It's one of the pitfalls of our own testing framework, from my point of
view. It's somewhat unexpected that the test would just continue running
as this is the wrong thing to do in almost all cases. When assumptions
fail, nothing good will come of it.

In any case, issues like this will be fixed once we migrate those tests
to the clar unit test framework. The default there is to abort the tests
in case an assertion fails, which is much saner from my point of view.
So I'm not sure if it is worth fixing this now, or whether refactoring
the tests to use clar is the more sensible fix.

Patrick
