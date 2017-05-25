Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A9920209
	for <e@80x24.org>; Thu, 25 May 2017 05:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032713AbdEYFef (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 01:34:35 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33029 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030766AbdEYFee (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 01:34:34 -0400
Received: by mail-pf0-f171.google.com with SMTP id e193so156758403pfh.0
        for <git@vger.kernel.org>; Wed, 24 May 2017 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9dXpgQu2huqdTc26VB6FeX/DT7pBwFzAzQ6QZ+MtC78=;
        b=mPkVDqZf2f1uHB7I0W22Ke+YOdlnBRyULJzeMTTMqI20wRmrzwr/QDNYIHWrsheVyo
         JAy9woOqpJbfC3a/wc8CwFjoXSoAJaSrjMjs/bXAM2yyEKepwrhmZwwGGPHiBPrvmLeG
         9BQJKnj6zwQCSotepSQHCA0OsLgWVU2Ba73saNL2AX6rK/muJ04YHnM7CB0fXijMdYRS
         g2A+ClxzDToVpu1OtkgArdj653IFgzhxkflj6+zPKx9PP0Ih3TpCArz0DGxmcQfllj74
         CftY7M7v3cWOOWa2v52Q7ceRgxKSA9YdKINMfTCBCuL1Vd8ovCY47VP5iJxDajkmKouP
         O6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9dXpgQu2huqdTc26VB6FeX/DT7pBwFzAzQ6QZ+MtC78=;
        b=RtYrjWrCgi/QIRPfulbxXC6Kf0ew4TxtOuTIautL45PcWShIzbTCYyOKKtQOhHtU25
         ADZlQue6UNK3cONn2hPLEp1ZsOO4l+2/lNAZCJKIUsibuG205BgS8AeNK50S1Xh9pXcb
         HefxZZjNlE+2847PJdPauI+1OcfSvaP1FuydgWZ5QDHoGLfTNjjMc1etqqIN3IRpse/0
         tKgUr8d5DFNMKc4oGiWN1Ryp0xk+ULxiYrV2GZo+ew4i9msarwn3nBrTMWc56qGWG1s0
         DcKMQp6seCoLf2aI1BzpNQyHu0aRHQMWPNMjCtIhqyr90rvp9vTmC6PStO0eLfpILwj5
         hGQA==
X-Gm-Message-State: AODbwcDXJ/DF26rXr715sxAGuqBLlPpNAzr5w+7uaN3PBpjwEA9ASHDM
        ALuJepDx1bMkevznNpNAzDeRM/RGMfW1Uwc=
X-Received: by 10.98.205.65 with SMTP id o62mr42289118pfg.105.1495690473858;
 Wed, 24 May 2017 22:34:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 24 May 2017 22:34:33 -0700 (PDT)
In-Reply-To: <xmqqo9uhfz8g.fsf@gitster.mtv.corp.google.com>
References: <20170523024048.16879-1-sbeller@google.com/> <20170524214036.29623-1-sbeller@google.com>
 <20170524214036.29623-17-sbeller@google.com> <xmqqo9uhfz8g.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 24 May 2017 22:34:33 -0700
Message-ID: <CAGZ79kZM5KPP7iDo7rT5gxsooRrftJrA=+3-WBXW3nqfXeTy4Q@mail.gmail.com>
Subject: Re: [PATCHv5 16/17] diff: buffer all output if asked to
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 7:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Introduce a new option 'use_buffer' in the struct diff_options which
>> controls whether all output is buffered up until all output is available.
>> ...
>> Unconditionally enable output via buffer in this patch as it yields
>> a great opportunity for testing, i.e. all the diff tests from the
>> test suite pass without having reordering issues (i.e. only parts
>> of the output got buffered, and we forgot to buffer other parts).
>> The test suite passes, which gives confidence that we converted all
>> functions to use emit_line for output.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Oh, did I?

Yes, this is essentially the v4 with small indentation fixes, so I
assumed your signoff is still valid.

Which leads to explaining my workflow (which I think we
discussed that half a year ago with Dscho in a longer thread).

As soon as you apply a series I take that series and work off
that series, because you explained you would do smaller
fixups occasionally.

Patches that change drastically, I strip off your signoff and
pretend like I created them from scratch, but for those which
I barely touch (if at all), I do not remove your signoff, as
I'd be just passing them along again.

Maybe I have to rethink that strategy.

>
>> ---
>>  diff.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++---------------
>>  diff.h |  41 +++++++++++++++++
>>  2 files changed, 161 insertions(+), 35 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index 514c5facd7..8e06206881 100644
>> --- a/diff.c
>> +++ b/diff.c
>> ...
>> @@ -2579,6 +2628,13 @@ static void builtin_diff(const char *name_a,
>>                       xecfg.ctxlen = strtoul(v, NULL, 10);
>>               if (o->word_diff)
>>                       init_diff_words_data(&ecbdata, o, one, two);
>> +             if (o->use_buffer) {
>> +                     struct diff_line e = diff_line_INIT;
>
> This ...
>
>> +                     e.state = DIFF_LINE_RELOAD_WS_RULE;
>> ...
>> +#define diff_line_INIT {NULL, NULL, NULL, 0, 0, 0}
>
> ... and this should be in all caps.   We do not say
>
>         struct strbuf buf = strbuf_INIT;
>
> and we should do the same for this new thing.

Yes. Totally agree. That is fallout from a mechanical
replace all s/buffered_patch_line/diff_line/ and the case
sensitivity got lost.

Will fix again.

Stefan
