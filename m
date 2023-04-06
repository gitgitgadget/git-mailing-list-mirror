Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0433EC77B6C
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 21:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjDFVfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDFVfp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 17:35:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972D5C2
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 14:35:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l15so4528037ejq.10
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680816943; x=1683408943;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9hSLKyFUCH/MpQ8FhwgPX74fmuaDhNFOJBfsO8wb6hg=;
        b=g5fN2jNVUkxkrfU9LuQJzHyfNFV2i+bFhM5iU+VP8f47Pf+KZtdLNYa37q2EfUbo56
         PAJw37/CY4ehaGEiqVQnOP42NkEuMS5SNAFiddxeiJxapbUnbVwNxlhY7vyJtcwSNJQk
         tifh+LZqJwOAVuiMx8EY85+1pO4z4c9TaOgTMWM/kESuJ8hayqcopRzYgdAWSP14Jkuh
         NSQZ9AJZxWGKnC4mHiSgSGyYhEdqqV1f2nd0LrC8/6/nO0q1uk5OwZbJvf3ura2PSEC3
         PQGPNHR1QVr/K/UClv08M2AdfAxkoJEZJyx0ceaUG0nQqhSpwnhOwxxW2oLhx/PsxnsH
         FVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680816943; x=1683408943;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hSLKyFUCH/MpQ8FhwgPX74fmuaDhNFOJBfsO8wb6hg=;
        b=DG7ybiLxpkjIZhahymq+Yv81TqhSUYIHFqXC80i9RA23ZFIXylMh3xdhKzF3OHT5UQ
         Vq/xVmpqvr1QQ+/nOWIf12+mOOdgcp/NO1gk6O9+ZVcnriSqNJYg1A0cc2nuEpr0Hezk
         zFOQf+4t8xVXHefbwLEnDwZwJe+7eoVz1CbosdSYp8wr0iqXf//rimQYncSUytqD3RiG
         GUN6U+0h7mhONszJ1g7AbfUol+Q5G5iYMNNuYlg0j3n/wt/zf7TijMheUpVvnMaDA8oG
         XSeLuyPnlixnhLycpCPD2dtlBQDbjgDvKfTX7DoDUeU/Q5he6x8XOxdOfWB+dFtACF+T
         bBOg==
X-Gm-Message-State: AAQBX9d7Pz/oXCILBCaFNN/bipvSiHhMAWfBblNu1nxbx3ZXSBWaJvX8
        iVwvRpSvRF1sZgDSjvcsSrUuff7+nzKz04z2AyM=
X-Google-Smtp-Source: AKy350Y0oB+jWY643iKW/eQl0aUWGbS1CJWBJ+3Ynkmw/ov4HjVR9Tsjl8yxkGhRRWCfsE2dzbQ17g==
X-Received: by 2002:a17:906:498f:b0:949:8f1e:9f1 with SMTP id p15-20020a170906498f00b009498f1e09f1mr290829eju.1.1680816942998;
        Thu, 06 Apr 2023 14:35:42 -0700 (PDT)
Received: from [10.6.18.184] ([45.88.97.12])
        by smtp.gmail.com with ESMTPSA id ke19-20020a17090798f300b009306be6bed7sm1255504ejc.190.2023.04.06.14.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 14:35:42 -0700 (PDT)
Message-ID: <7a5de047-3535-3b87-f023-43c400d57131@gmail.com>
Date:   Thu, 6 Apr 2023 23:35:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: git config tests for "'git config ignores pairs ..." (was Re: [PATCH
 v2 3/6] t1300: don't create unused files)
Content-Language: en-US
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=c3=98ystein_Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230403223338.468025-4-rybak.a.v@gmail.com>
 <230406.86pm8htnfk.gmgdl@evledraar.gmail.com>
 <c43e6b71-075a-e39a-7351-8595e145dacf@gmail.com>
In-Reply-To: <c43e6b71-075a-e39a-7351-8595e145dacf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/04/2023 23:30, Andrei Rybak wrote:
> On 06/04/2023 10:38, Ævar Arnfjörð Bjarmason wrote:
>>
>> Ditto my comment on 1/6, shouldn't we instead be doing e.g.:
>>
>>     diff --git a/t/t1300-config.sh b/t/t1300-config.sh
>>     index 2575279ab84..df2070c2f09 100755
>>     --- a/t/t1300-config.sh
>>     +++ b/t/t1300-config.sh
>>     @@ -1575,7 +1575,8 @@ test_expect_success 'barf on syntax error' '
>>          [section]
>>          key garbage
>>          EOF
>>     -    test_must_fail git config --get section.key >actual 2>error &&
>>     +    test_must_fail git config --get section.key >out 2>error &&
>>     +    test_must_be_empty out &&
>>          test_i18ngrep " line 3 " error
>>      '
>>
>> I.e. before this we had no coverage on the error being the only output,
>> but seemingly by mistake. Let's just assert that, rather than dropping
>> the redirection entirely, no?
> 
> Here, failing invocations of "git config" are tested, and an argument,
> as Junio C Hamano outlined in 
> https://lore.kernel.org/git/xmqqsfe8s56p.fsf@gitster.g/
> for output of failing "git mktree", could be applied here.
> 
> Thinking about it more, such assertions enforcing empty standard output for
> these commands might be helpful if some tools and/or scripts rely on empty
> standard output instead of checking the exit code.  Hyrum's Law applies 
> here,
> I guess.

There are some tests in t/t1300-config.sh that do check that standard output
or standard error is empty.  And I think I stumbled some other broken tests,
while checking those.

Test 'git config ignores pairs without count' checks that standard error
(2>error) is empty.  Just below it, there seems to be a copy-paste error:
there are two tests titled 'git config ignores pairs with zero count'.
First one doesn't check any output, but the second checks standard output,
while calling the file "error" (>error). Test 'git config ignores pairs
with empty count' checks >error as well.

They were all introduced in d8d77153ea (config: allow specifying config entries
via envvar pairs, 2021-01-12) by Patrick Steinhardt.  Patrick, what do you think?
