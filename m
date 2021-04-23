Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B987C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AF761406
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbhDWJ7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 05:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241184AbhDWJ7w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 05:59:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6F3C06174A
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 02:59:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id g5so66309343ejx.0
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 02:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/2HHxnB0xsKely5D6So3cxr0x/07n/af5YORND0/eRk=;
        b=ZGw1JA2xfzkFjxzxZFqsZa7GpjRaqfBFFHEBt1SLE6CTi6vx5yuKFTq3A3lYYlFX6n
         I2cMt+t/COE/7YWebk6ErTgToOPOrV7DRwvzvZ6GBJr6yTnEuLsqd2PdhXOKOSmGauWD
         HAFphSq49zf2HLxEDRM0RzyKFuWDkY4MhPb1OnxvTHrnS4CUC8UHY2jHGC/1DiniDpLp
         iFuLBd/1q7oJnwDmAzocQIe31NXWKdSgJhJ5Y4qAVixHv7zOWzpePThkWt8Bd4MUrpCe
         Rl3NytGnvW9sWiE/eLwgQ3V3jlfDctEtEc2P7/jv7FYhTATqNiiYDYDwFiw0Dsr6CBEY
         aeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/2HHxnB0xsKely5D6So3cxr0x/07n/af5YORND0/eRk=;
        b=b5CzIZJcBVEAcGgiv0IJo0t4YB1mT3+DRXh9+2NUe+oq3fpf4TbU7KW9H+KN04G2Ie
         Fh+j2n2lVXpVmyKVEBE9EqeRmbljp4xwskuUiz8v6icg97hOmmKCUtM+m66DQRzA3dGH
         OnCs4hRZwoMxUFgy2uFSB+QbBvkauL3vP0F/9UnBNwUrUQyJkUGur32fkJmf+wrXhbgc
         18BnlCU3DRcCO5bjZWqW5F/XH0rm56xUW1ZsKAJRfkMcSi0smrdmeH2oXsY9ug9RSRr9
         czVrTAtEhA1+GiN8x5inR1BdaNFRAeHqGKlLfQxUtVZ8NNN05fL7SdJlmml3ImUJJVpZ
         0e1w==
X-Gm-Message-State: AOAM532qVuvp1MdnsO0RDmMYaQzkpQXtko09qcDXlXMn3xZfP9KS9bDe
        DOZqLn00Bx8ZM01JSE7xwIqLOdy1YVs=
X-Google-Smtp-Source: ABdhPJwEEOai8OtFRuRzLbymhaCDqdKbc4D47WuYSIIivqsU+hlLXaC+RNZC9v9saQWYMOs7/CAAhg==
X-Received: by 2002:a17:906:ae84:: with SMTP id md4mr3347364ejb.432.1619171953890;
        Fri, 23 Apr 2021 02:59:13 -0700 (PDT)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id v8sm3942612edc.30.2021.04.23.02.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 02:59:13 -0700 (PDT)
Subject: Re: [RFC PATCH v2 2/4] t1510-repo-setup: don't use exact matching on
 traces
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20210423001539.4059524-1-emilyshaffer@google.com>
 <20210423001539.4059524-3-emilyshaffer@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c31c30f0-2613-0a12-1025-6043ef5f2962@gmail.com>
Date:   Fri, 23 Apr 2021 10:59:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210423001539.4059524-3-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily

On 23/04/2021 01:15, Emily Shaffer wrote:
> Tests which interrogate the exact underlying behavior of the code under
> test, instead of checking for the presence of desired side effects or
> calls, are a known testing antipattern. They are flaky as they need to
> be updated every time the underlying implementation changes.
> 
> By using 'grep --fixed-strings --file <expect>' instead, we can check
> for the positive presence of lines we are sure should be happening, and
> ignore any additional things which may be happening around us (for
> example, additional child processes which are occurring unrelated to the
> code under test).
 >
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>   t/t1510-repo-setup.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
> index bbfe05b8e4..8bd4f54d03 100755
> --- a/t/t1510-repo-setup.sh
> +++ b/t/t1510-repo-setup.sh
> @@ -63,7 +63,7 @@ test_repo () {
>   		rm -f trace &&
>   		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
>   		grep '^setup: ' trace >result &&
> -		test_cmp expected result
> +		grep -Ff expected result

If there is more than one line in expected (it's not clear from the 
limited context if there is) then grep will succeed if any of the lines 
match rather than requiring all the lines to match as test_cmp does.

Best wishes

Phillip

>   	)
>   }
>   
> 

