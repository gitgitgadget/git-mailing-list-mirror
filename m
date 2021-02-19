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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9CBC433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 09:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9521F64EBF
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 09:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhBSJdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 04:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBSJdD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 04:33:03 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20319C061756
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 01:32:23 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id c44so1634197uad.12
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 01:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sSh3vJNcjBBW58FKLYtpeTM79ayrO/6Xa+k+h8qzF4=;
        b=t+RH1zccGsHK9o8pcPL/JFkpuvVPscP15PohhGbkjV5rcp4TzAuoE/CGLdX+Gyq6Bk
         vj29QLKb4bSjRSWzMGGvHKC9MfMyurgIZ3bzmUbLpcxoT2DJNDo/vXLqlYo7hEVumJrl
         UimJ1BJr3m7izj7zEC+CwJPk6ad+Y/6+ABGxG5kwAui9BPzbLri4JUwM0dM/urNUs1k5
         a1oun9NOI9gfH59tgUcDNNcwAUzjw66LYfq1/QvJb6tqtz1EbULwyDNQwS09OCSo2AK6
         tumro4cdE65Uo85KZuwE1xcrxUiLC/PVESuiVlOWoixyh8RQNH6Qxs42uJnODCVDNxXw
         ujmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sSh3vJNcjBBW58FKLYtpeTM79ayrO/6Xa+k+h8qzF4=;
        b=qlWUhmDsPLluKpGsZiP+oW+QiEQlJdUpd8qoTzhFfk3i5m5M8+b5x8bL+FPPTiRsEX
         6agO4aomQOL5MKUbGEC0QK0dI4tZuBWUlZ8goTHkoYeCRXgf7dTNe8yzXtn5WTWLbxbG
         +qumVMviIma0JsVj02MvQFaIDG4Tqi/Nh+8lNpm7wbAUGWHZoVAHskkvqVRHUNyin0Lh
         CmxTD/AMbz7r6LivZt3pbbPHXGl3PjOjE029WQkUv01dFxuOLwNb1h0fnA36z8T8/82U
         NqI0g855u05wltLx6DgyWfwGCNCDvuJLmU9yCqa2NYpwytf5VmM4Of1slu4yI2LegZ+l
         hpwQ==
X-Gm-Message-State: AOAM530wC9fLWFRWciFMbxJQ4Sbyv1J7f98PNwJBNXp6MDvZEkzVOy5f
        84gGzdl1xAooeEHUR2BWBdp+8HKarrvx35D1eYyWhaTj
X-Google-Smtp-Source: ABdhPJwVkXLiMB221rw71O6ax5DDYQikDOAh/7Ep9rLG7X/vol1k4uVESdp/RK3nE4S6b8/b7a5D6DcohnEEpgGTb5E=
X-Received: by 2002:ab0:274b:: with SMTP id c11mr6310592uap.53.1613727142300;
 Fri, 19 Feb 2021 01:32:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
 <pull.820.v5.git.1608609498.gitgitgadget@gmail.com> <48c79dc3d84f55dec4cd2199cc4152e146bee0ba.1608609498.git.gitgitgadget@gmail.com>
In-Reply-To: <48c79dc3d84f55dec4cd2199cc4152e146bee0ba.1608609498.git.gitgitgadget@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 19 Feb 2021 01:32:13 -0800
Message-ID: <CA+P7+xr7nZBdTgknjM_H34=q5qr3sfT=dJJkasm87h8=qkd9PQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] negative-refspec: fix segfault on : refspec
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 21, 2020 at 8:01 PM Nipunn Koorapati via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Nipunn Koorapati <nipunn@dropbox.com>
>
> The logic added to check for negative pathspec match by c0192df630
> (refspec: add support for negative refspecs, 2020-09-30) looks at
> refspec->src assuming it is never NULL, however when
> remote.origin.push is set to ":", then refspec->src is NULL,
> causing a segfault within strcmp.
>
> Tell git to handle matching refspec by adding the needle to the
> set of positively matched refspecs, since matching ":" refspecs
> match anything as src.
>

