Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89DBC636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 18:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjBGSFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjBGSFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 13:05:07 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A2D36699
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 10:05:04 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id m1so2288009ejx.7
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 10:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XsGYyQjW5Q83L96Fp40X1Tefux3nsu1Ld3iaRH1oWA=;
        b=KGRICtfLOfat5Jpbf/6U0OMYqjv94b+9sLiTXowI2LhNPopQHtLBOuH4eBamMAp9Z2
         4ImeUT6i0oTBLvHFg1grL/2uwkS3JgJJz+m8WB8eyH1d6TN+NIHjt/xMGErgst1Rtpel
         522u9ZFHLP6GgdclEBNTpT5Epe2WP+n5jS5UzyVVLFr3iyZ6vriCtqkcI6FAtlFJ6vTF
         YEzTLDia9eL8XjLZvlqk64vhmrdNZ9A+7tOXm09K/11tU8JzTRDNB/aa5MT7UGhDFxO8
         mlJG0tV9CicOiETgGYLkbl659XbAZ5vhekA8qRPGeitk2HRkc/yla7NoBTT1x5R6cBVX
         qe1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XsGYyQjW5Q83L96Fp40X1Tefux3nsu1Ld3iaRH1oWA=;
        b=JlmplLsbgxYSrJHj8NouJn/PJj5UTyqxgpmgpPel2cIrRdrkdSz/8GhTGfIzw5kdiT
         C2fqY9u+c1+k+e9m5UH4+EiilW9cijavjhFsWzkSfg8k8L9RkQmOxPueKxtxi0x0Q0qp
         +dTD4Rdval+tagINNU3OkW0byP+mFNsJgJqa1ZkAcFokoYX7MszC3dADCDwjdAasesfB
         we6ksWu1xtKY1EBkVShNA5oS+fAniY08N9MYy1H23kl3dXTAb6uzGkEZ74M3Bs8f4fFl
         Y0+rpLZOpsnlZAig1oxE7bvLvr6bYbvDr4NkMK8SuEGcCe+L8n7OZtbmeq6CKT8xZYVb
         ZrEw==
X-Gm-Message-State: AO0yUKWUx5+5IJKi7XiM+vlr+WK6h4t2PK3nR7y0fing5T6FZxRJ6suT
        jDYDtwwJtaSEg2ekPZnpNMIinJuqWdypSfhu
X-Google-Smtp-Source: AK7set+4cKNd/+eROohgDjqApzFeWz4WE84nxLiWx64vu2nJi0B8HcVVTwc2LhNSQjqVkNGui5fGyg==
X-Received: by 2002:a17:906:a1d5:b0:78d:f455:b5d4 with SMTP id bx21-20020a170906a1d500b0078df455b5d4mr4884375ejb.20.1675793103104;
        Tue, 07 Feb 2023 10:05:03 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id z25-20020a1709064e1900b0088550a1ce6esm7221136eju.222.2023.02.07.10.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:05:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPSKz-000vTW-2t;
        Tue, 07 Feb 2023 19:05:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
Subject: Re: [GSoC][PATCH] commit: warn the usage of reverse_commit_list()
 helper
Date:   Tue, 07 Feb 2023 18:56:26 +0100
References: <20230207150359.177641-1-five231003@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230207150359.177641-1-five231003@gmail.com>
Message-ID: <230207.86o7q52vxu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Kousik Sanagavarapu wrote:

> The helper function reverse_commit_list() has destructive behavior when
> used to reverse a list in-place. Warn about this behavior.
>
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---
>
> This patch has been sent based on the confusion that can be caused while
> using the reverse_commit_list() helper function. One example of this is
> a recent patch that I submitted[1] where the use of this function broke
> try_merge_strategy() in merge.
>
> It is also based on the discussions[2] there that I send this patch.
>
> [1]: https://lore.kernel.org/git/20230202165137.118741-1-five231003@gmail.com/
> [2]: https://lore.kernel.org/git/xmqqmt5uo9ea.fsf@gitster.g/
>
>  commit.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/commit.h b/commit.h
> index fa39202fa6..9dba07748f 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -198,7 +198,12 @@ void commit_list_sort_by_date(struct commit_list **list);
>  /* Shallow copy of the input list */
>  struct commit_list *copy_commit_list(struct commit_list *list);
>  
> -/* Modify list in-place to reverse it, returning new head; list will be tail */
> +/*
> + * Modify list in-place to reverse it, returning new head; list will be tail.
> + *
> + * NOTE! The reversed list is constructed using the elements of the original
> + * list, hence losing the original list.
> + */
>  struct commit_list *reverse_commit_list(struct commit_list *list);

Junio can clarify, but I understood from his original comment on this
suggesting a comment that he wasn't aware of the existing documentation.

I think it's better just to chuck this up to an understandable one-off
mistake, if we're going to update the docs here I don't really see
what's being added by this addition.

It seems to me that this is just rephrasing what's being said more
succinctly with "modifies in-place", it's understood that any function
which does that is going to schred the input data for its own purposes.

If that wording is thought to be too technical or obscure wouldn't we be
better off with replacing the existing wording with something using less
jargon, rather than keeping the jargon & adding a rephrasing of it?

Having said that, I think the existing version is fine, and we could
just ascribe the issue that prompted this to a one-off mistake :)

I think if you want to pursue this, a much better improvement here would
be to show what the user *should* do.

E.g. show one code example of using the API in-place, and then the
preferred pattern if one wants to produce a new reversed commit list,
while retaining the original (presumably just copy_commit_list()
followed by reverse_commit_list()).
