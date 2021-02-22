Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22F8C433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 15:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6989F64E61
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 15:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhBVPMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhBVPMf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 10:12:35 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA39C061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 07:11:53 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id g6so8098999otk.11
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 07:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oGGu4R4I5CHB1ADKonZrxUyV6una2RNg+XtESW5hXmE=;
        b=hff3FkzMLMzkqqKxOa0o9dE/oWxyIwtn3S2oQ4KBmC5T6k37MrW8I6fi+2LFbBeGjT
         EASNouCkLjDIvI8Pa+cMrHc23fX1ItiuVxBVP2yDW4Nk6GIymbga4Aa5GtDtWyCSgDPQ
         zvzPWzpOQvVYa7haYtdwMg3Rr1W5VrYch/CfMDgjaGKDhBaLaBwKxFtUJvr9YK/D03k7
         nZHqNU4jEaymmk2jigsLx/mU4Oze0Y6VKqGcrWYFHO8ZtkaKGNdROjtl/31cc4721atJ
         9JlS1LK+/4hbqxNjQFW3JPpjAZGiGoLhVV3E6xGPOYDobwOVq+XupW3YVBilCNBbSNie
         CU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oGGu4R4I5CHB1ADKonZrxUyV6una2RNg+XtESW5hXmE=;
        b=b4pzHBlvjRrjPdZcPt4ehvGl0LTktgeRROghvRheeEPYH79FaY1uqCRTNtMpnZJBn0
         +2Di4LZ2WK/+X4i6xfVBceP1ZOLCSNDGtwb4BcQLDyi6czRwu4qZheTRy8PvOzLN+OOl
         PBg6oGizj4P5rXwcjSIztzSCQ9w3fOwrX1FAtN1yIxZcrd/xBN5+JeaOMTG0JwFjOr+Z
         OMxVkUXNuQfP3mdEQbN/ZM8c0hPi02NpmRK11xcH/BjDo3J1IySv01SJFG8U55256lzJ
         Gd9tirlpeZadJa6iLSNSjMd2wXPDUYppZiX9WDr6Ci8Dvr4FCc9UQxiKc7/JbdbIUVh8
         yDRA==
X-Gm-Message-State: AOAM531qLhOH4viMnr+96FoAIIVQp2jHkpg71HWOaL2BtixMM4vwveZP
        nYuS+QQYN4cbnStkcKVC9p0+37Xi/ElhtQcDk+A=
X-Google-Smtp-Source: ABdhPJxBLFzyNyQcNmCSszvBYQ+V9E400oAn+whGGG5juf6SLv5v/nKi92ZSRXdoqs4Aj5FPbaVz8fiY+ZKMdHflQEs=
X-Received: by 2002:a05:6830:1db3:: with SMTP id z19mr1928451oti.299.1614006713060;
 Mon, 22 Feb 2021 07:11:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.870.v5.git.1613480198.gitgitgadget@gmail.com> <pull.870.v6.git.1613739235241.gitgitgadget@gmail.com>
In-Reply-To: <pull.870.v6.git.1613739235241.gitgitgadget@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 22 Feb 2021 23:11:40 +0800
Message-ID: <CAOLTT8ST9_eazfsy+=j-t3bHuwhnsBhzXiQ4peC3RbLEK1CTxg@mail.gmail.com>
Subject: Re: [PATCH v6] difftool.c: learn a new way start at specified file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,Junio,

ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2021=E5=B9=B4=
2=E6=9C=8819=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:53=E5=86=99=E9=
=81=93=EF=BC=9A
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> `git difftool` only allow us to select file to view in turn.
> If there is a commit with many files and we exit in the middle,
> we will have to traverse list again to get the file diff which
> we want to see. Therefore,teach the command an option
> `--skip-to=3D<path>` to allow the user to say that diffs for earlier
> paths are not interesting (because they were already seen in an
> earlier session) and start this session with the named path.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     difftool.c: learn a new way start at specified file
>
>      * The patch of the previous version implemented the jump through
>        environment variables. The current version is based on the "diff
>        --skip-to=3D" feature implemented by gitster, which implements a
>        possible solution for the jump of difftool.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-870%2Fa=
dlternative%2Fdifftool_save_point-v6
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-870/adlter=
native/difftool_save_point-v6
> Pull-Request: https://github.com/gitgitgadget/git/pull/870
>
> Range-diff vs v5:
>
>  1:  fb4bfd0f8b16 < -:  ------------ diff: --{rotate,skip}-to=3D<path>
>  2:  98e2707ee2fa ! 1:  4377a917ca9e difftool.c: learn a new way start at=
 specified file
>      @@ Commit message
>           difftool.c: learn a new way start at specified file
>
>           `git difftool` only allow us to select file to view in turn.
>      -    If there is a commit with many files and we exit in the search,
>      -    We will have to traverse list again to get the file diff which
>      -    we want to see. Therefore, here is a new method: user can use
>      -    `git difftool --rotate-to=3D<filename>` or `git difftool --skip=
-to=3D<filename>`
>      -    to start viewing from the specified file, This will improve the
>      -    user experience.
>      -
>      -    `git difftool --rotate-to=3D<file>` or `git difftool --skip-to=
=3D<filename>`
>      -    will pass the path to `diffcore-rotate`, and diff-core will
>      -    adjust the order of files, make the specified file sorted to
>      -    the first.`git difftool --rotate-to=3D<file>` will move files b=
efore
>      -    the  specified path to the last output, and
>      -    `git difftool --skip-to=3D<filename>`  will ignore these files =
output.
>      -    It is an error when there is no patch for specified file is sho=
wn.
>      +    If there is a commit with many files and we exit in the middle,
>      +    we will have to traverse list again to get the file diff which
>      +    we want to see. Therefore,teach the command an option
>      +    `--skip-to=3D<path>` to allow the user to say that diffs for ea=
rlier
>      +    paths are not interesting (because they were already seen in an
>      +    earlier session) and start this session with the named path.
>
>           Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>
>      - ## Documentation/diff-options.txt ##
>      -@@ Documentation/diff-options.txt: components matches the pattern. =
 For example, the pattern "`foo*bar`"
