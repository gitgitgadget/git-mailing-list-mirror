Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F145C77B6F
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 13:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjDMNtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjDMNtj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 09:49:39 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D043584
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 06:49:36 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54fa9da5e5bso82730047b3.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 06:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681393775; x=1683985775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IACb5aAtTtbyQISNeTgggwiO3frZh3z8ueicizwRlM8=;
        b=Vcznfl/Hl24p1wuBr9QUnJ0EjJ4e1BOKX/Pc/UyST49MjiSPbPci1DWN5q+eD7hkg4
         A5hsqOxBpqK/1HTjxMjIbsJPs5wHvsK/qQhnAyTcE82uQphaPoC+CKRXib/j2hR26LAV
         hXfbm8OXyQVsDnNfcLSvWxq2baFxxLhsYAztn82t6bL6ws/e9merMHTzLWPEr8bJgbgQ
         D0Sk8AmwdVMgIcSFY6rckOjxDeST4RenVGTSGWNW7iw3VGpFD5b7oVcH2ukYEvFbjhQr
         c3zXeSGKNnYhu9sa1pf7/aaWx9rJbqhSmCnowHcwMLEBWm8/7In6BDDyV2jkwDtDb7qv
         04CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681393775; x=1683985775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IACb5aAtTtbyQISNeTgggwiO3frZh3z8ueicizwRlM8=;
        b=NHNcYiN+7m3npz0i/3dJV2qxKD/bFdQo0hai2RRNp+KrAxyRHl9LbzCtAsns5muALq
         YBywbVUgLPD717kaNLHOeVjr5wWt5k8gxMHTZ2Y4uZnj6tePFPyb3n5U51r6X+KmgKan
         +WidhP9wKxdhIncINIJY1zGcfN8x5SIM3wmFE6RXCrqXc6QGXk2ESDDdyQPwhm9N7EAx
         jU4v+/gUfXpShqDzqbK27yUTRVmlsHoH0Y7N/vEHcqWDaeEnGPRr6M6+wZXNL2G5Euup
         BE1guH461ft//0V0tKgzWkc8KTXUEp52/MfBY6WGBRTNZcprC4PeopGigK2FtWwpDizK
         2KrQ==
X-Gm-Message-State: AAQBX9fQkD7cJNG/oKdcT+Gwdzj23ojQ0IPzAT1dYLphFi/n2WjETZcq
        eLZJfWLcovXxqPp/PlUwes5Q
X-Google-Smtp-Source: AKy350adtm7V9ajBR1N8ie5kdCvxZbWZlk+Ae1TmaLyte/XrTtdwIX0jN7QM5YrGDfoPCGaVtRZbAw==
X-Received: by 2002:a0d:e205:0:b0:54f:ba16:eee with SMTP id l5-20020a0de205000000b0054fba160eeemr1827891ywe.32.1681393775390;
        Thu, 13 Apr 2023 06:49:35 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 195-20020a810fcc000000b00545a08184f6sm453413ywp.134.2023.04.13.06.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 06:49:35 -0700 (PDT)
Message-ID: <1d2e1796-c305-0876-533c-2fe0fd39d722@github.com>
Date:   Thu, 13 Apr 2023 09:49:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 01/10] midx: fix segfault with no packs and invalid
 preferred pack
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
 <dd8145beade440e5444130d3a3189b2c5d15a911.1681384405.git.ps@pks.im>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <dd8145beade440e5444130d3a3189b2c5d15a911.1681384405.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/2023 7:16 AM, Patrick Steinhardt wrote:

> Fix this bug by resetting the preferred packfile index to `-1` before
> searching for the preferred pack. This fixes the segfault as we already
> check for whether the index is `> - 1`. If it is not, we simply don't
> pick a preferred packfile at all.

>  	if (preferred_pack_name) {
> -		int found = 0;
> +		ctx.preferred_pack_idx = -1;
> +

This patch looks good, but I did need to think about it for a bit,
so here are my thoughts (feel free to ignore):

I briefly considered recommending that we set this as the default in
an initializer macro, something like

  #define WRITE_MIDX_CONTEXT_INIT { .preferred_pack_idx = -1 }

but this struct is internal to the file and only constructed once
(at the start of write_midx_internal).

Further, outside the context of this patch we have this code:

	} else if (ctx.nr &&
		   (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
		struct packed_git *oldest = ctx.info[ctx.preferred_pack_idx].p;
		ctx.preferred_pack_idx = 0;

I don't see a way that ctx.preferred_pack_idx can be anything but zero
here, but it's also not going to give a segfault because of the 'ctx.nr'
condition.

Thanks,
-Stolee
