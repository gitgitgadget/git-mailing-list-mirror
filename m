Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFCF17555
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720808145; cv=none; b=BEQz0lloeXrClnZ7v0UyvraIeJe9RVI8CTXZfOnKXAcFaWTNCt6evPNtACJwewKaCEXDklUY47sMdrmhfq1mLEzZhDam1F3DTb9ICtanz61i8j3Z1XYCY09Q/5nReLXrC+Pdhnbit798J0fLkXai2996dkAyy85oWSaZE28npyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720808145; c=relaxed/simple;
	bh=7EfyGd7MExWRb6iFf17NXDMs/hyp3d6AFM4sszvxf/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gQKoxvck3IPnAUr3S0TT8dJzqScVsUIxHGfxsNEgb5ZBO91NoMna37n32ql1qNAMvYhZfG9PI9gy0m0KRmsmIHg5VrzjvtDdgUeyDXEmzMSrX5nzujUS1+nHrqYBZKm8IepfA8EiXxrpwkcSUtmW9DMDjyOyLgBbppR2HWtZImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=onujtXnT; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="onujtXnT"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D9C023799;
	Fri, 12 Jul 2024 14:15:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7EfyGd7MExWRb6iFf17NXDMs/hyp3d6AFM4ssz
	vxf/g=; b=onujtXnTOQ4THVi7g2FOM+OB++AX5iOrC1uYC9VGopLB58+bIG+Vrg
	2EsFYTOoB7E9Vt9c8wWLsVuupzvjLXXpXjiqgoQfR+Q/8uFEnemZ57C5x4rqght7
	6Hp2SHplEyEzunsARrvoqeQJ0XSS/hC4yp8LMlUPES3L1Q6ma/U3o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E99AC23798;
	Fri, 12 Jul 2024 14:15:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C7BD23797;
	Fri, 12 Jul 2024 14:15:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>,
  Taylor Blau <me@ttaylorr.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bja?=
 =?utf-8?Q?rmason?=
 <avarab@gmail.com>
