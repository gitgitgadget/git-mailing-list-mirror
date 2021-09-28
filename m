Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B816C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58208611C0
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242717AbhI1UV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhI1UV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:21:58 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E0AC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:20:18 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id r18so101016qvy.8
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eMFpXCMJWkS3sgNauZOQe5L6VST/aOTuAHcW+1hzSuk=;
        b=lvc3clsme2MkQmBbCUvZ/XUk5UQk1u3vO7hdTvoK8ccAcvDNsgvy2R30XIAkVHBkBh
         aTkqETJeVPxA2L/7C1jYlvAX/IAJKQB7zfwAVwTvG9JvvTJQPLM6xYdEs53fqP0o1yEK
         q47tdzSfhlw/Bjfcd+aecV5Muotm2FU9dVrhFQ8fP2crpZz9zC46xcwFjOJ08hLJ7rJN
         KPUpfD+Z4iTaZ5/jlBq90QNpMocb3yrVPo4qlqd38A5H8xITK6PAFHnc76gpuK/8xgLz
         o1hy3tjtx8lFUOEXacFS0oQHUberi3/p71KLkFzfRNfD1GmBt8dTrWPjTXaDVFpOm6ca
         ZnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eMFpXCMJWkS3sgNauZOQe5L6VST/aOTuAHcW+1hzSuk=;
        b=U5PAbuPhjZhoh1lk/HFWDCn9VpukXS2S9Q60B8h5zAsoTlTS8JhV1QrvASG82k4C0u
         iU/Ws9WD59MdedcHCGVOZEGgt0+yfORTwGujlCa/gGcPxh7MlsODm35mHhkajdAeDGdX
         5Z3jzNFmEiKf95Bxh9xtuAOUe6Aozterd/DRPUNPpJi8uNPWon7MOQ6ZH7wiRKr/ljM3
         HqIAmgw237uBX8y48J4WAKVuxx9mIr7+GRQHuw7PX7u2XtsTdUY2gqwaiCwaO3YHklv+
         DRZtZ9a0iD1PbxsWzJZEXVbASORMfYJhs/RXOogoZPz4cr5NM9LsaljaR8Ue1zxbuWls
         lLxQ==
X-Gm-Message-State: AOAM533iRjWTIhOi9++n389nF6PPQygZ9AuoRECEN4ZhndkATktsME2/
        brdc5p1Z13L29KLl6uxx1iY=
X-Google-Smtp-Source: ABdhPJzTHuBazhn5Op41qUaVmQqsmHLUotPSzv8FY7DDRE6IZXMWqtQ3Tnriq22xtmWMcfxHNW+rtg==
X-Received: by 2002:a05:6214:723:: with SMTP id c3mr7545045qvz.60.1632860417498;
        Tue, 28 Sep 2021 13:20:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ce8:d663:cc6a:5d40? ([2600:1700:e72:80a0:ce8:d663:cc6a:5d40])
        by smtp.gmail.com with ESMTPSA id o21sm134103qtt.12.2021.09.28.13.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 13:20:17 -0700 (PDT)
Message-ID: <bd7d6515-e1ca-9646-5e73-5594d7991ec3@gmail.com>
Date:   Tue, 28 Sep 2021 16:20:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] reset: behave correctly with sparse-checkout
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Kevin Willford <kewillf@microsoft.com>, vdye@github.com
References: <pull.1047.git.1632842421213.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1047.git.1632842421213.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/28/2021 11:20 AM, Derrick Stolee via GitGitGadget wrote:
> From: Kevin Willford <kewillf@microsoft.com>
> 
> When using the sparse checkout feature, 'git reset' will add entries to
> the index that will have the skip-worktree bit off but will leave the
> working directory empty. File data is lost because the index version of
> the files has been changed but there is nothing that is in the working
> directory. This will cause the next 'git status' call to show either
> deleted for files modified or deleting or nothing for files added. The
> added files should be shown as untracked and modified files should be
> shown as modified.

Sorry for the noise, but hold off on this patch. It will be joining
a larger series involving getting 'git reset' working with the sparse
index.

Thanks,
-Stolee
