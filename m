Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91056C3B183
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 00:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 704F6229C7
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 00:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgLEAsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 19:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgLEAsA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 19:48:00 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC944C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 16:47:34 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id g185so8520943wmf.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 16:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zw54gXGMeSeEaYwDDSY8Z9c51eG5xfP4CFPyAf4vNEw=;
        b=PIGNWK1YpiVxlscEtjAObJaS/v0+HrnoM8y3FQQEKVk0Wrr9suIr2loje5IPSAFiJT
         t3D4LkiSAqFThvAtrB5iCT2GuHd4RP8FHODYDFAWOM1xpslfG3kjswBl6pcQNL/ah7V0
         WpDym5XJexIlOPRSpuULY/WSHm9dwRLd2kxjDXbyLsMRDaN+RjG4186HS4xvMZL5P8Cs
         wc5yq+2CtJSd7AQ3ADauW2PHIG8ZlpXX//cT6xQrbLaCk/HAIbziB+Km39EUv5DamNkX
         1PJVb/xUA4sfWX0tuMGilsQQqdUgsipdQTcMR8uIRfm0iOgrsxPyJcF4tkxLiBhs97xZ
         eHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zw54gXGMeSeEaYwDDSY8Z9c51eG5xfP4CFPyAf4vNEw=;
        b=ZKueVLu+0WyNciGNrMMJhLL5ciLtsGnd6Nw38l5LKDaLd7q35sYf2Vvi7kTGqgsXSR
         JekBPb47l4MF27oQWmMCcS7eiF7rdmuhStjZXJWsVOdzeAsEtbsm4c7TB3vIgR/AaB7y
         7MNtnIELlFj5xCh5YulpyKlRRitpn/YY8sjbBKLF20+GRj/bdq9dwnpEhurYv99ueale
         k/PA+rHcXqPYo/y6MC6qYZ5adX0g4I1f4pMq207n7Da3Fk+6fyZj2ZonAw4pKChFLyFO
         5dKtJbpBbYYVIJIDN/5aCz2LHKN0Exsy9CLleW+vqb4zQVrYZf+rcsZ79VpFQXd1UKol
         Mr/A==
X-Gm-Message-State: AOAM531ZV45up3kMjQnV+x4BSyawTpeu/+MiLEyfmgBmSQ1uax/ptToP
        GYqutpO/5lXVWosQtamnl1CbBld7bqWOAJ3uLsjzY+q4jaZpvg==
X-Google-Smtp-Source: ABdhPJzHpWj2t1DluwqczQUNSu3I0zaJWlecFaHsPUQFAB+YORqzmxjbWNRrEu9U3jeKSy4NSKVEkb/RC80n9GOjHN0=
X-Received: by 2002:a1c:df57:: with SMTP id w84mr6704942wmg.37.1607129253641;
 Fri, 04 Dec 2020 16:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-5-felipe.contreras@gmail.com> <CABPp-BHjzzhqQW8YY5podav+TU8Eixhp7g-VrQ-tva-0ztAtvA@mail.gmail.com>
In-Reply-To: <CABPp-BHjzzhqQW8YY5podav+TU8Eixhp7g-VrQ-tva-0ztAtvA@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 18:47:22 -0600
Message-ID: <CAMP44s0D42s=q8TJqxwswOHb4PO-NW6SEUt-LwfvqiGgvkre9A@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] pull: cleanup autostash check
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 5:07 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > This essentially reverts commit f15e7cf5cc.
> >
> > Once commit d9f15d37f1 introduced the autostash option for the merge
> > mode, it's not necessary to skip the fast-forward run_merge() when
> > autostash is set.
>
> It helps reviewers and future code readers if you provide a little
> context when referring to commits, making use of git log's
> --pretty=reference option to get the output.

Yes, I actually have this alias:

  short = show --quiet --format='%C(auto)%h (%s)%C(reset)'

Which shows almost the same thing. I've updated it to
--format=reference. Thanks for the suggestion.

And I usually add those descriptions.

> So, for example, here
> your commit would read:
>
> """
> This essentially reverts commit f15e7cf5cc (pull: ff --rebase
> --autostash works in dirty repo, 2017-06-01).
>
> Once commit d9f15d37f1 (pull: pass --autostash to merge, 2020-04-07)
> introduced the autostash option for the merge
> mode, it's not necessary to skip the fast-forward run_merge() when
> autostash is set.
> """
>
> I still found it slightly hard to follow the explanation even with the
> added summaries, though.

And that's the reason I didn't add them. You need to look at both the
commits to understand why one cancels the other. In my opinion in this
particular case the description only makes the text harder to read.

Probably some better $subjects like f15e7cf5cc (pull: skip ff merge
shortcut on --rebase --autostash) would have helped.

> An extra sentence at the end of the second
> paragraph to make it clear what is being changed ("So, change the code
> to fast-forward even when autostash is set.") seems to help.

OK. That's implied by "it's not necessary to skip the fast-forward"
but it's better to be explicit.

How about this:

Currently "git pull --rebase" takes a shortcut in the case a
fast-forward merge is possible; run_merge() is called with --ff-only.

However, "git merge" didn't have an --autostash option, so, when "git
pull --rebase --autostash" was called *and* the fast-forward merge
shortcut was taken, then the pull failed.

This was fixed in commit f15e7cf5cc (pull: ff --rebase --autostash
works in dirty repo, 2017-06-01) by simply skipping the fast-forward
merge shortcut.

Later on "git merge" learned the --autostash option [a03b55530a
(merge: teach --autostash option, 2020-04-07)], and so did "git pull"
[d9f15d37f1 (pull: pass --autostash to merge, 2020-04-07)].

Therefore it's not necessary to skip the fast-forward merge shortcut
anymore when called with --rebase --autostash.

Let's always take the fast-forward merge shortcut by essentially
reverting f15e7cf5cc.

Cheers.

-- 
Felipe Contreras
