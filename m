Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC210C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C773F610E9
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbhHaRpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 13:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhHaRpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 13:45:09 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF215C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 10:44:13 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id a5so10949802qvq.0
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iARKu0ZkoG69SyULiNa9Xmah0nmWHAg1WnHEw+NwnGM=;
        b=SOOnSwEor55UpV0mrYTODtmbFddJO7p4ncZ6L+LXT31u9bytbzFL9z0km9geNhRRxF
         7+D7CTr1KP/keOA3EmAMhJR7KEoDylR9az3MKA7wsNANixJL3b0yzbMPV84W1QBT4fs0
         3BqAPgfXO72ZYz502qnSsqAqBYx3OMKVyPH98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iARKu0ZkoG69SyULiNa9Xmah0nmWHAg1WnHEw+NwnGM=;
        b=sD+9UtwRY82TIlyXIs54K0sIVC5ZI+cBN5f1TQfN9miqf28cEFt/mXbcIgtYq+ktWq
         hojQb1ArZHSZiqMsOCdmHgJcM7xYcmIOg/F6FzgDI+iZeHQIxJm/K2Rt5a9l7YRZjDfg
         4bs7Nn4Ese0E/0pMk06eKywa0/++JnYThLjBUyFsekhexdrAnYBFf3vq8zNz6kUv1frY
         Cb4MoyAjMb+r7LHYTGqnthFjwlQskxSXOgJ88M0Uqsz/YsVQETXrdGOBN1oxJL5x2x9z
         KD1+vfNl/PvvUs+II6Gl0raut49YRBot0fG8cOXmwhKBGSbwxwn3C/6UfamveVDvi6Hb
         xfOQ==
X-Gm-Message-State: AOAM533sKrvIsCBCOogC7jRBe+32MtA1a7320qJ3bR6xNZO+7wgXs5bJ
        TobxixmPzA36J9iiBBGAFmkkYOXkpNC11Ar/rFtmAQ==
X-Google-Smtp-Source: ABdhPJwaubsk7gHwHcezXgFMN6TaUy0/VmqXS56TOHM2MJNbKICcoUPYzGhc3AsQ3TWSmpaXz5ivTk5Ne01AJUc75rY=
X-Received: by 2002:a0c:e803:: with SMTP id y3mr30744265qvn.39.1630431853046;
 Tue, 31 Aug 2021 10:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbl5ic19t.fsf@gitster.g> <20210831093444.28199-1-jacob@gitlab.com>
 <YS4DmlJdjxeo+QI0@coredump.intra.peff.net> <CADMWQoPerffQcTfKh3bfesjgHaBqXGzW2805knyRW3R_q4V-YA@mail.gmail.com>
In-Reply-To: <CADMWQoPerffQcTfKh3bfesjgHaBqXGzW2805knyRW3R_q4V-YA@mail.gmail.com>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Tue, 31 Aug 2021 19:44:02 +0200
Message-ID: <CADMWQoOfPr47a6bJtApt=wSE9BrgXQKJRfJuNAj0zbtio2BRHw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] send_ref buffering
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 3:08 PM Jacob Vosmaer <jacob@gitlab.com> wrote:
>
> On Tue, Aug 31, 2021 at 12:25 PM Jeff King <peff@peff.net> wrote:
> > I do think it would be nice to take the packet_writer
> > interface further (letting it replace the static buf, and use stdio
> > handles, and using it throughout upload-pack).
> I would like that too, for the sake of neatness and general
> performance, but I don't have the time to take on a larger project
> like that at the moment.
I gave solving the problem with packet_writer a couple of hours today.
The diff gets too big, and I have too little confidence I'm not
introducing deadlocks. This really is more work than I can chew off
right now. Sorry!

Jacob
