Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948282BD11
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772951181; cv=none; b=AcgrTZTRV9/WqFT88cBwORoKQau/qpLKUZF3xMO85a8JmsQKVkjOgfgStFpJUtRGMmmoC7jnIFD5ebAHt3dJcXo88cmfy9G2xTVOXpcfGQDCTA20F3ybNvMHa6To4L2+7ifOuIUSgn4czyM4aiAK1CwMsMVC/qT2Q23AcXcj8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772951181; c=relaxed/simple;
	bh=jzLeGbWIr9/nocFe+msHzEx5EcdTOTpWItar0d8CGok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uJIjtipxHunjV3jssWnqqANqRFvPrf7qXbd9A23KRP1T5Jqd9Kkr9grYvI0vChpJlieJEK9kJICavRQhM5bQQFaPdXSoXiGTNBuCHBN5NmohCD+jgQr97UH4/Z7P3e4PPkfW8xMztMZgo2PfLfmMtEsLJvF6TsWIp0YIm+QeCjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cJy8cliK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O803Wjlm; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cJy8cliK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O803Wjlm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA4701400166;
	Sun,  8 Mar 2026 01:26:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 08 Mar 2026 01:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772951179; x=1773037579; bh=+1/LxGTecs
	W3GH3wxv2KW4ICyLFPHq6cyFwRHOytBeo=; b=cJy8cliKSsf2VNHmDkb0zIz7DV
	rKmpv1I2BYSL6KxKgE56T8YCJF6fCECmbH+pokeUPEJi+odzJGedR8m9zOJzoqeu
	xI+jwGjoTQDTrbhiJ/mC+1JV42nanJ6UBd2DRoPDzIjmQ6ZhaiKU7MPBTW6f9Moj
	gQq+5MDjqV/U57eSm1PTWEL5wf0Wivz0PaHqZ7luD5p/speDZStQWgO3hPF8iVUV
	J5GNIajrWLDgkba+SPe9EorOd29HiYuE4yrPvupCKXJrQls5XHTXdDzKSRcVoPbN
	r0K8kCBcNEemn0Du9LEd39/EA3T2fa51ZDht+cO1X5dxTnJjQmJWb2SP03vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772951179; x=1773037579; bh=+1/LxGTecsW3GH3wxv2KW4ICyLFPHq6cyFw
	RHOytBeo=; b=O803Wjlm6W29NgEeAMFlBxWOPM+FuzF8zDverT1V4kl41vzvf8U
	ENrCy1oKOYwyJWk6Mq0faW2PYyIziw13KjfUTHgSiqLXFhSl1hCjaMmWF7hHGqTi
	XMkjPZAPKhs6VPJTPpsXyYpEY5+vGg70CME8r+NkZs/+ZAMArwTK3kL1YLhOsw0P
	orwkxR3n3PFtvKJDHPwCQaNmlXc1GA124TQtjwL6rWiqUz4LXoENh0MXiaU8wDPk
	E4pxVW5H3eTbt0UFz58+MSxYheLwW5exvKbTaxD3xj0NujCQbHdK0wQLOMMha17v
	/9SwT+MLsGKlT6+2sozArq38BOsxqq9ASVQ==
X-ME-Sender: <xms:ixataekl2IBlXRC-yshCoyQKMPgRYUIa7zSj9y77oz7pRV8MnvQZpA>
    <xme:ixatadRxtcDm32D5obzpW4wmyMX99vGVlqQ_i6Itx0l9DDuHU0xmS-NA_TPCR4LKf
    U1O6L01TzICVSPEPxx-sEQxr3zYZv-4ngGhcE4wi1kh93VJi_Gyig>
X-ME-Received: <xmr:ixataaD3cw0VaG7geRLfq7ibTGtD58PQbQOCoMK05hBAm5jdUB_lgn62McKkXfhkVCmyJnn3wON5eRNC-8RA8oY58W6TztJRcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeggedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ixatacSyJNt4RzG_SwffmaTYLLLEWy6eNk5MU_PBcFrQSV-1freWAA>
    <xmx:ixataQqxTXZJFDAzDZyZ3abcbrJA2AmQocqE7yi_nExuWaHTrsrEQw>
    <xmx:ixataWze7Bdk1K3gHh6DA9iJ36iKZrNnoYjlUf9_t8BzaCfdgUv7SA>
    <xmx:ixatadLFEiE2yyxAHaJAmXCkgotUmWV2wFZH9C9BbkjWeLFpnLb3-Q>
    <xmx:ixataSo0Tv5d-yuYlv4ayS1gRHVnVg2pQQI4xGG3c7x8t-o7S2fSepkG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 01:26:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] patch-ids: achieve const correctness in patch_id_neq()
In-Reply-To: <20260308043131.77782-1-a3205153416@gmail.com> (Tian Yuchen's
	message of "Sun, 8 Mar 2026 12:31:31 +0800")
References: <20260308043131.77782-1-a3205153416@gmail.com>
Date: Sat, 07 Mar 2026 22:26:18 -0800
Message-ID: <xmqqseaasuph.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> The implementation of the 'contain_of' macro in 'patch_id_neq()' is:
>
> 	#define container_of(ptr, type, member) \
> 		((type *) ((char *)(ptr) - offsetof(type, member)))
>
> Here, 'type' is passed as a raw type with no const information.
> Consequently, const correctness cannot be guaranteed here, resulting
> in an eight-year-long NEEDSWORK comment.
>
> Use explicit casting (struct object_id *) to ensure const correctness.

The "NEEDSWORK: const correctness?" comment in patch-ids.c:patch_id_neq()
is indeed about the fact that this function modifies its arguments `eptr`
and `entry_or_key` (via the `patch_id` pointers `a` and `b`) to lazily
compute the full patch ID.

I am afraid, however, that this patch may not be moving in the right
direction. By marking `a` and `b` as `const struct patch_id *`, you are
telling the compiler and the reader that the objects they point to will
not be modified. But then you immediately cast that constness away when
calling `commit_patch_id()`:

> -	    commit_patch_id(a->commit, opt, &a->patch_id, 0))
> +	    commit_patch_id(a->commit, opt, (struct object_id *)&a->patch_id, 0))

I wonder if this is actually any better than the original code. If an
object is marked `const`, it is generally supposed to be immutable.
Casting away the constness of a member to pass it to a function that is
expected to write its findings into that memory region sounds wrong to me.

The fact that `patch_id_neq` receives `const struct hashmap_entry *`
parameters--which is a requirement of the `hashmap` API--is what is
clashing with our lazy initialization here. The original code
handled this by casting to a non-const `struct patch_id *` right at
the beginning (via `container_of`). While this also "drops" the
constness, the original is at least more honest about the fact that
`a` and `b` will be modified.

If we truly wanted to achieve const-correctness here, we would
likely need to avoid lazy initialization within the comparison
function altogether, pre-calculating the full patch ID before it's
needed for comparison. The NEEDSWORK comment should remain until a
more fundamental solution is found, or if we should just admit that
the current lazy evaluation pattern is what we want and document
that (i.e., add a comment to justify why we strip away the constness
here). As it stands, this patch doesn't "ensure" const correctness;
it just masks the violation with an explicit cast at the location
the pointer is used.
