Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E11C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 23:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244222AbiHHXyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 19:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHHXx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 19:53:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3139D1C138
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 16:53:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h132so9956843pgc.10
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 16:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=DU19vWiUW9aqxYOFHE5YLVtskbrH003Wm2GWtUInbYY=;
        b=JbserybrxjMzAteQUh1GpuAVisAHGI2ERq3V5j6SfU/RCK600yN/8UIUJkh2DX6qew
         Tp/lQlU4jVqCxY5DSYtJjkTuMUI0wx4yuxy4btE5P4bXkWV92Nc0a2EI6NMfJTh2H0Qc
         FRQukh6BZ+nNIcRiSy/R/56cBF3LBZ7QSIkQW4lvSDy96QGEYvkdvNjS0CNhITREMG/L
         HpuxX4ftBgvn0xuw827aHfVqCei+lJtT5CpYo8WizQ0JK0DwntWaPXvrJkcrpxtayJ5E
         6xxqpbBhBP6DjUh7sr8AhmGpu5DY+p34KBeOxjlJ5QQZUEuhIswbI8RfQ5ftqIgYjOsN
         +xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DU19vWiUW9aqxYOFHE5YLVtskbrH003Wm2GWtUInbYY=;
        b=qpZMeraMQUJ/cNbUB/wOcejHifRqe8Fpjx9xobp/LYWPK/mwMvryA5AwMxCw5HyxlA
         X0XZiq7CeYj0zlH/K2wMW5lRofiJCrM7lUrA26vwfhQ4fBLS79XxzMi4nquEIM4g7FIR
         u6bY/8D8D5tFWPPDwPfXxAxO0E9IsBN0GfGXT95L+/CmAs5F6CMxDOt3LUs6li3/ALh7
         OKXlYYbXADj4NpveOKfHw7evIPsATZoGcZs3xRHwKNixaQsIvQXVeaZon+99pAt7+puc
         dvAi0HaH9gnE61nym2blxoK+NouegX15J0+QG5gmroFE9Xrelrg18gUE5LeAgLHOy+p6
         7xyQ==
X-Gm-Message-State: ACgBeo0N3t/JL1FnepY8U30NT54j1+rv7ZUzMgRuuXQLoEK5TVT6FaIX
        BdfoiGnCYQ8BThVEwzajFWdqNHYCKRze
X-Google-Smtp-Source: AA6agR7tMgq2MydIuiLbFRALD7VglhSZQ49oBAFypwDzplY0X7b2ELaPYH2GyhoAA9lPc4bV4ZjhwA==
X-Received: by 2002:a05:6a00:1252:b0:52e:b81f:f70c with SMTP id u18-20020a056a00125200b0052eb81ff70cmr17534701pfi.5.1660002836704;
        Mon, 08 Aug 2022 16:53:56 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id er15-20020a17090af6cf00b001f303d149casm8654091pjb.50.2022.08.08.16.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 16:53:56 -0700 (PDT)
Message-ID: <8b5801a3-fa3a-acf4-0c34-a753ab7770ac@github.com>
Date:   Mon, 8 Aug 2022 16:53:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 9/9] mv: check overwrite for in-to-out move
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-10-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220805030528.1535376-10-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Add checking logic for overwriting when moving from in-cone to
> out-of-cone. It is the index version of the original overwrite logic.
> 
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/mv.c                  | 12 ++++++++++++
>  t/t7002-mv-sparse-checkout.sh |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 765a1e8eb5..70996d582f 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -367,6 +367,18 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			goto act_on_entry;
>  		}
>  
> +		if (ignore_sparse &&

If '--sparse' is specified...

> +		    (dst_mode & SKIP_WORKTREE_DIR) &&

...and the destination's parent directory is outside the sparse cone...

> +		    index_entry_exists(&the_index, dst, strlen(dst))) {

...and the destination file exists in the index, then we're going to be
overwriting an existing index entry. 

> +			bad = _("destination exists in the index");
> +			if (force) {
> +				if (verbose)
> +					warning(_("overwriting '%s'"), dst);
> +				bad = NULL;
> +			} else {
> +				goto act_on_entry;
> +			}
> +		}

The rest of this aligns with what's done for a normal (exists on-disk)
overwrite. There's not much in the original overwrite-handling logic that
can be reused here (it's checking for overwrite based on 'stat' rather than
the contents of the index), so code structure-wise this makes sense as a
standalone check.

Looking good!

>  		/*
>  		 * We check if the paths are in the sparse-checkout
>  		 * definition as a very final check, since that
> diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
> index f0b32a2f70..50bcca583c 100755
> --- a/t/t7002-mv-sparse-checkout.sh
> +++ b/t/t7002-mv-sparse-checkout.sh
> @@ -323,7 +323,7 @@ test_expect_success 'move clean path from in-cone to out-of-cone' '
>  	grep "S folder1/d" actual
>  '
>  
> -test_expect_failure 'move clean path from in-cone to out-of-cone overwrite' '
> +test_expect_success 'move clean path from in-cone to out-of-cone overwrite' '
>  	test_when_finished "cleanup_sparse_checkout" &&
>  	setup_sparse_checkout &&
>  	echo "sub/file1 overwrite" >sub/file1 &&

