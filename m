Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1F144D36
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721771400; cv=none; b=nht1eliyzgDBM23YHNx7emjtvPZrTM8iDmfdnvSUNd0DZdMgiDenlrsYP7uuhvLyph6m88ZrdCRbxqL3a92KLD4fq7hPAECxNY+wv/8R3XewbZMqmVGy0lU76QxnsbHukzitCT7gScIaKt3RuhW1QCbvgpvxMaF63Amp49Nc3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721771400; c=relaxed/simple;
	bh=SKscTt1B0EbpGNsUM2ie8Z0NUvdOqJwmNIa8c3v9mNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoNWj3iRWLP2B4/ADje2eAFbLQMgcBthNQlzcboKYvex2NlX/VzURDlJe3swGWqrHCYc1BN+7S0CYvwyLxWioL608mJQXMy2w23Gj8SkIktkwSfcWgzLmwB00yFEi0KOevOBf62j04UPUx//e4hzKpt4lntbYrXA/nKWgC0U+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yjk8R/bx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yjk8R/bx"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d18112b60so201515b3a.1
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721771398; x=1722376198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrTxyGWeezJDuUYFom/GD8sDtRtp9f3aguPc2zAjkHI=;
        b=yjk8R/bxlDZbv3g532s23rPKTNdrfdMbvYGYzuQqeHcQ5H+QX5nzg1LoTDr8DjA2Fg
         0g6fT4p70svg7n2EN7gme/mFZjCqSw3YKVZdXxBOJyf14fhAfbe8iLCq7nn3CJv9MdJ1
         o5dukjskz4xl/oqqumgugUpAcn2PZeLGlAqGzyLhEFsQSOq/TVb8jwCQdqQqj26Dd7iI
         aNi9nAVczB0s2qD/nebTwfY1JJWsvv93gRtjJZAe4khHYDyGoJ97xmEkiVXRQ97hLGAG
         M+VnUs6CvyV+TmQ4LlKh3u+uFKgdmUb90oJRTG2e6mUqEkhuz5Gc0wrvS6eyACY2efjC
         d59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721771398; x=1722376198;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrTxyGWeezJDuUYFom/GD8sDtRtp9f3aguPc2zAjkHI=;
        b=mAQFYUinie2cmp0SaQGzrDKJors7wCYrZzCdjBCPvEaSPHIFR+LrDI4lPyb6RHFq4k
         1KdLDNc8wxldnGIxq4KARQaUt/SAcPERgpP5sF/RpHwSujBtBYrA5RlgauOvXk893zyw
         LGPaVbDQGFrTdyMLDSmnlkBeSlc5LvEwrVnrkZ3ejBKv+V25wvwnFlFbH0nF2aCpo1LE
         bFTTCIevs3UAHVndg6TmXmgwtZh9l+d2jKvDqwexDKB+3jo5oeGkKZ7OBlDjxtOWYcUS
         Uxbcb3QQab3h6txOsFjQfHwy5kHVYi7X3kl6s4zOSeJbcKnltJSu/v4w5a2pLqG1dQbB
         pPEA==
X-Gm-Message-State: AOJu0YxY7RKSv6ezzb4TaY0oKQblfMx6H2DItuk+5wtsf3l0y5vMNUOU
	ku8IXlEcalWOAHLgvejEjnZQP2QValDSjrtARdGvcVYfBMyO9UZkBZ/xQjU8GEeaS3uouTMpWKi
	t1g==
X-Google-Smtp-Source: AGHT+IHCw0R97l5pPUQRlNYekeEx0W5t3PXg5f+T+JpBajQri75TMnHW4HZpFundBMqC3J+tbCaG3w==
X-Received: by 2002:a05:6a00:92a0:b0:70d:2709:3b53 with SMTP id d2e1a72fcca58-70e80778d79mr4787253b3a.4.1721771397375;
        Tue, 23 Jul 2024 14:49:57 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:ae7b:c81e:3de4:a258])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1e4ac7a4sm4477448b3a.136.2024.07.23.14.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 14:49:56 -0700 (PDT)
