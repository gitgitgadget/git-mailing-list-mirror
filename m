Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DDEC3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA8F2072E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfhFky9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgCWSLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:11:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43432 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgCWSLI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 14:11:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id a6so14302775otb.10
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1aJ793FKLWwz3O0hVl9bpOQkjh793lCjkR94JOy46M=;
        b=LfhFky9croWsX5xCt+/bz1dGx/7fQWvtKClj2lhgUlXrNmVZEo0/i7sPw5WVR2Uax/
         eB7nfadFBJ+bXcju9LUU9jsTDlhYf+eMCkifAKhRNxIFzFSeOlewc6RdM7HEElI4WSlj
         5zSKSmTRAVuVrn5Kr3Th2TpyM2ZIXVjOZnI0smuThU/tFNeUvimO7QV1qI7XXd/54Vea
         kLoyQUQhvRMNyuhcIUmcPr18rCRb3GN59NwZaD4OkMyoFaPDcOK1a9aFbdnDg6H1N4yy
         T1UYgpEEv7RhNEyk4fav+NBHSQNwhg9ODS5hxydCe2jXuz9zZNWSGHUkE9IO16MyqbsT
         DTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1aJ793FKLWwz3O0hVl9bpOQkjh793lCjkR94JOy46M=;
        b=MMqYCM3lp9YcWz0aWMM7EKSmspVRc0CcnPhtae7z2ZSMmnRRCqE6MQ3tygdaD7IWGk
         gGGgM6QIYg2EJrr84NSvzDpY1U4IrQm2MO9CaZzkcgJKpQg4Z/satrvIXe8yNme9qcWY
         XLWqdif8SqdMlLid0xJbds6To+wSn/iUoTPIg2lz7HD53szkO1+ald0xxMHWqL2yolRO
         z45wxTRxb2kpcorQgmX/93DjWbyXbHrjhmPkqvwt35KbP27dtQfF8Mcyvap5BdtEI9CL
         p812ZNNCRN0cY6Rg8txgtWY54i8MSO3bazQYl6XPoXI7p97CqcB7ARyWVa9bxeTsrdWD
         cs4w==
X-Gm-Message-State: ANhLgQ2yV/A3Tz/SVnzXQRnZdNPmgGckXw81vWxaz3fw0Xg6A7+EKuhI
        rfmRNudPXM1qlCJn7JvQe0Da6ypV34V/7arIqVanSVom
X-Google-Smtp-Source: ADFU+vvCLT9awIh9tPS7IS2nmbWamBPf9Q9bRqAhZAjI0Ltd9K1Puaqa7DcH8RWimdlSi80l6kead7Zx4vvqdD1PtaI=
X-Received: by 2002:a9d:5cc8:: with SMTP id r8mr19290132oti.345.1584987066774;
 Mon, 23 Mar 2020 11:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com> <a46439c8536f912ad4a1e1751852cf477d3d7dc7.1584813609.git.gitgitgadget@gmail.com>
 <9501e018-fe87-16b8-b0d8-913e4331778d@gmail.com>
In-Reply-To: <9501e018-fe87-16b8-b0d8-913e4331778d@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Mar 2020 11:10:55 -0700
Message-ID: <CABPp-BF7=jJ2fWFcriC3E0=ZrUWawXoLbz659jtYdtkTJ4we_w@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] unpack-trees: add a new update_sparsity() function
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 11:02 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/21/2020 2:00 PM, Elijah Newren via GitGitGadget wrote:

> > +     for (i = 0; i < o->src_index->cache_nr; i++) {
> > +             struct cache_entry *ce = o->src_index->cache[i];
> > +
> > +             if (apply_sparse_checkout(o->src_index, ce, o))
> > +                     ret = UPDATE_SPARSITY_WARNINGS;
> > +
> > +             if (!ce_skip_worktree(ce))
> > +                     empty_worktree = 0;
> > +
>
> nit: extra whitespace-only line

Will clean it up.

> > +     }
> > +
> > +     /*
> > +      * Sparse checkout is meant to narrow down checkout area
> > +      * but it does not make sense to narrow down to empty working
> > +      * tree. This is usually a mistake in sparse checkout rules.
> > +      * Do not allow users to do that.
> > +      */
> > +     if (o->src_index->cache_nr && empty_worktree) {
> > +             unpack_failed(o, "Sparse checkout leaves no entry on working directory");
> > +             ret = UPDATE_SPARSITY_INDEX_UPDATE_FAILURES;
> > +             goto done;
> > +     }
> > +
> > +skip_sparse_checkout:
> > +     if (check_updates(o, o->src_index))
> > +             ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;
> > +
> > +done:
> > +     display_error_msgs(o);
> > +     o->show_all_errors = old_show_all_errors;
> > +     if (free_pattern_list)
> > +             clear_pattern_list(&pl);
> > +     trace_performance_leave("update_sparsity");
> > +     return ret;
> > +}
> > +
> >  /* Here come the merge functions */
> >
> >  static int reject_merge(const struct cache_entry *ce,
> > diff --git a/unpack-trees.h b/unpack-trees.h
> > index d3516267f36..2c5d54cae9f 100644
> > --- a/unpack-trees.h
> > +++ b/unpack-trees.h
> > @@ -28,6 +28,13 @@ enum unpack_trees_error_types {
> >       NB_UNPACK_TREES_ERROR_TYPES
> >  };
> >
> > +enum update_sparsity_result {
> > +     UPDATE_SPARSITY_SUCCESS = 0,
> > +     UPDATE_SPARSITY_WARNINGS = 1,
> > +     UPDATE_SPARSITY_INDEX_UPDATE_FAILURES = -1,
> > +     UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES = -2
> > +};
> > +
>
> Is there a reason this isn't located just before
> update_sparsity()?

You mean move it to unpack-trees.c?  If I did that, the code in
sparse-checkout.c that uses two of these values would fail to compile.

> >  /*
> >   * Sets the list of user-friendly error messages to be used by the
> >   * command "cmd" (either merge or checkout), and show_all_errors to 1.
> > @@ -88,6 +95,8 @@ struct unpack_trees_options {
> >  int unpack_trees(unsigned n, struct tree_desc *t,
> >                struct unpack_trees_options *options);
> >
> > +int update_sparsity(struct unpack_trees_options *options);
> > +
>
> This appears to not use the enum as it should.

Whoops!  Will fix.  (Interesting that the compiler didn't flag any
kind of warning based on mismatch of declared function return types
for update_sparsity() in the .c and .h files...)

Thanks,
Elijah
