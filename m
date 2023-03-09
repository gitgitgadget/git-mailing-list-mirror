Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1854AC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 17:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCIRVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 12:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCIRVB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 12:21:01 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBE2E8CC5
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 09:20:56 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id nn12so2742146pjb.5
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 09:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678382456;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/yOppEHazqhp27KUM4KU8/+uMXzpdz1rXddnRPky08=;
        b=BqcsSG5Rg2+j9rlHwSDLLEtJ/sV5tnkdDWbvZN7DPxsGYrosQPAACl+pLHF7gQ8l09
         dbP957H4v8z3zkBQyHdN18Z0GuHs4hyINLYKVbpZT2wIfaUqldtiClRbe4TZ2TP8FDse
         HmpZtdWeEfPohWj9963g4SSSfQDa+Iy/1qqjZBKhNwmzxHXxWJ2sV6JTl72Gvc2dU13U
         EeukkENu1Vx77jZShWsPTQsJN3I3koS9e19GLmkGDIsmL9rgApwhNjxVOis8kQ1uSEpg
         W5cYZZ2Xhz1eX54RG/VTaV0cGl+Vws+0kgH5akCki3T341XvDosLbGcHZueHRO7RRt49
         LTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678382456;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l/yOppEHazqhp27KUM4KU8/+uMXzpdz1rXddnRPky08=;
        b=JuIi5dEPxpvPq6pbr9Feb9Wg37foX8hpV9U74YNy/LlNe9cqfKcC8mgnx8Or9b9+QC
         K2sWgmaUnwECoezrVkQZMfi8j8Qc1RJsYkCxxooE0FVa7lRaWdJohrL5LlwO8cVj0QTB
         LFtWija6J3p0pbReYUgtG1qIctgdCNb0/06FGaiiWWb9WfSJC5dDXOg3kY6JJ5HyEvfC
         wzy2WsGX71Zro17bbIj2xBWkqWL4GpwOsgWi9sADbgCvLCUdBinch+mSlk5xivEHdvtQ
         17zov7Zlp6OKCW6fYbyHs5Xu+Fo077Q4epR4dwuC958sMdW4UpAMf6/KwnLwh7SbPWVq
         5FbQ==
X-Gm-Message-State: AO0yUKW8N4xBqU6puPlQ8YuvdxmeX02G/HP/VVbSYceauLUWtPEahPXj
        F1L2PQH1nYG2NylLlyS42bU=
X-Google-Smtp-Source: AK7set9wwSCEwASdXfrURVhpj8uBp7xhOOW0BDsrH1jpPA7dCKSLkMIfr5cAxKr4PKnXgU4jH07Zvw==
X-Received: by 2002:a17:90b:4c0a:b0:22c:aaaf:8dd9 with SMTP id na10-20020a17090b4c0a00b0022caaaf8dd9mr23184662pjb.47.1678382455866;
        Thu, 09 Mar 2023 09:20:55 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id mp4-20020a17090b190400b00230befd3b2csm210758pjb.6.2023.03.09.09.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 09:20:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [PATCH v4 1/2] t1092: add tests for `git diff-files`
References: <20230309013314.119128-1-cheskaqiqi@gmail.com>
        <20230309063952.42362-1-cheskaqiqi@gmail.com>
        <20230309063952.42362-2-cheskaqiqi@gmail.com>
Date:   Thu, 09 Mar 2023 09:20:55 -0800
In-Reply-To: <20230309063952.42362-2-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Thu, 9 Mar 2023 01:39:51 -0500")
Message-ID: <xmqqmt4lc03s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> +	run_on_all ../edit-contents deep/a &&
> +
> +	test_all_match git diff-files  &&

An extra space on this line.

> +	test_all_match git diff-files deep/a 

And on this line.

No need to resend only to correct the above two, but if you are
going to reroll to fix something else, please make sure fixing
them.

> +'
> +
> +test_expect_success 'diff-files with pathspec outside sparse definition' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	# add file to the index but outside of cone
> +	run_on_sparse mkdir newdirectory &&
> +	run_on_sparse ../edit-contents newdirectory/testfile &&
> +	test_sparse_match git add --sparse newdirectory/testfile &&
> +
> +	# file present on-disk without modifications
> +	test_sparse_match git diff-files &&
> +	test_must_be_empty sparse-checkout-out &&
> +	test_must_be_empty sparse-index-out &&

As output from checkout and index are known to be identical (that is
one of the things that test_sparse_match does), I do not think there
is much point checking -out from both sides.

If we know "diff-files" invocation above should never send anything
to the standard error, then checking that sparse-checkout-err is
empty may have value, though.

> +	test_sparse_match git diff-files newdirectory/testfile &&
> +	test_must_be_empty sparse-checkout-out &&
> +	test_must_be_empty sparse-index-out &&

Ditto.

> +	# file present on-disk with modifications
> +	run_on_sparse ../edit-contents newdirectory/testfile &&
> +	test_sparse_match git diff-files &&
> +	test_sparse_match git diff-files newdirectory/testfile 

We do not care what the actual output is in this case?

> +'
> +
>  test_done

Thanks.
