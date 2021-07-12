Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C57C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14D76117A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbhGLTln (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 15:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhGLTlm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 15:41:42 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506F1C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 12:38:54 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 128-20020a4a11860000b029024b19a4d98eso4804104ooc.5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 12:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ao3l8vh7tpe87WRI2NJRTVMXPpRR9OoXeTJMRmYyOZY=;
        b=VIf0n94LyeGYNwKi9F80Otjsf/cZoIjHw3RcJXXO0egps6074qF9aMPSYXHmJrxaqf
         51MO0ptu4OwD88dozCvpUdXsWbcxWKixkWWtGKclMyRw8KGxlR4RYHuJPAuWLHg0dJSY
         lpWZav+1cjQYpBNTQDHiqo6lQC9V47oxN+uo0vzFTV+pdFrTkopr3uDCHB+R05S6a6I/
         4X8sg049OXCAgqerObPtJJKDeZ6q9GmPoKl9Rp37JaB5JwNxqELAqlHlQKGipit0k9/V
         31snHj4brSEawX8I5Iu05gVvjlG11J3PR+r1HNaxVYI/ivj56TySbx992IdV3m+ZJVAf
         mAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ao3l8vh7tpe87WRI2NJRTVMXPpRR9OoXeTJMRmYyOZY=;
        b=EuKCOqgjmTHP1HbGrXKROql9o0e4SUCYfF3FHw5Dw86Sxpi5rsE0flkKRPmAYdtQOa
         cyjfsFn8fKX/T4oKOLqFnXF5Tl9gnMfEC5zh0MnXdbB0XKkM05qh+6Tr9/X5t6WMnyzJ
         +6AlN8Yp/6Yy6M7MlI1eXRIVdkExD9t94LcN4b4PZNfhzV/2qrtOu5CdhjyS2TcLMgcc
         xU6yYUT4iM+hEMv7MD9d6QX0jm9FafCSYImKyLUAjFKw89u6kmHSoMLJnO6WZ7jbgz39
         90TlX7nfWpQSInt7uOle0jaXWITtCRYiv6mgfPNX0yPUWXX9wpz14wUz363YXd5Oq9QA
         tAIQ==
X-Gm-Message-State: AOAM533OEM5hAag3ujqhBEiFLw7A7DfCwptbm9nANoMVPlhESe5rH/Ay
        PmVrGgoYJAbNCWYwbJrRcLPnGbFFWeNONHbWhfU=
X-Google-Smtp-Source: ABdhPJyeF7B2k3gofO49/b1aM7nvjnFfHbhDbjxtbCI2nsxyTIdnFVr1yCJxSdOlyL87QlzKwNWAJ6NhDnJPhjsaCRM=
X-Received: by 2002:a4a:1b82:: with SMTP id 124mr644510oop.32.1626118733577;
 Mon, 12 Jul 2021 12:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com> <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Jul 2021 12:38:42 -0700
Message-ID: <CABPp-BGZ0VNkAcScXLKAX0M3FwmXuZ5ei0o7Nu31L=rpSt6iQA@mail.gmail.com>
Subject: Re: [PATCH v8 00/15] Sparse-index: integrate with status
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 10:55 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is the first "payoff" series in the sparse-index work. It makes 'git
> status' very fast when a sparse-index is enabled on a repository with
> cone-mode sparse-checkout (and a small populated set).
>
...
> Update in V8
> ============
>
>  * The directory/file conflict patch is removed and delayed to the next
>    series where it will be required. (It will also be improved in that
>    series.)
>
>  * Some comments have been improved, including a new assert() that helps
>    document the situation.
>

This one looks really good.  Just two minor comments:

> Range-diff vs v7:
>
...
>   9:  237ccf4e43d !  9:  c0b0b58584c unpack-trees: unpack sparse directory entries
>      @@ unpack-trees.c: static int find_cache_pos(struct traverse_info *info,
>       +  * Check for a sparse-directory entry named "path/".
>       +  * Due to the input p->path not having a trailing
>       +  * slash, the negative 'pos' value overshoots the
>      -+  * expected position by at least one, hence "-2" here.
>      ++  * expected position, hence "-2" instead of "-1".
>       +  */
>       + pos = -pos - 2;
>       +
>      @@ unpack-trees.c: static int find_cache_pos(struct traverse_info *info,
>                 return NULL;
>       +
>       + /*
>      -+  * We might have multiple entries between 'pos' and
>      -+  * the actual sparse-directory entry, so start walking
>      -+  * back until finding it or passing where it would be.
>      ++  * Due to lexicographic sorting and sparse directory
>      ++  * entried ending with a trailing slash, our path as a

s/entried/entries/ ?


>      ++  * sparse directory (e.g "subdir/") and our path as a
>      ++  * file (e.g. "subdir") might be separated by other
>      ++  * paths (e.g. "subdir-").
>       +  */
>       + while (pos >= 0) {
>       +         ce = o->src_index->cache[pos];
...
>  15:  717a3f49f97 = 14:  dada1b91bdc wt-status: expand added sparse directory entries

As I commented over at [1], I would appreciate if we could at least
add a comment in the testcase that we know this testcase triggers a
bug for both sparse-index and sparse-checkout...and that fixing it
might affect the other comments and commands within that testcase in
the future...but for now, we're just testing as best we can that the
two give the same behavior.

[1] https://lore.kernel.org/git/CABPp-BGJ+LTubgS=zvGJjk3kgyfW-7UFEa=qg-0mdyrY32j0pQ@mail.gmail.com/


If you agree and include the two fixups above, the entire series is:
Reviewed-by: Elijah Newren <newren@gmail.com>

If you disagree, then all patches other than 9 and 14 can have my
Reviewed-by tag.  :-)


Thanks for all the awesome work!
