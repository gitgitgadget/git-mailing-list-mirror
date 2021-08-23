Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEA5C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC7961374
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhHWRjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhHWRjD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 13:39:03 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1881EC061760
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 10:38:21 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id x9-20020a056830278900b0051b8be1192fso17711108otu.7
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sqrep/vx56JYzpR/y+re5Lal/sd4troCTWDNGUhlNtE=;
        b=bEx+xa+cHJnAg7gO/os93t9CwlNLtBw6wahjMgWrxJmhBV4segfYAJWBMDRekNGhjc
         o7QpWVJQIvBSTvkWiTHDN3n8YN/k95RITXau/Ba+OQPLjcgMgT5IZXiMu+ps2pBkG6Q7
         ziUkUyKWx7UG1K0xTWbf1un30LbHOTAHs/8/lvDb7bGmNX5tQiM5EMIicaY50cZ8wHZx
         R24Swx2Jl9rKSrty1hOu29pppYysEr0AIMLnajBShKLcsuoGZHv+6ljTalJ0qNcxg/uc
         PdMqtYg2P9jNuQGm0HHCWUScRsHb7Z1B8WgMKZ4DJ3sTm2S1foUHT7ph4LheXpz7EGVQ
         OVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sqrep/vx56JYzpR/y+re5Lal/sd4troCTWDNGUhlNtE=;
        b=nNhUAGDKqfAa0nEAl9ziR5/0Xjm6QDbE9jZr4c2OCeDL0MKpX2B/5kCE1Rv8jwlQ7R
         rBBZ+nNlaqtZbUD5dH2R1D/QEiZr/+OlBCrvMS0LlvnP7iZVDDM9ljftW8jelsUvi7KQ
         tBbJ89/8Er1KloRYt7A4qED7fo0P05+g506ijAZQ7kWBqdIEMue28QV8oHywsdLPlf50
         Kw3UqDg/Yrrs99o1ay68uVhR++yl3zZeDOZ1pfUpiuW83HaNTUUL7WBMkQLmFKA/8ktM
         25p58Gnsxqybrc7xS+mU2Qx6st0lqUvqcB8ivO4uELFDS4je6/+AfQn8srllr6kHoZiM
         Zamw==
X-Gm-Message-State: AOAM53314lSpdO6bA6gVL5fmYtb/Bh31PsZ908+XKDA8bctuh2bzvEHG
        2gNS6qnl6UGyZqYF/z5gGAgUBrxgx17owvo2FoY=
X-Google-Smtp-Source: ABdhPJwVzD7nuB4nm2s12axKT51suwJUcmRDO42+vTK2ck+GwXAdDGOivRA5i3ExLcRO0oPvXSudp1rUckqDFTONYkI=
X-Received: by 2002:a9d:448:: with SMTP id 66mr28511963otc.345.1629740300452;
 Mon, 23 Aug 2021 10:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAMJzOtxMjEuAy2B3oJqOZEnipmC4OBWxhQLx_baXDHcQ1C7-+g@mail.gmail.com>
In-Reply-To: <CAMJzOtxMjEuAy2B3oJqOZEnipmC4OBWxhQLx_baXDHcQ1C7-+g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Aug 2021 10:38:09 -0700
Message-ID: <CABPp-BE7JMdWi5DzHkkkZiM-7u1pW3uhwh1W69yEOxaGuAmUbw@mail.gmail.com>
Subject: Re: git read-tree doesn't accept tree-ish
To:     Nikita Bobko <nikitabobko@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 10:32 AM Nikita Bobko <nikitabobko@gmail.com> wrote:
>
> ```
> git init
> echo foo > foo
> git add --all
> git commit -m 'foo'
>
> echo bar > foo
> git add --all
> git commit -m 'bar'
>
> git read-tree HEAD~:foo
> ```
> EXP: Read information about file `foo` into index
> ACT: `fatal: failed to unpack tree object HEAD~:foo`
>
> I expect it to work because manpage says that `git-read-tree` accepts
> `<tree-ish>`

HEAD~:foo is not a tree in your example, it's a blob.  Try running
this: `git cat-file -t HEAD~:foo`, to see the type.
