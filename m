Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFC3C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 19:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbjDFTvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 15:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238437AbjDFTvb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 15:51:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5159C13D
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 12:51:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id qb20so4017253ejc.6
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 12:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680810689; x=1683402689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4kku/9m65/tIPYh7Li8amFy9MV+pdHNrF6hVB2LNiGg=;
        b=NAhEBl7mtpe8Tj/x6JvzkR/bhUDuZ83/jNb/xZTt8eNqV+3EI9VADvyJIYgooNs5/D
         wxZEfA9cNxqZ5Fz/IYht+C2uosGWpSgc6eIoBf+AlopLgZQbFZoPXyEFGVciuZACGJbW
         9SfCXtQjafsyS4tmpcajBduT4y0tkaoPR3PmLlEOg8Q306Cgmo5BHjIhoQkMy8wqLSfF
         anX0KekwoInbaMI857fIqI4FatOaMtTtc/Mv5DhnxD9IPy/L71KpqXOcANOjTW6y+XPO
         0De2AjEK2f/+FCwfp5ruRH/YPaJo1RlERMbWxpCduj8QaEyawjdOqXVUFBNpnSlWJKts
         kCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680810689; x=1683402689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kku/9m65/tIPYh7Li8amFy9MV+pdHNrF6hVB2LNiGg=;
        b=a8EwZWQqY83HZ2NowE6B5rf5hFouKJGsH5AAVd5/9r2yNWPcWP5J3bMnqfHOf9RjNp
         lzUntvNyO8Y1ioPFe8G1Sde6/U1BMOgxj3JZNWyMcrY8+3Qrm34/ypvkpeVDaaEa6+41
         Jm/5zNxMoCgp0dmRWcwpIhxsv2zJmMzhGbWrcubL0REcGnIOatkBw6PhzrWFIMs9teFn
         CWqOJOiWBuy2jsO7HFkeaYcSf9qbRHY3LbhUwOkVUyCam7f3LmX9eT0TyIPyrNG7s6AD
         BAnGEhhJYcMPu5CSHw8WKPN74WrhAexzxKdNs8l+04/cbH6kiFLqI71cLg3MmX1RA0PW
         HTcg==
X-Gm-Message-State: AAQBX9f/gx/oS9RkVyYqy5+TElx6LpFuHTuE8ATfaeAlJ34w8nmpK9VT
        JrgRnEws8Ti0/Q+k83APDr5J99qmZahl5E8sxGM=
X-Google-Smtp-Source: AKy350avpjWBVxlgrZIz4ZwmzwhOfooEJH8aR72iNOB+ir7p7aK20Y9ox28toUeMxCJFG2eg45IAxw==
X-Received: by 2002:a17:906:46da:b0:949:8772:8195 with SMTP id k26-20020a17090646da00b0094987728195mr47429ejs.38.1680810688634;
        Thu, 06 Apr 2023 12:51:28 -0700 (PDT)
Received: from [10.6.18.184] ([45.88.97.12])
        by smtp.gmail.com with ESMTPSA id sa28-20020a1709076d1c00b00949c04d1c64sm1188368ejc.41.2023.04.06.12.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:51:28 -0700 (PDT)
Message-ID: <abaa6151-0f4d-1aab-2249-a2bdac2bebef@gmail.com>
Date:   Thu, 6 Apr 2023 21:51:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 5/6] t1502: don't create unused files
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=c3=98ystein_Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230403223338.468025-6-rybak.a.v@gmail.com>
 <230406.86cz4htmzz.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <230406.86cz4htmzz.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/04/2023 10:47, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Apr 04 2023, Andrei Rybak wrote:
> 
>> Three tests in file t1502-rev-parse-parseopt.sh use three redirections
>> with invocation of "git rev-parse --parseopt --".  All three tests
>> redirect standard output to file "out" and file "spec" to standard
>> input.  Two of the tests redirect standard output a second time to file
>> "actual", and the third test redirects standard error to file "err".
>> These tests check contents of files "actual" and "err", but don't use
>> the files named "out" for assertions.  The two tests that redirect to
>> standard output twice might also be confusing to the reader.
>>
>> Don't redirect standard output of "git rev-parse" to file "out" in
>> t1502-rev-parse-parseopt.sh to avoid creating unnecessary files.
>>
>> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
>> ---
>>   t/t1502-rev-parse-parseopt.sh | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
>> index de1d48f3ba..dd811b7fb4 100755
>> --- a/t/t1502-rev-parse-parseopt.sh
>> +++ b/t/t1502-rev-parse-parseopt.sh
>> @@ -302,14 +302,14 @@ test_expect_success 'test --parseopt help output: "wrapped" options normal "or:"
>>   	|EOF
>>   	END_EXPECT
>>   
>> -	test_must_fail git rev-parse --parseopt -- -h >out <spec >actual &&
>> +	test_must_fail git rev-parse --parseopt -- -h <spec >actual &&
>>   	test_cmp expect actual
>>   '
>>   
>>   test_expect_success 'test --parseopt invalid opt-spec' '
>>   	test_write_lines x -- "=, x" >spec &&
>>   	echo "fatal: missing opt-spec before option flags" >expect &&
>> -	test_must_fail git rev-parse --parseopt -- >out <spec 2>err &&
>> +	test_must_fail git rev-parse --parseopt -- <spec 2>err &&
>>   	test_cmp expect err
>>   '
>>   
>> @@ -339,7 +339,7 @@ test_expect_success 'test --parseopt help output: multi-line blurb after empty l
>>   	|EOF
>>   	END_EXPECT
>>   
>> -	test_must_fail git rev-parse --parseopt -- -h >out <spec >actual &&
>> +	test_must_fail git rev-parse --parseopt -- -h <spec >actual &&
>>   	test_cmp expect actual
>>   '
> 
> Ditto earlier comments: When we fail, we should assert what we emitted
> on stdout, surely this should also be a "test_must_be_empty out".
> 
> (I didn't test that, but if that fails wes hould be testing whatever it
> is that we emit here, surely..)

This patch is not like the others.  File "out" is indeed empty, because
file "actual" isn't empty.  Redirect to "out" is overwritten by redirect
to "actual".
