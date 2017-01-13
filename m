Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0406F20756
	for <e@80x24.org>; Fri, 13 Jan 2017 18:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbdAMSoF (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 13:44:05 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:35391 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdAMSoE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 13:44:04 -0500
Received: by mail-it0-f45.google.com with SMTP id 203so38322319ith.0
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 10:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2qS11AhqmjISDIcAH5nUIsPK/lCNSQISMqdBFdNQfbY=;
        b=JLxMHmgItjfiPsYlE1xY0FKmA56fidvt5CGFevyi+Vpc8eLFEy9Ckq09FHwiDOY8/s
         rM80rq3F5WLrZdCFfz0HZ0YfgRT3UyalkDU+FrFilleKSF94rJ5YMTvXeaOSzGJ5euti
         hGXmAQmcxWa68+W6wZJjPQE13AQvYAbw23/jdrutTWLlkzVUOeRp73bQ1VodqB/sgJ7M
         v5VIOnvATy55QW2D/Y4QTKXLFg8Iv18cJg8kOnmsvg8gSRTLFEZYqbucEnQJnv0Q0wfi
         p1dI59lfXhmBKxO0Fe6d26DMYNKtdhZ1JeAXGDcRtPeumYJM+N9uzvq8b6LB0oZuZktP
         /7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2qS11AhqmjISDIcAH5nUIsPK/lCNSQISMqdBFdNQfbY=;
        b=BTxt7+TYMiup3/uUAlZZeLEbqKttQCZHpEVhxxS9NzV0o4N2SJetOH9/2MtLuMsriT
         m0uMi/S8sovr/aBOHvnyJV5kzsVcsbtOh4SH9qIAm+1wJdXtMwsIFT8ul8mLyn1dUQnn
         XC7Djhg8xTR9vqdRZX2sIOpTWwfFRIa6TyAenlDGLpGoUNGLe3IAx63DnAV1sTBNDk8m
         R2KNXgeIZMqUl/cM/Fu6vUpaYratAvCNUD0fTRRIRDVx5cu7+GLdi3TPkpRL2o0mTpaw
         oWj2HJ6JPjqNWGKb/TgE7yayW8T2booQ2rhBvOfn1lozA2wG9zWMmvLCZ0aWz5Yb0yf4
         xRkA==
X-Gm-Message-State: AIkVDXLqN7MJE/MbJd3is+puRo2+woICgYky0rqthRcdKN5ycIqXOcEZf8CmpVn+w1Crz9JzJ4nNKJQMBilDXbRQ
X-Received: by 10.36.169.12 with SMTP id r12mr4049970ite.69.1484333042964;
 Fri, 13 Jan 2017 10:44:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 13 Jan 2017 10:44:02 -0800 (PST)
In-Reply-To: <e55dc4dd-768b-8c9b-e3b2-e850d5d521f5@web.de>
References: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
 <1484324112-17773-2-git-send-email-vegard.nossum@oracle.com> <e55dc4dd-768b-8c9b-e3b2-e850d5d521f5@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 13 Jan 2017 10:44:02 -0800
Message-ID: <CAGZ79kamTgefk9RxUwFk7hgAQK7kEJJKS6RjNMbnv2=Vk=BTSQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] xdiff: -W: include immediately preceding non-empty
 lines in context
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2017 at 10:19 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 13.01.2017 um 17:15 schrieb Vegard Nossum:
>>
>> When using -W to include the whole function in the diff context, you
>> are typically doing this to be able to review the change in its entirety
>> within the context of the function. It is therefore almost always
>> desirable to include any comments that immediately precede the function.

Do we need a small comment in the actual code to hint at why we count
upwards there?

>>
>> This also the fixes the case for C where the declaration is split across
>> multiple lines (where the first line of the declaration would not be
>> included in the output), e.g.:
>>
>>         void
>>         dummy(void)
>>         {
>>                 ...
>>         }
>>
>
> That's true, but I'm not sure "non-empty line before function line" is go=
od
> enough a definition for desirable lines.  It wouldn't work for people who
> don't believe in empty lines.  Or for those that put a blank line between
> comment and function.  (I have an opinion on such habits, but git diff
> should probably stay neutral.)  And that's just for C code; I have no ide=
a
> how this heuristic would hold up for other file types like HTML.

I think empty lines are "good as a first approach", see e.g.
433860f3d0beb0c6 the "compaction" heuristic for a similar
thing (the compaction was introduced at d634d61ed), and then
we can build a more elaborate thing on top.

>
> We can identify function lines with arbitrary precision (with a xfuncname
> regex, if needed), but there is no accurate way to classify lines as
> comments, or as the end of functions.  Adding optional regexes for single=
-
> and multi-line comments would help, at least for C.

That would cover Java and whole lot of other C like languages. So a good
start as well IMHO.

>
> Ren=C3=A9
