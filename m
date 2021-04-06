Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E275DC433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 02:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82D76139E
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 02:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbhDFCw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 22:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbhDFCw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 22:52:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D28BC06174A
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 19:52:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ap14so19576908ejc.0
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 19:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JIExY/8d3KpyTzXEst/3i8AOlXGwm+U4LK39z2D3Ze8=;
        b=kkhuXGT8q1ZapsEM9qb9YXnZdJD7fuzTtJDL9JVxd9LhMrgBkNdAp2Cnf2HjF1aq3Z
         nfHauklocsXV471Eq2M0PcUCW0lROpWU7yyOgS6BzToOKNAg5K5cK68nK3SxvvxkVAxA
         VHzHPateKcc0Q/jB9iQf3gVqG9CaUwt42lKupeLNLUfyH/DgcLF+10Ywh263Z77cV7PS
         wYiHyq0zH9hSTskGx8PkcOQTcp4t9uSr+rhy0ZlCrkhvT1XFNHhtzTxeACMSxJTgtph/
         SvqS28/dYY3Py0qvJDgEc8Jr4XMfBwiGWEVWcrJTmsdtKcpiCIuuRPZyFr8PnED345pV
         b3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JIExY/8d3KpyTzXEst/3i8AOlXGwm+U4LK39z2D3Ze8=;
        b=Tihb3zjAboWxIuKyxg1bd+PU5GaFoyzQJQsiO4BWM6/4g3RW/fUShO8suLr+PoJYmS
         6hx8v2VR/blrY4D4H1n/2LLc8C0SLbaO8vJtjQw+T5BCxJp2OGuQw/yj65aT2sOWn6IS
         oaaouuZ4Dj3CsPqZ2Sn/IncWnnwE5UoOCZvqJk3b8VCHWqZ4Snxlmi31XCNszh/4/5cd
         QkdLGryRSjHp60E5+L8W3pb8aNhBgYOHr1DYKBV5YK2+zCKyV/AoURgQh7yk9B/1zgA8
         einqIR2Uoom5Gjduhwko7zJkSI7zB4/6LvDg0fVOjgvhPpY6n0AH/sdu9oLGqH+MJtXk
         qO9A==
X-Gm-Message-State: AOAM533sn2Y2Ycgi3y8S3SBEuYJySB6jQ+sVlcib61T0jRF/zGSm/j8V
        Bjmb47EY8uc4UKqlcveAhWxge24hKSH/NjoYgJxZZg==
X-Google-Smtp-Source: ABdhPJx/ptFdT93qwXwVl2Cp0vFPQwDAYlIvOQbFSKC891IawX5IWrl9QjRLhwx27DhjSfhHW4qYLARhEcIOQIBYwb4=
X-Received: by 2002:a17:907:3e9e:: with SMTP id hs30mr32187712ejc.66.1617677536828;
 Mon, 05 Apr 2021 19:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210403013410.32064-2-jerry@skydio.com> <20210405221902.27998-1-jerry@skydio.com>
 <xmqqr1jo4aex.fsf@gitster.g>
In-Reply-To: <xmqqr1jo4aex.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Mon, 5 Apr 2021 19:52:06 -0700
Message-ID: <CAMKO5CuLpa9Sn_oXMpgP6oGE9NFA8aLeTfeyaW6TOTErE0KgEg@mail.gmail.com>
Subject: Re: [PATCH V2] git-apply: Allow simultaneous --cached and --3way options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>,
        Jerry Zhang <jerryxzha@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the comments! I've updated v3 with the changes. Let me know
if you have any
more thoughts on whether to block / warn the user before clobbering their cache.

On Mon, Apr 5, 2021 at 3:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jerry Zhang <jerry@skydio.com> writes:
>
> > Subject: Re: [PATCH V2] git-apply: Allow simultaneous --cached and --3way options
>
> s/Allow/allow/ (cf. "git shortlog --no-merged" output for recent examples)
>
> > Previously, --cached and --3way were not
> > allowed to be used together, since --3way
> > wrote conflict markers into the working tree.
>
> Hint that you are talking about the "git apply" command by
> mentioning the name somewhere.
>
> Drop "previously"; we talk about the status quo in the present tense
> in our proposed commit log messages to set the stage, and then describe
> what the patch author percieves as a problem, before describing the
> proposed solution to the problem.
>
> cf. Documentation/SubmittingPatches[[describe-changes]] (the whole section)
>
> > These changes change semantics so that if
> > these flags are given together and there is
> > a conflict, the conflicting objects are left
> > at a higher order in the cache, and the command
> > will return non-zero. If there is no conflict,
> > the patch is applied directly to cache as
> > expected and the command will return 0.
>
> Give an order to the codebase to "be like so".  Here is my attempt.
>
>     Teach "git apply" to accept "--cached" and "--3way" at the same
>     time.  Only when all changes to all paths involved in the
>     application auto-resolve cleanly, the result is placed in the
>     index at stage #0 and the command exits with 0 status.  If there
>     is any path whose conflict cannot be cleanly auto-resolved, the
>     original contents from common ancestor (stage #1), our version
>     (stage #2) and the contents from the patch (stage #3) for the
>     conflicted paths are left at separate stages without any attempt
>     to resolve the conflict at the content level, and the command
>     exists with non-zero status, because there is no place (like the
>     working tree files) to leave a half-resolved conflicted merge
>     result to ask the end-user to resolve.
>
> > The user can use `git diff` to view the contents
> > of the conflict, or `git checkout -m -- .` to
> > regenerate the conflict markers in the working
> > directory.
>
> Nice.
>
> > With the combined --3way and --cached flags,
> > The conflict markers won't be written to the
> > working directory, so there is no point in
> > attempting rerere.
>
> I am not sure what this paragraph is trying to convey here.
>
> I agree that when a *new* conflict is encountered in this new mode,
> writing out a rerere pre-image, in preparation for accepting the
> post-image the end-user gives us after the conflicts are resolved,
> does not make sense, because we are not giving the end-user the
> conflicted state and asking to help resolve it for us.
>
> But if a rerere database entry records a previous merge result in
> which conflicts were resolved by the end user, it would make sense
> to try reusing the resolution, I would think.  I offhand do not know
> how involved it would be to do so, so punting on that is fine, but
> that is "there is no point", but it is "we are not trying".
>
> Perhaps
>
>     When there are conflicts, theoretically, it would be nice to be
>     able to replay an existing entry in the rerere database that
>     records already resolved conflict that match the current one,
>     but that would be too much work, so let's not try it for now.
>
> would be a good explanation why we are not doing (i.e. we made a
> trade-off) and recording that is important, as it will allow others
> in the future to try building on the change we are proposing here
> (it is not like we decided that it is fundamentally wrong to try to
> use rerere in this situation).
>
> > Signed-off-by: Jerry Zhang <jerry@skydio.com>
> > Signed-off-by: Jerry Zhang <jerryxzha@googlemail.com>
>
> Unless we are interacting with two people with the same name, please
> sign-off with the same name/address as the name/address that will be
> recorded as the author of this change.  I am guessing that dropping
> the latter should be sufficient?
>
> Thanks.
