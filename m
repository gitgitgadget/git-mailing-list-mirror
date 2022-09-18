Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB78ECAAA1
	for <git@archiver.kernel.org>; Sun, 18 Sep 2022 02:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiIRCPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 22:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIRCPB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 22:15:01 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B186313E89
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 19:14:59 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id v15so19509514qvi.11
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 19:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Tha4SCLFtH6xez0Na+RAXGz+tRUNF2zy2atRCPyb7yQ=;
        b=fQ9r7g1j1zWhu8BgeImpmFEUAOITgspMW9YcyQXl8P8TahGpTJW5bNQEXyafZxN69z
         MANSaIs/6y0ZA5zaQdnB+oNa8LDoW2xko6KX/AE+ESUVZZ0hl5CIL9lyQm9gooRtgzXA
         hBKwATQ5LiVRj8Job3kprwFkOlWDWj0TJSHmPwYwQLn305HkdmodmvqQ16VRh3LxmtNh
         h90iM95H25BWbXWrfvkxfxbv4Y9V8ms8siBvNriAjSv8Tlqen0fOliV5r2QUh5WiQmri
         HLrbpqyv4c12QntCJBT3g2pMT1vMoQQtQY2U8D1NXCone5EFoQQVJum0oYMFfeSqkrQQ
         qMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Tha4SCLFtH6xez0Na+RAXGz+tRUNF2zy2atRCPyb7yQ=;
        b=dN1T7ojMuoibKfUzEcRAW4fx2BNwkyHw8mFPNCgZDFUF054zS2esGaM+ZyU0bsq9Bm
         RDC5/yWuL/cDbs95ST76HoX+q2w1rHV+PtGhAkgkF734u3f4uLF36XdZcaLccMpMkWWn
         nx46PlK8l7WXJK54sZXJ5Z9cq4WM9Fkc0f2g6rzIHORoBWibfM2rgLX4SZmQcAIt7U0E
         LqEqflZ52yOG2CyKMrd29YlGtq1IrcpaXOcEsUpaXqL+vw1wiwLI+7HTtwOsMfcH609n
         eKx+RNaUYYH8l66VBFUlDv233IQ+SBEegK0qF0ppS2TmbghSdAJM63XZuJU+E3DlT0Po
         856g==
X-Gm-Message-State: ACrzQf36y4Vm8ojlCmEQi9cuEX6HmasqY59Mevoe/Um7gLBk1Jjg4cOQ
        apfxXY2TEameiEPWRoUeWu0JngLe9YNGyvYI+u6HMHDvVKHKdw==
X-Google-Smtp-Source: AMsMyM7MoZ4Pe/rm+LK2nkyXYFYoqdzWgBYKLKlu5r3EKojgiEGtFynj2o5FZ0/qZ+QeKjluuxX+Qsnp/wbbGIRZKpM=
X-Received: by 2002:ad4:5bee:0:b0:4ac:d9d2:d630 with SMTP id
 k14-20020ad45bee000000b004acd9d2d630mr9621148qvc.65.1663467297419; Sat, 17
 Sep 2022 19:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com> <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
 <CABPp-BF-z72=hY_Jf8h3g95s+wwZOsV_S=+dDNs_AVskQxoaTw@mail.gmail.com> <xmqqh719pcoo.fsf@gitster.g>
In-Reply-To: <xmqqh719pcoo.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 17 Sep 2022 19:14:46 -0700
Message-ID: <CABPp-BEOVGfgmAMGCjP6Q3k-t=C1tL=f27buhiCiL-Wv0eDF_A@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] builtin/grep.c: add --sparse option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2022 at 7:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > ... I think all those other commands probably deserve a mode where they
> > restrict output to the view associated with the user's cone.  I've
> > brought that up before[1].  I was skeptical of making it the default,
> > because it'd probably take a long time to implement it everywhere.
> > Slowly changing defaults of all commands over many git releases seems
> > like a poor strategy, but I'm afraid that's what it looks like we are
> > doing here.
> >
> > I'm also worried that slowly changing the defaults without a
> > high-level plan will lead to users struggling to figure out what
> > flag(s) to pass.  Are we going to be stuck in a situation where users
> > have to remember that for a dense search, they use one flag for `grep
> > --cached`, a different one for  `grep [REVISION]`, no flag is needed
> > for `diff [REVISION]`, but yet a different flag is needed for `git
> > log`?
>
> In short, the default should be "everywhere in tree, regardless of
> the current sparse-checkout settings", with commands opting into
> implementing "limit only to sparse-checkout settings" as an option,
> at least initially, with an eye to possibly flip the default later
> when all commands support that position but not before?
>
> I think that is a reasonable position to take.  I lean towards the
> default of limiting the operations to inside sparse cone(s) for all
> subcommands when all subcommands learn to be capable to do so, but I
> also agree that using that default for only for subcommands that
> have learned to do, which will happen over time, would be way too
> confusing for our users.
>
> By the way, I briefly wondered if "limit to sparse-checkout setting"
> can be done by introducing a fake "attribute" and using the "attr"
> pathspec magic, but it may probably be a bad match, and separate
> option would be more appropriate.
>
> >> Change the default behavior of 'git grep' to focus on the files within
> >> the sparse-checkout definition. To enable the previous behavior, add a
> >> '--sparse' option to 'git grep' that triggers the old behavior that
> >> inspects paths outside of the sparse-checkout definition when paired
> >> with the '--cached' option.
> >
> > I still think the flag name of `--sparse` is totally backwards and
> > highly confusing for the described behavior.
>
> Yeah, regardless of which between "--sparse" and "--no-sparse"
> should be the default, I am in 100% agreement that "--sparse"
> meaning "affect things both inside and outside the sparse cones" is
> totally backwards.
>
> How strongly ingrained is this UI mistake?  I have a feeling that
> this may be something we still can undo and redo relatively easily,
> i.e. "--sparse" may be that "limit to sparse-checkout setting"
> option, not "--no-sparse".

