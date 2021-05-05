Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE2EC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 04:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55622613D8
	for <git@archiver.kernel.org>; Wed,  5 May 2021 04:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhEEEEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 00:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhEEEEE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 00:04:04 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51229C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 21:03:07 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c11so166675qth.2
        for <git@vger.kernel.org>; Tue, 04 May 2021 21:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSRH7oi/SK2RqV2Iqngz+z3SjweNwVswUAoZf6EhkvU=;
        b=fX0Sc9dUPK2HTMwjOJ/pRjJ0DrCi+hvSZPbm1eOHs/Wp8PQtkEvjRwr+Z4VaSj1yEV
         KU6OrfnFzw9CphUZYc8MB1rfUubIuCig5kxd4xMaRQi/PiPuaSeC9aj2LfBp+dRN8AIU
         kYPnQG7a0TZJMD8P3/XXBn8wu+4Wql3lKBeruQx86BvqpGFceU3WYj4J0CfCE00ETCm/
         cPVsMo+aoL4g6ZhHqAVU2ZBHClJ6EQQWWnYIINPVjKn9jhkxtSLT/OyVMiQpVsJ7Rg9b
         Rzk/qm/h7iglJpDHUamWdBYjeKuI/kMOUDGcVZCre9rtIXRs20jZydOafP9yLTXrcpOS
         6QCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSRH7oi/SK2RqV2Iqngz+z3SjweNwVswUAoZf6EhkvU=;
        b=NLT1yBOn99JnE5u/+b0yKmxWfRP61TXWq47Me1ViFNMMyZCttIHtBoRwRkMsClhNn6
         FR45lohxty/fE3HOeHkpXXqLSv/AYkNBm/wb1PbfdX+m+MaR7TrlLFvYZ99pfWuzjigW
         tgdSHaciIuNvqOn5uF2pZtWF768h512EyL0Tm1r9GynMw0ZRFvPm8Z+jslxDFdvdTr3X
         nr2QDfOQfDjm4Ue1ONKaSxdB9y3kpNpR8QZeGcqd3Ml0XpBNpmJi0ATN4BOW3QoD+WUV
         i0QysdXu3YW2R4CRI5sxprdeaQI5Xw+eSok9MygnrqlMZ2R0yPwifW5zT0177fUUgEaR
         MirQ==
X-Gm-Message-State: AOAM530NWxG4a1GOS7/S7RHkJJv9bw+pTPVKVBcZL08B3EUPSz3diEGn
        thLaWgbMC044fBm4c9WgsZUvar9Y4dSeQTiBbNc=
X-Google-Smtp-Source: ABdhPJxqELEs+tPJJDfFFmxGSpI6msWgNphnGSO4nrApWGFNaq7cQB3Xvs8X++2fP+xMcFbqfHuN71nv2EmioRPWIpM=
X-Received: by 2002:ac8:490b:: with SMTP id e11mr4774952qtq.126.1620187386419;
 Tue, 04 May 2021 21:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210412085251.51475-1-andrew@adoakley.name> <20210412085251.51475-3-andrew@adoakley.name>
 <CAKu1iLXRrsB4mRsDfhBH5aahWzDjpfqLuWP9t47RMB=RdpL1iA@mail.gmail.com>
 <20210430095342.58134e4e@ado-tr> <021c0caf-8e6f-4fbb-6ff7-40bacbe5de38@diamand.org>
 <CAKu1iLWbmPrVjAcgLKP1yisjmVxJr+kKQWJLiqkRzh=aAzETwA@mail.gmail.com>
 <20210504220153.1d9f0cb2@ado-tr> <CAKu1iLXOFiUGmQUeoW-YkiiJ8P2+LznXWz4YabEiGktv=nUYjA@mail.gmail.com>
 <xmqqczu656iv.fsf@gitster.g>