>      - matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`=
".
>      -
>      - --skip-to=3D<file>::
>      ----rotate-to=3D<file::
>      -+--rotate-to=3D<file>::
>      -  Discard the files before the named <file> from the output
>      -  (i.e. 'skip to'), or move them to the end of the output
>      -  (i.e. 'rotate to').  These were invented primarily for use
>      -
>        ## Documentation/git-difftool.txt ##
>       @@ Documentation/git-difftool.txt: OPTIONS
>         This is the default behaviour; the option is provided to
>         override any configuration settings.
>
>       +--rotate-to=3D<file>::
>      -+ Internally call `git diff --rotate-to=3D<file>`,
>      -+ show the change in the specified path first.
>      -+ Files before the specified path will be moved to the last output.
>      ++ Start showing the diff for the given path,
>      ++ the paths before it will move to end and output.
>       +
>       +--skip-to=3D<file>::
>      -+ Internally call `git diff --skip-to=3D<file>`,
>      -+ skip the output to the specified path.
>      -+ Files before the specified path will not output.
>      ++ Start showing the diff for the given path, skipping all
>      ++ the paths before it.
>       +
>        -t <tool>::
>        --tool=3D<tool>::
>      @@ t/t7800-difftool.sh: test_expect_success 'difftool --gui, --tool =
and --extcmd ar
>       + 4
>       + 1
>       + EOF
>      -+ test_cmp output expect &&
>      -+ test_must_fail git difftool --no-prompt --extcmd=3Dcat --rotate-t=
o=3D"3" HEAD^
>      ++ test_cmp output expect
>       +'
>       +
>       +test_expect_success 'difftool --skip-to' '
>      @@ t/t7800-difftool.sh: test_expect_success 'difftool --gui, --tool =
and --extcmd ar
>       + 2
>       + 4
>       + EOF
>      -+ test_cmp output expect &&
>      -+ test_must_fail git difftool --no-prompt --extcmd=3Dcat --skip-to=
=3D"3" HEAD^
>      ++ test_cmp output expect
>       +'
>       +
>      ++test_expect_success 'difftool --rotate/skip-to error condition' '
>      ++ test_must_fail git difftool --no-prompt --extcmd=3Dcat --rotate-t=
o=3D"3" HEAD^ &&
>      ++ test_must_fail git difftool --no-prompt --extcmd=3Dcat --skip-to=
=3D"3" HEAD^
>      ++'
>        test_done
>
>
>  Documentation/git-difftool.txt |  8 ++++++++
>  t/t7800-difftool.sh            | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.=
txt
> index 484c485fd06c..143b0c49d739 100644
> --- a/Documentation/git-difftool.txt
> +++ b/Documentation/git-difftool.txt
> @@ -34,6 +34,14 @@ OPTIONS
>         This is the default behaviour; the option is provided to
>         override any configuration settings.
>
> +--rotate-to=3D<file>::
> +       Start showing the diff for the given path,
> +       the paths before it will move to end and output.
> +
> +--skip-to=3D<file>::
> +       Start showing the diff for the given path, skipping all
> +       the paths before it.
> +
>  -t <tool>::
>  --tool=3D<tool>::
>         Use the diff tool specified by <tool>.  Valid values include
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 9192c141ffc6..3e041e83aede 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -762,4 +762,36 @@ test_expect_success 'difftool --gui, --tool and --ex=
tcmd are mutually exclusive'
>         test_must_fail git difftool --gui --tool=3Dtest-tool --extcmd=3Dc=
at
>  '
>
> +test_expect_success 'difftool --rotate-to' '
> +       difftool_test_setup &&
> +       test_when_finished git reset --hard &&
> +       echo 1 >1 &&
> +       echo 2 >2 &&
> +       echo 4 >4 &&
> +       git add 1 2 4 &&
> +       git commit -a -m "124" &&
> +       git difftool --no-prompt --extcmd=3Dcat --rotate-to=3D"2" HEAD^ >=
output&&
> +       cat >expect <<-\EOF &&
> +       2
> +       4
> +       1
> +       EOF
> +       test_cmp output expect
> +'
> +
> +test_expect_success 'difftool --skip-to' '
> +       difftool_test_setup &&
> +       test_when_finished git reset --hard &&
> +       git difftool --no-prompt --extcmd=3Dcat --skip-to=3D"2" HEAD^ >ou=
tput &&
> +       cat >expect <<-\EOF &&
> +       2
> +       4
> +       EOF
> +       test_cmp output expect
> +'
> +
> +test_expect_success 'difftool --rotate/skip-to error condition' '
> +       test_must_fail git difftool --no-prompt --extcmd=3Dcat --rotate-t=
o=3D"3" HEAD^ &&
> +       test_must_fail git difftool --no-prompt --extcmd=3Dcat --skip-to=
=3D"3" HEAD^
> +'
>  test_done
>
> base-commit: 1eb4136ac2a24764257567b930535fcece01719f
> --
> gitgitgadget

A few days ago I successfully sent this patch with the help
of Denton Liu, I don't know if you see it?
Any reply is appreciated.

--
ZheNing Hu
