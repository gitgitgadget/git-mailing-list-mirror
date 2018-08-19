Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05CEA1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 21:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeHTAu7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 20:50:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35066 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeHTAu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 20:50:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id e6-v6so7331426edr.2
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 14:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5HwcugSQTlx+3TcSJhU/xbjE0i09lEfvxqbvAkB1QYQ=;
        b=Bbd+JDsaGg7fsmzdNbj+pwYTw9zu4Rv+HziJxMLPTMq53d+YK1sNQNZ+m8duJCWxZp
         uaFjWaAUPEyoEevhBCdiFRdbf93pnI7sbEdFJs/jIy+Y+Qlbak7PrBNES3havqVFVCbs
         dM1OAK/6RNv73ctTZAPpYgODfJH/hPuLXUE408ovuZwMg3s9S0FmGuvRebT3LFHxWgpa
         UUqYyL8+M5j3n9JMaHqUFtN47sr3jjbiuZOFpgllGi9f31aYvggvrS9XQmzGsnPCUpNz
         IkQ9P5NCdu4SmrS+yJ0idHYjgvmIIyWUmwneuLTOaILsThgAEL/8Z7+qMfogXN426BMJ
         zrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5HwcugSQTlx+3TcSJhU/xbjE0i09lEfvxqbvAkB1QYQ=;
        b=YlpUkQhtXyyoCcFlX9u1m+ZWJzhCi/jBiuEE35+5UX9yAq2KBG4jU4rNpcxhiyAikX
         3YtTP9qDVbnwXIvTxTVeIO17pEW1dVjoEEo9TbnzNRQuXAPvibuRkQCtEhqNxh4DnsgP
         zBbj4dNnraZ59loM2Fa67+szpnDej3qrvyxUikvUNYsuTkYR9JwTW43sSqAkWALT3g9J
         oHLiVyqmIz1fi8XYxs73SSGN6/9NcwfWST5iIsD3+zFboPUA0x44aYLcOyivsqwkItxE
         9NJPiB+jwzqRmTfT276t0uNRk+98jeyb7GIYE5S/mn/iBncXkZfZULpc9gz0vbmAfxF/
         MVng==
X-Gm-Message-State: AOUpUlHAJVoAiKqX2kdON/KPKk+UPfB8ZfiWEayxpszwz2Op4/UZO/AP
        NGSQKOAoSJa9oNe3YNchdis=
X-Google-Smtp-Source: AA+uWPwXWnpBdDbpgOQJCpCuZCA2l8pNoN1AqzRJnIa3Z29QUACi9m9ffsS6K1QLGctIjytxVYsoBQ==
X-Received: by 2002:a50:a0a6:: with SMTP id 35-v6mr53310411edo.280.1534714683477;
        Sun, 19 Aug 2018 14:38:03 -0700 (PDT)
Received: from [10.9.11.6] ([46.246.123.46])
        by smtp.gmail.com with ESMTPSA id r5-v6sm3981929edo.75.2018.08.19.14.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 14:38:02 -0700 (PDT)
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can
 use bitmap' test
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>
References: <20180814114721.25577-1-szeder.dev@gmail.com>
 <4d6ffc81-a1e8-a60f-d53f-2ec159160fcd@gmail.com>
 <xmqqr2iyc526.fsf@gitster-ct.c.googlers.com>
 <CAM0VKjkT7fBJRie_3f4B13BHT9hp9MxRhuX5r1sogh2x7KQzbg@mail.gmail.com>
 <eeb04c94-50c1-13ee-880b-ea380031a685@gmail.com>
 <xmqq4lfsbvru.fsf@gitster-ct.c.googlers.com>
 <73346b91-6d19-651a-c361-1666a39681f0@gmail.com>
 <20180819203253.GA5789@sigill.intra.peff.net>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <aedb7f33-65cc-5d63-4e7e-dd5f37831e19@gmail.com>
Date:   Sun, 19 Aug 2018 23:37:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180819203253.GA5789@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/08/18 22:32, Jeff King wrote:
> On Sun, Aug 19, 2018 at 07:50:42PM +0200, Andrei Rybak wrote:
> 
>>   1. Check both files at the same time (combination with Gábor's
>>      function):
>>
>> 	test_cmp () {
>> 		if test "$1" != - &&
>> 		   test "$2" != - &&
>> 		   ! test -s "$1" && 
>> 		   ! test -s "$2"
>> 		then
>> 			error "bug in test script: using test_cmp to check empty file; use test_must_be_empty instead"
>> 		fi
>> 		test_cmp_allow_empty "$@"
>> 	}
>>
>>      This will still be reporting to the developer clearly, but
>>      will only catch cases exactly like the bogus test in t5310.
> 
> Doesn't that have the opposite issue? If we expect non-empty output but
> the command produces empty output, we'd say "bug in the test script".
> But that is not true at all; it's a failed test.

No. Only when both "$1" and "$2" are empty files will the function above
report "bug in test script". From patch's commit message:

  ... both invocations produce empty 'pack{a,b}.objects' files, and the
  subsequent 'test_cmp' happily finds those two empty files identical.

That's what I meant by "will only catch cases exactly like the bogus
test in t5310".

However ...

> If we assume that "expect" is first (which is our convention but not
> necessarily guaranteed), then I think the best logic is something like:
> 
>   if $1 is empty; then
>     bug in the test script
>   elif test_cmp_allow_empty "$@"
>     test failure
> 
> We do not need to check $2 at all. An empty one is either irrelevant (if
> the expectation is empty), or a test failure (because it would not match
> the non-empty $1).

... this is indeed a better solution. I written out the cases for
updated test_cmp to straighten out my thinking:

 * both $1 and $2 are empty:
     bogus test:
       needs either fixing generation of both expect and actual
       or switching to test_must_be_empty
   OR
     bogus helper function, as Gábor described above:
       needs to switch to test_cmp_allow_empty
 
 * $1 is non-empty && $2 is empty
   proceeding with test
   test failure from GIT_TEST_CMP
 
 * $1 is empty && $2 is non-empty
   bogus test - needs either switching to test_must_be_empty
   (and after that test_must_be_empty will report failure)
   or fixing generation of expect (and after that test result
   depends on contents).
 
 * both $1 and $2 are non-empty
   proceeding with test
   result depends on contents
