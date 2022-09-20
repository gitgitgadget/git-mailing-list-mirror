Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05578C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 16:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiITQnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 12:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiITQnW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 12:43:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F986556D
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 09:43:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m3so4662854eda.12
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 09:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=tWlMTmTIw/44rg9nfrFntxYklImioqBUvM7C5pm4Y4M=;
        b=YoptFHaRiK+qeENtwxGdHrgTk+aaTtAlDjbBBUF7hF/1/+HbDpP1BMIr4bFESpAnCW
         vpcQhUx7UpHDm7/eDv5AGWmTNmq/fERM+KdWCG2vSFF9ltcm8Yl6vWVm+vDldn9hPl1m
         qAGSWxooiQaxfqs4oBEszkZddfIjU6D2hxpwpm8UpBaGamMcKf5kUHgKQQDudgRg63S1
         W/1Q0ArXoDqZ8PSUtH4KK173ozR8O2k9eNiji+kqSYHEq5chY+0iq4FFAElA0AQ5Z1uf
         YB+3x2WJqiIdR74XwtQRztUTzTP0z8cRYwOzG9r1ZbO3oICnEm+bAOKnJz95BvOrwF2R
         cMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tWlMTmTIw/44rg9nfrFntxYklImioqBUvM7C5pm4Y4M=;
        b=FEZdjkcRPD62VZ6fE41zFoZDqbxi6zv0tpoh7S35yw+thQmZt8EhZwHb4pCL+oTlKs
         aoQPounOSGJQq1nVvyKsL5g5Ot7KKJ8tvNUA1AUzybO2HiRx4L+82TfroC3xO3jiC9LJ
         eWAC2574BudX7taZ5BC+YLUL05FFTamwc/vK7dIhsZ1wacnk78FwfZsPLHzLAh0K/DvS
         cvyjktJRFygKDdvb86gZ+eBx0NUhLmIT24Rm/HkCIBlVNaSOMI0guQRiVnvljwxhs2do
         3kdBvEpkBlyjFEs0085wqhu8g9cpuHL53AOSpW0MEdnuwabNOOZStV+OxFbL56RVk9Eg
         OV7g==
X-Gm-Message-State: ACrzQf1UhwPCoA9QqZC1SV4FEQFwxfN/YCGBp4cycPGZIkFIU/W/4OaS
        gOhgyxO0KFXMU0sFWB4Cum8=
X-Google-Smtp-Source: AMsMyM5LdPiHbF1ChtF8Sv6Va4+PuOUek0ms8IUPP0KUU0InSflyy5ke3rgILYD+Be0JnIMEzwQRIQ==
X-Received: by 2002:a05:6402:1e96:b0:451:129e:1a2c with SMTP id f22-20020a0564021e9600b00451129e1a2cmr21406910edf.60.1663692199804;
        Tue, 20 Sep 2022 09:43:19 -0700 (PDT)
Received: from localhost (78-131-17-3.pool.digikabel.hu. [78.131.17.3])
        by smtp.gmail.com with ESMTPSA id a12-20020a1709063a4c00b0073a20469f31sm146270ejf.41.2022.09.20.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 09:43:19 -0700 (PDT)
Date:   Tue, 20 Sep 2022 18:43:17 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] t: remove \{m,n\} from BRE grep usage
Message-ID: <20220920164317.GA1704@szeder.dev>
References: <cover.1663688697.git.congdanhqx@gmail.com>
 <752b12ef1e27d3b69d6aa3734309895082be7886.1663688697.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <752b12ef1e27d3b69d6aa3734309895082be7886.1663688697.git.congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 10:49:14PM +0700, Đoàn Trần Công Danh wrote:
> \{m,n\} is a GNU extension to BRE, and it's forbidden by our
> CodingGuidelines.
> 
> Change to fixed strings or ERE.
> 
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  t/t3200-branch.sh             | 6 ++++--
>  t/t3305-notes-fanout.sh       | 2 +-
>  t/t3404-rebase-interactive.sh | 6 +++---
>  t/t5550-http-fetch-dumb.sh    | 2 +-
>  t/t5702-protocol-v2.sh        | 2 +-
>  5 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 9723c2827c..f05ac1fe0b 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -201,8 +201,10 @@ test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
>  
>  test_expect_success 'git branch -M baz bam should add entries to .git/logs/HEAD' '
>  	msg="Branch: renamed refs/heads/baz to refs/heads/bam" &&
> -	grep " 0\{40\}.*$msg$" .git/logs/HEAD &&
> -	grep "^0\{40\}.*$msg$" .git/logs/HEAD
> +	zero="00000000" &&
> +	zero="$zero$zero$zero$zero$zero" &&
> +	grep " $zero.*$msg$" .git/logs/HEAD &&
> +	grep "^$zero.*$msg$" .git/logs/HEAD

I think these could use $ZERO_OID instead.

