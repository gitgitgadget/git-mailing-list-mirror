Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B50C433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7391420770
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgL3TnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 14:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgL3TnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 14:43:16 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD91C061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:42:36 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id d189so19689446oig.11
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RnFydyV5JDq3WcwPMzHpWGIzRdUKihHP4CShePajSU=;
        b=s7dIaYaDi0nvD69qyjmFhJtKX7Jmo1GPy3fz+KT9paoF/tEHEv5GSFnNdDJptTrlTO
         hKic943axLZoAOwbiwmn912EBLe0K//jx+s5pnTmC+IExwMYgkAsLc3qfCSmZi3KZfNl
         PX0AvlwqmDNAfQRY1j4n+rlwyyu/ajrpPaCTpa695crRmHxaBoYIZQbqpOoNyhLc26+J
         LZqHsJWIRx/aO8/A2sLDf2oHlapzoiaqM572xUyhn8k+1hp6z/5PgEnM+3js6CVE7F5c
         gPSPXpxp/KaeYYYRGP+JC8iSW8TH7PnkdNUmTsTq5V4AjLQx09Equmh4C+chvnN5m6RI
         X+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RnFydyV5JDq3WcwPMzHpWGIzRdUKihHP4CShePajSU=;
        b=WN3Mk39qPdJsCUFKtkiqSzDJUz5rVr9DAzPRP83bib1/alX2nLRNnM77mZmEuWjoBx
         kcwASLzBYYOoaZiXPsxJ2RwvPovmXTjnQnmj9BaE5+sI4EObjD6Af18Ck8L4xh1n4mj/
         OuLKiU6/EUKm7TVtE2eUFB3W3VkZm0ouj92BaY9ERLj7oCWlCtN/JdLwtfQVhqPpgFMy
         Zb2K1XxqmQRdhQ++FXb3GmXpOhWkCmvoOtpS0d1ho7xypvgj8otKbcUXHXuPpCzCsd4v
         qwAVEA3lWErTEyBHPVFKxtviwF752dD96CsOzR5jaKTCbQau6W8UPDaxpdNKKwyGai5d
         89Bw==
X-Gm-Message-State: AOAM530G11rG6CBxoW4Q6yLV5WLoDyThul0E5VYVyBUEB1Wvdw/bUMbc
        vMIVE1ojGxKzdQh7U3C6XrcX+hTxKY+OHEeXnIM=
X-Google-Smtp-Source: ABdhPJwEIVUWLRee9a4kfx9EZ27YTIILdHm3gNSFUwMHX2Dr60oomz7rVkyT2j/m3DbeoxMZ5h1pt5Oo2G9xGCTt1vk=
X-Received: by 2002:a54:4185:: with SMTP id 5mr6214852oiy.31.1609357355460;
 Wed, 30 Dec 2020 11:42:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.829.git.1609356413.gitgitgadget@gmail.com> <f727880add6e0380248279e1ad79f80762868a6c.1609356413.git.gitgitgadget@gmail.com>
In-Reply-To: <f727880add6e0380248279e1ad79f80762868a6c.1609356413.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Dec 2020 11:42:24 -0800
Message-ID: <CABPp-BHQY0v2GwmV6dokkTPGuJKmFYKJ7NCe2kes0pQbZgBGQQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] tree-walk: report recursion counts
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 30, 2020 at 11:26 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The traverse_trees() method recusively walks through trees, but also

recursively -- you're missing the second 'r'.

> prunes the tree-walk based on a callback. Some callers, such as
> unpack_trees(), are quite complicated and can have wildly different
> performance between two different commands.

Not sure it belongs in the commit message, but you do have me curious
what you're digging in to...

> Create constants that count these values and then report the results at
> the end of a process. These counts are cumulative across multiple "root"
> instances of traverse_trees(), but they provide reproducible values for
> demonstrating improvements to the pruning algorithm when possible.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  tree-walk.c    | 33 +++++++++++++++++++++++++++++++++
>  unpack-trees.c |  1 -
>  2 files changed, 33 insertions(+), 1 deletion(-)

