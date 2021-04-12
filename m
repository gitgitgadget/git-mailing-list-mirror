Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3809BC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 15:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0395261246
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 15:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbhDLPws (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 11:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242088AbhDLPwq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 11:52:46 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1F3C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 08:52:26 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id l131so8828334oih.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xuIhSggfgJYXTc5uuUQL75XQTfDTJ6Yz9QojVVqegGs=;
        b=Al2AJlkrURXS8EDIGCdfxXhqhQS001hIGIItsMzT2ASa6FRbcpyObnrBAha4aSHuRv
         JUQVi/fzAdiliplrQWIGhBlumxI8MBcV76yAG+7b4T6pSTPUHpzyox65Jv1pe6GmeVfb
         0jhsSVwCIxXRx3vYV0KBVhXrhjsNZ+DRy1ZbN9Gr14kotplUl9GN9ewT6XgrAAGSMcSi
         m5qkostESyAisq18hLTd8aqDwCx1w7M+5m/Qk5FjzdrPb2T5Ghc1Wn6GGgP2tt793HSL
         WKdA5GSU+LF4OIh8EVJYpG/3u7NowAFvapEUVzl2YeSedMrpDiZ2h/j0HhKA//1Zy3cF
         KpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xuIhSggfgJYXTc5uuUQL75XQTfDTJ6Yz9QojVVqegGs=;
        b=aYLefAKDI19tjo10ybnbJFXGZmSQjFt3/Rf1rjbfqshXY5TlHcZdmAuG9EifK/+yel
         pMWy1gxXSfE8uyqyO+KE1GjTLRRjPnHJaG0x3Ozn5XQjZVNsAB1vnfEhJiP2q7kFH2/i
         T1CZ2K6P1UGl56Q2GEQUIwwT3XPRUzY53L5ajiZ0KPhCa/NPwMBCv9GG5ZCS9mJCqEUx
         6F0jlOfNs9VNC75hP04wtag0hi7wXzD1mHSCxTbN1kCGGqygol4jIHVy0wz1k2dhFtba
         eRBdt4Vv3e/sqbeF6i1zjkiN4FEExDF3ronN1HEZCaKYZc2zogRzMCNxvqZpMhPYtFj5
         BqxQ==
X-Gm-Message-State: AOAM532EeQfKL8ZUGFbRkec00enU/xPw3ZpaFK4eMCa3+uYCxI7zTUF+
        ffZqdRrWvR6Jlv8xwEV6X7pSxu3cf6+mRS4OriY=
X-Google-Smtp-Source: ABdhPJyFnCrSnqMzBc8jCLkqwLflgxQmSx3nvCEsR9jFU1IQTL7sqZNTFlHTv8M2yzei1HVkEgPBCft1BYjzFJn7RSE=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr19640729oij.167.1618242746125;
 Mon, 12 Apr 2021 08:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.930.git.1618043449249.gitgitgadget@gmail.com> <pull.930.v2.git.1618139107203.gitgitgadget@gmail.com>
In-Reply-To: <pull.930.v2.git.1618139107203.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Apr 2021 08:52:14 -0700
Message-ID: <CABPp-BE2D933Bc6w-OeaJc1r+1_tvMeK2M-HK4eEKPkQb3BdQQ@mail.gmail.com>
Subject: Re: [PATCH v2] merge-ort: only do pointer arithmetic for non-empty lists
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 11, 2021 at 4:05 AM Andrzej Hunt via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Andrzej Hunt <ajrhunt@google.com>
>
> versions could be an empty string_list. In that case, versions->items is
> NULL, and we shouldn't be trying to perform pointer arithmetic with it (a=
s
> that results in undefined behaviour).
>
> Moreover we only use the results of this calculation once when calling
> QSORT. Therefore we choose to skip creating relevant_entries and call
> QSORT directly with our manipulated pointers (but only if there's data
> requiring sorting). This lets us avoid abusing the string_list API,
> and saves us from having to explain why this abuse is OK.

Oh, nice, I like that.

