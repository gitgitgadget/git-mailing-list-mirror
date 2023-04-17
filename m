Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C98C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 21:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjDQVCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 17:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDQVBr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 17:01:47 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81813C648
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:59:46 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1880110ebe5so2165123fac.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681765185; x=1684357185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybgZkggMkjM+5fvUsM2m1vB+Jme5O9ooMZJrREwFojk=;
        b=cluLZiNqGx6KkYNEVP2hwR1VS4e5lZNK0IhWr9jzq4mRwLE3veQKPbfAqT3LZjdL2L
         oBdW3I9Vu7LxLmyFFn2oNFkBHkXp3gKCaKgRLX/A9clPx6neq+x+EbHC88rxIlWnsaQG
         bB6DNsO2JeITFNn8DWSnWN8uLMEHbzu4J3F6hQrIsuacqJkrRP+Y8SxqkIV8onk/Qz+n
         TAfJqXns2bUyO95liPN2GntJyxfty3SAoOnmkdR0RyXGtKm0NR8bdZELlmM6z54BysRl
         LqNuexXEuQRNwEcTl7V1hDQrgzJoF1rhoF6RHFwfcGFucQ6I6Im4dFXno9AuKyeXEpc1
         YOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681765185; x=1684357185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybgZkggMkjM+5fvUsM2m1vB+Jme5O9ooMZJrREwFojk=;
        b=CWnmGW9Za5Szs6Q1j6y9BjLxbWJL8Q8WqpvARtRDNZ7ie8V5CyKdgKLPXA/e6MrFoO
         9JHukzlYwatM6GEJHu/Z7140XDKt9tj7Ljl2Q7n7z3lifoX2oCyQXmRjXW5WzCxgaXKw
         1Ljpd/pCVwzmNt31HxvjHZZRPWc6EymoF4bnAoeuFjIYswOtJsyc/4mlbKghwjSRR4xl
         7WoRcVBqfZjFy15RAZ95xaYxSKiJ/v/VY5I2FH5oob6uxjTgwev+aIhv8IvaVqrHwx4G
         N5JPNAETiPYJA3mvwBYS2+TyAzvnEpq6vvFAviMQDfVTpgst74am9gNUStr5emAzmv1t
         wIzw==
X-Gm-Message-State: AAQBX9epVs1m+7Gt7mmr+CicFjS3X0l+8HHM9/MAUcfUszDPI4ue6y8H
        00LJfbGMU/oVMHOBWewHSo1gdwVENdx6XXYQkw==
X-Google-Smtp-Source: AKy350Z2QqPllwWBiyxK3R4JV7hfD5Rcd5MRAWC5GMXL8DsGIo2yWieBJkozD3xJWfl+g1dKNwYONw==
X-Received: by 2002:a05:6870:589b:b0:187:a6fd:f1c9 with SMTP id be27-20020a056870589b00b00187a6fdf1c9mr8443663oab.19.1681765185599;
        Mon, 17 Apr 2023 13:59:45 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i5-20020a9d68c5000000b006a14579a8besm3964766oto.43.2023.04.17.13.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 13:59:45 -0700 (PDT)
Message-ID: <ad90e716-ba23-040f-66be-4c4faff02ea8@github.com>
Date:   Mon, 17 Apr 2023 16:59:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 14/23] hash.h, repository.h: reverse the order of these
 dependencies
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, Elijah Newren <newren@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <1c6989ae456c86850761b079384f1505735e317a.1681614206.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <1c6989ae456c86850761b079384f1505735e317a.1681614206.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/15/2023 11:03 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Previously, hash.h depended upon and included repository.h, due to
> the definition and use of the_hash_algo (defined as
> the_repository->hash_algo).  Move this #define, and the associated
> inline functions that depend upon it, from hash.h to repository.h.
> Due to that movement, reverse the dependencies so repository.h includes
> hash.h.
> 
> This allows hash.h and object.h to be fairly small, minimal headers.  It
> also exposes a lot of hidden dependencies on both path.h (which was
> brought in by repository.h) and repository.h (which was previously
> implicitly brought in by object.h).

This is the first patch in the series where I don't immediately agree
with the patch. This is a big list of methods that don't seem like
they fit in repository.h:

> diff --git a/repository.h b/repository.h
> +static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
> +static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
> +static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
> +static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
> +static inline int is_null_oid(const struct object_id *oid)
> +static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
> +static inline void oidcpy_with_padding(struct object_id *dst,
> +				       const struct object_id *src)
> +static inline void hashclr(unsigned char *hash)
> +static inline void oidclr(struct object_id *oid)
> +static inline void oidread(struct object_id *oid, const unsigned char *hash)
> +static inline int is_empty_blob_sha1(const unsigned char *sha1)
> +static inline int is_empty_blob_oid(const struct object_id *oid)
> +static inline int is_empty_tree_sha1(const unsigned char *sha1)
> +static inline int is_empty_tree_oid(const struct object_id *oid)

The goal to remove repository.h from hash.h and object.h makes sense
as a goal, but is there another way to do it? Can we redefine
'extern struct repository *the_repository;' in hash.h so we have
access to that pointer?

Thanks,
-Stolee
