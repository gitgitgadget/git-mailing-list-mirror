Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489EA1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 13:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeCLNzt (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 09:55:49 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37693 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeCLNzs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 09:55:48 -0400
Received: by mail-qt0-f193.google.com with SMTP id a23so7456646qtm.4
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 06:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=q694sqh5ZRgk6jlMiCkSm4mMpvfnUTRQU/MYXQoa0eo=;
        b=Ae33HFGmP04IASGzRqihDa4psMnct5EWs7OMyLIG3yCn7/BZ/5gHrovRSksIRCasbR
         cY7GILrUfpWCeWILyfqS3gGMzbKNKjjBJw1eP108akpFqdUxBrvBr29KSJneHv7QDD/T
         T48z8IwXULXP9YaRyWX6baZcpvkvyiQHEJVodgJNokNAJWxWiUCjI5PPV4yCI0b9fqa3
         OUwDvT5Q2TRDONZvAy2yGKGD2RR8VLSYABGJVn4zD2rAV4eSHA5wkNYv6WBybpJ4x3SQ
         7eN2CLHDZtcqgn9VtAmyYkjc5f9Z0BaBOZTDxEuBuXbOVBhOwLd0Oc3fbR/68NZUtwEi
         HPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=q694sqh5ZRgk6jlMiCkSm4mMpvfnUTRQU/MYXQoa0eo=;
        b=qn5VWgtbgbkCzHjOoPtcOSbAwOUr12wjpz34wnXzGsRsQkUKB4AiI7Qv4cFcWhJa66
         1RDR985P9W0UEdG467qjp6mu+r315GFb+Mjv//RqTNfxgsAWhhGEGVh7bjdqsY3zs6Ua
         pPDOlBzDr5kl/f4Koqly7DpRMWpQBgekq/W9YqJniZZeOQXEv3nbXKRd8FVW92KxLt6y
         Z7xerms0UXuvylISChna9qT6S+lTr2ys/QM1N0K9TpGHRvhWH8eKaU0VFFHPyyjAQ/SU
         wPmk9+PpBvdPfbc7W+SV3GVWnFnI+Q98SrYyqzfQgaZm7vHTR4+msvyN16njOHzcZYCj
         V29A==
X-Gm-Message-State: AElRT7Fxwy7vpwnEZZt8OZ37fCgAC0xY5kSLG5STTXqTMsbmFkqzIqks
        NwXEwVDtVDxBOL61Uy/6MZA=
X-Google-Smtp-Source: AG47ELs3gLMIKnJ+tDGeR5GvUilq5K5354nODX03UFxiL+k0j+FOQipj7OPN6ZHU1djsxfxK3oiC5A==
X-Received: by 10.237.33.170 with SMTP id l39mr12420410qtc.100.1520862947414;
        Mon, 12 Mar 2018 06:55:47 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id t68sm2150353qkg.58.2018.03.12.06.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 06:55:46 -0700 (PDT)
Subject: Re: [PATCH v5 04/13] csum-file: add CSUM_KEEP_OPEN flag
From:   Derrick Stolee <stolee@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <1519698787-190494-5-git-send-email-dstolee@microsoft.com>
Message-ID: <e1264d9a-9d6c-b294-6d56-46382a28b280@gmail.com>
Date:   Mon, 12 Mar 2018 09:55:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519698787-190494-5-git-send-email-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/26/2018 9:32 PM, Derrick Stolee wrote:
> This patch is new to the series due to the interactions with the lockfile API
> and the hashfile API. I need to ensure the hashfile writes the hash value at
> the end of the file, but keep the file descriptor open so the lock is valid.
>
> I welcome any susggestions to this patch or to the way I use it in the commit
> that follows.
>
> -- >8 --

I haven't gotten any feedback on this step of the patch. Could someone 
take a look and let me know what you think?

Thanks,
-Stolee

> If we want to use a hashfile on the temporary file for a lockfile, then
> we need hashclose() to fully write the trailing hash but also keep the
> file descriptor open.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>   csum-file.c | 10 +++++++---
>   csum-file.h |  1 +
>   2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/csum-file.c b/csum-file.c
> index 5eda7fb..302e6ae 100644
> --- a/csum-file.c
> +++ b/csum-file.c
> @@ -66,9 +66,13 @@ int hashclose(struct hashfile *f, unsigned char *result, unsigned int flags)
>   		flush(f, f->buffer, the_hash_algo->rawsz);
>   		if (flags & CSUM_FSYNC)
>   			fsync_or_die(f->fd, f->name);
> -		if (close(f->fd))
> -			die_errno("%s: sha1 file error on close", f->name);
> -		fd = 0;
> +		if (flags & CSUM_KEEP_OPEN)
> +			fd = f->fd;
> +		else {
> +			if (close(f->fd))
> +				die_errno("%s: sha1 file error on close", f->name);
> +			fd = 0;
> +		}
>   	} else
>   		fd = f->fd;
>   	if (0 <= f->check_fd) {
> diff --git a/csum-file.h b/csum-file.h
> index 992e5c0..b7c0e48 100644
> --- a/csum-file.h
> +++ b/csum-file.h
> @@ -29,6 +29,7 @@ extern int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
>   /* hashclose flags */
>   #define CSUM_CLOSE	1
>   #define CSUM_FSYNC	2
> +#define CSUM_KEEP_OPEN	4
>   
>   extern struct hashfile *hashfd(int fd, const char *name);
>   extern struct hashfile *hashfd_check(const char *name);

