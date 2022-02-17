Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF44C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 16:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbiBQQOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:14:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbiBQQOe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 11:14:34 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8204E16A5B2
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 08:14:19 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id g20so6789436vsb.9
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 08:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ctLlRRyXqq9/tSXhvM8ia/jkpwBTWvCfBRhsV1B76es=;
        b=TdvdSxxYrC7cyMCt1BjSuivvUl6BgedXX/Mx4qys6RcGkeQVZShUh7rp9QPnzdpb9+
         lbFYvu+Wjc2fBW0tL2Hy7fXWk8IuXX9KDHG6ee9q8RwwWEreOqMH748ayQOmOGEOzsus
         hTGznE+J4NTR2l9/inCFvDvKcy/+TonZgvuURb4rd8scuECQu95DlvZFDWQbhzuynkKd
         CgWw/r1g5tA5LQEXGFWPqEpYFS/MJlsAda+TXMafgKVcAyTWcpciRoVx10LaMUmDykYg
         7qzukqOFJ+vqh0cEoAf3CejErD3KZWv3UkAJde49hi7GJVVLsb2v9DCXbDLFxwYbnWOI
         C2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctLlRRyXqq9/tSXhvM8ia/jkpwBTWvCfBRhsV1B76es=;
        b=Ffbb5ogVhBfYtrgqtzH0RvLFiL+sP+xhYdXo8BL7MLB0FlK1bpX8lUEhFKKqfxWyJZ
         Reie/GZ8f6bZK6W7zVIy6gbZNbPZx4IxjiwsPYnqCtT4vVM2d8eH0nn5eS6JHQeWv81v
         8EeytZvUEUKzFevLM4qr8ntGEUPvKHK6x5UkKGh46KP1qU9rDfRH7g6teovN2wgWlgDm
         GaARryJVnRC4gW1FieXruBKmLAXXgxUeySEezOtGNuV6hZdJ7zSLx+bXCoRxdVSw+c92
         SVR0ZmuGoifKVh8+WgNzPz5NlC+WkUR8SO7KUKhO74WBOqZ4Dt9ek8wO5fvoOjiT6CU7
         WrNA==
X-Gm-Message-State: AOAM530EPnoHICyLscPJpH2jli26xsu1wePfU81uAQ+PvuYh53Q8QOk8
        MC5wDFn9clQqWoydqC0c+bBqzXyq8Y2Pk92W4eRPx/PcUCWbA3db
X-Google-Smtp-Source: ABdhPJx9MsT7bI+8Gyjx0qZxcCSk36eopF1KMbBKDmvRueqJXUkq/1PDG+0EhlHNm7AdDxQS9N4lnrm44sW4V9Qdn7U=
X-Received: by 2002:a67:e14d:0:b0:31b:9356:40ff with SMTP id
 o13-20020a67e14d000000b0031b935640ffmr1525325vsl.51.1645114458579; Thu, 17
 Feb 2022 08:14:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com> <d76faa1f16e8b5f8eb13284fdb162525fcbcb22e.1644372606.git.gitgitgadget@gmail.com>
In-Reply-To: <d76faa1f16e8b5f8eb13284fdb162525fcbcb22e.1644372606.git.gitgitgadget@gmail.com>
From:   Robert Coup <robert.coup@koordinates.com>
Date:   Thu, 17 Feb 2022 16:14:02 +0000
Message-ID: <CAFLLRp+9TmMKu5UpaN4sUr+o_9AGAVvtis0e87VMJsCva67q3w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] tests for repack --filter mode
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

Minor, but should we use oid rather than sha1 in the list.sh/upload.sh
scripts? wrt sha256 slowly coming along the pipe.

> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index e489869dd94..78cc1858cb6 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -237,6 +237,26 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
>         test_must_be_empty actual
>  '
>
> +test_expect_success 'repack with filter does not fetch from remote' '
> +       rm -rf server client &&
> +       test_create_repo server &&
> +       git -C server config uploadpack.allowFilter true &&
> +       git -C server config uploadpack.allowAnySHA1InWant true &&
> +       echo content1 >server/file1 &&
> +       git -C server add file1 &&
> +       git -C server commit -m initial_commit &&
> +       expected="?$(git -C server rev-parse :file1)" &&
> +       git clone --bare --no-local server client &&
> +       git -C client config remote.origin.promisor true &&
> +       git -C client -c repack.writebitmaps=false repack -a -d --filter=blob:none &&

Does writing bitmaps have any effect/interaction here?

> +       git -C client rev-list --objects --all --missing=print >objects &&
> +       grep "$expected" objects &&

This is testing the object that was cloned initially is gone after the
repack, ok.

> +       git -C client repack -a -d &&
> +       expected="$(git -C server rev-parse :file1)" &&
> +       git -C client rev-list --objects --all --missing=print >objects &&
> +       grep "$expected" objects

But I'm not sure what you're testing here? A repack wouldn't fetch
missing objects for a promisor pack anyway... and because there's no
'^' in the pattern the grep will succeed regardless of whether the
object is missing/present.

Rob :)
