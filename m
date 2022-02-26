Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15205C433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 12:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiBZMKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 07:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiBZMKM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 07:10:12 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4711E403D6
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 04:09:38 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id r13so15778682ejd.5
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 04:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbIuuxVMbJjU+ErGkC/UeA5MOuiIqFq/o7eRywD86sc=;
        b=Xhi+NEg+xdHELcshIqYdcAobh4Wt1w1EuxCm0wTccgetripLNdWZOky9fSOPXtna/i
         giMz0TednB4svq0XicZBnHu44YfPjafUWTpphZc6Rg6yTJ7aDVWbwfkfr1guo4Yn4p6Q
         lhG3kZ4TtRPxMG2mfM/Pss6riPAzgssqz/Aj8BaLPidFdlh7/+rMegb00ectWlZ0te/f
         5ARLQxeeysFz44MCYLONocy0Ig5uEMcAPF8TLuqgr+RwcBgPkGryxSISnhPwdb2BSQkW
         KkDzpizh8V4yFsmaUJHmkkn491KGvDQjByHhfZirQ6CLUJhfLKypy2z6ckc+4em197NV
         qD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbIuuxVMbJjU+ErGkC/UeA5MOuiIqFq/o7eRywD86sc=;
        b=VsO2k5DtTVO7bdNmRA9F95AYpLjOAyCrHRr2fLOA4JJkpHycvrGEsqyzt9748QKz2O
         Mk0jkprfrv8/vm3TLY2k3sUzrU87QGzzn8Mx5YuY5T7IfEh202YRtKYTHeb9XqDnL230
         +9DD43Liwxzj8fl/6crLRBkNmaYkrVl7Rs4ceYBvozJ53Q/j2RsI9p8c4LzNQM4xDtOK
         q+GghCNN7Y0oeqQHmsQawIWkSvMUObliriAaI64QU3R79zXVaGcFHSijKszggpl+DkuI
         p+U8J/eucqTOOOA+Eb6neUllwWLkzhxkbZ9zMuN5KIV88HVC0rG0dlKLuAEeHHecB8cT
         ryGw==
X-Gm-Message-State: AOAM5303XUByoOMEFVU4X9GmqfZZHcYcTEkL7k793L/TBhOZBRpceBEJ
        2yy0JLhkhdipwnzg+3GoFcVr348oop+yDflD1XIf91j5uJzeBsxV
X-Google-Smtp-Source: ABdhPJwBHC3TX6WCJ0+vvXPwT+0apxPfNRpdHjQ30aymmb90Dt/GdlS4QsX9/yHiUc3zqxX6Rf/HBx4dHj0HEWsHYzU=
X-Received: by 2002:a17:907:334c:b0:6cd:76b7:3948 with SMTP id
 yr12-20020a170907334c00b006cd76b73948mr10134431ejb.55.1645877376593; Sat, 26
 Feb 2022 04:09:36 -0800 (PST)
MIME-Version: 1.0
References: <20220224054720.23996-1-shivam828787@gmail.com>
 <20220224054720.23996-3-shivam828787@gmail.com> <220224.86o82wab31.gmgdl@evledraar.gmail.com>
In-Reply-To: <220224.86o82wab31.gmgdl@evledraar.gmail.com>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Sat, 26 Feb 2022 17:39:22 +0530
Message-ID: <CAC316V4a37rsVpemARu17h2e0bj=ahsWOxjBEwO=BiWou+4aBw@mail.gmail.com>
Subject: Re: [PATCH 2/2] t0030-t0050: avoid pipes with Git on LHS
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for Reviewing.

> You're modifying some tests here that are using some old coding style,
> so maybe it's better to adjust it while we're at it?
>
> Also I think this would be a lot nicer with test_stdout_line_count and a
> helper to deal with that pritnf, e.g.:
>
>         diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
>         index ae1ca380c1a..d48a3579511 100755
>         --- a/t/t0030-stripspace.sh
>         +++ b/t/t0030-stripspace.sh
>         @@ -223,12 +223,15 @@ test_expect_success \
>              test_cmp expect actual
>          '
>
>         -test_expect_success \
>         -    'text without newline at end should end with newline' '
>         -    test $(printf "$ttt" | git stripspace | wc -l) -gt 0 &&
>         -    test $(printf "$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
>         -    test $(printf "$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
>         -    test $(printf "$ttt$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0
>         +printf_git_stripspace () {
>         +       printf "$1" | git stripspace
>         +}
>         +
>         +test_expect_success 'text without newline at end should end with newline' '
>         +       test_stdout_line_count -gt 0 printf_git_stripspace "$ttt" &&
>         +       test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt" &&
>         +       test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt" &&
>         +       test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt$ttt"
>          '
>
>          # text plus spaces at the end:
>

it makes sense to improve this code as we are touching it, this way
looks much better. I will implement it.


> This is not on you, but generally we don't pipe "grep" to >/dev/null,
> and just let the --verbose option do its work.
I don't think I understood this, I guess you are talking about the
"-v" flag that stands for invert match? I didn't find "--verbose" with
grep.
Please correct me if I am wrong.

> With/without that change you no longer need the () subshell here.
sure.

Thanks,
Shubham
