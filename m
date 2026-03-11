Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7693F3E9285
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773254022; cv=none; b=bZETtyRiXf83er9AA8jSCFacIloxStRmpD6Dfmiti/NNyL9SwG9lEUJiAeMvkEek+faYiVGEdxURBT5/pLZl669n+II0dyWuf9sswe0WsqtyJgmJjRtuVAZeHikV+jV+lwnNIkxH3Aq0OVBwPZM5JbDJryu/g+WuOaPHuh7XjQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773254022; c=relaxed/simple;
	bh=SPcUR7RRGk0iQAR6p2M/2rFTmWLOiEzDXeG57aMkSKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xtlk5ruZJGMaPteNlAOwnXGatiVcMk0lO5YWnXQzNO/7/0Js1/2oqx7PLNShv9hywr22FKuXL5kUCSua8SDn4NuELb9A5LtZogfpPZFthHUPyHmPZ7ZC1oDI4R666IaqlFsG7h3FG6MIxa14mPLmsGB2Uf/ZjzKWi/t3AWuIo3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ykzeg00O; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ykzeg00O"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-467161c4b7aso122841b6e.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773254019; x=1773858819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GT9bS3A8NSmIRQ7wq+HeJi/ERGGQLT+7b8ruT0KxCXM=;
        b=Ykzeg00O1lz3g5wBgSq4/nbPmKYn6SXJdwbNYS4/tvesd5HjzNSfy/kl0olh3FaQQq
         SDrmnWQ6R+6W2M6d+bNMxWIG3EU3GSh5ZkJesa/usP2o5tsXYg+8VWGsFgandGSgmmcF
         CMhY34FAMGn0e4EZJKWtaGWtPeq+vEE2ityGOTmyaZTlSSan5nNFe/NYc0lJn31KJLj+
         d68hoMXRgScZ2rDhfAVpp8/V/hbrZ9ZfK/ohcj8sD46XHn5T7oReXTN1C6yPpkRQNGMz
         lzG7qSM2kGQMT/31Bzxb8vr0Iu94F+JUeMxyT713yq9MOSVy+z3ii2HwoUxhja669xjx
         qB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773254019; x=1773858819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GT9bS3A8NSmIRQ7wq+HeJi/ERGGQLT+7b8ruT0KxCXM=;
        b=Vhj/KMD4eLNGxP7Hv5gqSXj6eVsVIUxqRMDz1WnqIVtQZ6OU59arQKJWh8EPe8afvu
         1FNbir+BOVYkFXP7sa+YD1+K/SAJT2biY+SUgnLoTnG25tM6rQFOQDc2erhgRtkZR/dB
         JHxklmdgFpJLOU/aLvf5q/nXYi3b3mxB6mQENBW6ptXpx6eLehUUAM2+hChQHUBBcZct
         ++7drV4lXRaR/e5agzKob/qwbdRuMCEOGuobnM+4PEn85dEosOR+IjN7ZdPN+wU7FYZI
         plJowxIZ85SysXCwX8mJh4r1wlRAa2aSeoIs+PAj9infCjMiDEODZ4wJRsOhC4iqIv5G
         5sww==
X-Gm-Message-State: AOJu0YzN0Zw05seEy00mMK9o/McLA+scT2UnXVJQ0QF+hStlcYtDUsaZ
	KP7eS3/9poxz4/v2Ii0bEAQK5ZgFqk0ZLDKvBTpAxQzDfNx7W69rRSe5
X-Gm-Gg: ATEYQzxPiR8VHSwSkyMNpX/97QtXqUmdd4CKC9DRaPoOa4L8CYQrD9IbMcD05HdSRBK
	ZW12vrHi07UnVBqMABvwmWho2HCQcr7WGyxEMo9x8k4+pl58J0tZpburwJzaIKwulRGCTJlvdax
	GfLlCnc+5vMix1pWE/OSZPmH3djfaejBbSn+MeHgAbZH5ViJL1OMBt5t8XDEJt36pJH/EEKJBdg
	XGMFIeM2IivnZoe6gCsNsabvOcYxunr+8fZz6oozkDQG5a86YuCia8W+V/MFo9wOkPxKlNJqt2R
	TNYbvXvuuMVXYwB0/sdhu9cW8Tn3ZXMLX4LpotWs1AaltPPGSTRSLnZ3Src2WYyLtpV//BBlk+H
	zXN21b/EyOkP5W65Zmtu0PYkWh9gn4xVO5kCtF9UejlOCKbwEsMn7bdcv1R4vtRsWhWml8tvKJT
	PoX9SDcpcPi1HYulUJ
X-Received: by 2002:a05:6808:152a:b0:467:1f6:4ace with SMTP id 5614622812f47-4673341d034mr1896264b6e.12.1773254018557;
        Wed, 11 Mar 2026 11:33:38 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41791432d87sm1317705fac.1.2026.03.11.11.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:33:38 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:33:34 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH RFC] git-replay: implement subcommands
