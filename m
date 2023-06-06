Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004B3C77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 13:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbjFFNfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjFFNfG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 09:35:06 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D151790
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 06:35:02 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5659d85876dso62724047b3.2
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1686058502; x=1688650502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HZqnQ5Wt7uFMtSpcOKQ5WirT2BQh41iLLXeQHfkc3O4=;
        b=i15u+yh0qskg4gOeqyYJVmbfk3ej5f6H0gtWD+U718bhkwY67xzcmdV9QZ8eCoqt17
         /4N9h3UgmMfM/APLWiJou3Nn41y91NQXZOHEtKhJnXOKw4y2GRmW/eJNFjDlf/nPUacf
         v9yphJrgv6GRKAgzTw9G7i/IYhzBcN/rPeVyEGDaDxIRYxwTRPIa67rC1oFCKYJAFTnc
         5L012B1wH+rtzOEa2cF6tK6NnC5dsWyNYGx5Vwm79sgiDWu/IhLOW5Mr4t7/KjjTsW6o
         rhMiruSvIaoaPG4vYxW378uJbIdOqeDsQ+WmhDnoyVamoZs8gc2JuGMVJmzFxoVu1aBe
         +j9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686058502; x=1688650502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZqnQ5Wt7uFMtSpcOKQ5WirT2BQh41iLLXeQHfkc3O4=;
        b=RwKP3Nx0arcYvRSqjRMKHyCnpuLDWsm6Ahj3VgyE4Q6ot17UhUaitxBtHVsXu1HLB1
         yvyWkkITNO+NimghYew98bLVCHQDJit4dw0WlSAcP0O2dCzY/y5hOF23TXm0KqjxA190
         Z2abExPp94z1ZHJubtZgyjde9zmoqw5yy7FD9V1C0onJ7r40YD3JamMGjcyzJtSZU0GJ
         Rx57cBHGIqcqZZiHXVAo7tOFO4AbNWWDBYmNBMRghBOMqVwwW88gCe3JgFdO5wKGNFDd
         AQExatjAEbOJ3Y9ug7PoXcQ8z3qNOI+LDnCwb7cQAqc2nhP1qv0qvn2A2mBvJ+vhTWwY
         T27w==
X-Gm-Message-State: AC+VfDzGoDCrRzLT85b4CrIMOZ7SGkGgza0F1kbfx9kIyia/wZ1vTIlh
        OX1uaMcFItbdhQT2A/2P7Xf8YFmt1995avXO8A==
X-Google-Smtp-Source: ACHHUZ7F6ufu5tsXKPgxLz+iFH5aeE9R/NtdqloFwrEW/FnepP+A2ldcHAfsphXtvJyN0q+t12AT8w==
X-Received: by 2002:a0d:ff86:0:b0:565:cef7:92d2 with SMTP id p128-20020a0dff86000000b00565cef792d2mr2095754ywf.21.1686058501860;
        Tue, 06 Jun 2023 06:35:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3d87:d951:da44:1f50? ([2600:1700:e72:80a0:3d87:d951:da44:1f50])
        by smtp.gmail.com with ESMTPSA id t197-20020a8183ce000000b005619cfb1b88sm4081440ywf.52.2023.06.06.06.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 06:35:01 -0700 (PDT)
Message-ID: <e08f5cea-67dc-6b96-098f-118934c11b6d@github.com>
Date:   Tue, 6 Jun 2023 09:35:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: What's cooking in git.git (Jun 2023, #02; Tue, 6)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5y814aw8.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq5y814aw8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/5/2023 9:50 PM, Junio C Hamano wrote:

> * ds/add-i-color-configuration-fix (2023-06-06) 1 commit
>  - add: check color.ui for interactive add
> 
>  The reimplemented "git add -i" did not honor color.ui configuration.
> 
>  Will merge to 'next'?
>  source: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>

Your recommendation to compare the raw output to the color-decoded output
is a clean way to simplify the test (and remove the whitespace errors in
the meantime). I'll send a v2 soon with that change.

> * ds/disable-replace-refs (2023-06-03) 3 commits
>  - repository: create read_replace_refs setting
>  - replace-objects: create wrapper around setting
>  - repository: create disable_replace_refs()
>  (this branch uses tb/pack-bitmap-traversal-with-boundary.)
> 
>  Introduce a mechanism to disable replace refs globally and per
>  repository.
> 
>  Will merge to 'next'.
>  source: <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>

Please be sure to pick up v3 [1], which fixes a compilation bug in
v2's patch 2. Want to keep history bisectable.

[1] https://lore.kernel.org/git/pull.1537.v3.git.1686057877.gitgitgadget@gmail.com

Thanks,
-Stolee
