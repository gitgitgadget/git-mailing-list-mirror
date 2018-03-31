Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF21A1F404
	for <e@80x24.org>; Sat, 31 Mar 2018 17:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeCaRNp (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 13:13:45 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35088 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbeCaRNo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 13:13:44 -0400
Received: by mail-wm0-f47.google.com with SMTP id r82so21087300wme.0
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:subject:references:user-agent:in-reply-to:from:date
         :message-id:mime-version:content-transfer-encoding;
        bh=M0yd3z2yY5AxWbA9EXak142g1G8lstZ7IlZzKhOhEqY=;
        b=ECLxz/OomKu0qouBJ7J4qWW6euA+Q3246cj1EStmMA2UTgHH3S0NY7MRnwOtpcKD/0
         b3E5VWVCovVqAIMpvi5AQhfweau8f1r85EqKX4A6WD042zE7x/whBwUotRmotBqWfshL
         AHTS/iQjxyW3KAGXc5nLECs6kXgq3HQt+q0Bq+VKpsUue1XqnUfdlFxBq5jS5ST7ZfX2
         IpdO4ezyFm/cOHNg/07qTGaem2gB6yEKw2+jLTEc1NCfysy2b1wnkP81gkzqXp7bPOuP
         Dp3ahZ0zyW93C0P5zPfT23S8+ufKN7eEtE7JpreobJBaHOaimQ19zy2jVC4IRUgzIyNg
         8jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:subject:references:user-agent:in-reply-to
         :from:date:message-id:mime-version:content-transfer-encoding;
        bh=M0yd3z2yY5AxWbA9EXak142g1G8lstZ7IlZzKhOhEqY=;
        b=d12tUSD8+VdD1VO5ixfpCsXlgpc32UUESqvN/nX5+9gx6JZe0vY/IjDKz0bf6xxHus
         jeYjl6nRbb6Wmp7ptTgHi38FN0utHfdsiHIS/R6Tw2DJi/dpyNxxvMewDm6QdeymIP4H
         yjRCCURmRS3KpZqDNc2mwrTib0r0zCPYqFSkKzajn9Wto9gKFKAf6OJqZx858/Y1TBp8
         1Q0rx/P1+k92ywU5GLTSEZizu6T8zeFgBcZv77q4eHIHtA89qhlvBiwcbDMN2R35pRbU
         9eG0F9J9Fyx29doyarT5MFCSYVWM3o47RjV6RCqyBkctPSViqF+xO9kWvb8gPgzHqWuh
         hKfg==
X-Gm-Message-State: AElRT7G3IzUA9/2MvfOiUhiSIrrK8HhArYmJNtGFx6gMODRHjaEidEtZ
        pHBvWIk9uTSc8azVp6mL+AMEjcpp
X-Google-Smtp-Source: AIpwx49HaexJPQ/vo08OQ/aRsbn2ZaNW9+uynsxrtqqws0j+r+bCVKyMd/XY/GzohgV6mRoNtadVHA==
X-Received: by 10.80.179.236 with SMTP id t41mr7042133edd.40.1522516422679;
        Sat, 31 Mar 2018 10:13:42 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o60sm6657416eda.17.2018.03.31.10.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Mar 2018 10:13:41 -0700 (PDT)
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add -p: fix 2.17.0-rc* regression due to moved code
References: <20180331123605.30076-1-avarab@gmail.com> <20180331125058.4506-1-avarab@gmail.com> <f60a2014-3b02-3eae-76cb-950330113afa@talktalk.net>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <f60a2014-3b02-3eae-76cb-950330113afa@talktalk.net>
 From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
From:   avarab@gmail.com (=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason)
Date:   Sat, 31 Mar 2018 19:13:40 +0200
Message-ID: <87bmf4w4l7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 31 2018, Phillip Wood wrote:

> On 31/03/18 13:50, Ævar Arnfjörð Bjarmason wrote:
>> Fix a regression in 88f6ffc1c2 ("add -p: only bind search key if
>> there's more than one hunk", 2018-02-13) which is present in
>> 2.17.0-rc*, but not 2.16.0.
>>
>> In Perl, regex variables like $1 always refer to the last regex
>> match. When the aforementioned change added a new regex match between
>> the old match and the corresponding code that was expecting $1, the $1
>> variable would always be undef, since the newly inserted regex match
>> doesn't have any captures.
>>
>> As a result the "/" feature to search for a string in a hunk by regex
>> completely broke, on git.git:
>
> Good catch, I could have sworn I'd tested my patch but I obviously
> didn't notice the warning (I've got interactive.singlekey set so it
> prints the warning and then prompts as it always has done). Calling it
> completely broken is perhaps a little harsh as it does work if you
> enter the regex again and with interactive.singlekey set you only have
> to enter the regex once.

To clarify by "completely broken" I mean the "/" feature itself, but
yeah, you can still search by regex since we just so happen to have the
fallback codepath intended to catch "/" without an accompanying string,
which'll kick in and ask you for the regex since $1 will be undef at
that point, and will thus coerce stringwise to "".

> Thanks for fixing it
>
> Phillip
>>
>>      $ perl -pi -e 's/Git/Tig/g' README.md
>>      $ ./git --exec-path=$PWD add -p
>>      [..]
>>      Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,?]? s
>>      Split into 4 hunks.
>>      [...]
>>      Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,?]? /Many
>>      Use of uninitialized value $1 in string eq at /home/avar/g/git/git-add--interactive line 1568, <STDIN> line 1.
>>      search for regex? Many
>>
>> I.e. the initial "/regex" command wouldn't work, and would always emit
>> a warning and ask again for a regex, now it works as intended again.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>
>> Of course I just noticed the grammar errors in the commit message
>> after sending. Here's a v2 with that fixed, also genreated the patch
>> with -U6 to make it clear what's going on.
>>
>>   git-add--interactive.perl | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
>> index d190469cd8..c1f52e457f 100755
>> --- a/git-add--interactive.perl
>> +++ b/git-add--interactive.perl
>> @@ -1561,13 +1561,13 @@ sub patch_update_file {
>>   			elsif ($line =~ m|^/(.*)|) {
>>   				my $regex = $1;
>>   				unless ($other =~ m|/|) {
>>   					error_msg __("No other hunks to search\n");
>>   					next;
>>   				}
>> -				if ($1 eq "") {
>> +				if ($regex eq "") {
>>   					print colored $prompt_color, __("search for regex? ");
>>   					$regex = <STDIN>;
>>   					if (defined $regex) {
>>   						chomp $regex;
>>   					}
>>   				}
>>
