Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F3171A3
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 22:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s8mNRoGX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34A631C3877;
	Tue,  2 Jan 2024 17:15:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LAcizXfQPcxwhdbMTS4t+GLv7+fQlVyF16C79E
	xiQoE=; b=s8mNRoGXjHILJ/puxBauuNqcZXAUpHw264nW20gWlocmwzI0LsttAQ
	CUOeoFXrK6wLWHvKORltP3VtkpPhdmbEgP7T71PtOqtBL789hR1Auuklo2cTU7pU
	wHgsIPWWQtTITSwIzTAvyu688YZVhGiLkfwLH5TKR6XbuXKXdzU58=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B4161C3875;
	Tue,  2 Jan 2024 17:15:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9725F1C3874;
	Tue,  2 Jan 2024 17:15:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jakub Wilk <jwilk@jwilk.net>,  git@vger.kernel.org,  Eric Wong
 <normalperson@yhbt.net>
Subject: Re: [PATCH] git-clone.txt: document -4 and -6
In-Reply-To: <ZZRzxZNb2Aq+2feW@nand.local> (Taylor Blau's message of "Tue, 2
	Jan 2024 15:36:21 -0500")
References: <20230527123849.5990-1-jwilk@jwilk.net>
	<xmqq1qivd8d0.fsf@gitster.g> <ZZRqgmDycyAXCrGZ@nand.local>
	<ZZRzxZNb2Aq+2feW@nand.local>
Date: Tue, 02 Jan 2024 14:15:57 -0800
Message-ID: <xmqqr0izcrfm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 817B1D4E-A9BC-11EE-BB65-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Note that the 'clone' and 'fetch' versions for many of these options
> have different wording. For example, in Documentation/git-clone.txt we
> have:
>
>     -j::
>     --jobs=<n>::
>            Number of parallel children to be used for all forms of fetching.
>
> Whereas the description in the original fetch-options.txt is more
> verbose.

Yes, so it will be impossible to unify without changing the
resulting text.  But unless one description is clearly better for
one subcommand while the other description is also clearly better
for the other subcommand, we should be able to pick a better one
that would serve both subcommands, and that way we would improve
description for one subcommand while keeping the other one the same,
right?

> In fact, the story is even more complicated than that, since even though
> the 'push' builtin would benefit from having a shared source of
> documentation for the --ipv4 and --ipv6 options, 'push' does not have a
> --jobs option.

Sure, it won't be just "write what is shared across all the transfer
commands in a single file and include it from all".  The direction
of transfer is a reason why the options may differ, of course, so we
may need to have two (or three) include files if we want to go that
route.

> --progress could be shared, as could --server-option, and the two
> --ipv4/6 options. But the number of nested ifdefs necessary to share the
> other options probably dose not justify the effort to do so.
