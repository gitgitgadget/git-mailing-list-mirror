Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FE9C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 15:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiFWPOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiFWPOW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 11:14:22 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4463E3389D
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:14:21 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id p8so25680402oip.8
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/a0AovTaH+kqrbElHjJmb7p5p0c29S2dcmavV7SSw4g=;
        b=UJWglKUEALYODFBL0K7CO5ZtyEEqb6KdPeqBY1FqrhZJ9pFQEE71xLHvQF+ZUnRrOV
         lpPhmYftiSuwTJVLrRsmumTN57SujRmnNpJ/rrWDs9tS+7rrr02Asfts6RWB7gB/0cHr
         LIwZR0XfyXn89oMkNedfR7phdUkRvDsyy6EXiBJK0ko9KOfSrK6wrFbcjets8fea0khb
         IaC83C15Ed+dleCV36bJl+Rj48+h+MMR9F+vRhcvd0CZ7qqNZHQvKGvFUftsEaEMFhDu
         yt9Ggu3mHnTj5688IN2Q91ae0PIpX/2AUWhdA+EBeN8X0aGRfGe2DZwm1zszf8VytOyk
         TXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/a0AovTaH+kqrbElHjJmb7p5p0c29S2dcmavV7SSw4g=;
        b=VJ3tv2l3CtVzTdKo2NMPCw//6f+n8wejdx4ksUWLqOZm0YbbHzbQ73IuW4aewZCplk
         TiEWazpEM/66E4Kt6dCJVc279BFBjIGpyXkONXqjRpi5iINv26uHRLkv6dCXhZajJGXq
         hrucigr9aoW2Q/jCIe72arCU+90tyDSa/TRs291tfHiE4m/gaPsXth9t1qKlRHQWyPZ4
         sH6X3m0R71WTfwYtjaZcRFmjYx+/FuJ4a7ZLDNOEkVChdRjqAYx1pAkryH7MQS6AXW5G
         iPmTewClQvqbuMnn8vHUdnKcljWQQKyWx9cIepczAtImUkG6jsrRDkiSkz0YgVyk52cI
         lwUA==
X-Gm-Message-State: AJIora9Qqw7o1Q3tU4FLTqHAjMDH3tf7k0vWJPT6CWFZv/QGtshQu6a7
        xRDLyZ+gX9LoWfB6zx9B3X1X
X-Google-Smtp-Source: AGRyM1t7/J3cmH3OPu1RAixtPm/z3/MBqPN9hpxUkBIjdfgB2Bchonq41f7AnYIEtrzsZ+Krj4Ewqg==
X-Received: by 2002:a05:6808:13d6:b0:333:2945:9bd7 with SMTP id d22-20020a05680813d600b0033329459bd7mr2586527oiw.6.1655997260577;
        Thu, 23 Jun 2022 08:14:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:7549:2a5a:7ed5:f864? ([2600:1700:e72:80a0:7549:2a5a:7ed5:f864])
        by smtp.gmail.com with ESMTPSA id o67-20020acabe46000000b0033519ba7d22sm2799498oif.32.2022.06.23.08.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:14:20 -0700 (PDT)
Message-ID: <17a34570-f823-7908-1ea5-8e7bf8680b23@github.com>
Date:   Thu, 23 Jun 2022 11:14:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 7/7] mv: add check_dir_in_index() and solve general dir
 check issue
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-8-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220623114120.12768-8-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/23/2022 7:41 AM, Shaoxuan Yuan wrote:
> Originally, moving a <source> directory which is not on-disk due
> to its existence outside of sparse-checkout cone, "giv mv" command
> errors out with "bad source".
> 
> Add a helper check_dir_in_index() function to see if a directory
> name exists in the index. Also add a SKIP_WORKTREE_DIR bit to mark
> such directories.
> 
> Change the checking logic, so that such <source> directory makes
> "giv mv" command warns with "advise_on_updating_sparse_paths()"
> instead of "bad source"; also user now can supply a "--sparse" flag so
> this operation can be carried out successfully.
> 
> Helped-by: Victoria Dye <vdye@github.com>
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/mv.c                  | 50 ++++++++++++++++++++++++++++++-----
>  t/t7002-mv-sparse-checkout.sh |  4 +--
>  2 files changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index aa29da4337..b5d0d8ef4f 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -25,6 +25,7 @@ enum update_mode {
>  	WORKING_DIRECTORY = (1 << 1),
>  	INDEX = (1 << 2),
>  	SPARSE = (1 << 3),
> +	SKIP_WORKTREE_DIR = (1 << 4),
>  };
>  
>  #define DUP_BASENAME 1
> @@ -123,6 +124,36 @@ static int index_range_of_same_dir(const char *src, int length,
>  	return last - first;
>  }
>  
> +/*
> + * Check if an out-of-cone directory should be in the index. Imagine this case
> + * that all the files under a directory are marked with 'CE_SKIP_WORKTREE' bit
> + * and thus the directory is sparsified.
> + *
> + * Return 0 if such directory exist (i.e. with any of its contained files not
> + * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
> + * Return 1 otherwise.
> + */

This description and the implementation seems like it will work
even if the path exists as a sparse directory in a sparse index.

It would be good to consider testing this kind of move for a
directory on the sparse boundary (where it would be a sparse
directory in a sparse index) _and_ if it is deeper than the
boundary (so the sparse index would expand in the cache_name_pos()
method). These tests can be written now for correctness, but later
the first case can be updated to use the 'ensure_not_expanded'
helper in t1092.

> +static int check_dir_in_index(const char *name)

Thanks,
-Stolee
