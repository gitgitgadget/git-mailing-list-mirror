Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D3AC433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 05:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiAVFVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 00:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiAVFVe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 00:21:34 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51775C06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 21:21:33 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id s13so5709936ejy.3
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 21:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1UxOilxMH55Qv1BgNYDfrUnxmgcPeIHqeghvWwN0S9M=;
        b=YkGmX8eK5NMYqncUCaPWVpC4hZ2GozVKQlMCTjGfChrOd8PAacM1dWPIyVW558m4ir
         xi3YsXRlE45LU4gbhPqCaq0AVfoz+9GKE1LTZphRQWuvD69i5bIZVnEtNJs6D7GQE/LR
         HU+jhROcB9KfpuoiFf4mrvcknhOXTNv3jxHuEVVC83AiYVRIqomM9pL3RKjiEZiO/PcS
         21rVH5Ja/uaIwCUdjK5myJyRTkUG2M6oDV3NziexZM2S+A37SaYdwzhyE1s6Cne/x1+f
         aZnNfR6URsRseaI7MvgV+7azpOn7tPiFcVIU2ER/5i0CwfEf4kS+Sdc1Z/vSaA4pfT89
         TTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1UxOilxMH55Qv1BgNYDfrUnxmgcPeIHqeghvWwN0S9M=;
        b=rOYKsNnwfrDDNQyaDMpTZ0v+eEF5R5K9vKduULEa7fH1/Ngtxq9T4DG2RYT6SScA2U
         6mD3ceKOMmNtgciXjmZm8Odt51L2XbI/Q/hzg3/LrYs6I3m2jj+LryBoW9CmGnBiQ5kh
         jItbzYyg1H8Yt79sip/rfIse5M1CSY+KBhTShTNMi4/aUbbCSDVXqiSxH0KpP0Pd0ARD
         6iep6RSBMdi2bQbfW8/Qm2yiLocOjJd2NHFtI1IQuxc5CVZakAK6T+dOx8GFv6/izGSw
         RP2CCoSDvBY3dhIKmPF1Pr1UU9pVTuyYkYaXWJTN3fb/raN7sPGtB5O95h+qWV41tOlZ
         ZSyw==
X-Gm-Message-State: AOAM531OfGQEORsZuX9JZAcxCqRwjPfMoo5MFa+aD9lrST1cPcxwNP5i
        iPvIyb7/HOwPMWpUbbbE2I18uSJM4aPe7eZEMug=
X-Google-Smtp-Source: ABdhPJyhPK2+Z6DrAy4NkoS3hcDOsOmde/MQSnFrSZDyt2puyooNS2lG1tgAdYf5JhQimQpGwKpcin9n2WKMcs1+uFg=
X-Received: by 2002:a17:906:dc8e:: with SMTP id cs14mr5550950ejc.269.1642828891579;
 Fri, 21 Jan 2022 21:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20220120185548.3648549-1-jonathantanmy@google.com>
 <20220121174441.3991963-1-jonathantanmy@google.com> <220121.8635lgkj17.gmgdl@evledraar.gmail.com>
In-Reply-To: <220121.8635lgkj17.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 21 Jan 2022 21:21:20 -0800
Message-ID: <CABPp-BHgRQ+qNvq19wsBsMCR+Cn7FS+0FMYXVyyzEAZTsg-wjA@mail.gmail.com>
Subject: Re: [PATCH v2] sparse-checkout: create leading directory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, jabolopes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 21, 2022 at 6:12 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Jan 21 2022, Jonathan Tan wrote:
>
...
> This partial application of the fix-up I suggested in
> https://lore.kernel.org/git/220120.86mtjqks1b.gmgdl@evledraar.gmail.com/
> leaves the now-unused "blank-template"

Good point; no need to remove something that isn't being created anymore.

>
> >  - added attribution to Jose Lopes for finding and making the first
> >    draft of this patch (after confirming with them)
> >
> > =C3=86var mentioned "git sparse-checkout add" but I think that that is =
a
> > different problem - in the "git sparse-checkout init" case, we could ge=
t
> > into this case with a template that does not have .git/info, but in the
> > "git sparse-checkout add" case, the user would have had to explicitly
> > remove the info directory. So I'll limit this patch to the "init" case,
> > for now.
...
>
> I agree that it's a slightly different problem, but I was just
> advocating for us testing what happened in these cases.
>
> The below fix-up does that.

Different problem...addressed with a "fix-up"?  Why would we squash
extra testing of a different problem into the same commit?  I think
it'd at least deserve its own commit message.