Message-ID: <abGutGnWo1gN0Dii@denethor>
References: <20260309-toon-replay-subcommands-v1-1-864ec82ef68a@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-toon-replay-subcommands-v1-1-864ec82ef68a@iotcl.com>

On 26/03/09 08:30PM, Toon Claes wrote:
> git-replay(1) has various operation modes. The mode depends on which of
> the options `--onto`, `--advance`, or `--revert` is given. These options
> are mutually exclusive. This usage pattern is counterintuitive and
> uncommon for Git commands to behave this way.
> 
> Implement subcommands into git-replay(1):
> 
> * `rebase`: This replaces what `--onto=` used to do.

I'm a bit confused by this. It appears that the "rebase" subcommand
still requires the `--onto` option so it doesn't seem to really be
replacing anything. I assume we are tyring to break these operations
into distinct categories which seems reasonable.

> * `pick`: This replaces what `--advance=` used to do.
> * `revert`: This replaces what `--revert=` used to do.
> 
> Option `--onto` is still accepted. It's mandatory for the `rebase`
> subcommand and needs to be used in the exact same way.
> 
> Option `--ref` is added and required for the `pick` and `revert`
> subcommands. This replaces what `--advance` and `--revert` used to do,
> but as a single uniform option for all subcommands.
> 
> The `rebase` subcommand also accepts option `--ref`, and when given this
> is the ref that's updated with the outcome of the git-replay(1) command.
> Thus following commands are identical:
> 
>     $ git replay rebase --onto=master master..branch-1
> 
>     $ git replay rebase --onto=master master..branch-1^{0} --ref=refs/heads/branch-1
> 
> In the second example the upper boundary of the revision range is peeled
> down to a commit (using '^{0}'). Without option `--ref`, git-replay(1)
> doesn't know which ref to update, that's why `--ref` is passed
> explicitly.
> 
> For the subcommands `pick` and `revert` it's also possible to combine
> `--ref` and `--onto`. Here are again two identical examples:
> 
>     $ git replay pick --onto=branch-1 master..aabbccdd
> 
>     $ git replay pick --onto=branch-1^{0} master..aabbccdd --ref=refs/heads/branch-1
> 
> In the latter the argument for `--onto` is peeled down to a commit, so
> the command doesn't know which ref to update. To inform git-replay(1)
> which refs should be updated, it's passed explicitly as option `--ref`.
> 
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
> In the patch series by Siddharth Asthana[1] the option `--revert` is
> added to git-replay(1). This is implemented as option `--revert`, next
> to the existing options `--advance` and `--onto`.
> 
> The usage of these options is mutually exclusive, so the user can only
> use one of them, and depending on which one, git-replay(1) selects a
> "mode of operating".
> 
> Various people have raised this behavior is somewhat confusing. In this
> series we attempt to make the usage of git-replay(1) more intuitive and
> user-friendly by implementing the modes as subcommands.

Ok, subcommands for git-replay(1) seem like they could be a good fit
here.

> This patch is submitted as an RFC to gather feedback about the design.
> All changes are implemented as a single patch right now, and thus
> reviewing the changes might be challenging. When we got people aligned
> on the direction, I'll work toward cleaner patches.
> 
> These changes are based on 'master' at 864f55e190 (The second batch,
> 2026-02-09) with the patches of Siddharth[1] applied: 'sa/replay-revert'
> at f79189a653 (replay: add --revert mode to reverse commit changes,
> 2026-02-19)
> 
> [1]: 20260218234215.89326-3-siddharthasthana31@gmail.com
> ---
>  Documentation/git-replay.adoc | 124 ++++++++++++++++----------
>  builtin/replay.c              | 150 ++++++++++++++++++++++++-------
>  replay.c                      |  66 +++++++-------
>  replay.h                      |  31 +++----
>  t/t3650-replay-basics.sh      | 199 +++++++++++++++++++++++-------------------
>  5 files changed, 349 insertions(+), 221 deletions(-)
> 
> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index ffdf790278..a7e8dac23f 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -8,8 +8,13 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
>  
>  SYNOPSIS
>  --------
> -[verse]
> -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>...

Do we intent to remove the experimental marker?

> +[synopsis]
> +git replay rebase --onto <newbase> [--ref <branch>] [--contained]
> +		[--ref-action[=<mode>]] <revision-range>
> +git replay pick --ref <branch> [--onto <newbase>]
> +		[--ref-action[=<mode>]] <revision-range>
> +git replay revert --ref <branch> [--onto <newbase>]
> +		[--ref-action[=<mode>]] <revision-range>

Subcommands with required options like this feel quite bad IMO and I'm
not sure it makes it much more intuitive. I guess subcommands do make it
easier to convey which options pertain to which operation. Maybe it
would be better if required arguments remained positional though?

Also, using these subcommands appears to be required now which is a
breaking change compared to before. The command is experimental, so this
may be fine, but should probably be more directly mentioned.

-Justin
