Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E7941FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 23:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbdFMXl7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 19:41:59 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34322 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbdFMXl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 19:41:58 -0400
Received: by mail-pg0-f51.google.com with SMTP id v18so67032018pgb.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 16:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AAjjm5PfNUPXTRf64G1AWLJ2KQuSXbUv2pUgCQNJils=;
        b=YUNocqXZfi54wvrYjrIU9r4yJNwg6g05/PiUTxM3m1q0Ug9gYFSqZliqAKPVXSmf0Q
         WXaU9s5BbHaLZF985szeZOVY7P42F9Fbipjrgl5GxTWcxt2z9lscV1XOHqRF6JvRwuTv
         /pka3MOuvQbUpv1rTY2igYOMiIBFnRP7hLLbhvlhLmJ5TXF7pWItmuxP01LGW2jNfRv7
         J70kITVT+DWBG3UaQMw/6ML7tqgOobgHz4Hm0yv/kQqcV5B4FirWLmpJlvIIGhutU62E
         EqC+jJLZaljTV+pzXKz0zwXxNWJe5hvO4K/UWO4HKGnwjbTVsKdNlJat+beb84YVPlug
         OFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AAjjm5PfNUPXTRf64G1AWLJ2KQuSXbUv2pUgCQNJils=;
        b=sQCEiv8Nay6ut3JuZMV2va+aHaF4ZIrQ/G1QP9Q0uwOxLUNXAJIbcUW97EH/sQt6Ot
         vY27GRxi5uzG0sBG7DVZY1qyM3FfK8UsFCeqc3uHLUBXQih2eKf1W6faHcAdOukxCFoI
         yvxw/c4W8XhAsBk3F03qGL5EprxndkHaCqHHV3JyjFbrZl+jdNijpBB3Yl6pLHbldhHX
         InBBknJAyOgtjOqwDHttVe0of3U+ojwlO2wytpqSbH5UHyJtuiGOCE6D7SYXbjf+K4aT
         ynXQoSqqAvcJgMNvGg7dwZLw3J/EI7uFGQ/IKa8AJ0Ywj2QW/XQ4p4NjA2DPqERL2Okd
         RsLw==
X-Gm-Message-State: AKS2vOx2rwnKN7Y96HOSXZt+Zbt72A6lFRrpOfts2EvBPhWNJNE6vafN
        uL44cWWZwXR0Nuz0nw5NPwcrAYXfCbvv
X-Received: by 10.98.68.156 with SMTP id m28mr1528188pfi.48.1497397317817;
 Tue, 13 Jun 2017 16:41:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 13 Jun 2017 16:41:57 -0700 (PDT)
In-Reply-To: <20170613145457.2e888c27@twelve2.svl.corp.google.com>
References: <20170523024048.16879-1-sbeller@google.com/> <20170524214036.29623-1-sbeller@google.com>
 <20170524214036.29623-5-sbeller@google.com> <20170613145457.2e888c27@twelve2.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Jun 2017 16:41:57 -0700
Message-ID: <CAGZ79kY9ByaHe_fx+S3neT6+1LcA_Q13bbVha8AKHUUO32FgeA@mail.gmail.com>
Subject: Re: [PATCHv5 04/17] diff: introduce more flexible emit function
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 2:54 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Wed, 24 May 2017 14:40:23 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> Currently, diff output is written either through the emit_line_0
>> function or through the FILE * in struct diff_options directly. To
>> make it easier to teach diff to buffer its output (which will be done
>> in a subsequent commit), introduce a more flexible emit_line() function.
>> In this commit, direct usages of emit_line_0() are replaced with
>> emit_line(); subsequent commits will also replace usages of the
>> FILE * with emit().
>
> Check the names of the functions in this paragraph.

Only the very last word needed replacement of /s/emit/emit_line/.

>
>> diff --git a/diff.c b/diff.c
>> index 2f9722b382..3569857818 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -516,36 +516,30 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
>>       ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
>>  }
>>
>> -static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
>> -                     int first, const char *line, int len)
>> +static void emit_line(struct diff_options *o, const char *set, const char *reset,
>> +                   int add_line_prefix, int sign, const char *line, int len)
>
> In the future, this function is going to be used even to emit partial
> lines

Yes.

> - could this be called emit() instead?

Despite having good IDEs available some (including me)
very much like working with raw text, and then having a function
named as a common string doesn't help.

After this patch

  $ git grep emit_line |wc -l
  16
  # not all are this function, there is
  emit_line_checked as well. But 16 is not too much.

But if renamed to emit():

  $ git grep emit -- diff.c |wc -l
  60

You could argue I'd just have to grep
for "emit (" instead, but that then I would have
rely on correct whitespacing or use a regex already.
Complexity which I would not like.

So I am not sure if this is helping a reader. (Not the casual
reader, but the one grepping for this function)

Maybe we can settle on a different name though,
such as emit_string which is not a prefix of a dozen
different other functions?

Thanks,
Stefan
