Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA2EC433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 19:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242010AbhL3T3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 14:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241813AbhL3T3m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 14:29:42 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52932C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 11:29:42 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o6so101597194edc.4
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 11:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qeh/7m3ksYOYzRyVusvGdt01SF6uB93ycqeakc0lZXE=;
        b=YpVth00fgzDV5mbfteYHOlC9NbiZExyzSQ3ZeHg8+yC8nvpfmDp5LXy4+q1mM2GRbx
         cB5xWnFm2hrS5xitgUvtSZqoLwlJgVNe+mjJ2yhVfx1G4IHbaov4VJntPaW7+4BetW/W
         CQjPyDV7o6OXv59jM85wbfcBD/CGnISICuBylDel/lSKxFabUfxWnLEFGcGA42xuUg89
         noI92MNi0f4mSHPPMPtOmhOurLQWq/DR1GBTGCvHKQCDG2rRzaZ0Dw94bHbwk7/mSzNJ
         j1Q3UV+gwO4FmxyL8UDjFAkwBE9ErObtDwklP5UuUhfX8zQnjG1HVbSp19N4W/uaF7wy
         zm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeh/7m3ksYOYzRyVusvGdt01SF6uB93ycqeakc0lZXE=;
        b=RSQKo5KddXUyxVIFT41ZbAzvkqFoZp4wFB3lUFA+Yu8PiKIdFJqEkoTi3YYnmjP4sp
         njJN9Pl2hOjS6fi0WXIq2VtjRi7M0zSirTEpYzuan4bUc36Wa+n6NOV9NiMXq/iqYnFR
         Equho2bFsM+XZx46KOpPe1b9gr91U6zaJDDWIJbCc1kNave+apfHgYlIAJMGIM4o4VBn
         QQ5DZGx9wy2VuKU+HAgrbRvMf0j4J3uXDsl3klq0uN2G3giuaqxGKx+nh/6sUuVWr2x3
         r598t43NyDo9X4az3TvZeMX6gvrk1jZhx6ydiTAKPBqzEc55dKsk89J41bSFQLbKbApE
         CNcw==
X-Gm-Message-State: AOAM531NayL/gJ/z4VeKrICRdPDQh3u7OhKD/i0i390pgxf0pCdemNDf
        36yI7j541DfKW9XrXXCnglxN65cAF3VnoPZ2DeeYh73PN2g=
X-Google-Smtp-Source: ABdhPJz0TG67oawyo39GXAUFnL6cA5cA6jtMQNhvZN51oD2u7xPQg6y8fA/O5Ws+otMquAHwSOIwd0AtSpv1QhpFm1A=
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr25479382ejc.269.1640892580775;
 Thu, 30 Dec 2021 11:29:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com> <CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com>
 <CAPig+cQ8Y2FC8=d7DaZ46YwPCrzM6RzutiZ3ghhrHsg6y8KWoQ@mail.gmail.com> <f62709d5-a0d4-dc0c-461a-c4c75c810340@gmail.com>
In-Reply-To: <f62709d5-a0d4-dc0c-461a-c4c75c810340@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Dec 2021 11:29:29 -0800
Message-ID: <CABPp-BG2Ueb9rBRNZz3Z_8V7hin5SamzOJLNpjrg0k-QGUV4zA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Sparse checkout: fix bug with worktree of bare repo
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 30, 2021 at 9:41 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/30/2021 2:40 AM, Eric Sunshine wrote:
> > On Wed, Dec 29, 2021 at 4:40 AM Elijah Newren <newren@gmail.com> wrote:>
>
> Taking time to focus only on this outline here:
>
> >> So, I'd like to reiterate my earlier suggestion which would avoid
> >> these regressions while also fixing the reported bug:
>
> >>   * If core.bare=true or core.worktree is set, then at `git worktree
> >> add` time, automatically run the logic you have here for
> >> init-worktree-config.  Having either of those config settings with
> >> multiple worktrees is currently broken in all git versions and likely
> >> in most all external tools.  As such, being aggressive in the new
> >> config settings to allow new versions of git to work seems totally
> >> safe to me -- we can't be any more broken than we already were.
>
> I'm not sure I agree with the "currently broken in all git versions"
> because when extensions.worktreeConfig is not enabled, the core.bare
> and core.worktree settings are ignored by the worktrees. This upgrade
> during 'add' is the only thing I am not so sure about.

Oh, you're right; I mis-spoke.  If someone has core.bare=true and has
multiple worktrees, AND never attempts to use sparse-checkouts OR
otherwise set extensions.worktreeConfig, then git still works due to
git's special-case logic that will override core.bare in this
configuration.  It's just setting them up for a ticking time bomb,
waiting for them to either use an external tool that doesn't share
that special case override-core.bare logic, or for the user to decide
to set extensions.worktreeConfig directly or use sparse-checkouts.

> >>   * If core.bare=false and core.worktree is not set, then:
>
> >>     * `git sparse-checkout {init,set}` should set
> >> extensions.worktreeConfig if not already set, and always set the
> >> core.sparse* and index.sparse settings in worktree-specific files.
>
> This should happen no matter the case of core.bare and core.worktree
> existing, right?

Hmm.  I think that's safe for people who cloned and used `git worktree
add` with newer git versions, since `git worktree add` will have moved
core.bare and core.worktree to the config.worktree file when those
have non-default values.

But, we might want to help out the folks who have existing repos with
which they have used older git versions.  So, we could have `git
sparse-checkout {init,set}` check for non-default values of
core.bare/core.worktree in the shared config file, and, if found, exit
with an error which point users at some relevant documentation (which
may just suggest 'git worktree add temporary && git worktree remove
temporary' as a workaround for those caught in such a state.)

> >>     * `git worktree add`, if extensions.worktreeConfig is already set,
> >> will copy both the info/sparse-checkout file and the config.worktree
> >> settings (module core.bare and core.worktree, if present) to the new
> >> worktree
>
> and here, 'git worktree add' should always copy the info/sparse-checkout
> file (if core.sparseCheckout is enabled) and copy the config.worktree
> settings if extensions.worktreeConfig is enabled (and filter out
> core.bare and core.worktree in the process).

Right.

> > Thanks for the clearly written enumeration of how you expect this to
> > work. This summary pretty well (or entirely) captures the conclusions
> > I arrived at, as well, after devoting a chunk of time today thinking
> > through the cases. If I'm understanding everything correctly, the
> > approach outlined here solves the bare-worktree problem in the least
> > invasive and least dangerous way (for older Git versions and foreign
> > tools). And we don't even need the `git worktree init-worktree-config`
> > subcommand (though we need the underlying functionality).
>
> I'm happy to drop the subcommand in favor of some documentation in
> git-config.txt (Documentation/config/extensions.txt to be exact).

You may also want to make the two existing references to
extensions.worktreeConfig within Documentation/git-config.txt point
users at the extended documentation you add to
Documentation/config/extensions.txt.  (Remember, I found a reference
to extensions.worktreeConfig, tried it, and started using and
recommending it without it ever occurring to me that there was a more
detailed explanation elsewhere, so only adding to
Documentation/config/extensions.txt might run into the same
discoverability issues.)
