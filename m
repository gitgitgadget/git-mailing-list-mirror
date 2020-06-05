Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F7EC433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE48206FA
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFd98Vrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgFESqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgFESqs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 14:46:48 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1B6C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 11:46:47 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id u23so8404780otq.10
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 11:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XoxzRQ7fAoDdELpVoN6Xt1Snq23NGdLC9CBAZuzfPOk=;
        b=qFd98VrvYl9r6KWPqRduoauG41CoZZBWh04xK7mZQyb81pSQuphJCmHRsmX8XJjYKe
         fRndO1eo9kPTtAaXIP2E2Cw+wn4lpFyLHHBLa27DL74QNI/0T1CNQo5JHtpPTa+4CJeO
         RA2bRf+Sby76+8HH6S65w7WWAmql/oC6/9YFy196WjvRnZMgu/7dn0ZzYiHwtvbtdhzu
         /c14qGNyx8uha8VO5DHopZUNTyIc4azbpHPsgoAMMysCE9+IOrXn6fvrZwmoMJASoa48
         D6/KBjXcKTO08G5aKrWNyaDKjsjp/IUoPA5C1aPEf3ydzmsd8XDI72vnSORlzpqIC3jn
         p1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoxzRQ7fAoDdELpVoN6Xt1Snq23NGdLC9CBAZuzfPOk=;
        b=tlpARYNLMDcmNOul5Vio06BHw9CpP/fZ5XHXHDlV/p2EflOubChQDyqgtXDggN6U7z
         h+4/h6FwVB956U42X3d1Yhm/KKXjzge4b8x4Nv9IR/C0AzPNZMhbP6oqeKhrxuMizTdi
         TK8/wkxKGELC//KipYeHBKbChKaFM8fYipwRCZbPH9DUVFRBU8VnNqJN+JHf9nL55bkR
         WXlHSLMf646VbJ0bGgtgyEHKB448gtLB2pnueZxll0D8NNq5QQaMzQ20Ca51uvMtg6aL
         S5nUneWz6ldl6PE8mD711iNfZ73sGmkVPxEfDj4igUYbCo6gpGEdNfNK5h0p2FUQCkJc
         l5eA==
X-Gm-Message-State: AOAM531H23/YL/jhbyQIwN36lL4ciEPW7bowMBS1ctfKS9hosblsb7pg
        lwB+Hz3jom1HWzALMAzWaHBfk6XJWZVd8bP/uYM=
X-Google-Smtp-Source: ABdhPJwQ+dHS8zuqsbrGZ4I3hCbyv8YkLq0kfqCESV0YZrXLhE6muXcPrSd4mbw/+cdOWs8sWSrUsnavLBQnGvD0Wcc=
X-Received: by 2002:a9d:6c07:: with SMTP id f7mr8844477otq.345.1591382806918;
 Fri, 05 Jun 2020 11:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJmdR_pG74x0Zn43MSm7zXNcoitqjjOy+WnhyGBW+oFjVFLbRQ@mail.gmail.com>
 <CABPp-BEPOn_JL1FDA-z1jfkfej4dEbbODkcmzNWwY7V-=WsMVw@mail.gmail.com>
In-Reply-To: <CABPp-BEPOn_JL1FDA-z1jfkfej4dEbbODkcmzNWwY7V-=WsMVw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 5 Jun 2020 11:46:35 -0700
Message-ID: <CABPp-BEBKyE2NVfREov6k5qML5jryLjtzw=Y21EA=fHXA0PO5A@mail.gmail.com>
Subject: Re: Possible regression in `git grep --untracked` pathspec matching
 in v2.27.0
To:     John Millikin <jmillikin@stripe.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 3, 2020 at 7:14 AM Elijah Newren <newren@gmail.com> wrote:
>
> Hi,
>
> On Tue, Jun 2, 2020 at 8:30 PM John Millikin <jmillikin@stripe.com> wrote:
> >
> > In v2.26.2 and earlier, `git grep --untracked` with negative pathspec patterns
> > would filter out paths matching those patterns. In v2.27.0, this no longer works
> > as expected.
> >
> > Example output:
> >
> > # v2.26.2 (good)
> > $ ./git grep --untracked --files-with-matches -e '.' -- 'quote.*' ':!quote.c'
> > quote.h
> > $
> >
> > # v2.27.0 (bad)
> > $ ./git grep --untracked --files-with-matches -e '.' -- 'quote.*' ':!quote.c'
> > quote.c
> > quote.h
> > $
> >
> > I've bisected the change to commit 95c11ecc73f286e0a95d9591ae98f1221efe4633,
> > which changed the handling of path matches in callers of `fill_directory()`.
> >
> > It's not clear from git-grep(1) whether the old or new behavior is "correct",
> > so I request that the fix include a clarification of expected semantics.
> >
> > Thanks,
> > - John Millikin
>
> Oh, fun, an issue from _that_ series.  At least the commit you
> bisected to wasn't 8d92fb292706 (dir: replace exponential algorithm
> with a linear one, 2020-04-01), though.
>
> Thanks for the detailed report.  I'll try to get some time to take a
> look later this week.

For those looking through the archives or threads later; see
https://lore.kernel.org/git/pull.803.git.git.1591381428302.gitgitgadget@gmail.com/
for the fix.  Some day, maybe I'll tweak GitGitGadget to accept
In-Reply-To...
