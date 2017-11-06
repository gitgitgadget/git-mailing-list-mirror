Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C1720A10
	for <e@80x24.org>; Mon,  6 Nov 2017 22:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbdKFWo5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 17:44:57 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:56097 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752473AbdKFWo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 17:44:56 -0500
Received: by mail-qk0-f173.google.com with SMTP id x195so7425343qkb.12
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 14:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PbhPxsLLjDEBkwi0yEpiYxyhieCY43w1Vr0issY7ThY=;
        b=nD4amkn/e6RuYC5bpMzBu2xM1xyHXub/H5YC1TKb15rdzVbzn8tGp5JDSM5+qRkCGd
         w6e7Koo+wkwmHTGAPysKaKmqueNQa5TLjwKvnSWXECqGPKU2O6T+vprrFHsaopEHjM+9
         XYIgvXVM6hGRxmzRo2z5htVT+//6OzBykV7GLhJIITjcZhdWt0hK09ymMfgT5XrysSZU
         rVBkzSwjTxFDEJi2XbNsKVcK9MSKLCuleD0onVm39zdJMd97JL/Yq9XgdhyOn3gDU7Ef
         JTB2ecMynV5iDSKioJpqRSVumy47CQeqHlrn5eyN581etk5Cl2hxFyOnmTuHwtLGuc+v
         aqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PbhPxsLLjDEBkwi0yEpiYxyhieCY43w1Vr0issY7ThY=;
        b=llc8d5TfU0jOISuP7j/AY6Cr9Tcw+whLzx7XMAvRS6UFmIkAvFwif0CHgBUPz/dAE1
         KkogaGaBCPwgflPrdU71jtzie3/jODuvjoMQhLGjA/KgnYCGPzslw2g5S7gTuOdWhzGx
         1NXo3JXjQd2HgbqA1TootnYDereOAbYHRaH0qIGhNkmp79zjhsEivld/FC48c+LelbTQ
         1pnEGt8BS+NRYk8M5soNfieYhY1tKlXy8rniE5FehaON/6gNKZqFXvRVMoCwiw88pB3S
         RyVKM0mSIOZBCP+9DtU40mCBSeQC0cnHeNMzk57UYVr+ZgHV5q3gLLpB+sHrO7YhIzNc
         auOA==
X-Gm-Message-State: AJaThX4BkunwM0Drnc2CieOcPe9174w2NPSKmAEUjsaiZIhYT4nMMlFs
        ZKQUEifI9y1znAIpNvRlyDoTww87PxhQMpryx0bEJg==
X-Google-Smtp-Source: ABhQp+TO+WfNJbISaHAJIG60WHs6mVdv9HjSSShmY8wMyFk1475sbc/cqy4AcaYzeXLbZkPpDSecn4+BrM1W6KzTERc=
X-Received: by 10.233.239.197 with SMTP id d188mr56060qkg.308.1510008295139;
 Mon, 06 Nov 2017 14:44:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 6 Nov 2017 14:44:54 -0800 (PST)
In-Reply-To: <20171106220819.178881-1-bmwill@google.com>
References: <CAGHpTB+jKiXr45tKVEVTtszN7OBTW7W_FqKu7aAjsB8Tmx9N3Q@mail.gmail.com>
 <20171106220819.178881-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Nov 2017 14:44:54 -0800
