Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44519C76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 16:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjDCQeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 12:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjDCQeT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 12:34:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265541FD3
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 09:34:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l7so27757510pjg.5
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 09:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1680539654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=glLk76fBNij24aTY69Aqmy26c/VcJaXl4Aqd+qRF6/k=;
        b=Iekr8JcEjcyRvtUV76wN5G4n5PRAqhIuTrhQ4P2OSXm1J7xcsyUvbIDD82jArpH2rU
         7pLsVxikUUQVtF+EQd0kt+Z5kQW3EoASCEtk0KLGdsfOxaDiMR6ZCZEl6sf+OU5TAXJ2
         IpneGwrNxUuHj/A/nnKBwiAoannsAXrmGOWHvDs6K8md0cUvWOM4nSaU9vbILOligmV1
         iXIHVRsTDn2dQuERQTnqXeWq/IJto5MTEmMc2lG9OWUh/XKN8qBp8WdlyBNr2rv8cvoR
         8PuNtXEfBkiCv5/uzdfmPvId5/CY1jGF9dhap0JA2TFJ4OJB85QcTU2a75F70QvqOohX
         Yj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680539654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glLk76fBNij24aTY69Aqmy26c/VcJaXl4Aqd+qRF6/k=;
        b=Y/QuvRLy/TVi1DHNX7Pkfpukgho0WyKj0K0u9bA62MuZFozfI6jbYA3cZ5xww25Pdp
         xtuTrtcRVzZBwE9Ilau7dDyB2LCBnW28McKPiGvohAvEarMwTC1xbywWyRHsNH496IQ8
         cp2tGfWi6iuuFb7LbyfZGHsAMTbbh8d6P3t9pU+Mh1d8irYY/g8Cdbs4C51IoAozpf6J
         r8sclvXoFnVhSbKpvLFXHPEsQF8Nd2Yd7Qej4nFDMKWoFDuONv82sR80ztadfFQ2xYvP
         xczvkONIA9pRRPE4DKuhqM2p2kesPSGin0NWXkpSIEU4E8BHcvgpRAfTZvOs3TLLQpmT
         FQ0w==
X-Gm-Message-State: AAQBX9edfgfmiB3RGo6c4w/ZsEysgkOT+X0VR/CQ/JW7LZQO/iX2JeYe
        yeGKy4x59bmvCQm4De//CXig
X-Google-Smtp-Source: AKy350ZPCFbF/Clu7ac2vjfTqVX89EGXTonWJDfnQKyCnrAk+MNvwrkAueMDE130m+NPcM/uSCPENg==
X-Received: by 2002:a17:903:20d4:b0:1a1:c746:7d6f with SMTP id i20-20020a17090320d400b001a1c7467d6fmr28669101plb.53.1680539654565;
        Mon, 03 Apr 2023 09:34:14 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id r24-20020a170902be1800b001992e74d055sm6864835pls.12.2023.04.03.09.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 09:34:14 -0700 (PDT)
Message-ID: <f8d8ed7f-49cd-d65a-521c-e03d2c552c50@github.com>
Date:   Mon, 3 Apr 2023 09:34:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [GSOC][PATCH v4] describe: enable sparse index for describe
Content-Language: en-US
To:     Raghul Nanth A <nanth.raghul@gmail.com>, gitgitgadget@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org
References: <pull.1480.v3.git.git.1680155957146.gitgitgadget@gmail.com>
 <20230331182038.224892-1-nanth.raghul@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230331182038.224892-1-nanth.raghul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raghul Nanth A wrote:
> git describe compares the index with the working tree when (and only
> when) it is run with the "--dirty" flag. This is done by the
> run_diff_index() function. The function has been made aware of the
> sparse-index in the series that led to 8d2c3732 (Merge branch
> 'ld/sparse-diff-blame', 2021-12-21). Hence we can just set the
> requires-full-index to false for "describe".
> 

This is a good description of the patch and the reasoning behind the
changes.

> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 801919009e..2b46fb2a48 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1514,6 +1514,36 @@ test_expect_success 'sparse-index is not expanded: stash' '
>  	ensure_not_expanded stash pop
>  '
>  
> +test_expect_success 'describe tested on all' '
> +	init_repos &&
> +
> +	# Add tag to be read by describe
> +
> +	run_on_all git tag -a v1.0 -m "Version 1" &&
> +	test_all_match git describe --dirty &&
> +	run_on_all rm g &&
> +	test_all_match git describe --dirty
> +'
> +
> +
> +test_expect_success 'sparse-index is not expanded: describe' '
> +	init_repos &&
> +
> +	# Add tag to be read by describe
> +
> +	git -C sparse-index tag -a v1.0 -m "Version 1" &&
> +
> +	ensure_not_expanded describe --dirty &&
> +	echo "test" >>sparse-index/g &&
> +	ensure_not_expanded describe --dirty &&
> +	echo "v1.0-dirty" >actual &&
> +
> +	# Check describe on dirty work tree
> +
> +	test_cmp sparse-index-out actual &&

This type of output comparison should be part of 'describe tested on all',
not the "ensure not expanded" test; the former tests the correctness of 'git
describe', whereas the latter focuses on index expansion. When unit testing,
it helps to keep the scope of each test fairly narrow with a specific focus
so that they can more easily isolate future regressions.

> +	ensure_not_expanded describe
> +'
> +
>  test_expect_success 'sparse index is not expanded: diff' '
>  	init_repos &&
>  

