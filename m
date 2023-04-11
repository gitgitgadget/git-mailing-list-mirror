Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7930C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 13:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjDKNyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjDKNyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 09:54:18 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6425A10FD
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 06:54:10 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i15-20020a9d610f000000b006a11f365d13so3161301otj.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681221249; x=1683813249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KgXuK+wWyLuCIcL5TrNFSctb2g6MLw0NegOa+/xzsRE=;
        b=jaohit6rHLj6ObpOuIS6itl6LsFD1qJGhxsx7WcROda2T43tLuoBrFoGY6LRZdu9A8
         NdpfABo0NtQdywvNbjEdnCoY2tCvJRpHpdTFx9ttFBX+7r2MQeDgQhV5VUJTjkEKu0H3
         hTResIHvpK+Q46fhO6YIpS9LOBSWVrE/31hHCiK+5xxZz3VSrbvQ8Fme80maKc1kAOIW
         floCkEwRlEtKZ8RPbYdT9AjEC0v4Az0A1Bpd/4UYFv/4tm2TdFYbk0o3R+IkIokEN55Q
         8U3i/mryNgk0gskFZ6unQp9KZ5865LNUIa69F8B4I76eHV27r/MO4ZF75ljrKuX1ZS0X
         q9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681221249; x=1683813249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgXuK+wWyLuCIcL5TrNFSctb2g6MLw0NegOa+/xzsRE=;
        b=WymXcB7+NHjFJnfi2Ta2TYP99h+P0y5GhlBsmtVnD5O3G0BjFeGqyQSMXjirTKeZH2
         5geBuDslnQBTbHRXSYd5LE7u7rp1d7a1EbTuLmzKOF0BoqUdw9PruTb89/LWcCRrV/5U
         69c3jD+XQEsOHYCdz4GKOy8XRrm/j63eMWShuMjXGh2G773AkbZiSPT3ldDFrMswTMjk
         LKOhvRQxm+dJx4xHElaz/AKoIhVS4YugrQ7thQnUqSgd3QFz6GyvExyL14COEtZNqXAa
         IEWRqk9rctIZqbiCvcV9gYUt0mv3Vwcwc+F+ieJmFkQgTBa4YfYESiIi7txhrS08FazQ
         fJqA==
X-Gm-Message-State: AAQBX9eNn0KB8srcDeRvKLhrRR5AYIykH+YO9qqPqS49HGpJfUDmQ6qk
        xpnNg+dt/x484oEBYDiKlpBe
X-Google-Smtp-Source: AKy350beFS+Njyy2xp3ybQ/hR5r6GbnLHMmwqiqIW4yURWdLO0nRnVYR3GIABGWx0oQrCsK8CqnzSA==
X-Received: by 2002:a9d:64da:0:b0:69d:d4f4:733d with SMTP id n26-20020a9d64da000000b0069dd4f4733dmr1547270otl.4.1681221249523;
        Tue, 11 Apr 2023 06:54:09 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t21-20020a9d5915000000b006a13dd5c8a2sm5383997oth.5.2023.04.11.06.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 06:54:09 -0700 (PDT)
Message-ID: <bfa4c23d-8b38-7505-fb57-a02e0a028292@github.com>
Date:   Tue, 11 Apr 2023 09:54:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/7] pack-revindex: enable on-disk reverse indexes by
 default
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1681166596.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1681166596.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2023 6:53 PM, Taylor Blau wrote:
> In the vast majority of cases, this trade-off favors the on-disk ".rev"
> files. But in certain cases, the in-memory variant performs more
> favorably. Since these cases are narrow, and performance is machine- and
> repository-dependent, this series also introduces a new configuration
> option to disable reading ".rev" files in the third commit.

I agree that the performance trade-off indicates that having the .rev
files is preferred. It makes operations that _can_ be very fast as fast
as possible (inspecting a small number of objects is much faster because
we don't generate the in-memory index in O(N) time) and you create a knob
for disabling it in the case that we are already doing something that
inspects almost-all objects.
 
> The series is structured as follows:
> 
>   - A couple of cleanup patches to plug a leak in stage_tmp_packfiles().
>   - Three patches to enable `pack.readReverseIndex`.
>   - Another patch to change the default of `pack.writeReverseIndex` from
>     "false" to "true".
>   - A final patch to enable the test suite to be run in a mode that does
>     not use on-disk ".rev" files.

This was an easy series to read. I applied the patches locally and poked
around in the resulting code as I went along. This led to a couple places
where I recommend a few changes, including a new patch that wires
repository pointers through a few more method layers.

Thanks,
-Stolee
