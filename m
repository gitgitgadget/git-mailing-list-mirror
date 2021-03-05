Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9131C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8201E64F60
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhCEAhB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhCEAhA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:37:00 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A13C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:37:00 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id l133so587738oib.4
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOGJOEE9i6vwVAqI7W1JZl2ASN7RtESflf2TeWdwiqA=;
        b=Exakhff+PFBjeB2esloyNT6Qk2SnoyHlabKMxCAGdtx/v2Q4xIS5IY2o/Nt0UDhYPF
         b1NAje8h+CwdCu60UYqubWN5RDbf3s7qcnnR9cvozE94z6NB/G8QujPb+TXjFsL5Q69y
         KG6wv0bT5g8H/16MDlGFoS/J9QGyGIWaqUrxky/Sk8Vi+8M7nVknRaon3cTBenY7Pgtk
         FrixCs+eOHgV+E2guSvp7FJWkkO2+sh5jUgTC25Z9EYMPYhHqyuK4VfY9R615qLJ8zfs
         /6MIrcg8r+beEJArF6SeLViMQESEh7sN4/lLr6qGxfq+8dqHc17M5LXiB5EG/2UIK25j
         1Azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOGJOEE9i6vwVAqI7W1JZl2ASN7RtESflf2TeWdwiqA=;
        b=J/n7W1/MMn58LKmKLjPLntvgfaGEVins/wuTDnSZ2Q6Bl0uFMLC7F3WKY5w0Ew/u6l
         XPRATjCJSx2sZbbRGT7G9MOOSwjLdoipEdvjShTfkbnY3ee8NmuIXA66o2UbvIsUeDXx
         BPa67xuiK/TZzi9Fk4knm1NO3eIR2HRne/RrjVPJd0EZHH8Yh54coZoyQmsbybp3O7DD
         FrMoc+ErXoIhJnDB9OrZDgezfHiYEZ5aeLsYmXDoMjqUdia7u/INJ2TWS40PwvwYN2Tg
         CyeeGV8meH0dCrg7ioEI2wtaKKCmczyF9eAJT9wwy5BIGI4JyRM+8jnsaPm0fdxPCZJr
         N3aw==
X-Gm-Message-State: AOAM5307TiBY1js+koOUFuJSKnBxjjyjvQxj5WIHOiwJGjwxDnugNJGs
        C75OWqIIWX/iq5BBzFyCsSudqrT4vmL7Og/JF/U=
X-Google-Smtp-Source: ABdhPJz0QWwrHrvUl7iKf3IEh97sRGVFOmUnnNmc9k8pCPY07Wx2RU7bqV9290VeQBfoPRSIGtnYyLAyjW/hAANsDb0=
X-Received: by 2002:aca:f189:: with SMTP id p131mr3674797oih.31.1614904620036;
 Thu, 04 Mar 2021 16:37:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.974.git.git.1614898292503.gitgitgadget@gmail.com> <xmqqpn0ebicj.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn0ebicj.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 4 Mar 2021 16:36:48 -0800
Message-ID: <CABPp-BFL7-Na7btLxcdvaAtM1AGG6xXxwXt-YxGO-rh9e0NeKA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/RelNotes: improve release note for rename
 detection work
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 4, 2021 at 3:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > The former wording could be seen as hinting that more performance
> > improvements will come in 2.32, which is true, but ...
>
> It is somewhat dissappointing to hear that, as the above "hinting"
> was exactly what I wanted to achieve by leaving "continues" in
> there.

Ah.  I actually threw that last paragraph into the commit message
almost as an afterthought.  Perhaps "commences" or "has begun" instead
of "continues" would have worked?  When I saw "continues" it just
looked to me like an accidental copy of the commit message and one
that could be misleading, so I thought I'd flag it.

> Will queue, though.