> I think we should use warning_errno() there
> instead of some specutalite "file may not exist", but with/without this
> patch these tests show that only the "init" case was broken.
>
> As a more general issue I don't understand why "add" and "init" need to
> be conceptually different operations. If what defines a sparse checkout
> is just that it has that file and the 2 default patterns, which unless
> I'm missing something is the case.
>
> Why isn't "add" merely an "init"
> that'll optimistically add whatever pattern you asked for, in addition
> to doing an "init" if you didn't already?
>
> Then "add" and "init" will share the same error recovery behavior, and
> you won't needlessly have to run "init/add x" just to start using
> sparse-checkout with a pattern of "x".

The high level idea you propose (" 'add' can initialize sparsity state
if not currently in a sparse checkout") could make sense.  It isn't
just a straightforward switchover with the various other config
settings and such, and would also necessitate adding additional
command line flags to the 'add' subcommand, but it could be done.
Didn't occur to me before; I'm not sure if such a change in UI would
be better or worse.  I'm inclined to leave it as it is, though,
especially since...

The low level idea you propose (sharing code down to error paths) does
not make sense in this particular case, for reasons that are rather
non-obvious.  In particular, we need to be careful to avoid sharing
some code with "init".  The "init" subcommand is deprecated as of
ba2f3f58ac ("git-sparse-checkout.txt: update to document
init/set/reapply changes", 2021-12-14).  I initially wanted to remove
the separate "init" codepath, and just forward "git sparse-checkout
init" calls over to the "git sparse-checkout set" codepath (the only
difference being that "init" always comes with an empty set of
directories/patterns).  However, "init" had some problematic behavior
that I didn't want to copy to "set".  I also didn't want to kill that
behavior in "init" for backwards compatibility reasons.  And, this
xfopen call was tied up in that tangle, which means that it will
definitely remain separate, and thus needs to be fixed in isolation.

> But I've never *actually* used this command, so maybe I'm just missing
> something obvious...
>
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout=
-builtin.sh
> index 3189d3da965..6b56d9d177f 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -80,11 +80,37 @@ test_expect_success 'git sparse-checkout init' '
>  '
>
>  test_expect_success 'git sparse-checkout init in empty repo' '
> -       test_when_finished rm -rf empty-repo blank-template &&
> +       test_when_finished rm -rf empty-repo &&

This hunk looks like a good fixup to Jonathan's patch.

>         git init --template=3D empty-repo &&
>         git -C empty-repo sparse-checkout init
>  '
>
> +test_expect_success 'git sparse-checkout add -- info/sparse-checkout mis=
sing' '
> +       test_when_finished "rm -rf empty" &&
> +       git init --template=3D empty &&
> +       git -C empty sparse-checkout init &&
> +       rm -rf empty/.git/info &&
> +
> +       cat >expect <<-\EOF &&
> +       fatal: unable to load existing sparse-checkout patterns
> +       EOF
> +       test_expect_code 128 git -C empty sparse-checkout add bar 2>actua=
l &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'git sparse-checkout list -- info/sparse-checkout mi=
ssing' '
> +       test_when_finished "rm -rf empty" &&
> +       git init --template=3D empty &&
> +       git -C empty sparse-checkout init &&
> +       rm -rf empty/.git/info &&
> +
> +       cat >expect <<-\EOF &&
> +       warning: this worktree is not sparse (sparse-checkout file may no=
t exist)
> +       EOF
> +       git -C empty sparse-checkout list 2>actual &&
> +       test_cmp expect actual
> +'
> +

So...you're trying to test what happens when a user intentionally
bricks their repository?

(Note that `sparse-checkout init` sets core.sparseCheckout=3Dtrue, as
explicitly documented.  core.sparseCheckout=3Dtrue instructs git to pay
attention to $GIT_DIR/info/sparse-checkout for every unpack_trees()
call that updates the working tree, which basically means nearly any
significant Git operation involving a worktree update now needs that
file in order to function.  So, your commands told Git that this
directory is mandatory, and then you nuked the directory.)

Now, if you could find a testcase based on `git worktree add ...`
(which doesn't create an "info" directory) and then triggers problems
somehow without the intentional bricking, then what you'd have would
be more in line with what Jonathan is addressing here, but as it
stands it's hard to even call your testcases related.  There may be
some merit to testing deliberately broken repositories, but I'm just
not sure if that's what you really intended and were suggesting.  Was
it?  Or am I just missing something here?
