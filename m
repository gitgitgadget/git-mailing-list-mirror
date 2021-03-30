Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB73CC433E2
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 22:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B005D619CD
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 22:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhC3WoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 18:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhC3Wno (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 18:43:44 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE43C061765
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 15:43:44 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id n8so18063365oie.10
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 15:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BmWF+hCQ3R8vHaIrKgo9E7jrLHgQCcgV/TZGg88tf+0=;
        b=N1OK92+hTq8Ndd/XHM06Dbnss5bE9JWov+2WUCkK/Rckcq1cZh822W8NlnqtytKoCE
         S636k4zLaC40rja3wZJ4yWLU5hioHQ0La4gedxDx9zhKTQT69Akp2nLmmf5MRLyQtbVQ
         S/l+9vAZg82V+5xWx/rAe99vg8WDWD0erL5CRE+UuWBTFdRIFJupHD+dT0PcO+/G+rP3
         QamyjsLT001tiKQO0xLyVv3/xYdkt3PgCgvNcqPw56A6WhZhdXOjITHjOyFG8+G13hIt
         cc9WDKRbxqFe0XPFnc8Mpm20WYwoWGvw3oyu3Yrk+ji9ubj9xMaW1WPizSvA5eKgbvlV
         0WSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmWF+hCQ3R8vHaIrKgo9E7jrLHgQCcgV/TZGg88tf+0=;
        b=oWM0sU/JC8UVzbjsJ2hYaQZqBg4cd+nU0erYwEUcUJakfrs7eEliUbU8/mITe2n+Kr
         v9Afautxww1AJd5+S80G/UpXtntcaBQKTYek3Z8/nIZzMgoewV9ag4cGoB8XYjGSJSJj
         LFHe5oId/mIZKh0Dov/HlpEGLPpZnHa/EA6qucflcrgHCUMZpARkZ3q9dNRNJ+d3r1+t
         V9FwenUX9USB9ClVZC7TurgxdK3v/5N2LInv3CgSM6ylx3s8jw9dq9LPKAQVa4PFBU9k
         JZ1dMVsi/7m2WgmTUJ1xQyr7xCz7MfCu8wW96lIk3okB4ko69fK6C0eb6TjiKOJQQsBB
         QDFA==
X-Gm-Message-State: AOAM532T10lTpdXlaGUR/dUULJ3sxvSrgjMdHZ3xjMZXxwI4F4I+WQw0
        mCysjKWnIUGt/7Vt3j7/cXzxcCNW3O8NBBBq86O24FgfJopWqA==
X-Google-Smtp-Source: ABdhPJw4hjFt/I/NVFYhDXHMMV/FtTCuAyJOSLEarEX8kIA3U2VPNX/jG7KMf4FugxG/X9pdmQmOd1Do7OzvkEUvkfQ=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr121110oij.167.1617144223778;
 Tue, 30 Mar 2021 15:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEAbN05+hCtK=xhGg5uZFqbUvH9hMcCNMcBWp5JWLqzPw@mail.gmail.com>
 <YGLNBFJv8NKmrbvz@coredump.intra.peff.net> <xmqq35wceae6.fsf@gitster.g>
 <CABPp-BEE0eksCJSAviDh5GyqsOu=i_mW3VY6SEULa4kx0NsUMg@mail.gmail.com> <xmqqa6qkcnqa.fsf@gitster.g>
In-Reply-To: <xmqqa6qkcnqa.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Mar 2021 15:43:32 -0700
Message-ID: <CABPp-BEVFi+EsGMCv=qEhe_OGwmWwXF-mg9rjWYNuF0tDZnASg@mail.gmail.com>
Subject: Re: Bug report: git branch behaves as if --no-replace-objects is passed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 2:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Using your own words:
> >
> > "the replace mechanism is about telling Git: when anybody refers to
> > deadbeef, use its replacement if defined instead."
>
> "When anybody wants the contents of deadbeef, give the contents of
> its replacement" is what the replace (graft, too) is.
>
> > git branch didn't do that; it put deadbeef into refs/heads/foobar.
>
> Yes, but refs/heads/foobar having deadbeef does not have a problem,
> as long as you get the contents of the replacement object when you
> ask for the contents of deadbeef (or "the object referred to by
> the refs/heads/foobar ref").

Your "as long as" is I think the assumption that's violated in the
workflow in question.  You may have the replace ref defined, but
others don't[1].  Neither party has the actual original deadbeef
commit[2].  Having deadbeef in refs/heads/foobar leads eventually to
creating commits with deadbeef as an explicit parent, as we discussed
above.  While that's internally consistent, as you point out, can you
push your new commit elsewhere without pushing the replace refs too?

* If you can, isn't that repository corruption?

* If you can't, how are users supposed to understand, debug, and
correct the fact that their history is unshareable?

Why does `git branch` (in conjunction with one user deciding to fetch
replace refs) make it so easy to create a branch that cannot readily
be shared with others?


[1] Everyone can get the replace refs, but fetch/clone does not grab
them by default, and push does not include them by default, so it's
multiple manual steps.
[2] For the rewrite at $DAYJOB, we'll make it as hard as possible for
users to access the original deadbeef commit(s).  People who cloned
the old unrewritten repo in the past might still have it somewhere if
they didn't follow instructions to delete old clones and reclone, but
new hires won't have deadbeef and won't have a way to get it.
