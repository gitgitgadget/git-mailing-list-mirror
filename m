Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57A381F462
	for <e@80x24.org>; Mon, 10 Jun 2019 09:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388749AbfFJJ7u (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 05:59:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43729 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388056AbfFJJ7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 05:59:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id r18so8490833wrm.10
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TBjgWgQSSVeKyVufpyt0YhUvJZYDeBJJ65UAuBUGXQ0=;
        b=SRTBzofArS+Lrp+4W9Vec7l3moBp8BPONao6SkCkgyP66KvzzBBgJ16d3FaG/rEdkU
         e6GurFHT9hStWt8acg/d9dI4ro6fvgsoZlOYTDEzinipfOeWRGMWvLa2HxSyW8ugAKQU
         CaLTwHWt4w4TljaNLT8I82f/HG+VkzHiYiB5+LfIkYqHEVSc5hR2ta+BUxlW5eI1QA5v
         vpepjxGqTlNkZ4B7sr2AbAFjfhsN8zVMczX1j1tqgGBaz8Qw5rKrJFj9z+9RUi8G4THS
         qrO0szbkInrKdc5TK5U02pGF4kem6YwDUf/qwrINZZ5P1PG+GqEgb3wGxMCbQqzkLrU0
         tvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TBjgWgQSSVeKyVufpyt0YhUvJZYDeBJJ65UAuBUGXQ0=;
        b=YV0zj8gNBzPSgvYf7vOI2rbV7FgyDFcJHbwesMPuHVwCrgOTMh14M/oLyewlpn8pJA
         qO0lxHm8vgj04dLIr8fj5V3Y9VRd2s/qnV3VWbnIt6a4Bag7xVIyF0TTaF36hrLESB4U
         3e55RbQZNDlengLOL0lurDzKaYIDAqL7ywNhnmf+W4vJDS/id+YXv+9lToSxq29mEKAI
         vyMdDbqsWSL+iUs0tz/mpJ2O9Du0B2k7KVNyvR3ZxwBPnseZ6+n6p4OPtFN2Td1HOoMW
         PFuyI1Krb5wOguhOqGUk2Y2SOSBPyaM+E6Pc8SSekS26/ysEK67jE5U0H3p6o/GPOypd
         bBEQ==
X-Gm-Message-State: APjAAAWTa/qOQzFd3JYsXv4ZLze9zHmHgyT459KAQxh3T846GTRemdU6
        RtfNA4hM2C8JB1WrhfU3bGgkt1Eb
X-Google-Smtp-Source: APXvYqyarPTEvlq0JQZyVR7jo6IiVtN1AjU0C3KT+HdFnBMKXuEWy3eavGmISqsknVP/oclossGxxA==
X-Received: by 2002:a5d:4941:: with SMTP id r1mr35570168wrs.225.1560160788271;
        Mon, 10 Jun 2019 02:59:48 -0700 (PDT)
Received: from szeder.dev (x4d0c1d42.dyn.telefonica.de. [77.12.29.66])
        by smtp.gmail.com with ESMTPSA id j7sm13786020wru.54.2019.06.10.02.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 02:59:47 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:59:42 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] t7610-mergetool: do not place pipelines headed by
 `yes` in subshells
Message-ID: <20190610095942.GA19035@szeder.dev>
References: <cover.1560152205.git.j6t@kdbg.org>
 <75c812bd4838f6f35b6f42b97ae396ebb28d8b95.1560152205.git.j6t@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75c812bd4838f6f35b6f42b97ae396ebb28d8b95.1560152205.git.j6t@kdbg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 10, 2019 at 10:58:58AM +0200, Johannes Sixt wrote:
> Subshells for pipelines are not required. This can save a number of
> processes (if the shell does not optimize it away anyway).
> 
> The patch was generated with the command
> 
>    sed -i 's/( *\(yes.*[^ ]\) *) *\&\&/\1 \&\&/' t7610-mergetool.sh
> 
> with a manual fixup of the case having no && at the end.

I think it would be great to include the corresponding numbers from
the cover letter in each of the commit messages.

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t7610-mergetool.sh | 170 +++++++++++++++++++++----------------------
>  1 file changed, 85 insertions(+), 85 deletions(-)
> 
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index 5b61c10a9c..b67440882b 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -131,13 +131,13 @@ test_expect_success 'custom mergetool' '
>  	git checkout -b test$test_count branch1 &&
>  	git submodule update -N &&
>  	test_must_fail git merge master &&
> -	( yes "" | git mergetool both ) &&
> -	( yes "" | git mergetool file1 file1 ) &&
> -	( yes "" | git mergetool file2 "spaced name" ) &&
> -	( yes "" | git mergetool subdir/file3 ) &&
> -	( yes "d" | git mergetool file11 ) &&
> -	( yes "d" | git mergetool file12 ) &&
> -	( yes "l" | git mergetool submod ) &&
> +	yes "" | git mergetool both &&
> +	yes "" | git mergetool file1 file1 &&
> +	yes "" | git mergetool file2 "spaced name" &&
> +	yes "" | git mergetool subdir/file3 &&
> +	yes "d" | git mergetool file11 &&
> +	yes "d" | git mergetool file12 &&
> +	yes "l" | git mergetool submod &&
>  	test "$(cat file1)" = "master updated" &&
>  	test "$(cat file2)" = "master new" &&
>  	test "$(cat subdir/file3)" = "master new sub" &&

Another possibility for eliminating a few more subshells might be to
turn these

  test "$(cat file1)" = "that"'

checks into

  echo that >expect &&
  test_cmp expect file1

because 'test_cmp' on Windows first compares the two files in shell
and runs 'diff' only when there is a difference to report.

