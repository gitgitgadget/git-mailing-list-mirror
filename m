Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0288C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 16:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiGRQS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiGRQS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 12:18:27 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB23F6364
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:18:26 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id s129-20020a632c87000000b00411564fe1feso5812844pgs.7
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=5nIXgC9DBEJhbU/0WGnrO/q1qaoSMLHXEY3Pn1QrK5I=;
        b=oIgtFZsna/On6RzaXxRmjZU4tQUsrm6FSBA5MuzJHov4HPm0EumaqBstISIGDRFGuE
         w/+VsASoC4TWic9NB9mBibod30oYwfPWBP+nM05XBdxcgEsXmVYPlf7GHzC1q+9INDcO
         J3rSQqADF83PR6rsQy1pqEMEvd3xckQ/8N7GcqEqybm+Wq0pH2PpWxo+LsFSCR1HosI0
         9+ceC8d5L/Cj771Eo9q7d63BzQWfJvo0d7ghGn1/o1VKX9zrerlI4nqE7rlFl1iJ73tw
         OYc+FL64XWTXdwvSpmTQ6OsOuAgwMe9/Tyr7TwqEtfG16GspzAlH04fZ3cR/vAlfXgRc
         SLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=5nIXgC9DBEJhbU/0WGnrO/q1qaoSMLHXEY3Pn1QrK5I=;
        b=DoIeGW82UMy5ShUHiiHJFlVRSrcDTZXBn2weA8uCgjbL98w9ukC56yZbiI/lAd9Y60
         381kwvem7h7DIHSnhZ0TZsWBFjq4je/8PitaPW5NIwUuLtl6VHe1lQYWYuW8Bt6TSGBm
         bywZB+FLvdHETi2Rc7cCpWShxv/13rFnh4bvX/bK9ZVSJeBY5qQwj+EmNwe4BsGMR1nv
         6T2c5VdNjyJ5FXjLwP8NqZ9bwR1YQNUU18u0fJxMxhexG0VPAtWa28URwYawd7w/7S8W
         OIV65vBv6pYUu93lXrAgJQw4S+t8T7kvE75zEGYUE56kOvtgooWmOjJPpv0tD5WJz7VZ
         gCDQ==
X-Gm-Message-State: AJIora+FbVdRhIVhlP3WTKluPaMA2VFlvYwpqKJ46dMtzWR6VxQdkZT+
        C9U7sWOqJKjt0444MVfHqCG9pZK9ZzDemYpuz4yX
X-Google-Smtp-Source: AGRyM1v6/Vmwcs42fiXGwTIKutzEEKuyVVw/M8fcpY9/zCH5rvzJHUUGokDNZqDRD5gBE1EUpzKuSv+Bxxa0LJVvIw5d
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:7290:b0:16c:cbcb:3971 with
 SMTP id d16-20020a170902729000b0016ccbcb3971mr16997876pll.165.1658161106188;
 Mon, 18 Jul 2022 09:18:26 -0700 (PDT)
Date:   Mon, 18 Jul 2022 09:18:23 -0700
In-Reply-To: <xmqqr12is9gp.fsf@gitster.g>
Message-Id: <20220718161823.3363013-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: Re: [PATCH] fetch-pack: write effective filter to trace2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> > Using two different keywords.
> >
> > So that the log only contains "filter/effective" when it was actually
> > used.  And there is no "filter/effective" event when (for whatever
> > reason) it was not in effect.
> >
> > Then the "filter/unsupported" event helps you with debugging.  Did they
> > hit a server that doesn't support filtering or did they have a typo in
> > their filter spec?
> >
> > Then don't emit a message at all for the "not requested" case.  And you
> > can use the Git version number to know how to interpret it.  There are
> > other places where we don't bother sending messages where the value is
> > a zero or empty.
> 
> Sounds alright.  We could standardize the other way, which might
> make the interpretation of individual trace entries independent of
> the context easier, though.
> 
> Thanks.

Thanks for bringing up the use case of debugging a server that we
expected to support filtering but doesn't. As for whether we should not
send a message when the value is empty, I can see at least one reason
for not sending it - to not waste I/O and clutter the trace because of a
feature that the user is not using, but fetch is I/O-intensive enough
and having the empty message is useful enough (not only do we not need
to know which versions have this feature, but we also can be sure that
the message wasn't excluded because of some unexpected log filtering or
something like that) that I think we should have the empty message. I'll
put it in v2 but we can easily remove it if we decide that we don't want
it.
