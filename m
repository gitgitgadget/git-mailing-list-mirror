Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6173CC1B0D9
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA7523A53
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 13:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgLHNhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 08:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgLHNht (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 08:37:49 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E20C061749
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 05:37:09 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id h18so11812950otq.12
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 05:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=gif0OImoNkCtRT9QSIataqjGQCwmuLRPCSeR+o7P//k=;
        b=RFscXwE4cTJttTMZesRXnDIJau/N51PUFV6VW8xjQF3ytz2gG+iIL+3CeS6+CL64AD
         ML4ldi4EX+fHRLBgHECbnnlynvbFVcLheinJekl3VhQCwH6+oih0hayi99241pvVjKz4
         y3FOyZtT28n58e2tVycBR8lnzFw6B0f4Go88y2M0Y0U2K9g14eFLEpPctFPDI8pZo8wu
         I2tMEII/GlE3SVvoJSYvgVWbQSP1yiPm0zcyEc27nPm+5E2nS7iGXgxc85rCqPBCoPpz
         RhnI4fkTApz1ZSg3QGRNN9R4WvbgscHgTPi1mfShqUUy80PpvsZXnKolBsoSRzWwUqD2
         e5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=gif0OImoNkCtRT9QSIataqjGQCwmuLRPCSeR+o7P//k=;
        b=kQIbIzUs2hXscJTTKBC9Q0/FDVjkKNEb6Jr05ctvPA/KRjpNdSv9bQzjE6GYm529vm
         7mV+jBBD0cOdRm3l7NT0voN69mN2SnNlnnRbGpJo67u9rUNhMP/V+1WQfpJ5gYoHQqUS
         AUlKWObsh5BTJlQR4vZ3BsUzQzjGsmGiR8oTTXO+0v40xkbQ44mHc2bLCSG5hrzdUjjc
         5X+rU1QcSoVO0kstVIePMeYL53ECM2+NVsA8ONtSi4IH/pqAuI3cXkOcBJ2wOBqS6rYT
         z8gLDXGgRxElIOWffqAl+Zs2t120EBJUkAMWk+B7rFd0ZZ6gtogfMwG5ZtttUmBHiKkE
         maCQ==
X-Gm-Message-State: AOAM532iSoRcptYUTwT/mRb4c92S8pJMf5VzhAUpARf+6ppgqU1c0ftz
        A3OacOoL8HhWz63d/pwHoWwOrCq382JVgF0bsJH4/DdG/iM=
X-Google-Smtp-Source: ABdhPJxkxsSiBvQ5rziyAgr//h7PwZ53ZrzCw9vouq+d4mCDoPppzFLfclTBWFq4IWCvAEdyJi2EBpGp7zxunKQ/b/Y=
X-Received: by 2002:a05:6830:1581:: with SMTP id i1mr1415881otr.35.1607434628700;
 Tue, 08 Dec 2020 05:37:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com> <20201110083900.88161-1-sangunb09@gmail.com>
In-Reply-To: <20201110083900.88161-1-sangunb09@gmail.com>
From:   Sangeeta <sangunb09@gmail.com>
Date:   Tue, 8 Dec 2020 19:06:57 +0530
Message-ID: <CAHjREB7_BScE3zZVUZho4xi0OTdpsJTqLAbqhS0Tcd_xF6gqHA@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v7] diff: do not show submodule with untracked
 files as "-dirty"
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

In the "What's cooking in git.git" you mentioned that this patch is
left on doc update and some adjustments in "git status".

The above patch does adds the `ignore-submodule=none` as the default
behavior for git status and also adds documentation too.
Am I missing something?

Thanks and regards,
Sangeeta

Sangeeta

