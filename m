Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8BC1F453
	for <e@80x24.org>; Thu,  2 May 2019 15:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfEBPpv (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 11:45:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37073 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfEBPpv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 11:45:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id k23so4040498wrd.4
        for <git@vger.kernel.org>; Thu, 02 May 2019 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NPTRJANnYe1uAGSy7mV0AbBjeqtD5mqHy83UKmL0cxo=;
        b=eTpgqaeMiFfnJc3FKPYknoBaLL8+7EtNuYJ4CCZ9lfM95qlXbKvumEUHHG7yVHVkxS
         pGD5JxSxhxsE4btN1Rp+aK/CQdK6X390Ro5UOk5mbimz6ov3rhkKggSrzun1/4v9sVW7
         XxsdF1QcgeZwBPte3XDEN8H6XCxK6wkLNI50IldBInx94lGbedz4FwAC/gqj4sxF9dve
         fueGoywdmXTW6O0+B3GTSV7/VtuDpFuOnVflcNCsHYjNLVw0OyEyLJQ3CNS73fHAAxgl
         KLEL5TxLj0X4u5lN66UawNJA9/T2PEe6ctySCh7Hz6WXvHksTvh1q0csw7D6Y9bOwK/x
         vQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NPTRJANnYe1uAGSy7mV0AbBjeqtD5mqHy83UKmL0cxo=;
        b=QLW8IYyUQ3P9c36RTCUPBmGMvAkuKagiae7MwTB+8GmpcvH8sQYBCrB/XHkBJp9sUy
         x1i1azgOAhVa0lEPCqP1GGJE/roC8il3XZdgO965hbS5AfjcPKSBRzs+UWJWzytUDJuh
         6qm0Jn2d0tdi9KDuf3Wrqha2r9pgQNl/3EX1ATjRlF2owQCaaPItSENON4fuNwMvg2sg
         +ce1Kh0+gTBU16L2FsLt9uNHmrOmik8FVbrRQNMjJZDrvCnI/wDJovGbRlXswOasRCCa
         gkszQp6KHhMRiSqvM2RJ3yPkgL6olmESbAsi4fAzYRseDnUbIZuzYmQmaD1t1RVb4T6P
         cqAQ==
X-Gm-Message-State: APjAAAVSw1ZyemFGb59jdkDrhHra2Yz3CKVHq8WOKNzP3bEvMvKjSfZ9
        bkuE5dFCyaZRcQMzGdptZr0=
X-Google-Smtp-Source: APXvYqyjz3Pm+9eWYOp54qcBnFrmPSRJcUOxx4a/DB4Mkxx0njyGfGlA9bBZzB/lG7ZVFLLy72b9cA==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr3454028wre.72.1556811948524;
        Thu, 02 May 2019 08:45:48 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id b12sm22100850wrf.21.2019.05.02.08.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 08:45:47 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] rebase --interactive silently overwrites ignored files
To:     wh <microrffr@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <CAL_tzDGRQ4BzJ4c6QypXfBXQNQYocbKbJSBOHhBBB2TwQQPCGA@mail.gmail.com>
 <2643a200-5356-f3bc-1715-3f34b5f19a5b@gmail.com>
 <CAL_tzDFQQtDYMStN+RDVYN_TzJmO+kufMhG9PGHwvsUWREpgWQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3bf0f04d-83d4-ef13-8e19-a679b4153793@gmail.com>
Date:   Thu, 2 May 2019 16:45:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_tzDFQQtDYMStN+RDVYN_TzJmO+kufMhG9PGHwvsUWREpgWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi wh

On 14/04/2019 02:59, wh wrote:
> Thanks for the info about the upcoming "precious" attribute. Looks useful.
> 
> I didn't get the impression that Git normally overwrites ignored
> files. I ran some more experiments:
> 
> git rebase FETCH_HEAD        # bails
> git rebase -i FETCH_HEAD     # overwrites
> git merge FETCH_HEAD         # bails
> git reset --keep FETCH_HEAD  # bails
> git reset --merge FETCH_HEAD # bails
> git checkout FETCH_HEAD      # overwrites
> # without feature 2 locally:
> git merge FETCH_HEAD         # overwrites, fast-forwards
> git merge --no-ff FETCH_HEAD # bails