From the subject, you are changing tree-walk.  unpack-trees depends on
tree-walk, but why is something exposed to it with this kind of
change?  Maybe I'll see when I get to it.

>
> diff --git a/tree-walk.c b/tree-walk.c
> index 0160294712b..2d6226d5f18 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -4,6 +4,7 @@
>  #include "object-store.h"
>  #include "tree.h"
>  #include "pathspec.h"
> +#include "json-writer.h"
>
>  static const char *get_mode(const char *str, unsigned int *modep)
>  {
> @@ -167,6 +168,25 @@ int tree_entry_gently(struct tree_desc *desc, struct name_entry *entry)
>         return 1;
>  }
>
> +static int traverse_trees_atexit_registered;
> +static int traverse_trees_count;
> +static int traverse_trees_cur_depth;
> +static int traverse_trees_max_depth;
> +
> +static void trace2_traverse_trees_statistics_atexit(void)
> +{
> +       struct json_writer jw = JSON_WRITER_INIT;
> +
> +       jw_object_begin(&jw, 0);
> +       jw_object_intmax(&jw, "traverse_trees_count", traverse_trees_count);
> +       jw_object_intmax(&jw, "traverse_trees_max_depth", traverse_trees_max_depth);
> +       jw_end(&jw);
> +
> +       trace2_data_json("traverse_trees", the_repository, "statistics", &jw);
> +
> +       jw_release(&jw);
> +}

Yeah, I don't know the json_writer or trace2 stuff; might be nice to
cc Josh Steadmon or someone to review this patch.  (Or perhaps he
already reviewed internally?)

> +
>  void setup_traverse_info(struct traverse_info *info, const char *base)
>  {
>         size_t pathlen = strlen(base);
> @@ -180,6 +200,11 @@ void setup_traverse_info(struct traverse_info *info, const char *base)
>         info->namelen = pathlen;
>         if (pathlen)
>                 info->prev = &dummy;
> +
> +       if (trace2_is_enabled() && !traverse_trees_atexit_registered) {
> +               atexit(trace2_traverse_trees_statistics_atexit);
> +               traverse_trees_atexit_registered = 1;
> +       }
>  }
>
>  char *make_traverse_path(char *path, size_t pathlen,
> @@ -416,6 +441,12 @@ int traverse_trees(struct index_state *istate,
>         int interesting = 1;
>         char *traverse_path;
>
> +       traverse_trees_count++;
> +       traverse_trees_cur_depth++;
> +
> +       if (traverse_trees_cur_depth > traverse_trees_max_depth)
> +               traverse_trees_max_depth = traverse_trees_cur_depth;
> +
>         if (n >= ARRAY_SIZE(entry))
>                 BUG("traverse_trees() called with too many trees (%d)", n);
>
> @@ -515,6 +546,8 @@ int traverse_trees(struct index_state *istate,
>         free(traverse_path);
>         info->traverse_path = NULL;
>         strbuf_release(&base);
> +
> +       traverse_trees_cur_depth--;

I double-checked to see if there were any other return sites in this
function.  There aren't, which is nice and keeps this clean.

>         return error;
>  }
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 323280dd48b..02f484604ac 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1559,7 +1559,6 @@ static void populate_from_existing_patterns(struct unpack_trees_options *o,
>         free(sparse);
>  }
>
> -

Did you mean to combine this cleanup with some other patch?  If not,
could it be put into its own patch?

>  static int verify_absent(const struct cache_entry *,
>                          enum unpack_trees_error_types,
>                          struct unpack_trees_options *);
> --
> gitgitgadget

Seems like a good change other than a few small nits.  I don't know
the json_writer/trace2 stuff, so you might want another reviewer, but
it's only a few lines and seems relatively straightforward.
