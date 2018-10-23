Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4A21F453
	for <e@80x24.org>; Tue, 23 Oct 2018 23:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeJXIDi (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 04:03:38 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:48072 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeJXIDh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 04:03:37 -0400
Received: by mail-yw1-f73.google.com with SMTP id w190-v6so1993571ywf.14
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 16:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YXltBDpFK7HdFL+c8MNli4KEf+Q/eVmLdIbugNvGhRw=;
        b=V5JfmZU0yjpFeSKj8+e3qOpolD8TagBPVdesjDzRFZKl2SU1OCw7g57WlQ4w8oLCnX
         vJ97eB8xZr7iViIpcxA6HMQk1Nd0PhE64nZo3UIH6Y8foQuP0jJkJo4rIaxCpr/dIACB
         CCHqeEHyGlWPMLFrbNb4dMkL78ba7hBAtcyyJ9erWOhYUywCS73wSZ6Ts0hXiow4hVcU
         kw6nIg2JPgZ6m3W+G0Iz50eluk/fOCokXbBz0ALmYqCKc7AKLn73nVxe2fEFC7+W0xcw
         LyOBTmj+h1czIXQlArcRroWtfXo7gV1DOeKN0b5n9s28DVfFACGJsfj/+wzAbwpf7dX4
         GVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YXltBDpFK7HdFL+c8MNli4KEf+Q/eVmLdIbugNvGhRw=;
        b=bVCahCjv2dDJXzHJznvbx+hXwvUtXl7vrlsrCoSJcWrvAAIqpLYjN2tyZ8+hRHsZ1a
         m7F7UPp9AusvB5W+YHTPE1kFsi+cdQfBXgaBGMkw7Qq6aVkBBHcMZOr04H/HvRwMs92w
         BgidnreDpOWGAckLiQO182vZXXYDEsvwxPCnYBexnrInHLlZl9hhzZ/sacdhfQXuxXh4
         4BQzhbwNXS+Om2DFmSBB6gSXq6aNK8e6o0Fm8y+u2tgx3JnrAVCVIhTQcRlPuFw/xdMb
         5JaVhB29fwpZZjcxkmVYaHwxOTDpiknxHCYY+5XNGlBQzwaJyz9oL492a/GlNQqEqIku
         P6Yw==
X-Gm-Message-State: AGRZ1gIBol96nZyaFF/82tFkWxRd5LBjd0f8ekSY+R1ESG/hzhZF/3a8
        yEj5BwX53vL3pJL0Yn5+TTHZ0JfCpUYffCud9XBR
X-Google-Smtp-Source: AJdET5d9jUvrjlX4P/PnJZUjcKRVpOt1cCbwJssojJ/pCLouU4lmzmsxeE2tDlQZtz4rbdb8B/7b8fPTwb3zg6ijv8Sh
X-Received: by 2002:a5b:305:: with SMTP id j5-v6mr233414ybp.43.1540337880298;
 Tue, 23 Oct 2018 16:38:00 -0700 (PDT)
Date:   Tue, 23 Oct 2018 16:37:56 -0700
In-Reply-To: <CAGZ79kZrK5G-EeGRzxyw0xW3ozo9_aPab4r8fn_Jc4hzKDOEwg@mail.gmail.com>
Message-Id: <20181023233756.190026-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAGZ79kZrK5G-EeGRzxyw0xW3ozo9_aPab4r8fn_Jc4hzKDOEwg@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 8/9] fetch: retry fetching submodules if needed objects
 were not fetched
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     jonathantanmy@google.com, gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Another thing you need to clarify is what happens if the fetch-by-commit
> > fails. Right now, it seems that it will make the whole thing fail, which
> > might be a surprising change in behavior.
> 
> But a positive surprise, I would assume?

Whether positive or negative, I think that this needs to be mentioned in
the commit message.

As for positive or negative, I tend to agree that it's positive - sure,
some previously successful fetches would now fail, but the results of
those fetches could not be recursively checked out anyway.

> > The test stores the result in a normal branch, not a remote tracking
> > branch. Is storing in a normal branch required?
> 
> In the test we fetch from another repository, such that in the
> repository-under-test this will show up in a remote tracking branch?

If that were true, I would expect that when this line:

> git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2:refs/heads/my_branch &&

is replaced by this line:

> git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2 &&

then things would still work. The tests pass with the first line (after
I fixed a type mismatch) but not with the second. (Also I don't think a
remote-tracking branch is generated here - the output printed doesn't
indicate so, and refs/changes/2 is not a branch anyway.)

> > Also, do you know why this is required? A naive reading of the patch
> > leads me to believe that this should work even if merely fetching to
> > FETCH_HEAD.
> 
> See the next patch, check_for_new_submodule_commits() is missing
> for FETCH_HEAD.

I see in the next patch that there is an "if" branch in
store_updated_refs() without update_local_ref() in which
"check_for_new_submodule_commits(&rm->old_oid)" needs to be inserted. I
think this is a symptom that maybe check_for_new_submodule_commits()
needs to be extracted from update_local_ref() and put into
store_updated_refs() instead? In update_local_ref(), it is called on
ref->new_oid, which is actually the same as rm->old_oid anyway (there is
an oidcpy earlier).

> > > +static const struct submodule *get_default_submodule(const char *path)
> > > +{
> > > +     struct submodule *ret = NULL;
> > > +     const char *name = default_name_or_path(path);
> > > +
> > > +     if (!name)
> > > +             return NULL;
> > > +
> > > +     ret = xmalloc(sizeof(*ret));
> > > +     memset(ret, 0, sizeof(*ret));
> > > +     ret->path = name;
> > > +     ret->name = name;
> > > +
> > > +     return (const struct submodule *) ret;
> > > +}
> >
> > What is a "default" submodule and why would you need one?
> 
> s/default/artificial/. Such a submodule is a submodule that has no
> config in the .gitmodules file and its name == path.
> We need to keep those around for historic reasons AFAICT, c.f.
> c68f837576 (implement fetching of moved submodules, 2017-10-16)

Ah, OK. I would call it a fake submodule then, and copy over the "No
entry in .gitmodules?" comment.

> > Will task->sub ever be NULL?
> 
> Yes, if we fall back to these "default" submodule and just try if it
> can be handled
> as a submodule, but it cannot be handled as such,
> get_next_submodule_task_create has
> 
>     task->sub = submodule_from_path(r, &null_oid, path);
>     if (!task->sub) {
>         task->sub = get_default_submodule(path);
> 
> and get_default_submodule can return NULL.

Ah, yes you're right.