I've had a look at the rebase -i code and I think it only overwrites 
ignored files when it is fast-forwarding. This matches what merge does 
when fast-forwarding but I'm not convinced either of them should be 
doing this by default (I think checkout doing it is probably asking for 
trouble), as you point out most operations preserve ignored files. When 
pull fast-forwards it does not overwrite ignored files.

Both checkout and merge have an undocumented --overwrite-ignore option 
which is on by default. Checkout and fast-forward merges overwriting 
ignored files dates back a long way to commit 1127148089 ("Loosen 
"working file will be lost" check in Porcelain-ish", 2006-12-04). There 
does not seem to have been much discussion of changing the semantics of 
ignored files around the patches that implemented this [1,2]. There is a 
brief mention of doing it in this thread [3] but no one seems to comment 
on the idea as far as I can see. Before this change ignored files were 
just ignored by status and add but otherwise treated like any other 
untracked file.

I'll put a patch together to fix rebase -i, I'd like to see the defaults 
for merge and checkout changed but I'm not sure that would be popular. 
It does seem like surprising behavior though when most operations try to 
preserve untracked files.

Best Wishes

Phillip

[1] 
https://public-inbox.org/git/7vlklnkv39.fsf@assigned-by-dhcp.cox.net/T/#u
[2] 
https://public-inbox.org/git/7vbqmjkuzd.fsf@assigned-by-dhcp.cox.net/T/#u
[3]https://public-inbox.org/git/Pine.LNX.4.64.0610081657400.3952@g5.osdl.org/

> On Fri, Apr 12, 2019 at 9:30 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi
>>
>> On 12/04/2019 00:56, wh wrote:
>>> I'm using git 2.20.1 from Debian. Git is usually careful not to
>>> overwrite untracked files, including ignored files.
>>
>> Git normally overwrites ignored files, so I think in your example rebase
>> -i is working as expected, I'm surprised that the am based rebase does
>> not overwrite the ignored file. There has been some discussion about
>> introducing 'precious' files that are ignored but protected in the same
>> way as untracked files [1].
>>
>> Best Wishes
>>
>> Phillip
>>
>> [1] https://public-inbox.org/git/20190409102649.22115-1-pclouds@gmail.com/
>>
>>    But interactive
>>> rebase doesn't detect this (non-interactive rebase works fine).
>>>
>>> Reproduction:
>>> -----
>>>
>>> #!/bin/sh
>>> mkdir upstream
>>> cd upstream
>>> git init
>>> echo 1 >feature-1
>>> git add feature-1
>>> git commit -m "feature 1"
>>>
>>> cd ..
>>> git clone upstream local
>>> cd local
>>> # write some tools for our own convenience
>>> echo ours >tools
>>> echo /tools >>.git/info/exclude
>>> # start working on a feature
>>> git checkout -b f2
>>> echo wip >feature-2
>>> git add feature-2
>>> git commit -m "wip"
>>>
>>> cd ../upstream
>>> # official tools are available
>>> echo theirs >tools
>>> git add tools
>>> git commit -m "tools"
>>>
>>> cd ../local
>>> git fetch ../upstream master
>>>
>>> # this would be okay
>>> #git rebase FETCH_HEAD
>>>
>>> # problem: overwrites tools silently
>>> GIT_EDITOR=true git rebase -i FETCH_HEAD
>>>
>>> cat tools
>>>
>>> -----
>>>
>>> Expected: `git rebase -i` fails because it would have to overwrite the
>>> untracked "tools" file. Contents of tools file remains `ours`.
>>>
>>> Actual: Contents of tools file becomes `theirs`.
>>>
