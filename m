Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDEAC10F1B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 16:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiL0Qo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 11:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiL0Qo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 11:44:28 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF9E1D6
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 08:44:26 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso9712407wmo.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 08:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t/sbW+o9prrlEAmPzzN3Cfir/RTV0Vm5JgavANJcvfU=;
        b=feKsNjqAO6MFOGpiE/uR9eZGdSnkrPnxCSEbS8K6Y8sDWuT1gc1uZ0WXgJjb8n5tKg
         3fm1XhDV5ldOV68D+JoqOkperZqE3LF17wSfkVbP/JyjasoZw2i1dopdDF/IJWVBBmOb
         axNIWmqcAm/UN1j10ZPuzMYhzmUSRjUNgZ1gjK2EfhX4urwcvQi2ujm7R1LlqiatmUX2
         mnyXLlhBu6XDGp8TT9QqQG6bDNqS3hODCqpHgRfZW6XYnkXFPol4tl8JPt7yA7/dziPW
         BJ7f7zSV1dvCcWK4XmaVwMbPJvmjm9SQsiqs9dCMokwO0bMDwFa66KLmOmihfMb8wEZ3
         REnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/sbW+o9prrlEAmPzzN3Cfir/RTV0Vm5JgavANJcvfU=;
        b=oAjV30jH8QTRGHuIPFV1S9AKmJoVa82Enw0q9TTwJD6QTPFsA/wpMpqFmz3R/0AYZS
         35p9dnN26nsFgBfTRMlUwsOjyeyra+kW5VTupOWcrt3Le+nY+uxJwOitiYCMa3NGT29+
         9DhqWPbDhQs+3IabaKAKhziMBFL4GLNgIkbXlsRrHWrLzaGpXtshqE01vUu0V9s2ScGT
         /guE69h7Twp1g1UhEnLs95XXUc/inagw9rAK33f+HC54vkJr03B76rdyFMxjq85+qLox
         V89oiD4rWzVKCGT9zbbUgKfhMIv5uUmakoEQCwU10+c6L0gYZKSViBvlZLxvloHYXO23
         5wXg==
X-Gm-Message-State: AFqh2krQLKIpI41scqSUZJvnwcfakFc7h9fsPyimLKzhwgJ+YBnqkGjt
        3Xgzpi1C3JXjJ7XudVfDmqwr/5R/Urg=
X-Google-Smtp-Source: AMrXdXvBzmZ3k+bByBXmecF6mRewf4Yg3j03T6EL2reA1Ck9F0ZzeaVz25a0f2QRhqIS5V5upMIgBg==
X-Received: by 2002:a05:600c:1e10:b0:3d1:f496:e25f with SMTP id ay16-20020a05600c1e1000b003d1f496e25fmr16658906wmb.16.1672159465252;
        Tue, 27 Dec 2022 08:44:25 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id j10-20020adff54a000000b002420d51e581sm13224116wrp.67.2022.12.27.08.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 08:44:24 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <0825da46-b659-d18c-6e65-ced6ce85bd29@dunelm.org.uk>
Date:   Tue, 27 Dec 2022 16:44:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 5/6] tests: don't lose "git" exit codes in "! ( git ...
 | grep )"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
 <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
 <patch-v4-5.6-9596702978e-20221219T101240Z-avarab@gmail.com>
In-Reply-To: <patch-v4-5.6-9596702978e-20221219T101240Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 19/12/2022 10:19, Ævar Arnfjörð Bjarmason wrote:
> Change tests that would lose the "git" exit code via a negation
> pattern to:
> 
> - In the case of "t0055-beyond-symlinks.sh" compare against the
>    expected output instead.
> 
>    We could use the same pattern as in the "t3700-add.sh" below, doing
>    so would have the advantage that if we added an earlier test we
>    wouldn't need to adjust the "expect" output.
> 
>    But as "t0055-beyond-symlinks.sh" is a small and focused test (less
>    than 40 lines in total) let's use "test_cmp" instead.
> 
> - For "t3700-add.sh" use "sed -n" to print the expected "bad" part,
>    and use "test_must_be_empty" to assert that it's not there. If we used
>    "grep" we'd get a non-zero exit code.
> 
>    We could use "test_expect_code 1 grep", but this is more consistent
>    with existing patterns in the test suite.

It seems strange to use sed here, you could just keep using grep and 
check the output is empty if you don't want to use test_expect_code. 
There is also no need to redirect the input of the sed commands.

Best Wishes

Phillip

>    We can also remove a repeated invocation of "git ls-files" for the
>    last test that's being modified in that file, and search the
>    existing "files" output instead.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   t/t0055-beyond-symlinks.sh | 14 ++++++++++++--
>   t/t3700-add.sh             | 18 +++++++++++++-----
>   2 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/t/t0055-beyond-symlinks.sh b/t/t0055-beyond-symlinks.sh
> index 6bada370225..c3eb1158ef9 100755
> --- a/t/t0055-beyond-symlinks.sh
> +++ b/t/t0055-beyond-symlinks.sh
> @@ -15,12 +15,22 @@ test_expect_success SYMLINKS setup '
>   
>   test_expect_success SYMLINKS 'update-index --add beyond symlinks' '
>   	test_must_fail git update-index --add c/d &&
> -	! ( git ls-files | grep c/d )
> +	cat >expect <<-\EOF &&
> +	a
> +	b/d
> +	EOF
> +	git ls-files >actual &&
> +	test_cmp expect actual
>   '
>   
>   test_expect_success SYMLINKS 'add beyond symlinks' '
>   	test_must_fail git add c/d &&
> -	! ( git ls-files | grep c/d )
> +	cat >expect <<-\EOF &&
> +	a
> +	b/d
> +	EOF
> +	git ls-files >actual &&
> +	test_cmp expect actual
>   '
>   
>   test_done
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 51afbd7b24a..82dd768944f 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -106,24 +106,32 @@ test_expect_success '.gitignore test setup' '
>   
>   test_expect_success '.gitignore is honored' '
>   	git add . &&
> -	! (git ls-files | grep "\\.ig")
> +	git ls-files >files &&
> +	sed -n "/\\.ig/p" <files >actual &&
> +	test_must_be_empty actual
>   '
>   
>   test_expect_success 'error out when attempting to add ignored ones without -f' '
>   	test_must_fail git add a.?? &&
> -	! (git ls-files | grep "\\.ig")
> +	git ls-files >files &&
> +	sed -n "/\\.ig/p" <files >actual &&
> +	test_must_be_empty actual
>   '
>   
>   test_expect_success 'error out when attempting to add ignored ones without -f' '
>   	test_must_fail git add d.?? &&
> -	! (git ls-files | grep "\\.ig")
> +	git ls-files >files &&
> +	sed -n "/\\.ig/p" <files >actual &&
> +	test_must_be_empty actual
>   '
>   
>   test_expect_success 'error out when attempting to add ignored ones but add others' '
>   	touch a.if &&
>   	test_must_fail git add a.?? &&
> -	! (git ls-files | grep "\\.ig") &&
> -	(git ls-files | grep a.if)
> +	git ls-files >files &&
> +	sed -n "/\\.ig/p" <files >actual &&
> +	test_must_be_empty actual &&
> +	grep a.if files
>   '
>   
>   test_expect_success 'add ignored ones with -f' '
