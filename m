Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2765FC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECDFD61041
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbhHaQQU convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 31 Aug 2021 12:16:20 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:45961 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbhHaQQT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 12:16:19 -0400
Received: by mail-ej1-f48.google.com with SMTP id e21so39939322ejz.12
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 09:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=od1tX/vzsJuUMwlNkGft5b/l9WYzhD5gOvdsw9CtxrU=;
        b=jw5rEB5RliHK+0RQ8pYLIIK2uAtikXDGB6Pxj3kNPq1jyA+SMio4GE31O/HKREdBXj
         EA3w5+i0UurvtKEZzQRtfj47rtaOWf23lBKl91kL6LicNdPminYFAy7E+rzEe3slGvv/
         vx7aAbQzcj9JpxsljZdXWy+sAv5XWfdzFa8atubW7ZurECL9n3Gv/eS5z3D7cuPi5yIo
         JK1iuD5Ufk3oXCJMCPPP/Pb8n+5LbHQDPzCXMgh2Ame8VFTM6Him3fKbGFOU9CVHNo6N
         76LusycmUH4tKD+p097TWZSEqYjPRso0MgGGy7uW9eQhasOOvD0LqGfz42UzKcItxDJA
         w6fw==
X-Gm-Message-State: AOAM5316ppSaNG0EqeOxUWP6ssrDhSkafQuuRYfb/XMSK0Ka8uFLd+0K
        YZE0a5bu0gDFBxCHAHWRhNU6FqSjXefuuko6a+Y=
X-Google-Smtp-Source: ABdhPJxt7SIda59N01LV2bkHlwt0Y4Sncw1JPClaOFscsBFOGFSQCiwFyR/ulDNXkT2l9WT8im8OSrirXIi5dUwSFXA=
X-Received: by 2002:a17:906:3ed2:: with SMTP id d18mr30395175ejj.311.1630426520546;
 Tue, 31 Aug 2021 09:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAO=eiXzPaRpEV_nsudvvCUbNab+oMxR8b9rsehjdyc4WMHe3OA@mail.gmail.com>
 <patch-1.1-27f00a664e6-20210831T143536Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-27f00a664e6-20210831T143536Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Aug 2021 12:15:04 -0400
Message-ID: <CAPig+cQ1V-sSZzrBwDWZYFEFJY-W8s1aq4igfhg9vPBNdLJusA@mail.gmail.com>
Subject: Re: [PATCH] gc: remove trailing dot from "gc.log" line
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jan Judas <snugar.i@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 10:37 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Remove the trailing dot from the warning we emit about gc.log. It's
> common for various terminal UX's to allow the user to select "words",
> and by including the trailing dot a user wanting to select the path to
> gc.log will need to manually remove the trailing dot.
>
> Such a user would also probably need to adjust the path if it e.g. had
> spaces in it, but this should address this very common case.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Suggested-by: Jan Judas <snugar.i@gmail.com>
> ---
> diff --git a/builtin/gc.c b/builtin/gc.c
> @@ -502,7 +502,7 @@ static int report_last_gc_error(void)
>                 warning(_("The last gc run reported the following. "
>                                "Please correct the root cause\n"
> -                              "and remove %s.\n"
> +                              "and remove %s\n"

Bikeshedding: Adding a colon after "remove" would give this a slightly
more grammatically-correct feel:

    Please correct the root cause
    and remove: /path/to/repo/.git/gc.log

>                                "Automatic cleanup will not be performed "
>                                "until the file is removed.\n\n"
>                                "%s"),

Even more bikeshedding:

    Please correct the root cause and remove
    /path/to/repo/.git/gc.log
    to allow automatic cleanup to resume.

or something.
