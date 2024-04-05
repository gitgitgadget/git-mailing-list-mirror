Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B167624205
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300488; cv=none; b=kwNIj3Lm0EMzPiTA6QvFOHlax3V4Kl5vnZweoO2C0GmrxfpWQe79oky+PifrHfo046mJtUkHialUJBAjumiLtMpamKz2aKA3mXmDoxWrwOT+g5kLasqhnd6RhYYd0SIjf5Fm7FK/uMmKya8bzOjAYfQCCXV38jA6j/LyPPnRrnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300488; c=relaxed/simple;
	bh=/IrxP8vVtX0WMKAaKhsTOsHRz12tCpb/wJdhVFCZ5CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwXkL4FB3d8LHl7zWi5gJBeozRak9od34AroGX1TC2Fd/Yw0lOVtvdgroXkH25jpSumV4VHewRO4/4rkdMToCVEEHwuFWDL2sBTQV82AUSXTghxRet/YXzJMpFiT495fnMfr+Dn+XvWm3XITr73fClQLO62FLxitlU9hQE0TGCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8tlLSRJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8tlLSRJ"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d04fc04bso2163994e87.2
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 00:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712300485; x=1712905285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lQo8DeR8S2AHXecL8kNGodTputIpn6NML8fdpxuhl3g=;
        b=c8tlLSRJjPHs4bjD/vPkxGpbneeXwRZskWj9d68moUOW9sc/ONZVmSiQzfV6brAS2G
         kby37zQVBhoTD0ppqAqW5/017qmrkjpcj301M47FudmYLnRcG5l7VJxDDZSvKDK+1RyZ
         80BtV8+Ybloel3dK9s9ksp/3qU7R7hMsXUNKaSU4r1edn5UMpfBopdMYfMKE5bmjmZ4l
         Y7PUlKaQCNwwismntuAEeVjfj/x09+rIIKrDmQ+mAi3Ib1nKuFUEarHw4y3u32m2hnxt
         wRwufu/uFTx3hzXIBOQ4oqOhYaH/1RsjWpUq138N2tbJgk4R11F3dG+UttMXQf7NJ4MV
         LNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712300485; x=1712905285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQo8DeR8S2AHXecL8kNGodTputIpn6NML8fdpxuhl3g=;
        b=SfF2sJNxzYkcU9ldaOrzBQNf7xG+qR6mrwes5QnVzGwDW2xxpgKiLfvXe9wFFUvMcW
         xIDCmqi9rTvpkr/6Sj7S6vVSlbIgpH29DO7voEUMUDxB4qGmrdYYx4u7Rvua6cQftNuT
         jFgOjfS62saSVts1MfumbR1MJG7c+3wSLor6UgJmwEWscWgWMJG9nF3/vwlcMX5LwSBC
         /6TcDUpPF7XyN8OBTYia3igf9N7OtwaQELfXuhnbBoKqSvz3I0TylkpMC6zg2hhPBSsJ
         FzAdCjftkx/RyAcKhnwKoK6m/CQ9YnuK8tctJXA5GaQKr1ObV/Ss+3r+XYMpvE6LJHfk
         b2qw==
X-Gm-Message-State: AOJu0YzfXD6hqRgUpvTtGqDfnOOh9CyX3IeCPsiUZeAnxlJYVvVM+PrG
	Py5B9+dBeBP2zvoB9kqK8otv+GCCk9A+M+1+siTYt2AucsQcdId1wdqJjYGTt1zEZvqIMYrdR7O
	5POg3weVy3xJC9R96mGGf9sFBVuU=
X-Google-Smtp-Source: AGHT+IFydKSUj/L2voPLSKAFPZpawrU2CX45U9wHWCuQhComncz6CeDOqprFQbk5BI3+lYOslBX3y//PNoMYoJzk9XA=
X-Received: by 2002:ac2:554e:0:b0:516:d09b:cbe4 with SMTP id
 l14-20020ac2554e000000b00516d09bcbe4mr439176lfk.53.1712300484565; Fri, 05 Apr
 2024 00:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKcCxfAVGr2QoaXiT81gVZ0mfq3zJs7TywRhJzevwKX7wChJ4w@mail.gmail.com>
 <xmqqa5mfl7ud.fsf@gitster.g>