On Tue, Nov 10, 2020 at 2:09 PM Sangeeta Jain <sangunb09@gmail.com> wrote:
>
> Git diff reports a submodule directory as -dirty even when there are
> only untracked files in the submodule directory. This is inconsistent
> with what `git describe --dirty` says when run in the submodule
> directory in that state.
>
> Make `--ignore-submodules=untracked` the default for `git diff` when
> there is no configuration variable or command line option, so that the
> command would not give '-dirty' suffix to a submodule whose working
> tree has untracked files, to make it consistent with `git
> describe --dirty` that is run in the submodule working tree.
>
> And also make `--ignore-submodules=none` the default for `git status`
> so that the user doesn't end up deleting a submodule that has
> uncommitted (untracked) files.
>
> Signed-off-by: Sangeeta Jain <sangunb09@gmail.com>
> ---
>  Documentation/config/diff.txt                |  2 ++
>  diff.c                                       |  3 +++
>  diff.h                                       |  1 +
>  submodule.c                                  |  1 +
>  t/t3701-add-interactive.sh                   |  6 ++++++
>  t/t4027-diff-submodule.sh                    | 12 ++++++++++--
>  t/t4041-diff-submodule-option.sh             | 16 ++++++++--------
>  t/t4060-diff-submodule-option-diff-format.sh | 16 ++++++++--------
>  wt-status.c                                  |  4 +++-
>  9 files changed, 42 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
> index c3ae136eba..2d3331f55c 100644
> --- a/Documentation/config/diff.txt
> +++ b/Documentation/config/diff.txt
> @@ -85,6 +85,8 @@ diff.ignoreSubmodules::
>         and 'git status' when `status.submoduleSummary` is set unless it is
>         overridden by using the --ignore-submodules command-line option.
>         The 'git submodule' commands are not affected by this setting.
> +       By default this is set to untracked so that any untracked
> +       submodules are ignored.
>
>  diff.mnemonicPrefix::
>         If set, 'git diff' uses a prefix pair that is different from the
> diff --git a/diff.c b/diff.c
> index 2bb2f8f57e..5a80695da8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4585,6 +4585,9 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
>                 DIFF_XDL_SET(options, INDENT_HEURISTIC);
>
>         options->orderfile = diff_order_file_cfg;
> +
> +       if (!options->flags.ignore_submodule_set)
> +               options->flags.ignore_untracked_in_submodules = 1;
>
>         if (diff_no_prefix) {
>                 options->a_prefix = options->b_prefix = "";
> diff --git a/diff.h b/diff.h
> index 11de52e9e9..1e18e6b1c3 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -178,6 +178,7 @@ struct diff_flags {
>         unsigned diff_from_contents;
>         unsigned dirty_submodules;
>         unsigned ignore_untracked_in_submodules;
> +       unsigned ignore_submodule_set;
>         unsigned ignore_dirty_submodules;
>         unsigned override_submodule_config;
>         unsigned dirstat_by_line;
> diff --git a/submodule.c b/submodule.c
> index b3bb59f066..8f6227c993 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -420,6 +420,7 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
>  void handle_ignore_submodules_arg(struct diff_options *diffopt,
>                                   const char *arg)
>  {
> +       diffopt->flags.ignore_submodule_set = 1;
>         diffopt->flags.ignore_submodules = 0;
>         diffopt->flags.ignore_untracked_in_submodules = 0;
>         diffopt->flags.ignore_dirty_submodules = 0;
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index ca04fac417..9a2489cde0 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -765,6 +765,12 @@ test_expect_success 'setup different kinds of dirty submodules' '
>         cat >expected <<-\EOF &&
>         dirty-both-ways
>         dirty-head
> +       EOF
> +       test_cmp expected actual &&
> +       git -C for-submodules diff-files --name-only --ignore-submodules=none >actual &&
> +       cat >expected <<-\EOF &&
> +       dirty-both-ways
> +       dirty-head
>         dirty-otherwise
>         EOF
>         test_cmp expected actual &&
> diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
> index d7145ccca4..894a11b224 100755
> --- a/t/t4027-diff-submodule.sh
> +++ b/t/t4027-diff-submodule.sh
> @@ -93,6 +93,14 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked)' '
>         ) &&
>         git diff HEAD >actual &&
>         sed -e "1,/^@@/d" actual >actual.body &&
> +       expect_from_to >expect.body $subtip $subprev &&
> +       test_cmp expect.body actual.body
> +'
> +
> +test_expect_success 'git diff HEAD with dirty submodule (untracked) (none ignored)' '
> +       test_config diff.ignoreSubmodules none &&
> +       git diff HEAD >actual &&
> +       sed -e "1,/^@@/d" actual >actual.body &&
>         expect_from_to >expect.body $subtip $subprev-dirty &&
>         test_cmp expect.body actual.body
>  '
> @@ -168,13 +176,13 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
>                 git clean -qfdx &&
>                 >cruft
>         ) &&
> -       git diff HEAD >actual &&
> +       git diff --ignore-submodules=none HEAD >actual &&
>         sed -e "1,/^@@/d" actual >actual.body &&
>         expect_from_to >expect.body $subprev $subprev-dirty &&
>         test_cmp expect.body actual.body &&
>         git diff --ignore-submodules=all HEAD >actual2 &&
>         test_must_be_empty actual2 &&
> -       git diff --ignore-submodules=untracked HEAD >actual3 &&
> +       git diff HEAD >actual3 &&
>         test_must_be_empty actual3 &&
>         git diff --ignore-submodules=dirty HEAD >actual4 &&
>         test_must_be_empty actual4
> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index f852136585..b3a7b7acaa 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -262,7 +262,7 @@ test_expect_success 'submodule is up to date' '
>
>  test_expect_success 'submodule contains untracked content' '
>         echo new > sm1/new-file &&
> -       git diff-index -p --submodule=log HEAD >actual &&
> +       git diff-index -p --ignore-submodules=none --submodule=log HEAD >actual &&
>         cat >expected <<-EOF &&
>         Submodule sm1 contains untracked content
>         EOF
> @@ -270,7 +270,7 @@ test_expect_success 'submodule contains untracked content' '
>  '
>
>  test_expect_success 'submodule contains untracked content (untracked ignored)' '
> -       git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +       git diff-index -p --submodule=log HEAD >actual &&
>         test_must_be_empty actual
>  '
>
> @@ -286,7 +286,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
>
>  test_expect_success 'submodule contains untracked and modified content' '
>         echo new > sm1/foo6 &&
> -       git diff-index -p --submodule=log HEAD >actual &&
> +       git diff-index -p --ignore-submodules=none --submodule=log HEAD >actual &&
>         cat >expected <<-EOF &&
>         Submodule sm1 contains untracked content
>         Submodule sm1 contains modified content
> @@ -296,7 +296,7 @@ test_expect_success 'submodule contains untracked and modified content' '
>
>  test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
>         echo new > sm1/foo6 &&
> -       git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +       git diff-index -p --submodule=log HEAD >actual &&
>         cat >expected <<-EOF &&
>         Submodule sm1 contains modified content
>         EOF
> @@ -337,7 +337,7 @@ test_expect_success 'submodule is modified' '
>
>  test_expect_success 'modified submodule contains untracked content' '
>         echo new > sm1/new-file &&
> -       git diff-index -p --submodule=log HEAD >actual &&
> +       git diff-index -p  --ignore-submodules=none --submodule=log HEAD >actual &&
>         cat >expected <<-EOF &&
>         Submodule sm1 contains untracked content
>         Submodule sm1 $head6..$head8:
> @@ -347,7 +347,7 @@ test_expect_success 'modified submodule contains untracked content' '
>  '
>
>  test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
> -       git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +       git diff-index -p --submodule=log HEAD >actual &&
>         cat >expected <<-EOF &&
>         Submodule sm1 $head6..$head8:
>           > change
> @@ -371,7 +371,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
>
>  test_expect_success 'modified submodule contains untracked and modified content' '
>         echo modification >> sm1/foo6 &&
> -       git diff-index -p --submodule=log HEAD >actual &&
> +       git diff-index -p --ignore-submodules=none --submodule=log HEAD >actual &&
>         cat >expected <<-EOF &&
>         Submodule sm1 contains untracked content
>         Submodule sm1 contains modified content
> @@ -383,7 +383,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
>
>  test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
>         echo modification >> sm1/foo6 &&
> -       git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +       git diff-index -p --submodule=log HEAD >actual &&
>         cat >expected <<-EOF &&
>         Submodule sm1 contains modified content
>         Submodule sm1 $head6..$head8:
> diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
> index fc8229c726..dc7b242697 100755
> --- a/t/t4060-diff-submodule-option-diff-format.sh
> +++ b/t/t4060-diff-submodule-option-diff-format.sh
> @@ -409,7 +409,7 @@ test_expect_success 'submodule is up to date' '
>
>  test_expect_success 'submodule contains untracked content' '
>         echo new > sm1/new-file &&
> -       git diff-index -p --submodule=diff HEAD >actual &&
> +       git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>         cat >expected <<-EOF &&
>         Submodule sm1 contains untracked content
>         EOF
> @@ -417,7 +417,7 @@ test_expect_success 'submodule contains untracked content' '
>  '
>
>  test_expect_success 'submodule contains untracked content (untracked ignored)' '
> -       git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +       git diff-index -p --submodule=diff HEAD >actual &&
>         test_must_be_empty actual
>  '
>
> @@ -433,7 +433,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
>
>  test_expect_success 'submodule contains untracked and modified content' '
>         echo new > sm1/foo6 &&
> -       git diff-index -p --submodule=diff HEAD >actual &&
> +       git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>         cat >expected <<-EOF &&
>         Submodule sm1 contains untracked content
>         Submodule sm1 contains modified content
> @@ -451,7 +451,7 @@ test_expect_success 'submodule contains untracked and modified content' '
>  # NOT OK
>  test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
>         echo new > sm1/foo6 &&
> -       git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +       git diff-index -p --submodule=diff HEAD >actual &&
>         cat >expected <<-EOF &&
>         Submodule sm1 contains modified content
>         diff --git a/sm1/foo6 b/sm1/foo6
> @@ -512,7 +512,7 @@ test_expect_success 'submodule is modified' '
>
>  test_expect_success 'modified submodule contains untracked content' '
>         echo new > sm1/new-file &&
> -       git diff-index -p --submodule=diff HEAD >actual &&
> +       git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>         cat >expected <<-EOF &&
>         Submodule sm1 contains untracked content
>         Submodule sm1 $head7..$head8:
> @@ -528,7 +528,7 @@ test_expect_success 'modified submodule contains untracked content' '
>  '
>
>  test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
> -       git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +       git diff-index -p --submodule=diff HEAD >actual &&
>         cat >expected <<-EOF &&
>         Submodule sm1 $head7..$head8:
>         diff --git a/sm1/foo6 b/sm1/foo6
> @@ -564,7 +564,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
>
>  test_expect_success 'modified submodule contains untracked and modified content' '
>         echo modification >> sm1/foo6 &&
> -       git diff-index -p --submodule=diff HEAD >actual &&
> +       git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>         cat >expected <<-EOF &&
>         Submodule sm1 contains untracked content
>         Submodule sm1 contains modified content
> @@ -583,7 +583,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
>
>  test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
>         echo modification >> sm1/foo6 &&
> -       git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +       git diff-index -p --submodule=diff HEAD >actual &&
>         cat >expected <<-EOF &&
>         Submodule sm1 contains modified content
>         Submodule sm1 $head7..$head8:
> diff --git a/wt-status.c b/wt-status.c
> index 7074bbdd53..83d418647d 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -606,7 +606,9 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
>         if (s->ignore_submodule_arg) {
>                 rev.diffopt.flags.override_submodule_config = 1;
>                 handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
> -       }
> +       } else if (!rev.diffopt.flags.ignore_submodule_set &&
> +                       s->show_untracked_files != SHOW_NO_UNTRACKED_FILES)
> +               handle_ignore_submodules_arg(&rev.diffopt, "none");
>         rev.diffopt.format_callback = wt_status_collect_changed_cb;
>         rev.diffopt.format_callback_data = s;
>         rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
> --
> 2.21.1 (Apple Git-122.3)
>
