Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F16C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 22:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B83161CBE
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 22:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhGGW2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 18:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGGW2r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 18:28:47 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D840C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 15:26:07 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id b2so5329638oiy.6
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 15:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mfdzF3broLTfp4rwHezuRBPLr6x3qRwYxPnys5H4ek=;
        b=hN5h/P5llT4X8LvqZgHe8eHqBPRb+5TOgYy3errXyBWuPJMNfYLHfJKRgx1zZ23K2P
         WrPElLsHTKkkh9bbj9XRyzBFpRZilZoUgU/Qp5i441z50SHIrcX87q+ipLb8XynlNdrK
         fojBlTcJ8FNBjPF72DRoiZFcGOO2fRGecf2F5P7L+NdwHKq/7U8qQfsqNwoxmK82lDqY
         GMIopvZQpjbSoq3FfIpbKxwMjeGiH23j3lDFsO5c8BSt6Sfq3p8M479GMu75+5HikBS+
         H/3ENpEA7bkyKmZpcqp+cFPjVuUHE6Ku6Oh7lMaGsFk693FbQNmVQpGf6nCB3bdASJ6+
         ZBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mfdzF3broLTfp4rwHezuRBPLr6x3qRwYxPnys5H4ek=;
        b=nI83GlSLRqxnFvgepXnToklzCUZzkQzsmGJo6n/al2QCjxfMc0TNgrlq2uQJlcr8Ua
         Mue2Sut3CT3qBRBV4muELjhVihShxoYMEKnbEOi+6rita7/hLW3OZxS+qTHHJUArTQHT
         Fe+tDPzwtK4xREDYubZnAbIbiib2Jo0iPBQSIAdP+2jFjw61vi4vst89m9T2SDnTAvwG
         Q9v7kuMDdem2fp2EcEHftf/PVBzYOuLDm9l82kcV06mQUPxjjawn3lIwZsbMESTgRmWH
         IYBKxpwMf4N8dJDPm8etw5YscTrsmGIcz6o9XteSIZdoeQHxUSx5LTApnaWGK4Nonv7d
         Y6Fg==
X-Gm-Message-State: AOAM533YnRgqb5HA0bJ40W08utE4QtZJ1vnXjp2mHgrQRbuIw/lL/raL
        uak2rQiKLwfuCPKOmw9PwxO7bj4TixXJIskhSME=
X-Google-Smtp-Source: ABdhPJwNtLIqaFZxxV862dnCZC+UMGoCQ8y2wiLapOG5QWaAOvt9yE/oVV6ug30dJhWBOFFiY53/0dWuOev8NfageQQ=
X-Received: by 2002:aca:d547:: with SMTP id m68mr10910572oig.31.1625696766472;
 Wed, 07 Jul 2021 15:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
 <pull.932.v7.git.1624932293.gitgitgadget@gmail.com> <237ccf4e43dd461250b3e6d609a475c1d675ea86.1624932294.git.gitgitgadget@gmail.com>
In-Reply-To: <237ccf4e43dd461250b3e6d609a475c1d675ea86.1624932294.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 7 Jul 2021 15:25:55 -0700
Message-ID: <CABPp-BE_vGHv7GTESwQbbJ-YSSzkDjapKScEhgYq9QZkVVEg5w@mail.gmail.com>
Subject: Re: [PATCH v7 09/16] unpack-trees: unpack sparse directory entries
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 7:05 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> -       else
> +
> +       /*
> +        * Check for a sparse-directory entry named "path/".
> +        * Due to the input p->path not having a trailing
> +        * slash, the negative 'pos' value overshoots the
> +        * expected position by at least one, hence "-2" here.

You added the qualifier "at least" to this comment since v5.  I think
it's slightly misleading because it sounds like -2 is the end of the
special handling of the "at least" one overshoot.  Perhaps if you
ended with... "hence '-2' instead of '-1' here, and we also need to
check below if we overshot more than one".

> +        */
> +       pos = -pos - 2;
> +
> +       if (pos < 0 || pos >= o->src_index->cache_nr)
>                 return NULL;
> +
> +       /*
> +        * We might have multiple entries between 'pos' and
> +        * the actual sparse-directory entry, so start walking
> +        * back until finding it or passing where it would be.

It might be helpful to add a quick comment about the scenario where
this comes up.  e.g.

    This arises due to lexicographic sort ordering and sparse
directory entries coming with a trailing slash, causing there to be
multiple entries between "subdir" and "subdir/" (such as anything
beginning with "subdir." or "subdir-").  We are trying to walk back
from "subdir/" to "subdir" here.


> +        */
> +       while (pos >= 0) {
> +               ce = o->src_index->cache[pos];
> +
> +               if (strncmp(ce->name, p->path, p->pathlen))
> +                       return NULL;
> +
> +               if (S_ISSPARSEDIR(ce->ce_mode) &&
> +                   sparse_dir_matches_path(ce, info, p))
> +                       return ce;
> +
> +               pos--;
> +       }
> +
> +       return NULL;
>  }
