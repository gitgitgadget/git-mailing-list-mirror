Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D381F453
	for <e@80x24.org>; Wed, 23 Jan 2019 23:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfAWXjO (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 18:39:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37949 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfAWXjL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 18:39:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so1147976wml.3
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 15:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=oTKLTnqXj6+r9YH3QAsNeyLTVxIKd9MbuINWiznWDms=;
        b=ptBcslKw3p3b8VzujYdmXspUQ+qVeinNnTVJdJP/ObLHS8VDfYmYI+U1YAPcgt29aC
         8Ff8h2dvi63b6SRyW4i4LjKWFvgu0KUxyn4yJaQyPtez78v0mdJSCAUqxv0vj6VoUd1l
         Su+uWJONl8wrVEVc0b4rcC9faeyWC4doeq9GFVVjj7HwA5GAaQTtmvjP/aGQxzlH0dmV
         zsVMX33D3JzPq+bAGGnZv36DlH2KmP9TzHRVkn9JgAL8A+lkXOiL2pzLYcuOggMeOKZy
         mJk0zkl25H+X/RmV03aNMD7KkRjHMZvdu7mPnpHLxRb2pyuChdJOwySN8BtRHXLQ4kIJ
         8Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=oTKLTnqXj6+r9YH3QAsNeyLTVxIKd9MbuINWiznWDms=;
        b=TaU1iuhASBe/KqvyjkYVJg7P/7PsrpOKt7a1U6GnxuYH69KIh2JN0Jp+l8rhjhpD0Q
         7Ohm8v9Vyrdo5q9mVAElKn3mzhJD7zh48NgZ0HL+1NfHztzl/h+P5Ymo3HVIuFB36pPk
         uwf4s1hSFsffUehpAym1zv/saDG8qMnWJKTk8Pjl/zBqTCo9VmMhLBB/cUTFjvUQPmRy
         5EUVjR2sz4KaZSC+0y3auLzQl6+4i8oJqLheZnfL6CZfE+mO+Ab+eKWGglGJkd0e/e+6
         m0dFyZHnR2atwFJ2ud6y9sELOtyYBNZ8n/+XoQHrf2BPiudTUVyklNmtvGFzl14omv/T
         O70A==
X-Gm-Message-State: AJcUukeYwDg1DheRDdjXb1A8n1yC7RbBZk3FB40+uo8TMn3rMBlCxayQ
        xp88xk30Mmc97ECR8dDXTTQ=
X-Google-Smtp-Source: ALg8bN5RGplhoENst9TqgFoZNZh5qxELt6xMmBoaw4gU2/a6tBZ4ZBUG3HUACQ8CrYKWe7WxTGjJMg==
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr140684wmg.78.1548286749260;
        Wed, 23 Jan 2019 15:39:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k15sm135333819wru.8.2019.01.23.15.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 15:39:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 04/21] ci: inherit --jobs via MAKEFLAGS in run-build-and-tests
Date:   Wed, 23 Jan 2019 14:22:10 -0800
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <83b92a87e7698cee1e2c44252b934ad436d75a90.1548254412.git.gitgitgadget@gmail.com>
Message-ID: <xmqqtvhz54gz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Let's not decide in the generic ci/ script how many jobs to run in
> parallel; it is easy enough to hand that information down via the
> `MAKEFLAGS`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/run-build-and-tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index db342bb6a8..80d72d120f 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -7,7 +7,7 @@
>  
>  ln -s "$cache_dir/.prove" t/.prove
>  
> -make --jobs=2
> +make
>  make --quiet test
>  if test "$jobname" = "linux-gcc"
>  then

As there is no assignment to MAKEFLAGS in this patch, is it intended
for this step to change behaviour (possibly with the intention to
add "default 2 jobs at least under travis" back later in the
series)?  Not that it matters too much, but it is unnerving to see
that the proposed log message promising "it is easy enough" while
not actually doing so, without expressing an intention.