Message-ID: <CAGZ79kY5d3hhBCstY+UPpjhDbq=v_QXL+vtKz1fLdxo2Qhj5DA@mail.gmail.com>
Subject: Re: [PATCH] wt-status: actually ignore submodules when requested
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Orgad Shaneh <orgads@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 6, 2017 at 2:08 PM, Brandon Williams <bmwill@google.com> wrote:
> Since ff6f1f564 (submodule-config: lazy-load a repository's .gitmodules
> file, 2017-08-03) rebase interactive fails if there are any submodules
> with unstaged changes which have been configured with a value for
> 'submodule.<name>.ignore' in the repository's config.
>
> This is due to how configured values of 'submodule.<name>.ignore' are
> handled in addition to a change in how the submodule config is loaded.
> When the diff machinery hits a submodule (gitlink as well as a
> corresponding entry in the submodule subsystem) it will read the value
> of 'submodule.<name>.ignore' stored in the repository's config and if
> the config is present it will clear the 'IGNORE_SUBMODULES' (which is
> the flag explicitly requested by rebase interactive),
> 'IGNORE_UNTRACKED_IN_SUBMODULES', and 'IGNORE_DIRTY_SUBMODULES' diff
> flags and then set one of them based on the configured value.
>
> Historically this wasn't a problem because the submodule subsystem
> wasn't initialized because the .gitmodules file wasn't explicitly loaded
> by the rebase interactive command.  So when the diff machinery hit a
> submodule it would skip over reading any configured values of
> 'submodule.<name>.ignore'.
>
> In order to preserve the behavior of submodules being ignored by rebase
> interactive, also set the 'OVERRIDE_SUBMODULE_CONFIG' diff flag when
> submodules are requested to be ignored when checking for unstaged
> changes.
>
> Reported-by: Orgad Shaneh <orgads@gmail.com>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  t/t3426-rebase-submodule.sh | 16 ++++++++++++++++
>  wt-status.c                 |  4 +++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
> index ebf4f5e4b..760c872e2 100755
> --- a/t/t3426-rebase-submodule.sh
> +++ b/t/t3426-rebase-submodule.sh
> @@ -40,4 +40,20 @@ git_rebase_interactive () {
>
>  test_submodule_switch "git_rebase_interactive"
>
> +test_expect_success 'rebase interactive ignores modified submodules' '
> +       test_when_finished "rm -rf super sub" &&
> +       git init sub &&
> +       git -C sub commit --allow-empty -m "Initial commit" &&
> +       git init super &&
> +       git -C super submodule add ../sub &&
> +       git -C super config submodule.sub.ignore dirty &&
> +       > super/foo &&
> +       git -C super add foo &&
> +       git -C super commit -m "Initial commit" &&
> +       test_commit -C super a &&
> +       test_commit -C super b &&
> +       test_commit -C super/sub c &&
> +       git -C super rebase -i HEAD^^

The previous test `set_fake_editor` already, though I am unsure
about the current directory. It turns out that the setting of the fake
editor is done via environment variable using absolute path to
the generated `fake_editor.sh`, hence it works even when
invoking a rebase in another directory/repo. Spooky.

Also we do want to be able to skip previous tests,
which this might be a problem for. Can we have a 'setup'
that sets up the fake editor instead of repeating it here or
hoping the previous tests has run? (Calling for a refactoring
during a regression fix is bad taste, so maybe just take this
patch as is and put it to the #leftoverbits ?)

> +'
> +
>  test_done
> diff --git a/wt-status.c b/wt-status.c
> index 29bc64cc0..94e5ebaf8 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -2262,8 +2262,10 @@ int has_unstaged_changes(int ignore_submodules)
>         int result;
>
>         init_revisions(&rev_info, NULL);
> -       if (ignore_submodules)
> +       if (ignore_submodules) {
>                 DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
> +               DIFF_OPT_SET(&rev_info.diffopt, OVERRIDE_SUBMODULE_CONFIG);
> +       }

There are a couple of submodule related flags:

#define DIFF_OPT_IGNORE_SUBMODULES   (1 << 18)
...
#define DIFF_OPT_DIRTY_SUBMODULES    (1 << 24)
#define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
#define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
#define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)

We don't need to pay attention to 24,25,26 here, because
DIRTY_SUBMODULES and IGN_* are only used to specify further
interest, the generic INORE_SUBMODULES turns off any submodule
handling. (so if we were to turn them on as well, it would still be correct,
though it may have performance impact -- I shortly wondered if we'd rather
want to have a mask covering all submodule related flags, specifically
all flags invented in the future ;) )

The patch looks good to me (i.e. I am convinced by review it fixes the
regression), so maybe we can put the test refactor on top of it, which
then doesn't need fast-tracking down to the maintenance track?

Thanks,
Stefan
