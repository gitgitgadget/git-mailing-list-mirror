Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8537A1F4C1
	for <e@80x24.org>; Sat, 19 Oct 2019 18:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfJSS4J (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 14:56:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33765 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfJSS4J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 14:56:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id c4so7041899edl.0
        for <git@vger.kernel.org>; Sat, 19 Oct 2019 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+tvtekvF9KAI/K03KF/h+1hMsVmG+o+c3i5NnTZLzk=;
        b=Y77eJ8FsDnNWvKDa3jAVKqrjvSTHzxvXhxRrigJv7qv2z48Bl+LllDR0f99KaeNjGm
         wl+n78O2ii4j5uIXRjATZlS7BrJStzwtjagF6j1R47UtfsRc5VSoPLBO7KooqrPE11ZK
         P+nft2tV4o2NtdKcsl/B4oyUAGEvAHxBldy6HIkVPQx0Xahwgpk49YkNCAPT0HLOSFYC
         R5rqdLJ3kOlzP0p+VXqspLP82/DCTqDlcwmpFDqa0vncw8GKNOGaL1WY9OLm39QcJtO8
         4GCAEeRaAqK0p95/TJ+ckF0cpSGaKRBZdoFDH13gORrxkExHmAjZgV6KJc1G37zs6ARs
         28aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+tvtekvF9KAI/K03KF/h+1hMsVmG+o+c3i5NnTZLzk=;
        b=MGs7hNW/GWy2GM4hDeMCgwdI+iHMGUSpAq5xEwNFvhcVFdQWU41DPUWMjLDPQjYs9L
         TkSFj2tbzKSsWYI6ELp5jV8lB4dzWT0YcyU7shHmJ/oRT1zvNCsX4fhtCwm6HOKRRGIx
         bmmIevq7IwGSMgDp4emXTRCtUy/WmBHxUEDhiyQN4DkdA7t5SSC4+ZxeiiQXDQ34lSgL
         uwG1oL/I5uj9PoO+QvpUDtk1A1K7DRHfOYAuqct5zk69pSZPVkD49J54evsA/fckDg3q
         LaQ6gNaN1frN+2QBGRU8wZc3fJRLGJ9ouf9Ml1If3eo+Q+QSgsNCLvUmjH77F9HIu5Gf
         WrZA==
X-Gm-Message-State: APjAAAWhv6+Gk5om22uwI6vMpsFI/iJ3rmIXS0yEwZih/3eXRNO/WlX8
        9SoUn6c+LKLZWxj7Ckqw+A3Q01EiVhga8Kw3Vr0=
X-Google-Smtp-Source: APXvYqwaWQU68L7rZmOV9Es+WeHhUJ/6xBeKij4L+suNfoOeir8mlBgSHvql1tCzRVj7xrl4/VVrkhYQH+eLTHDqvI8=
X-Received: by 2002:a50:d616:: with SMTP id x22mr319837edi.110.1571511367265;
 Sat, 19 Oct 2019 11:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
 <20191019103531.23274-6-chriscool@tuxfamily.org> <dce8e0b5-c4ea-f4f6-6275-1322f2d7200b@iee.email>
In-Reply-To: <dce8e0b5-c4ea-f4f6-6275-1322f2d7200b@iee.email>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 19 Oct 2019 20:55:56 +0200
Message-ID: <CAP8UFD2dLPguCnUhTu+F4SNPxFZ7YT5io0qXkVwvSNP-sA8Jxg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] pack-bitmap: introduce bitmap_walk_contains()
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sat, Oct 19, 2019 at 5:25 PM Philip Oakley <philipoakley@iee.email> wrote:
>
> Hi Christian,
> can I check one thing?

Yeah, sure! Thanks for taking a look at my patches!

> On 19/10/2019 11:35, Christian Couder wrote:

> > +int bitmap_walk_contains(struct bitmap_index *bitmap_git,
> > +                      struct bitmap *bitmap, const struct object_id *oid)
> > +{
> > +     int idx;
> Excuse my ignorance here...
>
> For the case on Windows (int/long 32 bit), is this return value
> guaranteed to be less than 2GiB, i.e. not a memory offset?
>
> I'm just thinking ahead to the resolution of the 4GiB file limit issue
> on Git-for-Windows (https://github.com/git-for-windows/git/pull/2179)

I understand your concern, unfortunately, below we have:

idx = bitmap_position(bitmap_git, oid);

and bitmap_position() returns an int at least since 3ae5fa0768
(pack-bitmap: remove bitmap_git global variable, 2018-06-07)

So I think the fix would be much more involved than just changing the
type of the idx variable. It would likely involve modifying
bitmap_position(), and thus would probably best be addressed in a
separate patch series.

> > +
> > +     if (!bitmap)
> > +             return 0;
> > +
> > +     idx = bitmap_position(bitmap_git, oid);
> > +     return idx >= 0 && bitmap_get(bitmap, idx);
> > +}
