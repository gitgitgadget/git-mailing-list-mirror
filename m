Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC1BC4321E
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386309AbiBHWZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387189AbiBHWGH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 17:06:07 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A186CC0612B8
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 14:06:06 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ka4so1573395ejc.11
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 14:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AT0VhNdJwXGEeWw5YH7wiEdOpcZwfO9O8TYYUDbPF08=;
        b=paDEB+t9Q/sllDFwqlOqE3GOHu/jqEwv09JCuiTSQslyJoZ02vKZFttT9inb90xdHb
         EYh5dfScIgVh6rbIktrxlYa7pWxPD1h+X/xO21lJtCKeQ4L9qt6+By90W3ua8asRBXGp
         N+x6eSOx2Wk9BQ3kHZMS6tNXwnHzGqMG0DRfXUpxB5yJnU1hKC+bT5rAvPE+tMo3H8YL
         SrIkvO2tC6PfbU+XabopYDATgSHWGUtzlPRAKfOOY9a4iJB+F3lxuyUwVsVFpUgKwYWZ
         Jegsl97pEEt9p/oEN1yJDGDXdbcBclDEBrgO3E/2W7XLIqTHX4a9rtaejrd3k9WCbuuY
         rZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AT0VhNdJwXGEeWw5YH7wiEdOpcZwfO9O8TYYUDbPF08=;
        b=ftYykClfjMM1t9mPrt5ZmmADUPeQnzG/iG1mLErBSqdMHmB8Nx0C0vqRD13rjPRn+2
         d39GuX1RQS+KcM0HEZ/Xl//30aTZ2vN46UkMQjfFeibhkA2PNZ73uco454iogXfE6WDp
         XKEpGCImlrC5jfu7B0WuGFtgucuiAxMLDhQGL27N0UilPebfS5vWEObb6dERp81Sq+v/
         Lnbt3V902A9wAbrWttVWujyWhTzBbhLOhiRh48S1t2FUz5a+PI3P5WI3Pfb23iDjE+l+
         JC5BWjSppIHfujDT4UcLrRyq9a2ZiKF2DwKELOu0oMv6FtcuptNXJJTP3yIenb5wrlzS
         eUew==
X-Gm-Message-State: AOAM531oXQwinjBiOZfuZTLBfswY1P2jvpf6QEHO1FUrKQFdmgmPQm2B
        DXX7bvRkx/yyYaKwnKv5NGccEclkPifc5YC5zOA=
X-Google-Smtp-Source: ABdhPJxGfOLLOrTTlN4YCY+bG1cC3+gbLoJi6D2q2T9APk48DTY+jjRQYefSew8pRxaXgbY8iUTPci2GkDOKP8J+jFc=
X-Received: by 2002:a17:907:1b0f:: with SMTP id mp15mr5332264ejc.493.1644357964934;
 Tue, 08 Feb 2022 14:06:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <93d19d85ee38f50019d5f05605ce7b5eca76cbd6.1643328752.git.gitgitgadget@gmail.com>
In-Reply-To: <93d19d85ee38f50019d5f05605ce7b5eca76cbd6.1643328752.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Feb 2022 14:05:53 -0800
Message-ID: <CABPp-BGk7-yRZddOWBq6FpZDr=nOKSbL7eyMJQnOycP9CFtRng@mail.gmail.com>
Subject: Re: [PATCH 01/11] bisect run: fix the error message
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 28, 2022 at 3:27 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell function
> in C, 2021-09-13), we ported the `bisect run` subcommand to C, including
> the part that prints out an error message when the implicit `git bisect
> bad` or `git bisect good` failed.
>
> However, the error message was supposed to print out whether the state
> was "good" or "bad", but used a bogus (because non-populated) `args`
> variable for it.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/bisect--helper.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 28a2e6a5750..4208206af07 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -1093,7 +1093,6 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
>  {
>         int res = BISECT_OK;
>         struct strbuf command = STRBUF_INIT;
> -       struct strvec args = STRVEC_INIT;
>         struct strvec run_args = STRVEC_INIT;
>         const char *new_state;
>         int temporary_stdout_fd, saved_stdout;
> @@ -1111,8 +1110,6 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
>         strvec_push(&run_args, command.buf);
>
>         while (1) {
> -               strvec_clear(&args);
> -
>                 printf(_("running %s\n"), command.buf);
>                 res = run_command_v_opt(run_args.v, RUN_USING_SHELL);
>
> @@ -1157,14 +1154,13 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
>                         printf(_("bisect found first bad commit"));
>                         res = BISECT_OK;
>                 } else if (res) {
> -                       error(_("bisect run failed: 'git bisect--helper --bisect-state"
> -                       " %s' exited with error code %d"), args.v[0], res);
> +                       error(_("bisect run failed: 'git bisect"
> +                       " %s' exited with error code %d"), new_state, res);
>                 } else {
>                         continue;
>                 }
>
>                 strbuf_release(&command);
> -               strvec_clear(&args);
>                 strvec_clear(&run_args);
>                 return res;
>         }
> --
> gitgitgadget

Good catch.  Looks like this printed "(null)" on glibc, and probably
crashed elsewhere.  Perhaps it'd help to add a test that would have
caught this with something like (I'm hoping gmail doesn't corrupt
this):

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 1be85d064e..28b54ba41b 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -980,4 +980,15 @@ test_expect_success 'bisect visualize with a
filename with dash and space' '
        git bisect visualize -p -- "-hello 2"
 '

+test_expect_success 'testing' '
+       git bisect reset &&
+       git bisect start $HASH4 $HASH1 &&
+       write_script test_script.sh <<-\EOF &&
+       rm .git/BISECT*
+       EOF
+       test_must_fail git bisect run ./test_script.sh 2>error &&
+       cat error &&
+       grep git.bisect.good..exited.with.error.code error
+'
+
 test_done


Also, as a side note, it appears that another error message in this
same function has a suboptimal error message, which could be fixed
with

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a575..6187d9fbcb 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1118,7 +1118,7 @@ static int bisect_run(struct bisect_terms
*terms, const char **argv, int argc)

                if (res < 0 || 128 <= res) {
                        error(_("bisect run failed: exit code %d from"
-                               " '%s' is < 0 or >= 128"), res, command.buf);
+                               " %s is < 0 or >= 128"), res, command.buf);
                        strbuf_release(&command);
                        return res;
                }

In particular, the line of code just above here:
      sq_quote_argv(&command, argv);
means that we get double single quotes without this fix, which looks
ugly.  Of course, this doesn't need to be included in your series, but
since you're cleaning up other error messages anyway, I thought I'd at
least mention it.
