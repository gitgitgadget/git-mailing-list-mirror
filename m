Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109A21F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 10:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeJJRfd (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 13:35:33 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:23821 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeJJRfd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 13:35:33 -0400
Received: from [192.168.2.201] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id ABVBg2lYjbZX5ABVBgf3B2; Wed, 10 Oct 2018 11:14:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539166442;
        bh=9/VFXdS9MEgYaLRPA/3bYHeE9StIXcBGU0RSiD449ug=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ve1jgdBwnWg20ju7HfVQzJ/JOa1It6uvPf7vuJcDLU3N37ttyV3WA5vp7X5Zdvtx1
         g8bYoB6KlH//Rvet7nXbZsXidTfcxRp5CqcT6phS96/T+bfyNc/V/pZAARa05+hSAl
         TGzXSDKd4wxcshr+mIUBnk9PHPTQs7432nM9m1is=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=mMcvW89k4BleX1Sim1cA:9 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] add read_author_script() to libgit
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20180912101029.28052-3-phillip.wood@talktalk.net>
 <CAPig+cTGYWoW+YiW5tJVPZVie3zsG+pmQiV7k+es-=y9e4=RZw@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <28505444-0798-6fda-6d1b-b9dbc0007123@talktalk.net>
Date:   Wed, 10 Oct 2018 11:14:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTGYWoW+YiW5tJVPZVie3zsG+pmQiV7k+es-=y9e4=RZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEuBhiGsbZQdG1BPUT7eXfEFhCtMgzDudBf1PeC7E1u/giN2D8XNeylth33ujgkgEcVV6MRUiGY1LaAotkVa/6qbfiZ2zuQ9umykasd9y8trmnRV0RsS
 gqleBobZedn2EMQxGDrMASeOpWHiRwbZOME+zv7e209ZBqh71AnYE8rOuhxbZG+57GRIAF7WFr4vKt/UNMGmcO4UZbbf21Cjq0QHRqbFUu6UfTV6jitZ7CPE
 Jp0HDeezXDIXeuTGGw+bZcz9u7Lz16BYRRTPIocdgv1FGRiX8WME8AqtNhU2AXfITTlSsp1EAUxFtVOyCN6VNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

Thanks for looking at this series, sorry it has taken so long for me to
reply.

On 14/09/2018 00:49, Eric Sunshine wrote:
> On Wed, Sep 12, 2018 at 6:11 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>> Add read_author_script() to sequencer.c based on the implementation in
>> builtin/am.c and update read_am_author_script() to use
>> read_author_script(). The sequencer code that reads the author script
>> will be updated in the next commit.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>> diff --git a/builtin/am.c b/builtin/am.c
>> @@ -305,39 +279,16 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
>>  static int read_am_author_script(struct am_state *state)
>>  {
> 
> This function returns 'int'...
> 
>>         const char *filename = am_path(state, "author-script");
>> +       if (read_author_script(filename, &state->author_name,
>> +                              &state->author_email, &state->author_date, 1))
>> +               exit(128);
> 
> ...but only ever exit()s...
> 
>> +       return 0;
> 
> ... or returns 0.
> 
>>  }
> 
> It's a little disturbing that it now invokes exit() directly rather
> than calling die() since die() may involve extra functionality before
> actually exiting.
> 
> What if, instead of exit()ing directly, you drop the conditional and
> instead return the value of read_author_script():
> 
>     return read_author_script(...);
> 
> and let the caller deal with the zero or non-zero return value as
> usual? (True, you'd get two error messages upon failure rather than
> just one, but that's not necessarily a bad thing.)
> 
> A possibly valid response is that such a change is outside the scope
> of this series since the original code shared this odd architecture of
> sometimes returning 0, sometimes -1, and sometimes die()ing.

My aim was to try and to keep the changes to a minimum as this patch
isn't about changing the odd architecture of the original. I could add a
follow up patch that cleans things up as you suggest.

Best Wishes

Phillip

