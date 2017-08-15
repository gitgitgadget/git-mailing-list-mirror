Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F5F208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 18:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbdHOSsa (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:48:30 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34857 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbdHOSs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:48:29 -0400
Received: by mail-yw0-f172.google.com with SMTP id l82so9890905ywc.2
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 11:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qxHr6BPPrlTih0uCuml9REqvcqiL4KfaH7d9vhKmIjI=;
        b=ZKF7iKxLyaRexprbt0scUZHPveL6o1NGM2TOck+hInQ94BGstUDJ8xahjnrmk9Sayj
         bWmy+8XysK/y/dZOPkOIozj/70HYUoGRwZ+hoe2evL8w7UT1akO7oIYGbQC5rgqZVqQ7
         EgiIM25S4HXmPC009c/KuXnU87KRkCjfs/7/unMAHJpuLGdw8lpieImOYEnWvqb+7Cw8
         aGv+t7bdUtwDBUJq5L8+KihAypnE5zCuI/lns8YvdFR5EjshHKDS7oL9J4Rkq7IxkXIy
         8ZUjZaxHbQW8iw0Q1WeQti3zcD3eRPVNH9B1X2pj3adFoV97FsCZG9nWWPrEF77pHxJx
         +UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qxHr6BPPrlTih0uCuml9REqvcqiL4KfaH7d9vhKmIjI=;
        b=CidOBLAwnKyiRCkHH3l5wBEXuzoEYxOonoAl6L7F6rHu0OcO2jAW4KBubDs+4THDE8
         1LT2wjgxzp6D81MZe96eDwcovNNoEUOTpjlYpzdrrskmE64R/ip9z5Qe6N86xaR+iA1p
         d89gPcQ20wJAoObFsHzrHjtxE10S1OQp9ur1JR56b2Vxyr1srH61qPwc+JRuNQQmwXMr
         T+v6++OVNmdjTRHiuTu6AL0GiP+XKTMM7c99gdB3o9/agG02gffw7p98mFtybrgvPEHo
         Cvjki6doPACJm75OQwhsMDM53kk2WEtPbpi1IB+XunfNV78iN0TDVSiQxUrva63qaaFs
         CXGA==
X-Gm-Message-State: AHYfb5hvta07T5MQMASgHOiqOwEUVxB3BIDWZchGbd5i8pCyY0mAYXt1
        Q1wUima/ETuUH5TtkqvgSpWcaYhpKsb0
X-Received: by 10.37.55.79 with SMTP id e76mr23787059yba.215.1502822909275;
 Tue, 15 Aug 2017 11:48:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 11:48:28 -0700 (PDT)
In-Reply-To: <CAN0heSoXysu=6E_ScfWQVLOk805V=j7AYJi=z62SmNkP5U=A9Q@mail.gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <cff383c2-ca57-caba-5a46-7dec4abc25a4@jeffhostetler.com> <CAGZ79kbf52Uu-Th9W20QZV204A81kOAPTj2x6JkEP1rN=GTYtw@mail.gmail.com>
 <CAN0heSoXysu=6E_ScfWQVLOk805V=j7AYJi=z62SmNkP5U=A9Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 11:48:28 -0700
Message-ID: <CAGZ79kb-1S9F4Pp0dzkDX488uiZ8Zu_1m2U=hQ1CcsgSu314rQ@mail.gmail.com>
Subject: Re: tsan: t3008: hashmap_add touches size from multiple threads
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>>         /* total number of entries (0 means the hashmap is empty) */
>>> -       unsigned int size;
>>> +       /* -1 means size is unknown for threading reasons */
>>> +       int size;
>>
>> This double-encodes the state of disallow_rehash (i.e. if we had
>> signed size, then the invariant disallow_rehash === (size < 0)
>> is true, such that we could omit either the flag and just check for
>> size < 0 or we do not need the negative size as any user would
>> need to check disallow_rehash first. Not sure which API is harder
>> to misuse. I'd think just having the size and getting rid of
>> disallow_rehash might be hard to to reused.
>
> (Do you mean "might be hard to be misused"?)

yes, I do.

> One good thing about turning off the size-tracking with threading is
> that someone who later wants to know the size in a threaded application
> will not introduce any subtle bugs by misusing size, but will be forced
> to provide and use some sort of InterlockedIncrement().

agreed.

> When/if that
> change happens, it would be nice if no-one relied on the value of size
> to say anything about threading. So it might make sense to have an
> implementation-independent way of accessing disallow_rehash a.k.a.
> (size < 0).

Yes, and my point was whether we want to keep disallow_rehash around,
as when a patch as this is applied, we'd have it encoded twice,
both size < 0 as well as disallow_rehash set indicate the rehashing
disabled.

If we were to reduce it to one, we would not have "invalid" state possible
such as size < 0 and disallow_rehash = 0.

In the future we may have more options that make size impossible to
compute efficiently, such that in that case we'd want to know which
condition lead to it. In that case we'd want to have the flags around.

> For example a function hashmap_disallow_rehash(), except that's
> obviously taken. :-) Maybe the existing function would then be
> hashmap_set_disallow_rehash(). Oh well..

Not sure I understand this one.
