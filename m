Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C553FEB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 17:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjFURzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 13:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjFURzG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 13:55:06 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2A81FDC
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 10:54:09 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-573491c4deeso38702847b3.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1687369994; x=1689961994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usJNOvZgLl2zaUYxpqoPEXtSZOh05/xJ6Uvyn+pM/N0=;
        b=MVrXzMclwa41ZpkHNmR2lLCe0cbepedW4nFkQxORm28zB6QEytyxkBZpLZoaTppQcv
         vAoFdjXhFEm6eZU+Z7xlJueLhaW8LmZ1OAQIwH8h/spSZw1poW1Jeu4f3VjlTp6KLT+j
         I8iXMF46lc/nYtXgUaC8H7eWTnLgDv6tKV0DFY3SSn92O0R4Hx1k8iuJEILRUx2U3OVZ
         WzFNiOxmEo6H9yMOBNQ8BC5iUtooigCDXtucHEL8qN0n+nEzAgcCEt/GYWsc4/4SobLW
         KsDlGM6w95jRBU9+Mwpt/2ednvQWob2FtLxEqSEzE5ucwwL7XEESknoqLzicQFtjUZIh
         9VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687369994; x=1689961994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usJNOvZgLl2zaUYxpqoPEXtSZOh05/xJ6Uvyn+pM/N0=;
        b=LR77bTMwqTsiA/w0hV+sLtEs21nRwSHTIrQu5xdjYd+2LiuWQ6GxCJAwsy6HTknHMW
         5vmp013w/fnYoOlPWXUD6/m1kZkFfdEd7LrhsgDUEwILZFpkb9wIV/6DBTjg8BHo5yeI
         L8NMKQc3rO9MrWGLzF0PBXcX0QCfJWAi8OxrRddpVBsQKfKjM14450rgG6aUn7rEhvtU
         TaqVyk56OZLzcehFMC62mXrpj7y2U/n8yYup0Xh7M1lvndrJxG2oSxWtejga9yavybAO
         AmvuJJyMt7by2m3mKpnIBOhyMV0/1VCt1sKvyXQzFH/AhkdnlELRAx60d2qxLSJ0TXu1
         +jBA==
X-Gm-Message-State: AC+VfDySoqsNNzGSOyL8EPISM+4yt03KW1KCeUb4Df2imJfWv+i9dbES
        MBoDzkvLzOFL0vR2s4oenWCr
X-Google-Smtp-Source: ACHHUZ7A4Dww88XML921pMVoWDVxW8W9yQQuRszQTrS8hfhNnsYFa1NfiuPUltEMuxdrdzd7kVj4Bw==
X-Received: by 2002:a0d:cb57:0:b0:570:22f:af3 with SMTP id n84-20020a0dcb57000000b00570022f0af3mr17892756ywd.22.1687369994602;
        Wed, 21 Jun 2023 10:53:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:bc6f:59cb:abbe:cbd? ([2600:1700:e72:80a0:bc6f:59cb:abbe:cbd])
        by smtp.gmail.com with ESMTPSA id w123-20020a818681000000b0057320d10542sm1268669ywf.78.2023.06.21.10.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 10:53:14 -0700 (PDT)
Message-ID: <0fd02ca8-bd5d-4143-956f-2c456897b87a@github.com>
Date:   Wed, 21 Jun 2023 13:53:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 0/4] Changed path filter hash fix and version bump
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1686677910.git.jonathantanmy@google.com> <xmqq5y7r5fsx.fsf@gitster.g>
 <c7b66d2c-cdc3-1f0f-60a0-a2ee21c277bf@github.com>
 <ZJLq0XE3lSVzQ28k@nand.local>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZJLq0XE3lSVzQ28k@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/21/2023 8:19 AM, Taylor Blau wrote:
> On Tue, Jun 20, 2023 at 09:43:46AM -0400, Derrick Stolee wrote:

>>  commitGraph.changedPathsVersion: Which version should we _write_
>>  when writing a new commit-graph? Defaults to '1' but will default
>>  to '2' in the next major verion, then '1' will no longer be an
>>  accepted value in the version after that.
> 
> I am not sure if there's a situation where we'd ever want to not write
> the newer versions when starting a new commit-graph (or chain) from
> scratch.

I'd rather have the choice to start writing the new filter mode be
made by config rather than a change to the Git binary. Makes for a
more gradual rollout to be sure there aren't issues with the new
version.

So please keep the configuration value, but have it indicate the
mode used when writing filters.

Thanks,
-Stolee
