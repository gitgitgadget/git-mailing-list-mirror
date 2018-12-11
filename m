Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC1C211B3
	for <e@80x24.org>; Tue, 11 Dec 2018 02:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeLKC2Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 21:28:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38072 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeLKC2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 21:28:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so589885wml.3
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 18:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Sxaf0r9B8F/rXECbI6k5A7wVUnRHDLP0mRicD8RaHKg=;
        b=eOprtNO9zFbPjLpyEHT8ziP/jG1QiHbs+n0PpB/NUT/XIm/cpDP4rSmoEiKs8xFPX6
         onYvHPqgCLyf2xeE/nPgzRtZRySgkt6H6JC6pDttQIQKZd/S7diKeYrFi4EyKMi8k2EY
         xVe/JQRFWJ2mypCMOPwebWU30vH/xoiUJ1e1T5bDyorUZyp9hhJNn+nFsYCfbUk3I2ww
         cPYdHp6crFfD6BmXGqOUicykh4KDITEp+J4Twl6yKuDqppulrpICTC6UEUeGU7efeSXp
         Ghmv33kqg7f2bs7WWM8D5/95HczSOXt3XpuadC0KyTQWmp8wfOZGserscfmNwlcQoJof
         B0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Sxaf0r9B8F/rXECbI6k5A7wVUnRHDLP0mRicD8RaHKg=;
        b=HzwlZpPJ3fBEH90Sod0tGWQOBfqHR8RIGo3eBtGhfKq/LNSWvCE2oxdjLVJH+ZQq6v
         hPy4+vB/5xn8d4lMO+BxBZZSgqB5rqvLx1eGW6UUL80vpmgZyaXRWEshoFJGbAiDlfK6
         l6og8KUThtu3qHcMHWPVnywpP8ThY4Dx4otZ2cTB9HSWkGsg4f2vPgfM6NpNSNr1KuVo
         rneSRj6WqylH3QAnvK0KxXqh7+9mE6Szpqd53opbfMYkvWGFn4Av3M1F8ytAvgAb0gRQ
         blNEDmg8Zwke0/hYspq6eDITXdyCEgBschsoIpBCd3ynWMTznadNSYWZWViP+EbCBO5W
         B/WQ==
X-Gm-Message-State: AA+aEWZ0cBlcxs98w1m0qAKsy4vxVOHrhhBSwH1OoMSkvbyMuLQKoKHM
        Aixt/60tchH+81+TVY39vkE=
X-Google-Smtp-Source: AFSGD/Xo2NGBlHvaKpgjwEf930/xilW+guzha6ska93BTwLVu4cNe4S80B8RWkd/rD3wsFTa5tyohw==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr622703wmd.36.1544495294444;
        Mon, 10 Dec 2018 18:28:14 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x20sm828789wme.6.2018.12.10.18.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 18:28:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/8] entry: support CE_WT_REMOVE flag in checkout_entry
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-4-t.gummerer@gmail.com>
        <CACsJy8DQd_DcuogF2Wnj47F6ef26L1dea7M2Yi-ESZ_naQZ=kw@mail.gmail.com>
Date:   Tue, 11 Dec 2018 11:28:13 +0900
In-Reply-To: <CACsJy8DQd_DcuogF2Wnj47F6ef26L1dea7M2Yi-ESZ_naQZ=kw@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 10 Dec 2018 16:58:10 +0100")
Message-ID: <xmqqbm5sn6f6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> +       if (ce->ce_flags & CE_WT_REMOVE) {
>> +               if (topath)
>> +                       BUG("Can't remove entry to a path");
>> +               unlink_entry(ce);
>> +               return 0;
>> +       }
>
> This makes the path counting in nd/checkout-noisy less accurate. But
> it's not your fault of course.

When we check out absense of one path, how do we want to count it?
Do we say "one path checked out?" when we remove one path?

> Junio, do you still want to merge that series down to 'next' or drop
> it? If it will be merged down, I'll keep a note and fix it once this
> one lands too.

Sure, I still agree with you that "git checkout" that reports what
it did when given a "<branch>", but does not report what it did when
given a "<pathspec>", is being inconsistent.  If it makes it easier
to manage, I can kick nd/checkout-noisy out of 'next' to be rebased
on whatever more appropriate when rewinding its tip.

Thanks.

