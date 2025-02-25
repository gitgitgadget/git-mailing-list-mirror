Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A32405F7
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 01:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446282; cv=none; b=rKW6/l73ru+f+fvcvQEk8I+VKQ2gLk5EcOif53Q6Lh3KTdnAhNyVRhHAhBIkunu609H16x1ljgUU6AtS0HpB2q3efeKaMJ0zlJyKw+C8m0dowPZ35jY1EESw+sChSBIx0fU5eUGN4i5HP473Jr3eQOqidlDFjE+wxjOOgqi9NT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446282; c=relaxed/simple;
	bh=JPNPJgyPQUC5GbtSM9fGSBsO3kNzypqI0bneO3e4rIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9T6vt0CM+7S7HRkhKISQlVc2te/Jdowp20d8kE9Bw+tXTS9P4oJFhFt8cWHmJayu6cqBRwxqVtjKFsv1rVMTUbWCyf8Xe0Q/OoPqPq2hDhTIqmuc4e/EpLtJUPmoAjAFxyvdGeusgBnDEJyLQwan737aO/l58K0H9mY9T1UHhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XI6u9k0n; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XI6u9k0n"
Received: (qmail 22034 invoked by uid 109); 25 Feb 2025 01:17:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JPNPJgyPQUC5GbtSM9fGSBsO3kNzypqI0bneO3e4rIE=; b=XI6u9k0nBoFrkvEoLLSnCD9PoNlTJisp6K/O1t/nqDKHPHBngbCCVGUPcxgxx7yN25DS5XmYlRGkWnxiwxwAmXuDpIszcbdZhgce2LyLBN0YMVbYAUsPHzweKNg2PnSsY3X+XHPOh/bn19DTPZQlxG6VUGsFFdppTiiocVhLn//nlyinjqeWKBLzr9F6uuWjalqdl8XLdI4u0hvWAHEfG8LoT0bJg5lcVwVZMfJho5bp5Hq+j1jpk71XwlJDtoMJCKMVU6pZf/5mFz5wBLoAFTH8YcPUhJzecAAa4NWZgbDTz/yXTbnfqKDh8h9wUSjhBlbRBy9GmhX3jJBF35yqCg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Feb 2025 01:17:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31730 invoked by uid 111); 25 Feb 2025 01:17:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Feb 2025 20:17:58 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Feb 2025 20:17:57 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Calvin Wan <calvinwan@google.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][RFC PATCH] show-branch: use commit-slab for flag storage
Message-ID: <20250225011757.GA752084@coredump.intra.peff.net>
References: <20250217055049.9217-1-meetsoni3017@gmail.com>
 <xmqqseobksfe.fsf@gitster.g>
 <20250221063257.GA568823@coredump.intra.peff.net>
 <xmqqy0xzb4o4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy0xzb4o4.fsf@gitster.g>

On Fri, Feb 21, 2025 at 09:15:07AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah. I did not see the word "stride" anywhere in your email, so I
> > wanted to provide a further hint: the commit-slab "_with_stride()"
> > variant is meant to handle this kind of arbitrary-sized data. This was
> > part of the original commit-slab implementation in a84b794ad0
> > (commit-slab: introduce a macro to define a slab for new type,
> > 2013-04-13), but AFAIK we've never actually used it in practice. See
> > that commit for some examples.
> 
> Wow, after reading the log message of that commit, I realize that we
> already were considering that one-bit-per-ref needs dynamic scaling
> and folks must have been thinking hard about it (I do not think the
> author of the commit alone thought it---it must have been a group
> effort on the list, which the log message merely explains the motivation
> behind the design).
> 
> Thanks for a pointer ;-)

Definitely one of the use cases we discussed early on was using it in
paint_down_to_common(). This series:

  https://lore.kernel.org/git/20140625233429.GA20457@sigill.intra.peff.net/

built a fast --contains traversal using the slab stride. I think I
stalled because I hadn't convinced myself fully that it covered all
cases. You left some very thoughtful comments, but I guess I just never
got back around to it.

We ended up taking the early parts (like converting quadratic list
access to a prio_queue) as a separate series. I don't know how valuable
the rest of it is; there has been a lot of work since then in this area
by Stolee, et al. So it's unclear how much it would help now.

But the "bitset" API from:

  https://lore.kernel.org/git/20140625234000.GD23146@sigill.intra.peff.net/

would probably be useful if somebody is trying to help show-branch. It
gives you the arbitrary-sized thing you'd store in the slab.

-Peff
