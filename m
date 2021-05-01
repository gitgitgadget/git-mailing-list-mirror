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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E85C433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 17:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D4D610A6
	for <git@archiver.kernel.org>; Sat,  1 May 2021 17:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhEARJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 13:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhEARJf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 13:09:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4918CC06174A
        for <git@vger.kernel.org>; Sat,  1 May 2021 10:08:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gx5so1689516ejb.11
        for <git@vger.kernel.org>; Sat, 01 May 2021 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPfwIN6dkjRtdKYR9M1X3fBnrjO0G+uPStnM1xk8VBo=;
        b=M0z/9ZVzptBXLnorFRQtCu3gIQ/x3Dqb8T23VNKWqCKtFkbcbTN9NXg+I+h1nPh0TP
         XK9orkdhbTR+2b11O3aQzrpRfNB5D1kpNrtcyti1CD1loExt5UbImrNn0MDY4M7YF4Jn
         GzlX+LTIfzj6lp4bOjtTIdQtSb174/DWkhqCsp1RtkRlKGjWDczyWPLm5qgAzrAiGd3w
         gZDPDbUyff8Ccgipd0E5kRLYUAu/WVVJXOkL4pYSoUQKZUucjunQApZI/c6QB6ORvIH4
         dRaVQ7DOxipcFWMC+qIhmmuP0CjUT1xfL8HZpqREG/rfLU+gd//FDXLZnZvlSyOwY9TZ
         RVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPfwIN6dkjRtdKYR9M1X3fBnrjO0G+uPStnM1xk8VBo=;
        b=EVSPYJUY8EHNHHxVMvbL9ZEUiETns9BAet87CGKHCJtocpfyt1q3JFxn3MG6vMNVXL
         hSdJRTQJvIDSBlWLCUMIuq1VSL2Ovgzq7kg3RNvC0zXPUz+T7+KQ2XGOs94cjpmWcFvI
         PA9YzBr0K043raarY+B3Q4195OTLwD0jpcGaE8p9lvL5XGp9rk/btl0iYgfiTHbNCJ1d
         E1EXD+YAOdDY21jCOSn/HCseYjAC3aaE4F6ZCc5iTFSZ838YV1RBUCKj8NMZhMoB8AaJ
         UoYEiLP/DBbfD21ha3hoca2iVkp54H/CtzuZYfTmHV8zqoJ1eclyXuM5TNcVfJLosetz
         tV+w==
X-Gm-Message-State: AOAM531+qn9thJ5ACvvRVSLv/IRZvCo2B/UHgIt8x7fT4twZ688UdQp8
        1wO4QPAn+HitEwmcpWQFheSZAzgAcUSW5S/ehM9afwrXVlk=
X-Google-Smtp-Source: ABdhPJxoaG1Sex14JMVOyYqrjkvGrMT/08xxgOtUa3uYjoCbdA92Zbr9ia/mFc0rUN1CVojYWh7O6cwrPO3mEbd1Bm4=
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr9443410ejy.211.1619888923100;
 Sat, 01 May 2021 10:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619818517.git.matheus.bernardino@usp.br> <0fe1a5fabc8cb5f7c2421afaefae030d399d28ed.1619818517.git.matheus.bernardino@usp.br>
In-Reply-To: <0fe1a5fabc8cb5f7c2421afaefae030d399d28ed.1619818517.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 1 May 2021 19:08:32 +0200
Message-ID: <CAP8UFD1X6ZZXCMfEDfJDjr0mB2XwQAvuhTAT0beJka-QR2k6nQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] checkout-index: add parallel checkout support
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 11:40 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Note: previously, `checkout_all()` would not return on errors, but

s/Note: previously/Previously/

> instead call `exit()` with a non-zero code. However, it only did that
> after calling `checkout_entry()` for all index entries, thus not
> stopping on the first error, but attempting to write the maximum number
> of entries possible. In order to maintain this behavior we now propagate
> `checkout_all()`s error status to `cmd_checkout_index()`, so that it can
> call `run_parallel_checkout()` and attempt to write the queued entries
> before exiting with the error code.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>

> @@ -142,11 +143,7 @@ static void checkout_all(const char *prefix, int prefix_length)
>         }
>         if (last_ce && to_tempfile)
>                 write_tempfile_record(last_ce->name, prefix);
> -       if (errs)
> -               /* we have already done our error reporting.
> -                * exit with the same code as die().
> -                */
> -               exit(128);

So when there were errors in checkout_all(), we used to exit() with
error code 128 (same as die())...

> @@ -275,12 +277,16 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>                 strbuf_release(&buf);
>         }
>
> +       if (all)
> +               err |= checkout_all(prefix, prefix_length);
> +
> +       if (pc_workers > 1)
> +               err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
> +                                            NULL, NULL);
> +
>         if (err)
>                 return 1;

...but now it looks like we will exit with error code 1. I see that
you already answered this comment in the previous round of review, but
you didn't add the explanations to the commit message.
