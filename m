Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AFDC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 12:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3511860FE7
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 12:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbhG3Mwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 08:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhG3Mww (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 08:52:52 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFC1C06175F
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 05:52:47 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so9422409oti.0
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMEMAzHYyqp+0rEyIqVoTWcudY/LpTARaevQCDvflG0=;
        b=ZFA5oZm8He3CkbTKiOrn++ajFbfOd9MDhuLYV4SzuoOKeBR+QqngtJzfWtsEGVmEIY
         5m3CBleQ+5+FBvfHABeh6WXkJHt4nk8kDh+w7Kj6PzrWPXX0i+VBksClK9LqQDum/Aq7
         GlgmzSlCWR+I+UCty6Ul20bK5NPJPi/hd8l/8lqNHTjTmlGp21/5A5wkqr8E/i503XTS
         ciVjZuVm5N11i58dXmEMFstWEtgVUfg/oNsyKA7l4CuzMnlxyUR4cF34ytxg2OCq15oN
         XS/cRt4Dz7nnF6YBYy9oQ0Tzs5/FrrXzyMbz7Sj6eh6n4jsAyXMY09YOKBpkV9PMxvC0
         vh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMEMAzHYyqp+0rEyIqVoTWcudY/LpTARaevQCDvflG0=;
        b=q8qhbBBOllBBIUWpv7U/cK1fLigv++yte3Chuz3lxpwIgMT01Pn+uzJ8UaTTEJ0Gle
         /8VoomoxarT/Wsly0KLpFtKEXx8lbq4JNAIorTNKpswiygP8d51ET6RTux7ov9q4UmlD
         s6bHupla6ooXZUH/9+9GJh+P0tMk1rAb9RvQ8PSgpgk+1dkipdYbXXHa9i7ToiyaoOUv
         SxtFUuv09e+x0Lq7gKIAENjwzfEDUThDSQwcBxdAQg0Sc216pn806Jmm7s2bRchKzgHH
         irQsY+zZO249MkrwRAXmjL8hiivdldLnfQKHXa3UUwhVAgg1jW1rUwqAdAH9bY+x2j9+
         2jhw==
X-Gm-Message-State: AOAM533IE4poImHhChPJ/oYxdFu32u7bTWSEuYy7xd2D7UgQJfegKc64
        TdBeYoRElnQCxKjSdn52MeWL7DHX1DbBrEVt+nA=
X-Google-Smtp-Source: ABdhPJy949aiJKF/6PMzhDvPm5NXZyVSz0SZnQX9ke7NgWhh4uq1du+POtI0fVX8MUZ448baWHue8Rn8ZKyk30AChXU=
X-Received: by 2002:a9d:448:: with SMTP id 66mr1843709otc.345.1627649566453;
 Fri, 30 Jul 2021 05:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
 <pull.999.v2.git.1627312727.gitgitgadget@gmail.com> <CABPp-BHnvEPuYahFAoVSF58k99t__N2-M4OKKHDAAK2qrhY3WQ@mail.gmail.com>
 <6a63736a-feb8-b74b-ef68-73cc71009e1d@gmail.com> <CABPp-BGUTg=GarkhP0MwjWKWmDyRJiEL2J75wFz52y2xi_50mw@mail.gmail.com>
 <2a24488f-d0c8-d1f4-7115-36ac0745658d@gmail.com>
In-Reply-To: <2a24488f-d0c8-d1f4-7115-36ac0745658d@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Jul 2021 06:52:35 -0600
Message-ID: <CABPp-BE58FqpD3u2ECZUzMJ=3oNBYHshkKzf+sZWkaeHG8SxWA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse Index: Integrate with 'git add'
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 8:49 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/28/2021 10:57 PM, Elijah Newren wrote:
> > On Wed, Jul 28, 2021 at 8:03 PM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 7/28/2021 7:13 PM, Elijah Newren wrote:
> >>> On Mon, Jul 26, 2021 at 9:18 AM Derrick Stolee via GitGitGadget
> >>> <gitgitgadget@gmail.com> wrote:
...
> >> I agree about ignored files, and that is true whether or not they
> >> are in the sparse cone.
> >
> > Yes, and...
> >
> >>> I think the same logic holds for adding untracked files
> >>> outside the sparsity cone.
> >
> > In my opinion, "outside the sparsity cone" is another form of "being
> > ignored", and in my mind should be treated similarly -- it should
> > generally require an override to add such files.  (Case (c) possibly
> > being an exception, though maybe even it shouldn't be.)
>
> I don't hold that same interpretation. I think of it instead as
> "hidden" files, but they still matter. I also think that advising
> one to adjust their sparsity patterns might be dangerous because
> not all users know the ramifications of doing that. They might
> accidentally download an enormous amount of data to correct a
> single file.
>
> Having an override seems like the best option, and we can hopefully
> make it consistent across all the cases and commands.

I think we might be arguing two sides of the same coin at this point.
We don't have a more general term for special in a way that shouldn't
be included by default with git-add, and I couldn't think of a good
synonym, so I used the words "another form of being ignored" (not
trying to imply that it was the same as .gitignored, but just that the
two were special in a very similar way) while you tried to highlight
the differences using "hidden" but agreed they were similar in that
they should have an override.

Fair point on adjusting sparsity patterns and the data download it can cause.

> ...
>
> > Trying to get out of a corner we paint ourselves into with
> > sparse-checkout would be massively harder, which is why I keep harping
> > on this kind of thing.  I'm very concerned it's happening even despite
> > my numerous comments and worries about it.
> ...
> > I'm totally fine with such changes not being part of this series.  I
> > just don't want a test_expect_success that checks for behavior that I
> > consider buggy unless it comes with a disclaimer that it's checking
> > for existing rather than expected behavior.
>
> I understand your perspective. I'll send a v3 soon that adds a
> comment on top of the entire test signalling the things we talked
> about here: this is a documentation of behavior, not an endorsement,
> and we should probably change it because users can get confused.

Thanks for doing that.  :-)
