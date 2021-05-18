Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC2EC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 02:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026FC61004
	for <git@archiver.kernel.org>; Tue, 18 May 2021 02:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbhERCIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 22:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhERCIH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 22:08:07 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50F9C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 19:06:49 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso7315653ots.10
        for <git@vger.kernel.org>; Mon, 17 May 2021 19:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vi4MRILs9LeAI91JAep1r23rr35LzCJwymhy1Z12Uns=;
        b=c1ZM69Zt64M8ntCSOHgLs1NzlSugKr7oeEzvaI58TPsxbscbH3JzfXsk7rkSSKP+A7
         Yb36l+2B2KlB//OSBQHAY9dX/yNvjdltjgenbNfAjQsVudpeCatSJZh63g5F51ifBopP
         S2CkFIShc8tBU+tbWdX+AQNSczmnqlOGVXYHUaJ+AKncXprsiejisJrdMoL3Us35zo26
         c/EByfcJrsuGHF47PTUAofpfyL6YVH7e+HrINHnLCX/8imGziSLIPlTGrZgdL0PbMasv
         1fn08V2eoDsF/DrHVfAudoFfW8EO/Dg1kUwHhvOdzP9ZdEn5tPKAPbeEJEdp54UpTczN
         jo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vi4MRILs9LeAI91JAep1r23rr35LzCJwymhy1Z12Uns=;
        b=D8JuFsPpJBdMb53t75zoS/kxCPBcT15XfG0AEz0mo9WEckrVQvpGS9NcStANZEUoKC
         0QEtkTuZeyRDsT+hXCosPP5cCUXuY8jm9Y0H6OdjiQA3qPsuaHwWIeFu3Ysr3K3gR+10
         d+xncgeRVhs0nMznhWJ1GEx9w14NERIOfRb2rqPXNmaKp0tSnN1C9MawbqX1iDcBOh3N
         fOifmsUnLXHQ7F30kOKCxaX/2/myGQ9cdUEt5rT5+ZyHiTdzo+bU9IUs/RkMFedDdbMs
         yhFdviDqoSP9dHYf9YziNjJ/T7ym9kB4dD45M72eMuNZ+2AZjFr/JHkj5mc0j9o1HNmW
         Ynvw==
X-Gm-Message-State: AOAM5320312dUzcyz43rukIRkJOwXBzkEVBzpQur0rZHnbEz1V5ADJ88
        44feJFMEZo1X7WrWVE8xNUVGfBXoy+/JlFMKrPY=
X-Google-Smtp-Source: ABdhPJxpJj6ktGCEVU5kHCM9ouomMJhiAEinjRjO0LkXMuK2jNQO4hOVFaSwuFGD0qbAsZM0vtr9E0e7H+y3ErHGCrc=
X-Received: by 2002:a9d:7096:: with SMTP id l22mr2188798otj.345.1621303609372;
 Mon, 17 May 2021 19:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <pull.932.v3.git.1621017072.gitgitgadget@gmail.com> <598375d3531fabe8582cb6d93838df09e1bd06c3.1621017072.git.gitgitgadget@gmail.com>
 <CABPp-BGc_Cduk3aFJqk4MjJ2k6KMDWSnwZfJM+E-1oK8txsf7Q@mail.gmail.com>
In-Reply-To: <CABPp-BGc_Cduk3aFJqk4MjJ2k6KMDWSnwZfJM+E-1oK8txsf7Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 May 2021 19:06:38 -0700
Message-ID: <CABPp-BEdWMnzUay9R_GnbiWzuddrFMu87DLmCz4_s8HaBsrYQQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] unpack-trees: stop recursing into sparse directories
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I spoke too soon...

On Mon, May 17, 2021 at 7:03 PM Elijah Newren <newren@gmail.com> wrote:
>
> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index ef6a2b1c951c..703b0bdc9dfd 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -1261,6 +1261,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
> >         struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
> >         struct unpack_trees_options *o = info->data;
> >         const struct name_entry *p = names;
> > +       unsigned unpack_tree = 1;

Here, you set unpack_tree to 1.

> >
> >         /* Find first entry with a real name (we could use "mask" too) */
> >         while (!p->mode)
> > @@ -1307,7 +1308,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
> >                 }
> >         }
> >
> > -       if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
> > +       if (unpack_tree &&

You check it's value here...

> > +           unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
> >                 return -1;
> >
> >         if (o->merge && src[0]) {
> > @@ -1337,7 +1339,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
> >                         }
> >                 }
> >
> > -               if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
> > +               if (unpack_tree &&
...and here....

> > +                   traverse_trees_recursive(n, dirmask, mask & ~dirmask,
> >                                              names, info) < 0)
> >                         return -1;
> >                 return mask;

but you never set unpack_tree to 0, so this is wasted effort and you
always recurse.  The previous iteration had a case where it'd set
unpack_tree to 0 in a certain case, but you deleted that code in this
version.  Why?
