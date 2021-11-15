Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D086C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 15:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2707961B6F
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 15:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbhKOP5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 10:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbhKOP5C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 10:57:02 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3EFC061204
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 07:54:03 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id v19so4095926plo.7
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 07:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8GmrdgyND+l9rt1OGOXlLlhd8fWLSGUc6oRZ0+mx8dg=;
        b=I9o/QWWahQZe2A/uH7D1vlH2MvKA9fvURCOzGwuvfCip8x0yR6BszF/T3NCeDPFOEx
         t3LrL3oTzh6Di2IS1N8zApyQls03fpS2X2qULxbvAE6HscH+lKlHcB8WhmlwCRdaLAvE
         3qCvKQlBXZNHHHnc6wsNKLpkbmh7xVIk6Jis1tQI2mImjZE76snZjWNffEu9zQx77lQa
         /53Ydbfxz0kPYWunxBeGgveLA2KpaozTxg4BQ3XiXD0qiP2aelAZdWEWHZ2It1QY0gaP
         WTDtz7DFaxCOfRE62CjgCYxSLsyOkYdPZ8/BInjxgGgGFeG1ACOrWUXAmw0cp7Uh/a15
         SOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8GmrdgyND+l9rt1OGOXlLlhd8fWLSGUc6oRZ0+mx8dg=;
        b=MzCXb9xGCCZbeH7PD3LU8UC0wAKWV7ZiubVah00cuzgDTiMDma6RvHWxpDwbgnjDxC
         ZUKgHw73s1K8p6m1TuyVnmIxlBVWTcbzdycS9oHBARc2WdqrpLGRNNxsALy3XA4ITOCB
         XPzemr80cb6MDbQpzzogS8DXX8m2jYRi2oishAj8/BxYzA6i3tLVUXpChcK7XNUIfh9B
         wYOQNRRR2tdGvLXDa9/QhlsLSKYO0DzQpkyGo2oskXhasprl7FK1gbrRu4E3e8v1MS2D
         6V5ia0d/vE6FeX8Eyo7DSXWVLDGXbYMQw6lgbSPilj4AALKbAPXoSX7BCdv5aNPIfe4Y
         BEjg==
X-Gm-Message-State: AOAM530JwqOWP9HW0PoZf+knTCZs6NbjWy9O0JBXpjI8rKBmmmyzN/l4
        qilpv0O22CGgJBaPF6YovM4=
X-Google-Smtp-Source: ABdhPJwlcpF5tCaz1myXxzl1uwknA5Je4H6QsJy3IA773BM5wj2v9c0bh0ilnxdyA9u/4eZs/mWy7w==
X-Received: by 2002:a17:90b:4b4d:: with SMTP id mi13mr27466237pjb.192.1636991643359;
        Mon, 15 Nov 2021 07:54:03 -0800 (PST)
Received: from localhost ([2402:800:63b8:c954:57f3:fdbb:8ade:b454])
        by smtp.gmail.com with ESMTPSA id w37sm11807272pgk.87.2021.11.15.07.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 07:54:03 -0800 (PST)
Date:   Mon, 15 Nov 2021 22:54:00 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 2/3] t3104: add related tests for `--oid-only` option
Message-ID: <YZKCmPJzOwLeFhIJ@danh.dev>
References: <20211115115153.48307-1-dyroneteng@gmail.com>
 <20211115115153.48307-3-dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115115153.48307-3-dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-11-15 19:51:52+0800, Teng Long <dyroneteng@gmail.com> wrote:
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  t/t3104-ls-tree-oid.sh | 55 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100755 t/t3104-ls-tree-oid.sh
> 
> diff --git a/t/t3104-ls-tree-oid.sh b/t/t3104-ls-tree-oid.sh
> new file mode 100755
> index 0000000000..78ab9127c7
> --- /dev/null
> +++ b/t/t3104-ls-tree-oid.sh
> @@ -0,0 +1,55 @@
> +#!/bin/sh
> +
> +test_description='git ls-tree oids handling.'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	echo 111 >1.txt &&
> +	echo 222 >2.txt &&
> +	mkdir -p path0/a/b/c &&
> +	echo 333 >path0/a/b/c/3.txt &&
> +	find *.txt path* \( -type f -o -type l \) -print |
> +	xargs git update-index --add &&
> +	tree=$(git write-tree) &&
> +	echo $tree
> +'
> +
> +
> +test_expect_success 'specify with --oid-only' '
> +	git ls-tree --oid-only $tree >current &&
> +	cat >expected <<\EOF &&
> +58c9bdf9d017fcd178dc8c073cbfcbb7ff240d6c
> +c200906efd24ec5e783bee7f23b5d7c941b0c12c
> +4e3849a078083863912298a25db30997cb8ca6d6
> +EOF

Failed with:

	GIT_TEST_DEFAULT_HASH=sha256 ./t3104-ls-tree-oid.sh

I think we can use:

	git ls-tree $tree | awk '{print $3}' >expected

> +	test_cmp current expected
> +'
> +
> +test_expect_success 'specify with --oid-only and -r' '
> +	git ls-tree --oid-only -r $tree >current &&
> +	cat >expected <<\EOF &&
> +58c9bdf9d017fcd178dc8c073cbfcbb7ff240d6c
> +c200906efd24ec5e783bee7f23b5d7c941b0c12c
> +55bd0ac4c42e46cd751eb7405e12a35e61425550
> +EOF
> +	test_cmp current expected
> +'

Ditto for this test and below tests.

> +
> +test_expect_success 'specify with --oid-only and --abbrev' '
> +	git ls-tree --oid-only --abbrev=6 $tree >current &&
> +	cat >expected <<\EOF &&
> +58c9bd
> +c20090
> +4e3849
> +EOF
> +	test_cmp current expected
> +'
> +
> +test_expect_success 'cannot specify --name-only and --oid-only as the same time' '
> +	test_must_fail git ls-tree --oid-only --name-only $tree >current 2>&1 >/dev/null &&

The last redirection '>/dev/null' does nothing, me think.

> +	echo "fatal: cannot specify --oid-only and --name-only at the same time" > expected &&

Style nit:

	use '>expected' instead of '> expected'

> +	test_cmp current expected
> +'
> +
> +test_done
> -- 
> 2.33.1.9.g5fbd2fc599.dirty
> 

-- 
Danh
