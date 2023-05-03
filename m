Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5898BC77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 18:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjECSiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 14:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECSiP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 14:38:15 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FC34C24
        for <git@vger.kernel.org>; Wed,  3 May 2023 11:38:14 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3ef34c49cb9so503391cf.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683139093; x=1685731093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/+kdEHsEXsHyCmZsEqb570gNtTqDY6tjP6YSLPyndA=;
        b=Zz9gncaUACe10qxjBCjT8xWifUgSyQuhzRz8goSPqoWIMa2yM2KOigWHTXxPBhMYV3
         m2s7Sa0NlI9VLcENBTnav/O5BZjZW7ls0sdLzNIg/AeBsZNpO38irgLO96UhHKYcV9wK
         l6Bw1pwQWEInLUHkCtnHhNxrG3LAfsxWSRcJThi1t8MO0JLnsK1RloVrnZV10Ikm0v55
         H1F9NjzwLNeiHIYGDpOSZNmOHCUMzpE6BIwCgevI3u0/UjOoDPnpxEfAYjqpExbyuWDN
         KFyEpMB6Jpt1I4522mGxMZYbefs5dvmHz3Q8Ff296s5tJlty6mZQlYs9Z+Uteh73AfBa
         5Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139093; x=1685731093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/+kdEHsEXsHyCmZsEqb570gNtTqDY6tjP6YSLPyndA=;
        b=QGe9HpXt69fYwV209/U15LiMDEcTOVKwttu1LAtIK0QsWJb7LGKS/aaPwXbc4xWraV
         yISacAU9vvzjLAYO2P96aj8y6JjHiyPF4X/eUgs29uSHv3J2XIYKcG3WOfVBNmXkrUbi
         D12HIZUzUKsqjwKYVO1r4WMKmp5q/Q+PTz3umuBVOGgA7VzqoumAeiLv2egq9wEUhd1S
         hjSfDc4AbihRQjkXuZBkjurjYKFpet4sw/Vx/wz2MTYGEKzEYEUJW+vQJt2km/ex3Lc/
         w4MSVw4J8HYS28mt3UOilZu4Yp8Jy5kByqZYEw2dxm4XHKGGc+TMMon7ViI2BgZE6//H
         Y2OQ==
X-Gm-Message-State: AC+VfDzARkbgte5SadJWN2eFuhFovs+2UhDbrpu73xC7dy0vE4vboFs4
        +/jnJnEHy9oNMOcEiQXBqRBY509+gdwfoz2vdkush7TrzoIZTzAth/4=
X-Google-Smtp-Source: ACHHUZ7AXVDB8dFRPDcaxNjcqy+oR9u5umPeH65wtM+SOzkhCfgAbAhggPHZ8DkD1gDINqzb7Bvfl1jN1ejHlcqEqYs=
X-Received: by 2002:ac8:5845:0:b0:3f1:bb90:c006 with SMTP id
 h5-20020ac85845000000b003f1bb90c006mr17056qth.11.1683139093533; Wed, 03 May
 2023 11:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com>
 <20230502211454.1673000-3-calvinwan@google.com> <20230503162858.GA1789686@coredump.intra.peff.net>
 <20230503163446.GB1789686@coredump.intra.peff.net>
In-Reply-To: <20230503163446.GB1789686@coredump.intra.peff.net>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 3 May 2023 11:38:02 -0700
Message-ID: <CAFySSZCAmgw=f81Jb2f45_nN4hL-k6vct2hb7rhqfHkdOOBVLQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] credential-store: move related functions to
 credential-store file
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for digging up the history and context for these functions. I
agree that refactoring these functions right now is not worth it and
can be saved for when there would be new callers to them.

On Wed, May 3, 2023 at 9:34=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Wed, May 03, 2023 at 12:28:58PM -0400, Jeff King wrote:
>
> > I think the main reason we do not have other callers is that urlmatch.c
> > implements its own percent-encoding code, and that's where we do most o=
f
> > our URL handling. It does make me wonder if credential-store could
> > simply switch to using that, but that is probably out of scope for your
> > series.
>
> Poking at it a bit, I think the answer is "not easily". credential-store
> has broken-out elements of a URL, and wants to turn them back into one.
> And urlmatch.c's url_normalize() always takes a URL string as input.
> Even though it finds the broken-out fields as part of its work, the
> parsing and reconstruction of the URL are inter-mingled in a complex
> way (i.e., it's not just "parse it, then turn the fields back into a
> normalized string).
>
> I'm sure it could be refactored, but it's probably not worth it (and
> again, this tangent is somewhat orthogonal to your series, except that
> it would make these is_rfc3986 functions go away entirely).
>
> -Peff
