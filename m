Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E859C433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 16:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378728AbiD2QQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 12:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbiD2QQD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 12:16:03 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0418FCC504
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 09:12:44 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id y63so8991064oia.7
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AAbwiyWRv0u2mJ0fDuYE5NxTuE9C76TgZpKxgUyHF1Q=;
        b=JXxwOLjyc/zkcZlTFYhZHyLj7yUKGLR2SEKdjV55tCja6KRVKBo1Gv0kS1Nx8F4UJg
         W/E3PBg/WLX4oEjpg+tDDmyDR1qbYNwqkJ2jOMuEvLTRY88s0wfl0IPxOBack+mKl3kr
         sNX21/QO7p80BUBkNwJtmn1/O+IK8JxvJJWgyBHJSICJ4c19crHiRHdt30TsXyQSpgsL
         yy2fslD4jovAHYjU4uB2dvFrE19943kHxAolwG0gfcXXbsO2RObeH2Yd8+cWwnJKorUz
         x5Rq55+lqwRtNItO8HBN/Gz45RGOMGeSipfOnMd9nyWF9X1pmrgj+cc9UuGFThP1kTFy
         QtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AAbwiyWRv0u2mJ0fDuYE5NxTuE9C76TgZpKxgUyHF1Q=;
        b=CBVgxBTW4+4kEQ+Ur+tYJE5bGakhxpp8+iU6yAhXp7tOFK0lIVqbnl5qep+honemFw
         mdFavVjTuTEdUWNOYW1g6V3A+RGNRTTODe0+Ug+iduTYAuN7iKup3ptyFEG0YZ+vfgUA
         trsfyps7JrA6A94D6wvuH8QxWzvyC9Ke/YuoMrSQ1FHYsIiv7EJtgRvsiYr7LnLwpAaq
         zoFzpyB9vVhUFoPaAZVhoKRbSdqZaak4jbSw1lCr1jQjuNN/CwkM+YOvv2Fhh/z42UMO
         92qFwAxfWsA1IAn/NrBN/78/CGJ5eMOInydyEiQfDNp9A4qiHnBQ1cAfNyiovlyba0hO
         u1HQ==
X-Gm-Message-State: AOAM532AOi5vg1eSU4jZqn+/COdR+MciNZBa7lecojdAlTpdgTM2ll0r
        XFIErHsHqOUN3AkbGlR3mJW1+V2Q0E32
X-Google-Smtp-Source: ABdhPJxUQ8Djc8tTolaCbmY7/JGNqit3yMV+wY+yJ35awv0scbwlsK1V+T2WpDpHojiEeboP2QalLw==
X-Received: by 2002:a54:4398:0:b0:325:6312:1520 with SMTP id u24-20020a544398000000b0032563121520mr1860753oiv.53.1651248763320;
        Fri, 29 Apr 2022 09:12:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:20e7:8cbb:83bb:177d? ([2600:1700:e72:80a0:20e7:8cbb:83bb:177d])
        by smtp.gmail.com with ESMTPSA id z21-20020a056871039500b000e686d13876sm3131099oaf.16.2022.04.29.09.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 09:12:42 -0700 (PDT)
Message-ID: <a44b4f0e-038c-9bcd-80d6-f53c87bd7f2d@github.com>
Date:   Fri, 29 Apr 2022 12:12:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] t0033-safe-directory: check when 'safe.directory' is
 ignored
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
 <20220427170649.4949-3-szeder.dev@gmail.com> <xmqqr15il0uo.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqr15il0uo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/27/2022 4:37 PM, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>> According to the documentation 'safe.directory' "is only respected
>> when specified in a system or global config, not when it is specified
>> in a repository config or via the command line option -c
>> safe.directory=<path>".
>>
>> Add tests to check that 'safe.directory' in the repository config or
>> on the command line is indeed ignored.
>>
>> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
>> ---
>>  t/t0033-safe-directory.sh | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
>> index 6f9680e8b0..82dac0eb93 100755
>> --- a/t/t0033-safe-directory.sh
>> +++ b/t/t0033-safe-directory.sh
>> @@ -16,6 +16,19 @@ test_expect_success 'safe.directory is not set' '
>>  	expect_rejected_dir
>>  '
>>  
>> +test_expect_success 'ignoring safe.directory on the command line' '
>> +	test_must_fail git -c safe.directory="$(pwd)" status 2>err &&
>> +	grep "unsafe repository" err
>> +'
>> +
>> +test_expect_success 'ignoring safe.directory in repo config' '
>> +	(
>> +		unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
>> +		git config safe.directory "$(pwd)"
>> +	) &&
>> +	expect_rejected_dir
>> +'
> 
> I am debating myself if we want to remove the in-repository
> safe.directory configuration setting after this test piece is done,
> with test_when_finished.  We just made sure, with this test, that
> having the variable does not affect anything, so the subsequent
> tests should not care hence it is probably OK.  On the other hand,
> to make sure those settings they make (e.g. setting it globally is
> what the next test we can see below does) is what affects their
> outcome, it removes one more thing we need to worry about if we
> clean after ourselves.  I dunno.

test_config would do the same, right? I think it automatically
does the test_when_finished for us.

Thanks,
-Stolee
