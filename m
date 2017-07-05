Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 624C0202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 18:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbdGESDN (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 14:03:13 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38236 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdGESDM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 14:03:12 -0400
Received: by mail-wm0-f48.google.com with SMTP id f67so121063873wmh.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 11:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WdRxIFrZxha14zSjnGywGaE9laDwEFO+dwlURSh9YZE=;
        b=rU1St3gb8BM+1WIYxE/8oOeBIREghqhB8kjHC7G4SVHJKPAyHq7FaXBM9/6OiS22Iu
         tnnff1luQatUsLE2b40pu+Ftjj0XW5PHXbRJeS5eQnDex6KIKHZnFc3NSfV9+eah+uT3
         /8KmgUEY/dXkZhjKlfID8Oa0xCQQrHDNHqwgzOf0uwydMRGCzl++YHAhFW2ZWKP6mThN
         bkuhVUwwMcSIbjnbDEo58ngRTWIPxJE2ZEf9aH44OYmi+6GBsEyLSn7w99gaHa1ZQX7W
         2KxBxEx8oDRyJ1MMa/iP1W/ja0tEALCShx/RVu3Dz10XBqj9XsAIBmAt9aavNjF5oW3n
         uHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WdRxIFrZxha14zSjnGywGaE9laDwEFO+dwlURSh9YZE=;
        b=ohFXxRi89vZfvmIEizdMSAN2o+mXuM+vi6wZvPzAHmoBh9bOEPglhxP+uJ/pRT6s8Z
         ojEjQdnAYbWAkNzLMXTYz3cgu8xcgGnun1tBljTcug6ApjlMDO0dTZB93IEKFGFGb0mX
         dpVfqelWGb9TAN5SSKev4TC/c1yU/6voySPAYAVQekNq8Ze1oSUQ9puxameCma0bWCUB
         DrDelsyKLlAb9mb+oY6HfcfNYMgGAERiGRz//qLra5ShpzCHin2525BDQ6cSm4dFl8ur
         M9j4F0hCsvLXbJloS8pEmr9OwXFQCprA61Rm/15ijUQVl0+TQ5CzOAsO8Fuvu2HW0GKU
         t/KQ==
X-Gm-Message-State: AKS2vOxITTG2dD6ImyrtalfFXEcIcn6VzlDGzJUHu91wU+8XOcWWHW6K
        QSS/HyFX6YBxtw==
X-Received: by 10.80.179.109 with SMTP id r42mr19952408edd.1.1499277791289;
        Wed, 05 Jul 2017 11:03:11 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id i42sm8848491ede.5.2017.07.05.11.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 11:03:10 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dSodp-0006RW-3w; Wed, 05 Jul 2017 20:03:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v3 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
References: <20170701220547.10464-1-avarab@gmail.com> <20170627121718.12078-1-avarab@gmail.com> <20170701220547.10464-3-avarab@gmail.com> <xmqqa84lmonj.fsf@gitster.mtv.corp.google.com> <874lutclie.fsf@gmail.com> <xmqq4luskt9l.fsf@gitster.mtv.corp.google.com> <87fuebbyvl.fsf@gmail.com> <CAGZ79kZqF3_PyrCnCMDyLNAUMRnvq96L3yoE0j=yzMigu4LUzg@mail.gmail.com> <xmqqinj7k5ot.fsf@gitster.mtv.corp.google.com> <CAGZ79kaHLi7iotAT-eKkFv5fsG1fTA2k4SYZAPAmU7h3uAA8Jw@mail.gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAGZ79kaHLi7iotAT-eKkFv5fsG1fTA2k4SYZAPAmU7h3uAA8Jw@mail.gmail.com>
Date:   Wed, 05 Jul 2017 20:03:09 +0200
Message-ID: <87bmoybw2q.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 05 2017, Stefan Beller jotted:

> On Tue, Jul 4, 2017 at 6:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> On Tue, Jul 4, 2017 at 3:50 PM, Ævar Arnfjörð Bjarmason
>>> <avarab@gmail.com> wrote:
>>>
>>>>
>>>> I think some invocation of "git submodule update ???" will do the same,
>>>> but I can't from the docs see what that is right now.
>>>
>>> '--remote' is what you are looking for.
>>>
>>> When we have the branch field configured, the workflow for *creating*
>>> the patch sent
>>> to Junio might be different than it currently is. Currently, you would
>>> send a patch that is
>>> produced as:
>>>
>>>   git -C sha1collisiondetection pull origin master
>>>   git add sha1collisiondetection
>>>   git commit -m "serious reasoning in the commit message"
>>>
>>> This could be 'simplified' to
>>>
>>>   git submodule update --remote
>>>   git add sha1collisiondetection
>>>   git commit -m "serious reasoning in the commit message"
>>>
>>> but as we had different branches in the submodule field,
>>> I wonder how much of an ease this is.
>>>
>>> For Junio the workflow stays the same, as he would just
>>> apply the patch, so I understand why he might see the
>>> branch field as pollution.
>>
>> My reaction was more about "the rest of us", not me or those who
>> choose to bind a new/different commit in the submodule to the
>> superproject.
>
> Currently the rest of us would not care IMHO, as there is no
> difference with the field recorded or not. (I just checked if it
> would provide slight benefits for shallow clones, but not so)
>
>> I was recalling a wish by submodule users in a distant past that
>> lets "submodule update" to detach to the tip of the named branch in
>> the submodule, regardless of what commit the superproject points at
>> with its gitlink.
>
> Yes, I heard that a couple times when poking around for opinions
> and I think the issue has 2 facets:
> * They actually want to be on a branch, such that the workflow
>   is 'normal'. (Whatever that means, "detached HEAD" sounds
>   scary, but workflow-wise it is not. It just requires an additional
>   "checkout -b" once the work done seems worth preserving)
> * None of the people I talked to wanted to get rid of exact-tracking,
>   solely. But they always came in trade off with the first point
>   outweighing the benefits of exact tracking.
>   Although for this purpose the "update --remote" also doesn't
>   quite fit as it does not re-attach the HEAD to a branch at
>   the same commit as the remote tracking branch.

For my submodule use, I'd like to have it checkout the branchname
recorded in the .gitmodules with tracking info set to upstream, and then
"git reset --hard" to the commit that's recorded in the commit info.

This would exactly mirror the state the repo was in when I initally ran
"git submodule add" on it, and make it easy to start making new commits
on my local branch, submit a PR of those to upstream, and have things
like "git fetch && git log @{u}.." work.

>> When those merely following along with this project did "pull &&
>> submodule update", I do not want the submodule directory to check
>> out the commit that happens to be at the tip of their 'master'
>> branch.  If "submodule update" requires an explicit "--remote"
>> option to work in that way, then my worry is allayed, greatly.
>>
>> Thanks.
