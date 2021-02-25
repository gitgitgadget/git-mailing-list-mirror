Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F41C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE31064EDC
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbhBYHv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 02:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbhBYHvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 02:51:25 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698FEC061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 23:50:43 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id b145so3076859pfb.4
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 23:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNzWXWm1QCaG3aZT7bqMb0eHBw8EWGiKGHb98v3gI2A=;
        b=gv66E2Iag4j3iLjeKSVlbNBaKigb0y9ZZ1SM4WwGep3U/QTHzc6MGvPNClTimDFlI1
         qkAL6zCnknyq6XBgI0NV2zJuSeHx3uBqH8mntKC1mR/r05nhBys81+zZ4Fuu8GC8q9Cq
         tmdXYd9xWUrrdeArMhBPkSx3ZVV5+eH5cY01fJmDLQlpAFNoZfOiX2k4FR9aWEtHkqZH
         unE53HAyIpPmZv2Nh1PCQRejKN4BLzkybvBkzVpAu4cqgoJs7besXjDuJ6Ok0eZ0ampL
         tZ0KhC0EXRJNAM0pRnEuMsUjRbkMBWKSPpVUID9CgDt8RyTYTAIdsyXFNcXts5H/tZvN
         XgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNzWXWm1QCaG3aZT7bqMb0eHBw8EWGiKGHb98v3gI2A=;
        b=a3WlS6j05R+WBc6P28vxGyzKEXE/S9RxkONU514FfoWRQ06K/YKn89qswWLC4SKE+O
         Z+dfBoKMy/ba9U0C3GiLb+grdLmZKpN3Zk+Vk/zTa/k8AIZAre6/0VTHOfSsQju100xY
         FR2yW+wNZoEyWplJHR782OtRZipZzpl+d5bfLhFCRvRu5mVozqlExIpTbQ3sMf/RhgmV
         ydAnpl2JohzwoaeoClQpsrFH8QDDZ1kBUp8mBJGY/ZbbD2SA+K/VnlEzlh26jsEAbi17
         0eMMzOfW+ETiKcySV8HeBqLCVQo5ttylc5PHi4yRjZ3Q3KmGjLs2kk0YUd3xsFYfnXDQ
         VU6Q==
X-Gm-Message-State: AOAM531pof81Euk9aFdxsNji2S7YQX8Gvwy0Tmq6aDSy7jNuYh/+JVEk
        eAm3axdZGNf5YroFNU1AK6DhH0yRTJvhqxWqTdo=
X-Google-Smtp-Source: ABdhPJxBhzcIzHWJBus+ST7I83Pm+n4MGnNHwT5p6N/a7mJfA0AP4Ocs1MlB2MkhMD5+71hIztnJPRo+JLOD9mXBhU4=
X-Received: by 2002:a63:d506:: with SMTP id c6mr1898233pgg.77.1614239442978;
 Wed, 24 Feb 2021 23:50:42 -0800 (PST)
MIME-Version: 1.0
References: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
 <YDROhhrM5qJti1ir@coredump.intra.peff.net> <YDVo0kGYODP0JjqT@coredump.intra.peff.net>
 <CAGgn8PcPtLNtZTmMqKKTmH3KOezkr-jY7aTEDA-0dvYWuzid9A@mail.gmail.com>
 <YDa/EupbrNa62r+D@coredump.intra.peff.net> <YDc3dinQ37FY8fhD@ncase>
 <CAGgn8PfdGBuB29Gxba6OmhSagjqwH2DNUv9XyJnXUhcKpJZBsA@mail.gmail.com>
 <YDdDUILUUXA1ytva@ncase> <xmqqim6gwrf8.fsf@gitster.g> <YDdRgwwuvZBGuSVP@ncase>
In-Reply-To: <YDdRgwwuvZBGuSVP@ncase>
From:   Yaron Wittenstein <yaron.wittenstein@gmail.com>
Date:   Thu, 25 Feb 2021 09:50:06 +0200
Message-ID: <CAGgn8PfnWQRy_ovN29RfMH7cyP62y67uStD2cGUwgr4_ovLuOw@mail.gmail.com>
Subject: Re: [QUESTION] Tracking HEAD changes?
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you all!

I'd like to make sure I understand the way things are right now:

1. The reference-transaction hook as it's today doesn't intercept
symbolic-references changes.
It means that when HEAD changes due to branch-switching the hook won't
get called.

Are there any other cases that today the transaction won't execute? (I
couldn't think of one)

2. The mechanisms that handle the changes to index and working-dir are
isolated from the one that manages the refs updates.

A side-effect to that is the post-index-change hook running before the
reference-transaction one.
Future code changes to the way git operates could result in the
reference-transaction hook running before the post-index-change one.

Is that correct?

  Thank you!
      Yaron

On Thu, Feb 25, 2021 at 9:28 AM Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Feb 24, 2021 at 11:13:47PM -0800, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > So what you're observing is simply mirroring "reality": the order in
> > > which git does its things here. There can be arbitrarily many
> > > transactions in a given git command, and the only way this can be
> > > changed is by changing how the command operating the transcations works.
> >
> > In other words, ref transaction is only about changes to the refs.
> > There is no such "transaction" that treats a series of operations
> > like object creation and index manipulation that may happen before a
> > group of refs are updated as a single unit and make it atomic.
>
> Exactly. Thanks for putting it into better words than I did.
>
> Patrick