Subject: Re: [PATCH v2] Documentation: add platform support policy
In-Reply-To: <20240711232413.693444-1-emilyshaffer@google.com> (Emily
	Shaffer's message of "Thu, 11 Jul 2024 16:24:13 -0700")
References: <20240711232413.693444-1-emilyshaffer@google.com>
Date: Fri, 12 Jul 2024 11:15:37 -0700
Message-ID: <xmqqed7ylbna.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BE0FFE5A-407A-11EF-91E5-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Emily Shaffer <emilyshaffer@google.com> writes:

> +Platform Support Policy
> +=======================

Paraphrasing a bit for my understanding (read: not suggestions to
rewrite), with some comments (read: might suggest rewrites).

> +Git has a history of providing broad "support" for exotic platforms and older
> +platforms, without an explicit commitment.

    There currently is no level of guarantees given.

> +This support becomes easier to
> +maintain (and possible to commit to)

    We want to give better support and certain levels of guarantees?
    (this is left unsaid, though).

If we don't want that, then we would not care what would make
the support easier to maintain, so that's implied.  Do we want
to make it more explicit?  Perhaps

    Stakeholders of such platforms, however, may want to have a more
    predictable support commitments.  It would require ...

> when Git developers are provided with
> +adequate tooling to test for compatibility.

    ... platform stakeholders to supply Git developers adequate
    tooling to test for compatibility and to develop workarounds for
    platform specific quirks, which may be hard to find for such
    exotic and/or older platforms without platform stakeholders'
    involvement.

> Various levels of tooling will
> +allow us to make more solid commitments around Git's compatibility with your
> +platform.

Good.

All of this document assumes that a working port of Git once existed
in the near past for a platform, and we outline the levels of
investment platform stakeholders can make in order to keep it
working, and expected outcome depending on the level of their
investment.  The document does not cover "I now have this exotic
box---could you port Git to it?"

Is it something we want to clarify in this part of the document?

> +Compatible by next release
> +--------------------------
> +
> +To increase probability that compatibility issues introduced in a release
> +will be fixed in a later release:
> +
> +* You should send a bug report as soon as you notice the breakage on your
> +platform. The sooner you notice, the better; watching `seen` means you can
> +notice problems before they are considered "done with review"; whereas watching
> +`master` means the stable branch could break for your platform, but you have a
> +decent chance of avoiding a tagged release breaking you. See "The Policy" in the
> +link:../howto/maintain-git.txt[maintainer's guide] for an overview of which
> +branches are used in git.git, and how.
> +* The bug report should include information about what platform you are using.
> +* You should also use linkgit:git-bisect[1] and determine which commit
> +introduced the breakage.
> +* Please include any information you have about the nature of the breakage: is
> +it a memory alignment issue? Is an underlying library missing or broken for
> +your platform? Is there some quirk about your platform which means typical
> +practices (like malloc) behave strangely?
> +* Once we begin to fix the issue, please work closely with the contributor
> +working on it to test the proposed fix against your platform.

This is a source to be reformatted by AsciiDoc so it _should not_
matter [*], but I find it utterly unreadable if a bulletted list of
paragraphs are formatted like the above.

    Side note: ... but it does matter because what we look at while
               editing is this .txt source file.

I locally reformatted the above like so:

        To increase probability that compatibility issues introduced in a release
        will be fixed in a later release:

        * You should send a bug report as soon as you notice the breakage on
          your platform. The sooner you notice, the better; watching `seen`
          means you can notice problems before they are considered "done
          with review"; whereas watching `master` means the stable branch
          could break for your platform, but you have a decent chance of
          avoiding a tagged release breaking you. See "The Policy" in the
          link:../howto/maintain-git.txt[maintainer's guide] for an overview
          of which branches are used in git.git, and how.

        * The bug report should include information about what platform you are using.

        * You should also use linkgit:git-bisect[1] and determine which
          commit introduced the breakage.

to have the second and subsequent lines indented to begin at the
same column as the first line, and have a blank line between
bulletted list entries, which made it easier to scan the source text.
Such a reformatting did not appear to make any changes when the
resulting HTML file was rendered (via "lynx -dump").

This might be my personal preference, and if other people prefer the
more dense form used inthe patch, then I wouldn't complain.

Regarding this point.

> +* Please include any information you have about the nature of the breakage: is
> +it a memory alignment issue? Is an underlying library missing or broken for
> +your platform? Is there some quirk about your platform which means typical
> +practices (like malloc) behave strangely?

How deep do we expect platform stakeholders to dig in their initial
contact to us?  In order to make a firm "It is a memory alignment
issue" would be helped by having otherwise identical version of Git
built from the same source on a more mainstream platform (say,
Debian GNU/Linux running on x86_64) and the exotic platform in
question, to be able to say "Ahh, x86 is lenient to unaligned access
and that is why this problem wasn't noticed by developers, but on my
platform this matters".  Is such a comparison something we may want
to hint here?  Perhaps at the end of "use git-bisect to find the
exact commit", add something like

    Build Git from exactly the same source files on your platform
    and one of the mainstream platforms and see if the problem you
    noticed appears on both, or only on your platform.  If the
    former, the suggestions in this document does not apply, but of
    course we do greatly appreciate such a bug report that will help
    users of every platform.

Note that the above would apply equally for any compatibility
levels, not limited to those who expect "by next release".

> +Example: NonStop
> +https://lore.kernel.org/git/01bd01da681a$b8d70a70$2a851f50$@nexbridge.com/[reports
> +problems] when they're noticed.
> +
> +Compatible on `master` and point releases
> +-----------------------------------------
> +
> +To guarantee that `master` and all point releases work for your platform the
> +first time:
> +
> +* You should run nightly tests against the `next` branch and publish breakage
> +reports to the mailing list immediately when they happen.
> +** You may want to ask to join the mailto:git-security@googlegroups.com[security
> +mailing list] in order to run tests against the fixes proposed there, too.
> +* It may make sense to automate these; if you do, make sure they are not noisy
> +(you don't need to send a report when everything works, only when something
> +breaks).

Also, the same problem that was reported yesterday for yesterday's
'next' does not have to be reported for today's 'next', even if they
are different, as long as the breakage is the same.

> +Compatible on `next`
> +--------------------
> +
> +To guarantee that `next` will work for your platform, avoiding reactive
> +debugging and fixing:

Applies to the phrasing at the beginning of the previous section as
well, but I found it easier to read if you flipped the order from
"do Y and you get X" from "you want X, so do Y", e.g.

    We can avoid reactive debugging and fixing, if you make sure
    'next' keeps working for your platform.

Do we assume that readers are familiar with the way how `master` and
`next` are used?  Otherwise

    We can avoid reactive debugging and fixing, if you make sure the
    'next' branch keeps working for your platform.  The changes in
    this branch are what the developers finished reviewing and are
    expected to appear in the next tagged release.  Unless you stop
    them, that is.

> +* You should add a runner for your platform to the GitHub Actions CI suite.
> +This suite is run when any Git developer proposes a new patch, and having a
> +runner for your platform/configuration means every developer will know if they
> +break you, immediately.

I am a bit surprised that nobody from GitLab complained so far, but
the contents of the ci/ hierarchy has been reorganized and it is my
understanding that we now consider both GitLab CI and GitHub Actions
first-class citizens.

> +** If adding it to GitHub Actions is infeasible (due to architecture constraints
> +or for performance reasons), any other method which runs as automatically and
> +quickly as possible works, too. For example, a service which snoops on the
> +mailing list and automatically runs tests on new [PATCH] emails, replying to the
> +author with the results, would also be within the spirit of this requirement.

Again, "do not be too noisy" principle should be stressed, no?  If
it breaks only on the exotic platform in question, please do notify,
but if the breakage is shared with all the other platforms, then...?
