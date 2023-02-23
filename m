Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145A4C64ED6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 14:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjBWOGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 09:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjBWOGL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 09:06:11 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A9C570A2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:06:08 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id l12so10693657qtr.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVxv4bfv8zPv3XFBT1CcV5rMcSwhWov4y4M6iXWpzn0=;
        b=jfEr9GcQrxVoOntr+jAqiPrciFfE7UCbsxoNNBZ1uOqEa+hYWSaDc834MoGUnPUybL
         CFD0a6jGTqPP6F6RwOkZ0oLmvq2q4NXCgwGB0MFQ874nDRMuefW730NnpnLi3yosNZ+D
         Hw2+upelErMeKBKgT4ltBn6mgOKvIdwB0TbMZMOeYZp6C1UWNl8xHAzWo8s81j9TIzU7
         SdCWyq1kivpTthQhx+m3bX6ZrWTpv9toxoRDBgDi28BKdQRzgnyXAz688wyJPZGlCOWN
         RYVVUu4+rYxWNJ2uNAXbpe5lU7cjvBH0ASklpOnW5LY/SxgteOHGO1mwAlNYgXboihiy
         6bOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVxv4bfv8zPv3XFBT1CcV5rMcSwhWov4y4M6iXWpzn0=;
        b=TueWysYq+qNdjGiZZoq62FvEyl/v1OZ+TydGls5HqQMOLhEKAL9iQuzkHZrfX45Ojq
         hHXU/gFJfy1azp2QSF/23yKD5VF0RyRxa7G2+/hW2ttGIZ/00d7LVORRimzzMykXN8kV
         ZTl/FIR6HKxBzIrFras5LCjfYXJiFk7hBVU9ZatjmqBTBpfw2qun71MmyNlmZu+87Gle
         TArnlGjarNlY3pnnzaM0WU3nsDcYxzCJPj+CvK5XlLHgYRr749XYfRbkYb0OIb04QbII
         CMQFcfhBo6IHCbPfDcwkt7btBfWJWzahPy+aQLqWmTl4fFo7J2W8q6IJs9AUG9znG7X2
         bo1g==
X-Gm-Message-State: AO0yUKU1NUEgWEGqG96gR0nDUiR1L2h38mIjtMFndZeTbH4mtDg7Kfzr
        2nhMdv8K0zxhkjyXluKT3p2n
X-Google-Smtp-Source: AK7set/R9iji2hJRoYI0GIqhJMl6IvJ2YVnnD4q2xD5Z8e2C1+m9ku9ZzQdORLeWQvXe/oi3nUVQIg==
X-Received: by 2002:ac8:5850:0:b0:3bf:9f6e:a383 with SMTP id h16-20020ac85850000000b003bf9f6ea383mr18183287qth.20.1677161167778;
        Thu, 23 Feb 2023 06:06:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e099:82d3:1307:6825? ([2600:1700:e72:80a0:e099:82d3:1307:6825])
        by smtp.gmail.com with ESMTPSA id fe15-20020a05622a4d4f00b003a527d29a41sm5857156qtb.75.2023.02.23.06.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 06:06:07 -0800 (PST)
Message-ID: <536338b8-2189-04f3-7ed6-dbe640c73c9f@github.com>
Date:   Thu, 23 Feb 2023 09:06:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 05/16] alloc.h: move ALLOC_GROW() functions from cache.h
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <ec6f2518b9dddbaaaf101b0f87a2db377fef3c6b.1677139522.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ec6f2518b9dddbaaaf101b0f87a2db377fef3c6b.1677139522.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> This allows us to replace includes of cache.h with includes
> of the much smaller alloc.h in many places.

> diff --git a/add-patch.c b/add-patch.c
> index a86a92e1646..7fe6b66d866 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1,5 +1,7 @@
>  #include "cache.h"
>  #include "add-interactive.h"
> +#include "alloc.h"
> +#include "gettext.h"

I see here that you are not dropping cache.h, but are also adding
gettext.h, too? Did you mean to replace cache.h with git-compat-util.h
here, or will I see that change happen in a future patch?

> diff --git a/attr.c b/attr.c
> index 1053dfcd4b6..657ee52229e 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include "cache.h"
> +#include "alloc.h"

(Here's another example. Makes it more likely that this is on
purpose in preparation for a full swap in the future. I'll
stop mentioning this when I see it.)

I also manually verified that the macros are an exact move
from cache.h to alloc.h.

Thanks,
-Stolee
