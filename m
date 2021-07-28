Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC15AC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2176103A
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhG1TZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhG1TZw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 15:25:52 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9D7C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:25:50 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u25so5088811oiv.5
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=reRX0A12R8sMVxCpc7ZjbVIDANMLyRtZic14AYOq+RY=;
        b=Az9wNZIP1ggwrt71hYWGHh8qAAaIxyfY6ZR4TdY6zCd5qxsR5CT8TOwIJ+9YXGlfbA
         7yjM2xYebDb5eHbvA7O8greQPwaA2ICT8NrLkj/0Ql3MqWIHjnGynFL1pJBKw/5tK5o8
         rIrea5YLN9bZFBeBryd+3Ztcgp5dgHwUMCREyZeJAymfqMG92GvSHRKxvD5+Mczh30Dc
         4kwT5YwHLmIdeK3GZF/o7Nvz9CBCRGTeEannt9KlcSZZ0z8+LuWnLKs7rp3WAukXiyv0
         EPprLXvU37ImP8IYZf3lMCbZFKG0sr9P7+U06nF8HWPoWPfKDDLxNaAx8rlVLqeLv9pf
         Bbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=reRX0A12R8sMVxCpc7ZjbVIDANMLyRtZic14AYOq+RY=;
        b=l1gSiBTG2oa7dhFUIGkc/gfOOwDbSS02Vw24EjBmeulcjeCt1Rrnzsz7FWn0ZWTjy0
         CPf0t2UTReEzsePaFb/nZTRMH0dLXHSM7ub2CwVfqeYDZExoTdZVlKcSWgCqiwhaG76p
         prJmUw0zZ6Yz5uGRektURmPfbJcPXuVl4X01HriIYZJulTkL2D8m77p0dLdbw7gNb5RO
         AUbNtYzLeg5jN9cUGzYKCDU6vdn90EAbUXjKJhCa056KpKSSwdOwKbSlrtuqEWbo4qX2
         0i4ip3EyDz5LmLeWk8XFhd74aguFeu2NUd48p/YU1VhGyW7bjTdunaYx+E9pOdLC+OrY
         /2Ng==
X-Gm-Message-State: AOAM533wt3gmqDy1uKiRrFb+kGa5hasDFKXtG/3eusA3fk4B9gU8oZYm
        TsLV1aMnobgmKnQSovAFCsA=
X-Google-Smtp-Source: ABdhPJzLpQpcHpYjQOHspE88W4BnPhe35bfWsqD7PgSZ9OGU/z0UCdauudy0q24Pj0iaFV7yFqc0Jg==
X-Received: by 2002:aca:d404:: with SMTP id l4mr648903oig.21.1627500349760;
        Wed, 28 Jul 2021 12:25:49 -0700 (PDT)
Received: from localhost (fixed-187-188-73-1.totalplay.net. [187.188.73.1])
        by smtp.gmail.com with ESMTPSA id m19sm155310otp.55.2021.07.28.12.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 12:25:49 -0700 (PDT)
Date:   Wed, 28 Jul 2021 14:25:43 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Message-ID: <6101af37cabc_41362084d@natae.notmuch>
In-Reply-To: <xmqqv94u9x2l.fsf@gitster.g>
References: <20210721134650.1866387-1-felipe.contreras@gmail.com>
 <CAHk-=whf-9kNV3y5G-VVA2K5EZCnvv94paAEj6p=i2R4RM2emQ@mail.gmail.com>
 <xmqqeebregns.fsf@gitster.g>
 <CAMMLpeTL92cDmMHsE3iuhHQrVjwLFWHxE0CwD+uDBoPGAQCrkg@mail.gmail.com>
 <xmqqwnpcdu1w.fsf@gitster.g>
 <CAMMLpeQ-Qpct4TX__KVuCyjbgxtB49qTMRHYc9R9-o0cRu4MuA@mail.gmail.com>
 <610038c0e1056_8fd52084a@natae.notmuch>
 <9e8f1c87-cd08-e1a2-fd5d-713cb0590049@aixigo.com>
 <xmqqv94u9x2l.fsf@gitster.g>
Subject: Re: [PATCH v2] pull: introduce --merge option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Matthias Baumgarten <matthias.baumgarten@aixigo.com> writes:
> 
> > Add to Felipes list:
> >
> >  * git switch -m
> >
> > and maybe git cherry-pick -m where -m does not mean "merge" itself but
> > is used to determine the parent of the merge (when picking merge 
> > commits) to base on.
> >
> > Other examples of where -m has different meaning than merge:
> >
> >  * git am -m (message-id)
> >  * git branch -m (move branch)
> >
> > I would rephrase the question as to what would I expect `git pull -m`
> > to do, if I had never heard of it before. In the case of
> > fast-forwarding and rebasing trying to add a merge commit message with
> > -m would not even make sense. Only in the case of trying to create a
> > merge commit by issuing git pull this would make sense. So if we could
> > agree on that being not the most used scenario, I think -m would be a
> > great short option for --merge.
> 
> I am afraid that you are misinterpreting what I said, comparing
> apples and oranges, and drawing a wrong conclusion.
> 
> When I said "-m" would not fly well as a short-hand for "--merge" in
> the context of "pull", I didn't mean "nobody would think 'm' stands
> for 'merge'", and I didn't mean "more people would think 'm' stands
> for 'message' more than 'merge'".  The reason why I find it
> problematic is because it can be ambiguous.

The question shouldn't be "can it be ambiguous?", the question should be
"is it ambiguous?".

The *main* purpose of `git pull` is to integrate remote changes, and the
first question asked is "how?".

  git pull --merge|-m
  git pull --rebase|-r

So I don't see why it is ambiguous.

The fact that a tiny minority of users might find a command (any command)
ambiguous is not valid reason for its inexistence. By that rationale
`git pull` shouldn't exist at all, because many find it ambiguous that
it's not the symmetric command opposed to `git push`.

The vast majority of users shouldn't suffer because of the confusion of
a tiny few. The tiny few can simply look at the documentation.

-- 
Felipe Contreras