It's gotten into a few commands, but I agree it seems like something
we can still undo.

In fact, not all uses of `--sparse` are backwards; two commands (clone
& ls-files) use `--sparse` to mean limit to sparsity specification.
There are three commands that use `--sparse` in a potentially
confusing or backwards way, though one is new to this cycle and isn't
even documented.  In more detail...

== clone --sparse ==

For clone, `--sparse` definitely means limit to the sparsity patterns.
That's the meaning we want.

== ls-files --sparse ==

For ls-files, the meaning of `--sparse` is "do not recurse into sparse
directory entries in order to print the traditional ls-files output,
just print the sparse directory entry".  So, I'd say that also has the
meaning we want; it's for restricting rather than expanding.

This one is also interesting in that it is the only command in the
list about querying for information rather than modifying the
worktree/index, and is thus the best precedent for grep.

If grep behaved similarly to ls-files, it would suggest that
Shaoxuan's series should default to searching the whole index (the
opposite of what his current series does) and that --sparse would be
used to restrict to the sparsity patterns (also the opposite of the
meaning for his flag).

== add --sparse ==

For add, `--sparse` affects the behavior of untracked files.  Its
usage allows untracked files to be added to the index despite the file
normally being outside the sparsity patterns.  There are two ways for
users to view this:
  * The file added is now tracked, and is present (or "checked-out").
Thus, the new file is part of the user's "sparse checkout" now.
Perhaps the flag makes sense viewed from this light?  (I had actually
looked at it this way previously).
  * We used the `--sparse` flag to allow git-add to operate on
something outside of the normal sparsity patterns.  The flag is
backwards.

It might be worth noting that the reason this flag was added was that
users are likely to be surprised later when some other command runs
and causes the file to vanish when they update the working tree to
match the sparsity patterns.

== rm --sparse ==

For rm, `--sparse` allows files to be removed from the index despite
normally being outside the sparsity patterns.  There's also a couple
ways to view this:
  * Any file being removed is not going to be part of the sparse
checkout anymore.  Thus there is no meaning to `--sparse`, but git-add
used it as a safety check to avoid surprises by operating outside the
normal patterns so perhaps we re-use that?
  * We used the `--sparse` flag to allow rm to operate on something
outside the normal sparsity patterns.  The flag is backwards.

Much like add, it might be worth noting that this flag was added for
cases like `git rm '*.jpg'` -- users probably only want such
expressions to operate on their sparse-checkout and they could be
negatively surprised by also removing stuff elsewhere.

== mv --sparse ==

For mv, `--sparse` feels like it's stretching the logic used for
`git-add` and isn't so clear that it could make sense anymore.  The
connection might be that when it moves files outside the sparsity
specification, it actually leaves them materialized, so in that sense
you could argue the files are still part of the sparse checkout, but
I'd say we're stretching that a bit.

However, the `mv` changes were made earlier this same cycle and aren't
part of a release yet.  It doesn't feel like this should be setting a
precedent for how grep should behave.  Especially since it's a
modification command, and grep is a querying command; ls-files seems
like a better precedent.

Also, the `--sparse` flag was not documented for mv for whatever reason.

== Overall ==

For existing querying commands (just ls-files), `--sparse` already
means restrict to the sparse cone.  If we keep using the existing flag
names, grep should follow suit.

For existing modification commands already released (add, rm), the
fact that the command is modifying actually gives a different way to
interpret things such that it's not clear `--sparse` was even a
problem.  However, perhaps the name of the flag is bad just because
there are multiple ways to view it and those who view it one way will
see it as counter-intuitive.

== Flag rename? ==

There's another reason to potentially rename the flag.  We already
have `--sparse` and `--dense` flags for rev-list and friends.  So,
when we want to enable those other commands to restrict to the
sparsity patterns, we probably need a different name.  So, perhaps, we
should rename our `--sparse/--dense` to `--restrict/--no-restrict`.
Such a rename would also likely clear up the ambiguity about which way
to interpret the command for the add & rm commands (though it'd pick
the second one and suggest we were using the wrong name after all).

(There are also two other commands that use `--sparse` -- pack-objects
and show-branch, though in a much different way and neither would ever
be affected by our new --sparse/--dense/--restrict/--no-restrict
flags.)

Other names are also possible.  Any suggestions?

== global flag vs subcommand flags ==

Do we want to make --[no-]restrict a flag for each subcommand, or just
make it a global git flag?  I kind of think it'd make sense to do the
latter

== Defaults ==

As discussed before, we probably want querying commands (ls-files,
grep, log, etc.) to default to --no-restrict for now, since we are
otherwise slowly changing the defaults.  We may want to swap that
default in the future.

However, for modification commands, I think we want the default to be
--restrict, regardless of the default for querying commands.  There
are some potentially very negative surprises for users if we don't,
and those surprises will be delayed rather than occur at the time the
user runs the command.  In fact, those negative surprises are likely
why those commands were the first to gain an option controlling
whether they operated on paths outside the sparsity specification.
(Also, the modification commands print a warning if they could have
affected other files but didn't due the the default of restricting, so
I think we have their default correct, even if the flag name is
suboptimal.)
