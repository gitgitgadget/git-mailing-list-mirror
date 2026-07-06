Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0756339734D
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349872; cv=none; b=lSAaM6DRAZNpLBU1h7ViGLnPYjSMy1iwILqpnCv7+reN6ZTQ1VLO+5KWx9n3049C97U2eekvTUZFNjnWFwGLAjDMtK17SWaQd7WshZ9jMRl5jksNwOjvTNF4WiB2pTMXXbW8yIf0tuESqxdG7dmYyq+wzpTxwLIBoExc9Rpdwso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349872; c=relaxed/simple;
	bh=08PcmW1k95qahnff3Hc6nNvwpzk6hvGJyc1Xcc+Yfls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=edD4fkVV3AZUIQLkTnXd8NhB6qAlKu0Yfi+xd7iD416lq999JXQzEUb0dvq+ZT4rAY5zAao/qVQskiD8aVPiqQFp4OfMIX7ndFyf//Dm5BXwqcc4dhyONtu6wxOwuvgek/5Az+r0Jog+SQyfvDQKma7XaDJgtoGo4X5JAnymLHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qsjJYBgC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LVhl+jvp; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qsjJYBgC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LVhl+jvp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 40FE61D000EA;
	Mon,  6 Jul 2026 10:57:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 06 Jul 2026 10:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783349870; x=1783436270; bh=UM2SP6Xg8z
	xjDk1RhhAp9zTV5QjDeM/V5pigAOCfaJk=; b=qsjJYBgCCLslWUvc1PMEM3sXs/
	P+NFmF0z+FpuY6O6DKdbPNkF3BUcCW6TkYpI4yj29tazrB7+6P+Db53k2uDHMVfR
	FVywB6JfQ7cgHo8G0hW51dZSB/ZRTjNBlDSSKZZoScpcVjsmFg1rS8aSVeDMLKvK
	XLkeTJ7UfbbAFtZ59bl3/5+DucFjJ0JxWdd5KlXre0ZWoVcl0yCV3lg8G0Iz5SKj
	b9YbzrYVJJY9nvGcXD1eM0xGt5VJ1LNKhraH+TgwHU49BzJbx04nqcPZMwuQPYeV
	uvYgWn6jvLgLWy6uA4z+p8zzB1QllyvC0saSsvrDy+DQXFrNDB7UcSk0e6AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783349870; x=1783436270; bh=UM2SP6Xg8zxjDk1RhhAp9zTV5QjDeM/V5pi
	gAOCfaJk=; b=LVhl+jvpHVT/GvXbcpT6FKFo4J/um521oJ9D8C+MZrY7m4ITbVj
	WHmWfo/3zzoULQCUcqoIi4ti2m2iNq8bE4yrTtPWJyIy/FORSauctTWBfu9d3bgX
	GYMdnXqEowMXJbDB9pMtogxgepqoU+VdvefYxKOS5Wsaz962TYwEOtDhOfE4vUyG
	4jO/KLKuz2PuC855ZvuScb1THkNAb2sIuKK0yLWD8TCVfgtMsMHtHIyQpGnp44WK
	opEh5LNNblXQC6oPwJqQSDs/gg+r5HLmCD1nYwhYSvJgoUAQVyVw0cOrh4tMQ/j5
	X6FOajJwhyHUx385628OE3fsFZszghMM6Bg==
X-ME-Sender: <xms:bcJLagnjvyJCYSk_A1fzco_DMZY4HxmQ4rVoZCrqqNCiA8ftLvWdbQ>
    <xme:bcJLam2BKK8yb8Tltz3csb-zZiiOwh1GgLetX7GvYcgIAGUVrvMsOzSbrJ7do7mGX
    WVURcaO1OMsWuuKRzmyjCIlXazylf4C8GG2k-E0KEVBnqfPfKIZvQ>
