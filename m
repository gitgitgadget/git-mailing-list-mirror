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
	by dcvr.yhbt.net (Postfix) with ESMTP id 35DBF1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 15:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403816AbfITPO7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 11:14:59 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38154 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387614AbfITPO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 11:14:59 -0400
Received: by mail-qk1-f193.google.com with SMTP id u186so7665148qkc.5
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oPzr2/H2rf4ZbLl0y9b6PBWMVl/KJVnTaZjHCGA352E=;
        b=u3/oOgtIv1IpUMQMJ3bEII6r8wrdwGvk3w0CoEPzAuCH9OSFMI5fJtTcYETkCP35dh
         Sr2kPZEPI5nqbagGSYGlmpNEe5apqTp/hJoj8kDSOs4Q++TMJxwu97gL6MQ7/2JTQ1SU
         CZw+pv9bl7YC6UupvHgCz52TqdaAFeY88lyfvMOGevzzZ/CDkgoh3VUHZJx43ioI5bRd
         fCUJYaFrk9zoN7J1fG9VSBLa55s5QzH2OVeMx7oWI1mWfUYMRnSOpXGO6I9jUi2Rz9A/
         fqS+ynelrIz9ImNpRVCnWh6mYNV1gNpXbBug172zAFhTXQWfmTwvqRBzv/ElMrXBWQww
         7Ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oPzr2/H2rf4ZbLl0y9b6PBWMVl/KJVnTaZjHCGA352E=;
        b=X9S5nq5YbectNg8yiMFSi4KXx3LtRS8PvYSQtHm8YdBQ7PEzuGnJpfWip8wU3mI4VM
         8tTcyaoYWPFMNl6IFveSm/O8vOVJp41Ltt1sEDLF6Isgzdl0wisSqCJfX1B58kGxhNqu
         IwX9ov28cULJIn4snYpYMlSWm22U9PZoHeNxYpIe/pXE6L59+HTeCRNRrz4ZQWHYBko/
         IiwoxbuY033boWUzPlDCTgqyKuXn7edJuCx9Jc7E+zfHA5SmbzdFEwkTJ+C/ZPMHY4H0
         pGXzPoZPCbQjCjXaWL/oac4un556IrcbDiTwQkIla1lfYCm9Zse0LH1nr5/YpUo+TM31
         K7cg==
X-Gm-Message-State: APjAAAV8BpS0jj4t0OzIrThgp5feMdLLOoD1Ybibc+DWzTGFbLhQteEG
        3ZMrhuKIgkZ5ycFuM6GW7ck3c2XySSY=
X-Google-Smtp-Source: APXvYqyL7SpGaZdSl0NQubpy7gMfAKbwDuL46AVbiqv34rpkTrzefcZ7cuX4zGxcTPKqIZxhK7Id2w==
X-Received: by 2002:a37:7402:: with SMTP id p2mr4255276qkc.457.1568992497780;
        Fri, 20 Sep 2019 08:14:57 -0700 (PDT)
Received: from ?IPv6:2001:4898:4070:37:142:491c:a46c:6a48? ([2001:4898:a800:1010:89d8:491c:a46c:6a48])
        by smtp.gmail.com with ESMTPSA id o38sm1483782qtc.39.2019.09.20.08.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:14:57 -0700 (PDT)
Subject: Re: [PATCH 06/15] t6120: add a test to cover inner conditions in 'git
 name-rev's name_rev()
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-7-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2e18a216-f6f8-2307-2524-a2e1f44b26c7@gmail.com>
Date:   Fri, 20 Sep 2019 11:14:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190919214712.7348-7-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2019 5:47 PM, SZEDER Gábor wrote:
> In 'builtin/name-rev.c' in the name_rev() function there is a loop
> iterating over all parents of the given commit, and the loop body
> looks like this:
> 
>   if (parent_number > 1) {
>     if (generation > 0)
>       // do stuff #1
>     else
>       // do stuff #2
>   } else {
>      // do stuff #3
>   }
> 
> These conditions are not covered properly in the test suite.  As far
> as purely test coverage goes, they are all executed several times over
> in 't6120-describe.sh'.  However, they don't directly influence the
> command's output, because the repository used in that test script
> contains several branches and tags pointing somewhere into the middle
> of the commit DAG, and thus result in a better name for the
> to-be-named commit.  In an early version of this patch series I
> managed to mess up those conditions (every single one of them at
> once!), but the whole test suite still passed successfully.
> 
> So add a new test case that operates on the following history:
> 
>     -----------master
>    /          /
>   A----------M2
>    \        /
>     \---M1-C
>      \ /
>       B
> 
> and names the commit 'B', where:
> 
>   - The merge commit at master makes sure that the 'do stuff #3'
>     affects the final name.
> 
>   - The merge commit M2 make sure that the 'do stuff #1' part
>     affects the final name.
> 
>   - And M1 makes sure that the 'do stuff #2' part affects the final
>     name.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  t/t6120-describe.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 07e6793e84..2a0f2204c4 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -421,4 +421,47 @@ test_expect_success 'describe complains about missing object' '
>  	test_must_fail git describe $ZERO_OID
>  '
>  
> +#   -----------master
> +#  /          /
> +# A----------M2
> +#  \        /
> +#   \---M1-C
> +#    \ /
> +#     B
> +test_expect_success 'test' '
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		echo A >file &&
> +		git add file &&
> +		git commit -m A &&
> +		A=$(git rev-parse HEAD) &&

Is it not enough to do something like test_commit here?

> +
> +		git checkout --detach &&
> +		echo B >file &&
> +		git commit -m B file &&
> +		B=$(git rev-parse HEAD) &&
> +
> +		git checkout $A &&
> +		git merge --no-ff $B &&  # M1
> +
> +		echo C >file &&
> +		git commit -m C file &&
> +
> +		git checkout $A &&
> +		git merge --no-ff HEAD@{1} && # M2
> +
> +		git checkout master &&
> +		git merge --no-ff HEAD@{1} &&
> +
> +		git log --graph --oneline &&
> +
> +		echo "$B master^2^2~1^2" >expect &&
> +		git name-rev $B >actual &&

This matches your description.

Thanks,
-Stolee
 
