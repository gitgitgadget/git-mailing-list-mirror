Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B8251F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbeKEPa4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 10:30:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41873 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbeKEPa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 10:30:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so8050259wrw.8
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 22:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8mwX5fuojZT/mi32aOWjEvsILQUr6Ub+AUHJbyINAik=;
        b=rjw1m3ohM7GDuasl1J/KSsgrkR0A59ysjFY1YD/5ntXG+/cx/Tg3mHcfw3doYPH2A/
         vD9EKQdkc1mZt47UQ2LNM3qsshuUf2PfkNogTEF28q6+FeOnWLn0ZKh9FVT7Al8xKvTC
         xqsyjoA9Gg1ybHRZ8LrS1wBTdjH7UEelAQqh9LEzjRjUnXc6Pg/8a944H0FrYDeqOcHb
         RGg1X9K2LQ2LueMMCUQyqOtPPR7gZiFM93rqfN/RuAwsOKTbTbpsuMHthdAoIQxZqYYP
         LC6GqPz18p81PJm/DgvRkqDGgmenlbkDXSQdQSVT9fSv0oYPknEq9zM33vgnsu1WjQze
         zB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8mwX5fuojZT/mi32aOWjEvsILQUr6Ub+AUHJbyINAik=;
        b=YXuIX4a2fuLBg84dRhMemLbjev2KxQFBzK0sth4VS409f0j6gHC/m9364dhmW8T2wb
         9JkkH3U9Rui1HQWmflF595Knjah/85U5340UqYMGwXghKwgWZAOHILX+DQEXkvMjSSzU
         AwEcLKT/9LJA1cX91J5qeA8ap9EC6oxJenOfTw1WLi7QLn5WB94F5YR1CS90Wh+/EU4e
         YVafmk1/ifli20UcU7fyuuKnSMhz+39pbB4DzjTbwTN8gdpq05bgJDFNrpj6j4e6ElxI
         fJ+hE3IHzJoPsQnKCpcG62KoGKmEqe2n9OFB409t0rqrTN+Dazg3dWc9HpKvmQ15nQZV
         lsMg==
X-Gm-Message-State: AGRZ1gKOJD1Kq4GQawrruUtO5BW9qRcMNHgIiyeYF0ytikwnQfsvxl0p
        m4oxwyQf3BNLnwBSlGgE7lk=
X-Google-Smtp-Source: AJdET5fmpLttDKaaaLRSt1RM+Lz9O6T+lD9KYMg0BgcKUovm2E8YM3cO1h9L+AA5WS8PByNmgCZcow==
X-Received: by 2002:adf:b109:: with SMTP id l9-v6mr17273961wra.290.1541398373110;
        Sun, 04 Nov 2018 22:12:53 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v189-v6sm25213194wmd.40.2018.11.04.22.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 22:12:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: differentiate error handling in parse_color_moved_ws
References: <20181102212316.208433-1-sbeller@google.com>
        <xmqqzhurlzv2.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 05 Nov 2018 15:12:49 +0900
In-Reply-To: <xmqqzhurlzv2.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 03 Nov 2018 10:21:53 +0900")
Message-ID: <xmqqk1lshx26.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>>  
>> -static int parse_color_moved_ws(const char *arg)
>> +static unsigned parse_color_moved_ws(const char *arg)
>>  {
>>  	int ret = 0;
>>  	struct string_list l = STRING_LIST_INIT_DUP;
>> @@ -312,15 +312,19 @@ static int parse_color_moved_ws(const char *arg)
>>  			ret |= XDF_IGNORE_WHITESPACE;
>>  		else if (!strcmp(sb.buf, "allow-indentation-change"))
>>  			ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
>> -		else
>> +		else {
>> +			ret |= COLOR_MOVED_WS_ERROR;
>>  			error(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
>> +		}
>> ...  
>>  	} else if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
>> -		options->color_moved_ws_handling = parse_color_moved_ws(arg);
>> +		unsigned cm = parse_color_moved_ws(arg);
>> +		if (cm & COLOR_MOVED_WS_ERROR)
>> +			die("bad --color-moved-ws argument: %s", arg);
>> +		options->color_moved_ws_handling = cm;
>
> Excellent.
>
> Will queue.  Perhaps a test or two can follow to ensure a bad value
> from config does not kill while a command line does?

Wait.  This does not fix

	git -c diff.colormovedws=nonsense diff

that dies with an error message---it should ignore the config and at
moat issue a warning.

The command line handling of

	git diff --color-moved-ws=nonsense

does correctly die, but it first says "error: ignoring" before
saying "fatal: bad argument", which is suboptimal.

So, not so excellent (yet) X-<.

