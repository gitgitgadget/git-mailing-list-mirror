Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205E7C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 18:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiEPSNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 14:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiEPSNK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 14:13:10 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E9C15FCC
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:13:09 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id b8-20020a056820134800b0035f6e70c82cso6690683oow.2
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ezyk1GQpn1AX6kj9J5GSkEf1gUxX8GRmiMBVe9h5H9w=;
        b=Fc15fDz3qqjhyh2bzlTdScHFemQaSzBcIihtykCGcaZ6rG2AWq2daE++9c3t9bxC9/
         JqC69F90B5ZN8lo6a5SUONQ3COHS5m4+qQh0cq4hkFa+WyxMhMo0RY3mOfxHu042+uUi
         znQ3nFQe/1L4vrwtlIm7K7DkVv4ghqZnQ9mnbAqEk/tmMR8aZ7BUlvVCzogMwxRIJc2Z
         YdqdUqNzj0zKldzcL9XEdo/dm9aArI491L59NWCkKD6r0g5oxOFkzZk/QFk1RsL9YDil
         iU8obIvczhMnvO+RoQYvH5BZtFPPB3zUQWszSu4LSOYNEmly9HPtw/dZvjUxOeV4d8/b
         kK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ezyk1GQpn1AX6kj9J5GSkEf1gUxX8GRmiMBVe9h5H9w=;
        b=ln48duu9X5W2AQqOoDKgEh+j6+Au2Unk8jfB5VnDUrhkTEgDJVzDqevP2h+WGRLO7k
         zRB+/uZpOXAeXyxId/6mWMuxjccHSqNg4Fltb+v4LlKzJSCi1zbgbyzyOuXqzn+lAGBs
         5XLNO0RSN4LDWr9w+uuI5dow1mgJ3BuHtfPXdvJ43Jtzqu6HxGCTEZWdnhmKlH7WQbMI
         y/hUs8o8uaOnUKwJauof4rYO+VxFRc3jnKyfJJdup+tNyC87jTMjT0dTv1/k2+ldXvO3
         DNqVmCUrwh7cbJsd19fRl5SvtFfFZEpv1UX2qbEaGQGlTOzUyGN/wPUFke+iYNomcyBL
         lrpg==
X-Gm-Message-State: AOAM530v+31vF48lDn920Zovq916f8j5nyeSQUQtFPRY8gDeiloBA75c
        oTFUkjz+/qVkvy04hCn70L1CBRfixQjDvA==
X-Google-Smtp-Source: ABdhPJzVgCGerK987ssw+cNa5wdXpb8GbiPmFuw/XO6K/NgiaK8NFxGRGXQwnlcOgNeoZgyy78ZAuQc4wC0M8w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:2a8a:b0:1df:26ba:6333 with SMTP
 id j10-20020a17090a2a8a00b001df26ba6333mr2pjd.0.1652724771614; Mon, 16 May
 2022 11:12:51 -0700 (PDT)
Date:   Mon, 16 May 2022 11:12:49 -0700
In-Reply-To: <22b10bf9da8ccf4ae4da634aadfdaff5ee7a3508.1652485058.git.gitgitgadget@gmail.com>
Message-Id: <kl6l1qwtjqhq.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
 <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com> <22b10bf9da8ccf4ae4da634aadfdaff5ee7a3508.1652485058.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 1/2] setup.c: make bare repo discovery optional
From:   Glen Choo <chooglen@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> Add a config variable, `discovery.bare`, that tells Git whether or not
> it should work with the bare repository it has discovered i.e. Git will
> die() if it discovers a bare repository, but it is not allowed by
> `discovery.bare`. This only affects repository discovery, thus it has no
> effect if discovery was not done (e.g. `--git-dir` was passed).
>
> This is motivated by the fact that some workflows don't use bare
> repositories at all, and users may prefer to opt out of bare repository
> discovery altogether:
>
> - An easy assumption for a user to make is that Git commands run
>   anywhere inside a repository's working tree will use the same
>   repository. However, if the working tree contains a bare repository
>   below the root-level (".git" is preferred at the root-level), any
>   operations inside that bare repository use the bare repository
>   instead.
>
>   In the worst case, attackers can use this confusion to trick users
>   into running arbitrary code (see [1] for a deeper discussion). But
>   even in benign situations (e.g. a user renames ".git/" to ".git.old/"
>   and commits it for archival purposes), disabling bare repository
>   discovery can be a simpler mode of operation (e.g. because the user
>   doesn't actually want to use ".git.old/") [2].
>
> - Git won't "accidentally" recognize a directory that wasn't meant to be
>   a bare repository, but happens to resemble one. While such accidents
>   are probably very rare in practice, this lets users reduce the chance
>   to zero.
>
> This config is an enum of:
>
> - ["always"|(unset)]: always recognize bare repositories (like Git does
>   today)
> - "never": never recognize bare repositories
>
> More values are expected to be added later, and the default is expected
> to change (i.e. to something other than "always").
>
> [1]: https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com
> [2]: I don't personally know anyone who does this as part of their
> normal workflow, but a cursory search on GitHub suggests that there is a
> not insubstantial number of people who munge ".git" in order to store
> its contents.
>
> https://github.com/search?l=&o=desc&p=1&q=ref+size%3A%3C1000+filename%3AHEAD&s=indexed&type=Code
> (aka search for the text "ref", size:<1000, filename:HEAD)
>
> Signed-off-by: Glen Choo <chooglen@google.com>

The intended commit message ends here...

> WIP setup.c: make discovery.bare die on failure
>
> Signed-off-by: Glen Choo <chooglen@google.com>

Ugh, dumb mistake (bad squash). Fortunately this was one of my more
professional-sounding WIP commit messages.