This seems like the right approach to me. Thanks for the fix, and the
tests so we don't break it on accident again in the future.

belated, but....

Reviewed-by: Jacob Keller <jacob.keller@gmail.com>

> Add test for matching refspec pushes fetch-negative-refspec
> both individually and in combination with a negative refspec.
>
> Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
> ---
>  remote.c                          | 10 ++++--
>  t/t5582-fetch-negative-refspec.sh | 51 +++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 3 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 8be67f0892b..4f1a4099f1a 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -751,9 +751,13 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
>
>                         if (match_name_with_pattern(key, needle, value, &expn_name))
>                                 string_list_append_nodup(&reversed, expn_name);
> -               } else {
> -                       if (!strcmp(needle, refspec->src))
> -                               string_list_append(&reversed, refspec->src);
> +               } else if (refspec->matching) {
> +                       /* For the special matching refspec, any query should match */
> +                       string_list_append(&reversed, needle);

Right, so we explicitly handle matching first...

> +               } else if (!refspec->src) {
> +                       BUG("refspec->src should not be null here");

and then carefully check to make sure we don't end up with a NULL src
for some other reason, and at least BUG() instead of just crashing.

This shouldn't be possible because when we build the refspec, src is
always not NULL unless in the case of matching. Ok.

> +               } else if (!strcmp(needle, refspec->src)) {
> +                       string_list_append(&reversed, refspec->src);
>                 }
>         }

Yep, this looks like the best approach to solving this.

>
> diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
> index 8c61e28fec8..2f3b064d0e7 100755
> --- a/t/t5582-fetch-negative-refspec.sh
> +++ b/t/t5582-fetch-negative-refspec.sh
> @@ -186,4 +186,55 @@ test_expect_success "fetch --prune with negative refspec" '
>         )
>  '
>
> +test_expect_success "push with matching : and negative refspec" '
> +       # Manually handle cleanup, since test_config is not
> +       # prepared to take arbitrary options like --add
> +       test_when_finished "test_unconfig -C two remote.one.push" &&
> +
> +       # For convenience, we use "master" to refer to the name of
> +       # the branch created by default in the following.
> +       #
> +       # Repositories two and one have branches other than "master"
> +       # but they have no overlap---"master" is the only one that
> +       # is shared between them.  And the master branch at two is
> +       # behind the master branch at one by one commit.
> +       git -C two config --add remote.one.push : &&
> +
> +       # A matching push tries to update master, fails due to non-ff
> +       test_must_fail git -C two push one &&
> +
> +       # "master" may actually not be "master"---find it out.
> +       current=$(git symbolic-ref HEAD) &&
> +
> +       # If master is in negative refspec, then the command will not attempt
> +       # to push and succeed.
> +       git -C two config --add remote.one.push "^$current" &&
> +
> +       # With "master" excluded, this push is a no-op.  Nothing gets
> +       # pushed and it succeeds.
> +       git -C two push -v one
> +'
> +
> +test_expect_success "push with matching +: and negative refspec" '
> +       test_when_finished "test_unconfig -C two remote.one.push" &&
> +
> +       # The same set-up as above, whose side-effect was a no-op.
> +       git -C two config --add remote.one.push +: &&
> +
> +       # The push refuses to update the "master" branch that is checked
> +       # out in the "one" repository, even when it is forced with +:
> +       test_must_fail git -C two push one &&
> +
> +       # "master" may actually not be "master"---find it out.
> +       current=$(git symbolic-ref HEAD) &&
> +
> +       # If master is in negative refspec, then the command will not attempt
> +       # to push and succeed
> +       git -C two config --add remote.one.push "^$current" &&
> +
> +       # With "master" excluded, this push is a no-op.  Nothing gets
> +       # pushed and it succeeds.
> +       git -C two push -v one
> +'
> +
>  test_done
> --
> gitgitgadget
>
