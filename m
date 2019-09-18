Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF74B1F463
	for <e@80x24.org>; Wed, 18 Sep 2019 12:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfIRM0o (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 08:26:44 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45707 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfIRM0o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 08:26:44 -0400
Received: by mail-qk1-f195.google.com with SMTP id z67so7732507qkb.12
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 05:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x0hjiNP0e6T1FrZCKx8TKybreKzQdXxTDVkWmZxaQl8=;
        b=EpKtkuQntt1v5F8Zq2JtdnIGBy2MInfrz+j5GBYOCp+W0bXhazxbg7Yw86kXubz2Pg
         R4eNJCxHn3Hb24J8djbjm0/lmIjgH0gqYnH0x9OIzCPKOueb8OzaZ/w5t4NYI8848kPK
         6INg7aWMUNIe3aqrBoJD4fvB8ByD0aVQcbLYCbjcHpuVXttm7ieJ2L1tboPKAazfn2sf
         gBJOGobpPsENCiQUclgAuqvfPS1yUyAVA1z/HBGgpdNvlSiK64pD24Gc6RQCox1DWgMK
         xfUzDNrk5MKW3gStP+/IcGS/3ipOjZFm/7TuZbJHeQDFssw/pwMfKCgCcRlB11LYPwg9
         I+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x0hjiNP0e6T1FrZCKx8TKybreKzQdXxTDVkWmZxaQl8=;
        b=qxrfB7gcCfzxksPg+Rs0r25nIQXv4+UalQSEyEWIqO8g+t1+U1RXGlr/LKViTIlf0N
         GdmDWXmxKy8UvtF7zJvOrJerJiQipBn+Qd6+/0+wU+rTAszJI195GeOpgVOXv3vDyIi8
         KTxFHoIq8HV7WOAi57+K0apgB5C5xETUsOMVDKIT4uxXJcJE/OpmTBpLN0kry30bMtPO
         9ZbX+5QQ4iQW/Pr/LxOpyyvlyrfqYBCgZU2AM0cv8hNWmfokUKXD69ylKL0Q4n/MKY9I
         jgmPX6/SXR6IFnnMBN68vJTxBA9JhpaOVUxJXLizR0ogcdD9LeLVbxm50eNT0wG2p2AA
         T8vw==
X-Gm-Message-State: APjAAAV/+rpzLe6k6nf1di04y0EV5N3ctRJu5YkrIxTcBA/mjp+iSyPx
        HeswzJ25GQTDtCTJ90R/QXQXCsqKpdE=
X-Google-Smtp-Source: APXvYqzu/80NYZ+mevcLvm2nS5m2BwWmGT9QwJskE8XIhjUR0nKO+mSgurh8ck/DcaCtnt8+UTmDYA==
X-Received: by 2002:a37:76c3:: with SMTP id r186mr3744373qkc.224.1568809603402;
        Wed, 18 Sep 2019 05:26:43 -0700 (PDT)
Received: from [10.0.1.21] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id q8sm3030057qtj.76.2019.09.18.05.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 05:26:42 -0700 (PDT)
Subject: Re: [RFC/PATCH] commit-graph: generation v5 (backward compatible date
 ceiling)
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
 <20190518015005.GA951@szeder.dev>
 <20190518035828.pjaqfrkkvldhri6v@glandium.org>
 <20190518041706.ct6ie5trvxgdhjar@glandium.org>
 <f14799c3-e343-eb41-3536-65de7e38fbd9@gmail.com> <86mujhpewj.fsf@gmail.com>
 <cfa2c367-5cd7-add5-0293-caa75b103f34@gmail.com> <86ftp9p7i8.fsf@gmail.com>
 <86mui63xwr.fsf@gmail.com> <55fad895-2c18-5a91-79b9-7b958fe280c6@gmail.com>
 <86o8ziatb2.fsf_-_@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8fba9eb7-934f-9b4e-f898-bab099b95ede@gmail.com>
Date:   Wed, 18 Sep 2019 08:26:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <86o8ziatb2.fsf_-_@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/18/2019 4:43 AM, Jakub Narebski wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>> On 6/25/2019 3:51 AM, Jakub Narebski wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>> Derrick Stolee <stolee@gmail.com> writes:
> [...]
>>>> O.K., so the "generation number v2 (legacy)" would be incremental and
>>>> backward-compatibile in use (though not in generation and validation).
> [...]
>>>> Do you have benchmark for this "monotonically offset corrected commit
>>>> date" generation number in https://github.com/derrickstolee/git/commits/reach-perf
>>>> and https://github.com/derrickstolee/gen-test ?
>>>
>>> I guess this will have to wait...
>>
>> I have not had time to revisit this topic and re-run performance
>> numbers, sorry.
> 
> I have created pull requests against `reach-perf` branch of
> derrickstolee/git repository[1], and companion pull request against
> gen-test repository[2] with proposed prototype of backward-compatible
> corrected commit date (with monotonic offsets).
> 
> Could you please run the tests for this generation number v5?

I'll try to get to this, but it may take a few days.

> I was not
> able to do so.  It was my first time trying to compile Git on MS
> Windows, and while there were no problems compiling `master` (well,
> except for compilation taking a long time), I was unable to do it for
> `reach-perf` branch because of independent of change compilation errors.

I don't think I tested this on Windows. I do most of my performance tests
in Linux, especially when presenting numbers to the mailing list. The
gen-test repo has a bunch of shell scripts that I used for testing in
that environment.

Thanks,
-Stolee
