Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25A6C6FA82
	for <git@archiver.kernel.org>; Sat, 10 Sep 2022 01:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIJBH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 21:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIJBH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 21:07:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC13F22F7
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 18:07:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q63so3063183pga.9
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 18:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Tnz44K/zfad3Tae6TMpv9lNb3EhtwE38VECfcNHglU0=;
        b=Voi31Qy8xBT4XaQ6heTf/yDv0BVvW84uS+1o0Y8znTWaIXZBwuvBBkgp9xk/gl7jJ3
         4/JstIVvy0yh1hUfr5oFehcrti9sGdzAMXKRTpDlhruOxQZfXsWCQj/WuFz6euOL9kPc
         MJBGpDIdmxz+hpNz7kfEs5uCS7WhuahCmSRBWCE0Uh/SNl64ZOGeewRNRNCDW5tBGvr8
         E5ISY2CwJjtI/TSdpBfm2vZ2XNbgcwSbJpKXHKBWyB4UT5BJE0LnBKAwg1K+YPn+pXId
         p5TJrNC86qH4hIRBxonQ/mMwjuduBry6SxunuGuUeQR2iEYhtuH2Q++iPBURS1XKE1im
         1KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Tnz44K/zfad3Tae6TMpv9lNb3EhtwE38VECfcNHglU0=;
        b=ZKJtfxMRHNcQASNOQwyz1VxXVClqhFUVcJEF2RJITBkfT4mq6Eu8g2nGDMab425PAE
         Tcb8aTLzC9hhf+C5o62mwr704H9FBnOELCMIHIDLckz5l+vSOrP9ozjuBQ28UyceBnkw
         LDo82q9TZLIDKHluHtdMs1yIUUdGk+CGnTtp3kMrTYXpNF1BMuNzOsDt+a4JSuAB/EXR
         8BrZG8hdpVP2zt39k+6NphVc+CzZeNW6joJ1Ijyx7TDGFBdUojTsu39iNT8nLExEy7U9
         582oaoVIfcMB269rU4Z06Kmlfmn3xZKxltXob4fbOrwirPy1GLfqojLavQkvr0lF+qBJ
         Zrdw==
X-Gm-Message-State: ACgBeo2gkbqIgvoZbGxUwQWEqGDRZZJcvptmznE6NPUcTBmbutLZ9VjT
        UsDG4byy0kzJzhngARc6k57F
X-Google-Smtp-Source: AA6agR6Xbo3jTJk2GQkcLn3ZSrW12Ax57/rr5meU6jDXGcpIQtHTXR7x8/6Equ0VNg+u/049BHkxgw==
X-Received: by 2002:a05:6a00:248d:b0:541:6b82:7a81 with SMTP id c13-20020a056a00248d00b005416b827a81mr27935pfv.47.1662772045699;
        Fri, 09 Sep 2022 18:07:25 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b001781cad59e3sm152300plh.108.2022.09.09.18.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 18:07:25 -0700 (PDT)
Message-ID: <68d8c6f8-d2cd-185b-147d-dfa8d4190fc6@github.com>
Date:   Fri, 9 Sep 2022 18:07:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v5 1/3] builtin/grep.c: add --sparse option
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> index eb59564565..a9879cc980 100755
> --- a/t/t7817-grep-sparse-checkout.sh
> +++ b/t/t7817-grep-sparse-checkout.sh
> @@ -118,13 +118,19 @@ test_expect_success 'grep searches unmerged file despite not matching sparsity p
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'grep --cached searches entries with the SKIP_WORKTREE bit' '
> +test_expect_success 'grep --cached and --sparse searches entries with the SKIP_WORKTREE bit' '
> +	cat >expect <<-EOF &&
> +	a:text
> +	EOF
> +	git grep --cached "text" >actual &&
> +	test_cmp expect actual &&
> +
>  	cat >expect <<-EOF &&
>  	a:text
>  	b:text
>  	dir/c:text
>  	EOF
> -	git grep --cached "text" >actual &&
> +	git grep --cached --sparse "text" >actual &&
>  	test_cmp expect actual
>  '

At first, seeing that all the test titles were changed from "grep --cached
<does something>" to "grep --cached and --sparse <does something>", I was
going to suggest that 'git grep --cached' (without '--sparse') should
receive some new tests in addition to updating existing ones (which now
require '--sparse' to work as before).

However, looking at the actual content of the tests like the one above, I
can see that you've added cases demonstrating the expected difference in
behavior between 'grep --cached' and 'grep --cached --sparse'. I can't think
of a clearer way to name the tests, though, so this looks okay to me.

The rest of the patch (namely, the implementation of '--sparse' and
corresponding documentation) looked good as well - I didn't have anything
specific to note on that.
