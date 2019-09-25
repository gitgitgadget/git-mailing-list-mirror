Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27BE91F464
	for <e@80x24.org>; Wed, 25 Sep 2019 12:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405641AbfIYMwI (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 08:52:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:47010 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732452AbfIYMwI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 08:52:08 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so5077053qkd.13
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wa7KQifklyR+AN3HZ+jj/NHxHLPDID4iGY2q/0xYOuo=;
        b=EWsLyLv5ScFFYJCby7+JLGdE9nYRl+qkRU7rDYb9mghYCPxNzJLdUPJbe3aIANWa9V
         9rVkH0K35YFX+PyhPBizn0RS/8GL7p0X9ktX7/hiddFphpI8BYJdNfgsDfIzpO0VzAvk
         0UEmUjQ360dHaLAZJUCxoZmTtAb05PJG5unq85dXyKNDhaoAYvP1qY990VM8QM1ZslWX
         zKgdIaXnbow9S38NxmwwfKAVmcCdWJUmCFOhRV/FwelM9wXs31oyTXd73blDTCatiG4N
         fMuWRYKIjdbvp07idsdTvDD26SJ5fhys/HwG3OE4rvF7cInjmg32+tQg7bJJpdb5wH+G
         cpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wa7KQifklyR+AN3HZ+jj/NHxHLPDID4iGY2q/0xYOuo=;
        b=o+6NuJLjXzZQMQU5Fhb8M9ltfShKzfPTaqsxG0aCOSqdkNQB4egrOvFPMtw41HRPyr
         HdThflfiv9KpMJleRYw/RJ38El3XlcVyrIvNi6OcWGNB0c2GmSRS6HOC0+QaisDLLLuf
         kDnIqKgtvPiEM+lz3oamXcbfXNrqCMZ60p3r98LqabFdu52EYLEV6BTJdYMXbe7HVDyf
         mBnuS4kacwOasiX3pWK8Q7BOOzXtIqUS+8IHqs3JDbAyUYqD8Fm49lOh9MmaNbsxvhzx
         Weg8luXQmphHCu3ifyKsRVfTuT6lN06DZWkvXihyq71YDVXZTsHDluvyk3m/TJ8cI1JJ
         xj8g==
X-Gm-Message-State: APjAAAX4cSrJaqteyVqoh/ag/r4RyJxGwPy1q/dQc8ToMnuPO+Uzf4wj
        4V1p3Di8N9dgvla3R5fOtENADCYnme8=
X-Google-Smtp-Source: APXvYqyjhoB+xbNXeZ+SarhZR4EvGUiNmOzBrqLhlOy1VQ6gLXOJdjng3kgxZyd3p5il4rrSDn/wNQ==
X-Received: by 2002:ae9:e609:: with SMTP id z9mr3402803qkf.50.1569415926802;
        Wed, 25 Sep 2019 05:52:06 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4cc1:b74:5d5b:b0b0? ([2001:4898:a800:1010:fdf6:b74:5d5b:b0b0])
        by smtp.gmail.com with ESMTPSA id q47sm5248540qtq.95.2019.09.25.05.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 05:52:06 -0700 (PDT)
Subject: Re: [PATCH v2 07/19] hashmap_get takes "const struct hashmap_entry *"
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20190924010324.22619-1-e@80x24.org>
 <20190924010324.22619-8-e@80x24.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9dc71ed0-617c-84e8-b7fc-0766f4d83695@gmail.com>
Date:   Wed, 25 Sep 2019 08:52:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190924010324.22619-8-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2019 9:03 PM, Eric Wong wrote:
> This is less error-prone than "const void *" as the compiler
> now detects invalid types being passed.
[snip]
> diff --git a/hashmap.h b/hashmap.h
> index 40bcc64289..2a4b4a3954 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -74,7 +74,8 @@
>   *             e->key = key;
>   *
>   *             flags |= COMPARE_VALUE;
> - *             printf("%sfound\n", hashmap_get(&map, e, NULL) ? "" : "not ");
> + *             printf("%sfound\n",
> + *                    hashmap_get(&map, &e->ent, NULL) ? "" : "not ");
>   *             free(e);
>   *         }
>   *
> @@ -84,7 +85,8 @@
>   *             k.key = key;
>   *
>   *             flags |= COMPARE_VALUE;
> - *             printf("%sfound\n", hashmap_get(&map, &k, value) ? "" : "not ");
> + *             printf("%sfound\n",
> + *                    hashmap_get(&map, &k->ent, value) ? "" : "not ");
>   *         }
>   *
>   *         if (!strcmp("end", action)) {
> @@ -286,7 +288,7 @@ static inline unsigned int hashmap_get_size(struct hashmap *map)
>   * If an entry with matching hash code is found, `key` and `keydata` are passed
>   * to `hashmap_cmp_fn` to decide whether the entry matches the key.
>   */
> -void *hashmap_get(const struct hashmap *map, const void *key,
> +void *hashmap_get(const struct hashmap *map, const struct hashmap_entry *key,
>  			 const void *keydata);

super-nit: the whitespace before the second line is "\t\t\t " but should be
"\t\t  ".

(I'm really struggling to find things wrong with this series. Am I not
reading it correctly, or is it just that good?)

Thanks,
-Stolee
