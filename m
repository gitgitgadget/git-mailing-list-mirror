Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DDBC4167B
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5756822573
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407652AbgLLQh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 11:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394926AbgLLQhI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Dec 2020 11:37:08 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974CEC0613CF
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:36:28 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id q25so13810908oij.10
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=VNEcGcZc3hl/3dlXqpM+pCyGwcVW2N3Kor2KXIYL8gk=;
        b=OK+E3/1h/lMIhOjtwo/QSYj9uTIoYHMWFnsSb634dETTVWYnt78o7vQr0A/E9VVmUs
         ccPVQZWHk5XMNa0bReufGSwsSBvSXQZtm5NdHiU0KG7waPOPNaoilANI8MQHMsw2lP5q
         LZk2tZmiSVHxTTKyrbwUTjVNNCrEnGAl0zgv9VcYcorlO5oj0vbFh46GCAvNz9kaRCEh
         SdyPvIwk1CEPDtxGGncnfxXxdIk++S5yNme5qiel9+FSq71M1u6RzslVm+GUxwiEvVZr
         LiAYuDLr3/nN0PJ37lCgkbS7DTKBem15EdAoPwIOHuu0LPaLw7nVsI79iyANmZosZDSb
         z3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=VNEcGcZc3hl/3dlXqpM+pCyGwcVW2N3Kor2KXIYL8gk=;
        b=aN/kSSlevGBSwWyaB1ntz8/M8KwQRex4dU2Bsja6xfNuh5udX59vI5CS8f+V0bKqn6
         g3BdkUpEPbc8oZu+ltHf5ZrZ+6h9eQR5J5xN8D/TlB7Qmf5s609gtEjxJtqjXD0likpx
         5YRZ329Bw4ZAvL6EEBPlc2lf0q5vgFTQDQESwlnecrYxQLkWMZg/+uw6uci/D7jmZ0nS
         31/DoI+/NtOJyI9cyKiI1szPJHv48UiEqiqI+JxOegiG84usF+yOHDfh8I2u7rq12E4y
         PQ05CvkHZ64FjdfbwzEs0SgGvvxqZy9BKdSecKEKrRi7r9KufGg0UvUOYsbjCxPA8K2T
         1hVg==
X-Gm-Message-State: AOAM5332oUxWWUB/WfbyAwL2E5iq2v0Wp4JspwUzBDezM+F0aSyivuxg
        n/PrENLdc0o5Nejahl0TsnU=
X-Google-Smtp-Source: ABdhPJytjagwWyIRtBjdNLqzeYMDBJs7t0C/F8VB08jVVOGnzaqqc6ozJrYXC2rFGIpC1+28jM2mhg==
X-Received: by 2002:aca:5786:: with SMTP id l128mr13282996oib.145.1607790987965;
        Sat, 12 Dec 2020 08:36:27 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z5sm1073653otp.40.2020.12.12.08.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:36:26 -0800 (PST)
Date:   Sat, 12 Dec 2020 10:36:25 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Message-ID: <5fd4f189a1f4e_bc1eb20891@natae.notmuch>
In-Reply-To: <xmqqv9d7faot.fsf@gitster.c.googlers.com>
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
 <xmqqo8j0io39.fsf@gitster.c.googlers.com>
 <CAMP44s0uyxs4p+HJ5ZDrrKJs9wQW4tSCZzPonpvP=FcTGCcxSA@mail.gmail.com>
 <xmqqv9d7faot.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v5 0/3] pull: stop warning on every pull
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > But that's not what I was referring to here.
> >
> >> I do not know if others on the list agree, though.
> >
> > This is what I was referring to. Initially there seemed to be some
> > interest, and suddenly that interest disappeared.
> 
> Perhaps most of them are happy enough with the current behaviour.

Or perhaps they are happhy enough the current behavior *for them*, but
not the other users.

> Perhaps nobody cares strongly enough to say what they want to see,
> as they fear that by speaking up they would be drawn into a
> discussion that is needlessly hot and unpleasant.

Or perhaps they got busy.

Or perhaps they got sick.

I don't see how listing hypotheticals is fruitful.

> >> I do agree that there is no agreement on the behaviour in the
> >> endgame.
> >
> > See? I disagree.
> >
> > I think the endgame is clear. How we get there is where there's no agreement.
> 
> What you want as the endgame may be clear to you.
> 
> But I do not think there is clear concensus among people on the
> list.

I do. It has been clear for many years.

> >> In principle, I am in favor of disabling the more
> >> dangerous half of the "git pull" command for those who haven't
> >> configured anything.  But I can understand those who do not want
> >> that behaviour, as the fallout would be quite big.
> >
> > And who is that? Did anyone in the list express that they did not want
> > that behavior?
> 
> I thought that you at least saw Dscho's reaction to the breakage
> caused by "future" patch in response to one of the recent What's
> cooking reports.

Yes, I saw it, but it was a complaint about the breakage of test due to
the merge of a patch that wasn't meant to be merged today.

> Doesn't that count "anyone on the list express"?

No. These are two different statements.

 1. This will break things for *me*
 2. This is a bad thing for *everyone*

These two statements have a different object. Also, the first doesn't
necessarily require rationale, we can take his word for it. But the
second one does.

It's not enough to say "I think this patch is bad for everyone"; you
have to explain *why*. I'd be happy to discuss with him his rationale,
which he hasn't given.

Moreover, isn't Schindelin advocating for a change that will cause
breakage (renaming the master branch).

> I am starting to feel myself that "don't do anything if this is not
> a fast-forward" may be something that would have been great if we
> had it from day one but is no longer a feasible default with
> existing users, to be quite honest, so you can count my 20% as
> another example.

As opposed to virtually everyone in this mailing list that has given an
opinion about the topic in the last 10 years (including you I count 3
out of literally dozens).

I will do some mail archeology and present the results.

Anyway, this is not relevant today, because you were the one that
proposed to go straight to an error.

What I propose for today is to introduce the option
"pull.mode=fast-forward", and improve the warning. Not an error.

That doesn't break the behavior for anyone, including Schindelin.

Cheers.

-- 
Felipe Contreras
