Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792761F954
	for <e@80x24.org>; Mon, 20 Aug 2018 19:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeHTXH4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 19:07:56 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42171 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTXH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 19:07:56 -0400
Received: by mail-yw1-f66.google.com with SMTP id n207-v6so2189291ywn.9
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 12:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/CYZjmHA/awpjqISuPdm8sA5yPHNWi0jJzJRjb/3RU=;
        b=QMjk69oIRz9OZ3rkCFDwO9IjkLE4y49cfhAANjLkmedklgTUQqAb2AbPDHUIUsG2YI
         wHGRaCjtsP+ivSxSrtHy3sT34VYe706SCZUE5JRd5jdzJtzcqOpdV2kXTxpiKZwC0zp7
         FYU5zG+1nKgCHXnTPQ9I/xMHqy5aHfUtXgCK7r4q47HYMVaR+9U3tNAQjca0oswpSlpc
         7nVsQnrdTsxDEKqVPKMQc44ic+AkhQek0XlJ7u80bYOgRsRox3Igd84n0Hc6n1jKpEMc
         UplfLwBDHni/XWYOE/R63kDzMvy9bpaQ4YgZ/j4rOjA19YQTAzgfVRafLCyOVVTvbOsu
         BX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/CYZjmHA/awpjqISuPdm8sA5yPHNWi0jJzJRjb/3RU=;
        b=PIITQukhS8VhznBCszOCJo081N75ETP19z3LYcH6c3DQyuKNgirN416XazB0eH6mlW
         Gvkol4BzTE+XZ9fg09NRwXnkJRy8OEJWpn3baB6Zj34k+ssxgcaINkpxmIF1ew1KePHO
         6XDVt0Oy7C0Pwv/L3khV/uyNUYJ06n1ix4Xp14iQgX30lsKnYu0HAKB2KowoNtZ70UWh
         +VsB4EF6DESmmSYfy+AV7PCTflDemUTLmIJvM1ixQk7cHdlDYWGQ7aNTsBw1wCKkjZqW
         h59ImhUbzXgM13QO4bu/a37P+xjbPfIjQ0acmWepYZhLbnU2H1+JGuDeKlFucOlvKb/E
         YsoQ==
X-Gm-Message-State: AOUpUlHC+5nNKvk7K3LA1dnl+ZsEf/zTE5XRVmOxKbL4gGABlzhZzPqU
        GIbBVESK+oHEHBUGMefaOE4T9TT7pnm1v3jFRvewJg==
X-Google-Smtp-Source: AA+uWPzhx/K6kzUxHECcBXu/R1SEhNCXcX6aNsRX0efatryZ+WGzViG3Ca7pEKfTc7R8T2SRDw44DuqbJBoFzrbEYGg=
X-Received: by 2002:a81:5703:: with SMTP id l3-v6mr25081830ywb.3.1534794659723;
 Mon, 20 Aug 2018 12:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180816023100.161626-1-sbeller@google.com> <20180816023100.161626-4-sbeller@google.com>
 <xmqq600afc1e.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq600afc1e.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 12:50:48 -0700
Message-ID: <CAGZ79kb-_7PTqe_9i4=FQQE7EmQsKN8+iB4snLetPD+r2UgpBQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] submodule: is_submodule_active to differentiate
 between new and old mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 10:37 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > The change a086f921a72 (submodule: decouple url and submodule interest,
> > 2017-03-17) enables us to do more than originally thought.
> > As the url setting was used both to actually set the url where to
> > obtain the submodule from, as well as used as a boolean flag later
> > to see if it was active, we would need to keep the url around.
> >
> > Now that submodules can be activated using the submodule.[<name>.]active
> > setting, we could remove the url if the submodule is activated via that
> > setting.
>
> ... as the cloned submodule repository has $GIT_DIR/config which
> knows its own origin, we do not need to record URL in superproject's
> $GIT_DIR/config.  Back before we started using a directory under
> $GIT_DIR/modules/ as a more permanent location to store submodule,
> and point at it by a gitdir file in $path/.git to allow removal of a
> submodule from the working tree of the superproject without having
> to reclone when resurrecting the same submodule, it may have been
> useful to keep custom URL somewhere in the superproject, but that no
> longer is the case.
>
> > In preparation to do so, pave the way by providing an easy way to see
> > if a submodule is considered active via the new .active setting or via
> > the old .url setting.
>
> Makes sense.
>
> >
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> >  submodule.c | 5 +----
> >  submodule.h | 6 ++++++
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/submodule.c b/submodule.c
> > index 6e14547e9e0..d56350ed094 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -221,9 +221,6 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
> >       return 0;
> >  }
> >
> > -/*
> > - * Determine if a submodule has been initialized at a given 'path'
> > - */
> >  int is_submodule_active(struct repository *repo, const char *path)
> >  {
> >       int ret = 0;
> > @@ -267,7 +264,7 @@ int is_submodule_active(struct repository *repo, const char *path)
> >
> >       /* fallback to checking if the URL is set */
> >       key = xstrfmt("submodule.%s.url", module->name);
> > -     ret = !repo_config_get_string(repo, key, &value);
> > +     ret = !repo_config_get_string(repo, key, &value) ? 2 : 0;
> >
> >       free(value);
> >       free(key);
> > diff --git a/submodule.h b/submodule.h
> > index 4644683e6cb..bfc070e4629 100644
> > --- a/submodule.h
> > +++ b/submodule.h
> > @@ -45,6 +45,12 @@ extern int git_default_submodule_config(const char *var, const char *value, void
> >  struct option;
> >  int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
> >                                                    const char *arg, int unset);
> > +/*
> > + * Determine if a submodule has been initialized at a given 'path'.
> > + * Returns 1 if it is considered active via the submodule.[<name>.]active
> > + * setting, or return 2 if it is active via the older submodule.url setting.
> > + */
> > +#define SUBMODULE_ACTIVE_VIA_URL 2
> >  extern int is_submodule_active(struct repository *repo, const char *path);
> >  /*
> >   * Determine if a submodule has been populated at a given 'path' by checking if
>
> This change assumes that all the existing return sites in the
> is_submodule_active() function signals true with 1 (or at least some
> value that is different from 2).

Yes.

> So I think this patch is insufficient, and needs to at least change
> the "submodule.active" codepath to return !!ret; otherwise, a caller
> that now expects 0 (not active), 1 (active but can lose URL) and 2
> (active and the presence of URL makes it so) will be confused when
> one of the MATCHED_* constants from dir.h comes back.

Yes.

I'll resend when appropriately.

Thanks,
Stefan
