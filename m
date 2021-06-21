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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E1FC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1230361289
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhFUVTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhFUVTt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 17:19:49 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D81EC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:17:34 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w1so8220880oie.13
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QK/YJiM34VO40Jv1xlQxK8jbcEHRJlgyQqS89pzYV18=;
        b=eKz/L4er0Ss6bOJgFYWxEP70w7/VpF5t9L05u6e40AVXXBdgpF1oD/xBBSDlE/m7DT
         S/60uSgRMUcmbgLs6BLv8guXOSRnsX+rJkSIQRZz40EMno1CXatF9dnwh+vmZsiROze0
         8B0dsGcDnJff2DV8lathvSUjL6p+cD5shyJZt5XgaxYuooKnTptmzAVcsU7EDVfEO1xw
         Qp2qYXY/0dUjwolz42cZyTdkBi7YW8m9taikW76+qIKLruM+TUDmZcENiGOE0qepTUGv
         PQZNTWrEm3pmoGh+qvtpzjpQQJ5FGCgEkulUiBWoPie7DFMSltSPso6ScLYjHnCuHN2l
         Ohlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QK/YJiM34VO40Jv1xlQxK8jbcEHRJlgyQqS89pzYV18=;
        b=SXb3uyYK8eK5e2bTJK+RSJV/gU5RXNSc1ajganRJlAMHYcZ7y3JulqJJ1WwiJLqsQT
         ZPr4U+3xZzg4QOLv9WvBNATKHeJNIxSsvRFYnpopIU+Nb7WzBO4SodgZZetnaNHYSPjn
         8FKCGVac+djQ+fuBTsX+U0x8T9wAJzIBviWbf5HkFTDT1T/Hcw1HRne44Hdqdb/1Q65w
         98gtVOa7Ovg7NPOTczwYbLNlJBaQSHWopKjH8fxY4P6q6ztPXNV5nNGPru66wnuEl0pN
         6YFLO/ohRomaeW2Xb4j+yw8fTTsyLMNyPD2R9j5VbO3Kb74ExcXvVmO4nFOKIBIfqIBP
         /mEQ==
X-Gm-Message-State: AOAM532mi621/6S6j8T2ZspVDl8wwiZtHsEE+7cuDohWmka+OMl1K9Wm
        1zbMdLhIh/Vut3mopK8WU9h2q9s9EhYfOn+6KHg=
X-Google-Smtp-Source: ABdhPJwChPRXZ4PYRe7GCyN7ostMHZS9wquXEb6wurjS5IxL1FSO0l43gniYhvGWKjZOInNAzgbgVt0P0MBakHbsKqs=
X-Received: by 2002:aca:330a:: with SMTP id z10mr508629oiz.31.1624310254022;
 Mon, 21 Jun 2021 14:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210620151204.19260-1-andrzej@ahunt.org> <20210620151204.19260-8-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-8-andrzej@ahunt.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jun 2021 14:17:23 -0700
Message-ID: <CABPp-BGBk8qT+ApEkaDMF4zqK5ZeW07fTjQUuNz6c6z=oQd2eQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] read-cache: call diff_setup_done to avoid leak
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 8:15 AM <andrzej@ahunt.org> wrote:
>
> From: Andrzej Hunt <ajrhunt@google.com>
>
> repo_diff_setup() calls through to diff.c's static prep_parse_options(),
> which in  turn allocates a new array into diff_opts.parseopts.
> diff_setup_done() is responsible for freeing that array, and has the
> benefit of verifying diff_opts too - hence we add a call to
> diff_setup_done() to avoid leaking parseopts.

Should the documentation near the top of diff.h also point out that
part of the purpose of diff_setup_done() is to free some memory?

> Output from the leak as found while running t0090 with LSAN:
>
> Direct leak of 7120 byte(s) in 1 object(s) allocated from:
>     #0 0x49a82d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
>     #1 0xa8bf89 in do_xmalloc wrapper.c:41:8
>     #2 0x7a7bae in prep_parse_options diff.c:5636:2
>     #3 0x7a7bae in repo_diff_setup diff.c:4611:2
>     #4 0x93716c in repo_index_has_changes read-cache.c:2518:3
>     #5 0x872233 in unclean merge-ort-wrappers.c:12:14
>     #6 0x872233 in merge_ort_recursive merge-ort-wrappers.c:53:6
>     #7 0x5d5b11 in try_merge_strategy builtin/merge.c:752:12
>     #8 0x5d0b6b in cmd_merge builtin/merge.c:1666:9
>     #9 0x4ce83e in run_builtin git.c:475:11
>     #10 0x4ccafe in handle_builtin git.c:729:3
>     #11 0x4cb01c in run_argv git.c:818:4
>     #12 0x4cb01c in cmd_main git.c:949:19
>     #13 0x6bdc2d in main common-main.c:52:11
>     #14 0x7f551eb51349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> SUMMARY: AddressSanitizer: 7120 byte(s) leaked in 1 allocation(s)
>
> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>  read-cache.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index 77961a3885..212d604dd3 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2487,37 +2487,38 @@ int unmerged_index(const struct index_state *istate)
>  int repo_index_has_changes(struct repository *repo,
>                            struct tree *tree,
>                            struct strbuf *sb)
>  {
>         struct index_state *istate = repo->index;
>         struct object_id cmp;
>         int i;
>
>         if (tree)
>                 cmp = tree->object.oid;
>         if (tree || !get_oid_tree("HEAD", &cmp)) {
>                 struct diff_options opt;
>
>                 repo_diff_setup(repo, &opt);
>                 opt.flags.exit_with_status = 1;
>                 if (!sb)
>                         opt.flags.quick = 1;
> +               diff_setup_done(&opt);
>                 do_diff_cache(&cmp, &opt);
>                 diffcore_std(&opt);
>                 for (i = 0; sb && i < diff_queued_diff.nr; i++) {
>                         if (i)
>                                 strbuf_addch(sb, ' ');
>                         strbuf_addstr(sb, diff_queued_diff.queue[i]->two->path);
>                 }
>                 diff_flush(&opt);
>                 return opt.flags.has_changes != 0;
>         } else {
>                 /* TODO: audit for interaction with sparse-index. */
>                 ensure_full_index(istate);
>                 for (i = 0; sb && i < istate->cache_nr; i++) {
>                         if (i)
>                                 strbuf_addch(sb, ' ');
>                         strbuf_addstr(sb, istate->cache[i]->name);
>                 }
>                 return !!istate->cache_nr;
>         }
>  }
> --
> 2.26.2

Patch makes sense; a quick `git grep -e repo_diff_setup -e
diff_setup_done` doesn't flag any other areas of the code as having
the same bug.
