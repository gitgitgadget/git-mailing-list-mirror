Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2CE120248
	for <e@80x24.org>; Wed, 13 Mar 2019 20:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfCMUkh (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 16:40:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32828 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCMUkg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 16:40:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id i8so3509526wrm.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uk3DGRNtPdkl33HAq4Lq0X5IHmDjjHyiPaLa6em/Mc0=;
        b=hW/jEk/ZYVLL7f4haUAY+QjyP7QwzxmKcX1ujVn/Opk0a6uTgqZSuukuCKkUeDO3s7
         8TVrIYD4qV8DToZKJILl0UrldreYJRcxIRriG+Zci+wAJOkMLccUoQ9+1CKf1iLDVrJb
         Tl64sjPtFd5D26oaDhRHEHJiuCwA1PAdn7/Oj7cz3z3+iYMRwfbZm8cZZkiAZ6kMw+e2
         lKNMzASsnzXk5bfYXYxFqW8zympUwQnFWvsuStfDShTnsUNw3eYbZWtmYzfrwZfr+A4J
         pPZ821pf1KsjIG5xDTHUYvwG6JBtcopaKk3T5kKAOubAct/RKmyebmtv5r6kgxGa3C3Q
         h4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Uk3DGRNtPdkl33HAq4Lq0X5IHmDjjHyiPaLa6em/Mc0=;
        b=HrbEwISYhtYZTrrRR2AQbuFHv2SMPBbfOmY6czYYZppnfgCbfet4hjwzO4V5ejzGiK
         LdnuTPvDQjOJFtEvkFYjawJqvBVAlzgkcNv7+xvSF+y5ZHyLbwwPcy2NvafJfFnz9ESg
         LcShUfRIqW0kHN0yvqMZgklzngZ/0e3+QkGWPyeuj0QAGED8eQbOGYaMNuQ4N3hxh61R
         TQv3J0hMxF3Su1ttQIM7KywBRk31f2h+rl/M1kJPgjgFx5lnFQ0UVT1NcjDe+AcpkRZc
         rW7xAh7gRfQgiyz1TWIn82lQLJH2JwsMITVMtG/ZQW0CMQGBg6Z6d/pZhmKsqEFb8AFO
         S+mQ==
X-Gm-Message-State: APjAAAWq0wiv2aVjlP/2vWWTX73w0LqKD8bJXS2hX0oRq36KOVqoWiQl
        1T4fZ3eh5ll41rX9lQE1fqR2wqWGq0iQ2Q==
X-Google-Smtp-Source: APXvYqwxttB5JVEzTG2VvEkKX3NfU3j2+JfpcTiMU/A5zVJ4jT+tuUIdid0p8TdzSkSf2eS0tMI98A==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr26472820wrp.150.1552509634385;
        Wed, 13 Mar 2019 13:40:34 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.gmail.com with ESMTPSA id d5sm6308207wrx.12.2019.03.13.13.40.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 13:40:33 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Possible race condition with git-rebase + .git/index.lock
To:     Sergio Durigan Junior <sergiodj@sergiodj.net>,
        Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <87k1h55bx0.fsf@sergiodj.net>
 <CACsJy8ANLkz=3cj1dAuHdUCkrgQzos=90EEG0n901o3QAp3PUQ@mail.gmail.com>
 <877ed459eh.fsf@sergiodj.net>
 <CABPp-BFnxhiXfvZUZndD-_htMEw0bZzrLRFpAF9u5YV3wi6qnA@mail.gmail.com>
 <8736nr6g94.fsf@sergiodj.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e0e1e159-844d-c9bf-e1cc-ada05384ef76@gmail.com>
Date:   Wed, 13 Mar 2019 20:40:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <8736nr6g94.fsf@sergiodj.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergio

On 12/03/2019 19:32, Sergio Durigan Junior wrote:
> On Tuesday, March 12 2019, Elijah Newren wrote:
> 
>> On Tue, Mar 12, 2019 at 9:48 AM Sergio Durigan Junior
>> <sergiodj@sergiodj.net> wrote:
>>> On Tuesday, March 12 2019, Duy Nguyen wrote:
>>>
>>>> On Tue, Mar 12, 2019 at 5:18 AM Sergio Durigan Junior
>>>> <sergiodj@sergiodj.net> wrote:
>>>>> This works without problems most of the time (well, usually there are
>>>>> conflicts and all, but that's a burden I have to carry).  However,
>>>>> sometimes I notice that git fails with:
>>>>>
>>>>>    # git rebase origin/master
>>>>>    ...
>>>>>    Applying: commitX
>>>>>    Applying: commitY
>>>>>    Applying: commitZ
>>>>>    fatal: Unable to create '/home/xyz/dir1/dir2/.git/index.lock': File exists.
>>>>>
>>>>> The first thing I did was to check whether the index.lock file existed,
>>>>> but it doesn't.
>>>>
>>>> Is the output this clean? What I'm looking for is signs of automatic
>>>> garbage collection kicking in the middle of the rebase. Something like
>>>> "Auto packing the repository blah blah for optimum performance".
>>>
>>> Yeah, this is the exact output.  I also thought about "git gc", but I
>>> don't see any output related to it.  Is it possible that it's being
>>> executed in the background and not printing anything?
>>
>> Any chance you have a cronjob or other task execution mechanism that
>> is running git commands in various directories (even simple commands
>> like 'git status' since it's not read-only contrary to what some
>> expect, or 'git fetch' which might trigger a background gc)?
> 
> Nope, nothing like this.  AFAIK, nothing is touching that repository at
> the same time that I am.  Besides, even if I wait some minutes before
> trying again, the bug manifests again.
> 

Do you have any of the files in the repository open in an editor or ide 
while you are rebasing? I have seen this message when rebasing and one 
of the files is open in emacs which runs git status when it sees a file 
has changed which locks the index while the rebase is running.

Best Wishes

Phillip
