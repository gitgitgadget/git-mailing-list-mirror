Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9881C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 13:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhLTNh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 08:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhLTNh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 08:37:57 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70712C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 05:37:57 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id d21so9319389qkl.3
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 05:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eFsrVTqHRc7aUeiKZrsZwHNlUUaqlJhxFGudNEBzZ9I=;
        b=TsKDlAAMWGJ9arCkxZzZ9XHoqj8OhpfMZXJ3Hdu+XckHO2wlscAiHEc9xxHOfSj4U/
         s/gJzWNv38sxG0M6Mw3hiq4FXrlz41jR0/B6zvb2gKuPvWrbQ8JFIhV6SYkseKGjFGFU
         ktodbmdpHE8pMi98fedZr7e+U9UQbuA9uwCeaItxfzwWJ4ucbX2nNYY/d2/+v8jvUfSa
         N4vTJocwUJ6ONqp8EmaxMCeRPMcnORdeuRJmok/DMaVTwo+hyuYBYhcIy/9kp/a2R6uo
         0DLtcSTND+x8oHBl4w9pjtZYDY58AofkepTPI7naMcJOqMbnaLufNgV/DizP4V3FCCWy
         pi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eFsrVTqHRc7aUeiKZrsZwHNlUUaqlJhxFGudNEBzZ9I=;
        b=HfP5yAQRfucpXl0dhs5agvQbKza8X2MdM0kc+CFPScyKFcMtnYL9+jCTB7s3YCJX5E
         1gPoribjUC0O0jkaFSU0DItp4EPCXXajb6KFh52u/Yn/za2NuqExx4eMzeUOWyRm5Dzk
         ZW2DMVBgTbo8cFMXZzR+6V/3fqeR0ZLmwkLUFDpU4WhyyJc+ouxv+nc4L2Cj9XnzYztr
         JqRMzXSfXQN7ueOj2K5hcCbGfFxLSW3jr/znFQ54hmttK4UVBiIBmIMVfhPG63fKvVq2
         DwwM26i/qTZ3xkkPYeDvlYynWZx+ECu8/XS+/q9WQExxeyH1akr5WcK1e/W0cY2c8+Qb
         ZGtA==
X-Gm-Message-State: AOAM5306svB3CBImYCdcYoVZYkrwrFToXYNXnBR7xA1rpNoAFmw8Zd6P
        C5thaT4EmwbKsu+umRRI/1g=
X-Google-Smtp-Source: ABdhPJyKBd3whlI7WEPq5t9Laat7SvCyO/TioVSyU6VhECjSjrI0JD+m8dNrX2lVajd48Eom6zu11Q==
X-Received: by 2002:a05:620a:208c:: with SMTP id e12mr2642763qka.445.1640007476440;
        Mon, 20 Dec 2021 05:37:56 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id y73sm10916045qkb.113.2021.12.20.05.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 05:37:55 -0800 (PST)
Message-ID: <7969c9e5-dd57-705c-b554-67681b9af62f@gmail.com>
Date:   Mon, 20 Dec 2021 08:37:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] repack: make '--quiet' disable progress
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
 <3eff83d9ae14023f3527dfeb419cf8259f6d053d.1639758526.git.gitgitgadget@gmail.com>
 <YbzSfwQixuonrK/o@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YbzSfwQixuonrK/o@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/17/2021 1:10 PM, Jeff King wrote:
> On Fri, Dec 17, 2021 at 04:28:46PM +0000, Derrick Stolee via GitGitGadget wrote:

>> This is difficult to test because the isatty(2) already prevents the
>> progess indicators from appearing when we redirect stderr to a file.
> 
> You'd need test_terminal. Something like this:
> 
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 8c4ba6500b..b673c49650 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -5,6 +5,7 @@ test_description='git repack works correctly'
>  . ./test-lib.sh
>  . "${TEST_DIRECTORY}/lib-bitmap.sh"
>  . "${TEST_DIRECTORY}/lib-midx.sh"
> +. "${TEST_DIRECTORY}/lib-terminal.sh"
>  
>  commit_and_pack () {
>  	test_commit "$@" 1>&2 &&
> @@ -387,4 +388,10 @@ test_expect_success '--write-midx -b packs non-kept objects' '
>  	)
>  '
>  
> +test_expect_success TTY '--quiet disables progress' '
> +	test_terminal env GIT_PROGRESS_DELAY=0 \
> +		git -C midx repack -ad --quiet --write-midx 2>stderr &&
> +	test_must_be_empty stderr
> +'
> +
>  test_done

Thanks. I added this test.

When first running the test, it failed because I didn't have the
IO::Pty Perl module installed. I'm not sure why I don't fail with
other tests that use test_terminal. If someone knows more about
what is going on, then maybe we need to expand the TTY prereq?

Thanks,
-Stolee

