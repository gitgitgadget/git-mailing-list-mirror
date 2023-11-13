Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94AA3D988
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NqmAFRcK"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15918F
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 15:55:59 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EC7411C2C33;
	Mon, 13 Nov 2023 18:55:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=99FYapC9z3VlJa6MYMHLlHrZF+fQx/NAP5VeYC
	F//2k=; b=NqmAFRcKPQFEh/QDSpx1NeNDDG6gtjEcSq35gJ0nTwoJQenNn7DMfn
	z8a3tmVnwqHOMRd+w/jKLrPV6yuVkGnZzyVlKP72qTKaosGgWivd1HECnWQzGTLa
	j21vcLr5D8hPrQ/5BvJNCzDkLjRXI1RTay3QVo1GGlVOO/dzL89V4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E40A61C2C32;
	Mon, 13 Nov 2023 18:55:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 580C81C2C30;
	Mon, 13 Nov 2023 18:55:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,  Josh
 Steadmon <steadmon@google.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid running the test suite _twice_
In-Reply-To: <20231113184909.GB3838361@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 13 Nov 2023 13:49:09 -0500")
References: <pull.1613.git.1699894837844.gitgitgadget@gmail.com>
	<20231113184909.GB3838361@coredump.intra.peff.net>
Date: Tue, 14 Nov 2023 08:55:57 +0900
Message-ID: <xmqq4jhp438y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 30F416AE-8280-11EE-AB5E-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> I do have to wonder, though, as somebody who did not follow the
> unit-test topic closely: why are the unit tests totally separate from
> the rest of the suite? I would think we'd want them run from one or more
> t/t*.sh scripts. That would make bugs like this impossible, but also:
>
>   1. They'd be run via "make test", so developers don't have to remember
>      to run them separately.
>
>   2. They can be run in parallel with all of the other tests when using
>      "prove -j", etc.

Very good points.  Josh?
