Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0152B18A6DC
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367599; cv=none; b=uBU9aOHdvP8IfElDSWwFJzP1bUYefmYdUdVeb2KbrtLWld0hC/EkK3Ew2J5shT4xPRWDY+uyGt0/nVBVAkxDpQ1udx7iOAxMQx0ptSsshsio4MSYzbHAVaNBFfEpKVQoLksklN+qPkGQvP7LWC4Xuo9AvH8R9+QmEjhjzRqejIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367599; c=relaxed/simple;
	bh=Qa+jTh+KE+eHBwwcDoX1fHtf+c+GwBzZMpVqQS0L8o0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MeM2/1uxNjIpwE44jhrZ+1OsOfsqzKSJgJprmzrm88n153POSzU3qOzP+U1fkqiIw7brjAH4dGk7uF5WE6cXdHafopK4n3jQLqKel1Tut2yZDrWYduIVZhF0FZMdwGQFpZOuFa8iU7GV+U2Il3AZRerMvpt6rT263OKRntIY9XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KHJhPeSF; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KHJhPeSF"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19490354DB;
	Tue, 30 Jul 2024 15:26:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Qa+jTh+KE+eHBwwcDoX1fHtf+c+GwBzZMpVqQS
	0L8o0=; b=KHJhPeSFFvALHkCGmliau9IEA8oDbZRj6SJ+TI6BGhohTp3E0AFKOd
	fcVkSl7djIk4lpKxDpi09KoApindzqJygWfQxmv49xyMHGVv89lseuKt+5AgCn6o
	2uFYHbqL8NupRqw5RoBAvivgaB3fZzuLrXWZE1IoRp1W37M6soY2c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 112D1354DA;
	Tue, 30 Jul 2024 15:26:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B3CB354D8;
	Tue, 30 Jul 2024 15:26:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>,
  Taylor Blau <me@ttaylorr.com>,  =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?=
 =?utf-8?Q?_Bjarmason?=
 <avarab@gmail.com>
Subject: Re: [PATCH v4] Documentation: add platform support policy
In-Reply-To: <20240730175448.1727373-1-emilyshaffer@google.com> (Emily
	Shaffer's message of "Tue, 30 Jul 2024 10:54:48 -0700")
References: <20240730175448.1727373-1-emilyshaffer@google.com>
Date: Tue, 30 Jul 2024 12:26:29 -0700
Message-ID: <xmqq7cd2bs0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9F8F7AE0-4EA9-11EF-857D-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Emily Shaffer <emilyshaffer@google.com> writes:

> My sense is that this doc is quite close, with the only open concern
> being around the "Minimum Requirements" section and what they should
> contain[1]. Would it be valuable for me to trim that part out and send
> it as a follow-on patch for us to discuss in isolation, and merge the
> rest of the document as it is now?

Hopefully just resolving a few remaining "huh?" and it would be good.

> diff --git a/Documentation/technical/platform-support.txt b/Documentation/technical/platform-support.txt
> new file mode 100644
> index 0000000000..e0e7a3c2d8
> --- /dev/null
> +++ b/Documentation/technical/platform-support.txt
> @@ -0,0 +1,187 @@
> +Platform Support Policy
> +=======================
> +
> +Git has a history of providing broad "support" for exotic platforms and older
> +platforms, without an explicit commitment. Stakeholders of these platforms may
> +want a more predictable support commitment. This is only possible when platform
> +stakeholders supply Git developers with adequate tooling, so we can test for
> +compatibility or develop workarounds for platform-specific quirks on our own.
> +Various levels of tooling will allow us to make more solid commitments around
> +Git's compatibility with your platform.

Most of this paragraph is about "stakeholders' platform" where the
stakeholders are third-person, but the last sentence suddenly makes
it "your" platform, which left a jarring sensation at least to me.

"your platform" -> "platforms"?  That does not sound like a huge
improvement.  "various platforms"?  That is not all that better,
either.  All I can say is "your platform" sounded wrong, sorry.

> +Note that this document is about maintaining existing support for a platform
> +that has generally worked in the past; for adding support to a platform which
> +doesn't generally work with Git, the stakeholders for that platform are expected
> +to do the bulk of that work themselves. We will consider such patches if they
> +don't make life harder for other supported platforms, and you may well find a
> +contributor interested in working on that support, but the Git community as a
> +whole doesn't feel an obligation to perform such work.

The part after "... and you may well find" reads a bit muddy.  I
couldn't tell if it is talking about the initial port, or continued
support, or both.

 - The rest of this document is about continued support

 - You are expected to come up with the initial porting

 - If it will make the codebase too ugly with #ifdefs scattered all
   over the place in order to provide compatibility with your
   platform, we won't accept such an initial port.

 - It is even true if some contributors are willing to give support
   to such a platform.  We won't promise that we will bend over
   backwards to support unreasonably exotic platforms.

is what I read out of the paragraph.  Is that the message we want to
give them?

> +* Please include any information you have about the nature of the breakage: is
> +  it a memory alignment issue? Is an underlying library missing or broken for
> +  your platform? Is there some quirk about your platform which means typical
> +  practices (like malloc) behave strangely?
> +
> +** If possible, build Git from the exact same source both for your platform and
> +   for a mainstream platform, and make sure the problem you noticed appears
> +   only on your platform. If the problem appears in both, then it's not a
> +   compatibility issue, but we of course appreciate hearing about it in a bug
> +   report anyway, to benefit users of every platform.

"and make sure" -> "to see if"

and add something like "In your bug report, please mention clearly
that it is a compatibility issue with your platform" at the end.

In other words, we are interested in hearing both kinds of issues,
but we do want to see your problem report marked clearly if it
happens only on a particular platform.

By the way, I do not see why this bullet item should be a subitem
of the "nature of the breakage" item.  It probably would read better
to keep them independent and on equal footing.

> +Compatible on `master` and releases
> +-----------------------------------
> +
> +To make sure all stable builds and regular releases work for your platform the
> +first time, help us avoid `master` breaking for your platform:

"avoid `master` breaking" -> "avoid breaking `master`"?

> +* You should run regular tests against the `next` branch and
> +  publish breakage reports to the mailing list immediately when they happen.
> +
> +** Ideally, these tests should run daily. At minimum, they should run weekly, as
> +   topics generally spend at least 7 days in `next` before graduating to
> +   `master`.

Weekly would give an unlucky topic only 1 day, though.  A report
comes, and it may probably take a few days to stop the train, in
order to validate the breakage report.

> +Compatible on `next`
> +--------------------
> +
> +To avoid reactive debugging and fixing when changes hit a release or stable, you
> +can aim to ensure `next` works for your platform. (See "The Policy" in the
> +link:../howto/maintain-git.txt[maintainer's guide] for an overview of how `next`
> +is used in the Git project.) To do that:

"ensure `next` works" -> "ensure `next` always works"?
