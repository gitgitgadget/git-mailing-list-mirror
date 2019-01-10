Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 695821F803
	for <e@80x24.org>; Thu, 10 Jan 2019 21:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfAJVWD (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 16:22:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41211 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfAJVWD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 16:22:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so12983827wrs.8
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 13:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=I1HIgFJG8hhnRlvk8J6vm4bqe0HykwIGS8fTgB/yzlc=;
        b=WEibcgO0pacH9Bet2Ln/LVGEaiHLbWA/Jdhvb4eGNuqVkqeyhY34RWO+XT40+Dba/f
         jH/HAO3r8jLg32ttrg780kpx38sbW4Jf+dEH26QWzZYs9icmoNAgrUpUU7xKmcBysV2t
         MvuNUlUxKWD461oy6FN+cgk8CFpEpcZMTrYZDeAmBq7PaTEk15q4KagoGgQdUaKjES5B
         W+XnNUc+hDJDuFxxOlV3JXVNerkzCkZ04NKUyii0bQSaicYmWK+yuc2sKYESRnrq5rgK
         X0OsWJpKsuRMDmkKBqSPLVq8+IArpKAL2uJs0dBJbQwYyMB14BCaRRH7sbR21ixAyJFR
         0C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=I1HIgFJG8hhnRlvk8J6vm4bqe0HykwIGS8fTgB/yzlc=;
        b=DtewFYcwr32Sm9AglIQdfeXKZKya3gcZ3/u3WjctoRYlnnmDnoTigYI1hVnJKHVPHI
         b7kBDWJTnAeQhufentTEAaHu5Ig1mK1ctpHH4wLO+ilaGr6ha0yEd78GsEZWbry3LpEd
         weTaahpH4t58xUE+m5NdhQbOiamxijBbxwH+5Q+8t+7l6IURt5VUT4LgWoa/UNnTw9GI
         H+zc5T/1/mhxylkIjHtnEP9GKP0rUTkfUKIW/0nKQHoHF35VmgKspcdqidIkPuNZxTtg
         kHggnCNgdoyVv7p+7kGNxc1ZWLnUabkhDCi55RF/BFbp2tXphTmGCbNUNVpAX7lgJOnU
         Q7OQ==
X-Gm-Message-State: AJcUukciXVL8NSBqxzbTOfGK08xZihMyI3uL3f9O8MfdF5APNauZQxD4
        s1XqzKKdwEea5bsbmotByEg=
X-Google-Smtp-Source: ALg8bN7YxAabsj0nag+rWaKgVgU868g0FIVAlnIzbPz+lKL6zhrZEvZ+pkLcTlqNnElzXw8LR7aa/w==
X-Received: by 2002:adf:f903:: with SMTP id b3mr11361841wrr.82.1547155321492;
        Thu, 10 Jan 2019 13:22:01 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w80sm23478694wme.38.2019.01.10.13.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 13:22:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] compat/obstack: fix -Wcast-function-type warnings
References: <20181220162452.17732-1-szeder.dev@gmail.com>
        <20181220162452.17732-2-szeder.dev@gmail.com>
        <87zhszeqsr.fsf@evledraar.gmail.com>
Date:   Thu, 10 Jan 2019 13:22:00 -0800
In-Reply-To: <87zhszeqsr.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 21 Dec 2018 00:12:20 +0100")
Message-ID: <xmqqef9k1a4n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Dec 20 2018, SZEDER Gábor wrote:
>
>> When building Git with GCC 8.2.0 (at least from Homebrew on macOS,
>> DEVELOPER flags enabled) one is greeted with a screenful of compiler
>> errors:
>>
>>   compat/obstack.c: In function '_obstack_begin':
>>   compat/obstack.c:162:17: error: cast between incompatible function types from 'void * (*)(long int)' to 'struct _obstack_chunk * (*)(void *, long int)' [-Werror=cast-function-type]
>>      h->chunkfun = (struct _obstack_chunk * (*)(void *, long)) chunkfun;
>>                    ^
>>   compat/obstack.c:163:16: error: cast between incompatible function types from 'void (*)(void *)' to 'void (*)(void *, struct _obstack_chunk *)' [-Werror=cast-function-type]
>>      h->freefun = (void (*) (void *, struct _obstack_chunk *)) freefun;
>>                   ^
>>   compat/obstack.c:116:8: error: cast between incompatible function types from 'struct _obstack_chunk * (*)(void *, long int)' to 'struct _obstack_chunk * (*)(long int)' [-Werror=cast-function-type]
>>       : (*(struct _obstack_chunk *(*) (long)) (h)->chunkfun) ((size)))
>>           ^
>>   compat/obstack.c:168:22: note: in expansion of macro 'CALL_CHUNKFUN'
>>      chunk = h->chunk = CALL_CHUNKFUN (h, h -> chunk_size);
>>                         ^~~~~~~~~~~~~
>>   <snip>
>
> We originally got this from now-discontinued eglibc, but I notice that
> glibc.git's malloc/obstack.[ch]'s diff also changes these lines. If you
> backport those do does that fix this warning?
>
> I.e. is this another case where we're blindly fixing bugs but should
> just re-import upstream's code instead?

Good point.  I am inclined to queue the remainder of the series
without this one for now.

Thanks.

