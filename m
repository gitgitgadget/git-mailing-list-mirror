Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58521C433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 03:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiAPD6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 22:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiAPD6q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 22:58:46 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DD1C061574
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 19:58:45 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id k15so50243622edk.13
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 19:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F6XMBpMsJm/VuTn+X6Gv64P2SiEMUSs1EAcn4h6yrfo=;
        b=FZTt1Q6+9RqvjlUTcfMGv+kwmyAI58Tiiy92A57srOPxnlB/kemMzgbyR1gG9N4LIk
         regn4FPR5eHH3lGBuDfYqFH0OaiKFTG/FYsRTL8cLO6Y/3UwukiXQLVddw19lFAU0t2k
         IMVHMl6dz9HxMqfGQmKH7khYODCLv+SnfJqcGhtEcrGWEv6vCUHwE+cC5m+s9iXa4JSi
         r2xodj7YU8r1YRs9W6Kp/JXRVr0Jd3qbEZWnmZSc8tarkqM2KrsF0adzMnzOVh1Sc4x6
         swJlDgBzQY7wNC8cYTXm+FR33An86sq8KOTKCDpX0WL1sZEr9lKrVt8YPEWsqAWOPO5s
         84Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F6XMBpMsJm/VuTn+X6Gv64P2SiEMUSs1EAcn4h6yrfo=;
        b=05FZJELL89bflYtCVjUMSkM3txJTKmtr0ICLqG1j9LlTEPbcjhFWOJ5XC6fg85EIp3
         Db0kHp4WcPALIe2037iiPCr9UxMXPmAoEQCarpc9O/hDKe5Be8um4oSpYLdDfOzV90e7
         ExodLqDk/PgxX5zHKJFYz49nyjAWf6W2twE6aDdT7SH6VBLDTzz/8kdtUnYjfx9mZKLh
         MXiHXyjHBhn27IhZ+Tu6uXleeccRiqZRpWqLP5Axy/XtNvDm0YIhvqiy+y3VojVJDxb6
         SNdr3yezHNacGQosP0c28/UF+AKMyMvbZ/7gkhbYGpvrf/e2GfzPWv1b4lxSGzlN6Brf
         fPKg==
X-Gm-Message-State: AOAM530IXvlzXlVtloigdBrZ1/W0rMJRBKfcRo4XdgImq86OIHgsU/P0
        W3ORcB/51mFZbNyNutzbtSD4s4xXMFshOVwbMJqOQLwRK3Wfaw==
X-Google-Smtp-Source: ABdhPJxFWaMvOm3ocAjHcms4pCw+D/HGSTJsL+msEkm60H5KJECGUaQ/NDPydReUAmm8PzwICVZJD0cLdD8OIn3cBv8=
X-Received: by 2002:a17:907:2da3:: with SMTP id gt35mr12562948ejc.493.1642305523919;
 Sat, 15 Jan 2022 19:58:43 -0800 (PST)
MIME-Version: 1.0
References: <7ed402e0-63cd-2875-b3ac-71c967ccf80a@kdbg.org>
In-Reply-To: <7ed402e0-63cd-2875-b3ac-71c967ccf80a@kdbg.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Jan 2022 19:58:32 -0800
Message-ID: <CABPp-BF_fEN+2Q9kbSgc4mw3Ni4wPKDRut+MmWS3XpK-QtWtBQ@mail.gmail.com>
Subject: Re: Test failure on Windows in t3705-add-sparse-checkout.sh
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 14, 2022 at 12:30 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Hi Stolee,
>
> is there a reason we don't do this in the test case that you added in
> 63b60b3add75 ("add: update --chmod to skip sparse paths", 2021-09-24).
> Notice that the similar git add earlier also sets core.autocrlf. As the
> comment indicates, stderr indeed contains a warning about LF->CRLF
> conversion in my Windows build and fails test_must_be_empty.
>
> diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
> index 81f3384eee..4fb663e3b4 100755
> --- a/t/t3705-add-sparse-checkout.sh
> +++ b/t/t3705-add-sparse-checkout.sh
> @@ -181,13 +181,13 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
>         # Avoid munging CRLFs to avoid an error message
>         git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
>         test_must_be_empty stderr &&
>         git ls-files --stage >actual &&
>         grep "^100644 .*sparse_entry\$" actual &&
>
> -       git add --sparse --chmod=+x sparse_entry 2>stderr &&
> +       git -c core.autocrlf=input add --sparse --chmod=+x sparse_entry 2>stderr &&
>         test_must_be_empty stderr &&
>         git ls-files --stage >actual &&
>         grep "^100755 .*sparse_entry\$" actual &&
>
>         git reset &&

Is this an alternative fix for the same failure I was seeing in t3705
and which I was confused why I had to add to my series over at
https://lore.kernel.org/git/11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com/
?
