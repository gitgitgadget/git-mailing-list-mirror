Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618751F609
	for <e@80x24.org>; Thu, 29 Nov 2018 00:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeK2LeQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 06:34:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35675 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeK2LeP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 06:34:15 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so446722edx.2
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 16:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klIGNYG1ACUAV6xD908dBolEHQrwJe+8EIeCp4R3VLQ=;
        b=Nl+GAJIhVhVj0C/QkOJmsgex4xHSBUx9L2wi6CfXm4h21AZWBdrfMkdNkN9V3h5sQp
         WfSiaUAqF0YrfaRDFqAbtNBFewZKpq50Re1I/h8VIxtkMdG5EV5GbzQ/gxS+srcQMiJ/
         +/ZwdJdaXNhjoJFtwFWa0g2cF6psMHk89pMv6BvMCTmF0UtdaVsSoZEoEh8KYVKIOq7G
         C4ODh2YIfgNirZyeVMniQDBbRUaAFgEdNhNShqiOpdr9hS85m2P8Fr435gDpy0oczZ14
         +YRhHG+auoyB6wLTHsTqlmUV1ytFWj2HOxkoZknF8eVnprsrpoZkzen2zEGq3YW7wjxF
         bNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klIGNYG1ACUAV6xD908dBolEHQrwJe+8EIeCp4R3VLQ=;
        b=PLngQRpEVV4JcEh8EDLL1iWKFBUYms5uW2pkauTlaS3FXU4d+eBOgKetleml3A62Ex
         vlTtOwWOFxLSxd8Xw+EPxT75fofneYq+NTATDFOu5bTSA4JudhpIhy8Docaq17+basW6
         3+SQn2G1PA1hQ9qfv3x0/AKY+KOmAamV2REnz13Int1BaJWwomH+iCaMnJxun0u/XAJR
         2EelzD9qFr26dY2TF5AJ/5KJY1Myc+JUKGvPW5j6lKiavlQHp+Uq4pM9ycNzmCbOyUgg
         pvlFWuISWL7yY8TDiDiB1tFMmwqed7hD1wpl0canzkM7sPli9mM/KLgoMhWX/uZlKUJw
         SvKw==
X-Gm-Message-State: AA+aEWZmJRAMEnGg2DMjks75EvbbwoL69GjTGD03XVnoooXVdY5f7vNZ
        xP7lL51JpOI7lxdiXGYi7VnnUO/NkbFTGIpLuFBNQW/Uah8=
X-Google-Smtp-Source: AFSGD/XJRn/jHY2u7Tc7gMZdVSI2F6NZoktPu3ymwZOBRurO0m8dMC07QpGcagoGXmiT7W0eDM0JkEe20H5a7etIZoU=
X-Received: by 2002:a50:acc3:: with SMTP id x61mr31568244edc.76.1543451446122;
 Wed, 28 Nov 2018 16:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20181025233231.102245-10-sbeller@google.com> <20181026204106.132296-1-jonathantanmy@google.com>
In-Reply-To: <20181026204106.132296-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Nov 2018 16:30:34 -0800
Message-ID: <CAGZ79kYAyf9-9dNaaok-z-7WT9E-dC7RX4Sxd-9HBc2Qvr5mgw@mail.gmail.com>
Subject: Re: [PATCH 09/10] fetch: try fetching submodules if needed objects
 were not fetched
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 1:41 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > But this default fetch is not sufficient, as a newly fetched commit in
> > the superproject could point to a commit in the submodule that is not
> > in the default refspec. This is common in workflows like Gerrit's.
> > When fetching a Gerrit change under review (from refs/changes/??), the
> > commits in that change likely point to submodule commits that have not
> > been merged to a branch yet.
> >
> > Try fetching a submodule by object id if the object id that the
> > superproject points to, cannot be found.
>
> I see that these suggestions of mine (from [1]) was implemented, but not
> others. If you disagree, that's fine, but I think they should be
> discussed.

ok.

>
> > -             if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
> > -                 (recurse_submodules != RECURSE_SUBMODULES_ON))
> > +             if (recurse_submodules != RECURSE_SUBMODULES_OFF)
>
> I think the next patch should be squashed into this patch. Then you can
> say that these are now redundant and can be removed.

ok.

>
> > @@ -1218,8 +1218,12 @@ struct submodule_parallel_fetch {
> >       int result;
> >
> >       struct string_list changed_submodule_names;
> > +     struct get_next_submodule_task **fetch_specific_oids;
> > +     int fetch_specific_oids_nr, fetch_specific_oids_alloc;
> >  };
>
> Add documentation for fetch_specific_oids. Also, it might be better to
> call these oid_fetch_tasks and the struct, "struct fetch_task".

ok.

> Here, struct get_next_submodule_task is used for 2 different things:
>  (1) After the first round fetch, fetch_finish() uses it to determine if
>      a second round is needed.
>  (2) In submodule_parallel_fetch.fetch_specific_oids, to tell the
>      parallel runner (through get_next_submodule_task()) to do this
>      fetch.
>
> I think that it's better to have 2 different structs for these 2
> different uses. (Note that task_cb can be NULL for the second round.
> Unless we plan to recheck the OIDs? Currently we recheck them, but we
> don't do anything either way.)

I think it is easier to only have one struct until we have substantially
more to communicate. (1) is a boolean answer, for which (non-)NULL
is sufficient.


> I think that this is best described as the submodule that has no entry
> in .gitmodules? Maybe call it "get_non_gitmodules_submodule" and
> document it with a similar comment as in get_submodule_repo_for().

done.

>
> > +
> > +static struct get_next_submodule_task *get_next_submodule_task_create(
> > +     struct repository *r, const char *path)
> > +{
> > +     struct get_next_submodule_task *task = xmalloc(sizeof(*task));
> > +     memset(task, 0, sizeof(*task));
> > +
> > +     task->sub = submodule_from_path(r, &null_oid, path);
> > +     if (!task->sub) {
> > +             task->sub = get_default_submodule(path);
> > +             task->free_sub = 1;
> > +     }
> > +
> > +     return task;
> > +}
>
> Clearer to me would be to make get_next_submodule_task_create() return
> NULL if submodule_from_path() returns NULL.

I doubled down on this one and return NULL when get_default_submodule
(now renamed to get_non_gitmodules_submodule) returns NULL, as then we
can move the free() from get_next_submodule here and there we'll just have

    task = fetch_task_create(spf->r, ce->name);
    if (!task)
        continue;

which helps get_next_submodule to stay readable.


> Same comment about "on-demand" as in my previous e-mail.

I'd want to push back on refactoring and defer that to a later series.

> Break lines to 80.
[...]
> Same comment about "s--h" as in my previous e-mail.

done

> > +     /* Are there commits that do not exist? */
> > +     if (commits->nr) {
> > +             /* We already tried fetching them, do not try again. */
> > +             if (task->commits)
> > +                     return 0;
>
> Same comment about "task->commits" as in my previous e-mail.

Good call. I reordered the function read easier and added a comment
on any early return how it could happen.

>
> > diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> > index 6c2f9b2ba2..5a75b57852 100755
>
> One more thing to test is the case where a submodule doesn't have a
> .gitmodules entry.

added a test.

I just resent the series.

Stefan
