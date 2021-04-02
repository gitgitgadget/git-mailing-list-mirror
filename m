Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4404C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 20:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1026113E
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 20:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhDBUnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 16:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhDBUnU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 16:43:20 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1132FC0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 13:43:19 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id x207so5990572oif.1
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tv7fHOCWMhdbALIW/vIsZxhLkMjgEkO+OLczCXgibKk=;
        b=GA4/FNn7d37uQXwabUnFyOM6l3zeET8H0AaefmmtJL0Im9iB1iMMeHIK/lOd5dKNxl
         BGnwamPPAypWOdta7Swr6ZlYKGItJ7U2PpT1J6550CqZ2VBdif2y1hot8GXB3U0ydgV/
         GUl8oydcU0YL9RIpLt8L/H57sg/GS1q0n9V5ev+1J8vc7/JXmM3RWZ9RO/SGFYOXVFPs
         NfOYTT/5H69BBk02kfemmX5LeEifaL7jTm3vMfVDqwVs0PNlJcgpK/cHGz+eziMWsSub
         DzgJUxF+ALX7i6nQYfktv2AZ/KBL1GOvUFqGuGUlFM3cgfjTM2LnMdopuoiDmUhWWCBj
         V5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tv7fHOCWMhdbALIW/vIsZxhLkMjgEkO+OLczCXgibKk=;
        b=m6k5IiOgXA1YH19tWt6UtJnbxlO6iyXBglmvctUsVzXdYNgIAc8wPz5GhPCpHi5jEz
         lORkTa7BtEQSNO6/ZAtvguFvo6ilYhUbam8/8LSIk5mvEIWYuvydCF9iNvrpQ28xHbso
         fEwBQLwx1cYO7sd2zItq6sBvpCIxoW7uBpyLTHAPzvg+T4bezpCqye9HtdiV3/O5hh9d
         DXxlQyYRWnC+39rMYlgNQxBPGNCACSCZ+idzpw7Xgp5ZMDEgj8ImhKkJvOERZShpHNYO
         AVhFtD8DCdvLQJE1VrDXyxySBoIZWVSQG5JAe998KH3uyX5ars3iiuqVk0qeDziRHrhK
         rNdg==
X-Gm-Message-State: AOAM532w5dS3aMGnZjx8UnftjAVduRq9LPZfB7aCWTvmyxiWKHO/kfGC
        GZiugwChHMHIdHrrXX/X/U0QXz3U/ZGyQA==
X-Google-Smtp-Source: ABdhPJwfMq+JxbyQGNpQXSBPKFq+U9bpueXntmxmlvr8qX3PgMz2r5o+o4zeYKRCxUPizSgxJQcGRg==
X-Received: by 2002:aca:df44:: with SMTP id w65mr10647392oig.36.1617396198078;
        Fri, 02 Apr 2021 13:43:18 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d5a8:1a30:4466:1b29? ([2600:1700:e72:80a0:d5a8:1a30:4466:1b29])
        by smtp.gmail.com with ESMTPSA id x3sm2096257otj.8.2021.04.02.13.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 13:43:17 -0700 (PDT)
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com> <xmqq8s613gqa.fsf@gitster.g>
 <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
 <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
Date:   Fri, 2 Apr 2021 16:43:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/2/2021 2:27 PM, Tom Saeger wrote:
> On Thu, Apr 01, 2021 at 06:25:36PM -0400, Derrick Stolee wrote:
>> On 4/1/2021 4:14 PM, Junio C Hamano wrote:
>>> Derrick Stolee <stolee@gmail.com> writes:
>>>
>>>> On 4/1/2021 2:49 PM, Tom Saeger wrote:
>>>
>>> So, redirecting the right-hand of configured refspec is a good idea;
>>> not copying the left-hand of configured refspec, and unconditionally
>>> using "refs/heads/*" is not.
>>  
>> This makes sense as a way to augment the feature. It doesn't seem
>> like a common scenario, but it would be good for users to have
>> that flexibility.
> 
> It's common for me, especially on repos requiring 'maintenance'.

I'm sure that once this is a tool in your belt, then it becomes
common. The number of users who think about refspecs is likely a
small proportion. But features should work as well as they can
for as many users as possible. There's a way forward here, it
just is a little tricky due to the generality of refspecs.

>> Upon initial inspection, it shouldn't be too much work. However,
>> there is some generality to the refspec that might not be wholly
>> appropriate for prefetch (such as the exact_sha1 option). I'm
>> unfamiliar with the advanced forms of the refspec, so it'll take
>> some time to have confidence in this approach.
> 
> Didn't know about exact_sha1.  prefetch probably wouldn't do
> anything in that case?

My guess is that those should be dropped and ignored. But
maybe the approach below will still work?

> 'negative' refspecs - hmm haven't tried those.  I see how that might
> complicate things or maybe not.
> 
> generally isn't it still changing the right-hand side of refspec?
> 
> replacing ":refs/" with ":refs/prefetch/"

Right, this substring replacement might be easiest to achieve. The
'struct refspec' doesn't make it incredibly easy. Perhaps skipping
the refspec parsing and just doing that substring swap directly from
the config value might be the best approach.

> This would still work for refspecs with negative patterns right?

One of the issues is that negative patterns have no ":refs/"
substring.

The other issue is that exact matches (no "*") have an exact
string in the destination, too, so replacing the _entire_
destination with "refs/prefetch/<remote>/*" breaks the refspec.
I think the substring approach will still work here.

> I'm willing to help with/test/review this, thanks for investigating.
I have a branch available [1], but I'm seeing some failures only
on FreeBSD [2] and I can't understand why that platform is failing
this test. The current version (as of this writing) does not do
the substring replacement technique, and hence it just gives up
on exact matches. I will try the substring approach as an
alternative and see where that gets me.

[1] https://github.com/gitgitgadget/git/pull/924
[2] https://github.com/gitgitgadget/git/pull/924/checks?check_run_id=2256079534

Thanks,
-Stolee