In-Reply-To: <xmqqczu656iv.fsf@gitster.g>
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Tue, 4 May 2021 21:02:54 -0700
Message-ID: <CAKu1iLUaLuAZWqjNK4tfhhR=YaSt4MdQ+90ZY-JcEh_SeHyYCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-p4: do not decode data from perforce by default
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrew Oakley <andrew@adoakley.name>,
        Luke Diamand <luke@diamand.org>,
        Git List <git@vger.kernel.org>, Feiyang Xue <me@feiyangxue.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 4, 2021 at 6:11 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com> writes:
>
> > On Tue, May 4, 2021 at 2:01 PM Andrew Oakley <andrew@adoakley.name> wrote:
> >> The key thing that I'm trying to point out here is that the encoding is
> >> not necessarily consistent between different commits.  The changes that
> >> you have proposed force you to pick one encoding that will be used for
> >> every commit.  If it's wrong then data will be corrupted, and there is
> >> no option provided to avoid that.  The only way I can see to avoid this
> >> issue is to not attempt to re-encode the data - just pass it directly
> >> to git.
> >
> > No, my "fallbackEndocing" setting is just that... a fallback.  My proposal
> > *always* tries to decode in UTF-8 first!  Only if that throws an exception
> > will my "fallbackEncoding" come into play, and it only comes into play
> > for the single changeset description that was invalid UTF-8.  After that,
> > subsequent descriptions will again be tried in UTF-8 first.
>
>  The fallbackEncoding can specify only one non UTF-8
> encoding, so even if majority of commits were in UTF-8 but when you
> need to import two commits with non UTF-8 encoding, there is no
> suitable value to give to the fallbackEncoding setting.  One of
> these two commits will fail to decode first in UTF-8 and then fail
> to decode again with the fallback, and after that a corrupted
> message remains.

I'm not sure I understand your scenario.  If the majority of commits
are in UTF-8, but there are 2 with the same UTF-8 encoding (say
"cp1252"), then just set "fallbackEndocing" to "cp1252" and all
the commits will display fine.

Are you talking about a scenario where most of the commits are UTF-8,
one is "cp1252" and another one is "cp1251", so a total of 3 encodings
are used in the Perforce depot?  I don't think that is a common scenario.

But you have a point that my patch does not address that scenario.

> If we can determine in what encoding the thing that came out of
> Perforce is written in, we can put it on the encoding header of the
> resulting commit.  But if that is possible to begin with, perhaps we
> do not even need to do so---if you can determine what the original
> encoding is, you can reencode with that encoding into UTF-8 inside
> git-p4 while creating the commit, no?
>
> And if the raw data that came from Perforce cannot be reencoded to
> UTF-8 (i.e. iconv fails to process for some reason), then whether
> the translation is done at the import time (i.e. where you would
> have used the fallbackEncoding to reencode into UTF-8) or at the
> display time (i.e. "git show" would notice the encoding header and
> try to reencode the raw data from that encoding into UTF-8), it
> would fail in the same way, so I do not see much advantage in
> writing the encoding header into the resulting object (other than
> shifting the blame to downstream and keeping the original data
> intact, which is a good design principle).

I agree with the idea that if you know what the encoding is, then
why not just use that knowledge to convert that to UTF-8, rather
than use the encoding header.

I'm not sure about how complete the support in "git" is for encoding
headers. Does *everything* that reads commit messages respect the
encoding header and handle it properly?  The documentation seems to
discourage their use altogether and in any event, the main use case
seems to be a project where everyone has settled on the same legacy
encoding to use everywhere, which is not really the case for our situation.

If we want to abandon the "fallbackEncoding" direction, then the only other
option I see is:

Step 1) try to decode in UTF-8.  If that succeeds then it is almost certain
that it really was in UTF-8 (due to the design of UTF-8).  Make the commit
in UTF-8.

Step 2) If it failed to decode in UTF-8, either use heuristics to detect the
encoding, or query the OS for the current code page and assume it's that.
Then use the selected encoding to convert to UTF-8.

Only the heuristics option will satisfy the case of more than 1 encoding
(in addition to UTF-8) being present in the Perforce depot, and in any event
the current code page may not help at all.

I'm not really familiar with what encoding-detection heuristics are available
for Python and how reliable, stable or performant they are.  It would also
involve taking on another library dependency.

I will take a look at the encoding-detection options out there.
