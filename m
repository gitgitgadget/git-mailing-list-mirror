Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75853C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 08:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510B9611BE
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 08:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFQIFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 04:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhFQIFi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 04:05:38 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B58C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 01:03:29 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id q18so4625903ile.10
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 01:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gMjNhOA9iKD0P6bYDkYHUhBZEzU4D4tWS021Nt7bvG4=;
        b=cDAJGk5YwO35mD9lkreB8SDw+lEnIsZThxE7vYgHq+yf6UwtFUQ73BtWCpgovm+17d
         b1TRgsrLe+hTR8iSYFQH/EslDqLOaJROeZTFPmOqGJHOgyHuhwg1V16k+2PJa3PofgRa
         CSb7O4t74tfcXlMRlsy8fafEf0puY4Rqt0UZKi3wBhv5+hzAMLCebB42K4JA1igGyDbb
         J6iv4MD1SV2Mv71fSfdjMp0JYHeJbeGvX+MypWnm+QnPeUCxqth67cvmdg1AiF67lDtC
         0TTNxAvR0WayucBNtDJCP2Z+kQaqvNfBw7Dh1+yv6u8hChQqRUP0nyXvqnIIUp/UVC06
         PeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gMjNhOA9iKD0P6bYDkYHUhBZEzU4D4tWS021Nt7bvG4=;
        b=Pz3/e7F9jaBB3uE/nTJoJKnEr686Of1W51z7JZbtfYOdJx7apXSlBiz49uEad7JJpB
         WAyjqvmN+x3HiD2zORDYJjhpHtd79+VcXjyk02pC6Ri/ahvnbWhBpk/Fe5iFbVrhJQro
         4j9VHeGS0r8ATwBn185fGcPW16PaEW0wyPqOo6QUqlBuNDS9p4K/5OxKIqpv+V4ycrSI
         y8R/SbdNBc20Z9i9kKN/jwns9cQRc3XI3KZHk0+jU/0Mwp/R32AR9VTrAQDitSIMqE7E
         HzLyvMurnLcZhqW6DJbU+1jDAoP4e6nMLA8DXjz1N3EiSrRBwqDKkBvlTeOzEh2aR3ea
         GXYA==
X-Gm-Message-State: AOAM531tNZh8E+VJhreACavv8RrpriThHyyjoXxkH6e0P5ECLjwstamN
        4bxpD3Xev9PypiBMINcVhnu8ca7JwgeurTRkfR8=
X-Google-Smtp-Source: ABdhPJwylQNtv/O5bf4mcfZ8vsDNuH1t67Uv1z5gDh0YpeSgfBAEOjwvE/T6kebNZoFePnPnppf2PqU7hbm/29uTuK4=
X-Received: by 2002:a92:2004:: with SMTP id j4mr2601654ile.53.1623917008479;
 Thu, 17 Jun 2021 01:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <pull.980.v2.git.1623763746.gitgitgadget@gmail.com> <d2f2563eb76ac2e2c88a76edfac7353284407ad2.1623763747.git.gitgitgadget@gmail.com>
 <xmqqv96ep7u6.fsf@gitster.g>
In-Reply-To: <xmqqv96ep7u6.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 17 Jun 2021 16:03:17 +0800
Message-ID: <CAOLTT8T3Ov80w8LkUOw-vwqVB_WptiNZOCTPh7N5NGZwroAnnA@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] [GSOC] ref-filter: introduce free_array_item_internal()
 function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:49=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Introduce free_array_item_internal() for freeing ref_array_item value.
> > It will be called internally by free_array_item(), and it will help
> > `cat-file --batch` free ref_array_item's memory later.
>
> As a file local static function, the horrible name free_array_item()
> was tolerable.  But before exposing a name like that to the outside
> world, think twice if that is specific enough, and it is not.  There
> are 47 different kinds of "array"s we use in the system, but this
> new helper function only works with ref_array_item and not on items
> in any other kinds of arrays.
>

Well, this is indeed ignored by me.

So free_array_item() --> free_ref_array_item() and free_array_item()
--> free_ref_array_item().

> > -/*  Free memory allocated for a ref_array_item */
> > -static void free_array_item(struct ref_array_item *item)
> > +void free_array_item_internal(struct ref_array_item *item)
> >  {
>
> And "internal" is a horrible name to have as an external name.  You
> probably can come up with a more appropriate name when you imagine
> yourself explaining to somebody who is relatively new to this part
> of the codebase what the difference between free_array_item() and
> this new helper is, where the difference comes from, why the symref
> member (and no other member) is so special, etc.
>

Yeah, "internal" is an incorrect naming. The main purpose here is
to only free a ref_array_item's value.

> I _think_ what is special is not the .symref but is the .value
> field, IOW, you are trying to come up with an interface to free the
> value part of ref_array_item without touching other things.  But it
> is not helpful at all to readers if you do not explain why you want
> to do so.  Why is the .value member so special?  The ability to
> clear only the .value member without touching other members is useful
> because ...?
>

Because batch_object_write() use a ref_array_item which is allocated on the
stack, and it's member symref is not used at all. ref_array_item's symref a=
nd
itself do not need free. The original free_array_item() will free all
dynamically
allocated content in ref_array_item. It cannot meet our requirements
at this time:
only free the ref_array_item's value.

> In any case, assuming that you'd establish why the .value member is
> so special to deserve an externally callable function, when external
> callers do not have to be able to free the item as a whole (i.e.
> free_array_item() is still file-scope static), in the proposed log
> message in an updated patch, I would imagine that
>
>     free_ref_array_item_value()
>
> would be a more suitable name than the _internal thing.  When it
> happens, you might want to rename the static one to
> free_ref_array_item() to match, even if it does not have external
> callers.

Make sence.

--
ZheNing Hu
