Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E011C636CC
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 02:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjBACrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 21:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjBACrC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 21:47:02 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E336B3
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 18:47:01 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y5-20020aa78545000000b00593b071cb99so4438146pfn.4
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 18:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vbyIFw588oiEBPCzmb9WrywV+qXHxdSGoaSB9NedXAo=;
        b=TX+4ttwANgymfYdOoiGJfVr/Vb7/a5ubQDnlDDt3Khz6sjDZVRoFA7YyDmKjSlZJz5
         L9FbDzSpr/iCAyFouyqGesNb5T1xFmAEoVUiR03Mvze8cVlhy9SzzDm5LyHGvdbjETrg
         I8w/oFdjE5Iiby+Aja4qclh9aoEPeIvGbz0GHaBIhHd7V7KlskKd1KAjM7FL/p+PMMEX
         dLYWAUhIkldREtY7o8j/zS9zQgJlOxXXhcId03eedBq7LdSg6l4afap0pBGYleLicEgm
         nPI9D5fjvsCogRz5dugAvDmW6SclYAOEymxyuvBCkChOGAaoR9h1gTKz6QDTwVDYavu0
         E80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbyIFw588oiEBPCzmb9WrywV+qXHxdSGoaSB9NedXAo=;
        b=f6h9smO/nElSZuA6qCc3uS50xjh0CCa96ICsk2Qm1VhwszdDyTQFCzmZgTDBmQSiVC
         rhDOJQ+PPlZVObw7anTwDkaGrh+mBE+botZ3aaTA4lh1E3wp28xd3WSQft/TNT44dTHJ
         whrV+azdszylY3z5wrqPfEZtIfM9QOcZ3+ia/E/XYZEc/mU0Dl1RvND/Mbbrkw1QJSqZ
         pNRRPafLRvGBF7c+mqkEZOWVEPr4CWVVvspU7r8kfaLJawuW3TDBLqdQxJ0caYnk9IjN
         Jm1O+t0uknDw73JeXVkJie4jDKseqfLTKQsKQDI0ZLjgrd3mLSM6qhgOqPcmJDrEVaSe
         p7og==
X-Gm-Message-State: AO0yUKXI+NW4vH0h7pUuQnrPzMnTU8DGFcf6SbnkzTVBaKedzEQ7WUmj
        patAcDpdQKJpPig2HoU2UNm6zni2trTNawlB8RFacxboi2v9/HpFt39RQj4p7Zuj9LKcJrqhZUy
        5x2XsvG0yDO5qiWA5717cGlALqMCVjZ61Ojs7EUzV18OCCVX7hqnmVRIAJ9v2yhY=
X-Google-Smtp-Source: AK7set8v9rItrup99lveSRn8oD5Oy5gwPso8qaNLsf3z0zZJAqvFjNFhkBekn31hzellMq9O4e7ygv1bFwei8Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:ecc1:b0:193:794:ba9 with SMTP id
 a1-20020a170902ecc100b0019307940ba9mr235866plh.22.1675219620697; Tue, 31 Jan
 2023 18:47:00 -0800 (PST)
Date:   Wed, 01 Feb 2023 10:46:57 +0800
In-Reply-To: <20230201024041.29401-1-chooglen@google.com>
Mime-Version: 1.0
References: <20230201024041.29401-1-chooglen@google.com>
Message-ID: <kl6lzg9yw19a.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] docs: document zero bits in index "mode"
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>>                 The existing explanation starts with "32-bit mode,
>> split into (high to low bits)", followed by "4-bit object type", as
>> if the "4-bit object type" occupies bits 29-32, which is not quite
>> what we want to say.
>
> If I am understanding you correctly (which I'm not sure, since I am
> honestly clueless about bit numbering and big endianness and whatnot),
> you're saying that highest 16 bits are zero, not the lowest? If so, then
> I genuinely made that mistake, hah.
>
> (We're storing 16 bits as bigendian 32 bits, so they would occupy the
> lower 16 bits, right..?)
>
> Perhaps something like this would be better. I took the "unused, must be
> zero" phrasing from elsewhere in the doc. And if I am completely
> off-base, feel free to patch it without waiting for my reroll if you
> think that's easier.

Whoops, this was meant to be a reply to
https://lore.kernel.org/git/xmqqmt5yy08d.fsf@gitster.g. That's what I
get for trying to write the In-Reply-To by hand.
