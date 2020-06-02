Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E95FC433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 16:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443FD206E2
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 16:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj5Ao6Sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgFBQyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBQyX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 12:54:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD9FC05BD1E
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 09:54:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so11975089ljc.8
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 09:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZOTvjhjew6Tqx5jyccT5jVnfHJlCPMxmyUCyUvvJfE=;
        b=jj5Ao6SbUGTH3shlZ26rq4gf5ZvKhSleR2J7OqmQmIVVM+UExx0grM8tG5xJgOhGPq
         6CPnD/5uxrEU+UIitURTRRwRQyj0nrgVfULJAtK2xmGX2eMR6UEv7pQyV+kPN4eWVVhJ
         Dq0nQV8//H6ys+4S2aPFLkFJHy5Y3PGDDtvgzSo9gDtDeMgVxkFY6F8nkgRRsA9d4xUl
         cN4Lp8dNrOOBZJBmYnrVeNQI4eIop7eiII1AkGnT4pQ4oMwPrcsIhNjvdDVZ8O2w8qCi
         P6bczDRfWjAe/OE4AYD1rAHYCGCNccArMmZGkEvtVJBhi/KIR06ZVRiMUDLHA3LDoBcX
         c0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZOTvjhjew6Tqx5jyccT5jVnfHJlCPMxmyUCyUvvJfE=;
        b=BpdfMqU7dQqnmOeZa/KC1y3lWrhgypLf8SEViYifW0Gz6sGEKbbwxRUI8Vd15KCkVP
         3e/avsaTce8ojh7VaUC5kjFaHEi+R/WTSoOZRmha6g+xlaamyen3xijhqlLzjb0AEUOJ
         KoQgtxzNYo/PhapEhRyeHiTo32MmNzlNIyhcRqSblJuTvI+OmiqnfHWhi9vMYiKWcHqV
         EpspTj45L8WZH+QLtCLDw7HvfCm+ywYEnGm2IZ9pdp1rstWGI8OZSsQ7aqGC1fEKpQh6
         EbSk8vgGIOIPtoeAjkMBT9RD/V7wdNHiSY2OTUSeXolrLJGLsxEdf8f8SqMnZAQXSSKK
         0qFA==
X-Gm-Message-State: AOAM532NheCLaNKXjsNFb16xgwl/rI6uWzoJ1ybmeriN77hxMmPItAlP
        mCseQCphhqT2iG0Dz20QQyDBZWxEbcxQlOBefq0=
X-Google-Smtp-Source: ABdhPJwuxfWtWbiocmTB2rA1tgs533bKoQoROYHvCM4jAzGSn+6wGM12/2LcnXWlGyfKATpcTXcZz/e2pj4KR+hoX3w=
X-Received: by 2002:a05:651c:11c5:: with SMTP id z5mr53443ljo.220.1591116861746;
 Tue, 02 Jun 2020 09:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAGKX4vGhTbEqZS9+iYA2wZWRRaddQC6O4KV+zLaNYKkZgN36Xg@mail.gmail.com>
 <20200601214003.GA3309882@coredump.intra.peff.net> <xmqqr1uxtow4.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1uxtow4.fsf@gitster.c.googlers.com>
From:   John Siu <john.sd.siu@gmail.com>
Date:   Tue, 2 Jun 2020 12:54:10 -0400
Message-ID: <CAGKX4vFcqQ_0XFb5qOku9wAxF3+fj-fByrm+zmSXHr3k60yjKw@mail.gmail.com>
Subject: Re: Git multiple remotes push stop at first failed connection
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 2, 2020 at 12:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > There's really no benefit to doing it all in a single Git process, as
> > we'd connect to each independently, run a separate independent
> > pack-objects for each, etc.
> >
> > I'd even suggest that Git implement such a loop itself, as we did for
> > "git fetch --all", but sadly "push --all" is already taken for a
> > different meaning (but it might still be worth doing under a different
> > option name).
>

Yes. We notice the fetch/push --all is for branches.

> I wonder if it is possible to update the implementation to do so
> without changing the UI at all, though.
>
> The presence of the "--all" option in "fetch" command is tied
> closely to the fact that it makes no sense to have multiple URLs
> that are used to download from at the same time under a single
> remote name (e.g. what should "remotes/origin/master" point at if
> two URLs say different things if such an arrangement were allowed?).
>
> On the other hand, the pushURL for a single remote can be multiple
> places for redundancy (a possible #leftoverbits here is that we
> should probably disable the "pretend that we immediately turned
> around and fetched from them after pushing" optimization when
> pushing to a remote that has multiple pushURLs defined) does not
> need an extra option.  If the way we currently push is suboptimal
> and it is better to spawn a separate "git push" instance via the
> run_command() API, that can safely be done as a bugfix without
> affecting any UI elements, no?
>

I agree a "bugfix" for push only is good enough and safe. As the
current behavior is already pushing to all pushURLs of a single
remote. We are not trying to change behavior or do anything extra.
