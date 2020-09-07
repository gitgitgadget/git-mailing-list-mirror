Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C93C433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 15:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9F6206B8
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 15:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cabg4aWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgIGPuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730207AbgIGPtd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 11:49:33 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D45C061573
        for <git@vger.kernel.org>; Mon,  7 Sep 2020 08:49:32 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y11so3960679qtn.9
        for <git@vger.kernel.org>; Mon, 07 Sep 2020 08:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyv+EzXtCG3C4N7LuG47dacxgMuXXQD+oX1AUfQZK3I=;
        b=Cabg4aWjJskxZptnWuL2hjCZ35/WlazduZLBYb7jSrHAN4Itkgc/j2xU1YZlm93gsq
         IdAg0j1kBcLKgtd1rrNMxvkbJDdDyWpcjANE0/Bv+JcoAQElT6pbWMX1W58zDgnVOL5Y
         R6fJDNGXy4e+T1xiPr/DIEGFWp2TockXbEnBRtGge04vDDhc7bLoVz9HJqFFp4KA1Vav
         89fUbFLa06rLhHLvnxqHzWhhfLcVoN4gXfDgUeQ9jSD7K9+4UXRKQ7mfRJvX3eefA4WI
         xMvqDP4MrINTdG1br07qNAhSZgwiqZAi/2g8+cvtnVAj7CFVwNtVS59FMD3b7YC91BJh
         P/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyv+EzXtCG3C4N7LuG47dacxgMuXXQD+oX1AUfQZK3I=;
        b=hfm3oQHdRaLRn2XD/aGmnbMbt1d4v0lANv2xHzV/67TShLZ/qGLloUFrDFodHIW+49
         43aVsMHHFDj12K3PlX3XQT4gJOKPFNAQcbzazP80opoynLMI3ZXD+F9WlA7jesOBDqgj
         ATF8H73dsQ6vB0qf4SkJR/IjMtyzAV0t02f4gqNmfrAC+u+prl2X7acj2RoskdgrJgGE
         94on010TbedzAx9KLpbeHsLdFYvKW3eliExwltxHVWkVWF1mhyJsb/R9PDZSqasV6//L
         XiAdo41CnM6JHLws3ymXndyzVQANJLeJ4iF2TxcQpBieKA9+H4mr7o0PcPjXAGzvQHth
         HXQQ==
X-Gm-Message-State: AOAM530pRIa63Ul6d50nOk3+472smlGh1qEUvgaNKlwSpspZADc0O1IA
        F6IfNJJW5JQz3s9VkOUXrCx4zeWJfYD+85GGY/Y=
X-Google-Smtp-Source: ABdhPJyvGmW58ICf7c8DXmaScGfHWHnJNV4huiMIbcmB+9ApSsPCYXiHYwJ5mC6fNuOgshjgABq25YW6JEA4qd1ONEA=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr21549953qtr.263.1599493771871;
 Mon, 07 Sep 2020 08:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.720.git.1599056635276.gitgitgadget@gmail.com> <xmqq3640apsl.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq3640apsl.fsf@gitster.c.googlers.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Mon, 7 Sep 2020 18:49:20 +0300
Message-ID: <CAGHpTB+6spDbsXKpUYXhxbAST4qd-3f9Czga=XmAdRhm4Z-XnA@mail.gmail.com>
Subject: Re: [PATCH] fetch: do not look for submodule changes in unchanged refs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thanks for the detailed review. I posted a new commit message.

On Wed, Sep 2, 2020 at 11:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Orgad Shaneh <orgads@gmail.com>
> >
> > This operation is very expensive, as it scans all the refs using
> > setup_revisions, which resolves each ref, including checking if it
> > is ambiguous, or if it is a file name etc.
>
> Nobody can tell what "This operation" is without looking at the
> patch/diff text.  Our commit message typically gives minimum
> explanation of the situation and the problem it tries to solve first
> to make it self sufficient.  And then we go on to order the code
> base to be in a better shape.  Something along the lines of ...
>
>     When fetching recursively with submodules, for each ref in the
>     superproject, we call check_for_new_submodule_commits() to
>     figure out X and Y for the object the ref was pointing at before
>     the fetch in the superproject, in order to ensure Z.  This is
>     expensive because of A, B and C, but it unnecessary if the fetch
>     in the superproject did not update the ref (i.e. the objects
>     that are required to exist in the submodule did not change).
>
>     Check if we are making any change to the ref, and skip the check
>     if we aren't.
>
> ... but I didn't fill the most important bits in the above, as by
> now you, as the person who encountered the issue and figured out a
> good way to solve it, would know what to fill the placeholders with
> far better than I would ;-)

That was very helpful. Thanks.

> [... snip ...]
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 0f23dd4b8c..d3f922fc89 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -958,8 +958,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
> >                               ref->force = rm->peer_ref->force;
> >                       }
> >
> > -                     if (recurse_submodules != RECURSE_SUBMODULES_OFF)
> > +                     if (recurse_submodules != RECURSE_SUBMODULES_OFF &&
> > +                         (!rm->peer_ref || !oideq(&ref->old_oid, &ref->new_oid))) {
> >                               check_for_new_submodule_commits(&rm->old_oid);
> > +                     }
>
> The original before be76c212 fed ref->new_oid to the check
> function.  Now that we are using ref->{old,new}_oid in the
> condition, would it make more sense to pass ref->new_oid
> like we did before the commit, or is that an object that is
> different from rm->old_oid?

I think that was the whole point of this commit, to cover the case
of !rm->peer_ref, for newly fetched refs. On this case, ref is NULL.

> Thanks.
>
> >                       if (!strcmp(rm->name, "HEAD")) {
> >                               kind = "";
> >
> > base-commit: e19713638985533ce461db072b49112da5bd2042

- Orgad
