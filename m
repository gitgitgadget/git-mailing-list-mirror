Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25424C48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 21:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003AF619C5
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 21:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhF0VcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 17:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbhF0VcA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 17:32:00 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07120C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 14:29:34 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso16414668otu.10
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 14:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2siTA4eqiSvG2bgNtaB4y1EZQDSmupjFO5HCZsyM4Wc=;
        b=RP2eCezBp/UHNecoeNVVmhruYt5az+V/M43FaguptbdZj19EG/OBr1qhH6xOdSSjYV
         3N0ow9NhTKZ6Kc+LYoBsnMag1bdAG9zgn3eriIrUQ4cNC40U3lyH6atxx4L6ckqX8vRl
         CQdHLO5QbqNedk5JdiErmq+KyB9HZE0aBJN5ee1RdoNmndtaQW+34omj6XXl90tqNHFK
         r9rjyNBEZIyfQYnAvFMeT10/JJBl/9nGKZV8GyypJDW9h/nMZvhIi+FUyy8LjotiqxDb
         gUM3PtamQ1t9v6YGEGlPzAVE+lnRykjCXV/YTGeEqMrz5o44T6U/ouD9GSmDC/5124YQ
         T8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2siTA4eqiSvG2bgNtaB4y1EZQDSmupjFO5HCZsyM4Wc=;
        b=V9q322ApUA2whBLU9bacc5/HZLkUvONP/FmcymbewY+GqLJT7sXetKxuwJe5zAcwYc
         jcbiqmywlMLOwHAAhwp0pplCkbvmod3bXFc1gBgVhOP4SoexIUOoKre5rx/rhApbgljo
         I/4Og6c6EVq9f9IhF218Q1rqQp6B/NMc5b+yuYFafGMQl1L3SurKG7mPttWb6W6KpqGn
         qdNkyf89j09nftNCihLxJr6d24wklVHEO7sD1CLG9jT4qj3QwpOu2oPouh0AxXZ5+y22
         /S2ddD+85PTGVjmqJ+HlAAt8p0fJOw2qRrLEn5s3mZosxUl59EzrLuYJ2kmZW0p6WapU
         tWvQ==
X-Gm-Message-State: AOAM533QpQQb/vCw5VlGDliyTMgCkSXp+spali5Srl/eDFlAAvc8YXQS
        qs4lWySSf2JkOtA1KBBAk8I=
X-Google-Smtp-Source: ABdhPJxa0NL2yyd8sz0kaPi3JSGeHdlM4PZaPHeJc6cg0uPf8xc4x1xb8/rhmb6mh5Idh/ZcQGnNkQ==
X-Received: by 2002:a9d:550e:: with SMTP id l14mr18899734oth.241.1624829373168;
        Sun, 27 Jun 2021 14:29:33 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id 35sm2959797oti.65.2021.06.27.14.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 14:29:32 -0700 (PDT)
Date:   Sun, 27 Jun 2021 16:29:31 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60d8edbb3803f_70e20886@natae.notmuch>
In-Reply-To: <CAMMLpeQaY0z_baVQspJhAX0wanaJwneFoM5rG=xwFUmLEE-QaQ@mail.gmail.com>
References: <20210627000855.530985-1-alexhenrie24@gmail.com>
 <CABPp-BGko7BP6ZMyRKwKrv0xz7FM9ehe67HSAtzgHF9eV2TD3A@mail.gmail.com>
 <60d7fbb770397_b8dfe2087d@natae.notmuch>
 <CABPp-BGXQ4vbFf6Gx21X-Ms+1VQsZfod1waNJZQxVmB7b-gD7Q@mail.gmail.com>
 <60d8ab7fe0761_ba5a2208b@natae.notmuch>
 <CAMMLpeQaY0z_baVQspJhAX0wanaJwneFoM5rG=xwFUmLEE-QaQ@mail.gmail.com>
Subject: Re: [PATCH] pull: abort by default if fast-forwarding is impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:

