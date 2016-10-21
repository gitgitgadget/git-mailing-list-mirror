Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD6820229
	for <e@80x24.org>; Fri, 21 Oct 2016 17:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932542AbcJURTE (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 13:19:04 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34711 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754809AbcJURTD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 13:19:03 -0400
Received: by mail-qt0-f176.google.com with SMTP id q7so93344912qtq.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 10:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RdYWKmPQGr2GbntebKOfxlHJ8LCwUou+qjpRzfqqBpg=;
        b=K77rSqeCIIqWiM5Ub6CsPRMJZRXsOF1Kd1c8qmkNQjMjELMwUBx2d/o6qwXuxKnmAR
         T+79HIAC9HVxJ7Dlikk8dqHLyZqFY35Pm+k73T391rUQoXILG/7VkxZsszs/3lzRHv3W
         /nmQ4PjKATbKqlbteNpY6HGibBxPvf53ed7UJWISHT2V5pRoTR81S7hehmN7MStkCscq
         x/pTzdRRETS8+MvH0lmANM/QqK4yMJT4sUFAwLoEHs0mmK5rFgZDDjk6glBxixr4/LYn
         JLCFUALwm1HoBpELzeOQYcJZ4FQuCNX1x3t1VV3j9gQ/vp8NtYn9ocKQ5IIrphKdR2Vx
         VBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RdYWKmPQGr2GbntebKOfxlHJ8LCwUou+qjpRzfqqBpg=;
        b=BxCtksR+FQG7eVpR5PC+5UKkSOugM/dhwveK7r1M9ACrdJovsXcBpbNDuGB/hvo+MC
         R3WRAb6l2ndVQlJA0YV1ErmM1K/746NAGlYo6/+KdDczbuTuKoACddsNowI8gGon+D/K
         mdQhP/Wx0Fac+StEe/MhECx+BfN+pig3OSawnPN2C/JEKTilIhzwGh+tGI4gPpOCeAzM
         hC6fPkJufJHlEi5pcOo+ZLsuADjMfV6ayi5wXwvLuU45OzSeP2/6b1e3CRcbY83WctzS
         z3m/fEG2v6Ng3eJ0NM2xbHnqagbvI3kiwMxFwZuPTe/j+N7Z8SWASR6XP11PIDAjfG66
         6oqw==
X-Gm-Message-State: ABUngvcOOi6fyQGq93pmGT4skwxiv+J9xveerCcFMyPrEJ9TBJQKg3cnmJ/sM6ntWnltY10VX8Tdk4nQy9eX97Xc
X-Received: by 10.200.34.145 with SMTP id f17mr2339810qta.149.1477070342553;
 Fri, 21 Oct 2016 10:19:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Fri, 21 Oct 2016 10:19:02 -0700 (PDT)
In-Reply-To: <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
References: <D9C1E13F-88A2-483E-A549-1C2294EACFEB@gmail.com>
 <CAGZ79kZo3LdcRmrjQTAvgx=H6U2tdjASK3qv5A2K5J2HQ2NvSw@mail.gmail.com>
 <20161021082035.xad6wfny5i6wtshh@sigill.intra.peff.net> <20161021084348.dp4jfpfownodl7nz@sigill.intra.peff.net>
 <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 21 Oct 2016 10:19:02 -0700
Message-ID: <CAGZ79kaPAHdRsTXFUqjB843kSq7jVzy7zf4r7hT4YtyxeCPRdg@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix travis TAP/--verbose conflict
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 3:41 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 21, 2016 at 04:43:48AM -0400, Jeff King wrote:
>
>> The obvious fix would be to send "--verbose" output to stderr, but I
>> suspect that would end up annoying for people who do:
>>
>>   ./t5547-push-quarantine.sh -v | less
>>
>> to read long output. Probably we need some option like "--log" which
>> logs in the same way that "--tee" does, but _without_ sending the data
>> to stdout. Naively, that just means replacing the "tee" invocation with
>> "cat", but I suspect it will be a lot more complicated than that,
>> because we still need to let the TAP output go to stdout.
>
> Yeah, it was definitely a lot more complicated. This patch series fixes
> it.
>
>   [1/3]: test-lib: handle TEST_OUTPUT_DIRECTORY with spaces
>   [2/3]: test-lib: add --verbose-log option
>   [3/3]: travis: use --verbose-log test option

All patches look good to me
(1&3 are obvious, and 2 is very well described).

Thanks,
Stefan
