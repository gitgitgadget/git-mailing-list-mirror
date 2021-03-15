Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13A6C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 10:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9992164E20
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 10:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhCOKOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 06:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhCOKON (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 06:14:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047DBC061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 03:14:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ox4so49537656ejb.11
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 03:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9R3mww1eOsmr/MKBS4c0sm9c2HZ/vh+2vJpoAUaHryk=;
        b=QPmoLFa3wQi6ppDEI+KyJEKbs/NHvsbRD7O/ZkKTZioAC/rCr6n3z8Z9Iz94OsAZIB
         oOQKBZpvR/f0EnjOd4UDw2VSjsxmPos263bRrH8DsHgoegaRUvo8K0ej50FqG8LJSV/E
         vuoOMuq81mH/kVKQ7/u4Whoi5wwIeID9fsksr+peVPATS+Nl/ZV+Zejc/071v5aHSoIe
         YN/IZp6Gz4D+kc72KLolDOBmPr3/xGpQSg2cFLdvcu+nK5eOz/SDLMm0C16EvFd3KeSD
         r82xdZ8KJD1s+/D9qp3mljH4Ol3wZDWtKfwltvBvjM1gFdPqyUCdak9ggwxEoNUPdDFG
         5yGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9R3mww1eOsmr/MKBS4c0sm9c2HZ/vh+2vJpoAUaHryk=;
        b=SGfYkz4YDWawpGNkMAtcO+b7fXm3qrXEN35Z3g6tNMfFHZr/5lfRxisq3W16DjEUtI
         EmRA5flQfzwENOTyDKxLw53we8kijVHIPm04xsuQJkckl4JXrVT3Gl1FSuH513FYUSQA
         2NFbuwv3hNOShkwe133Klx1sVwsYbZNdQYAyDqJfNQbb3da9snF1YmDmMw0TOxpA1qur
         z6CzeM3BJ2VOwFhYCpp8hJmuSW8TnzsD76gcOuQkpkyybzBvF/q2BHqeE2ZoT5wAFxpk
         7KSwgJb/9sY8qPFg7E5iMBhoQD59afEQwjXxzl/9DadHUbNp4XZLU2RRYn+QXwUqWPS+
         5YeA==
X-Gm-Message-State: AOAM531ZtsL/zHT/hG8S0zWPCi97/2iMSp1BRtW+9IdkCKsIRPZ89M4/
        DjewVBvPDkrcyBPNBKjlt1Kr6vn/0URz8esP0Xw=
X-Google-Smtp-Source: ABdhPJwvhdwC4ajfNJdJkORI+8zW854kpmZAzlN6u1r5Lhw7/r/a+fk1k0OZHKoa5zW9PP3bHjsO44Y2/9jRXc6qnZQ=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr22679640ejz.341.1615803251828;
 Mon, 15 Mar 2021 03:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v6.git.1615790151073.gitgitgadget@gmail.com> <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 15 Mar 2021 11:14:00 +0100
Message-ID: <CAP8UFD2CNAW4o8BF8NLA0pwWzNmBwZJAP7L5SGSib+LcVbSLBA@mail.gmail.com>
Subject: Re: [PATCH v7] [GSOC] commit: add --trailer option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 10:08 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:

>       + if (trailer_args.nr) {
>      -+         static struct child_process run_trailer = CHILD_PROCESS_INIT;
>      ++         struct child_process run_trailer = CHILD_PROCESS_INIT;
>       +
>       +         strvec_pushl(&run_trailer.args, "interpret-trailers",
>       +                      "--in-place", "--where=end", git_path_commit_editmsg(), NULL);

Actually I don't think "--where=end" should be used here. "end" is the
default for the "trailer.where" config variable, so by default if
nothing has been configured, it will work as if "--where=end" was
passed above.

If a user has configured "trailer.where" or trailer.<token>.where,
then this should be respected. And users should be able to override
such config variable using for example:

git -c trailer.where=start commit --trailer "Signed-off-by:C O Mitter
<committer@example.com>"
