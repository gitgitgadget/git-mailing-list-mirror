Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707F7FA
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CPFfuQLa"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858DB3C39
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 16:12:39 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F0E801C1728;
	Fri, 10 Nov 2023 19:12:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rnx30G6SgjOS1U2zSNWf5hMrWN3m/xEkXJ8ONs
	2FcAQ=; b=CPFfuQLaRo8k7boExHSKTBm0kthZUFML0C1NSYVN53XEePUqB5jV3c
	5d+E2BGqxESkT8t3/uP17cgBVna0vZ4KMFh7G/mpVvT3Uv6hLh4gTSvca7//+Vpf
	2LCEQ6h5TtosqDfV0wN9iW9Ps5pnmrUv0mdn+yFQ6bkf8mCkNTbuk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA2D11C1726;
	Fri, 10 Nov 2023 19:12:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D9A8B1C1725;
	Fri, 10 Nov 2023 19:12:37 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] global: convert trivial usages of `test <expr>
 -a/-o <expr>`
In-Reply-To: <2967c8ebb460934eb4aaaaebe5941bff643d4a94.1699609940.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 10 Nov 2023 11:01:15 +0100")
References: <cover.1699526999.git.ps@pks.im> <cover.1699609940.git.ps@pks.im>
	<2967c8ebb460934eb4aaaaebe5941bff643d4a94.1699609940.git.ps@pks.im>
Date: Sat, 11 Nov 2023 09:12:36 +0900
Message-ID: <xmqqcywhtaff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 057AAE76-8027-11EE-B208-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Our coding guidelines say to not use `test` with `-a` and `-o` because
> it can easily lead to bugs. Convert trivial cases where we still use
> these to instead instead concatenate multiple invocations of `test` via
> `&&` and `||`, respectively.
>
> While not all of the converted instances can cause ambiguity, it is
> worth getting rid of all of them regardless:
>
>     - It becomes easier to reason about the code as we do not have to
>       argue why one use of `-a`/`-o` is okay while another one isn't.
>
>     - We don't encourage people to use these expressions.

Thanks for these additional notes.  Nicely done.
