Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE5CC433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 14:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFA164F18
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 14:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCSOLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhCSOLA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 10:11:00 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DA6C06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 07:11:00 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id f9so4897639oiw.5
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 07:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AJbrQzaVvIVO0E1uJQxI3+y/YN/YckDGTaYyxTtD4V4=;
        b=BQyK2TQaz7cZJepAEaCsrjXrP78nA2Dy/OBZavIVOTMuznhIyJ6EBwE1fpH/lICKto
         zgp2AwMMfktlIwYXL4iO9EmrPBXZB4jL01FZ1ngvYvabzN44H0qU+86K+OYuywT4/4dB
         OoDRvzaLMcD/p6kbHAWumiRIvdcpRfMVbWZ5QLrAvSi1TBnzEefjkd+uqZEBwVHPfSNM
         lurYhm3n4qnf8tTf/ooj5fRafKw+0NpVbp7ldbimoF2aBt86GKGVleeMeZneotRoghLz
         2MNbKGBBSZrfbdWk5qaqXGiyPRbmwzADQkPbNbpLUAhdfKC4+cwOEFu++mCgHlBr3nx6
         kIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJbrQzaVvIVO0E1uJQxI3+y/YN/YckDGTaYyxTtD4V4=;
        b=uE5PhGusJt8j58cuSlLdaVhmCljoOz/xRjSsRXLx7ToAQ8kniSbOKScjQIZKzymjkE
         0tCmxKBK2EDQyGmAQ2Yp0opEJ+57l7jUPbW+iyjGEaf362bjh5zhLbnuL3/hUcElGfih
         BErmi1ldLozFF45nqoUuW2BPKsGldgTh2bBG8gQw/g9lDA8fosSL4UWquvvKEOrf7/j4
         ZOvcb6jsDhykkt1ILmHtHOj4Bo5goGP6aXUPepvVKzCsH6M9+f3Dwwro4U+SJ/1S1mIA
         rxVQNFl1TF5+00+7Nf1VZPQRGpxnUmlm6xxhH/8VbngWKT4Oodr3ICmUEyZiJM+7ZbyP
         jraA==
X-Gm-Message-State: AOAM5307rE4CsCFXSUr73aB5UBGqLNiy8AV5EaDb9BEQUvVFZ3YMFlXS
        ULU1BG2O1jWC4jqLNyq4Ur95kqXZd8xo1d6p/ZfT8OJ8KqM=
X-Google-Smtp-Source: ABdhPJzrkKRH+Z6hw2nSpVhefruatvzimxEDIrUT03giiVjDfe966VcLrtuyFCdt7IsOkqUFXqK7NY3Sv00s8/PgPLo=
X-Received: by 2002:a05:6808:1405:: with SMTP id w5mr1175374oiv.48.1616163060066;
 Fri, 19 Mar 2021 07:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210310194306.32565-1-charvi077@gmail.com> <20210315075435.18229-1-charvi077@gmail.com>
 <xmqqft0sotg4.fsf@gitster.g> <CAPig+cSNgpw3LTbqj-_eBMM5SpKcOJUxM0Oszkuy4ju1zqH5Uw@mail.gmail.com>
In-Reply-To: <CAPig+cSNgpw3LTbqj-_eBMM5SpKcOJUxM0Oszkuy4ju1zqH5Uw@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 19 Mar 2021 19:40:48 +0530
Message-ID: <CAPSFM5fypzDgxKUVg1Lj4biV5T3bg6mSaLWu_QV4Ru_QwsLbPA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6][Outreachy] commit: Implementation of "amend!" commit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 19 Mar 2021 at 08:46, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, Mar 18, 2021 at 8:53 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Charvi Mendiratta <charvi077@gmail.com> writes:
> > > Example usuage:
> > > git commit --fixup=amend:<commit>
> >
> > Are people happy with this round?  I gave an extra round of
> > eyeballing and didn't see anything suspicious, so I am planning to
> > merge it to 'next' soonish once the dust settles post release.
>
> I gave the series a final read-through when v6 was posted and didn't
> find anything about which to comment. I think all my review comments
> on earlier versions have been addressed, so I have no objection to
> seeing it merged to 'next'.

I too agree, thanks for confirming.

Thanks and Regards,
Charvi
