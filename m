Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE66DC636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 14:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjBWOLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 09:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBWOL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 09:11:28 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BFF55C08
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:11:27 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id ks17so11173694qvb.6
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOxdnh4jTcNWAuCy1kbgXj+2Z5SzI2SkBmtqGohxA8w=;
        b=CzjgKtRhdvNbfCe1CTsbL/Esuo3xF2EQDaPTBZ5XUkOda8iT68wLICBGpM9W07fv87
         4X7ZnKpa7uNO2KOLdxaydJGD1WRvzytGNYcgpPJOj6kuPMb1AK8GU9m1kFUHXXk5cA8g
         oIjO2CyqZdKa7Cy6GNqOQNacOXoaaIRN6WIgI1ql60/sXPBndueeTu3GhS8HH+gz0Sj2
         lLVDD5lJib4my9Oufuyw90Im1QbOFZq2fOpnyYpTWRGT1nnv01LgWYUk7ONVOV5PoWVQ
         nVego3q8/Z0MwOPe8CzRXFMq5NE6uYvJ4hUHiCb06diyEu6y7PKrc4H/zMaBm7amYL4z
         990Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOxdnh4jTcNWAuCy1kbgXj+2Z5SzI2SkBmtqGohxA8w=;
        b=DuxUtWmHpgJnBB54elXXlnL1XGuljNc3dFFMwrIBNiPj0tvkBoezXIKc6d8feGsfS1
         +9q+5lCAU65u+VCmclwUOL3IXwku9ez2105ve6yuNhX6Th0VpwwXKdBMf07qOdHEJ6FH
         mygfRav7l7fP6MortjMmLCz6cPzKcAyAUMP/76lODRk2kW+xu3ZORlq9YohLFoNbPcps
         429+5MayUNv93ooypIlbm7MtKhhFHBpkVrlHqf1QzMQepA4nEOTb4Ldquc2rQiKW7E6f
         vGTKbs00a2oj6NAwmpIdqXILmRwUtjbWwp1skB4jYN6/YcmWj+0BKpSRNZ1F0rUKs32D
         sFjw==
X-Gm-Message-State: AO0yUKUDM5+suIaOs83g3M4rXjCAUVb1rFJFbRbe5DAvW4pHn+OA+rm5
        qCEHQTQzLFrtZiqrMQP9cb9IdUlzvU2kEE8=
X-Google-Smtp-Source: AK7set+NsmwZUgMOir/3CFweD+fOXzVKVE6vcUZnS4NLHvGsJN6uaDFEl0kd4gu/nChuEKKNJ7xP4g==
X-Received: by 2002:a05:6214:5010:b0:56e:f1fd:f16c with SMTP id jo16-20020a056214501000b0056ef1fdf16cmr22149972qvb.20.1677161486934;
        Thu, 23 Feb 2023 06:11:26 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e099:82d3:1307:6825? ([2600:1700:e72:80a0:e099:82d3:1307:6825])
        by smtp.gmail.com with ESMTPSA id s75-20020a37a94e000000b0073d873df3fesm8798853qke.30.2023.02.23.06.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 06:11:26 -0800 (PST)
Message-ID: <22ca24ee-39fe-013a-494a-ed7f140210fa@github.com>
Date:   Thu, 23 Feb 2023 09:11:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 07/16] hex.h: move some hex-related declarations from
 cache.h
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <c9b1b27809298eb1b7a8c5e48866637268dc12a1.1677139522.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <c9b1b27809298eb1b7a8c5e48866637268dc12a1.1677139522.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> hex.c contains code for hex-related functions, but for some reason these
> functions were declared in the catch-all cache.h.  Move the function
> declarations into a hex.h header instead.
> 
> This also allows us to remove includes of cache.h from a few C files.

> diff --git a/cache.h b/cache.h
> index daf6150bb3c..d0619ce2e63 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -13,6 +13,7 @@
>  #include "string-list.h"
>  #include "pack-revindex.h"
>  #include "hash.h"
> +#include "hex.h"

Adding this to cache.h is definitely safe, but it makes it so .c
files that consume the moved code do not _need_ to include hex.h
like I think you want to imply at the end of this patch.

What changes if you drop this from your change?

Thanks,
-Stolee
