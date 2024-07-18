Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0E51E515
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342766; cv=none; b=go7L43OVIGXvJUynesDUsJbw9MBaaiVEdLbeu0lNQmdYxsLUK1H2CVhhHxdl+qb5v3T27LnUmn+YTc5Gp0uI4aTLF2jP+RmzrqtHZ+H8EeJYJm3nZoci7gC9LcJpAe9XhglbhR79UI0X9NsFS+60Jk/4jGQezNgdfGzQhVFTuvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342766; c=relaxed/simple;
	bh=5Oue/7oc3PB2lzHSNwjLzROOh37+UyEpseGFMVuD2Ag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SdMf2fDusIZ5lT5DPJuma6GStG/0T099kodMKZnv25CXiZk6FfRJXgNwlaBZ+WY4DUlRZhzB3L7yuDHr4K/Ch9r/CBd62AEWf81mEhE1KKbVSeaCj9X3Kn+HiVzK6fPSD1SK12z2cYrk0stWAoFgRtlDn/nzsYqZF3TW57FBpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pPDQZipc; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pPDQZipc"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CEA742F2BC;
	Thu, 18 Jul 2024 18:46:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5Oue/7oc3PB2lzHSNwjLzROOh37+UyEpseGFMV
	uD2Ag=; b=pPDQZipcl6XCs0s0ChX+YIgL02yrH78An7YkdYPdO53RQv+mII1gcE
	TI5HbDWkPzhOXg/QpGoaJ9OkgNebI22YHurjDZlHtnTMClGqOqA0Iit6/f2mz1Vj
	40iVzagSu2N7YAb0U8jKPeFZNIGSAJVRfVTSmBDiNDZiBsoyShLSI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3DC02F2BB;
	Thu, 18 Jul 2024 18:46:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34B5A2F2BA;
	Thu, 18 Jul 2024 18:46:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>,
  Taylor Blau <me@ttaylorr.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bja?=
 =?utf-8?Q?rmason?=
 <avarab@gmail.com>
Subject: Re: [PATCH v3] Documentation: add platform support policy
In-Reply-To: <20240718173843.2411415-1-emilyshaffer@google.com> (Emily
	Shaffer's message of "Thu, 18 Jul 2024 10:38:43 -0700")
References: <20240718173843.2411415-1-emilyshaffer@google.com>
Date: Thu, 18 Jul 2024 15:46:00 -0700
Message-ID: <xmqqh6cmmi8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 824CAC7E-4557-11EF-831B-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Emily Shaffer <emilyshaffer@google.com> writes:

> Supporting many platforms is only easy when we have the right tools to
> ensure that support.

"easy" -> "possible".

> +Compatible by next release
> +--------------------------
> +
> +To increase probability that compatibility issues introduced in a release
> +will be fixed in a later release:
> +
> +* You should send a bug report as soon as you notice the breakage on your
> +  platform. The sooner you notice, the better; watching `seen` means you can
> +  notice problems before they are considered "done with review"; whereas
> +  watching `master` means the stable branch could break for your platform, but
> +  you have a decent chance of avoiding a tagged release breaking you. See "The
> +  Policy" in the link:../howto/maintain-git.txt[maintainer's guide] for an

Running

    $ make -C Documentation howto/maintain-git.html
    $ lynx Documentation/howto/maintain-git.html

tells me that the title of the document is "How to maintain Git".

> +  overview of which branches are used in git.git, and how.

"git.git" -> "the Git project"

> +Compatible on `master` and releases
> +-----------------------------------------

Underline that signals what level the header is is drawn to the same
column as the header title itself, or you'd confuse the formatter.


> +To make sure all stable builds and regular releases work for your platform the
> +first time, you can make sure `master` doesn't break for your platform:

"can" -> "want to"?  

But "to make sure X, you can make sure Y" feels a bit awkward.

    To make sure ... work for your platform, help us avoid breaking the
    tip of `master` by merging topics that break your platform.

> +* You should run nightly tests against the `next` branch and publish breakage
> +  reports to the mailing list immediately when they happen.

Can't it be daily instead of nightly ;-), or is it better than
nothing if you can afford to run only once every other day?

A topic (unless it is during the shuffle time around -rc0) usually
spends no less than 7 calendar days in 'next', so while I would
appreciate if somebody runs tests twice a day, in practice you
should be able to catch a new breakage in 'next' if you run a full
and thorough test twice a week.

> +* You should either:
> +
> +** Provide VM access on-demand to a trusted developer working to fix the issue,
> +   so they can test their fix, OR

"VM access on-demand" -> "on-demand access to your platform" (iow,
physical iron is also fine for our purpose).

> +Compatible on `next`
> +--------------------
> +
> +To avoid reactive debugging and fixing when changes hit a release or stable, you
> +can aim to ensure `next` works for your platform. (See "The Policy" in the
> +link:../howto/maintain-git.txt[maintainer's guide] for an overview of how `next`
> +is used in the Git project.) To do that:
> +
> +* You should add a runner for your platform to the GitHub Actions or GitLab CI
> +  suite.  This suite is run when any Git developer proposes a new patch, and
> +  having a runner for your platform/configuration means every developer will
> +  know if they break you, immediately.
> +
> +** If adding it to an existing CI suite is infeasible (due to architecture
> +   constraints or for performance reasons), any other method which runs as
> +   automatically and quickly as possible works, too. For example, a service
> +   which snoops on the mailing list and automatically runs tests on new [PATCH]
> +   emails, replying to the author with the results, would also be within the
> +   spirit of this requirement.

It would be very nice if they did this, indeed.  Explaining that
something that mechanically looks vastly different is within the
spirit is a very good move.

> +Minimum Requirements
> +--------------------
> +
> +Even if platform maintainers are willing to add tests or CI runners, we will
> +not consider helping to support platforms that do not meet these minimum
> +requirements:
> +
> +* Has C99 or C11

OK.

> +* Has dependencies which were released in the past 10 years

This is hard to understand and I wonder if we can clarify.  I get
what you want to say: suppose we rely on library X that is getting
regular feature and security updates in reasonable cadence, say
every 6 months there is an upstream release of library X, but a
niche platform has ported the library only once long time ago, and
hasn't updated it ever since.  Now the Git project may consider
helping a port to such a platform if the initial port of library X
was 8 years ago, but will not if it was 12 years ago.

But if Git depends on an ultra stable library whose last public
release was 12 years ago, disqualify everybody is not what this
requirement wants to do.

I attempted to formulate my version along ...

    Keep up with the versions of dependencies (libraries, etc.) and
    not to lag behind compared to typical mainstream platforms by
    more than X years.

... the above line, but to me it is no better than the original, so
I failed miserably.  But the idea I am bringing to the table here is
that time of release is not absolute.  If typical mainstream
platforms consider a release of a library made 8 years ago from the
upstream performant, functional, and secure enough and fit for use,
we do not consider that they are approaching the limit.  But if
another platform uses the same library from 12 years ago, i.e.
lagging behind others by 4 years is a problem at the same graveness
using another library that was released 6 years ago, when other
platforms are using a much younger vintage of the same library
released at 2 years ago.

Having said all that, everything I removed from my quote I found
agreeable.  Very well written.

Thanks.
