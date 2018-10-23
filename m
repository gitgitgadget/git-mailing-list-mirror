Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10791F453
	for <e@80x24.org>; Tue, 23 Oct 2018 04:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeJWMbV (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 08:31:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53260 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJWMbU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 08:31:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id y11-v6so212796wma.3
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 21:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+TmSCUDoiVzPa9AW4DGPUEzdnAYzYn2fBgU2R74Se1A=;
        b=mCUji+yf68Oy/BY/gLES0TuHRgImJekHj/n5wHlMrbXtk8K74Xr8KV2ch2E/SLALoc
         kkC3Y/qO3bJ172bEKfjR8f2jZm3CUGD04KRINxvSHXiYimSk9jNRQGJhmeIsMBceeMy8
         ZWqVvpCaQEind/VGs468U2TfRIiaC2ZfD7zdHPxFRcmK3+bTComJ/oY1lPkZH406b6I7
         n78c9eYrbWSg6wt33Mx3uKZWPdyQCFrpXeQneabzSjGwloLW4ykkYnpv/Vi/lovTCJNY
         yCgQwp+2WQW1q1Uk7JRlcxD9CsgwBUJM/u1+KuFn1JBsh92PTBd1sAqVK71byKOlOjH2
         4JkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+TmSCUDoiVzPa9AW4DGPUEzdnAYzYn2fBgU2R74Se1A=;
        b=Cvsxh7ekIxnKMC0kVVRbLWouLqS5j6Zk0/E4oicb+ABwJezIub7FyUvg82PgG0zyka
         KUNL7scOqwoXy7lR6ts4ibUDwbGJRcKKABCY5E5P6aQjJT/yIO8tbgrqo9vfnKIlAfFI
         HWPA5C4d/A4YkJHnGXDW0v1hdYLH8ovf/03s+O7wupe6Mrbtbu9UdjBAUxdUTDUbKa+Y
         MGVkKxiFyqnBiMddfACCPee47EGxbsvEoVkXFsSdFhkFR9m50l6Fd3juvhnAEFgXKZfN
         x7zZLqVi/eZbAo/pOkWXvjVFuO0WXREeBgYN+8kZTF2S0X4HF+y7LWrWwRRI5dXp/T9n
         /rFQ==
X-Gm-Message-State: ABuFfoh22rv+TGzFi5BAd8TJlUdQMkI4yl1Fc4Av1eGOpvK6PL+W72ku
        cXoznPVCBIe+Qg5yer3kVVQ=
X-Google-Smtp-Source: ACcGV606AgW5WkSjwJl393hRU6yCmMWLF4WrsT3ueDChXG9hN5+69PX5bx1kPPhI7pMSR6GXz26z3w==
X-Received: by 2002:a1c:c683:: with SMTP id w125-v6mr18127249wmf.117.1540267785916;
        Mon, 22 Oct 2018 21:09:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 77-v6sm323405wmv.6.2018.10.22.21.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 21:09:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     steadmon@google.com
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3] archive: initialize archivers earlier
References: <bc6f20274dfe11f1451745e0accb065544cc59ca.1540244445.git.steadmon@google.com>
        <39a4e7bf8f3ebc5803393f357d1ee7dc9806252f.1540251936.git.steadmon@google.com>
Date:   Tue, 23 Oct 2018 13:09:43 +0900
In-Reply-To: <39a4e7bf8f3ebc5803393f357d1ee7dc9806252f.1540251936.git.steadmon@google.com>
        (steadmon's message of "Mon, 22 Oct 2018 16:54:47 -0700")
Message-ID: <xmqq4lddtibc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

steadmon@google.com writes:

> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 2a97b27b0a..cfd5ca492f 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -39,6 +39,8 @@ test_lazy_prereq TAR_NEEDS_PAX_FALLBACK '
>  
>  test_lazy_prereq GZIP 'gzip --version'
>  
> +test_lazy_prereq ZIP 'zip --version'
> +

There are a handful of zip implementations; Info-ZIP found on many
Linux distros does support 'zip --version', but we may want to make
sure this test covers different implementations of zip sufficiently.

Queuing this patch (or an update of it) on 'pu' and hoping those
with zip from different origins to try it would not help very much,
either, as zip implementations that do not react to "zip --version"
would silently turn the prereq off without breaking anything.

In any case, please refrain from adding any ZIP prerequiste to t5000
which is about tar; t5003-archive-zip may be a much better fit.  It
has an already working machinery that validates the generated zip
archive under UNZIP prerequisite, so we may not even have to invent
our own ZIP prereq if we did so.

> @@ -206,6 +208,19 @@ test_expect_success 'git archive with --output, override inferred format' '
>  	test_cmp_bin b.tar d4.zip
>  '
>  
> +test_expect_success GZIP 'git archive with --output and --remote creates .tgz' '
> +	git archive --output=d5.tgz --remote=. HEAD &&
> +	gzip -d -c < d5.tgz > d5.tar &&
> +	test_cmp_bin b.tar d5.tar
> +'

We try to write redirections without SP between redirection operator
and target filename, i.e. "gzip -d -c <d5.tgz >d5.tar".

Thanks.
