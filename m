Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C25C433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 09:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8DB64EBD
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 09:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhBSJ3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 04:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhBSJ3B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 04:29:01 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9A3C061756
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 01:28:21 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id l192so2376072vsd.5
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 01:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVlGpIsi2SeudQXuK/OIEZKUxgqWTgGBzcEyqkcBq2w=;
        b=uO2jktxkjuzr9O4Y7ZtBwA68I6vpOjX2SInI2RzFyDesRRDnYx8Uz+D2+h+xThiz9p
         NWD6Y6GZ66hDBinTqgeoKzykgHrGQN7fJxmoIyU83FpWhLfpPleG7pW1SZehcB7zJEQh
         jR9+Hw5dZIS5i1GEK1+5g8ZedJXFy1JlN8l0e9YwQjevVZVw4flbR8Wb+JR6EjfH6TOe
         bxRWMdhIvryOMa5sXncYtsJVhRdri4DNHfYWBK9LeY0wPeS/0DbRAngLPph9G6i7yx3D
         DliEmFddOAnfAfbLcDAKWMagYlniH9awmSEFAnmgS7p3z7qsvaQYQE965Id/Wp9xZoUF
         y4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVlGpIsi2SeudQXuK/OIEZKUxgqWTgGBzcEyqkcBq2w=;
        b=DmPHKMIdGhjV0uaRAZ1FTM9iev1WLbpB7XXdzMPbarFZ9vlS6zcFqBTqPf4qQO2pWy
         u7vt19pJvIujti8cP/TqahaywjWyShKrm46IjXNP6Fh7oVuMZpw9SIHTAwqJMnJHu9h9
         kOiaP56Ft4cmGkE7Yfc5EXKAyT51iIivxOduujtoQnCCd7hWJF0vEAktl+bV9r3rybkD
         97NJlHt0dxRKvr6iT2ZNgtfEFqVT54J4qTORPRPa4v55E20X5qQUDN1Np43zn21H9N+F
         +PVZWOIMHQzsq0KhUAP4hyyTg4CEGi24nUFdrW9KQbjJiJPTigpot5tuwF/as/ecHfEz
         +SfA==
X-Gm-Message-State: AOAM530CIvMkV0V+aCozzSufhehoXWl0rXbFgLFOICGUqGDfM1lj9s+t
        HE9aD2Qhm53CbvhSsZGNmpbKREwoMkn+BJigG1M=
X-Google-Smtp-Source: ABdhPJzv/ejSr2g4dku14eI3ioqnc1Y83IhiR0RJUPYZ10xEJvsgPNSdmckSYM0ZWRRuuCs0ewUqbuvwki0Uw9EEsmc=
X-Received: by 2002:a67:ecd5:: with SMTP id i21mr6100910vsp.18.1613726900196;
 Fri, 19 Feb 2021 01:28:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.820.git.1608398598893.gitgitgadget@gmail.com> <xmqqy2htoen9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2htoen9.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 19 Feb 2021 01:28:11 -0800
Message-ID: <CA+P7+xrA1kCfJF1B13-yPKFgOKLQhcjQ+zJYpnqJuS5wOXk3wQ@mail.gmail.com>
Subject: Re: [PATCH] negative-refspec: fix segfault on : refspec
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 19, 2020 at 10:05 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Original author of the feature (Jacob) cc'ed for insight.
>

Hi,

Sorry I missed this thread last couple months.

>  - Can we have refspec->src==NULL in cases other than where
>    refspec->matching is true?  If not, then perhaps the patch should
>    insert, before the problematic "else if" clause, something like
>
>                 if (match_name_with_pattern(...))
>                         string_list_append_nodup(...);
>    +    } else if (refspec->matching) {
>    +            ... behaviour for the matching case ...
>    +    } else if (refspec->src == NULL) {
>    +            BUG("refspec->src cannot be null here");
>         } else {
>                 if (!strcmp(needle, refspec->src))
>
>  - We'd need to decide if ignoring is the right behaviour for the
>    matching refspec.  I do not recall what we decided the logic of
>    the function should be offhand.
>

Isn't this patch about how we somehow broke ":" on its own, not as a
negative refspec?
