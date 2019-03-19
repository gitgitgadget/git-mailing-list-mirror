Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F8A620248
	for <e@80x24.org>; Tue, 19 Mar 2019 14:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfCSOGs (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 10:06:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46289 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfCSOGs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 10:06:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id o1so1954821wrs.13
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kJZSYRhKi8kJvig0MMlFuJw7+JlItfr5QTvaYHd3ufc=;
        b=OFMGhIgOQKqoKwTHxKi3BW2p8FUZIieIiaAZGYhwACYs6BYZP35FdAdN9xXN1ozvi3
         /fK8l3SPV4A9fX9leTDfAiLoKGN+KsoIzmIprs8kgOvtNY57Le2JAj3zim0KRx3rUyfc
         rBw2QDuP0BB5nJwXUi982ZkbExAdsiOCMeHVr+TYnl5VX0HYeJJUdFV1w8KungmkbMxr
         BuEr/1sVhulYLiJYs7khDLxb1DgVAXWTIcAIJYNTuSzfzO6R/R+CB25SKq/8469yOuBg
         lJe7X8E1ZcZutA2iU1D5/c28jDSlxXTuvS2eC0aitN70ID+gqz+xY7gpx9iF6uhqvAZG
         UVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kJZSYRhKi8kJvig0MMlFuJw7+JlItfr5QTvaYHd3ufc=;
        b=QR1maTrPfGbpXnaE0bL3hXJFxhIQLQlBS1K6crcqA5MKSMkdt6XX6PQf8iwUEz4JHc
         rSUMX70MjwJFPjbYmA7V2P3LI8ZbLVHq56LSjUs2a+AYPVx+vHpZrD36+WhR2GUE5UiV
         2UmvFkT54xjtS3c+7JZonYflHK0awBReqZUBNBdTB+aBqSiGEke4Y4Bfmsw59b8qzEFv
         OOt7wBApOM/AJYhleqLn3fU1UKOjyx5EvxMw+4zZN4gh3k/9qXstFDaEdQmBePBtTvf1
         h/BocKKcKpSy6QHfkwW+rY8FbGvvUnX2/ITKSzhBYtYpgXOM71LA7Iv7lvzP2gLZEsaF
         QHmw==
X-Gm-Message-State: APjAAAUCnngTLMgMnD/Y/n1LR89GAjEfIQd02F3drSoLJCjerj6zFAD6
        7XnhBbJFQjpd4Ytt61evFuE=
X-Google-Smtp-Source: APXvYqzEtj0M0UbBLHmVe1KhO6bDh2eeKBdRPYW5tjlRbMzYbSt0Wfa9JUJXjWV7bxjO+7GEQVWGMQ==
X-Received: by 2002:adf:ce8f:: with SMTP id r15mr6994442wrn.90.1553004406135;
        Tue, 19 Mar 2019 07:06:46 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id s10sm6857148wrv.56.2019.03.19.07.06.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 07:06:45 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] unpack-trees: fix oneway_merge accidentally carry over
 stage index
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        newren@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
References: <20190317060023.3651-1-pclouds@gmail.com>
 <20190318113822.6195-1-pclouds@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <228d681e-4cfd-7e2e-8bb9-1624cc244a9f@gmail.com>
Date:   Tue, 19 Mar 2019 14:06:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190318113822.6195-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy

Thanks for doing this, one minor comment - I try to use 
phillip.wood@dunelm.org.uk for git as it wont change if I change my 
email provider.

Best Wishes

Phillip

On 18/03/2019 11:38, Nguyễn Thái Ngọc Duy wrote:
> Phillip found out that 'git checkout -f <branch>' does not restore
> conflict/unmerged files correctly. All tracked files should be taken
> from <branch> and all non-zero stages removed. Most of this is true,
> except that the final file could be in stage one instead of zero.
> 
> "checkout -f" (among other commands) does this with one-way merge, which
> is supposed to take stat info from the index and everything else from
> the given tree. The add_entry(.., old, ...) call in oneway_merge()
> though will keep stage index from the index.
> 
> This is normally not a problem if the entry from the index is
> normal (stage #0). But if there is a conflict, stage #0 does not exist
> and we'll get stage #1 entry as "old" variable, which gets recorded in
> the final index. Fix it by clearing stage mask.
> 
> This bug probably comes from b5b425074e (git-read-tree: make one-way
> merge also honor the "update" flag, 2005-06-07). Before this commit, we
> may create the final ("dst") index entry from the one in index, but we
> do clear CE_STAGEMASK.
> 
> I briefly checked two- and three-way merge functions. I think we don't
> have the same problem in those.
> 
> Reported-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   v2 updates log message to describe the problem and moves the test to
>   t2023-checkout.m.sh
> 
>   t/t2023-checkout-m.sh | 24 ++++++++++++++++++++++++
>   unpack-trees.c        |  2 +-
>   2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t2023-checkout-m.sh b/t/t2023-checkout-m.sh
> index 7e18985134..fca3f85824 100755
> --- a/t/t2023-checkout-m.sh
> +++ b/t/t2023-checkout-m.sh
> @@ -46,4 +46,28 @@ test_expect_success '-m restores 3-way conflicted+resolved file' '
>   	test_cmp both.txt.conflicted.cleaned both.txt.cleaned
>   '
>   
> +test_expect_success 'force checkout a conflict file creates stage zero entry' '
> +	git init co-force &&
> +	(
> +		cd co-force &&
> +		echo a >a &&
> +		git add a &&
> +		git commit -ama &&
> +		A_OBJ=$(git rev-parse :a) &&
> +		git branch topic &&
> +		echo b >a &&
> +		git commit -amb &&
> +		B_OBJ=$(git rev-parse :a) &&
> +		git checkout topic &&
> +		echo c >a &&
> +		C_OBJ=$(git hash-object a) &&
> +		git checkout -m master &&
> +		test_cmp_rev :1:a $A_OBJ &&
> +		test_cmp_rev :2:a $B_OBJ &&
> +		test_cmp_rev :3:a $C_OBJ &&
> +		git checkout -f topic &&
> +		test_cmp_rev :0:a $A_OBJ
> +	)
> +'
> +
>   test_done
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 22c41a3ba8..1ccd343cad 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2386,7 +2386,7 @@ int oneway_merge(const struct cache_entry * const *src,
>   		if (o->update && S_ISGITLINK(old->ce_mode) &&
>   		    should_update_submodules() && !verify_uptodate(old, o))
>   			update |= CE_UPDATE;
> -		add_entry(o, old, update, 0);
> +		add_entry(o, old, update, CE_STAGEMASK);
>   		return 0;
>   	}
>   	return merged_entry(a, old, o);
> 
