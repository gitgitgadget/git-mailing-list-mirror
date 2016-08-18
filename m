Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46FA51F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 14:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946459AbcHROH6 (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 10:07:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33826 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992986AbcHROGu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 10:06:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so5765710wma.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 07:06:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JOEkibFIyDPIO844a7LzV52OjHqFuRXdZ8I18HNA17A=;
        b=GkJjToTUM3RpYIexfnKjKBK7fmGj1+D1j4OUsFwwiWpIrTKJsPZT073/GHBjiwE96P
         WzUI9TPYhfiBzJd/+R45KDGAvLyY+uLP58/YxTiB2B8w/4LuXh5na1+QvMPXfaRTderJ
         sX2VG/RxEUxCf+s/0kRqisjc5DCP4pNIj2YFLi06Mpjt46Z0s8oFocGtcaHrWTd1WKyt
         tJwM6hu2xTROvW/ZDIu4D1MAcQ93jCxoNfciBRedgsL9hRXZqK7NTNcr/FzS7EP2+wMw
         EgQien89M3Sb6JEJt/7uvQDgYYLP0JNx2IoaDebPA0gJGKhv1NZqT+qhzf3QUK6NeiHB
         Wn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JOEkibFIyDPIO844a7LzV52OjHqFuRXdZ8I18HNA17A=;
        b=Z5O7dTXeVf8X5K60ivQFOi3WL5wGrgDYCMdOpn8Ftd/4YXO4TOpZp5P4QxWu6CgnWc
         x6H9vaR1gyNAB/DxmfnsLa0Hl2To/aaOonhxoGUJTaXH3jjN/Awh/BKMFbXeMbpF+9/q
         lyz2sDbpRxbrmCNhpfbZi+I/8ZPWv67buwS1Xqw3C84mcWhP97QoDyKYCagusCYMJyaz
         RFXC9vBViH4AgibE4Ft0D+vnOC8SOUic9uXm4Mey8FIsEYI9XnkeSMmSNE9rqMGTAo1t
         uEMqrk04R0lahM5qO6XrWAPgZ+WH0zGEPLve25nphd2Bckwk1zT8hCxEKVMRu/b2Ouv/
         Zz1g==
X-Gm-Message-State: AEkoouviygjVo/Mt3M+ijs94b3I+RNwnwtblmUchxdQtPMdWZ1xJO7+JQkZVKbwhGDJCvIjYk9NvspIi5TN8bw==
X-Received: by 10.28.225.4 with SMTP id y4mr2774177wmg.98.1471529208874; Thu,
 18 Aug 2016 07:06:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Thu, 18 Aug 2016 07:06:48 -0700 (PDT)
In-Reply-To: <20160816162141.b3jtmun3kynjnwxs@sigill.intra.peff.net>
References: <20160816081701.29949-1-chriscool@tuxfamily.org>
 <20160816081701.29949-4-chriscool@tuxfamily.org> <20160816131640.h2zzn3sy5qqdeewc@sigill.intra.peff.net>
 <CAP8UFD2r-Zi757zizRQq-TPp+dO=+=ho=7oOipjPxY4ksmzC=g@mail.gmail.com> <20160816162141.b3jtmun3kynjnwxs@sigill.intra.peff.net>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Thu, 18 Aug 2016 16:06:48 +0200
Message-ID: <CAP8UFD0Wtekn-qR+RvRmj+rHFZS2DvFhqYdnygU0LwSabYLyoA@mail.gmail.com>
Subject: Re: [PATCH 3/3] receive-pack: allow a maximum input size to be specified
To:	Jeff King <peff@peff.net>
Cc:	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 6:21 PM, Jeff King <peff@peff.net> wrote:
>> >
>> > Is there any reason to use different filenames and sizes for the two
>> > runs? They should behave identically, so it would make more sense to me
>> > to subject them to identical inputs.
>>
>> About the sizes, I thought that some people might want to try sizes
>> closer to the limit and also that it is good anyway in general to add
>> a bit of "randomness", or at least variability, in the tests.
>
> In general, I'd prefer a systematic approach to introducing variables
> into tests. If it's important that we test different sizes, then we
> should do so, and not only test some combinations (and if it is not
> important to test different sizes, then we should not waste CPU time and
> the mental energy of people reading the tests).
>
> IOW, when I see this, I wonder why the index-pack code path is not
> tested against a 2k file. But there really isn't a good reason. So
> either it does matter, and our tests do not have good coverage, or it
> does not, and it is just making me wonder if the tests are buggy.

I don't see things in the same way, but I will make the second file a
1k file too as I don't really care much about that.

> Worse, both files are created with the same seed via test-genrandom. So
> I suspect the 2k file is a superset of the 1k file, and we may send it
> is a thin delta (so it really is only testing a 1k input anyway!).

Yeah, I will use a different seed for the second file.

>> I thought that it would be a bit less wasteful to use the same "dest"
>> and also it would make the test more realistic as people often push in
>> non empty repos.
>
> I doubt it is expensive enough to matter in practice. Though note that
> if you push the same commit to two new repositories, then you can
> amortize the test-genrandom/add/commit step (i.e., push the exact same
> packfile in both cases).

Yeah, it probably doesn't matter anyway regarding efficiency, but I
still prefer to not create a new repo as I would find it more
confusing for the reader to use different repos.

Thanks,
Christian.
