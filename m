Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42821F403
	for <e@80x24.org>; Tue,  5 Jun 2018 22:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeFEWOb (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 18:14:31 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36311 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeFEWOa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 18:14:30 -0400
Received: by mail-oi0-f68.google.com with SMTP id 14-v6so3611900oie.3
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 15:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t/f2gZXbkdhwsl6xO87Drb5+ch/5O/ihCl15qD983TU=;
        b=D4szPKJe6S7kRVfrBFdHl8xmFDHq9QXccIc0bwyTsu35SfpSFNTWEqU5g0B6zkFpsD
         0VjS/9yvjRWSda0rhdtLYK3fj+5O/OPqJcB/Rku7NzR7fKqgF6Be9udan79HsyvEuzGA
         1he7jbSMthTQq9rtHIUwwpfzZVUyoeCpoIvnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t/f2gZXbkdhwsl6xO87Drb5+ch/5O/ihCl15qD983TU=;
        b=brwi1Ev8i+rk6WDzhn8HUI3K9tvHBRf3GdRM9CNXCPg/IM5FutJMJeQwEN0YYywqLB
         PeWlz5I9wUBOa+4beDQuWhr5Pk1/LdS/Ssc3APGKi7BXFETUMdzwSz1GG7G0zsBadngz
         76OM9EDMHXpXXHysEDFVggFAPFKkLtN50N8yYkCXg6UmRN6aMxUuomJTT8yQPmkDQ3te
         /XNtCGgYa+ZHcYufUYR9FnDy9Ga5V/5SeVHIRK3N2TZg5w30XxBA7G91822iDkamrwmT
         D3oknK7+TkaKvkUcjL7yyWWhA6APDI+b6XT4cNZsXKPstIOMgspRDBZMweLl1IyW+5T7
         EJNA==
X-Gm-Message-State: APt69E2Bko7o5wyuwUV0VMq+Z5ShtnXHAeUZA1BlpDMe3wReBheUizws
        d9yvKdWKTOOFkX72E8pXwAVeIkpB2w1WEpiKe/qZxA==
X-Google-Smtp-Source: ADUXVKKBFXPnKI5cf9aySI9uMB7PqndAk+m40f2S8sr9+54/l8i5kU6hLgOmfQ2Syc21gXjbiRTr8jgOaU9Vi8X3lRk=
X-Received: by 2002:aca:4ed6:: with SMTP id c205-v6mr271621oib.254.1528236870368;
 Tue, 05 Jun 2018 15:14:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2f8e:0:0:0:0:0 with HTTP; Tue, 5 Jun 2018 15:14:29 -0700 (PDT)
In-Reply-To: <CAPig+cTSrzmOtYPwPWLpGfDa5tt0SV6Aq8SmhYTTicK0ikst7Q@mail.gmail.com>
References: <20180605091350.14476-1-luke@diamand.org> <20180605091350.14476-2-luke@diamand.org>
 <CAPig+cQTTY8wc4d=4jV8GxHDOjF7xk1vjA62JS6s4Zr0uXiegg@mail.gmail.com>
 <CAE5ih7-1StB8RNrobO+hpG2QOSdoscUNfVP9+muZV0_b+m+XSw@mail.gmail.com> <CAPig+cTSrzmOtYPwPWLpGfDa5tt0SV6Aq8SmhYTTicK0ikst7Q@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 5 Jun 2018 23:14:29 +0100
Message-ID: <CAE5ih7-HMRJ3nFNuQCXmJEC4Ar4PZY=_4Q=4gDK+VTFRhMvCGA@mail.gmail.com>
Subject: Re: [PATCHv1 1/3] git-p4: raise exceptions from p4CmdList based on
 error from p4 server
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        vin ku <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 June 2018 at 20:41, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jun 5, 2018 at 6:56 AM Luke Diamand <luke@diamand.org> wrote:
>> On 5 June 2018 at 10:54, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > On Tue, Jun 5, 2018 at 5:14 AM Luke Diamand <luke@diamand.org> wrote:
>> >> +                    m = re.search('Too many rows scanned \(over (\d+)\)', data)
>> >> +                    if not m:
>> >> +                        m = re.search('Request too large \(over (\d+)\)', data)
>> >
>> > Does 'p4' localize these error messages?
>>
>> That's a good question.
>>
>> It turns out that Perforce open-sourced the P4 client in 2014 (I only
>> recently found this out) so we can actually look at the code now!
>>
>> Here's the code:
>>
>>     // ErrorId graveyard: retired/deprecated ErrorIds.
>
> Hmm, the "too many rows" error you're seeing is retired/deprecated(?).

There's some code elsewhere that suggests it's being kept alive:

    // Retired ErrorIds. We need to keep these so that clients
    // built with newer apis can commnunicate with older servers
    // still sending these.

    static ErrorId MaxResults; // DEPRECATED
    static ErrorId MaxScanRows; // DEPRECATED


>
>>     ErrorId MsgDb::MaxResults              = { ErrorOf( ES_DB, 32,
>> E_FAILED, EV_ADMIN, 1 ), "Request too large (over %maxResults%); see
>> 'p4 help maxresults'." } ;//NOTRANS
>>     ErrorId MsgDb::MaxScanRows             = { ErrorOf( ES_DB, 61,
>> E_FAILED, EV_ADMIN, 1 ), "Too many rows scanned (over %maxScanRows%);
>> see 'p4 help maxscanrows'." } ;//NOTRANS
>>
>> I don't think there's actually a way to make it return any language
>> other than English though. [...]
>> So I think probably the language is always English.
>
> The "NOTRANS" annotation on the error messages is reassuring.

I'll check it works OK on Windows; charset translation might cause a problem.
