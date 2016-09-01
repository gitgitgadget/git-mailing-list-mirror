Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8861FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 08:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbcIAITg (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 04:19:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34997 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbcIAITc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 04:19:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id c133so2581023wmd.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qy6VXYH2iD/pqsfAlrxpR2KFd3dw2zgqVNa0OIfjXBM=;
        b=ezTHR3sVBSZ1cZlRYFJm/TnvbjW0NEfNtPgnraB2gIohqMmDI1hhVft+1Bl4Mnaa0o
         7jkBCZFzN0CRLnO2rFeg5ssJ7tjO3ZUdIjRZ+k8ANqomrJ4dzJOv4vuL2r7Ehc5Flhp7
         sc5MC/NoUDX7ogkxpUKizhrm48sZL5nVuT6ON8aTKdruZN4pqbhUM/8dFjJMb7mu2h2v
         Cf+N9C5Z8b/+tG9SlHePshNP7yr0b2ji89szW76PGgK88kD/qtUBo21pN/6a9cFMeEPF
         vEiJV6E346jET5C0csw3eSKCrv6y7qvMh6CayWrbuQYVJs8CoQMQlA+YomooBeSLpT/v
         RwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qy6VXYH2iD/pqsfAlrxpR2KFd3dw2zgqVNa0OIfjXBM=;
        b=kE9zUlJkuYxFnlzQoLphona6OfihsQoh4KSGHM9iCD+Y3jweSFC0dKYhRlo/prDaUQ
         cek8aI5gcKR2nhr9jz8mGqFKSSnRGAvL673YmtML7AO39syDlp+wYjaqU/n+X1b/1fbZ
         1R6GnXhVfeysfKjZcMC6/yhHzUyiDoKRRNr577Xn8q3RcgEMYZR691BgHepGncgNPLZa
         BtWEFcjIglxHe9WAGwS2eaxkgQcjC2EZBz/LE0NXoNshn6qrYtqJWJkuSozwkETvPaA9
         2PYuij/JYMy5kpN+UOpTDYjINOzp6ku2EEwO9Do5mt/FNLEdIFBMI2f93291z8iPtzqW
         74cw==
X-Gm-Message-State: AE9vXwMVj54AWRvQ3Oaff2Il9KAKOkV2v/UUGq0FgkIbqvvQi3RF0ZPy9IhEPO2S52Wnq5xHICkwj+mwgfeqtw==
X-Received: by 10.194.89.73 with SMTP id bm9mr14180442wjb.76.1472717971360;
 Thu, 01 Sep 2016 01:19:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.222.132 with HTTP; Thu, 1 Sep 2016 01:19:30 -0700 (PDT)
In-Reply-To: <CAGZ79kbdoF-1=ZBZG8y3sEz6LVaNP4Ou+KVk+=M7y9PSzQ1J0Q@mail.gmail.com>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
 <20160827184547.4365-11-chriscool@tuxfamily.org> <CAGZ79kbdoF-1=ZBZG8y3sEz6LVaNP4Ou+KVk+=M7y9PSzQ1J0Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 1 Sep 2016 10:19:30 +0200
Message-ID: <CAP8UFD2Lwd_1+cWT702deF8=iFmBRKCi9gLSOizPbyLmeKepsw@mail.gmail.com>
Subject: Re: [PATCH v13 10/14] apply: change error_routine when silent
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 1, 2016 at 12:20 AM, Stefan Beller <sbeller@google.com> wrote:
> On Sat, Aug 27, 2016 at 11:45 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> To avoid printing anything when applying with
>> `state->apply_verbosity == verbosity_silent`, let's save the
>> existing warn and error routines before applying, and let's
>> replace them with a routine that does nothing.
>>
>> Then after applying, let's restore the saved routines.
>>
>> Helped-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  apply.c | 21 ++++++++++++++++++++-
>>  apply.h |  8 ++++++++
>>  2 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/apply.c b/apply.c
>> index ddbb0a2..bf81b70 100644
>> --- a/apply.c
>> +++ b/apply.c
>> @@ -112,6 +112,11 @@ void clear_apply_state(struct apply_state *state)
>>         /* &state->fn_table is cleared at the end of apply_patch() */
>>  }
>>
>> +static void mute_routine(const char *bla, va_list params)
>
> Instead of 'bla' you could go with 'format' as the man page for
> [f]printf puts it.
> Or you could leave it empty, i.e.
>
>     static void mute_routine(const char *, va_list)
>     ...

Ok to do that.

> I personally do not mind bla, as I know that the first parameter is
> supposed to be the format, but let's not add unneeded information.
> (Side question: Is there a culture that doesn't recognize 'bla' as a
> fill word?)
>
>> @@ -4864,7 +4876,7 @@ int apply_all_patches(struct apply_state *state,
>>                 state->newfd = -1;
>>         }
>>
>> -       return !!errs;
>> +       res = !!errs;
>
> I am trying to understand this and the next chunk (they work together?)

Yes, they work together.

>>  end:
>>         if (state->newfd >= 0) {
>> @@ -4872,5 +4884,12 @@ int apply_all_patches(struct apply_state *state,
>>                 state->newfd = -1;
>>         }
>>
>> +       if (state->apply_verbosity <= verbosity_silent) {
>> +               set_error_routine(state->saved_error_routine);
>> +               set_warn_routine(state->saved_warn_routine);
>> +       }
>> +
>> +       if (res > -1)
>> +               return res;
>>         return (res == -1 ? 1 : 128);
>
> So anything > -1 is returned as is, and == -1 returns 1 and <-1  returns 128 ?
>
> So I guess a reminder/explanation on why we need to fiddle with return codes
> in the commit message would help. (I do not understand how the
> verbosity influences return codes.)

It doesn't influence return codes, but we need to restore error
routines just before returning, so we cannot return early anymore.
I will add something to the commit message.
