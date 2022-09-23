Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A225DC04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiIWSXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIWSXe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:23:34 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A391113B51
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:23:33 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id d14so583971ilf.2
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hIM1zPveLMJfNx+WUM36orYsPxhag3MVNHMkcyd8XFs=;
        b=iMMlgp8OxtI7pbLDYARfwkSFQu/QaWRbidfvVOi/2D0R6mRgRA30LjDaX704bxChMB
         3BCXPNOPETTvHNTlE+YpfblD+z1Yb1h/oqyoC6bU/OOSC5I3UUzdkxAMWN+IfVlZk+4d
         OsZzPDJJ7DoBwdbbMOKpHLIDW5cZxEx4ujvP42ut8JGpx7sJDc8ljJI5szOGO55JDx5t
         YELaK5MaZLaKghN4v4bGgV6MGl6r0SI0SSPybiDdGoHRgaGeRZldqEiDhvs5V1kZ73xa
         l+1yW7rj9b92wJCiOe4y8mUgWFkHpT4T8gwAhi7K6dvtR6y1q/63sXPpPSqmk0sLPIRT
         irOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hIM1zPveLMJfNx+WUM36orYsPxhag3MVNHMkcyd8XFs=;
        b=Q/ZfXXj0sGMKz33oNyP5x34RJAX+W9rqpV31zYJyM2MWXOAA2KE/S6h+OGLkp2kGK+
         qhWW7TnsMjfqYLFErfcBkW4lcKfv8utRSEQocUxReTr/ZlAbo0tGLcpa7crv+uGTQlIX
         1v5JYanOLm71RppvjJLuLecpANNLsSonDNVT8bH+g19i/YsE7RJtqAw8gP/ce9Z652+F
         o8fdva78XVuapegeNYZ/LF4riGpVSe0YlENQIbnYwGO70vaonJEXKfALagWYUlMGaI9W
         GVvkuMMxrk93p6+m17ugoWIhvD9b10IEfbIjz3i2RMJVROKRlyXKnhmda2h3dvnrmdQL
         61TQ==
X-Gm-Message-State: ACrzQf0XEnjE5OXRgAMmSSYyNLpNoE3ztYB+gLxYCAS0AIifp9Jzevt6
        YQB8iwz49AYdLXy+lETY5oyx
X-Google-Smtp-Source: AMsMyM5Vj/D4ladNefnpZQbvJKV7MDBJ3eUV+6I63GpLs6e/HP+tvsxNVojMqXeCb8tMMyhmx/MwUQ==
X-Received: by 2002:a05:6e02:5c6:b0:2f5:5e35:1f9d with SMTP id l6-20020a056e0205c600b002f55e351f9dmr4515948ils.43.1663957412896;
        Fri, 23 Sep 2022 11:23:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f43f:f355:a5bb:115a? ([2600:1700:e72:80a0:f43f:f355:a5bb:115a])
        by smtp.gmail.com with ESMTPSA id t8-20020a026408000000b0035a0d844e43sm3577131jac.159.2022.09.23.11.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 11:23:32 -0700 (PDT)
Message-ID: <5172dbb7-61d1-7249-f9bb-d760e6f4450a@github.com>
Date:   Fri, 23 Sep 2022 14:23:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/3] midx.c: use `pack-objects --stdin-packs` when
 repacking
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
References: <YyokIf%2FSd7SYztKQ@nand.local>
 <cover.1663706401.git.me@ttaylorr.com>
 <4218d9e08aba629d8f64b5a999f60d12e5d8785b.1663706401.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <4218d9e08aba629d8f64b5a999f60d12e5d8785b.1663706401.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/20/2022 4:40 PM, Taylor Blau wrote:

> +	for (i = 0; i < m->num_packs; i++) {
> +		struct repack_info *info = &pack_info[i];
>  
> -		if (!include_pack[pack_int_id])
> -			continue;

...

> +		fprintf(cmd_in, "%s%s\n", include_pack[info->pack_int_id] ? "" : "^", scratch.buf);

Outside of how the object set is provided (a list of objects or a list of
packs) it seems this is equivalent. The only difference is that we are
writing a line for _every_ pack in the multi-pack-index, but we preface
the line with "^" to say "not this pack".

Do you know if there is any reason to do this explicitly? Does this
change the set of objects in any way (perhaps by not including
duplicates that are tracked in those other packs)?

Personally, I would have kept the "if (...) continue;" pattern, so maybe
you had a concrete idea why this approach is better.

Thanks,
-Stolee
