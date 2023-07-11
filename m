Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58343EB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 20:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGKUrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 16:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjGKUrX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 16:47:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5959B
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 13:47:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso3615766b3a.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1689108440; x=1691700440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rUjroZOQJmqnVDjATjgnvKZlL+nrTdKWNFCg07K4K9Y=;
        b=Lu4oo5sAZkzHiGbLU8xSVg6e9vtjnteVZzHoNitVIiK0bTZgO5HcIeTjIyOP7v01Xk
         zhhJICtd6zjCntkCFeqFWD6xtoy41GJ8R1vuRWqXfjIYrSowG9hnMBwMz45xvvdhCZWh
         lna9tLEeVP0uTzHvUVKTPqewtcZBdXLJYzwWgqtJr5QoApXa1HKSnYAepIU88xkVvkRq
         f+wjnqBfDOUA9Q5d35NaHqvYQS7ne8FzkFGCs9YTbgo95HU5IGpP3y2Q5NfA+EM7khbG
         YCR0r7R2LnmklhrHmBtCW1UHShwxrOPRppJBWx0nxZ6sFFKLfxSUtdaFt7F6W4UtTwXK
         rREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689108440; x=1691700440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUjroZOQJmqnVDjATjgnvKZlL+nrTdKWNFCg07K4K9Y=;
        b=bRUcf9YiBTd4Rj3jMwucb8e5PxWyqY/hSG1CZp2cyPBfWN36yduS5Y+TJiLBq9hIFg
         fGi7kELRBwcW/WtXppWXziP/BgT2bKDAc+AuMF1Eci0G8MDWfN0o++PqxGUxs5Jke0Oj
         B3z26MDYJhkDIOugbb23lWaQS/thfQriDOKJ68RzuQES2mGzx4EyTHs8auxpZvq4VG+B
         dzG8+yBkbcg3JQNxssBZsYFTMMKN9WCWVNMNUdkZZU2CuV5XKic0hKYbkmHTea+FGAP7
         bKT23u2J5qWaunPzO06xSPxhxV28rRc/ieMNulfoL4cItnOg81wLWf+DkP+zVfHWVFJl
         u9Eg==
X-Gm-Message-State: ABy/qLZeNdaeHchbnH6042UAns8G34nTEsKJMZbOPTlmPATpspwvWb29
        ND8e3aY24lVqiQ+x9a75vjsd
X-Google-Smtp-Source: APBJJlGLk6MvOHLDZzxu1h4MBKAkoGTqVN58u+BiXMhRMAbRv0RYV1gt4JVfvX3zDLv7OWBGCXpY7Q==
X-Received: by 2002:a05:6a20:7343:b0:12f:7a6b:63d2 with SMTP id v3-20020a056a20734300b0012f7a6b63d2mr15926873pzc.6.1689108440160;
        Tue, 11 Jul 2023 13:47:20 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001b7ffca7dbcsm2353443plt.148.2023.07.11.13.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 13:47:19 -0700 (PDT)
Message-ID: <959d9ee6-b2b6-3a2f-c597-856bdaef077b@github.com>
Date:   Tue, 11 Jul 2023 13:47:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/3] t1092: add tests for `git check-attr`
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20230707151839.504494-1-cheskaqiqi@gmail.com>
 <20230711133035.16916-1-cheskaqiqi@gmail.com>
 <20230711133035.16916-3-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230711133035.16916-3-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Add smudge/clean filters in .gitattributes files inside the affected
> sparse directories in test 'merge with conflict outside cone', make sure
> it behaves as expected when path is outside of sparse-checkout.
> 
> Add tests for `git check-attr`, make sure it behaves as expected when
> path is both inside or outside of sparse-checkout definition.
> 
> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 40 ++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 8a95adf4b5..839e08d8dd 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1006,6 +1006,17 @@ test_expect_success 'merge with conflict outside cone' '
>  
>  	test_all_match git checkout -b merge-tip merge-left &&
>  	test_all_match git status --porcelain=v2 &&
> +
> +	echo "a filter=rot13" >>.gitattributes &&
> +	run_on_sparse mkdir folder1 &&
> +	run_on_all cp ../.gitattributes ./folder1 &&
> +	git -C full-checkout add folder1/.gitattributes &&
> +	run_on_sparse git add --sparse folder1/.gitattributes &&
> +	run_on_all git commit -m "add .gitattributes" &&
> +	test_sparse_match git sparse-checkout reapply &&
> +	git config filter.rot13.clean "tr 'A-Za-z' 'N-ZA-Mn-za-m'" &&
> +	git config filter.rot13.smudge "tr 'A-Za-z' 'N-ZA-Mn-za-m'" &&
> +

In general, we try to add tests demonstrating behavior in context with the
implementation of that behavior. Patch 1 [1] contains the update to
attribute reading that's being tested here, so this block should be moved
there accordingly.

Also, does this test fail before patch 1 but succeed after? It's a bit
difficult to tell how this demonstrates that the in-sparse-directory
`.gitattributes` is applied properly now but wasn't before. An
additional comment in the test or commit message would be helpful for
understanding it better.

[1] https://lore.kernel.org/git/20230711133035.16916-2-cheskaqiqi@gmail.com/

>  	test_all_match test_must_fail git merge -m merge merge-right &&
>  	test_all_match git status --porcelain=v2 &&
>  
