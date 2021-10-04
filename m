Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5162C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE2A61213
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhJDN5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbhJDN44 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:56 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E085C0619CF
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 06:47:31 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c20so15871392qtb.2
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 06:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XpvjPHp3Ge/FQETLvz+zpXjpqQHguSkpqHWiJFaA9ag=;
        b=fAd6ukBX5g+GNtYKqh+1JKLUmDKmhtxG9xlP4ImKdVOsDbaVubBA1CxfSPyhYdv97o
         A02YRdKXEmSv/Pq1H6pjl9yjp43J7I/fixlwt14+3j1w6ZYk6WqMuMiuOHxEptZn2im4
         9nmvvq/mcyi9F0Z8UAp6JhZkykLKfPGbC606gFOY110VgIiFHQtA7NuvsvIjsGuTVBLr
         nHWT1+f5fqO4493BmowYnVnjTM1ueoiB/GRvdt3FMPpzSk/h+EkmU6fRnZEBJDSem2iI
         HKuYGbEa6Je4itvBduM1ZCVhM0OGyOIkIrnkqJdmvpOwV+Gd0sQABXt12aA3Y2EkMN7R
         U6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XpvjPHp3Ge/FQETLvz+zpXjpqQHguSkpqHWiJFaA9ag=;
        b=CBdNdmvct/kOpDE74tU1fEDHZIkxH7tprgrTDDz786+cMbTuUyg9/KmRyenMHQHL38
         Plo4Asbl+GnYrK9JooYgrUByEvh5VG+msdOsM36hB4gIVmOp9Bwl2JwwHazSQyFBsqqB
         r3hAKUJ1wEc/BCp3C+CuzvO/b1M040JdwH3a2a+IDP/oQTyBfvTVB3sXIofmUp1Hk8fe
         IXTwPCJbN5pg+9Lo33Urp4ZLirqgQYLGudorCiIKPvePqNlPQWBuvfNb6LkZJSpqLmrC
         y1Ezfzza79mi/ARfkyyMZOwSXQSMoiY8KEmWzlCMgore0y/6xEtjkXJ2aUcWNYpibvWz
         VQRA==
X-Gm-Message-State: AOAM533O4+Gg/zA8KmSMKB2uOViZEzpn2q5g1q/GPcWRcQdBX3Y4GZEj
        C4mybbjV9on3SmkvRN//9hN8
X-Google-Smtp-Source: ABdhPJxfIj/mSmCpy5AyrY2gg0511kZrE2ytcbXde+ZxuJkRza/8+mJ3KhnMoxdCbzx1LschzXjmdg==
X-Received: by 2002:ac8:73c7:: with SMTP id v7mr13584058qtp.84.1633355250782;
        Mon, 04 Oct 2021 06:47:30 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id h4sm8348036qtj.83.2021.10.04.06.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 06:47:30 -0700 (PDT)
Message-ID: <a1722c44-9788-0700-3d76-4199369d1c9f@github.com>
Date:   Mon, 4 Oct 2021 09:47:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH 2/7] sparse-index: update command for expand/collapse test
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <a1fa7c080aed2056afaad6415186c125c04a80cb.1633013461.git.gitgitgadget@gmail.com>
 <YVYNW13aVADaR+g6@nand.local>
 <6e9843d5-bc04-e69c-9e53-7bf18ca30fc8@github.com>
 <xmqqk0ixagw8.fsf@gitster.g>
 <e6049a17-c721-c596-51a6-101cb6065829@github.com>
 <xmqqr1d58v9x.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqr1d58v9x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
> 
>>> Do we need to update this further when "mv a b"
>>> learns to expand and then collapse?
>>
>> Unfortunately, yes. `git mv` was picked more-or-less at random from the set
>> of commands that read the index and don't already have sparse index
>> integrations (excluding those I know are planned for sparse index
>> integration in the near future). If `git mv` were to be updated to disable
>> `command_requires_full_index`, the command in the test would need to change
>> again.
>>
>> For what it's worth, I do think the test itself is valuable, since it makes
>> sure a command's capability to use the sparse index is always the result of
>> an intentional update to (and review of) the code.
> 
> Oh, of course.  
> 
> I was actually wondering if it woudl be a good idea to leave a
> command that will never be "converted" so that we can keep using it
> for testing.
> 
> Perhaps a new option that is invented exactly for the purpose added
> to a plumbing e.g. "git update-index --expand-collapse"?
> 

That sounds good to me! I'll add an `update-index --expand-collapse`
implementation and update the test in v2 of this series.
