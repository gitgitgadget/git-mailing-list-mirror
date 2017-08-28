Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A25B208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 22:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbdH1WnB (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 18:43:01 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34819 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbdH1WnA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 18:43:00 -0400
Received: by mail-qk0-f196.google.com with SMTP id p67so1496545qkd.2
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LwfkdB+ciXsW29w/PuSO9u/eFEcSblZDWwZoNRl2RZo=;
        b=eot+kq5GN40qOsHEHJsQ+Y2rWxRp2JXgqhdp73BSdRjaTnzENvD/GyeC/4g456OVL/
         H3ChvjB4EL/sGIeJLGIPzGS3IajbD08G6jDuhV1WoMm6zkDtkt5CO7lhks4EJu6CbQyz
         He61gL1eMnOnH4z3fr5E4iQt/vgUPiH/hRT2/Rnz4kHlFhM4mXEM7HiuF90xhFsw5yHF
         HkraJRMcURaKEBj/QPkFvZ/MfGLiZxc1OT99bPM29oPNau5M5aC0DkNTelPos0hfKM0E
         hX6GKpeUDwhxaywcXhlcbejFjAFAx5YWBepmx8cyQ5RpDkFukAuk8CkCkO88HrodBy3b
         6QxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LwfkdB+ciXsW29w/PuSO9u/eFEcSblZDWwZoNRl2RZo=;
        b=rBUHSsYuPpE9gY4dwcu8jKw6p/ZK5CiD27f9HjodjWZSKP3FaCI0M5i/zeWCCnD7PK
         bFD3+eXajtnhmR9ql9TLysoH7yFhoLKuqnKMxT9rffand+E7eAPCr6yAjqPYdtCNddzp
         Qf73Nb1KmBXe7MwOzVICk3Cig7bopybhps6YcUlGM4/wrQU0/RZbvM6p6EkWM9dEEfyX
         b2IqkDI8Xd9SJjASNXyJb0Q7zxC8lsfC4o+H3Eoa3MHi01puND7rsqixqqVM3xOlA+eK
         SiVXbqeIABaE/78IOvw5mMD1E9Etwp+Mr1LEiiun+54PVL4GoEWEKwrIkcT0rn3GaYHe
         38AA==
X-Gm-Message-State: AHPjjUg0se/RX6AUjICrxOirO9/lP2MRsCtRtbyeHR42Y6fyJPu48C7n
        NW0aatLPDBzRzA==
X-Received: by 10.55.80.67 with SMTP id e64mr2883663qkb.197.1503960179406;
        Mon, 28 Aug 2017 15:42:59 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t200sm990909qke.28.2017.08.28.15.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Aug 2017 15:42:58 -0700 (PDT)
Subject: Re: [PATCH 1/3] merge-recursive: fix memory leak
To:     Kevin Willford <kewillf@microsoft.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
References: <20170828202829.3056-1-kewillf@microsoft.com>
 <20170828202829.3056-2-kewillf@microsoft.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <770a93c1-9115-3104-ebae-3cdc69d658de@gmail.com>
Date:   Mon, 28 Aug 2017 18:42:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170828202829.3056-2-kewillf@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/28/2017 4:28 PM, Kevin Willford wrote:
> In merge_trees if process_renames or process_entry returns less
> than zero, the method will just return and not free re_merge,
> re_head, or entries.
> 
> This change cleans up the allocated variables before returning
> to the caller.
> 
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>

Nice catch on the leaks.  Looks good to me.

> ---
>   merge-recursive.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 1494ffdb82..033d7cd406 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1956,7 +1956,7 @@ int merge_trees(struct merge_options *o,
>   		re_merge = get_renames(o, merge, common, head, merge, entries);
>   		clean = process_renames(o, re_head, re_merge);
>   		if (clean < 0)
> -			return clean;
> +			goto cleanup;
>   		for (i = entries->nr-1; 0 <= i; i--) {
>   			const char *path = entries->items[i].string;
>   			struct stage_data *e = entries->items[i].util;
> @@ -1964,8 +1964,10 @@ int merge_trees(struct merge_options *o,
>   				int ret = process_entry(o, path, e);
>   				if (!ret)
>   					clean = 0;
> -				else if (ret < 0)
> -					return ret;
> +				else if (ret < 0) {
> +					clean = ret;
> +					goto cleanup;
> +				}
>   			}
>   		}
>   		for (i = 0; i < entries->nr; i++) {
> @@ -1975,6 +1977,7 @@ int merge_trees(struct merge_options *o,
>   				    entries->items[i].string);
>   		}
>   
> +cleanup:
>   		string_list_clear(re_merge, 0);
>   		string_list_clear(re_head, 0);
>   		string_list_clear(entries, 1);
> @@ -1982,6 +1985,9 @@ int merge_trees(struct merge_options *o,
>   		free(re_merge);
>   		free(re_head);
>   		free(entries);
> +
> +		if (clean < 0)
> +			return clean;
>   	}
>   	else
>   		clean = 1;
> 