> On Sat, Jun 26, 2021 at 10:12 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Also, a bunch of tests are broken after this change:
> >
> >   t4013-diff-various.sh
> >   t5521-pull-options.sh
> >   t5524-pull-msg.sh
> >   t5520-pull.sh
> >   t5553-set-upstream.sh
> >   t5604-clone-reference.sh
> >   t6409-merge-subtree.sh
> >   t6402-merge-rename.sh
> >   t6417-merge-ours-theirs.sh
> >   t7601-merge-pull-config.sh
> >   t7603-merge-reduce-heads.sh
> >
> > If you didn't mean this patch to be applied then perhaps add the RFC
> > prefix.
> 
> I actually did run `make test` before sending the patch, but when so
> many seemingly unrelated tests failed, I foolishly assumed that they
> were pre-existing failures. I should have run the tests on master for
> comparison, sorry. Or at least put "RFC" in the subject instead of
> "PATCH" as you suggest. I sincerely apologize for my lack of due
> diligence and I know that I need to do better at self-reviewing
> patches before sending them.

I personally don't see any need for apologies, we all make mistakes,
just keep it in mind for the future.

Personally I prefer to run prove instead, because the output is less
verbose, and there's a nice summary at the end:

  prove t[0-9][0-9][0-9][0-9]-*.sh

> > Alex Henrie wrote:
> >
> > > +           "You can replace \"git config\" with \"git config --global\" to set a default\n"
> > > +           "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> > > +           "or --ff-only on the command line to override the configured default per\n"
> > > +           "invocation.\n"));
> >
> > Can I?
> >
> >   git -c pull.rebase=true pull --ff-only
> >
> > `--ff-only` doesn't seem to be overriding the configuration.
> 
> Ahh, so /that's/ what you meant by "3. Fix all the wrong behavior with
> --ff, --no-ff, and -ff-only". That does seem like something worth
> trying to fix before making the switch.

That is just one of the inconsistencies, there's many others.

Consider all these:

	git pull
	git pull --ff-only
	git -c pull.ff=only pull
	git -c pull.ff=only pull --ff-only

Do you see any good reason why the error message should be different for
any of these?

How about these?

	git pull
	git pull --ff

Why does --ff make the second command work?

Even worse when you start considering more combinations, like
"--no-ff --rebase" which is obviously nonsense, but it depends on the
configuration.

I proposed a solution for some of these inconsistencies with --ff*, but
was ignored [1].

> On Sat, Jun 26, 2021 at 10:16 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Elijah Newren wrote:
> >
> > > The code changes look good, but you'll need to add several test
> > > changes as well, or this code change will cause test failures.
> >
> > Wouldn't you consider sending a patch without running 'make test'
> > "cavalier"?
> >
> > > Thanks for working on this.
> >
> > Such a completely different tone for a "cavalier" patch depending 100%
> > on the person who sent it. Weird.
> 
> I'm trying to make things better, as I'm sure you are as well, and I
> know that I make a lot of mistakes and need the help of more
> experienced contributors like you. So please be nice, even if others
> are mean to you, because regardless of whether these comments were
> directed at me, this kind of comment just makes me feel like giving
> up.

My mail was directed towards Elijah, not you.

I do appreciate all contributions, especially if they were done pro
bono.

> On Sun, Jun 27, 2021 at 10:46 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > I don't throw personal attacks, nor do I chastise contributors for
> > attempting to improve the project. That's your department.
> 
> "That's your department" is a personal attack. How about we all go
> spend some time enjoying the weather, and then get back to working on
> Git problems later this week.

Stating facts about what a person did is not a personal attack, it's
just stating facts. Elijah did attacked me personally, that's a fact [2]:

  If I were in charge, at this point I would drop all of Felipe's
  patches on the floor (not just the ones from these threads), and not
  accept any further ones.  I am not in charge, though, and you have
  more patience than me.  But I will not be reviewing or responding to
  Felipe's patches further.  Please do not trust future submissions from
  him that have an "Acked-by" or "Reviewed-by" from me, including
  resubmissions of past patches.

And he did so after I made a "mistake" (in his view) that was much much
less serious than the one you did.

I am merely pointing out the inconsistency, that's all.

This has absolutely nothing to do with you, again... I appreciate you
used some of your free time to try to improve git pull.

Whatever beef Elijah has with me is an entirely different subject, that
I suggest you leave on the table. I don't think anything constructive
can come from trying to defend what he did.

Let's just focus on the patches.

Cheers.

[1] https://lore.kernel.org/git/5fdd154264baf_130e182082b@natae.notmuch/
[2] https://lore.kernel.org/git/CABPp-BG53Kd7MhzE3hdq5fjBQVV2Ew3skcUCAuTfM5daP2wmZA@mail.gmail.com/

-- 
Felipe Contreras
