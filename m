Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F7FC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4DC61221
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhGLQ1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbhGLQ1o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:27:44 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79888C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:24:56 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id x70so14318234oif.11
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NYZXwDWJb6Y+3cfPzFIt+9hked1XqKQHAaxWTPTwJf0=;
        b=a0s65Q2BDroq65KWKPbzbFus/WL3qNOt8S+eTcKJuoSMEZ0/1R7pmAM42qW9VAwDVW
         yCzZ2U+M9pwZ+laCfZ3r4uZFp2wYAEnF+ckLhpgSllznl6s9HHb5bIy86inrMBPa1sxr
         gB+cOjflBAl0QCyWlQBv6yp25Bko7Woxu2BiBZUWhACrgGvdn8/fRD2S3W4pAdkM8+/e
         OUCe9qo2H53Kj5lzTpZw1otvxQmpqW1uFjZHUbnz7A/k/IFZFtU0ckUGPseTFZEaN+1m
         pNpUnZRsgFoOQX/UpLbxWUWGRPF18jvgi4YPFlffXkTBwoogiP0j172fdbjFksMJl2TG
         pw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NYZXwDWJb6Y+3cfPzFIt+9hked1XqKQHAaxWTPTwJf0=;
        b=PLi6o5SYmbI4ONzGTgvRH/tLWUg+BxnmPobZBbAo2jHTIBI6xMrPlogwtkrc0wSksa
         tf1su2eMTAmvOuQy94dd86tpAk+9pw9oycxGnLTM9eP4AElSmjpqSle5uXQoTvheVp/N
         ugwiRSz2i2N6nBLLADgaNitDaO3g3LjbHiCUAi/ldYXKw6cRYLAIFxaZ7AnWTLa2OO4w
         OwwRL7dyedy35TBm27HtEddkhbCs/98Bixhj7vYqXisF7TXvGDA7m7SkqBaP6n4lOO9g
         Gx9jrNmry/TaiZZt9fgtHLoIQ/CoM0Ki7Z7yz7+K73ZH4xo/bYplZp5969Hiw36al/be
         dQbw==
X-Gm-Message-State: AOAM532blLhg/07KO+KHEPi8szE4Kh5YIRXK3YgxYf79t9i+iCfTmX2a
        8jD2KKeFMfaXwsI+IqXp/cA=
X-Google-Smtp-Source: ABdhPJze/8r6joF25Q45ffkGz4yBBvOyF6BDOoFYXPvhRm45HJMer+DCBCNg+UH9elqwbsqC3hWQKA==
X-Received: by 2002:aca:3446:: with SMTP id b67mr39382955oia.120.1626107095761;
        Mon, 12 Jul 2021 09:24:55 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id f12sm2670081ooh.38.2021.07.12.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:24:55 -0700 (PDT)
Date:   Mon, 12 Jul 2021 11:24:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Message-ID: <60ec6cd622c4c_a4525208a0@natae.notmuch>
In-Reply-To: <874kd1gr0q.fsf@osv.gnss.ru>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <87im1ieaba.fsf@osv.gnss.ru>
 <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
 <87a6mudt9b.fsf@osv.gnss.ru>
 <60e9ff4430c57_7ef20815@natae.notmuch>
 <874kd1gr0q.fsf@osv.gnss.ru>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Sergey Organov wrote:
> >> Martin <git@mfriebe.de> writes:
> >> 
> >> > On 10/07/2021 12:24, Sergey Organov wrote:
> >> >> Martin <git@mfriebe.de> writes:
> >> >>> Actually, "new" or "create" would make sense in "git branch". But in
> >> >>> git switch, they actually raise the question "create what?" / "new
> >> >>> what?".
> >> >> I believe that's because "git switch" tries to do too much. "git switch"
> >> >> should rather switch between existing branches, and do nothing else. As
> >> >> I said once in this discussion already: trouble writing good
> >> >> documentation is often indication of some flaws in the design.
> >> >> Creating (a branch) is fundamentally different operation than switching
> >> >> to (a branch), and that's why the former doesn't fit into "git switch".
> >> >> 
> >> >
> >> > Right, yes. But creating a branch is often followed by switching to it.
> >> 
> >> Yep, but here the creation is the primary operation, not switching, so
> >> putting this into "git switch" looks like design flaw. These 2 actions
> >> are fine to co-exist in "git branch" = "whatever you want to do to
> >> branches", but not in "git switch" == "wherever you want to switch".
> >
> > I don't see the logic in here.
> >
> >   git branch topic # here 'branch' is the verb
> 
> Not to me. I assumed the "branch" is always a noun in "git branch", and
> the actual meaning of this command is:
> 
>    git branch [create|new] topic
> 
> I.e., creation just being the default action taken on the branch.

The question is not what you assumed, the question is can other people
assume otherwise?

"branch" can be a verb, that's a fact.

> >> To me, while the latter is obvious, it's verb and specifies the action
> >> to be performed, the former looks more like "whatever you want to do
> >> with branches", and thus the "branch" is a noun there and the command
> >> thus is object-oriented.
> >
> > I agree, and I did have indeed noticed the inconsistency. But there's
> > another category of commands that receive subcommands, like:
> >
> >   git remote $subcommand
> >   git worktree $subcommand
> >   git bisect $subcommand
> >
> > In my opinion `git branch` fits more these subcommand commands, and it
> > was a mistake to make the subcommands options, it should be:
> >
> >   git branch list
> >   git branch new
> >   git branch set-upstream
> >   git branch move
> >   ...
> >
> > Now the verb is crystal-clear.
> 
> Yes, lacking (assumed) subcommands is yet another dimension of
> inconsistencies.
> 
> I mean what I'm after is inconsistency of the first argument to "git".
> It's being the verb more often is where we currently are, at least when
> considering "primary" commands that "git help" outputs. 
> 
> I mean, consider:
> 
>    git branch new nice-feature
> 
> vs
> 
>    git new branch nice-feature
> 
> It should have been the latter, when in fact it's currently the
> [reduced] former.

I disagree. I prefer the former.

Either way this is way too far from the original point. I don't think
you can convince me that `git new branch` makese sense, but there's no
need for that.

To move forward we need to find consensus, and if you and me agree that
`git branch new` makes sense, that's where we should focus on.

Even standardizing `git branch` would be an almost-impossible task, even
if we manage to convince others. `git new branch` even more impossible.

-- 
Felipe Contreras
