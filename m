Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86D3C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 14:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjDMOy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 10:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjDMOy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 10:54:56 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9E244B9
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 07:54:55 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v7so14175442ybi.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681397694; x=1683989694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hU6glpNTcBUNWuCPCWOEo6ZGvPGViDi6g2ILIqEVms=;
        b=BfLv9DADRqNEfsY+OrBkxNTABq9sCZHliDdfAVQ/rCNNrRaFsPejtju6jdbq7n+pY9
         ooGL8eXFlBcKBsAIiwkOONFc5Q5PHnf9CH/1KfAOZGqCnjOhx7kJOOBGYbAgS8g6ulOA
         auLVAPNue+w7Fe4WCkPSm3qmfBjkdUrr7le0WxMix+m9RqEj13hOhDRNZdTM7JNUDC8Z
         AmSXn2pFoJqaS0CMvQBsTz9k0OefyRHOmt9oSYq8Q2VJNRjUDCuCOzV3THEyZgNkOyTX
         kprW+kaUfWEpKj0bODDOJ983v7/iOmnZxYRL5bnmPKFczDYZQuEOm67ttvls8OE/fAdm
         QohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681397694; x=1683989694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hU6glpNTcBUNWuCPCWOEo6ZGvPGViDi6g2ILIqEVms=;
        b=dFe6Nsh1SA4un6myhG1mZXK0al+kndlfBlvPC8c3y3mXMgFkXqAcr8X2uj0uRAyuVc
         YHoSQLw0oNGJZN/KoIvj//b3ugVKH1BYfoQDtOcLAmlN1hVzqocb4xmYv2ajp3fPl35f
         yONxaA6EMHxd8NobregSy54nW4LA5QvDf36gMRpTNTtBela7sT/pg3A3eHB4YxDb8+3+
         3OeH1kqK01QwjkOet6rC8E9Ake68C4l8rxSsA3cUhRc5CNKXfa8ttE03RuADVdzeWBQM
         0TrpdyDLdoYA5kbaCwPDbmLMviyA/7eScT629G6nfIYjRp/EIsbrOf3Mvn2jKAmcKqhR
         VOaw==
X-Gm-Message-State: AAQBX9e9nLNuVKnGXLKb/su4agqC6fmamrg6FZp0lb+a1Qcz1/HfPaiH
        wT6DgIzX2uK8PmOScVHM68z5lT7pYzNP/WI6kA==
X-Google-Smtp-Source: AKy350Z6FXhY+uu2Jz33jmnUodvtlJ3zn+BjzoHhndD2OnjcFOWNtlxYf963OLuQ9v1RL1OlJ4ChoQ==
X-Received: by 2002:a05:6902:110b:b0:b72:8a07:afcc with SMTP id o11-20020a056902110b00b00b728a07afccmr2558976ybu.46.1681397694420;
        Thu, 13 Apr 2023 07:54:54 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v12-20020a25848c000000b00b8f46d74e5dsm212757ybk.37.2023.04.13.07.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 07:54:54 -0700 (PDT)
Message-ID: <cbcc6022-1f13-1fa7-aca3-5f87a9cc8eb5@github.com>
Date:   Thu, 13 Apr 2023 10:54:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 00/10] repack: fix geometric repacking with
 gitalternates
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1681384405.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/2023 7:16 AM, Patrick Steinhardt wrote:
> Hi,
> 
> this is the third version of my patch series to fix geometric repacking
> with repositories that are connected to an alternate object database.
> 
> Changes compared to v2:
> 
>     - I've simplified patch 1 to reset the preferred pack index instead
>       of moving around some of the checks. This also causes us to print
>       the warning for missing preferred packfiles again.
> 
>     - I've fixed the logic in patch 2 to find the preferred packfile to
>       not return a packfile that would be rolled up in a geometric
>       repack.
> 
>     - I've added an additional patch to split out preexisting tests for
>       `--stdin-packs` into their own test file.
> 
>     - I've changed the unportable test added for geometric repacking
>       with `-l` that used stat(1) to instead use our `test-tool chmtime`
>       helper.
> 
>     - I've changed the logic that disables writing bitmaps in git-repack
>       to cover more cases. It now always kicks in when doing a repack
>       with `-l` that asks for bitmaps when connected to an alternate
>       object directory.
> 
>     - In general, there's a bunch of small improvements left and right
>       for the tests I'm adding.

I didn't get feedback on your v2 in time, but this v3 is very close.

There's just the one test change in patch 9 that I think deserves a
re-roll, but otherwise this looks good.

Thanks,
-Stolee
