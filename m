Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2756DC4743E
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 21:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137F5613EA
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 21:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFDVLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 17:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhFDVLI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 17:11:08 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2065C0617A6
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 14:09:21 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id q10so6024262uam.3
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 14:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpZYgXOSCFkiMZYBoZ8CAVNYUhh/spPyTKD/lzfXQos=;
        b=p/pbe0cvMVqtKrEVFi5nSBobFElWg6BkvL8PzWk33ubHAKTF2w7LPjUkkx6AuOQ7OT
         A2wm749asuprNKdunsv+js0XK0jsmYM3aBHMGiFOowdTq19T/6wwn4pfm0sarJR6r7KA
         ral6zIItd4ltS5T5kJquSfn4+J8qYQII989wqxcWXESC6XC1i65vJuje+9idZavvjRU7
         y1MKsZu8TWB/Vlnfuzidi0GG6xp7SIRJQBTtrIDg3cOzr2XdTOxYDwznbvifk6YYpExa
         ICGLEzqqtZLUU2q3yxo8LtJvyUfOOplq6StipZGTD2YQ3czyRtujEaYENsMDn6ltjtUh
         Qo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpZYgXOSCFkiMZYBoZ8CAVNYUhh/spPyTKD/lzfXQos=;
        b=A9MY7bp/TxjxgYvaiRGp/yDSneBt9K+h/l+ByurO3sMpKW7ASf1HIEeiBbc90OqwBG
         vKdSbYCzAA2AmRqvUU54NsZRQobgQUWYDXOzghEwumY/2cVNaYK3WUPT1gdO+NyG+tlI
         5YuutWvuOZYBFJbpwL5Ex16fEqpwj/jm66ldzgiSRHMZireKVRydXPcrpN50OzReszwR
         LkMbZJod6L03h5WBb4JZs6Z7pXf8/bRBa3Gdg11Ir7sKbRcQb8V6gxKkalDzUVbu8K6o
         ZPBOGbJvxTytBHy4Wa3ZQ7Uk8JQ2PhFFfBMfwbdGYrWW8i6AOWSEwaC26w/YaPUkdLkR
         y3gw==
X-Gm-Message-State: AOAM5325EzxwvKm7h4LVMCux4obWSTIH9YEnr7REYEEJGL5fwRP2jLdm
        PpOF0J+2PvBv8qNOl693sR2kdmW/hsxODx9h+/Q=
X-Google-Smtp-Source: ABdhPJxvXSmOUdjOfCrpOAOkcRqy4Hjx6ahipUg+YpTTgwCoFcWtbB3tVSzpsNx6Fe+y48qGbbZzM25yJgeScvD3Kwo=
X-Received: by 2002:a9f:2c84:: with SMTP id w4mr5225820uaj.99.1622840959404;
 Fri, 04 Jun 2021 14:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.970.git.1622828605.gitgitgadget@gmail.com> <c3bf266cf03a9678933623b48927ee749956218d.1622828605.git.gitgitgadget@gmail.com>
In-Reply-To: <c3bf266cf03a9678933623b48927ee749956218d.1622828605.git.gitgitgadget@gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 5 Jun 2021 02:39:07 +0530
Message-ID: <CAKiG+9W8Da4bG87VjTKN6m=cX+v_x33YAw8p4MqCfmNinYt1XA@mail.gmail.com>
Subject: Re: [PATCH 2/3] cmake: create compile_commands.json by default
To:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 11:13 PM Matthew Rogers via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> A straightforward way to accomplish this is to make it as simple as
> possible is to enable the generation of the compile_commands.json file,
> which is supported by many tools such as: clang-tidy, clang-format,
> sourcetrail, etc.
>
> This does come with a small run-time overhead during the configuration
> step (~6 seconds on my machine):
>
>     Time to configure with CMAKE_EXPORT_COMPILE_COMMANDS=TRUE
>
>     real    1m9.840s
>     user    0m0.031s
>     sys     0m0.031s
>
>     Time to configure with CMAKE_EXPORT_COMPILE_COMMANDS=FALSE
>
>     real    1m3.195s
>     user    0m0.015s
>     sys     0m0.015s
>
> This seems like a small enough price to pay to make the project more
> accessible to newer users.  Additionally there are other large projects
> like llvm [2] which has had this enabled by default for >6 years at the
> time of this writing, and no real negative consequences that I can find
> with my search-skills.
>

The overhead is actually much smaller than that. In my system it is
less than 150ms.
The first configure takes this long because we generate command-list.h
and config-list.h.
This process is really slow under Windows.

Thank You,
Sibi Siddharthan
