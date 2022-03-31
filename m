Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4433DC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 22:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242289AbiCaWNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 18:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241816AbiCaWNX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 18:13:23 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77FA13E84
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 15:11:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id o8so846101pgf.9
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 15:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S0PMaiS1dyjJTrJrQfKRXWb/CBdZFl5goIg+puVpFxk=;
        b=K+lfid+OOFQh7mXj1MHSUm3guKC8AP9y7ruaYsiAyCbCQNXlm2jdAzWBk8i4iQnrsi
         GXBNlGT0YT7S/d1Om13hzr/KOBaJhXMaeXPbVoLqIKCBu7x1TcBJoAqhpaErxxMWCS6O
         HRF7SXhIjXWT0iHlMTUVA0n3uqOuhjYCYL4ftRyoZEXe+yicQZTZaauUURSm6t9aYn52
         yIFPQZ7f7OQscLRCDUxZEFCW4Ey0Obsp0BsruTeVLqBY3+XJAOi+PHlRvj6C177PjkEZ
         29w9cLfaEvJY1FgWSexv/kCPxsHiqHd8xcETSpgMiIUBseAO4r33uj+/UjOuKx2LJrXj
         xQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S0PMaiS1dyjJTrJrQfKRXWb/CBdZFl5goIg+puVpFxk=;
        b=dCzvXA0vwnJATFp8MdsKOzMcHtZOjGTqWY/IyXmb1k41JUS/RO1tooYz1DIRie7f54
         CQp2XgieQl/4P/8sdHPSvpcgqNUl0034BepBk83+QD8sxxb+PwPSNPJJ64BoPXY1fR5t
         ZxH8iSnPt3Ii3GVMARxYKdzKswHhWEXaJusC5ty1+f79NpA4RSmAcdkB6xxhevnfz18Y
         rkVfXzTqdKfPfxaksupjDkj0QbGtkLmbzFp8dO1neLpo+rTqjF7xuZJFufCKFLGESwzX
         Lc/TtaH3bjtNAGnJ0O4wQ7sAz16XJg51c730y9k7gvRFRy/hVv4lL/ZbsIRzkIN6xJBh
         HFyQ==
X-Gm-Message-State: AOAM530B1z5rC7vFzEF+mrh7VgGfAX6RkRVYGTLgABpbCJVKKJ2rHJmu
        3AFBwyyllLfjhdcDrpi6+wra
X-Google-Smtp-Source: ABdhPJzJepepZLByZh5nCRLZlDNMlv/pCtCWF9p5rxAiMfl3Ig9O4bWcHT2imfQAh3lHP2VmTf5N0w==
X-Received: by 2002:a63:e958:0:b0:380:132:5da8 with SMTP id q24-20020a63e958000000b0038001325da8mr12390470pgj.114.1648764695436;
        Thu, 31 Mar 2022 15:11:35 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id s22-20020a056a00179600b004fb28a97abdsm503623pfg.12.2022.03.31.15.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 15:11:35 -0700 (PDT)
Message-ID: <3be083bb-7bc8-3aa2-400e-774b9a1524e0@github.com>
Date:   Thu, 31 Mar 2022 15:11:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [WIP v1 4/4] t7002: add tests for moving out-of-cone
 file/directory
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-5-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220331091755.385961-5-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Add corresponding tests to test following situations:
> 
> * 'refuse to move out-of-cone directory without --sparse'
> * 'can move out-of-cone directory with --sparse'
> * 'refuse to move out-of-cone file without --sparse'
> * 'can move out-of-cone file with --sparse'
> 
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  t/t7002-mv-sparse-checkout.sh | 72 +++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
> index 1d3d2aca21..efb260d015 100755
> --- a/t/t7002-mv-sparse-checkout.sh
> +++ b/t/t7002-mv-sparse-checkout.sh
> @@ -206,4 +206,76 @@ test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
>  	test_cmp expect stderr
>  '
>  
> +test_expect_success 'refuse to move out-of-cone directory without --sparse' '
> +	git sparse-checkout disable &&
> +	git reset --hard &&
> +	mkdir folder1 &&
> +	touch folder1/file1 &&
> +	git add folder1 &&
> +	git sparse-checkout init --cone &&
> +	git sparse-checkout set sub &&
> +
> +	test_must_fail git mv folder1 sub 2>stderr &&
> +	cat sparse_error_header >expect &&
> +	echo folder1/file1 >>expect &&
> +	cat sparse_hint >>expect &&
> +	test_cmp expect stderr
> +'
> +
> +test_expect_success 'can move out-of-cone directory with --sparse' '
> +	git sparse-checkout disable &&
> +	git reset --hard &&
> +	mkdir folder1 &&
> +	touch folder1/file1 &&
> +	git add folder1 &&
> +	git sparse-checkout init --cone &&
> +	git sparse-checkout set sub &&
> +
> +	git mv --sparse folder1 sub 1>actual 2>stderr &&
> +	test_must_be_empty stderr &&
> +	echo "Please use \"git sparse-checkout reapply\" to reapply the sparsity."\
> +	>expect &&
> +	test_cmp actual expect &&
> +
> +	git sparse-checkout reapply &&
> +	test_path_is_dir sub/folder1 &&
> +	test_path_is_file sub/folder1/file1
> +'
> +
> +test_expect_success 'refuse to move out-of-cone file without --sparse' '
> +	git sparse-checkout disable &&
> +	git reset --hard &&
> +	mkdir folder1 &&
> +	touch folder1/file1 &&
> +	git add folder1 &&
> +	git sparse-checkout init --cone &&
> +	git sparse-checkout set sub &&
> +
> +	test_must_fail git mv folder1/file1 sub 2>stderr &&
> +	cat sparse_error_header >expect &&
> +	echo folder1/file1 >>expect &&
> +	cat sparse_hint >>expect &&
> +	test_cmp expect stderr
> +'
> +
> +test_expect_success 'can move out-of-cone file with --sparse' '
> +	git sparse-checkout disable &&
> +	git reset --hard &&
> +	mkdir folder1 &&
> +	touch folder1/file1 &&
> +	git add folder1 &&
> +	git sparse-checkout init --cone &&
> +	git sparse-checkout set sub &&
> +
> +	git mv --sparse folder1/file1 sub 1>actual 2>stderr &&
> +	test_must_be_empty stderr &&
> +	echo "Please use \"git sparse-checkout reapply\" to reapply the sparsity."\
> +	>expect &&
> +	test_cmp actual expect &&
> +
> +	git sparse-checkout reapply &&
> +	! test_path_is_dir sub/folder1 &&
> +	test_path_is_file sub/file1
> +'
> +
>  test_done

Other than my earlier comments about moving the tests to another point in
the series, the content of the tests looks great!
