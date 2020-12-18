Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE83C2BBD4
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 15:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5741723A84
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 15:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgLRPhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 10:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLRPhd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 10:37:33 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53E7C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 07:36:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id 6so3812743ejz.5
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 07:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJPKGO0ClA7aj0FJzZIckGSDeHbeKe4pcsGF11Q4eKA=;
        b=CCD+Ge4BBSYoR002L1s4N4rDLqmXN2PN4QODsluXZaO0uBObZkttAKG8SQOJve+vFm
         5ftU7orbnifeklRpB77ISaYUTyyqc6d6hv9apwguXk3F0sfccF6g3OMCHjJxdLJOaXbs
         lX2q6fguKeonoxl6q304McagK1tJWPIoaKtzX3mbCtazbmxCK1vywSAEpr5jKoCB04G9
         bSKxYwBhE8ItegJ37YNqCT/tIbadA8RkKv0EQusFDIw1wqVfTakA9C6ypGXQer1x5G32
         XFFd7WAygolZfUiUpBBS845YbPXvYCmecUaO11+FNj6kpV+smFjVlQRVeODZHnwevJFc
         JD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJPKGO0ClA7aj0FJzZIckGSDeHbeKe4pcsGF11Q4eKA=;
        b=Vahg4PNZ07q+D5yB29T3+TvgVRY169ODV+tX7dXytg/2ndW8W6ERYoyWsUwZ/zBm/c
         0fdcvXJ2t442/k4ypsyv4+5o27Tmd0IkGYTASmLSrLgYDwvB0PSz5+SbiSb0U/FHH6Zy
         6rzXygDWSkOF9QLJjMMQyZZEn8RPKG3scVYylHLB7cXY9wn9j46DaaVhTeCERvJTYCsf
         14T11mKgGkPIAgKRSRnY6ZerZQ4kr2MWhzrS6xBLZk2nU3SGgNrHZyd5wqVaANmrbddn
         ljIR+rsvoic4xkKJwMcZOYume8RIwdref4zItkfJIC+kb8y7E206O32Ml0NUDF9jSPH/
         sQng==
X-Gm-Message-State: AOAM530eq5kTmdm7Mb4MtBVUN0BxuBD5crhHwOeOvMcXTz8HwA5ds/Qi
        O+g6eBVjP6MS2piKSk13GGZUkww4W1Y5tF8e0gjB7+s2DN4=
X-Google-Smtp-Source: ABdhPJwwYtakq4XYxsxSqn0PYPssDmG8G0fEJoPsSrSOC8dh2Vv1WimIBsDG7ebroWPzq5Cv3cUsTb9VSDeVbg7TdLM=
X-Received: by 2002:a17:906:ae0c:: with SMTP id le12mr4566785ejb.283.1608305811531;
 Fri, 18 Dec 2020 07:36:51 -0800 (PST)
MIME-Version: 1.0
References: <20201218151406.1193792-1-felipe.contreras@gmail.com>
In-Reply-To: <20201218151406.1193792-1-felipe.contreras@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 18 Dec 2020 16:36:40 +0100
Message-ID: <CAP8UFD0X5HR67T6msOhJwgAGKQfgW4JxH+pJprseBi9XAZ2rCw@mail.gmail.com>
Subject: Re: [PATCH] test: bisect-porcelain: fix location of files
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 4:14 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Commit ba7eafe146 (t6030: explicitly test for bisection cleanup,
> 2017-09-29) introduced checks for files in the $GIT_DIR directory, but
> that variable is not always defined, and in this test file it's not.
>
> Therefore these checks always passed regardless of the presence of these
> files (unless the user has some /BISECT_LOG file, for some reason).
>
> Let's check the files in the correct location.

This looks good to me, but...

> index 34099160ed..6d5440d704 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -926,14 +926,14 @@ test_expect_success 'git bisect reset cleans bisection state properly' '
>         git bisect bad $HASH4 &&

...if we wanted this kind of bug not to happen again, we could add a
test here, before `git bisect reset`, to check that here one of the
files below actually exists.

>         git bisect reset &&
>         test -z "$(git for-each-ref "refs/bisect/*")" &&
> -       test_path_is_missing "$GIT_DIR/BISECT_EXPECTED_REV" &&
> -       test_path_is_missing "$GIT_DIR/BISECT_ANCESTORS_OK" &&
> -       test_path_is_missing "$GIT_DIR/BISECT_LOG" &&
> -       test_path_is_missing "$GIT_DIR/BISECT_RUN" &&
> -       test_path_is_missing "$GIT_DIR/BISECT_TERMS" &&
> -       test_path_is_missing "$GIT_DIR/head-name" &&
> -       test_path_is_missing "$GIT_DIR/BISECT_HEAD" &&
> -       test_path_is_missing "$GIT_DIR/BISECT_START"
> +       test_path_is_missing ".git/BISECT_EXPECTED_REV" &&
> +       test_path_is_missing ".git/BISECT_ANCESTORS_OK" &&
> +       test_path_is_missing ".git/BISECT_LOG" &&
> +       test_path_is_missing ".git/BISECT_RUN" &&
> +       test_path_is_missing ".git/BISECT_TERMS" &&
> +       test_path_is_missing ".git/head-name" &&
> +       test_path_is_missing ".git/BISECT_HEAD" &&
> +       test_path_is_missing ".git/BISECT_START"
>  '

Thanks,
Christian.
