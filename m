Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C55C001B0
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 18:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGCSLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjGCSLq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 14:11:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54EAE69
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 11:11:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b7ef3e74edso23740975ad.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1688407900; x=1690999900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4949p4p74u7nB5BaVinuv9ra5F4OWecCiQO0PKPGUIA=;
        b=U3zE9jRHmULvaV5wtOAc/ZoZnpH0u9ANQ62tiJoOJI9UK3+Fr+RLSia5UD3UrliMHL
         sVJ0UPtPdhGr2V9YSZkWgrY3FT3Q6kozqdHFfIp7USQ7aUtjuvxh1Wl0o36SE5aIU9Id
         cZzSd6QYA3i38LxeYe7Y5bXqOpdStzNxG6AH3gB1kZoMhLV7FB0rL0Pdkk9SdU31/f5i
         j3XJU/Z3dwmb+JaV1Sq7Sb7ZCB8SUMs9lvqHJsyD2pqREWX2yNC56s9VFG1jYw49iD6B
         VQDH9CTRwQhRYPGksBba0oOdW52iEHNO/v4NiZQZwlYAEwQp7IOpHrZHTMI3W8aRmdob
         6OSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688407900; x=1690999900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4949p4p74u7nB5BaVinuv9ra5F4OWecCiQO0PKPGUIA=;
        b=GU7YNv9lmrKkCy9UQ97JKFAcsN3c8Twwj9vYgOh5RAqD7gX55UgGpuqSUZDKgvsBsD
         Bl7mhjJgt+5TA907a3D5eAxsu+5dAOHV1yI1YtnpxoxinrmJCuDnV5LOWcND4eWdf9La
         P5tJl+h4FafLBCLGvZtLK+2QLkR4p89ZWv7UMly/pmzw2j0iglnfvjBlnX8p1UtpzXP/
         HGaPX31/ys1yED7cdXDNeajBrPevA1Mae1/FdPCx1XsXfXCIJNeYyZc6WOZXYXAnXDjh
         sew5pJ965Xs/oDWlsM/2m1DKrmsB8Aa9xAB2IyenBwwKjBluFHBinQsSkC/2mmsug5Mx
         SlQA==
X-Gm-Message-State: ABy/qLb/0aMUtuA9O/eg9tiDVjTCD5AnakTUkXF3p54Zvpw9cOB9Vww7
        y1hzcCEdA76TNQ7fgzUcLsyFxafTW9xqRz1H8Q==
X-Google-Smtp-Source: APBJJlF66whEh2hIbOyoIPujqSDagpTHuSPUpazasJskJ5SJGUpSeNK7wA84/yNvBSZxI+lKTfghag==
X-Received: by 2002:a17:902:d4c7:b0:1b8:2ba0:c9c0 with SMTP id o7-20020a170902d4c700b001b82ba0c9c0mr10368500plg.59.1688407899687;
        Mon, 03 Jul 2023 11:11:39 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b001b850c9af71sm7708968plc.285.2023.07.03.11.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 11:11:39 -0700 (PDT)
Message-ID: <52174e5c-421a-256a-f052-85ccaaafca21@github.com>
Date:   Mon, 3 Jul 2023 11:11:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 2/3] t1092: add tests for `git check-attr`
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20230701064843.147496-1-cheskaqiqi@gmail.com>
 <20230701064843.147496-3-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230701064843.147496-3-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Add tests for `git check-attr`, make sure it behaves as expected when
> path is both inside or outside of sparse-checkout definition.
> 
> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 29 ++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 8a95adf4b5..4edfa3c168 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2259,4 +2259,33 @@ test_expect_success 'worktree is not expanded' '
>  	ensure_not_expanded worktree remove .worktrees/hotfix
>  '
>  
> +test_expect_success 'check-attr with pathspec inside sparse definition' '
> +	init_repos &&
> +
> +	echo "a -crlf myAttr" >>.gitattributes &&
> +	run_on_all cp ../.gitattributes ./deep &&
> +
> +	test_all_match git check-attr -a -- deep/a &&

First, ensure 'check-attr' reads the attributes in the untracked
.gitattributes...

> +
> +	test_all_match git add deep/.gitattributes &&
> +	test_all_match git check-attr -a --cached -- deep/a

Then, once .gitattributes is in the index, 'check-attr --cached' reads the
attributes from the index. Makes sense.

> +'
> +
> +test_expect_success 'check-attr with pathspec outside sparse definition' '
> +	init_repos &&
> +
> +	echo "a -crlf myAttr" >>.gitattributes &&
> +	run_on_sparse mkdir folder1 &&
> +	run_on_all cp ../.gitattributes ./folder1 &&
> +	run_on_all cp a folder1/a &&
> +
> +	test_all_match git check-attr -a -- folder1/a &&

This test starts the same way as the last, ensuring a .gitattributes file on
disk is read. The difference is, this one is outside the sparse cone;
without the previous patch [1], this would not work correctly. Good!

[1] https://lore.kernel.org/git/20230701064843.147496-2-cheskaqiqi@gmail.com/

> +
> +	git -C full-checkout add folder1/.gitattributes &&
> +	run_on_sparse git add --sparse folder1/.gitattributes &&
> +	run_on_all git commit -m "add .gitattributes" &&
> +	test_sparse_match git sparse-checkout reapply &&
> +	test_all_match git check-attr  -a --cached -- folder1/a

Now, add the file to the index and reapply the sparse-checkout patterns. In
both 'sparse-checkout' and 'sparse-index', the file is removed from disk; in
'sparse-index', the file is now contained in a sparse directory. Despite
this, the attributes are still read correctly by 'check-attr --cached'. 

These tests look great to me! 

> +'
> +
>  test_done

