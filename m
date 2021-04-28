Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEEFC433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 17:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B55961151
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 17:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbhD1RRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 13:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhD1RRu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 13:17:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F879C061573
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 10:17:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z5so38693304edr.11
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REKnLnNqGVFoGyJO6R+EHzSv0XXlJR0+HEgLHwuqiGI=;
        b=gf8wo9StNtV0aBW80HLFf5lNa4iDYUYvSnhmWUtxrxEbIRhvssHpKjkGNtz5MqyF+x
         Yb1Ph7OXKfU1nPhBnLD1ACmRqWlRfqzjYdQzMbQSg18j2up2t+7MJAtlCg1T0UzQrIhS
         Q9UyhucIQlhAIdK7GouydR/66+jwH5BqrlODJ/88xKULwsF4mHaeFWZtEWn8KKVNv1UL
         qRMXvtpO/UnsKM/Qq+dS5FRe49jts0xmSwSfFqIkmIz/yDTA9vum4fIhFCkbqUd3hi/Q
         LzY+0n8bNtWz4RyPAW29qm8Oubq09N29XjzvJFXEwyK2NN56fWPNvGbsci4sR3oeCju0
         tNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REKnLnNqGVFoGyJO6R+EHzSv0XXlJR0+HEgLHwuqiGI=;
        b=ciKsDpE792qRQcHQ4VJxC+uLWCSvUC/7UbrOatWmHEDdgxCW3B76zFB3NKwm/xUz/b
         mPxc7h+bHaR5wmXl/3SZJjq8PIzy+ovx8NAghFOfbZCz8cx8BTzay3zplA1nKhYXZ59K
         8zwjRXs48AuhoLEvNcL2WxchKxTmvC/TNpU1ZEVoZQCNgWGDZll5RjXhVH7yvTcCKitk
         m4lRAqNPY5FdR6vX96CpufQJMHfTWMC7wMBKGG9pX49E3eCTm+V6MdmllAb6hx4K7kqQ
         eX+u/i4iK8iCld7QUIdAhqxZ0VtRV+iJmzfbEMr490eklq7IeeyXJ7frvH0SU8NhjVkF
         brsQ==
X-Gm-Message-State: AOAM533mO21qgRzmKUKKIfWfUJcP5IdVS/Gx1fzPqa/HcMRo3VvyyVpo
        pzNVxmGu9kVfye+Ti7JR8Ypcz47RwIsUtuaucGc=
X-Google-Smtp-Source: ABdhPJxVA+uhMc0oL30ULjYrxCeC4xVvpvS5UXF+4uxBeqpn07bmIIi0/ql1Iy3h8RduRtRughGa7FSfs6ErDSUim9E=
X-Received: by 2002:a05:6402:270a:: with SMTP id y10mr12908745edd.387.1619630223789;
 Wed, 28 Apr 2021 10:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210425080508.154159-1-bagasdotme@gmail.com> <CAP8UFD0k9fwwW94BKtMPLmA=Qx1ce3Qh3UfF0KiC5+AOj-=MiA@mail.gmail.com>
 <CAPig+cS0yA3TP9PBi2ZtQx5UeKRbFgwXqeqB1sC6QPB7q+Lu2Q@mail.gmail.com>
In-Reply-To: <CAPig+cS0yA3TP9PBi2ZtQx5UeKRbFgwXqeqB1sC6QPB7q+Lu2Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 28 Apr 2021 19:16:52 +0200
Message-ID: <CAP8UFD10vLX_rF=P374BP-CeE5cxs1Rg6faxqf+m3J4MH9Vb8A@mail.gmail.com>
Subject: Re: [PATCH v2] t6030: add test for git bisect skip started with
 --term* arguments
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Trygve Aaberge <trygveaa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 28, 2021 at 6:32 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Apr 28, 2021 at 4:12 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> > On Sun, Apr 25, 2021 at 10:06 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > > +       git bisect reset &&
> > > +       git bisect start --term-new=fixed --term-old=unfixed HEAD $HASH1 &&
> > > +       HASH_SKIPPED_FROM=$(git rev-parse --verify HEAD) &&
> > > +       git bisect skip &&
> > > +       HASH_SKIPPED_TO=$(git rev-parse --verify HEAD) &&
> > > +       test $HASH_SKIPPED_FROM != $HASH_SKIPPED_TO
> >
> > It might be a bit safer and more consistent with the rest of this test
> > script to use double quotes around $HASH_SKIPPED_FROM and
> > $HASH_SKIPPED_TO, like:
> >
> >        test "$HASH_SKIPPED_FROM" != "$HASH_SKIPPED_TO"
>
> Also, is there a reason for upcasing these variable names
> (HASH_SKIPPED_FROM and HASH_SKIPPED_TO), thus making them appear to be
> globals even though they are used only in this test? More appropriate
> and less misleading names might be `skipped_from` and `skipped_to`.

In this test script many variables are called HASH1, HASH2, ... or
PARA_HASH1, PARA_HASH2, ... So in this regard HASH_SKIPPED_FROM and
HASH_SKIPPED_TO look ok to me.
