Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22F9C43603
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 05:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E62521655
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 05:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK6QVUcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfLUFDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 00:03:11 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42715 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLUFDL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 00:03:11 -0500
Received: by mail-ed1-f66.google.com with SMTP id e10so10523649edv.9
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 21:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HuOzOQQBCCxY1TGO27nkzfrchgzSxnoiPDRyPaA4/8g=;
        b=fK6QVUcCLKjzxhpV0dhXGkP7WrQ7N9eKCCXWxX2OqMU1c/6vMvVZ1SrlKK8pxSpRVW
         FOCR888/VJNmkzljDV6CAMUJ69sDSKs0Eigjx9sqKph6DFdAQcBBBUaeYFpiudSJejgd
         AsSVZNSv7aAqNau2XxTuHE9f9YXdHELrqdSbOr+QbcjxcVnF5vaNbR96tmPkyvH+jG9R
         tmzxO/QBXI9sdziDMTF1RgI1fTxubRkxmT1ywgGMCQY7LVFd7o+GEFCdGY4N7Fy9wLy5
         AW7wbvfM1R4vj12m/pEhwdOoWs91laKCcslQfDtN0phbPwdc5Mfcn0xwWadK35ZC+NhX
         pdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HuOzOQQBCCxY1TGO27nkzfrchgzSxnoiPDRyPaA4/8g=;
        b=XnzPaPkmrxMf7sc1wuaF4Fbdpsy1O313lAqGOj2f+wvl5hZfc9lYq/2s7Oa80JAaLw
         u9tWZRTg2bbkUizO2sfoGb6u2k9ny4LTykWmu0e4M4xTGnM3OX5yV+r3k/cfLh4C1VTZ
         XlrA94z1NwWslplzrElaN/mD1gyto2yQZX5p9H8UO4z9gSqkhRDQA9419NHCae5e1wAi
         pQuTpE6E7tnK6YBJdZ/VEoQ1kNHLi4vvQQUIA1UBPhC30a8Lq+AzSpcVW9QpUnn9MOtN
         idGWA2liZdtoI9aGiCudexWTIAPcwxLu6QNI6sRjSW41EdHUceKEJdggXfOX7wsBKrSS
         ADVw==
X-Gm-Message-State: APjAAAUEEfJnrgA9uujycZFehFXRqykxgvdeMBleZJ3h6kz15wsu+GOv
        n6XaDHTzAVGYqvPGgGxhuGQRDhfMDxctt4YHc3w=
X-Google-Smtp-Source: APXvYqw+szFvsVTbbZsvP1naMQpSNNDcNnzhewYmSpNwYSnJjyENB/e7oHDSwzLqBhGlrR0dy1lli5tHWamMSbwsi2k=
X-Received: by 2002:a17:906:5208:: with SMTP id g8mr20528829ejm.104.1576904588435;
 Fri, 20 Dec 2019 21:03:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.495.git.1576574242.gitgitgadget@gmail.com> <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
In-Reply-To: <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Sat, 21 Dec 2019 18:02:56 +1300
Message-ID: <CACg5j254YMCsWrLPxGXitFa-PKqyyxwdkn2Wmq-2r1FgLFN0Mg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] [Outreachy] commit: display advice hints when
 commit fails
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was brought to my attention that I should've elaborated in the
cover letter the difference between v1 and v2 and the reason behind
the change.
So I'll elaborate that here:

As pointed out by this review on v1
https://lore.kernel.org/git/xmqq36dgayma.fsf@gitster-ct.c.googlers.com/T/#m3adc84664e907bd8fcc13ac22c8702ae15925f8f

