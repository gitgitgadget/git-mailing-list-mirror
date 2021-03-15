Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBADC433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 09:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5C764E74
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 09:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCOJfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 05:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCOJfS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 05:35:18 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6F9C061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 02:35:17 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w195so27225104oif.11
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 02:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRVpJ4ERKuPac034zUC1AvMfTKd1Kkd1epem97sCaNY=;
        b=GkFgiocekG34iy1jSbSOdUkeiVACKNjApXlzo4K66H5gov8j9k7aCVLMYaEHr/rgCI
         WJRt/spEoZTampWeT7SDsNOb74jFnfpnoGppdezqPXDo5THFWgxWfWJkUb7D9JJQcmjH
         /eIi4NMfgfb05p1TLP9tY38++v1wPjvAGyRKQZULKQra/rs2Jfcx2aSxNWJMrIube210
         3CYUZfXw0b7j2DZCGbq22F/KGADKfzESKdgT2pRui7QsztTj+VhdcluLl54c7Y7yl0r5
         tcbfjZDEBcfJ4Wv6E/yTJtz1X/yQEBBktxUkNJLN5zqpwrNcYKXHjeyHvQLmyEa5Wvlj
         NqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRVpJ4ERKuPac034zUC1AvMfTKd1Kkd1epem97sCaNY=;
        b=N+6TreYIome9mpELmXJplY08cvffZn4EGTriRSnuCDSkPJywTscCW726IH6qi1BHRF
         HYP2si0JQUX3bx9eWji0bnzw6OkNcWdLfc/HraWEroNOVyvqggwSBxRTMEi1257dUuNp
         C92HO7Gct5kt1meXKxMTqNh06E6NeA1rnfKixaG3dfHMdP3EIi5eiTZfSvenWxx5V5nF
         OV4Dbp1gCZiEr8I0hfScUPTBB8Pij+0dRtlsmE8LEX7GuaGMi6UcmhuxbfqCnC+CNvuI
         +xOzy5QmLrqU4KuZ1U/jIpV+Exs4CjEYRtXViAT+r4vTE+XQOQT4dvLI2oSkbxdf1dsr
         /1Wg==
X-Gm-Message-State: AOAM531LtWEiiOL4ZPW0lVByrqGu2fCjLItvsOP0WyRIQYTXFGvFx3/w
        bTTItv6uAZGU9c49HRGlbyZ3uvlU+Rck+2TVwtI=
X-Google-Smtp-Source: ABdhPJz+xxSp5Qx5mj51ca46Zi5d5PkuAxSB8HTRXqszArVI6UXRvwcjMCdERjMFumAfhHjZa4XGim6zQ9aEhE1shTU=
X-Received: by 2002:aca:482:: with SMTP id 124mr3942298oie.98.1615800917177;
 Mon, 15 Mar 2021 02:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-3-charvi077@gmail.com>
 <CAPig+cRxZFV7DDtnYOxRqEYU4PwXK8gb2HSehDyGorqdgsmoNQ@mail.gmail.com>
 <CAPSFM5c8saGs=+OvXvZw-T2jPpdUfkmm9_BZOmZwUo=WO1sdQg@mail.gmail.com>
 <CAPig+cTBXBjZkJoGFYpzWBnEOmV52dnoBHxceuoe3pu3F0BnYw@mail.gmail.com>
 <xmqqft0y4gl5.fsf@gitster.g> <CAPSFM5f_=+S5XbE928a-q+OmaPi0iVQXZbJnHVy=ycGwdd8tGA@mail.gmail.com>
 <xmqqblbl4aro.fsf@gitster.g> <CAPig+cTO0umN4nAQi_qZEvTByCHFVavM-KbtfhkukXEUdzLPhg@mail.gmail.com>
 <CAPSFM5fQeB8dOQRzWkwAJCkHtNb2GXUWqgJUHCWoJh0vdDp_Fg@mail.gmail.com> <CAPig+cSZ45ZKqFfzL01ZFFA=pkLRVuktLKhVC=_dPoXbHSBcBA@mail.gmail.com>
In-Reply-To: <CAPig+cSZ45ZKqFfzL01ZFFA=pkLRVuktLKhVC=_dPoXbHSBcBA@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Mon, 15 Mar 2021 15:05:06 +0530
Message-ID: <CAPSFM5d+gXwB9orKd_JATh-mgjjxZH2WgS2485TpZhuoQHJvgA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 15 Mar 2021 at 13:46, Eric Sunshine <sunshine@sunshineco.com> wrote:
[..]
> Thanks for patiently putting up with reviewers who sometimes have
> opposing or contradictory opinions and recommendations.

It was more a learning path and helpful for me to proceed. I really
appreciate all the guidance and suggestions received. Glad to get this
merge!

Thanks and regards,
Charvi
