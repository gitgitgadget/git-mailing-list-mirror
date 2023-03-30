Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951A3C6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 16:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjC3QYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 12:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjC3QYS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 12:24:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDF3BDFF
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 09:24:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id ja10so18572642plb.5
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 09:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1680193455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zSJ+1bQt5x1oJSQ3Dk2m1EBu7wtCMn/XnH+F/PLdzz4=;
        b=hKoB01VgReb22uWLD5iF1bgROz03j+8d/dij2QxSwsR+6xW3Q0GRpKwLIYOZg29fhG
         V28ttgU9nBu78JDTMTv/fCymjrRCXvc8aA2sLSYcQQzmDwKITFSSNIlVxiCE0iBAvAxO
         tftqSCshVpZvrPc6tVDjzGry2iHG/XxyaraLQJTMe7CtGq50G/To6jncVeRzO40L/zZE
         uKiBPHVyMQVqVGtXVPePaHmwky26f2sClV175GUbUBa21iIlRPph3IeamQj/oUtvlAgF
         bBLqOeGhivNkmLRVHdP8QZ/d3mjMJTmfEgv8vI1AfpNLe/IW11vwpHysop/xaD5fpcai
         1bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680193455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSJ+1bQt5x1oJSQ3Dk2m1EBu7wtCMn/XnH+F/PLdzz4=;
        b=q8OQoxAfeSsEs6e1VDZPnY3a5M+8U6nnuM9GYJgbVXkChalRF0+Cf9cLShllfFgByI
         b6zEgKpGVGTnT81EGS0w4IWQppEHhJzMKSrsP9ui0FQESMFui4C2nt6XoODubQF6x1h3
         6UQmIWVlZQ+o2IxMh1/366sEn73H0Yr9SnamkcoFCHfA1NzkkywEi+/6qbVVZimD1ZUV
         mhavsF2sx1yOp4K7RzFbrpc7A5s9LOHOAz9u2OIFw8CjjmJk503GphDUeY0B8qKP6Z11
         /EKuUWBSTYycawio9fqQUnsdxsicdeic895yb9aKM57sjA/VG/SfTcAt78NJ52Wwd2DS
         b6pw==
X-Gm-Message-State: AAQBX9ca+NxW4KEr3FcJRYZWKU2EwhdQFG9kaF++RL+V+/MMdi7tNTOs
        U6Uim/GjBOpQEi3KRi/ZMjcW
X-Google-Smtp-Source: AKy350Zp0096PmYbivuXOPSKeLFfB3ilaK7YW1Q9iwEp7p4g9a1d5lLrV2pQFJyOf/6hLsXUe/Xjsw==
X-Received: by 2002:a17:90b:370c:b0:237:a500:eca6 with SMTP id mg12-20020a17090b370c00b00237a500eca6mr7030758pjb.22.1680193454793;
        Thu, 30 Mar 2023 09:24:14 -0700 (PDT)
Received: from [192.168.50.41] ([172.91.184.234])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090a7b8600b0023acdac248dsm3437335pjc.15.2023.03.30.09.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:23:48 -0700 (PDT)
Message-ID: <4f2fda36-111d-5bac-2322-1ebb3e508e4d@github.com>
Date:   Thu, 30 Mar 2023 09:23:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v3] describe: enable sparse index for describe
Content-Language: en-US
To:     Raghul Nanth A via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Raghul Nanth A <nanth.raghul@gmail.com>
References: <pull.1480.v2.git.git.1680107154078.gitgitgadget@gmail.com>
 <pull.1480.v3.git.git.1680155957146.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1480.v3.git.git.1680155957146.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raghul Nanth A via GitGitGadget wrote:
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 801919009e1..8bc35c51426 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1514,6 +1514,24 @@ test_expect_success 'sparse-index is not expanded: stash' '
>  	ensure_not_expanded stash pop
>  '
>  
> +test_expect_success 'sparse-index is not expanded: describe' '
> +	init_repos &&
> +	# Add tag to be read by describe

Please add newlines before these comments to visually space out the test &
make it more readable.

> +	git -C sparse-index tag -a v1.0 -m "Version 1" &&
> +	ensure_not_expanded describe --dirty &&
> +	cp sparse-index-out sparse-index-dirty &&
> +	ensure_not_expanded describe &&
> +	cp sparse-index-out sparse-index-normal &&
> +	# Check describe has same output on clean tree
> +	test_cmp sparse-index-dirty sparse-index-normal &&
> +	echo "test" >>sparse-index/g &&
> +	ensure_not_expanded describe --dirty &&
> +	echo "v1.0-dirty" > actual &&
> +	# Check describe on dirty work tree
> +	test_cmp sparse-index-out actual &&
> +	ensure_not_expanded describe

Sorry if I was unclear in my last review [1], but I did not mean that you
should add cases to this test (and, to be honest, the comparison of
'sparse-index-dirty' and 'sparse-index-normal' doesn't add much here).
Please add separate tests (as in, full 'test_expect_success' blocks) for
checking that the functionality of 'git describe' is consistent across
'full-checkout', 'sparse-checkout', and 'sparse-index'. Past sparse index
integrations ('git grep' [2], 'git read-tree' [3], 'git show' [4], etc.) are
a good reference for the types of tests that should be added.

[1] https://lore.kernel.org/git/8cb2b7a2-78f2-9221-1234-62814557d2d3@github.com/
[2] https://lore.kernel.org/git/20220923041842.27817-2-shaoxuan.yuan02@gmail.com/
[3] https://lore.kernel.org/git/90ebcb7b8ff4b4f1ba09abcbe636d639fa597e74.1646166271.git.gitgitgadget@gmail.com/
[4] https://lore.kernel.org/git/8c2fdb5a4fc3317c05324da54692036e36fc15f3.1651005800.git.gitgitgadget@gmail.com/

> +'
> +
>  test_expect_success 'sparse index is not expanded: diff' '
>  	init_repos &&
>  
> 
> base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e

