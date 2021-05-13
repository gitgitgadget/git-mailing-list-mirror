Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11406C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 03:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C00FD611C9
	for <git@archiver.kernel.org>; Thu, 13 May 2021 03:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhEMDcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 23:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhEMDcj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 23:32:39 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E591C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 20:31:30 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id x15so10432384oic.13
        for <git@vger.kernel.org>; Wed, 12 May 2021 20:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wuxtl1iOug0Zmg7B9GfzXwXhVNM70PB3WzQQvtrX2OU=;
        b=RJnfffxTggZnmM7b34D7bmLaZ1i89lS4tLHSEX9A8XhOmz5toJIcAxSW+4zdhpGkSO
         IB7OsxvrEJmz6rCrcq7NM1cphCxpZKQ9lsAFuy26+hyTpBZEooFM7RJqEQZf3Rq9/+Nb
         osAxl0nBJ7btUqch/Fhgn5HKs4uy6vyIeTyxrbglioq5Rx+WwDo8mqeg904lGOhxfGDi
         4w1Ctf0A7nSMe6P2Nlp43EY3TXeVQIUilFiDRCz5UqlCCF45d3Q/vBby5y2DUKdQhSBF
         axoZjfM7OVX4DB/ubeDUrp683pSaiyqeFmt27sgAoYVHcKz9vX/sv0AL71FDHTH80T3H
         ZvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuxtl1iOug0Zmg7B9GfzXwXhVNM70PB3WzQQvtrX2OU=;
        b=GA0aPQ7g9bTbyrwVgzZMs3V6GWigBO0ONlli3DIPT75Sz3AmIkxT/Ws6J99H/ytBsC
         R3O9QROh1hYpK8aRW1IZg0bki/YVFuT1IvWG8f77o7OGRChpMj4rHGOANCCfE47cea27
         tDYT5wjRUkNPVmxzXd9cx9TpylhUFknKzz1IN6lt16Y5nGDEeaH3ozJaMt1EQ03kZYrN
         B9+JQwqUvhcz1D25ySvYwzZTvYucf2VX74WvY8FIP0F8gjdT55M88Von3Fhnz4Z6YsKw
         5RsBN+8oqow69ZhVVwOFvSP0a/97FpzKPYODHTh684o2HxAZMuTJIldJS1AA3GCuqglD
         rdoQ==
X-Gm-Message-State: AOAM5310GTWRg/QUDofeqPGWUwL9WBQh8Ws06OGqxB1kKHQq2bnzV0va
        yuOM/HY0h7L0f008gDZBCp7Cml+6q1MujXsjruE=
X-Google-Smtp-Source: ABdhPJxdVGk5lpgMUZVvLdbIu5ZUxee8kjyALO/iNDfiLwXDHsWjw147sg1mFlGQNxFntxBI5mYEsuNTGPSDuYJX/ck=
X-Received: by 2002:aca:30cd:: with SMTP id w196mr1330671oiw.167.1620876689644;
 Wed, 12 May 2021 20:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <pull.932.v2.git.1619213665.gitgitgadget@gmail.com> <d3c8948d0a33d81e0d426130c89783df25b06703.1619213665.git.gitgitgadget@gmail.com>
In-Reply-To: <d3c8948d0a33d81e0d426130c89783df25b06703.1619213665.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 12 May 2021 20:31:18 -0700
Message-ID: <CABPp-BFkqK6ccVeV8N8WozsJC0nx05PTjNueqXgZzuURYR3e=A@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] unpack-trees: stop recursing into sparse directories
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

On Fri, Apr 23, 2021 at 2:34 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When walking trees using traverse_trees_recursive() and
> unpack_callback(), we must not attempt to walk into a sparse directory
> entry. There are no index entries within that directory to compare to
> the tree object at that position, so skip over the entries of that tree.
>
> This code is used in many places, so the only way to test it is to start
> removing the command_requres_full_index option from one builtin at a
> time and carefully test that its use of unpack_trees() behaves correctly
> with a sparse-index. Such tests will be added by later changes.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  unpack-trees.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 3af797093095..67777570f829 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1256,6 +1256,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>         struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
>         struct unpack_trees_options *o = info->data;
>         const struct name_entry *p = names;
> +       unsigned unpack_tree = 1;
>
>         /* Find first entry with a real name (we could use "mask" too) */
>         while (!p->mode)
> @@ -1297,12 +1298,16 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>                                         }
>                                 }
>                                 src[0] = ce;
> +
> +                               if (S_ISSPARSEDIR(ce->ce_mode))
> +                                       unpack_tree = 0;
>                         }
>                         break;
>                 }
>         }
>
> -       if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
> +       if (unpack_tree &&
> +           unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
>                 return -1;
>
>         if (o->merge && src[0]) {
> @@ -1332,7 +1337,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>                         }
>                 }
>
> -               if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
> +               if (unpack_tree &&
> +                   traverse_trees_recursive(n, dirmask, mask & ~dirmask,
>                                              names, info) < 0)
>                         return -1;
>                 return mask;
> --
> gitgitgadget

The splitting of the previous patch looks really good here too, and
the variable rename makes it flow nicely.  Looking good.