By default git honors the user's selection of displaying hints, but in
the specific case of using the editor to write
a commit message ea9882bfc4 wanted to turn it off temporarily because
while the editor is open and the commit
is in-progress, the user can't run these hints anyway
(list discussion for reference
https://lore.kernel.org/git/vpq4n9tghk5.fsf@anie.imag.fr/)

So it makes more sense to see the change made for this specific editor
case inside an if condition rather than
applying it to all the commit cases, and then flip it back once the
commit fails.

Please correct me if I'm wrong, but I think for the rest of the cases,
as long as there's no editor with status
displayed inside (hints displayed while commit in progress), there's
no need to turn off the hints.

Heba


On Thu, Dec 19, 2019 at 10:16 PM Heba Waly via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Display hints to the user when trying to commit without staging the modified
> files first (when advice.statusHints is set to true). Change the output of
> the unsuccessful commit from e.g:
>
>  . [...] . Changes not staged for commit: . modified: builtin/commit.c . .
> no changes added to commit
>
> to:
>
>  . [...] . Changes not staged for commit: . (use "git add ..." to update
> what will be committed) . (use "git checkout -- ..." to discard changes in
> working directory) . . modified: ../builtin/commit.c . . no changes added to
> commit (use "git add" and/or "git commit -a")
>
> In ea9882bfc4 (commit: disable status hints when writing to COMMIT_EDITMSG,
> 2013-09-12) the intent was to disable status hints when writing to
> COMMIT_EDITMSG, but in fact the implementation disabled status messages in
> more locations, e.g in case the commit wasn't successful, status hints will
> still be disabled and no hints will be displayed to the user although
> advice.statusHints is set to true.
>
> Signed-off-by: Heba Waly heba.waly@gmail.com [heba.waly@gmail.com]
>
> Heba Waly (1):
>   commit: display advice hints when commit fails
>
>  builtin/commit.c                          | 18 ++++++++++++------
>  t/t7500-commit-template-squash-signoff.sh |  9 +++++++++
>  2 files changed, 21 insertions(+), 6 deletions(-)
>
>
> base-commit: 12029dc57db23baef008e77db1909367599210ee
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-495%2FHebaWaly%2Fhints-for-unsuccessful-commit-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-495/HebaWaly/hints-for-unsuccessful-commit-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/495
>
> Range-diff vs v1:
>
>  1:  f23477c5a3 ! 1:  ebec237920 commit: display advice hints when commit fails
>      @@ -2,9 +2,9 @@
>
>           commit: display advice hints when commit fails
>
>      -    Display hints to the user when trying to commit without staging the modified
>      -    files first (when advice.statusHints is set to true). Change the output of the
>      -    unsuccessful commit from e.g:
>      +    Display hints to the user when trying to commit without staging the
>      +    modified files first (when advice.statusHints is set to true). Change
>      +    the output of the unsuccessful commit from e.g:
>
>             # [...]
>             # Changes not staged for commit:
>      @@ -19,16 +19,16 @@
>             #   (use "git add <file>..." to update what will be committed)
>             #   (use "git checkout -- <file>..." to discard changes in working directory)
>             #
>      -      #   modified:   ../builtin/commit.c
>      +      #   modified:   /builtin/commit.c
>             #
>             # no changes added to commit (use "git add" and/or "git commit -a")
>
>      -    In ea9882bfc4 (commit: disable status hints when writing to COMMIT_EDITMSG,
>      -    2013-09-12) the intent was to disable status hints when writing to
>      -    COMMIT_EDITMSG, but in fact the implementation disabled status messages in
>      -    more locations, e.g in case the commit wasn't successful, status hints
>      -    will still be disabled and no hints will be displayed to the user although
>      -    advice.statusHints is set to true.
>      +    In ea9882bfc4 (commit: disable status hints when writing to
>      +    COMMIT_EDITMSG, 2013-09-12) the intent was to disable status hints when
>      +    writing to COMMIT_EDITMSG, but in fact the implementation disabled
>      +    status messages in more locations, e.g in case the commit wasn't
>      +    successful, status hints will still be disabled and no hints will be
>      +    displayed to the user although advice.statusHints is set to true.
>
>           Signed-off-by: Heba Waly <heba.waly@gmail.com>
>
>      @@ -36,13 +36,44 @@
>        --- a/builtin/commit.c
>        +++ b/builtin/commit.c
>       @@
>      -   */
>      -  if (!committable && whence != FROM_MERGE && !allow_empty &&
>      -      !(amend && is_a_merge(current_head))) {
>      -+         s->hints = advice_status_hints;
>      -          s->display_comment_prefix = old_display_comment_prefix;
>      -          run_status(stdout, index_file, prefix, 0, s);
>      -          if (amend)
>      +  old_display_comment_prefix = s->display_comment_prefix;
>      +  s->display_comment_prefix = 1;
>      +
>      +- /*
>      +-  * Most hints are counter-productive when the commit has
>      +-  * already started.
>      +-  */
>      +- s->hints = 0;
>      +-
>      +  if (clean_message_contents)
>      +          strbuf_stripspace(&sb, 0);
>      +
>      +@@
>      +          int saved_color_setting;
>      +          struct ident_split ci, ai;
>      +
>      ++         /*
>      ++          * Most hints are counter-productive when displayed in
>      ++          * the commit message editor.
>      ++          */
>      ++         s->hints = 0;
>      ++
>      +          if (whence != FROM_COMMIT) {
>      +                  if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
>      +                          !merge_contains_scissors)
>      +@@
>      +          saved_color_setting = s->use_color;
>      +          s->use_color = 0;
>      +          committable = run_status(s->fp, index_file, prefix, 1, s);
>      ++         if(!committable)
>      ++                 /*
>      ++                  Status is to be printed to stdout, so hints will be useful to the
>      ++                  user. Reset s->hints to what the user configured
>      ++                  */
>      ++                 s->hints = advice_status_hints;
>      +          s->use_color = saved_color_setting;
>      +          string_list_clear(&s->change, 1);
>      +  } else {
>
>        diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
>        --- a/t/t7500-commit-template-squash-signoff.sh
>      @@ -56,7 +87,7 @@
>       + git add file &&
>       + git commit -m initial &&
>       + echo "changes" >>file &&
>      -+ test_must_fail git commit -m initial >actual &&
>      ++ test_must_fail git commit -m update >actual &&
>       + test_i18ngrep "no changes added to commit (use \"git add\" and/or \"git commit -a\")" actual
>       +'
>       +
>
> --
> gitgitgadget
