Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3207CEB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 11:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjFULT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 07:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjFULTa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 07:19:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAF81704
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:19:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f8fb0e7709so56214905e9.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687346356; x=1689938356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piO+DeU4RYomSGd08caMHVuYCoXuAdUhALRROI9pezs=;
        b=O4soMuuhb4YyXK4egqLd9hvZr5k5Mw1IkaH2znN4/i6CwkrfOMIQEoJSb91HcTtEtz
         kR7ycCRJskmA6WLdm8ZVQ33qW7fmrLmIMVNle0sEF3jUu4SrPuMCXmXHhuQixpw7950y
         T/tszAov3h5ACa0ApZFHQggP16HCWq4ZkKmyUcCyvyshQDiPFlOW9dVUD4DDsP3pL0iG
         tTtYwjeMMRKnJLRwMEuclZOk4QoqZgEybV6QlqSg+MQnQ+FY4jNJo7rG3On50TaJffD0
         O1p/uAgYmkUGk3ycxSvqvDUIIhcN4T76KDm6sttlJpQVJt2Ybduzm49Lk/IrimuELyX6
         DatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687346356; x=1689938356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piO+DeU4RYomSGd08caMHVuYCoXuAdUhALRROI9pezs=;
        b=duqmyc9aoHr42uy5Vq5DUyN1L2D/duC/AOwXbiwNNEzPsxBd8l13nwMoUV9BwSU6I5
         BLZtpB7yL+J6ZGkbzQep0of2GtGi3zElmUwV354y/AdvpOwaTZTXUNtUgG4oMmUSDqcM
         CXTpUN+vj3k4ChJRjY22ulyv+1lbKosRfLWfZ3z9VD+CVJ2Jjh1WO+EWzzYSk2gcRext
         5iWW++0u5UB4mzTaeCkHrK6OdG1RtkK+QBQSu71VuyktFx+8GGuKNlY+fhK2xlrRmTqd
         +3kTqTCraIAsNg97jSFuCrq/mO2s/GT3npw7NxmPNY6t/22mSud24NZ2qBzzeiy3nbDI
         /3VA==
X-Gm-Message-State: AC+VfDxL0v6BCjYqknbeXNo8VGb6sX97TNZaeRukTwkwYMwS/0fnkIx2
        MeEJCOUlNmAgrELUpc1u/B/RmnbBKp3Gf04Hums=
X-Google-Smtp-Source: ACHHUZ5xD16RP8ma0canQ6cdNvepIbb/ajtKEWVo3GlFicMirMyZ69tDYyZ8gky2329I0SBX/sLXatP078GRULz0VSs=
X-Received: by 2002:a1c:7c0a:0:b0:3f9:b58:df5f with SMTP id
 x10-20020a1c7c0a000000b003f90b58df5fmr8174768wmc.41.1687346356134; Wed, 21
 Jun 2023 04:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-6-christian.couder@gmail.com> <xmqqilbotgbp.fsf@gitster.g>
 <ZJLZnS1olivaQ+GH@nand.local>
In-Reply-To: <ZJLZnS1olivaQ+GH@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 21 Jun 2023 13:19:04 +0200
Message-ID: <CAP8UFD0F-n51+4V7Bykb27Px-fUNqk5rpKr5rOj9Ex2tZZXPnA@mail.gmail.com>
Subject: Re: [PATCH 5/9] repack: refactor finishing pack-objects command
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 1:06=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Thu, Jun 15, 2023 at 05:13:14PM -0700, Junio C Hamano wrote:
> > Computing "is it local?" based on the value of "destination" feels
> > it belongs to the caller (one of the callers that do need the
> > computation), not to this function, especially given that the full
> > value of "destination" is not even used in any other way in this
> > function.  And the "is_local?" bit can instead be passesd into this
> > helper function as a parameter.
>
> Hah. I had the same suggestion down-thread, but hadn't read your reply
> yet. There are either a couple of changes we could make to
> skip_prefix(), or foist the responsibility onto the caller (I tend to
> prefer the latter).

Ok, I will make callers compute the "is_local?" bit and pass it to the
helper function as a parameter.
