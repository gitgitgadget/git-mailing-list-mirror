Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8751EB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 09:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbjGNJ5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 05:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGNJ46 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 05:56:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BC7A7
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 02:56:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-315adee6ac8so1805757f8f.2
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 02:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689328616; x=1691920616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1LLJXGRPnO0yYXkKLrwOXPea0t9qmXDDFfqLpbplfAU=;
        b=kDK2Di6s/OPB2gSWmrpyayD8Z8IYf5G6mSVNU41bVUH7CYbAyys+r1Ds8JwBnDHAHf
         bqtfwFDjrdrdJmmIaEaGxGWI8ErKsp2uXlG+pyBhdMkwJaCGMu3wP2Rm/kd/AjqEdAWy
         be87VKuddotKycZRH/vke8YOlzie7cgDILn58m40zWkNdgvt1y7cjsnuWUM/o+BJKOho
         DgCKilGGCFCsIr6GtzPPrbs3DqmZRFJHcqhZ4KfchxZhAl/M7T+yZ1aXLooKChUZ3HwQ
         CMESoKP1r+Ha9vw3Daj40g1VVK+x795eJCoz8hLzlOiU5kXEAW9GpD3ufdX3S4JxVVYc
         mouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328616; x=1691920616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LLJXGRPnO0yYXkKLrwOXPea0t9qmXDDFfqLpbplfAU=;
        b=EMJtmmMoFKx+Q+l8hkcCoHSMkG+xXV8uV+Dnei0OzCnXU/I5zD2bJQyeblzTFvqHIl
         iCEVx7jfY6vleMkALIydTSnf5FV6aPT6eUhokOhKVQjCi0koQYZjiHM3DeB44O52HC+0
         RDIvwG4EpuPw5PyVFMGZYux9K+nKQ9kDLpZSVuR/S/TRPmeQqznI6Qzytcfyo93xI1yT
         wnmCZVsFc1lhk3sYU3yCoXBgFckIOi7+YyIW/M3knpIun6We/CvcO/kC+RJKYFeRY61v
         cJmmAaUo9nwQVGwzrLnywY8laad36aYg1rqNd38ttJymV/Un6XVrIne71HIGlvQ7AVjy
         Bkcg==
X-Gm-Message-State: ABy/qLbJAUPXLdrbbe7mh3qdebnpiMEFk0l6SQ1RvN06ZYJQSZAxHNWq
        U90YANiW0Msr2+v81FCumv4=
X-Google-Smtp-Source: APBJJlFILfrKnovEV3EEZmNcA88m0GQsTT/9Yh9A9b9sUO2u0S8qjRjBAhPUs5nqpodHUF9PdMWd1A==
X-Received: by 2002:a5d:5505:0:b0:313:f98a:1fd3 with SMTP id b5-20020a5d5505000000b00313f98a1fd3mr4201170wrv.27.1689328615874;
        Fri, 14 Jul 2023 02:56:55 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm10379469wrx.48.2023.07.14.02.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 02:56:55 -0700 (PDT)
Message-ID: <460ff25f-bc2a-2687-923b-7053668f1ce3@gmail.com>
Date:   Fri, 14 Jul 2023 10:56:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 02/20] packfile.c: prevent overflow in `load_idx()`
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <cover.1689205042.git.me@ttaylorr.com>
 <d6902cd9e7f7f2a6b8044c8fb782a28c23e15600.1689205042.git.me@ttaylorr.com>
 <5d2cf09f-34c7-9a88-bab2-8bf348dd13bb@gmail.com>
 <ZLAJNbIBFUPHYhlt@nand.local> <ZLCc3mRbdXPllpAp@nand.local>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZLCc3mRbdXPllpAp@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/07/2023 01:54, Taylor Blau wrote:
> On Thu, Jul 13, 2023 at 10:24:53AM -0400, Taylor Blau wrote:
>> On Thu, Jul 13, 2023 at 09:21:55AM +0100, Phillip Wood wrote:
>>> p->crc_offset is a uint32_t so we're still prone to truncation here unless
>>> we change the crc_offset member of struct packed_git to be a size_t. I
>>> haven't checked if the other users of crc_offset would need adjusting if we
>>> change its type.
>>
>> Thanks for spotting. Luckily, this should be a straightforward change:
> 
> Here's a replacement patch which changes the type of `crc_offset`. If
> there end up being other review comments, I'll fold this into the next
> round.
> 
> --- 8< ---
> Subject: [PATCH] packfile.c: prevent overflow in `load_idx()`
> 
> Prevent an overflow when locating a pack's CRC offset when the number
> of packed items is greater than 2^32-1/hashsz by guarding the
> computation with an `st_mult()`.
> 
> Note that to avoid truncating the result, the `crc_offset` member must
> itself become a `size_t`. The only usage of this variable (besides the
> assignment in `load_idx()`) is in `read_v2_anomalous_offsets()` in the
> index-pack code. There we use the `crc_offset` as a pointer offset, so
> we are already equipped to handle the type change.

Thanks for adding that explanation, this version looks good to me

Best Wishes

Phillip

> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>   object-store-ll.h | 2 +-
>   packfile.c        | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/object-store-ll.h b/object-store-ll.h
> index e8f22cdb1b..26a3895c82 100644
> --- a/object-store-ll.h
> +++ b/object-store-ll.h
> @@ -106,7 +106,7 @@ struct packed_git {
>   	const void *index_data;
>   	size_t index_size;
>   	uint32_t num_objects;
> -	uint32_t crc_offset;
> +	size_t crc_offset;
>   	struct oidset bad_objects;
>   	int index_version;
>   	time_t mtime;
> diff --git a/packfile.c b/packfile.c
> index 89220f0e03..70acf1694b 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -186,7 +186,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
>   		     */
>   		    (sizeof(off_t) <= 4))
>   			return error("pack too large for current definition of off_t in %s", path);
> -		p->crc_offset = 8 + 4 * 256 + nr * hashsz;
> +		p->crc_offset = st_add(8 + 4 * 256, st_mult(nr, hashsz));
>   	}
> 
>   	p->index_version = version;
> --
> 2.41.0.329.g0a1adfae833
> --- >8 ---
> 
> Thanks,
> Taylor

