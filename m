Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C252022A
	for <e@80x24.org>; Wed, 26 Oct 2016 14:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754803AbcJZOHb (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 10:07:31 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39262 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753883AbcJZOHa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 10:07:30 -0400
Received: by mail-it0-f65.google.com with SMTP id q75so927695itc.6
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EFemTbo0GumPNKdBxff0EK39M78oVJeBJGLSYqPf4Vw=;
        b=nm2hlg2uLLDp3AAQHz7rxwuQ/ll2EVXI7ERG1ch5IioDB+Xjpqx/FGlfRxX9d6AAUO
         kqGAxhKXPaxuQaWuIfyOmEilTC3mbkAUKyrorDuhcy58z0QSuRGnSyh7lim/HO0zFxYd
         MZN+lMqrwDEIxyLVwVtVhwJDQCDMArbxTrdGeTIyxhy9Puz8gyyuBGJPIjSsGr88R/0P
         0yT3qwsKtktyKtrEJdBdVSTMBLPnxsTHZ3eI+jOCXHK7NA6IBhXo4cUlQp24KWW7oynr
         KyWK3F15E2SDJrgHbjF5jsqMMZLIpT6gd/s6wtRsn5goLMMGUbqtI5JIKl0gyIJll+hn
         dBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EFemTbo0GumPNKdBxff0EK39M78oVJeBJGLSYqPf4Vw=;
        b=IVjxeqbc9CSUxA35Eq7L0W5bNIrKqE08vfAU39xZXyd8VKQ8bO25LUgmf0a5ookwk2
         ELhGbKJsK8U9cDxZ6LGcZbj1gugD1eOJrrrolEF6k6Sf/iuE3SO8Jet9jjV5NQyk0ZK1
         7yOPy44q99L67kRVACDcorxB378I0O6Iah8nHJcI/H++0exT3EfH1SMb/To6KylEnIp3
         FnoC/Ex33nCTJAUx0w5+Xs2Vonj+yIasZuhwVmGt77MLg/ERQ0HI21n7rLaorfKoe7cd
         HqbEJCRUU6kb0h4I21oW/3KPSBJHWc6Y7akvNH14g+uWs0c9FeIeogKb/abZydXk2KpL
         SWIw==
X-Gm-Message-State: ABUngvewmLFdX2WNp+VXQJJT9HuulkNJklEatcAGWSRKejcB2nTtJKHMpLYuQi1gKyn3FtKr9YgamQnA8yl9Lw==
X-Received: by 10.36.118.82 with SMTP id z79mr2569936itb.74.1477490849863;
 Wed, 26 Oct 2016 07:07:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Wed, 26 Oct 2016 07:06:59 -0700 (PDT)
In-Reply-To: <CAGZ79kb7PaqnyXZ7u0z8Q__ahTLKX8RQwV=dw7vbD4C9LnjOtw@mail.gmail.com>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-28-sbeller@google.com>
 <xmqqr37560gv.fsf@gitster.mtv.corp.google.com> <CAGZ79kb7PaqnyXZ7u0z8Q__ahTLKX8RQwV=dw7vbD4C9LnjOtw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 26 Oct 2016 21:06:59 +0700
Message-ID: <CACsJy8BY9QLb=xkGywss+FBo+EBw7O7Kc3P1Kwkxnp0_4ZsnpA@mail.gmail.com>
Subject: Re: [PATCH 27/36] attr: convert to new threadsafe API
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 2:18 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Oct 24, 2016 at 11:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>
>> Make that a double-asterisk.  The same problem appears in an updated
>> example in technical/api-gitattributes.txt doc, but the example in
>> the commit log message (below) is correct.
>
> The implementation is actually using a double pointer, see below,
> I forgot commit message and documentation
>
>>>     GIT_ATTR_RESULT_INIT_FOR(myresult, 1);
>>
>> Are you sure about this?  We've called attr_check_initl() already so
>> if this is declaring myresult, it would be decl-after-stmt.
>
> I forgot to update the commit message and Documentation.
> GIT_ATTR_RESULT_INIT_FOR is gone

I was asking whether this function/macro was not thread-safe and found
out it didn't exist as well, and it's bed time so I'm stopping. Will
continue my skimming on the next re-roll :)
-- 
Duy
