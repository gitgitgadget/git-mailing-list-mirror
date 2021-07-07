Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18754C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 21:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5AC61C2F
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 21:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhGGV2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 17:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbhGGV2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 17:28:16 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9061C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 14:25:34 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id h9so5144634oih.4
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 14:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2m1lC+D+DUDl7rjGoHApKcMO1HgQydpXw067EBgUCF0=;
        b=OpTHKTIl3Y0cAvGHcA2MFatzMNYu0z7CMVxknp46RmwX3rg4sJoja7Qj9pgXnkOVU3
         5wD7RnjHum7hki0sRpYonMuriXUp8Iin6LCE7JvwHWz3BI9TxL7LU7W2GsLOKqAQXil7
         jC+jVQ70p8XEMLQGlakLhpFWcbAgKlIQ8Kmm5B533fNQdbqStSAM18TXSzvAC6Sj4sVN
         54HEjLbLc8r1g2TTnZ6iUpc3k0RTLIoz8BJ/PyGeLBhIdVjq5hFEl7G9dUkKm+Q8HUmf
         JNV5pjv1R0vvhRVHz5PNruUQtuZBQxsoAo9ZkYFKAzc9OY6zUL8XlQkvT3++HqEIdKtu
         R0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2m1lC+D+DUDl7rjGoHApKcMO1HgQydpXw067EBgUCF0=;
        b=Mwt7BydoYrswpOJ9cbwpAxK/QLlIsJhmkv+TyHnzkQzcczAULWDlHme5/u6hrhYo1Q
         hFDVWTcOI/0DLZd1WPCZTOhaeWE99MkOQlgbHXW5VA3QW5KM/JKmgR7qsJQABH6XjUk+
         4KKFbSJe8nIfAt9aw20fl1d0ty4sa2r7WRgitmGNExsQ+8FLyvgcPUuT748HHOFujZEt
         19wZ4HTPqdeIrWTnHS0ZM55eNzWr1+He3nk5uQi4Cmi+75+YLZl0W+wzh7azXG7Q7KKd
         giZGDqWcxS5pABD1Ggu1ID2MnZe4ZuegCcd6kf5UoIhRUinLgXjf6CQBnbZ2c+BtXaUz
         2Lyg==
X-Gm-Message-State: AOAM532sadEmMUsdQJxla4VxJSzyyJvIIH1hvWjeMsMftdM2PAQZj12g
        gfwEfoZjoKv2zzqap46blPc=
X-Google-Smtp-Source: ABdhPJx56nMoGJWNe1GgPE+hUwSSZLfcYsClTmm8LGXud4CuawTY+saQDfodYts4dr5JvpqFCcQXFQ==
X-Received: by 2002:a05:6808:208a:: with SMTP id s10mr936843oiw.97.1625693134321;
        Wed, 07 Jul 2021 14:25:34 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id i1sm64419otc.78.2021.07.07.14.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 14:25:33 -0700 (PDT)
Date:   Wed, 07 Jul 2021 16:25:17 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Message-ID: <60e61bbd7a37d_3030aa2081a@natae.notmuch>
In-Reply-To: <87bl7d3l8r.fsf@osv.gnss.ru>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru>
Subject: What actually is a branch?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since this is not strictly related to the topic of `git switch` I
renamed the thread.

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Sergey Organov wrote:

> >> Overall, if we aim at clear documentation, we need to define our
> >> documentation terms as precise as possible, and then use them
> >> consistently.
> >> 
> >> For example:
> >> 
> >> "branch": a chain of commits
> >> 
> >> "branch tip": the most recent commit in a branch
> >> 
> >> "branch name": specific type of symbolic reference pointing to a branch tip
> >
> > Completely agree on all three (although I would call it "branch head",
> > not "branch tip").
> 
> I see why "branch head", as you later introduce "branch tail", but a
> branch (of a plant) has no "head" (nor "tail"), right? BTW, how the base
> of a plant branch is called in English, and how one finds "branch tail"
> on a real tree anyway? I mean, there are probably a few of them, at
> every fork. In Git it's even more vague, as a branch could logically
> begin at any place, not necessarily at a fork point.

We don't necessarily need a 1-to-1 mapping with common English (although
that would be nice). Anoher option could be "base" and "tip".

> OTOH, "head" and "tail" are obviously taken from CS "list" concept, and,
> provided "chain" == "list", it does make sense.

I took it from Mercurial, where the tip of a branch is called "head",
and in fact a branch can have multiple heads.

> And then we have 'HEAD' that points to the current branch tip anyway.

It actually points to a branch, or rather references a branch, since it
uses the branch name.

> Dunno, in fact I don't have any preference among "tip" and "head".

I don't either, but from different sources (non-git-specific) I've heard
"head" more often.

> As for branch tail, I do have convention of marking start of a
> long-standing branch with corresponding tag, where branch "foo" has
> corresponding "foo-bp" tag marking its "branch point". Recently I
> started to mark start of feature branch with yet another branch "foo-bp"
> rather than tag, "foo" being set to track "foo-bp", that allows to
> automate rebasing of "foo" against correct base.

So foo-bp is the upstream of foo, and you do basically:

  git rebase foo@{upstream}

This is works if your base (or tail, or whatever) is static, but many
branches jump around, and that's where @{tail} comes in handy.

You can do this:

  git rebase --onto foo@{upstream} foo@{tail}

This will always rebase the right commits (no need to look into the
reflog). So you can say that the branch is foo@{tail}..foo.

Another advantage of having this notion is that `git rebase`
automatically updates the tail (in this case to foo@{upstream}).

Cheers.

-- 
Felipe Contreras
