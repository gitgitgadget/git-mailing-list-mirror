Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E69D21F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 18:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753969AbdKNSsH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 13:48:07 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:44920 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755397AbdKNSsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 13:48:05 -0500
Received: by mail-qt0-f174.google.com with SMTP id 8so27891904qtv.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 10:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wSluv/AM8DP53sxOvNn02LrDO9vK86GbXM0FKnri0YA=;
        b=oGXvsSaJFjtlaQKZm/dY5H0bID2E97kixpHgTTY34gTDz4NSXJTE+Jd0mnlh3G84+D
         19QV80KCrswCPDtgmLUX1Z9ziI+j+biW5pMcoeDpfmC4sljqNokHIEhVcehQcvZ6uDLD
         LhOy2GoznnVj1pmcmNqZ69QlySLSmeJTDNJoFZPQrfF0GCebEdavjxAGj57hfFpVoia2
         FAp8dGUfoGUPtM4nVzLT8TGE98aRvrGfe/JaIFiuT96gkuzG+LIziDY7yWQtBPp+qNLl
         jftgfaGZ6Nes17WVpBDfUoKcQGJQoP58EcDqEjaZwbalFBpEm31Ym+z+IA3T5beVKjyA
         9XSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wSluv/AM8DP53sxOvNn02LrDO9vK86GbXM0FKnri0YA=;
        b=Kvl+Rhp4vJDIRMHxDnz9VeCzL1CUbQzgXYPUP9dIAfjC4O5KtlrIVsBMzY8kQpOcvS
         sMEQsA+WDY9l4iUhH8Yly+4FiZoU6MEEPJzWgM4IhOWh7WoBeKFjXzBUC/B0FgfUFiEk
         GXNcFCV2/BeVEl2ftdvnhVgJp3H84B7UhxkJKG1vOqOoLGGhDBzUtTP2hlgZdIEzkRCg
         Q3jaQWg8yWnejQjmQe0usW20IuR8YNJEcBrBhZ/2ry5E4dRbhdAxgIm34AQAMdATL1kw
         OPmRjVVvC5eNrhJmXwizePlkosPRIxmVIvTXhMe0ZgJmLAZ2th38IiBlbIWXdCQJRCFT
         CoUw==
X-Gm-Message-State: AJaThX53nGPaFTT/PUjyrbxe+uyIYwbVFJUT4sMF3QIAP9kb6DWnXorp
        vbxcu6ozbfaQqVR1VxRzNy3lHwgc1MOkkt/9YWNRug==
X-Google-Smtp-Source: AGs4zMYLgzZ9wtWKm69hF/9WqseToZW/ZLAEKkA6ar8F/gGUdywPiUmU+hKf4/q1v4296bARoWOKDAb6Y7YpV54i+VM=
X-Received: by 10.200.54.86 with SMTP id n22mr20031449qtb.224.1510685284813;
 Tue, 14 Nov 2017 10:48:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Tue, 14 Nov 2017 10:48:04 -0800 (PST)
In-Reply-To: <20171114173124.25982-1-newren@gmail.com>
References: <ABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com>
 <20171114173124.25982-1-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Nov 2017 10:48:04 -0800
Message-ID: <CAGZ79kbdC8fYx503=YKBvEE62=T5WYST0QSNuQjPp5QG1cx1aw@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: Handle addition of submodule on our side
 of history
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>, real@ispras.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc =D0=95=D1=84=D0=B8=D0=BC=D0=BE=D0=B2 =D0=92=D0=B0=D1=81=D0=B8=D0=BB=D0=
=B8=D0=B9 <real@ispras.ru> who reported the issue at
https://public-inbox.org/git/743acc29-85bb-3773-b6a0-68d4a0b8fd63@ispras.ru=
/

On Tue, Nov 14, 2017 at 9:31 AM, Elijah Newren <newren@gmail.com> wrote:
> The code for a newly added path assumed that the path was a normal file,
> and thus checked for there being a directory still being in the way of
> the file.  Note that since unpack_trees() does path-in-the-way checks
> already, the only way for there to be a directory in the way at this
> point in the code, is if there is some kind of D/F conflict in the merge.
>
> For a submodule addition on HEAD's side of history, the submodule would
> have already been present.  This means that we do expect there to be a
> directory present but should not consider it to be "in the way"; instead,
> it's the expected submodule.  So, when there's a submodule addition from
> HEAD's side, don't bother checking the working copy for a directory in
> the way.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> This commit is based on top of sb/test-cherry-pick-submodule-getting-in-a=
-way.

Thanks for getting the discussion started here (and fixing the bug),
based on your input in
https://public-inbox.org/git/CABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRk=
bhJsw@mail.gmail.com/
I adapted the test case locally to have two tests one file/submodule
and a submodule/file conflict, after the setup which boroows a lot of
code from the
existing test, we'll have:

    test_expect_success 'unrelated submodule/file conflict is ignored' '
    (
        cd a_repo &&
       git checkout with_sub^0 &&
        git cherry-pick with_file^0
    )
    '

    test_expect_success 'unrelated file/submodule conflict is ignored' '
    (
        cd a_repo &&
        git checkout with_file^0 &&
        git cherry-pick with_sub^0
    )
    '

and the other case now fails. I'll take a look into that. I think we'd need=
 to
check either a_mode or b_mode to be a submodule depending on which side
the submodule occured.

So I'll build on top of this patch to fix the other way, too.

>
>  merge-recursive.c                | 5 +++--
>  t/t3512-cherry-pick-submodule.sh | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 1d3f8f0d22..9fb0b9f8fd 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1901,8 +1901,9 @@ static int process_entry(struct merge_options *o,
>                         oid =3D b_oid;
>                         conf =3D _("directory/file");
>                 }
> -               if (dir_in_way(path, !o->call_depth,
> -                              S_ISGITLINK(a_mode))) {
> +               if (dir_in_way(path,
> +                              !o->call_depth && !S_ISGITLINK(a_mode),
> +                              0)) {

The last flag is_empty_ok is ok to keep at 0, I think.

Thanks,
Stefan