>
> Finally, an assertion is added to make sure that write_tree() is called
> with a valid offset.
>
> This issue has probably existed since:
>   ee4012dcf9 (merge-ort: step 2 of tree writing -- function to create tre=
e object, 2020-12-13)
> But it only started occurring during tests since tests started using
> merge-ort:
>   f3b964a07e (Add testing with merge-ort merge strategy, 2021-03-20)
>
> For reference - here's the original UBSAN commit that implemented this
> check, it sounds like this behaviour isn't actually likely to cause any
> issues (but we might as well fix it regardless):
> https://reviews.llvm.org/D67122
>
> UBSAN output from t3404 or t5601:
>
> merge-ort.c:2669:43: runtime error: applying zero offset to null pointer
>     #0 0x78bb53 in write_tree merge-ort.c:2669:43
>     #1 0x7856c9 in process_entries merge-ort.c:3303:2
>     #2 0x782317 in merge_ort_nonrecursive_internal merge-ort.c:3744:2
>     #3 0x77feef in merge_incore_nonrecursive merge-ort.c:3853:2
>     #4 0x6f6a5c in do_recursive_merge sequencer.c:640:3
>     #5 0x6f6a5c in do_pick_commit sequencer.c:2221:9
>     #6 0x6ef055 in single_pick sequencer.c:4814:9
>     #7 0x6ef055 in sequencer_pick_revisions sequencer.c:4867:10
>     #8 0x4fb392 in run_sequencer revert.c:225:9
>     #9 0x4fa5b0 in cmd_revert revert.c:235:8
>     #10 0x42abd7 in run_builtin git.c:453:11
>     #11 0x429531 in handle_builtin git.c:704:3
>     #12 0x4282fb in run_argv git.c:771:4
>     #13 0x4282fb in cmd_main git.c:902:19
>     #14 0x524b63 in main common-main.c:52:11
>     #15 0x7fc2ca340349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>     #16 0x4072b9 in _start start.S:120
>
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior merge-ort.c:2669:=
43 in
>
> Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
> ---
>     merge-ort: only do pointer arithmetic for non-empty lists
>
>     V2 removes relevant_entries as per Ren=C3=A9's suggestion, and adds a=
n
>     assertion as per Junio's question.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-930%2Fa=
hunt%2Fmerge-ort-ubsan-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-930/ahunt/=
merge-ort-ubsan-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/930
>
> Range-diff vs v1:
>
>  1:  d52ce7110446 ! 1:  48c1a0ad6f46 merge-ort: only do pointer arithmeti=
c for non-empty lists
>      @@ Commit message
>           NULL, and we shouldn't be trying to perform pointer arithmetic =
with it (as
>           that results in undefined behaviour).
>
>      +    Moreover we only use the results of this calculation once when =
calling
>      +    QSORT. Therefore we choose to skip creating relevant_entries an=
d call
>      +    QSORT directly with our manipulated pointers (but only if there=
's data
>      +    requiring sorting). This lets us avoid abusing the string_list =
API,
>      +    and saves us from having to explain why this abuse is OK.
>      +
>      +    Finally, an assertion is added to make sure that write_tree() i=
s called
>      +    with a valid offset.
>      +
>           This issue has probably existed since:
>             ee4012dcf9 (merge-ort: step 2 of tree writing -- function to =
create tree object, 2020-12-13)
>           But it only started occurring during tests since tests started =
using
>      @@ Commit message
>
>        ## merge-ort.c ##
>       @@ merge-ort.c: static void write_tree(struct object_id *result_oid=
,
>      -   * We won't use relevant_entries again and will let it just pop o=
ff the
>      -   * stack, so there won't be allocation worries or anything.
>      -   */
>      +  size_t maxlen =3D 0, extra;
>      +  unsigned int nr =3D versions->nr - offset;

Should we remove the initialization here and just define nr only, and then.=
..

>      +  struct strbuf buf =3D STRBUF_INIT;
>      +- struct string_list relevant_entries =3D STRING_LIST_INIT_NODUP;
>      +  int i;
>      +
>      +- /*
>      +-  * We want to sort the last (versions->nr-offset) entries in vers=
ions.
>      +-  * Do so by abusing the string_list API a bit: make another strin=
g_list
>      +-  * that contains just those entries and then sort them.
>      +-  *
>      +-  * We won't use relevant_entries again and will let it just pop o=
ff the
>      +-  * stack, so there won't be allocation worries or anything.
>      +-  */
>       - relevant_entries.items =3D versions->items + offset;
>       - relevant_entries.nr =3D versions->nr - offset;
>      -+ if (versions->nr) {
>      -+         relevant_entries.items =3D versions->items + offset;
>      -+         relevant_entries.nr =3D versions->nr - offset;
>      -+ }
>      -  QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_ord=
er);
>      +- QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_ord=
er);
>      ++ assert(offset <=3D versions->nr);

Define nr here after this assert?  The definition of nr also depended
implicitly on this requirement, so if we're making this requirement
explicit, it would make sense to define nr after stating the
requirement.

>      ++ if (versions->nr)
>      ++         QSORT(versions->items + offset, nr, tree_entry_order);
>
>         /* Pre-allocate some space in buf */
>      +  extra =3D hash_size + 8; /* 8: 6 for mode, 1 for space, 1 for NUL=
 char */
>
>
>  merge-ort.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 5e118a85ee04..702eb5bf362d 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2493,20 +2493,11 @@ static void write_tree(struct object_id *result_o=
id,
>         size_t maxlen =3D 0, extra;
>         unsigned int nr =3D versions->nr - offset;
>         struct strbuf buf =3D STRBUF_INIT;
> -       struct string_list relevant_entries =3D STRING_LIST_INIT_NODUP;
>         int i;
>
> -       /*
> -        * We want to sort the last (versions->nr-offset) entries in vers=
ions.
> -        * Do so by abusing the string_list API a bit: make another strin=
g_list
> -        * that contains just those entries and then sort them.
> -        *
> -        * We won't use relevant_entries again and will let it just pop o=
ff the
> -        * stack, so there won't be allocation worries or anything.
> -        */
> -       relevant_entries.items =3D versions->items + offset;
> -       relevant_entries.nr =3D versions->nr - offset;
> -       QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_ord=
er);
> +       assert(offset <=3D versions->nr);
> +       if (versions->nr)
> +               QSORT(versions->items + offset, nr, tree_entry_order);
>
>         /* Pre-allocate some space in buf */
>         extra =3D hash_size + 8; /* 8: 6 for mode, 1 for space, 1 for NUL=
 char */
>
> base-commit: 89b43f80a514aee58b662ad606e6352e03eaeee4
> --
> gitgitgadget

Otherwise, this patch looks good to me; thanks!
