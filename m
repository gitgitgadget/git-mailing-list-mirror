Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2484BCD6134
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 10:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjJJKAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 06:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjJJKAU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 06:00:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AC19F
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 03:00:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4066241289bso51110005e9.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696932016; x=1697536816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bRltVjAUKRafJ94gSGd5WPf8MB19q7507kEZVyH8G+o=;
        b=MjBKqQ32BzzR1d1rtjSLQIAh4VEAXp9OyVlQXA0Hh1iZSSlidq4Nshx5id47vQ5U9r
         otBHZ+HEysjpAS6ue09AXDiJVjK1eRA0bBGQJu58gT6qcUNhBRyAa/nxkUxbvlVmlU6a
         tn+ArLhbevRVZLPPHD/K7d/D5hgPBKeZyEsMzprMZ3CPWRLiu+5rM6CGnG4p+2pH4xdr
         OQ6so4d9r4PNidVDlA+HWY1j+xEYFlaGRRjOuNG0l5ehSFGxKaIa/zB0kkMv0az3I9Zl
         YzdW/3dYgTqhySRZFiYkSEWMuf5MIkD397WVq7RfuA3E35wTZmP4PzcL11xazOnxQdpB
         P8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696932016; x=1697536816;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRltVjAUKRafJ94gSGd5WPf8MB19q7507kEZVyH8G+o=;
        b=ENJZVkof6lh5DHS4zf73vNpOUVLwkOgPv9XJ3YPPJrrrX+L11/4LtM1HNSIhrio6Oo
         TaHC4YshZZ8r/5JbDwsGMj0IdaftG2DGOpC2st35gR/uHkMHK5EFr3N6t5eEug6UmLuj
         DKLWIHxx0M5kh7jSaqyjyQhrKYRXqb3OKHRsiEF+QyL/79kHCK+TUkzDUBOj9G7rWNty
         ULNKu/qjhrR8P4uMkDT8DEYDtpzVnAYxFjHgFQwLwm2qmNbCjyUgmPvnDtwktitBBAHo
         vmxNU+IuSn9lvP8Y07YGCGdRSRtkuftXKzhN/DaJ8lU6RaRsbagatkjZDF+R9ESb6H3R
         xNYQ==
X-Gm-Message-State: AOJu0YzzEOC7PVcBp/L0tIg3viwIc81hKlgtrlelC2KtHvpEk0Hhp3o3
        Kq1pm852QzGMO2t4six741s=
X-Google-Smtp-Source: AGHT+IFG7qBaBT8cKWiRokkbVE1cXUHdwcVXD6HV8T057g4fOWPvN5fuqACOhZNqXcqW/7QFPFn3Jw==
X-Received: by 2002:a05:600c:259:b0:401:b204:3b8d with SMTP id 25-20020a05600c025900b00401b2043b8dmr16888435wmj.27.1696932016288;
        Tue, 10 Oct 2023 03:00:16 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id l2-20020a5d4802000000b0031fe0576460sm12205991wrq.11.2023.10.10.03.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 03:00:16 -0700 (PDT)
Message-ID: <1de0a6f3-e223-4e84-a6d2-51d9b51a02f6@gmail.com>
Date:   Tue, 10 Oct 2023 11:00:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 4/4] parse: separate out parsing functions from
 config.h
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20230627195251.1973421-1-calvinwan@google.com>
 <cover.1696021277.git.jonathantanmy@google.com>
 <5d9f0b3de08ab8541482b9b640db06b6d3000b86.1696021277.git.jonathantanmy@google.com>
In-Reply-To: <5d9f0b3de08ab8541482b9b640db06b6d3000b86.1696021277.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan

On 29/09/2023 22:20, Jonathan Tan wrote:
> diff --git a/parse.h b/parse.h
> new file mode 100644
> index 0000000000..07d2193d69
> --- /dev/null
> +++ b/parse.h
> @@ -0,0 +1,20 @@
> +#ifndef PARSE_H
> +#define PARSE_H
> +
> +int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);

Previously this function was private to config.c, now it needs to be 
public because it is still called by 
git_config_get_expiry_date_in_days(). As this is essentially an internal 
helper for git_parse_int() and friends it is a bit unfortunate that it 
is now public. Perhaps we should change 
git_config_get_expiry_date_in_days() to call git_parse_int() instead.
Then we can keep git_parse_signed() and git_parse_unsigned() private to 
parse.c.

> +int git_parse_ssize_t(const char *, ssize_t *);
> +int git_parse_ulong(const char *, unsigned long *);
> +int git_parse_int(const char *value, int *ret);
> +int git_parse_int64(const char *value, int64_t *ret);

This was previously private but I think it makes sense for it to be 
publicly available.

> +/**
> + * Same as `git_config_bool`, except that it returns -1 on error rather
> + * than dying.
> + */
> +int git_parse_maybe_bool(const char *);
> +int git_parse_maybe_bool_text(const char *value);

This used to be private to config.c and now has callers in parse.c and 
config.c. We should make it clear that non-config code is likely to want 
git_parse_maybe_bool() rather than this function.

Best Wishes

Phillip