Date: Tue, 23 Jul 2024 14:49:51 -0700
From: Josh Steadmon <steadmon@google.com>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>, 
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] Documentation: add platform support policy
Message-ID: <o35snkortbqg3gexrwwsxyo4ixfqrk6cifdykfr2ujliiqr4he@fnkjehuaqukn>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <johannes.schindelin@gmx.de>, 
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20240711232413.693444-1-emilyshaffer@google.com>
 <20240718173843.2411415-1-emilyshaffer@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718173843.2411415-1-emilyshaffer@google.com>

On 2024.07.18 10:38, Emily Shaffer wrote:
> Supporting many platforms is only easy when we have the right tools to
> ensure that support.
> 
> Teach platform maintainers how they can help us to help them, by
> explaining what kind of tooling support we would like to have, and what
> level of support becomes available as a result. Provide examples so that
> platform maintainers can see what we're asking for in practice.
> 
> With this policy in place, we can make changes with stronger assurance
> that we are not breaking anybody we promised not to. Instead, we can
> feel confident that our existing testing and integration practices
> protect those who care from breakage.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> 
> ---
> 
> New in v3:
> 
> - Made language to platform maintainers a little clearer (hopefully)
>   about this allowing us to provide more predictable support levels.
> 
> - Clarified that this covers maintaining previous functionality, not
>   adding support for something new.
> 
> - Made the bullet point formatting a little less eye-bleedy.
> 
> - Asked reporters to make sure that bugs are really a platform
>   compatibility bug, and not a regular bug.
> 
> - Rephrased section intros to emphasize what the platform maintainer
>   gets, rather than emphasize the Git project patch lifecycle.
> 
> - Clarified alternatives to GitHub Actions CI: GitLab or list scraping.
>   Made some notes about avoiding noise.
> 
> - Small fixes to formatting, spacing, etc
> 
> Thanks,
> 
>  - Emily
> 
> v1 description at
> https://lore.kernel.org/git/20240709225042.2005233-1-emilyshaffer@google.com/
> ---
>  Documentation/Makefile                       |   1 +
>  Documentation/technical/platform-support.txt | 177 +++++++++++++++++++
>  2 files changed, 178 insertions(+)
>  create mode 100644 Documentation/technical/platform-support.txt
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index dc65759cb1..462af0311f 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -118,6 +118,7 @@ TECH_DOCS += technical/multi-pack-index
>  TECH_DOCS += technical/pack-heuristics
>  TECH_DOCS += technical/parallel-checkout
>  TECH_DOCS += technical/partial-clone
> +TECH_DOCS += technical/platform-support
>  TECH_DOCS += technical/racy-git
>  TECH_DOCS += technical/reftable
>  TECH_DOCS += technical/scalar
> diff --git a/Documentation/technical/platform-support.txt b/Documentation/technical/platform-support.txt
> new file mode 100644
> index 0000000000..981997e635
> --- /dev/null
> +++ b/Documentation/technical/platform-support.txt
> @@ -0,0 +1,177 @@
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
> +
> +Note that this document is about maintaining existing support for a platform
> +that has generally worked in the past; for adding support to a platform which
> +doesn't generally work with Git, the stakeholders for that platform are expected
> +to do the bulk of that work themselves. We will consider such patches if they
> +don't make life harder for other supported platforms, and you may well find a
> +contributor interested in working on that support, but the Git community as a
> +whole doesn't feel an obligation to perform such work.
> +
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
> +  overview of which branches are used in git.git, and how.
> +
> +* The bug report should include information about what platform you are using.
> +
> +* You should also use linkgit:git-bisect[1] and determine which commit
> +  introduced the breakage.
> +
> +* Please include any information you have about the nature of the breakage: is
> +  it a memory alignment issue? Is an underlying library missing or broken for
> +  your platform? Is there some quirk about your platform which means typical
> +  practices (like malloc) behave strangely?
> +
> +** If possible, build Git from the exact same source both for your platform and
> +   for a maintstream platform, and make sure the problem you noticed appears

Typo: "maintstream"


