Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8133D1F406
	for <e@80x24.org>; Fri, 12 Jan 2018 18:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965144AbeALSGH (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 13:06:07 -0500
Received: from mail-yb0-f176.google.com ([209.85.213.176]:40501 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964977AbeALSGF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 13:06:05 -0500
Received: by mail-yb0-f176.google.com with SMTP id i12so1557109ybj.7
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 10:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oUIlzb2TOxMqD+9Nl6DHAx+lWvkgS0WFxI5ZuNr+XNY=;
        b=wALzzOUjqdFRCetwQTNowMv45cBgVuqIZh2JDK/qlOqkDMvRuJZHiUHddE0+bJjG9t
         OIGUXthUfnBGbPIYDIlZngrsrFo8W2+TZKvb3pnxiJHSLOqsYacFBMdSRS9txB6VKsyW
         lvsn7BAQu6S7PZV6kQsdvSsDF6p8fX9lMAaN6/MxhXQ/MIlV3ihOOxEYEsBxiro+IMlh
         naBlnTjk3inBWeMNP1pHKr9pokN6pfaMSL8fy/quLZM206+xfTAH9nqanuwUyJbw4agD
         F2QpUwbfrqqq6fu9AcOZ2g7SKILGUeDw5Xl17wE822buzyAx38ca/EvWBnv3IrL/m0l9
         77Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oUIlzb2TOxMqD+9Nl6DHAx+lWvkgS0WFxI5ZuNr+XNY=;
        b=oSo6DPg9DdP8d5JUD+/FmX+lw68db3ua7vhz7VxNdWd/t/f1AJY/pGamH75XNOWQFP
         UUgq+eaYquFpfp0A++V0qCTqnF6rHp/jEEeXpcAwSQ5Bz1xi+Ur4aarTvnwUaKJVq0wn
         PNSED9CmShRkTf2bcup5IFKFX4g/t3qXbrfHDJqW8g3kU9xmlY7FMWbW4xfgNIg2fouo
         acHCbNsYEoUt4ama28d1bSgYqMim6GnY2+wDexV0wgrPG2y9VELSJeB3wYf6ZQRtrQUe
         S1DdmCsWWMahZMhUPxI+EigRj9CNrFvRXlYSU44oMMTIXc+S9EdTYeAj518WHp7i0o7x
         YVeA==
X-Gm-Message-State: AKwxytf6vqD0LWhr89XBIjrwB0LPaRAgaYuH/9CeD5fhHWQ4mdQS8nn7
        uV+84KcmTvPoAN3J1ISlfjMBC0/jUqXxIOt1WLLxcw==
X-Google-Smtp-Source: ACJfBovnikXirlIo55pkWcqyPYhq3u8i4j4TNwN4ylDw4x2Pox0gtzv5hejdTVn0BbAjs8DLrOUxLKv+O76Z3AH1NW0=
X-Received: by 10.37.92.4 with SMTP id q4mr5302983ybb.39.1515780364402; Fri,
 12 Jan 2018 10:06:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.134.197 with HTTP; Fri, 12 Jan 2018 10:06:02 -0800 (PST)
In-Reply-To: <20180112133613.GF27499@sigill.intra.peff.net>
References: <20180111094712.2551-1-pclouds@gmail.com> <20180112095607.18293-1-pclouds@gmail.com>
 <20180112133613.GF27499@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 12 Jan 2018 10:06:02 -0800
Message-ID: <CAGZ79kZRFCLEtyWCjKm-vM36Gf1EJfEAAFxEFz0wQHv4bqPc_A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] run-command.c: print env vars when GIT_TRACE is set
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 5:36 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 12, 2018 at 04:56:03PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> v3 turns a single patch into a series. Changes from v2
>>
>> - env var quoting is now done correctly (from shell syntax perspective)
>> - the program name is prepended in git_cmd mode
>> - cwd is now printed too (because I have too, see 4/4)
>> - we don't blindly print the env delta anymore but print the actual
>>   differences compared to parent env
>> - which means we also print "unset XXX" statements in $GIT_TRACE
>
> Overall I like it, though I raised on corner case in 4/4.
>
>> The new output on git.git looks like this
>>
>>     trace: run_command: cd 'sha1collisiondetection'; unset GIT_PREFIX; G=
IT_DIR=3D'.git' git 'status' '--porcelain=3D2'
>>
>> a bit longer than I would like, but that's because of
>> sha1collisiondetection and it's not long enough for me to invent
>> $GIT_TRACE_EXEC.
>
> IMHO the unconditional single-quotes make this longer and uglier than it
> needs to be. I've often been tempted to have them kick in only when
> necessary. Here are some patches to do that (on top of yours).
>
>   [5/4]: sq_quote_argv: drop maxlen parameter
>   [6/4]: trace: avoid unnecessary quoting
>

I have reviewed the whole series 6/4 and think they can be applied as-is,
though I have not thought about the corner case you mentioned.

Thanks for this series!
Stefan
