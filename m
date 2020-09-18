Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDE3C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6EF21734
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulJjeK57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRRwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRRwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:52:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EF4C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 10:52:25 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so5807756ljk.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nhznBW6yt+1hMw7UsK4R7XZaY0TERvweRS7yJIuvGA=;
        b=ulJjeK57QhiMKxwy0Dyjf9iBUh9RVSSrF7wN3KafNTlcWhuEvUX36bWGtNxX9mne1q
         7JbtS/uyTVI9UlnnNVGdRflKzbPgF8SRFTpv+e9X+nRWt+4sNKQ+wYGS4LT9a+H4psoM
         fEL41/MUno1qPFa0traTdO5qpST5oDZL6c3nOw72Mf3iDSY6HMiSBt0/aqU+yLfduFSN
         YC/buYLBkjwDYRHM3d5SBSA3EIKdfSk+TDZBUFGansyqu6nQzWlWZ9PccDzVmZqIVIvt
         MROoX4KGVZNIpRfPpTxnSxNNwkcto9NGKJ2Iqz2F8f6y74wyBxRfiNaRg/BtYv1iwKWy
         +LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nhznBW6yt+1hMw7UsK4R7XZaY0TERvweRS7yJIuvGA=;
        b=Iy5KbY+RD7e3tYrTfY6gExlpE5WOCW1W0CejeBdG0Cwqq9fsZKQ2TkEeQmLFGHdoIn
         f8RRzexIeyrtiv+5PtN8kMHGuwHlvbm54lwHBsKVU/nNbEQOB/BhnRtPsdCQkz/0Jqg3
         3+9Lro5LhJJ8QhjB4hbtNTgZ+jmHp3AZBoOCdjxHOq+knG/8TxByuFzuUrxwKN18Ck/6
         +vboGOvBn2fmGaXX4EIx3gfFEO7PAPCJAHB19cQM9iIQoWCcXVr6rFsCA3jjPN6JC0u/
         YsH8iFE5MFlG5KFUEUjD04aoDNMGsCqmxGJCKV0oPMh8R9ZD9k6oRrVKHX3LcSV9moh1
         qA6g==
X-Gm-Message-State: AOAM533G6RRuT+Go7Tqoo75MQ0ifz0Hz/qU1SOWDsGC8rskrbZ6/YHZ5
        iQiMy4sXgIvl1G2qCz7qVRHm1KmZy/AU+oaOXr4=
X-Google-Smtp-Source: ABdhPJytUvUcVChvIW0D7IThX56VuNyCR5UDk/dYG8H6fwMBurtJVBNCCBZAZcSwXTYF21kLOp0pRgPDUHGlL/YNRJ4=
X-Received: by 2002:a2e:7602:: with SMTP id r2mr12389728ljc.10.1600451543210;
 Fri, 18 Sep 2020 10:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200918113256.8699-1-tguyot@gmail.com> <20200918113256.8699-2-tguyot@gmail.com>
 <20200918172747.GD183026@coredump.intra.peff.net>
In-Reply-To: <20200918172747.GD183026@coredump.intra.peff.net>
From:   Thomas Guyot-Sionnest <tguyot@gmail.com>
Date:   Fri, 18 Sep 2020 13:52:11 -0400
Message-ID: <CALqVohcZrBcjmonw-peVxUNM1kgEheCr3nAk9ZvajGpbpXsNaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and --numstat
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Thomas Guyot-Sionnest <dermoth@aei.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 18 Sep 2020 at 13:27, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 18, 2020 at 07:32:55AM -0400, Thomas Guyot-Sionnest wrote:
> > This patch checks if is_stdin flag is set on both sides and compare
> > contents directly.
>
> I'm somewhat puzzled how we could have two filespecs that came from
> stdin, since we'd generally read to EOF. But looking at the test, it
> seems this is a weird range-diff hack to set is_stdin.

"is_stdin" is actually set manually by a function that copies stdin to
diff_filespec->data. We can get an arbitrary number of pipes from
command line arguments - only difference with stdin is that we have to
open them before read.

The flag seems to have been leveraged by diff-range - the first patch
fixes that tool alone, and 2nd adds support for multiple pipes in
--no-index. Both are independent but you would not be able to --stat
two pipes without the first patch.

> > diff --git a/diff.c b/diff.c
> > index a5114fa864..2995527896 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -3681,7 +3681,10 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
> >               return;
> >       }
> >
> > -     same_contents = oideq(&one->oid, &two->oid);
> > +     if (one->is_stdin && two->is_stdin)
> > +             same_contents = !strcmp(one->data, two->data);
> > +     else
> > +             same_contents = oideq(&one->oid, &two->oid);
>
> ...should this actually be checking the oid_valid flag in each filespec?
> That would presumably cover the is_stdin case, too. I also wonder
> whether range-diff ought to be using that flag instead of is_stdin.

I considered that, but IIRC when run under a debugger oid_valid was
set to 0 - it seemed to be used for something different that i'm not
familiar with, maybe it's an indication the object is in git datastore
(whereas with --no-index outside files will only be hashed for
comparison).

I think is_stdin is a misnomer, but if we want to refactor that i'd
rather do it after.

Regards,

Thomas