> +   only on your platform. If the problem appears in both, then it's not a
> +   compatibility issue, but we of course appreciate hearing about it in a bug
> +   report anyway, to benefit users of every platform.
> +
> +* Once we begin to fix the issue, please work closely with the contributor
> +  working on it to test the proposed fix against your platform.
> +
> +Example: NonStop
> +https://lore.kernel.org/git/01bd01da681a$b8d70a70$2a851f50$@nexbridge.com/[reports
> +problems] when they're noticed.
> +
> +Compatible on `master` and releases
> +-----------------------------------------
> +
> +To make sure all stable builds and regular releases work for your platform the
> +first time, you can make sure `master` doesn't break for your platform:
> +
> +* You should run nightly tests against the `next` branch and publish breakage
> +  reports to the mailing list immediately when they happen.
> +
> +** You may want to ask to join the mailto:git-security@googlegroups.com[security
> +   mailing list] in order to run tests against the fixes proposed there, too.
> +
> +* It may make sense to automate these; if you do, make sure they are not noisy
> +  (you don't need to send a report when everything works, only when something
> +  breaks; you don't need to send repeated reports for the same breakage night
> +  after night).
> +
> +* Breakage reports should be actionable - include clear error messages that can
> +  help developers who may not have access to test directly on your platform.
> +
> +* You should use git-bisect and determine which commit introduced the breakage;
> +  if you can't do this with automation, you should do this yourself manually as
> +  soon as you notice a breakage report was sent.
> +
> +* You should either:
> +
> +** Provide VM access on-demand to a trusted developer working to fix the issue,
> +   so they can test their fix, OR
> +
> +** Work closely with the developer fixing the issue; the turnaround to check
> +   that their proposed fix works for your platform should be fast enough that it
> +   doesn't hinder the developer working on that fix. Slow testing turnarounds
> +   may cause the fix to miss the next release, or the developer may lose
> +   interest in working on the fix at all.
> +
> +Example:
> +https://lore.kernel.org/git/CAHd-oW6X4cwD_yLNFONPnXXUAFPxgDoccv2SOdpeLrqmHCJB4Q@mail.gmail.com/[AIX]
> +provides a build farm and runs tests against release candidates.
> +
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
> +
> +* If you rely on Git avoiding a specific pattern that doesn't work well with
> +  your platform (like a certain malloc pattern), raise it on the mailing list.
> +  There are a few ways to avoid these breakages, so we'll work case-by-case to
> +  find a solution that doesn't unnecessarily constrain other platforms to keep
> +  compatibility with yours.
> +
> +* If you rely on some configuration or behavior, add a test for it. Untested
> +  behavior is subject to breakage at any time.
> +
> +** Clearly label these tests as necessary for platform compatibility. Add them
> +   to an isolated compatibility-related test suite, like a new t* file or unit
> +   test suite, so that they're easy to remove when compatibility is no longer
> +   required.  If the specific compatibility need is gated behind an issue with
> +   another project, link to documentation of that issue (like a bug or email
> +   thread) to make it easier to tell when that compatibility need goes away.
> +
> +** Include a comment with an expiration date for these tests no more than 1 year
> +   from now. You can update the expiration date if your platform still needs
> +   that assurance down the road, but we need to know you still care about that
> +   compatibility case and are working to make it unnecessary.
> +
> +Example: We run our
> +https://git.kernel.org/pub/scm/git/git.git/tree/.github/workflows/main.yml[CI
> +suite] on Windows, Ubuntu, Mac, and others.
> +
> +Getting help writing platform support patches
> +---------------------------------------------
> +
> +In general, when sending patches to fix platform support problems, follow
> +these guidelines to make sure the patch is reviewed with the appropriate level
> +of urgency:
> +
> +* Clearly state in the commit message that you are fixing a platform breakage,
> +  and for which platform.
> +
> +* Use the CI and test suite to ensure that the fix for your platform doesn't
> +  break other platforms.
> +
> +* If possible, add a test ensuring this regression doesn't happen again. If
> +  it's not possible to add a test, explain why in the commit message.
> +
> +Minimum Requirements
> +--------------------

It might make more sense to move this section immediately after the
introduction. I don't feel too strongly about it though.


> +Even if platform maintainers are willing to add tests or CI runners, we will
> +not consider helping to support platforms that do not meet these minimum
> +requirements:
> +
> +* Has C99 or C11
> +
> +* Has dependencies which were released in the past 10 years
> +
> +* Has active security support (taking security releases of dependencies, etc)
> +
> +Platform Maintainers
> +--------------------
> +
> +If you maintain a platform, or Git for that platform, and intend to work with
> +the Git project to ensure compatibility, please send a patch to add yourself to
> +this list.
> +
> +NonStop: Randall S. Becker <rsbecker@nexbridge.com>


Overall, looks good to me, thanks!

