Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4417C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 04:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2D261242
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 04:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhIXEzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 00:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhIXEzk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 00:55:40 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12658C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 21:54:06 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id u11so5761964uaw.3
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 21:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MyMqngIVK70hqizo+jweTnmx/Y6h/vN9X9vpXRtA4yY=;
        b=pBXzse+hoz0g/lq2u8AeO6r/89jmI2jcJAKgOheSWlTLJyXfEcMA+Hpr/94YFga6XL
         sB+KXzY1ibtrV8QiAJSoklGHk8VnhjOdqDA/m9eDFTp3kYhY47/VKOg1cohFsnMtHaFs
         GBBru4QB0PJp9VRt0jPcuMDsRqX2vcFS2BXI71aoZ4qbBEoJXzPUVZX1djkfmJ86E0vF
         yBf30PXmgvKn+jvJXZEjjLKFCo+nKmU8j5c3iZel1F6lYvE+t1dxOrSXZAFqknz60rZz
         L4KQHCxt5Oe1qavSxr7WEWWGSmjZ5VtzUW9/rmfykWUAYHv4BY9QVAkDJgJJCkBB3cGY
         54tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MyMqngIVK70hqizo+jweTnmx/Y6h/vN9X9vpXRtA4yY=;
        b=ELo9GVW8syMRO6sxk4eZMDugVFvgy0oi/rg+P5gOONszXEbp9D60dOTzQTb6b1fqwd
         r6qx7OyCksDc6pLzjDWc1cdk4RM0C4lBhHk/69HZffWP/RY4MzuOzb6gOda+fQCR/N0v
         Ub/eoBhna2x+5IZL91IwasrZj9jsLNMBxgiKzO1fbEpZYOsCLxenUOGmmkX2LaNfNPTE
         2CrcOI5IlS1CbOxgToqWU7yBh/3Yopjuj32pPu0he58rcDOltwuYYbfj8xqQXw3E07lP
         tKZVlfAJ2YurbRd/ZpmXsQpyQCJgZQaJABGmS7AHE/uzlrmBx4iVX5WaX7nCep+I88qB
         ivNw==
X-Gm-Message-State: AOAM530lMo/EIx/gUGxQLHzVg2yjAWDlETUbwPt+T9zHNpEFfg5MD/mQ
        DiU+/dbFhmSxK+1uKQNCWiUo1mxq6CZ6PhFfJXo=
X-Google-Smtp-Source: ABdhPJyvLcWicXakUOMpV1oZuP55Audl1cvS/J7FChNAH6G80LIp59b1WY3iEn/JT7t2/qeNyUnuNp8lGDV2jlUh6P0=
X-Received: by 2002:ab0:7c4a:: with SMTP id d10mr7642318uaw.138.1632459245105;
 Thu, 23 Sep 2021 21:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <87zgs34ccx.fsf@evledraar.gmail.com> <20210924024606.20542-4-tbperrotta@gmail.com>
 <9a60226c-7a35-0486-a687-31f7691e7551@gmail.com>
In-Reply-To: <9a60226c-7a35-0486-a687-31f7691e7551@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 23 Sep 2021 21:53:54 -0700
Message-ID: <CAPUEspjxYy4GOABXkzRza-wmKnZAdq-v=OP-9+-wfV2PCnDGwQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] send-email docs: add format-patch options
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, gitster@pobox.com,
        avarab@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 9:36 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 24/09/21 09.46, Thiago Perrotta wrote:
> >   SYNOPSIS
> >   --------
> >   [verse]
> > -'git send-email' [<options>] <file|directory|rev-list options>...
> > +'git send-email' [<options>] <file|directory>...
> > +'git send-email' [<options>] <format-patch options>
> >   'git send-email' --dump-aliases
>
> Is <format-patch options> optional? If so, we can say [<format-patch
> options>].

no; as Junio explained [1] this omission is intentional while the
rev-list options that
got cut to make space are not and are more relevant.

IMHO leaving [<options>] to imply ALL options (that also include diff
options, for example) is better

Carlo

[1] https://lore.kernel.org/git/xmqqh7fjuaar.fsf@gitster.g/
