Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C7C54EAA
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 19:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjA0TPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 14:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjA0TPO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 14:15:14 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67A77BBD8
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 11:15:12 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 88so5481166pjo.3
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WC+yj6a3WRExsWlurus6/3TyZZNs6VlYJlwS+lUYiUo=;
        b=gwk3vROvTBvQ/oOnt+LUzr5SupVBqs9nr4jjnksssa9djyBmNlF6FLaR7/YAKQnlYm
         8GYpSLONlce9nRO4Qa9jERiLf40lHcnpYKGZviceQs5/yYzp4/2cq0W++RyiwCA0qdi1
         FTYYP0r017O/UiF+It4r3VKyApOqPfYNugLyez73ApAvBefXkcz1hpvjzoU1/xXrBKzv
         u7GvxeRLpzTfV6G/Dfd6M7kgWxtDx7ntTAmN4POr7aOk1242hdR1EulTLe5qH8cuE6q9
         yqN9PBT2EHRER+pTQHBYQ2Pc9ThA7lwsYTscyphvtaFtOJIZCy4gnZf0kXqOpHmzQeUv
         L45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WC+yj6a3WRExsWlurus6/3TyZZNs6VlYJlwS+lUYiUo=;
        b=SK+pNSQjZ5hLSwU6Hft7lQrhQWzJWmXNdzSRE5rNYRb9xkvJSOW3beHExfgk1rvxVl
         BhEatY7nTetlgJ+RsS03KTODSsvCKotKVqe9Y5OprAUfr7Wq/F16jOI48Ga8YLTXf5ru
         vPFyWcHmnAyPV+XVima43hc4Z575z+v4dcchpai6ZjOCsw6wd3ZvNt8QMwapaqIxUCic
         Zqo9h5WP0HQJTDMmYat7VvZs1re+01Mh7z4taRYZXUvzQz1l8bEvf6fc0i7JykFZGICn
         /ne5TuhTIU/F8dvYUbQ1Ez0o4MKLTydixeuuFOgb0pMAKd6t0m6IB11eNqlFsGQreEqn
         jMjQ==
X-Gm-Message-State: AFqh2kqlD9f35AIEIkvNlisLPJVgsMqkKIVF7fX1jP9J2TyCqoa2Lmp6
        w7xx46R809tAUGOrLgSFlSx7
X-Google-Smtp-Source: AMrXdXv0wK8oUJt+HtgPVeQRhikMaejge4LNzXH+Ayiwb0eJsfqmDgdZ1N2wQIj5wmCd9T0x26dL8Q==
X-Received: by 2002:a05:6a20:c21a:b0:b8:cb15:d6db with SMTP id bt26-20020a056a20c21a00b000b8cb15d6dbmr38519440pzb.23.1674846912215;
        Fri, 27 Jan 2023 11:15:12 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id v11-20020a17090a4ecb00b00229f68ba7fbsm5390349pjl.19.2023.01.27.11.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 11:15:11 -0800 (PST)
Message-ID: <39e4a13a-2230-919f-4cfc-95d70fb33e3a@github.com>
Date:   Fri, 27 Jan 2023 11:15:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 02/10] t5558: add tests for creationToken heuristic
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
 <427aff4d5e5c85b601f43af8b664515380e11453.1674487310.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <427aff4d5e5c85b601f43af8b664515380e11453.1674487310.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> As documented in the bundle URI design doc in 2da14fad8fe (docs:
> document bundle URI standard, 2022-08-09), the 'creationToken' member of
> a bundle URI allows a bundle provider to specify a total order on the
> bundles.
> 
> Future changes will allow the Git client to understand these members and
> modify its behavior around downloading the bundles in that order. In the
> meantime, create tests that add creation tokens to the bundle list. For
> now, the Git client correctly ignores these unknown keys.
> 
> Create a new test helper function, test_remote_https_urls, which filters
> GIT_TRACE2_EVENT output to extract a list of URLs passed to
> git-remote-https child processes. This can be used to verify the order
> of these requests as we implement the creationToken heuristic. For now,
> we need to sort the actual output since the current client does not have
> a well-defined order that it applies to the bundles.

...

> +# Given a GIT_TRACE2_EVENT log over stdin, writes to stdout a list of URLs
> +# sent to git-remote-https child processes.
> +test_remote_https_urls() {
> +	grep -e '"event":"child_start".*"argv":\["git-remote-https",".*"\]' |
> +		sed -e 's/{"event":"child_start".*"argv":\["git-remote-https","//g' \
> +		    -e 's/"\]}//g'
> +}
> +

...

> +	cat >expect <<-EOF &&
> +	$HTTPD_URL/bundle-1.bundle
> +	$HTTPD_URL/bundle-2.bundle
> +	$HTTPD_URL/bundle-3.bundle
> +	$HTTPD_URL/bundle-4.bundle
> +	$HTTPD_URL/bundle-list
> +	EOF
> +
> +	# Sort the list, since the order is not well-defined
> +	# without a heuristic.
> +	test_remote_https_urls <trace-clone.txt | sort >actual &&
> +	test_cmp expect actual

...

> +	cat >expect <<-EOF &&
> +	$HTTPD_URL/bundle-1.bundle
> +	$HTTPD_URL/bundle-2.bundle
> +	$HTTPD_URL/bundle-3.bundle
> +	$HTTPD_URL/bundle-4.bundle
> +	$HTTPD_URL/bundle-list
> +	EOF
> +
> +	# Since the creationToken heuristic is not yet understood by the
> +	# client, the order cannot be verified at this moment. Sort the
> +	# list for consistent results.
> +	test_remote_https_urls <trace-clone.txt | sort >actual &&
> +	test_cmp expect actual

These updates make the tests stronger (that is, less likely to let a
regression slip through), and the additional comments are helpful for
explaining what is and is not implemented at this point in the series. 

