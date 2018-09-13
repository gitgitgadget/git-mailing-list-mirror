Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2A91F404
	for <e@80x24.org>; Thu, 13 Sep 2018 19:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeINAkv (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 20:40:51 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33550 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbeINAkv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 20:40:51 -0400
Received: by mail-yb1-f195.google.com with SMTP id m123-v6so3792161ybm.0
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 12:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJhLh1sTJyEc8WR4MNDF6hkUp/J1Yhjah7PdKu6d/QY=;
        b=DJOa9KMjaNx8rOlwb687NPpSaIIYLqIsUku+KcJQa3iRjhV17J357vNmxZJOVLH4U6
         2L+NrhbWYdKt8f9wpndzgUZw/SaOo/cj6rzfKADZo9p0jrwfOM5Fgz7En+6h4rcCc6Xa
         TY1Gj7L9jir9tYGMSAetOOBZ5P8DuTrKI/Ja3OaC8MnXVYgCD9WdcnaKmDK/+0M+BjY5
         ijRnsgn5S/UDimRW4v7Gq6pTo3UeqlSmrzG6GW/V9lFreHXQ2OT2ImeCc6p7mzBQlw17
         Ywd3mpz/A+/8Gy9hLRTwNe+BpNcTTA5qQ3PueMukFGs9NmqyKwXWaZwh/jXvigyD7fg+
         Xj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJhLh1sTJyEc8WR4MNDF6hkUp/J1Yhjah7PdKu6d/QY=;
        b=JrM7WgjVwEn5JUbaNiPfP1CeOoadHoAHgIiv2Gs/CaxIdRVLXfNEfmn/VVAC2uDJzo
         23vEFtNmXq9R+FVq6Hz00I8a2SY95dWUuKPNNNkZETs3uVB12CncsuVcfag6koBx1Wjn
         sHtH0+tuYs/W/SlgSbryT20mFOknQ9tNgnDaYYSh8YhZYptiY6LnmnpDe3Nz2dPkRRYu
         ldOQB5mz2o4oqnxlsk//xni4BLKQvq2uMBEaSzU1vVRv38sTzWq37eKmiDzk/WIgvXoW
         VAn52pFgDUNoXESw+f9aeBR/f9qwAJQPL/3YhWR61RZIJdnBNSY6vlKgro3BWs2uU+zK
         kmJw==
X-Gm-Message-State: APzg51AePkODYJpWtBloRpbbhDSLLzaZP80CGjxSZBvHB9HVK7Ny+Rmy
        VItV4NfnLFxNfLQPefJxbTOGU9qsYHR+svIH3mBQkTDwj04=
X-Google-Smtp-Source: ANB0VdYCYtxaS/QTtlsO3NFjTJI2mPQ0dL79xXrg8NgMn34mGU6mzMDaT1leF8ckbV9kvGTzZld6G4t8XrHO922njnU=
X-Received: by 2002:a25:842:: with SMTP id 63-v6mr4120134ybi.425.1536866997119;
 Thu, 13 Sep 2018 12:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com> <20180911234951.14129-8-sbeller@google.com>
 <xmqqlg86lg06.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg86lg06.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Sep 2018 12:29:45 -0700
Message-ID: <CAGZ79kZKKf9N8yx9EuCRZhrZS_mA2218PouEG7aHDhK2bJGEdA@mail.gmail.com>
Subject: Re: [PATCH 7/9] submodule: fetch in submodules git directory instead
 of in worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 12, 2018 at 11:36 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > This patch started as a refactoring to make 'get_next_submodule' more
> > readable, but upon doing so, I realized that git-fetch actually doesn't
> > need to be run in the worktree. So let's run it in the git dir instead.
>
> It may be clear to the author but not clear to the reader of the
> above paragraph that "worktree", "fetch" and "git dir" all refer to
> the recursively invoked operation that updates the submodules
> repository.  s/git-fetch/"git fetch" for the submodule/ should be
> sufficient to help the readers.
>
> > That should pave the way towards fetching submodules that are currently
> > not checked out.
>
> Very good.
>
> > +static void prepare_submodule_repo_env_in_gitdir(struct argv_array *out)
> > +{
> > +     prepare_submodule_repo_env_no_git_dir(out);
> > +     argv_array_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
> > +}
> > +
> >  /* Helper function to display the submodule header line prior to the full
> >   * summary output. If it can locate the submodule objects directory it will
> >   * attempt to lookup both the left and right commits and put them into the
> > @@ -1227,6 +1233,27 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
> >       return spf->default_option;
> >  }
> >
> > +static const char *get_submodule_git_dir(struct repository *r, const char *path)
> > +{
> > +     struct repository subrepo;
> > +     const char *ret;
> > +
> > +     if (repo_submodule_init(&subrepo, r, path)) {
> > +             /* no entry in .gitmodules? */
> > +             struct strbuf gitdir = STRBUF_INIT;
> > +             strbuf_repo_worktree_path(&gitdir, r, "%s/.git", path);
> > +             if (repo_init(&subrepo, gitdir.buf, NULL)) {
> > +                     strbuf_release(&gitdir);
> > +                     return NULL;
> > +             }
>
> This is for the modern "absorbed" layout?  Do we get a notice and
> encouragement to migrate from the historical layout, or there is no
> need to (e.g. the migration happens automatically in some other
> codepaths)?

No, the absorbed would also be handled by repo_submodule_init.
I wrote a patch once to migrate repo_submodule_init to take a
"struct *submodule" instead of a path as the third argument, which
would fall in line with this patch as well, I'll dig it up.

Historically git-fetch supported repositories that are not submodules
(but have a gitlink and a working tree in place) as well. That is covered
here. (see comment /* no entry in .gitmodules? */)

> > -             strbuf_release(&submodule_path);
> > -             strbuf_release(&submodule_git_dir);
>
> But if it is a leak, it is easily plugged by freeing git_dir here, I
> think.

Thanks.
