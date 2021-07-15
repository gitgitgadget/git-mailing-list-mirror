Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBB5C636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B749461167
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhGORf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbhGORfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:35:25 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB1EC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:32:32 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id c197so7510094oib.11
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPQmTrU8Do4jtaozk6UMdk3feLF4Sj2Hy1zVEomIoTE=;
        b=iJlWBPY5XFlZxZ1a3H8Jtizb7jQ+M9BPk/sOgpE5IihgXHsuXKEsUNPiFOiJfObW9G
         RTPnrY1/IhH7zpTaC5WzvxUFB5qtoKmnDAuvSdXEavYotj1fGscx19YDyxsTnuFMseNQ
         wlTLcJoe7uugrVKYnx5TEK9IDDZNsNdwmzKyRJcvoVN0pdHvXVWn+C4c3P6uxIJ6GcFV
         MtQPZsKoTbFT9fu9AzBZEzok7vTkgzU2VV2S9+b24m5ltKjYCZzMNxb/YKmF8zO4193+
         BAWg0bJQjIo/IJnqE/ppTBTHRCZQ4NyEgnsuR8l8ktbLXrZPPDMjDeKVJwna3L7ad6wZ
         pJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPQmTrU8Do4jtaozk6UMdk3feLF4Sj2Hy1zVEomIoTE=;
        b=TFCSQ5bf5DU+N3GYcXFj4tfNO/DCV3WPTLvHKL/8PcwueT50gRkbbwdKG0aErla3pf
         5jmA3ChJMgaro9Hqai50XfUPcGMQ3jDPBZQ+eUAT4DOWE7C8rLJ5LL+jp8UUOlqo9sP8
         fsr5OQfYfqm4jvr+IAp+EHtdoVbyJEYKmiaovolNmdQ0ral5oNBvYdeeu84NdIiGRwq+
         5ERQYwBbSDyA3p+5t4nrg9dHVe9vvK5Wz6M6ClCUJt4OQcVX21bqwVSv0wnaTbIIqwFh
         EqqKqC/aN68tJx1Eygmt0yTixssDdiiOvMtG+YKxQ4HjTCHaRTy54lqUCnD7u4VSl/2i
         pqYA==
X-Gm-Message-State: AOAM533EjbaT0mc9HkAHyzEo6QTstwMAQ//7L51Xcuq6FT/299EtOxHM
        wdqzgwSRzUNDuY7Cq7XsFyp+5YnKhXgjn10WLG0=
X-Google-Smtp-Source: ABdhPJwWw/YsTPzBVFPUMMV/GCZONPH0KIMhpM9jKFnbrXYCinb2Vi01L1XHLlCqa6i1qVnQTyAx+STgYGQ/1oGXO+I=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr8782247oie.167.1626370351493;
 Thu, 15 Jul 2021 10:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <pull.988.v2.git.1626204784.gitgitgadget@gmail.com> <7133f0efa520b3d0cadb059151daa12484fdb003.1626204784.git.gitgitgadget@gmail.com>
 <d91ed8a0-b37b-7dfa-10bf-e068f30e9691@gmail.com> <CABPp-BF+gR8WtpWt_DVDoWe16R4B65h-59zGOZ5j4vUJKp_Nuw@mail.gmail.com>
 <9260bd3d-2325-fde7-bfa2-081700f6a731@gmail.com>
In-Reply-To: <9260bd3d-2325-fde7-bfa2-081700f6a731@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 15 Jul 2021 10:32:20 -0700
Message-ID: <CABPp-BEHC8dbGmMq9M-Jn899c+cVN4AhOD8Bio52WupEywEa2g@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] merge-ort: restart merge with cached renames to
 reduce process entry cost
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 10:19 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/15/2021 12:53 PM, Elijah Newren wrote:
> > On Thu, Jul 15, 2021 at 8:10 AM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 7/13/2021 3:33 PM, Elijah Newren via GitGitGadget wrote:
> >>> From: Elijah Newren <newren@gmail.com>
> ...
> >>> +              * The exact number isn't critical, since the code will
> >>> +              * work even if we get the factor wrong -- it just might be
> >>> +              * slightly slower if we're a bit off.  For now, just error
> >>> +              * on the side of a bigger fudge.  For the linux kernel
> >>
> >> super-nit: s/linux/Linux/
> >
> > Yeah, I tend to refer to projects by the name of their repository
> > instead of their proper name.  (I do it with git too.)  Bad habit.
> > Will fix.  That is, I will fix this instance.  Not sure I can fix the
> > habit.
>
> If you had written it as torvalds/linux, then I wouldn't have batted
> an eye, because that is clearly a repo name (at least, clear to me).

Yeah, the thing is I use the repo name even in cases where it's not
ambiguous whether the project or the repo is meant.  For example, I
would often write something like "I'm part of the git project."
Christian has been trying to fix my capitalization.  Folks in another
project tried to "fix" my capitalization too.  Perhaps by demanding
five letters of all caps, they were able to get one out of me[1].  I
suspect, though, that if they had just a single repo instead of having
hundreds of repositories, they might not have even gotten that one
letter of capitalization from me.  ;-)

[1] https://blogs.gnome.org/newren/2006/04/22/enlightening-mankind-about-the-correct-spelling-of-gnome/

> >>> +              * testcases I was looking at with massive renames, the
> >>> +              * ratio came in around 50 to 250, which clearly would
> >>> +              * trigger this optimization and provided some *very* nice
> >>> +              * speedups.
> >>
> >> This bit of your testing might be more appropriate for your commit
> >> message. This discussion of a test made at a certain point in time
> >> is more likely to go stale than the description of how this factor
> >> does not change correctness, only performance.
> >
> > The commit message does include discussion on how this factor only
> > changes performance, not correctness.  I left this comment in the code
> > because I figured it looked weird and magic and deserved an
> > explanation without resorting to git-log or git-blame.  Granted, I
> > wrote this comment and the commit message at much different times (I
> > wrote the comment first, then the commit message many months later)
> > and thus summarized a bit differently.  But I thought I had the same
> > relevant content in both places.
> >
> > Are there pieces you feel are missing from the commit message?  Should
> > I trim this comment down in the code and just let people look for the
> > commit message for more details?
>
> I meant to say "these kinds of details are better for the commit
> message instead of comments" and not say "your commit message
> doesn't have enough."
>
> I don't feel strongly about this being present in the comment or
> not, but it seems like something that could be dropped from the
> comment without loss of information.

Ah, makes sense.  I'll trim it down.
