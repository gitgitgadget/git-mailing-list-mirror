Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 191D51F597
	for <e@80x24.org>; Mon, 30 Jul 2018 20:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbeG3WfS (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 18:35:18 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35693 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeG3WfR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 18:35:17 -0400
Received: by mail-qt0-f169.google.com with SMTP id a5-v6so13677786qtp.2
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 13:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AOKNYPYJ5K2WdrpEqbhaMIqeQ7coYOHJISj1fZCMp5s=;
        b=h7uRWJdZO0/0sUQrjWcH+dhc2On8LF0rJqKclkaAObRIE+kfFZFYMn1JY8fvT1NfMN
         /WOoFcKb1yl68bvG9Q5ZEKx5Ol9pyBtllBEf0IUQRqtN3LPZIjMbbqO4ItoWL967vmyR
         S2fk8ENWt9WrZb7DjEYvRuw/pHw05DRXdc7j8oGxk3X20rcISPIWmJsGOqvYl0EpyrIr
         TVKZKAsOnEs/FOPG/a0lE+itSXIoz7n1RtyR0YI2zko+GycDdMWIY9hpLvMTt7UVOS+8
         9diJNB+P1J4RBFhOBAI6Gn+UR5D/AuheiD8Rf/KZzElDqbNQYgbD4PmCBJRGY8ywn2fo
         3/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AOKNYPYJ5K2WdrpEqbhaMIqeQ7coYOHJISj1fZCMp5s=;
        b=gKpI6KaKN87NstREWlrxXYktE+1fA25vOcO8E/39Z6JJjG3/427iEeanSpTd2ZcLIz
         ijnvaqGDvZI6gUjRW/fgqgFIh0qnmemKXQ0YnyhDFRzFoudjbCenylqxEyVmu+RVncDw
         CRuUPBeomS9yRZAeDx+HltBER8oR777G+UH7JTEHmWkuvNU2xszazX2vSIMxaY0Uz4K9
         osN2UfpPn3h9Ut+Teg+tHiTYPyIGncyAuYmntuparhN7cKC+gDKQ6I+35ubXLBIZ7Fwy
         E9plt0vbX0IY0x+iYkPHSMh+Tgd+F6p8J/PjjBUbIw5lmYKF/TdC1pBgKfLXjcu4aHnc
         Lh+w==
X-Gm-Message-State: AOUpUlHbw4bBhtzD/hpK0iaJFF5QqGtOpe+TIX0B97CCTubx5RF6RuBl
        zzVCoekVIPIVth2HjapLh5g=
X-Google-Smtp-Source: AAOMgpeKMm7pRSg8MQoRIaPEzcp7FCCwBulhAWb/19zFN3edteHeQoH3HLgFEEkVyd6DpE83F1PD6g==
X-Received: by 2002:ac8:36ac:: with SMTP id a41-v6mr18962460qtc.139.1532984309519;
        Mon, 30 Jul 2018 13:58:29 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id p64-v6sm9222137qkl.30.2018.07.30.13.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 13:58:28 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] unpack-trees: reduce malloc in cache-tree walk
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net
References: <20180727154241.GA21288@duynguyen.home>
 <20180729103306.16403-1-pclouds@gmail.com>
 <20180729103306.16403-4-pclouds@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0cbba28a-1820-63bf-b31c-cb3774d7d5bd@gmail.com>
Date:   Mon, 30 Jul 2018 16:58:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729103306.16403-4-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/29/2018 6:33 AM, Nguyễn Thái Ngọc Duy wrote:
> This is a micro optimization that probably only shines on repos with
> deep directory structure. Instead of allocating and freeing a new
> cache_entry in every iteration, we reuse the last one and only update
> the parts that are new each iteration.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   unpack-trees.c | 29 ++++++++++++++++++++---------
>   1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 39566b28fb..c33ebaf001 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -694,6 +694,8 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
>   {
>   	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
>   	struct unpack_trees_options *o = info->data;
> +	struct cache_entry *tree_ce = NULL;
> +	int ce_len = 0;
>   	int i, d;
>   
>   	if (!o->merge)
> @@ -708,30 +710,39 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
>   	 * in the first place.
>   	 */
>   	for (i = 0; i < nr_entries; i++) {
> -		struct cache_entry *tree_ce;
> -		int len, rc;
> +		int new_ce_len, len, rc;
>   
>   		src[0] = o->src_index->cache[pos + i];
>   
>   		len = ce_namelen(src[0]);
> -		tree_ce = xcalloc(1, cache_entry_size(len));
> +		new_ce_len = cache_entry_size(len);
> +
> +		if (new_ce_len > ce_len) {
> +			new_ce_len <<= 1;
> +			tree_ce = xrealloc(tree_ce, new_ce_len);
> +			memset(tree_ce, 0, new_ce_len);
> +			ce_len = new_ce_len;
> +
> +			tree_ce->ce_flags = create_ce_flags(0);
> +
> +			for (d = 1; d <= nr_names; d++)
> +				src[d] = tree_ce;
> +		}

Nice optimization - especially when there are a lot of cache entries and 
large trees.

>   
>   		tree_ce->ce_mode = src[0]->ce_mode;
> -		tree_ce->ce_flags = create_ce_flags(0);
>   		tree_ce->ce_namelen = len;
>   		oidcpy(&tree_ce->oid, &src[0]->oid);
>   		memcpy(tree_ce->name, src[0]->name, len + 1);
>   
> -		for (d = 1; d <= nr_names; d++)
> -			src[d] = tree_ce;
> -
>   		rc = call_unpack_fn((const struct cache_entry * const *)src, o);
> -		free(tree_ce);
> -		if (rc < 0)
> +		if (rc < 0) {
> +			free(tree_ce);
>   			return rc;
> +		}
>   
>   		mark_ce_used(src[0], o);
>   	}
> +	free(tree_ce);
>   	if (o->debug_unpack)
>   		printf("Unpacked %d entries from %s to %s using cache-tree\n",
>   		       nr_entries,
> 