X-ME-Received: <xmr:bcJLajoX7Tx5TrBaJTULsSGlM1ybeRrx4IFCKSsmpa7X1iop0NeF6K-VEJ9z1mOzluaj-zx7pQ8pDvv5vvCBHrb_Xn9yGs8c7UgKsUs>
X-ME-Proxy-Cause: dmFkZTF568XcDWzgfmZ6W13boLHCdL4KVFB3Xl2zxgxuS0Nx81+jqAK/t8F73zjFBm7ON9
    CWAK+l/CP84h2esAf+BfwZhdd2jMoTeQxsVHKMkec9b+lrthW5c3OKLEOCPGRYqQRa34SQ
    xgclahQ0vidfzkhfVbW+1obgAjwpvMRX7fxkzkwzjWNJ8U2ES3oT8MVAhAw4SKYBxKV4FD
    YUypxsi/MQkB+oqeezee03uZJspkON1yCbwqdk4IzNnLKdHKWcI0PtLQDmcpIszSIhTmWW
    fFSCcGfo/lLxATBmpEouHbkLZLGZRyNYM+0gGcydiBZT1HXa6Jk0w3sjFoNp09seF4/COk
    M76q2zke3TCoUaPXsl9mrbyOJHJ132RtWP3OtjmV7dg8naQPjZFnr8x4wfuoU5TBnZPT88
    6BfJAq3U99hR2FdL61SUPusi/skbx6v9SWe0sTFGq0JSDf35MP1CmQhrfZLWAngQJBVAwc
    I560mVmbIcNRwEzrgqntcapPZSOBJq3E6D+MIqI7tzjHnWL6hz5KUtflBeWirV3Ei4ugUl
    QoWMW24cgTs/QcBsGbVn8YzsDoypVd3pQj5NR81usdCn+sp3V4dgWsXabgjhyPyDMoPwP8
    QvDo8BxKgHsVjSCIzCMb1hzBXb4F9k7YPieHi+1Nz4XyDJmf3xoZh7m9g2vw
X-ME-Proxy: <xmx:bcJLarcNaYIUu__yl2qc-k8GhHa09b9qTzzbIpPfZ2l2YbYwtmjvbQ>
    <xmx:bcJLaqp2Au10D35pFrr1_XxHkZhYRKa3bAVU1sRHVbHzxGRIDWFrbw>
    <xmx:bcJLakGQ9z8nwrEMwDkuswLU2I45_XADuZGpmMG_T19CgsB2kqiOew>
    <xmx:bcJLaivl2Yl-XsJm7a4Ha4-zka6bT3kBOwLjFGtLm2z8suGOv_HboA>
    <xmx:bsJLamnREafJLvtwrt2QTS677o7RPKf1iCbxgCTLpAxNkt80FwoRf9GH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 10:57:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v4 0/5] builtin/refs: add ability to write references
In-Reply-To: <20260706-pks-refs-writing-subcommands-v4-0-d51f6ce7f830@pks.im>
	(Patrick Steinhardt's message of "Mon, 06 Jul 2026 15:27:03 +0200")
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
	<20260706-pks-refs-writing-subcommands-v4-0-d51f6ce7f830@pks.im>
Date: Mon, 06 Jul 2026 07:57:48 -0700
Message-ID: <xmqqtsqcb1xv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Reference-related functionality in Git is currently spread across many
> different commands: git-update-ref(1), git-for-each-ref(1),
> git-show-ref(1), git-pack-refs(1) and git-symbolic-ref(1). This makes it
> hard for users to discover what functionality we have available to work
> with references.
>
> We have thus started to consolidate this functionality into git-refs(1),
> which is a toolbox of everything related to references. Until now, the
> command doesn't handle functionality of git-update-ref(1).
>
> This patch series backfills most of the functionality by introducing
> three new commands:
>
>   - `git refs delete` to delete references. This is the equivalent of
>     `git update-ref -d`.
>
>   - `git refs update` to update references. This is the equivalent of
>     `git update-ref <refname> <oldvalue> <newvalue>`.
>
>   - `git refs rename` to rename a reference, including its reflog. This
>     does not have an equivalent in git-update-ref(1), but is inspired by
>     and supersedes [1].
>
> Changes in v4:
>   - Add a couple more tests around symrefs.
>   - Use a subshell in one of the tests for consistency.
>   - Link to v3: https://patch.msgid.link/20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im

Good that this came just in time before I started merging things
down to 'next' ;-)  Will replace.
