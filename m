Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D680CC433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 18:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4A120848
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 18:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N31CdDeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391622AbgJPSYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 14:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391390AbgJPSYT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 14:24:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0F2C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 11:24:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so3971370wrm.13
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 11:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BC1zkcoTc84pu2R2BiB76Uv55mmDfNbfA1GAGL3iQdQ=;
        b=N31CdDeM0jOMoZ/+79upgvh6TyKzAtN90ClGDJYORLiDdj4vPQ0QtuywMQ2uXda3Nt
         rVQv9VBMy44DGkEwcR/46sQATVVU5RGghheu3tuqVdlBYDTjrsLZ5kPyM3WkQZnbentE
         C7H+AMVifn5dxpEaX0R4mKy9XT9a/ddR+vw0AM2EYS5lycz79S3qIfj3Y0iCT8diJUMo
         LQdkw8aM5RRt6AeunoBrzzK7vLzLJ50Hh4bKY20R2uUEAMv2Tmqc7n/53Id0jl8JzgBe
         lgD0XQA1sKi4WUIolP+KcLez0vvmK2K6DhmCZsMsVhepg473gRhb5tWMbUTw1zrVaY/C
         8rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BC1zkcoTc84pu2R2BiB76Uv55mmDfNbfA1GAGL3iQdQ=;
        b=tqyr3foVOdbKIMIgdVkR8NfLmJCCxwDiE2pr7CFlUjPUTiVqTf6LugjZDx2LwMbDA1
         Ngwk0EwkTVeA7YviGOEfa+eYiNbm9oR3zsw8W8IKrhOa8XX/TTxzA2zOpjEfZMwGO3Ba
         lycTJI9f+bsRKjCuQ6Guw61z25/9U06Ysebh4k+3LhIZUZTLkIIlQ1gYQMRtsOBWqbiq
         8Dz0SVt5kmAVjExz0UmPOjgV6/0wfeo5YDVEq6kbnFEvBJhZGKhoe3raPuPMY6oAtNQq
         BkOXpJIW8rfiR/S14ngveTzH1By1r2DzlFMJZpkDXCI1TyObGCLn3uoUMmUNod+J367G
         5BCQ==
X-Gm-Message-State: AOAM531BW2yS99wigOAK9Id7vPoyuUQihPTouSD2E9xdyzViw6eCpvwK
        qWC0W++HeeG4xmkVDmXWA4k=
X-Google-Smtp-Source: ABdhPJwmJc3cUdKYaqin+t1eTqFcLgQMPZ8Ajhvm4SrlJGRqIDcgcBr/1mRhyrftc5DlTUK5k+yFCg==
X-Received: by 2002:adf:e681:: with SMTP id r1mr5237708wrm.181.1602872657374;
        Fri, 16 Oct 2020 11:24:17 -0700 (PDT)
Received: from [192.168.1.201] (48.45.90.146.dyn.plus.net. [146.90.45.48])
        by smtp.googlemail.com with ESMTPSA id z191sm3918219wme.30.2020.10.16.11.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 11:24:16 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] test-lib: allow selecting tests by substring/glob
 with --run
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
 <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
 <9c8b6a1a943261635fa09bed22ae36e368686f15.1602710025.git.gitgitgadget@gmail.com>
 <2b757512-793d-a6e0-0a50-368061e122dd@gmail.com>
 <CABPp-BHkykWh8L_FYhLR1BCCpPDmc_2q+Tccg_yZ7W8ZHZ4WsA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2fd1231c-9df3-623d-9ae1-0d66526db618@gmail.com>
Date:   Fri, 16 Oct 2020 19:24:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHkykWh8L_FYhLR1BCCpPDmc_2q+Tccg_yZ7W8ZHZ4WsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 16/10/2020 18:27, Elijah Newren wrote:
> Hi Phillip,
> 
> On Fri, Oct 16, 2020 at 4:41 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Elijah
>>
>> On 14/10/2020 22:13, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> Many of our test scripts have several "setup" tests.  It's a lot easier
>>> to say
>>>
>>>      ./t0050-filesystem.sh --run=setup,9
>>>
>>> in order to run all the setup tests as well as test #9, than it is to
>>> track down what all the setup tests are and enter all their numbers in
>>> the list.  Also, I often find myself wanting to run just one or a couple
>>> tests from the test file, but I don't know the numbering of any of the
>>> tests -- to get it I either have to first run the whole test file (or
>>> start counting by hand or figure out some other clever but non-obvious
>>> tricks).  It's really convenient to be able to just look at the test
>>> description(s) and then run
>>>
>>>      ./t6416-recursive-corner-cases.sh --run=symlink
>>>
>>> or
>>>
>>>      ./t6402-merge-rename.sh --run='setup,unnecessary update'
>>
>> The beginning of match_test_selector_list() looks like
>>
>> match_test_selector_list () {
>>          title="$1"
>>          shift
>>          arg="$1"
>>          shift
>>          test -z "$1" && return 0
>>
>>          # Both commas and whitespace are accepted as separators.
>>          OLDIFS=$IFS
>>          IFS='   ,'
>>          set -- $1
>>          IFS=$OLDIFS
>>
>>          # If the first selector is negative we include by default.
>>          include=
>>          case "$1" in
>>                  !*) include=t ;;
>>          esac
>>
>>          for selector
>>          do
>>
>> If I'm reading it correctly the selectors are split on commas and
>> whitespace which would mean we cannot match on "unnecessary update". I
>> think we definitely want the ability to include whitespace in the
>> selectors in order to be able to narrow down the tests that are run. I'm
>> not sure that there is much value in splitting numbers on whitespace as
>> it would mean the user has to quote them on the command line so we can
>> probably just do 'IFS=,'. We'd also need to keep IFS as ',' in the case
>> statement you add below as well rather than restoring it straight after
>> the 'set' statement above.
> 
> Given that t/README explicitly shows examples of space-separated lists
> of numbers,

That's a shame

> I'm worried we're breaking long-built expectations of
> other developers by changing IFS here. 

I agree

> Perhaps I could instead add
> the following paragraph to t/README:
> 
> Note: The argument to --run is split on commas and whitespace into
> separate strings, numbers, and ranges, and picks all tests that match
> any of individual selection criteria.  If the substring you want to
> match from the description text includes a comma or space, use the
> glob character '?' instead.  For example --run='unnecessary?update
> timing' would match on all tests that match either the glob
> *unnecessary?update* or the glob *timing*.
> 
> Does that address your concern?  The '?' will of course match on
> characters other than a space or comma, but the odds that it actually
> matches anything other than what you want is pretty slim, so I suspect
> that is good enough.

'unnecessary?update' is pretty ugly but I agree false matches are 
unlikely to be a problem it practice. Your suggested paragraph looks 
good to me

Thanks

Phillip

