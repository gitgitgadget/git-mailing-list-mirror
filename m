Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A1A7201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932291AbdEKUkp (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:40:45 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36288 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932165AbdEKUko (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:40:44 -0400
Received: by mail-pf0-f176.google.com with SMTP id m17so19247572pfg.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QLu0U9CXjj/Gfk1kknrA0Fryc4gDBDTqIKzOpqYbfSs=;
        b=OvU1eEI04vTJ/u0tlYGDKV5mHCr+dTPeujgmoxRjEmHaDdbvXJTA5Slij41qpBjmgD
         EUC4ObaEdoW5p7s4IYSozQfNVSP7yH/TkvBgiFi03n6rx6SZPJVFyogJSoyzvJaZCRmM
         qNCz9yUBqWdDDVEbWBW0ygamsoD9S8gbWaJvwRS5hdIiX0FgGYnm4wacWRSI0vp3VOku
         1ob4cB3YDgWGDhHkqOyVbLAg81/zXueDhZdJYPygiM6HSl52xwgFl4qsG6HjPNd47L7/
         Fxqn1JXfHFesHR5bCbmd1ok0c/kLFtG1vqshz75ZWy6VgCDqBOeCKiP1VPCwiKtGcnIi
         u8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QLu0U9CXjj/Gfk1kknrA0Fryc4gDBDTqIKzOpqYbfSs=;
        b=j9thLy7fvN4MEMK4wKsm52G/NmolKqFvxA01a5ut0KYa35DcXZRlt4Pius7DX93vcC
         VSKr81KEHGvzs5u1+VjhTTqsxcoVKJitxCAfUppPXAOJH3OK4Q4Y9tP/3MRqOK/fkVx5
         Afox3DgPNY+qmML0M9Zi3i0VFZQUXuOKnj95cfOx0YA+WY+vpcqr1c2QN+lBfQ4hAM71
         gxX6nSqO+YiOaKuvali5f6xv1B6MBbmTqsL+4kJQI1zZvCJ8Ofq+73BCZ5yYxe8OJpoN
         /ZXor/IWRG4md36qsAXdhk2P/DI2XWRNNVOLrejGFcwb5CrG9lLKWf1gwOYavXv/Jwq7
         xe8w==
X-Gm-Message-State: AODbwcB2nJm6F5e0hMIRKTj78J+HrmuFq8+WMVVBx3aw2ETlfsso37O+
        SWy/4vbLFNo4+uRnD5hA1h6sSNR5AD3U
X-Received: by 10.98.30.3 with SMTP id e3mr471113pfe.48.1494535243445; Thu, 11
 May 2017 13:40:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 11 May 2017 13:40:43 -0700 (PDT)
In-Reply-To: <20170511200804.GF83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com> <20170511091829.5634-19-avarab@gmail.com>
 <20170511200804.GF83655@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 11 May 2017 13:40:43 -0700
Message-ID: <CAGZ79kb_ueU8hArtA3yvYywvawnuD0RGQBtm1=OEuQi2L0rjmA@mail.gmail.com>
Subject: Re: [PATCH 18/29] grep: catch a missing enum in switch statement
To:     Brandon Williams <bmwill@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 1:08 PM, Brandon Williams <bmwill@google.com> wrote=
:
> On 05/11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Add a die(...) to a default case for the switch statement selecting
>> between grep pattern types under --recurse-submodules.
>>
>> Normally this would be caught by -Wswitch, but the grep_pattern_type
>> type is converted to int by going through parse_options(). Changing
>> the argument type passed to compile_submodule_options() won't work,
>> the value will just get coerced.
>>
>> Thus catching this at runtime is the least worst option. This won't
>> ever trigger in practice, but if a new pattern type were to be added
>> this catches an otherwise silent bug during development.
>>
>> See commit 0281e487fd ("grep: optionally recurse into submodules",
>> 2016-12-16) for the initial addition of this code.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/grep.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 3ffb5b4e81..1c0adb30f3 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -495,6 +495,12 @@ static void compile_submodule_options(const struct =
grep_opt *opt,
>>               break;
>>       case GREP_PATTERN_TYPE_UNSPECIFIED:
>>               break;
>> +     default:
>> +             /*
>> +              * -Wswitch doesn't catch this due to casting &
>> +              * -Wswitch-default is too noisy.
>> +              */
>> +             die("BUG: Added a new grep pattern type without updating s=
witch statement");

I am not sure if the comment is of enough value for the used screen
real estate value.
People interested in the existence of the default would just use
blame/log to find out.

Thanks,
Stefan
