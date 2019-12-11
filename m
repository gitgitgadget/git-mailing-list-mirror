Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561AAC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 13:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CAD20836
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 13:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7QMgJ4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfLKNu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:50:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35229 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfLKNu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 08:50:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so24127327wro.2
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 05:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZqvMOvFd/U60xArWj6+lka/Lz9Sbv54+FxwKmaVz34=;
        b=K7QMgJ4+njHbbiUuekZstBZxEDpwnb2Ji/rE02leT5CGKUtKlB1R/Yp3ULxIUpkll4
         KHbiEdVz8e9GekpXRBa9hvigpuBdDrmDrTIuQDRqfftrswO5k2KB4ItOdXfrqzCWDUey
         6naVqs5Aj3CdOqiVabGvUieMqzA7yCqF+hJUXH3uQCKmcyF7GQDn80Jsnm5Oc9zb3M40
         B/MiO/jhDRubALs1eyAth7ykTtNI3WvVy6T83sAfSoIKhpzpxDjbuKNWN43qUVg8JRz4
         jN7+0X36R3QPIkD/96YSJwuNZ7JWq16gUhh2SE7M1PH1jOxUJ/kPwTmRQVvHNXOD5Uq9
         mA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZqvMOvFd/U60xArWj6+lka/Lz9Sbv54+FxwKmaVz34=;
        b=m7sd8oCHv9jq5ePhqxdUuQV3ytG4y6bfgqko8nq4SRMBs1rfqDs/cFYkq8XTs/TnAJ
         7xkbDZklAzAqFtQ/kNCVIoGO0bSXAwYAwYOF1ng56qyAhsYXpKyYbpcuv5wFeJLH4JKi
         0/f3VORx3Af16fiquLVilJKNLMEqV916WvheKi022+i55JDDQWR1D+BvF4AilHFuoOdO
         IZqdGKzUkaAF/OqjUmdHp165kG9EREzP4AEVk20VwEBAXcgSmfaU3NhcxkwENAAaN8Ig
         3PUzyqDeajXbGK4vritf874QfVZKKSJy9h2G8sl+Ur4xzJEzvJie3xrTDhg/0/T0U4v8
         LVBQ==
X-Gm-Message-State: APjAAAVScxFZ85MQdgc7keedwMbNTUy+2CPiQHmsfARXMpL6cDi49hCV
        Su2wO+xzLG27KZoZqgvSf2Q4YATOmRy782DNpdkeVw==
X-Google-Smtp-Source: APXvYqztbHS3Epj0U3obdKwdKl0Rl6UAzSjSDX+M6RHfDaCpSLoHoO2qHIhd2FIncLIKQrAIClzeuNU+BfNzRUY86yU=
X-Received: by 2002:a17:906:f49:: with SMTP id h9mr3381733ejj.6.1576072252827;
 Wed, 11 Dec 2019 05:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-4-chriscool@tuxfamily.org> <20191209062841.GC40570@coredump.intra.peff.net>
In-Reply-To: <20191209062841.GC40570@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 11 Dec 2019 14:50:40 +0100
Message-ID: <CAP8UFD3PwuSyJ0kjiYKo_UbgqzC1hjJS0rkBjhdfuNmC6hvGvw@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] ewah/bitmap: introduce bitmap_word_alloc()
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 7:28 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Nov 15, 2019 at 03:15:35PM +0100, Christian Couder wrote:
>
> > In a following commit we will need to allocate a variable
> > number of bitmap words, instead of always 32, so let's add
> > bitmap_word_alloc() for this purpose.
>
> This name is much better than the horrible "bitmap_new2()" it was called
> in the original. ;)
>
> I wonder if "new_with_world_alloc" or "new_with_size" would make it more
> obvious that this is also a constructor, though.

bitmap_new_with_word_alloc() feels a bit verbose to me for such a
short function, so for now I kept bitmap_word_alloc().

I think that if we really want to use "new" for constructors then a
better solution would be something like renaming bitmap_new(void) to
bitmap_new_default(void) and bitmap_word_alloc(size_t word_alloc) to
bitmap_new(size_t word_alloc).

> >  void bitmap_set(struct bitmap *self, size_t pos)
> >  {
> >       size_t block = EWAH_BLOCK(pos);
> >
> >       if (block >= self->word_alloc) {
> >               size_t old_size = self->word_alloc;
> > -             self->word_alloc = block * 2;
> > +             self->word_alloc = block ? block * 2 : 1;
>
> Since this hunk caused so much confusion, maybe worth calling it out in
> the commit message. Something like:
>
>   Note that we have to adjust the block growth in bitmap_set(), since
>   a caller could now use an initial size of "0" (we don't plan to do
>   that, but it doesn't hurt to be defensive).

Ok, I added the above as a commit message note in my current version.
