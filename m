Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCEBB20D0C
	for <e@80x24.org>; Wed, 21 Jun 2017 19:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbdFUTqM (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 15:46:12 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35091 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdFUTqL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 15:46:11 -0400
Received: by mail-pg0-f48.google.com with SMTP id 132so47599030pgb.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5CvdcNY2YXkSgxcFT4V6pTZwvWyx+j665b765B7yDBQ=;
        b=MLjho+vvBDVg1O4Pe/mQOrhH0mCKDsTmwaVwfZ5r8nr0Y3tfjLMYUEYlhlKgV5f9LY
         hITzVHD1ecVEetoZhnpPt/7Bg0+/MnidQLii06yCjXhVlqL3BhxdmTOE+gwXjEPI44Fd
         /HjUHS9ZHINn5jlYxhGTGg8+SfrzFcw4eBadMXU2ZqYD8jhKdJKx8reymfBkQEnJThgH
         2V2gwZjwdFITW32vmkTkMNL99SnWen3n1NC5fvZkrwgqp4o0wtWRLODFf2j18hQf7eep
         CeNFfBWiqhmKkfNo+c/12Uw7C3XXdy0TpWxzO/WDhcnGj5bKrlN82hfSaVi58Svo4DRz
         6iWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5CvdcNY2YXkSgxcFT4V6pTZwvWyx+j665b765B7yDBQ=;
        b=DrqTFGcsB9yDc8fyksCd5i6mYYbkM8d+1+AKqQmPuSt5ONKvORSx23AC6+WlIwOJ6R
         MEv3QNxBtExDgpLWj0t/qQpfuZHpLpSgIp8beab5a1O4gskjMPIsOSzQoPYE15kg2TTB
         +Ivb34u9QCF0NiyB/fKYtQXLdd6Wo5vuHBnaEyMrMnk0J5ycJrFnFIkguBUxs8NgNMtq
         4ha9D+jTmU15er6niLqGzUdiORBKolJJEaWeLHcTDGrMeLgwWnD57rCb8rtPfu4gKCPJ
         MYEURDRBtOvGpIwzyG8iUZBnjc9290s9XPmpfeEOX0ZkhMOMXntbQ8++3qFYdn7aUMEE
         DJhQ==
X-Gm-Message-State: AKS2vOyGQtujhMhDrzWmtgXixWF1eLE6qi8mGHCC3xW9JIoTugOveCkP
        /or+RwnBZv+zN+XkgGKZ5u1udoldj99D
X-Received: by 10.84.217.138 with SMTP id p10mr38445521pli.66.1498074370341;
 Wed, 21 Jun 2017 12:46:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Wed, 21 Jun 2017 12:46:09 -0700 (PDT)
In-Reply-To: <xmqq7f05p1z7.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com> <20170620024816.20021-5-sbeller@google.com>
 <xmqq7f05p1z7.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Jun 2017 12:46:09 -0700
Message-ID: <CAGZ79kYUpJxX-wBU=ALPgJwVaA8h_iJRtAu3T7p4J7qmy=U4dg@mail.gmail.com>
Subject: Re: [PATCH 04/26] diff.c: introduce emit_diff_symbol
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 12:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  diff.c | 22 +++++++++++++++++++---
>>  1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index 2f9722b382..89466018e5 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -559,6 +559,24 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
>>       emit_line_0(o, set, reset, line[0], line+1, len-1);
>>  }
>>
>> +enum diff_symbol {
>> +     DIFF_SYMBOL_SEPARATOR,
>
> Drop the last comma from enum?

I looked through out code base and for enums this is
actually strictly enforced, so I guess I have to play
by the rules here as I do not want to be the first
to deviate from an upheld standard.

This will be painful though as the next ~20 patches
add more symbols mostly at the end, maybe I need
to restructure that such that the last symbol stays the same
throughout the series. Thanks for that thought.

>
>> +static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
>> +                          const char *line, int len)
>> +{
>> +     switch (s) {
>> +     case DIFF_SYMBOL_SEPARATOR:
>> +             fprintf(o->file, "%s%c",
>> +                     diff_line_prefix(o),
>> +                     o->line_termination);
>> +             break;
>
> As the first patch in the "diff-symbol" subseries of this topic,
> this change must seriously be justified.  Why is it so important
> that a printing of an empty line must be moved to a helper function,
> which later will gain ability to show other kind of lines?

Ah yes. This got lost in comparison to the currently queued series with
diff_lines. The justification for the change was in the buffer patch,
but now we need to have the justification here.

In the old series, I had copied the same text in all these
refactoring patches, but thought to delete them in this series. The first
refactoring patch makes sense though.

Thanks,
Stefan
