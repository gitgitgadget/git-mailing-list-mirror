Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4E5C433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 13:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiCLNd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 08:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiCLNd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 08:33:57 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B9A1B0
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 05:32:52 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id q194so9188693qke.5
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 05:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iwwEWk8sQFLH+NBMPHnTeH2UMs6qtgzBDEhWNgLZT1k=;
        b=kmzVhHaqSlnSm41Lgod1OfLJH1SjWFaXmyMF+hH+q5L3gcUZ53s/aD0Q2fJKM8lmOx
         YAzfv0QFgvcpczGlkl1/pkThY/GqbFmZcr1QHdMOEArdWrCmAly96Pr5kUO6xh01M1+E
         6lq4nXtuUCse2rfHPnpijB/Yd0Fgm84PIEXIa6eHy++ldIG7uuzZBNZxgdzQ9v+EiMjG
         Kkj841SFcotzFrRy8uoTR+Ib/MzYbeIXqam5NLtEnaqUYLwTcEgg/uZTuyo7eMzwi9L1
         YGikTXK9jH9bM7f9u143AApBYOPCNIjpV+rL6I/GYS1CDFZ2TwaiCnsLj21/zUFPs9Dp
         OajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iwwEWk8sQFLH+NBMPHnTeH2UMs6qtgzBDEhWNgLZT1k=;
        b=qyNQXrlp0OlGDmc68wUHXWae8STnD+dRRmgOVhesHau4VFXUfEHEFl85SR+lCGBzGt
         SJD94PgkKaY1KCYKzsolbas5AEj1HQjZL9+d+rEL2pfskLqCAvsTmXba0BMnupgOz7HF
         b0vGPHqraixxG/VQgGh9QggsRhBYo9G66uCgPE5SoeIMDQHF6iBJIEUVQbUNiRl2EeFf
         DD0UcFh/umCd2Zl82qSzO/EUNrBDMkI8yvTWkZ6szjCFWqa9cXB0wOf8VHHhi0jQNrbB
         K+iWW52blKSb6NnMudxQ6f4NeQsy6unBzYs3xBaD1iMDTXuGrlMIXYScEvDSoga2+zvc
         C0hA==
X-Gm-Message-State: AOAM53188RApXRWO9EGVLiELxy9qrrjiTME3WP8+UA5WjCZFSQ/OUkoS
        7/7e80NPZDjbGvsXfnf4+od9Gj+dAS0=
X-Google-Smtp-Source: ABdhPJxFWPDgPsf0fH4lF/kagMId7NI7+zn6LJGiv9RlBdBSvGspR3wGJyhypimBzWEIZbS19omzLg==
X-Received: by 2002:a05:620a:d87:b0:67b:f949:1ee6 with SMTP id q7-20020a05620a0d8700b0067bf9491ee6mr9848786qkl.140.1647091971440;
        Sat, 12 Mar 2022 05:32:51 -0800 (PST)
Received: from [10.37.129.2] ([204.148.24.254])
        by smtp.gmail.com with ESMTPSA id y24-20020a37e318000000b0067d43d76184sm4771692qki.97.2022.03.12.05.32.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Mar 2022 05:32:50 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Michael McClimon <michael@mcclimon.org>
Cc:     git@vger.kernel.org
Subject: Re: Bug with rebase and commit hashes
Date:   Sat, 12 Mar 2022 08:32:49 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <B91AE306-6836-47C1-AC99-B06A50BAF61A@gmail.com>
In-Reply-To: <YiwPJD39+/hnu36j@newk>
References: <YiokTm3GxIZQQUow@newk>
 <C92B297B-0634-40CC-B1C6-B2A7325BF7DA@gmail.com>
 <036EAEE4-D957-41F2-8B17-3AD7B2E49611@gmail.com> <YiwPJD39+/hnu36j@newk>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Michael!

On 11 Mar 2022, at 22:10, Michael McClimon wrote:

> Thanks both! I had a look at this on the couch this evening, and with t=
he
> caveat that I am not at all a C programmer, I think have a patch that f=
ixes
> it:
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index b29ad2b6..82fb5e2c 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -829,6 +829,8 @@ static int checkout_up_to_date(struct rebase_option=
s *options)
>         ropts.oid =3D &options->orig_head;
>         ropts.branch =3D options->head_name;
>         ropts.flags =3D RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> +       if (!ropts.branch)
> +               ropts.flags |=3D RESET_HEAD_DETACH;
>         ropts.head_msg =3D buf.buf;
>         if (reset_head(the_repository, &ropts) < 0)
>                 ret =3D error(_("could not switch to %s"), options->swi=
tch_to);
>

Thanks for looking into this yourself! I actually have a patch out alread=
y [1],
which is pretty similar to what you suggested.

1. https://lore.kernel.org/git/pull.1226.v2.git.git.1647019492.gitgitgadg=
et@gmail.com/
>
> I haven't yet run the entire test suite, but I did run all the t*-rebas=
e*
> tests, which passed, including Junio's up-thread here. If this seems no=
t
> totally off-base, then I'll actually read the "my first contribution" d=
ocs and
> send in a proper patch and whatnot.
>
> -- =

> Michael McClimon
> michael@mcclimon.org
