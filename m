Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42D9C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E8161883
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFORFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhFORFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 13:05:32 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D5FC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:03:27 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so14997762otk.5
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=uH5hk8hoPrbh4x4HccJIU/n3+NyvUwcQtxZ3leDU8WI=;
        b=aGrK5HK0HaRfkdMEbzaSMQGmYnLx5LRC8/2jDuW8O5WNm3jDOWbsZ9WRq1VaL5aAck
         WMGcoCsxLscScpb4dHLyZFDWctKooYcPldo9H22c/b+l4t/XVyG7mclNuuoXuKvq5oRf
         OKax3aqWVpXKSFHV/4CGhaFFJZVFaWQyn/jZT88+IT6n0cdW9fIGiPnMI+8Aufqu7MdB
         xiMnVUhJZvVMf9qCV6o2dSeqjG6VnbHQtGBEDdxCTAOqdTKVBMEAoeh2ClTz6s/TC/J1
         A5CH+XGtUOO9RubkWDP70o1xjo9dvNgJHXq7lmyzQ3DdI0AenVQdU73zPay/G5tB0qj4
         opsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=uH5hk8hoPrbh4x4HccJIU/n3+NyvUwcQtxZ3leDU8WI=;
        b=HfBfBOUWUuf9pZhI1C6izpLfAm5qcCAP+325JkoeyQhfrqDcQDKdHHmhmEpKCK9Kdj
         fyyQjqyowLZT30GeebTfl2P9yTCYl5K48Bi7M5de93jFD/UswQUrBERlv8bw10wq/1Lu
         Dj19qL6h66u01Sjpkl98c9JwYiAjnWwfaqklLb2oCQb7E1keXz9ufXHpW1yjO4bt2fwc
         LBp1zIWYhIof7rhLs5+DbqH3rIKwyjMVjF6OWZ6+upWcgbSp1uH3htFaCSuKYneRh4Ba
         Iec4/7nE3D2AFSA26l7Q1iyYhElSgU8xfsWpGdMuUhorS70tKB0m0oCjjD9gwUoC6k9u
         IG6w==
X-Gm-Message-State: AOAM530Pu/bKQS5Y8QIRAct9pKQNR9cv4ehnJnRZPS72mm6vsvB/ibFu
        OrJkD+yB8t1ics6MaEC0Bfs=
X-Google-Smtp-Source: ABdhPJzW9ucL20deN6B7TUY/9jb8hSlVaROmhz57AoFsW2CE2F8zneygzOfJLgimuJo/U2R+oED5OQ==
X-Received: by 2002:a9d:628:: with SMTP id 37mr237476otn.120.1623776607235;
        Tue, 15 Jun 2021 10:03:27 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id f7sm3917809oot.36.2021.06.15.10.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:03:26 -0700 (PDT)
Date:   Tue, 15 Jun 2021 12:03:25 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
Message-ID: <60c8dd5d31686_12c282087d@natae.notmuch>
In-Reply-To: <ffdd4b33-65b2-de66-165a-84d2ce6f2fce@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <87a6nz2fda.fsf@evledraar.gmail.com>
 <YMKTARn368Qzsqc2@camp.crustytoothpaste.net>
 <87pmwt1dz3.fsf@evledraar.gmail.com>
 <f4488360-bdaf-3e97-69c5-00087f797117@gmail.com>
 <87h7i21a43.fsf@evledraar.gmail.com>
 <xmqqzgvrvf5g.fsf@gitster.g>
 <ffdd4b33-65b2-de66-165a-84d2ce6f2fce@gmail.com>
Subject: Re: [PATCH v2 0/4] Use singular "they" when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 6/15/2021 2:02 AM, Junio C Hamano wrote:

> > I just retried a "competing" merge that got ugly ;-)
> > 
> > Between Derrick's two "singular they" patches (one for comments, the
> > other for docs) and Felipe's two patches (the same split), they
> > touch identical base text.  Only the way they neuter the description
> > is different, and to me the latter feels a bit more ESL friendly.
> > 
> > So, the main things that are missing from Felipe's version that we
> > may want to build on top before the whole discussion can be
> > concluded are:
> > 
> >  - Derrick's "typofix" patch, but if I recall correctly it needed a
> >    fix-up in one of its hunks?
> > 
> >  - Guidelines; you had a more generic readability tips that would
> >    (incidentally) result in nudging the writers to be more gender
> >    neutral, which I think is going in the right direction, but I do
> >    prefer to see an explicit mention of gender-neutrality as one
> >    bullet item.
> 
> I will send a v3 soon with Felipe's two patches, a fixed typo patch,
> and a new set of guidelines.

I don't believe it's necessary to tie the guideline with the fixes. The
guideline might be desirable without the fixes (depending what the
guideline says), and the fixes can be applied without the guideline. In
other words: they are orthogonal.

Tying them together only ensures the fixes are going to be unnecessarily
delayed until we find appropriate guideliens (if we ever do).

-- 
Felipe Contreras