In-Reply-To: <xmqqa5mfl7ud.fsf@gitster.g>
From: M Hickford <mirth.hickford@gmail.com>
Date: Fri, 5 Apr 2024 08:00:00 +0100
Message-ID: <CAGJzqsmE9FDEBn=u3ge4LA3ha4fDbm4OWiuUbMaztwjELBd7ug@mail.gmail.com>
Subject: Re: [PATCH] checkout: do not bother "tracking" report on detached HEAD
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, mirth hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Mar 2024 at 21:37, Junio C Hamano <gitster@pobox.com> wrote:
>
> By definition, a detached HEAD state is tentative and there is no
> configured "upstream" that it always wants to integrate with.  But
> if you detach from a branch that is behind its upstream, e.g.,
>
>     $ git checkout -t -b main origin/main
>     $ git checkout main
>     $ git reset --hard HEAD^
>     $ git checkout --detach main
>
> you'd see "you are behind your upstream origin/main".  This does not
> happen when you replace the last step in the above with any of these
>
>     $ git checkout HEAD^0
>     $ git checkout --detach HEAD
>     $ git checkout --detach origin/main
>
> Before 32669671 (checkout: introduce --detach synonym for "git
> checkout foo^{commit}", 2011-02-08) introduced the "--detach"
> option, the rule to decide if we show the tracking information
> used to be:
>
>     If --quiet is not given, and if the given branch name is a real
>     local branch (i.e. the one we can compute the file path under
>     .git/, like 'refs/heads/master' or "HEAD" which stand for the
>     name of the current branch", then give the tracking information.
>
> to exclude things like "git checkout master^0" (which was the
> official way to detach HEAD at the commit before that commit) and
> "git checkout origin/master^0" from showing tracking information,
> but still do show the tracking information for the current branch
> for "git checkout HEAD".  The introduction of an explicit option
> "--detach" broke this subtley.  The new rule should have been
>
>     If --quiet is given, do not bother with tracking info.
>     If --detach is given, do not bother with tracking info.
>
>     Otherwise, if we know that the branch name given is a real local
>     branch, or if we were given "HEAD" and "HEAD" is not detached,
>     then attempt to show the tracking info.
>
> but it allowed "git checkout --detach master" to also show the
> tracking info by mistake.  Let's tighten the rule to fix this.
>
> Reported-by: mirth hickford <mirth.hickford@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>     mirth hickford <mirth.hickford@gmail.com> writes:
>
>     >> git switch --detach main
>     > HEAD is now at 5a07c3bde Refactor...
>     > Your branch is behind 'origin/main' by 1 commit, and can be fast-forwarded.
>     >   (use "git pull" to update your local branch)
>     >
>     >> git pull
>     > You are not currently on a branch.
>
>     I think the instruction meant to say "use 'git pull' with
>     appropriate options to update" but had to ellide the details due
>     to limited screen real estate.  And it is quite expected that a
>     "git pull" from a detached HEAD would not do anything.
>
>     Because my local branches do not track any upstream branches, I
>     have little experience with the message in question.  Given
>     that, I doubt that I am the best person to comment on this
>     issue, but having said that, I observe that this is shared
>     between "checkout" and "switch".
>
>     Having said that, I think that the instruction is what is wrong.
>     What is wrong is the fact that the command assumed that you want
>     to keep up with the upstream of the branch you detached from.
>
>  builtin/checkout.c         | 3 ++-
>  t/t2020-checkout-detach.sh | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2e8b0d18f4..26e1a64569 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1030,7 +1030,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>         remove_branch_state(the_repository, !opts->quiet);
>         strbuf_release(&msg);
>         if (!opts->quiet &&
> -           (new_branch_info->path || (!opts->force_detach && !strcmp(new_branch_info->name, "HEAD"))))
> +           !opts->force_detach &&
> +           (new_branch_info->path || !strcmp(new_branch_info->name, "HEAD")))
>                 report_tracking(new_branch_info);
>  }
>
> diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
> index bce284c297..8d90d02850 100755
> --- a/t/t2020-checkout-detach.sh
> +++ b/t/t2020-checkout-detach.sh
> @@ -176,7 +176,10 @@ test_expect_success 'tracking count is accurate after orphan check' '
>         git config branch.child.merge refs/heads/main &&
>         git checkout child^ &&
>         git checkout child >stdout &&
> -       test_cmp expect stdout
> +       test_cmp expect stdout &&
> +
> +       git checkout --detach child >stdout &&
> +       test_grep ! "can be fast-forwarded\." stdout
>  '
>
>  test_expect_success 'no advice given for explicit detached head state' '
> --
> 2.44.0-413-gd6fd04375f
>
>
>

Thanks Junio for the fix. It works for me.

Tested-by: M Hickford <mirth.hickford@gmail.com>
