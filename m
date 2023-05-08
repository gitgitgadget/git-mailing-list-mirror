Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC3DC7EE25
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjEHWZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjEHWZt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:25:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1E95B92
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:25:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-643912bca6fso4031861b3a.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683584748; x=1686176748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WePH/tCb4To56/rrzYKWCYwjZ+dOGU5TruKCLc6sNrY=;
        b=C0Desm1Ar9w5ynDIqlhrMfaFVTek7bSBYxfBOuzXz8IOYi7PGSZ4DmyJqQdQGfoYYj
         mhkYY4olM+m7rqljCp59YlKOgbwJLO/0xdcuUcB5dRc2IhUAgWJel1hcamGcEiJnxuti
         Cph+k1ojTkZa1oJNxRzX5cMw1D4FKzuYlbjETgabHwbBzUeBnR0ARSAuzl4SO1P8YPXw
         ESvDiWYe0kKDCPrH0B/WF4UyOYKOrrlhPZRAHYv0sVtEusIbccQyjwwWXRCd7d6+9Kq1
         P5r7P5NW7S1QFfBeyapjwIJWSiIHrumqoDjkv3lfut6U+8ClLXhCWqpXAFmWp5ylK5p6
         mIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683584748; x=1686176748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WePH/tCb4To56/rrzYKWCYwjZ+dOGU5TruKCLc6sNrY=;
        b=f2w3t2nXjWXf0vskpOH5CbgWA0IvJF2FyR+DQOuODV/wO/leKw0VKSl0lWC5V4VWf5
         r3HqT+agpkpiwGbFFWZ6CGNWMqQyjmxJB2PSg+KivoZtzv1q25uw9ID4n+6KFhvfhgBc
         /tLmvEPTI+2+MOJs6wxKbW7xKsJ+NKVwNnBjA3uwkEOgth1NLuxua1a/DifixMsgXEJZ
         Chwjc+V68j0XvAZpBvVVmCPhqsKWYFkz3b64er/cNRaVJm5CILMf2AWb+7XgPjtGIoSh
         tjrYZ+XrIffpc90lejAZ/Kb4mSK8SA59ObjI/Xvuy8wYDefAE1OkLTKZZhP3c6GFQBYF
         9iWQ==
X-Gm-Message-State: AC+VfDy/+Ol+7QmAegTv2rdBthGtwH4OJDzvSrDZ1n3Dt02iF6QPVVzR
        rnDdRwtKVRBekpHmeOKDORycr7coEXitu7bRNA==
X-Google-Smtp-Source: ACHHUZ5nxuNXiv/7KYFB5FRls/6drCBLIDeCpibCHPPn481h6ikCojc3MmsJ6SARDX378jRwWMfe2w==
X-Received: by 2002:a05:6a00:1821:b0:644:d77:a2c5 with SMTP id y33-20020a056a00182100b006440d77a2c5mr12386016pfa.29.1683584748242;
        Mon, 08 May 2023 15:25:48 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id k3-20020aa790c3000000b0063d46ec5777sm419107pfk.158.2023.05.08.15.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 15:25:47 -0700 (PDT)
Message-ID: <8489e272-ccb9-62b1-992e-d305bb27c895@github.com>
Date:   Mon, 8 May 2023 15:25:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v11 1/2] t1092: add tests for `git diff-files`
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230503215549.511999-1-cheskaqiqi@gmail.com>
 <20230508184652.4283-1-cheskaqiqi@gmail.com>
 <20230508184652.4283-2-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230508184652.4283-2-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> +test_expect_success 'diff-files with pathspec inside sparse definition' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	run_on_all ../edit-contents deep/a &&
> +
> +	test_all_match git diff-files &&
> +
> +	test_all_match git diff-files deep/a &&
> +
> +	# test wildcard
> +	test_all_match git diff-files "deep/*"

You added the '--' separator below, but not here. Was that intentional, or
should these have it as well? It doesn't make much of a practical difference
in this case, but it would be nice to remain consistent across all tests of
'diff-files' that you're adding. 

The same goes for some of the tests in patch 2 [1] ('sparse index is not
expanded: diff-files' and the perf tests).

[1] https://lore.kernel.org/git/20230508184652.4283-3-cheskaqiqi@gmail.com/

> +'
> +
> +test_expect_success 'diff-files with pathspec outside sparse definition' '
> +	init_repos &&
> +
> +	test_sparse_match git diff-files -- folder2/a &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	# The directory "folder1" is outside the cone of interest
> +	# and may not exist in the sparse checkout repositories.
> +	# Create it as needed, add file "folder1/a" there with
> +	# contents that is different from the staged version.

nit: 'folder1/' *definitely* won't be present in the sparse-checkout
repositories, so "will not" would be more accurate than "may not".
Otherwise, this comment is clearer than before & better explains what's
going on here.

> +	run_on_all mkdir -p folder1 &&
> +	run_on_all cp a folder1/a &&
> +
> +	run_on_all ../edit-contents folder1/a &&
> +	test_all_match git diff-files &&
> +	test_all_match git diff-files -- folder1/a &&
> +	test_all_match git diff-files -- "folder*/a"
> +'
> +
>  test_done

