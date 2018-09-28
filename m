Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73C4A1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 18:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeI2A7s (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 20:59:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55791 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeI2A7r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 20:59:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id 206-v6so3155781wmb.5
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=31+ZE8xJRJAMtqEa/bmvBksMJ0MNCOR5T+4RfqH2lFg=;
        b=T2mvG5tyrJerHRbmqzCXzbM2cg7d3KPZ/2EBch66WxN8Hw2DP5NPqP09Dh8OJhasnU
         FE4pW/rtF4+ugTZu38QBYndXP/gEMpO4adkE5wfoSQgMOC8cS+fx9cJY9SYpXeQOsv0f
         EfhTfkKoFxNIAs84AA8URNKycL/h+QVQWf/fdglULojwXJVcoYNx9zpbS5btZSV3M5bz
         lVosQ/b929ggLiVZg/rAjAM12H/FfGdA1Omitjh8kt7ecA43rpJtIdAGWbDfHMw/FqiM
         3vzG7QDvhn04/SqRP+YDjrEuJgAyxL+MnCL9yMbMHZCd5XLvd2ClLD24r3J6/PDCBIju
         bo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=31+ZE8xJRJAMtqEa/bmvBksMJ0MNCOR5T+4RfqH2lFg=;
        b=fzg3qvUH6O1YHNRqnpY+Ajg0wQQrBiwjDP2y1Ff0DEUjv6cL5BOHk2+3eSFmmxUeX/
         lvTKA9yCj+Rt6/jvDhZDtPIz1rjy4sUDzECHY4Ri5U+UyjFEp0kwYFHMAsGf07cQ7yyg
         Hs6LGsFk5C80Iv4Tn6cxg3yBgzM8/Cc43uyS2A3LTJEKdKeSsqdMvhh3cYh0AJ/u4Gv+
         mlZqgnKahiLbCUDlgVpwjsb8VPMgebTZx7YBHMmyxOB2D147Y51ll/HNy2QK26zka8n9
         /cauprXy2u3JmPh/Nn6v+4Y5ZoQMRYs9mjfH2cGesOY3Kk7E5v1qwkfRukmww/zhTu82
         goJg==
X-Gm-Message-State: ABuFfoiRlFi9gG2Z5CIQhVDy7tNvKI33WjlTl3HssNX+Bfd1UFdaXnqG
        IJ9icJWiQ4vMFynKP35VPC4=
X-Google-Smtp-Source: ACcGV60H4vz8H53o0KN4qH93YkhZydNjuvlgOIJKwtgp/RdaED8qwx4TmeVF8dOHmsdzrIicoDHjnw==
X-Received: by 2002:a1c:aed1:: with SMTP id x200-v6mr2592065wme.86.1538159683108;
        Fri, 28 Sep 2018 11:34:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t66-v6sm3432542wmt.5.2018.09.28.11.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 11:34:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "Stephen P. Smith" <ischis2@cox.net>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/1] roll wt_status_state into wt_status and populate in the collect phase
References: <xmqqr2i5ueg4.fsf@gitster-ct.c.googlers.com>
        <20180928044936.2919-1-ischis2@cox.net>
        <20180928044936.2919-2-ischis2@cox.net> <20180928135549.GA23652@syl>
Date:   Fri, 28 Sep 2018 11:34:41 -0700
In-Reply-To: <20180928135549.GA23652@syl> (Taylor Blau's message of "Fri, 28
        Sep 2018 06:55:49 -0700")
Message-ID: <xmqq4le9cvy6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Sep 27, 2018 at 09:49:36PM -0700, Stephen P. Smith wrote:
>> When updating the collect and print functions, it was found that
>> status variables were initialized in the collect phase and some
>> variables were later freed in the print functions.
>
> Nit: I think that in the past Eric Sunshine has recommended that I use
> active voice in patches, but "it was found" is passive.

Yeah, and when/how it was found is much less interesting backstory
than _why_ we are doing this follow-thru.  I think the first line
can just simply go without losing clarity.

>> Move the status state structure variables into the status state
>> structure and populate them in the collect functions.

On the other hand this one may deserve a bit more backstory.  If I
understand correctly, what happened over time was

 - A "struct wt_status" used to be sufficient for the output phase
   to work.  It was designed to be filled in the collect phase and
   consumed in the output phase, but over time some fields are added
   and output phase started filling it; we recently corrected it so
   that .committable field is filled in the collect phase.

   A "struct wt_status_state" that was used in other codepaths
   turned out to be useful in showing the "git status" output, so
   some output phase functions started taking it.  This is not tied
   to "struct wt_status", so the discipline of filling in the
   collect phase to be consumed in the output phase was never
   followed.

I am not suggesting to write that much in the log message, but and
with a backstory like that, embedding a wt_status_state inside
wt_status and fill it in the collect phase, which this patch does,
starts to make sense, I would think.

>> diff --git a/wt-status.c b/wt-status.c
>> index c7f76d4758..9977f0cdf2 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -744,21 +744,26 @@ static int has_unmerged(struct wt_status *s)
>>
>>  void wt_status_collect(struct wt_status *s)
>>  {
>> -	struct wt_status_state state;
>>  	wt_status_collect_changes_worktree(s);
>> -
>
> Nit: unnecessary diff, but I certainly don't think that this is worth a
> re-roll on its own.

I do not think it is unnecessary to remove the blank between three
things this function does (i.e. (1) inspect working tree, (2)
inspect index and (3) inspect untrackeed; if there is no blank line
between (2) and (3), we shouldn't have a blank between (1) and (2)).

I do agree with you it is an unrelated change.  Its correctness (not
to the compiler, but to the humans due to the above) is so trivial
that it probably is a good taste to include it in this patch.

>>  	if (s->is_initial)
>>  		wt_status_collect_changes_initial(s);
>>  	else
>>  		wt_status_collect_changes_index(s);
>>  	wt_status_collect_untracked(s);
>>
>> -	memset(&state, 0, sizeof(state));
>> -	wt_status_get_state(&state, s->branch && !strcmp(s->branch, "HEAD"));
>> -	if (state.merge_in_progress && !has_unmerged(s))
>> +	wt_status_get_state(&s->state, s->branch && !strcmp(s->branch, "HEAD"));
>> +	if (s->state.merge_in_progress && !has_unmerged(s))
>>  		s->committable = 1;
>
> Should this line be de-dented to match the above?

I am not sure if I follow.

Thanks.
