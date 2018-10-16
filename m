Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B891F453
	for <e@80x24.org>; Tue, 16 Oct 2018 19:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeJQDWS (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 23:22:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41835 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbeJQDWS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 23:22:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id x31-v6so22511775edd.8
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sd4zjTXiMGfRoZRWhxxiwFnEPtY8YcYIQmCRGStUxyE=;
        b=sfijUD6eQocOPJPdybRT+FQTVUrDWmo2HIsn05shs7KhH9h6jTHDBhB8DY1CYzG7iX
         jVgpmwW2z3+09Sbobi5mNmr7VCz6g9qmiSX+B2qv/YByHxlMAl53yh0Kwj7mYdNohmWd
         Hx+uvMvSKT0y/nTLbGVYJLT99+sVWfqKdl4Cs+Mx8DnxxZjE3lP+CVqcA0/vbonhpV90
         5eu9RAZHK1SSuZaOncuvy0RmcnGT2isk2P8DD2OZuuEmwYL6Bq5U6/iEP1PZLWjXBPZ/
         RTHOFyK2sl3mqvl6b0l5l0XfagMvcabvgE7mLFOqPkqc1eq1H4IwDtuqw5CfAgM4MBwC
         SDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sd4zjTXiMGfRoZRWhxxiwFnEPtY8YcYIQmCRGStUxyE=;
        b=t1DgvtCRInxNTsPjFo6AL7GOYaIUbbm0mclzbJditqGfeVzzZUmwwrdn3Ws8rLxcpk
         i8Ws1UDHmJ3RMRx/PKOFgH0oGcrIJXXcEYzl4DzAcfFINdWkxB2s1yExMy4oO8ksd7Sc
         6g6yrWaMGdM56OI00QopHHKpdcG+7DmO6RWE9yrjuzSv5MtFRc2894EpWxDda0O9dfLs
         2U5MCizyygWreoU4ZAmW+rUVWgJrmt6dyxu/j9Xu+Rm7svKC66Iv23lQe88jp6cY3L6L
         tWSIYD4FXG19wYu33Ne6ebUCLgaagIAV4Mq1eZoeWXDXvCtPjhzeCWtkCN2NNo+1fXxF
         OBmA==
X-Gm-Message-State: ABuFfohvHe5lmeNXDava4MUkeyyWVzt3EKMeJD8GyOVfej/F3eLRwnci
        pq/n8e99ObM8PWT6tvv6thFkIW8LewqFwQAEcZbc/Q==
X-Google-Smtp-Source: ACcGV6314n8QHCodgPYAKW26lNBoStt5qD4pDpVho+BPG5VZnK3hDv5EaX1ReRX9eIXQc+GV0kAjgxipTd8OGNYATeo=
X-Received: by 2002:a17:906:2da9:: with SMTP id g9-v6mr24854687eji.67.1539718220161;
 Tue, 16 Oct 2018 12:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181011211754.31369-18-sbeller@google.com> <20181011224052.191281-1-jonathantanmy@google.com>
In-Reply-To: <20181011224052.191281-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 16 Oct 2018 12:30:09 -0700
Message-ID: <CAGZ79kYS7at89igHdg163mcZGmsOXO1jj6iBqSZF_VuMEh=g9A@mail.gmail.com>
Subject: Re: [PATCH 17/19] submodule: use submodule repos for object lookup
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 3:41 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > +/*
> > + * Initialize 'out' based on the provided submodule path.
> > + *
> > + * Unlike repo_submodule_init, this tolerates submodules not present
> > + * in .gitmodules. NEEDSWORK: The repo_submodule_init behavior is
> > + * preferrable. This function exists only to preserve historical behavior.
>
> What do you mean by "The repo_submodule_init behavior is preferable"? If
> we need to preserve historical behavior, then it seems that the most
> preferable one is something that meets our needs (like open_submodule()
> in this patch).
>
> > +static int open_submodule(struct repository *out, const char *path)
> > +{
> > +     struct strbuf sb = STRBUF_INIT;
> > +
> > +     if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
> > +             strbuf_release(&sb);
> > +             return -1;
> > +     }
> > +
> > +     out->submodule_prefix = xstrdup(path);
>
> Do we need to set submodule_prefix?
>
> > @@ -507,7 +533,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
> >       else if (is_null_oid(two))
> >               message = "(submodule deleted)";
> >
> > -     if (add_submodule_odb(path)) {
> > +     if (open_submodule(sub, path) < 0) {
>
> This function, as a side effect, writes the open repository to "sub" for
> its caller to use. I think it's better if its callers open "sub" and
> then pass it to show_submodule_header() if successful. If opening the
> submodule is expected to fail sometimes (like it seems here), then we
> can allow callers to also pass NULL, and document what happens when NULL
> is passed.

Thanks for the review of the whole series!

I have redone this series, addressing all your comments. I addressed
this comment differently than suggested, and put the submodule
repository argument at the end of the parameter list, such that it
goes with all the other arguments to be filled in.

I was about to resend the series, but test-merged with the other
submodule series in flight (origin/sb/submodule-recursive-fetch-gets-the-tip)
which had some conflicts that I can easily resolve by rebasing on top.

It conflicts a lot when merging to next, due to the latest patch
("Apply semantic patches from previous patches"), so I am not sure
how to proceed properly. Maybe we'd omit that patch and
run 'make coccicheck' on next to apply the semantic patches
there instead.
