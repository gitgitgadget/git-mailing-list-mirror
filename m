Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF1BC433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 22:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiJZWdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 18:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbiJZWdR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 18:33:17 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921E4122BE2
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 15:33:16 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id i19-20020aa787d3000000b0056bd68d713cso5005027pfo.17
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 15:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eD6J/9Nc74fG6vi1KhqvL0E8+qLW1CP/ZdYxn6myGtI=;
        b=q4ffpZpnuo54mtatuPOXKiUZ1M0B9yOxkT10TSGe8JtjDgP5K07eODRG6wq6ukV3MJ
         KQLSiTrS6ONG+4V9LsfqorDsVDf4Is2hbV+aK+iRfQ/fzc49XaKsDyBBiDuDcFhxmvsB
         Uod5sZ4Cb5fWB+ws7iwLvyB+50+I3Bt5X5BK8ONneixVNdFS1+oKZaKgIeizmyL2vgGV
         NQ6XQjR7hQlxqhvdCzDi+zMUfJCmdfFbc3k3+1+dVd1/PbpZRblMJ56NEpyz8MvcdFHF
         IuBtb3km7GhwZdA5SrDl4Vz7fsAoCpBB5ViVa5xkwnwJm+bqg3eQdSxGXRd3wclRXg8H
         VM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eD6J/9Nc74fG6vi1KhqvL0E8+qLW1CP/ZdYxn6myGtI=;
        b=Rm9VBFUJXJg9vZi9YxtKzZCXLNvMVnVGDfJuhZ0A2nsTU0sLuWcm70AShTM29TJkJk
         F0LN/qfOWHZAuM1+Z+NDiufFDQrNBUy+1oqdThZTW6BXSAnOf7k7Te75XLNfNlOrH1Lh
         y5svo+7Mxy2sjTlGO/CCRt3kYTHjch/YFDTKNzWLAcbcNxjPv5N0o90vviNwZ8gU5lYs
         oDRGLCnhPRwciz4vh0U2Yb+Qzr8euie80WLzx4rqDqlEtSmyepOOgqQ29KWO/JaGK+zH
         oFNVJIYB3W3AHq+oyKTznQvfO2+Qw45hVyCjICgJWA0NjLNj7ea2aGywsIyuV5h0gowe
         vtMQ==
X-Gm-Message-State: ACrzQf2sTREbrmLk0Qpg0JfJFWBecOzhOGVpJGRxTv2pTS388LwjsgyM
        SlwyaC9kCv9a+vPg71UWzaG/Ivapoj84DQ==
X-Google-Smtp-Source: AMsMyM79Bx9rAZSh8fDnHhjah05ltxktURSt3sII2Oo15WOkrqH5eFyQqEGVOHqERotDS2+/Rn/dCGiz0Z+w5g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:9405:b0:212:d24e:b3b with SMTP id
 r5-20020a17090a940500b00212d24e0b3bmr6705983pjo.43.1666823596082; Wed, 26 Oct
 2022 15:33:16 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:33:14 -0700
In-Reply-To: <79959a54eb4c1a0812b1f4643530069a63e549f4.1665973401.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com> <79959a54eb4c1a0812b1f4643530069a63e549f4.1665973401.git.gitgitgadget@gmail.com>
Message-ID: <kl6lo7tyqkph.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 1/9] tree: do not use the_repository for tree traversal methods.
From:   Glen Choo <chooglen@google.com>
To:     Alphadelta14 via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     "=?utf-8?Q?Ren=C3=A9?= Scharfe" <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alphadelta14 via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/tree.h b/tree.h
> index 6efff003e21..cc6402e4738 100644
> --- a/tree.h
> +++ b/tree.h
> @@ -18,15 +18,21 @@ struct tree *lookup_tree(struct repository *r, const struct object_id *oid);
>  
>  int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
>  
> -int parse_tree_gently(struct tree *tree, int quiet_on_missing);
> -static inline int parse_tree(struct tree *tree)
> +int repo_parse_tree_gently(struct repository *r, struct tree *tree, int quiet_on_missing);
> +static inline int repo_parse_tree(struct repository *r, struct tree *tree)
>  {
> -	return parse_tree_gently(tree, 0);
> +	return repo_parse_tree_gently(r, tree, 0);
>  }
> +
> +#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
> +#define parse_tree(tree) repo_parse_tree(the_repository, tree)
> +#define parse_tree_gently(tree, quiet_on_missing) repo_parse_tree_gently(the_repository, tree, quiet_on_missing)
> +#define parse_tree_indirect(oid) repo_parse_tree_indirect(the_repository, oid)
> +#endif

Typically, when we have repo_* and non-repo_* variants, we use a "static
inline" function, e.g. from refs.h:

  int repo_dwim_ref(struct repository *r, const char *str, int len,
        struct object_id *oid, char **ref, int nonfatal_dangling_mark);

  static inline int dwim_ref(const char *str, int len, struct object_id *oid,
          char **ref, int nonfatal_dangling_mark)
  {
    return repo_dwim_ref(the_repository, str, len, oid, ref,
            nonfatal_dangling_mark);
  }

I think we should do the same here, instead of using "#ifndef
NO_THE_REPOSITORY_COMPATIBILITY_MACROS".

From I can gather from "git log -S
NO_THE_REPOSITORY_COMPATIBILITY_MACROS", that macro was introduced
in e675765235 (diff.c: remove implicit dependency on the_index,
2018-09-21) and all instances of that macro were introduced around that
time. At the time, there was an effort to get rid of the_repository and
the_index almost everywhere (except builtins), and the macro would
ensure that we did this successfully.

We did such a good job with the_index that we flipped the default from
NO_THE_INDEX_COMPATIBILITY_MACROS to USE_THE_INDEX_COMPATIBILITY_MACROS
(f8adbec9fe (cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch,
2019-01-24)) but it looks like we never got there with the_repository.
I couldn't find any instances of "#define
NO_THE_REPOSITORY_COMPATIBILITY_MACROS", so I think we should just use
"static inline" instead.

Alternatively, one could get rid of the non-repo_* variant and adjust
all existing callers to use "struct repository", but that's a lot of
churn and may conflict with other in-flight series, so that's probably
left for another time.

>  void free_tree_buffer(struct tree *tree);
>  
>  /* Parses and returns the tree in the given ent, chasing tags and commits. */
> -struct tree *parse_tree_indirect(const struct object_id *oid);
> +struct tree *repo_parse_tree_indirect(struct repository *r, const struct object_id *oid);
>  
>  int cmp_cache_name_compare(const void *a_, const void *b_);
>  
> -- 
> gitgitgadget
