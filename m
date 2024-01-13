Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0038A1A594
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19487 invoked by uid 109); 13 Jan 2024 07:31:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 13 Jan 2024 07:31:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25571 invoked by uid 111); 13 Jan 2024 07:31:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 13 Jan 2024 02:31:34 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 13 Jan 2024 02:31:31 -0500
From: Jeff King <peff@peff.net>
To: Linus Arver <linusa@google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] strvec: use correct member name in comments
Message-ID: <20240113073131.GA657764@coredump.intra.peff.net>
References: <pull.1640.git.1705043195997.gitgitgadget@gmail.com>
 <20240112074138.GH618729@coredump.intra.peff.net>
 <owlyo7dqig1w.fsf@fine.c.googlers.com>
 <xmqqjzoe8br0.fsf@gitster.g>
 <owlyle8uhxut.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <owlyle8uhxut.fsf@fine.c.googlers.com>

On Fri, Jan 12, 2024 at 04:37:46PM -0800, Linus Arver wrote:

> OTOH if we were treating these .h files as something meant for direct
> external consumption (that is, if strvec.h is libified and external
> users outside of Git are expected to use it directly as their first
> point of documentation), at that point it might make sense to name the
> parameters (akin to the style of manpages for syscalls). But I imagine
> at that point we would have some other means of developer docs (beyond
> raw header files) for libified parts of Git, so even in that case it's
> probably fine to keep things as is.

I think this is mostly orthogonal to libification. Whether the audience
is other parts of Git or users outside of Git, they need to know how to
call the function. Our main source of documentation there is comments
above the declaration (we've marked these with "/**" which would allow a
parser to pull them into a separate doc file, but AFAIK in the 9 years
since we started that convention, nobody has bothered to write such a
script).

Naming the parameters can help when writing those comments, because you
can then refer to them (e.g., see the comment above strbuf_addftime).
Even without that, I think they can be helpful, but I don't think I'd
bother adding them in unless taking a pass over the whole file, looking
for comments that do not sufficiently explain their matching functions.

I don't doubt that some of that would be necessary for libification,
just to increase the quality of the documentation. But I think it's
largely separate from the patch in this thread.

-Peff
