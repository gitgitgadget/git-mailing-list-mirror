Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3D6C1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 12:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeFHMsh (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 08:48:37 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37973 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752693AbeFHMsf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 08:48:35 -0400
Received: by mail-qt0-f193.google.com with SMTP id x34-v6so13253531qtk.5
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=h4qaRCcuVFfa1ekZ/oCBHSTEaTpL0TCIJCxkIMf0Ovo=;
        b=XWKO0ElrrzlQmMMyan5VwHmG10j29IQOHGOKyHWY/f/7/Q4rO8jnK3eG0o2iWesZC5
         SW5+JZvqZ/2/SzFQECUBpyt77BCygIIXvlQUDMnvqiouoF0HBSXO8z9V2+tMvdRovxsM
         rGEDjEOgegqczuaRI+a7s8NBZ03wBa+0T4P+CN0M6E48T3Z+9mnGRIAn7IiFNkaW/uVd
         3iRTqJGNtWiZmadUmQWL7M1QFoxg5VMFj/3sEY/6YpQpQh4mCtVnwMU5M1kL0C9bZX2v
         SfclO1HArPo2l9qDKup5jElQ1ogWg3zp0VUV6og+OxFbv1F9vu9hC0/59OBrcop+7wpi
         PNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=h4qaRCcuVFfa1ekZ/oCBHSTEaTpL0TCIJCxkIMf0Ovo=;
        b=s6im8+S/gQAXr2T3x869z6/SM2umpIFmV3VVe+XJ5b4qxTfddk42yvdepR44ICkfLL
         /R3rt+1TvQmpekzWjqn5WNbCqyGZYSq7he6Gua2c0zMdjUu590nSSF1J56Zoq3xe38Ud
         EmN0EgFEZ9NaJLcEoeIJ4Md3jztQyQf3AwACWmdOXGrmjG0m3SJBZqaxXq2nJvIjEzbx
         v35u/HvwSlRF7JiBvMTY9ooXBl3jDm7ak021v1PWgMillsvauR+7JaokPszvYDfjjeAJ
         lK5kCyZi9IJcbZQgtS+na9lSlj0sEBApDfYpdHvmuiTOx/P+vxhmaoR+CNwmpZhAO/7Y
         SaPw==
X-Gm-Message-State: APt69E3iXmhGope0KUElwJ5KHEAwKO3WXdfHgblI1Q/VdDrTRlqulYgf
        1C5WaJPQfvONvLlNqiVxuA0=
X-Google-Smtp-Source: ADUXVKLDDwx9OlcYW6rRXT4drmLee4zhXAXJM9XEbzGSm2Zv+6pe6Ps6ifMW/YF8Ey3KeY3QlxS8iw==
X-Received: by 2002:ac8:35b3:: with SMTP id k48-v6mr5709284qtb.10.1528462115061;
        Fri, 08 Jun 2018 05:48:35 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:5dc2:24cc:4e85:52e? ([2001:4898:8010:0:46f8:24cc:4e85:52e])
        by smtp.gmail.com with ESMTPSA id q77-v6sm25590586qki.73.2018.06.08.05.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 05:48:34 -0700 (PDT)
Subject: Re: [PATCH v5 18/21] commit-graph: use string-list API for input
From:   Derrick Stolee <stolee@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
 <20180606113611.87822-1-dstolee@microsoft.com>
 <20180606113611.87822-19-dstolee@microsoft.com>
 <87h8mgyv0f.fsf@evledraar.gmail.com>
 <aa4c3a93-0c63-f424-db0b-0e451bbaa91e@gmail.com>
 <87efhkyubq.fsf@evledraar.gmail.com>
 <548f9285-da68-478c-1423-a9b9b5021d97@gmail.com>
Message-ID: <4c5982b2-15a0-9172-c115-e78afe0b4daa@gmail.com>
Date:   Fri, 8 Jun 2018 08:48:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <548f9285-da68-478c-1423-a9b9b5021d97@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2018 8:45 AM, Derrick Stolee wrote:
> On 6/6/2018 8:26 AM, Ævar Arnfjörð Bjarmason wrote:
>> On Wed, Jun 06 2018, Derrick Stolee wrote:
>>
>>> On 6/6/2018 8:11 AM, Ævar Arnfjörð Bjarmason wrote:
>>>> On Wed, Jun 06 2018, Derrick Stolee wrote:
>>>>
>>>>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>>>>>
>>>>> +    string_list_clear(&lines, 0);
>>>>>        return 0;
>>>>>    }
>>>> This results in an invalid free() & segfault because you're freeing
>>>> &lines which may not have been allocated by string_list_init().
>>> Good point. Did my tests not catch this? (seems it requires calling
>>> `git commit-graph write` with no `--stdin-packs` or
>>> `--stdin-commits`).
>> Most of your tests (t5318-commit-graph.sh) segfaulted, but presumably
>> you're on a more forgiving compiler/platform/options. I compiled with
>> -O0 -g on clang 4.0.1-8 + Debian testing.
>
> I appreciate the extra platform testing. I'm using GCC on Ubuntu (gcc 
> (Ubuntu 7.3.0-16ubuntu3) 7.3.0).

While the errors didn't repro on my box, they did on the VSTS Linux 
build machines [1]. I created an internal PR just so I could run those 
tests (and on our OSX agents which use clang) and so I can verify I 
fixed the situation. I'll send a v6 soon so Junio only picks up a 
version that succeeds in tests.

Thanks,
-Stolee

[1] 
https://github.com/Microsoft/vsts-agent-docker/blob/master/ubuntu/16.04/standard/Dockerfile
     What's installed on a VSTS Linux build agent
