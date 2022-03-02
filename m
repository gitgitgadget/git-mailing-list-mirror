Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAE1C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 13:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbiCBNlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242202AbiCBNlb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 08:41:31 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EA927CD7
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 05:40:48 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id r2so292564qvr.12
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 05:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4SpMeYRPt2UYqb7G0WrfX+80xx0AOwd0mIH2qqtDlzU=;
        b=cc84X3ou3i7t0RHOhoU3OiqaA7KDahXpOBDvQ8j6eDeX6wqjTgs7Ju7K+3/Gw9FcrU
         9wZkKM2MlLVe+CAhIsO00CAku3lg/f0aVeBf9AfOw25tVP+2IZdtI9W03Z09kzKvt3hq
         GKKxjsTFo+AeusjUKNnt5f7j/iEs1+0bVXxSXFPJL40CTc9QLGsmlXeG3kU9KGoChZ5c
         JH5+9GcJBbI/eee+O4WLIy3F6j0DsBkqDPjsit2foHvlfk/vvs4k2APxN01YwmMKvV9v
         Kya6hQG7aJy2HyFol42KFpXZ0bsY1WsoOhhDmNOe2RpkmuQ1FMC7bfeyxi/BjSfC+eAb
         qOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4SpMeYRPt2UYqb7G0WrfX+80xx0AOwd0mIH2qqtDlzU=;
        b=VmvwXCLX+XdrQKHSry40urvlGwsdRxLkiZtq/VZIo6EgFZWQSyan9RROwmhuXpA73y
         0cIrDoa9zZUow49y3pAkIpAHHD0paTHku2hjO8XzeF+ocjnDjmtyTZTNZl0tX6JTI1hC
         9EX/YpwwPqNxcLhFwLK6ixAhxXVEYRkgDdKx1UbFayqfVst++JzpoAU3/wBI4lYOSDnJ
         AtBli2dQyN88IDnGVLni7njFg9CdtGa9qC61DRze1jUSiAbe9/8OfZc5ho3dktlJ+3ab
         lUhlG3TneVwZpxMJrYjW6I3Ij3YLOiQwMbifkoWm89Ej+dzXuotYXKLywmmjrgS6BmWk
         nXkg==
X-Gm-Message-State: AOAM532hxp/LfAEjyb5dSEZjFz50GHJdIxkKfxn9aPuPVd6c0A80ak0u
        48HcqpWvyEqXQ1ZBnY7N0TRJ
X-Google-Smtp-Source: ABdhPJzF2qdCMKBZEC0JrPvnpRzFtV4/wse+h0HIBIWmPfrAhi8sVzl7So2p8dmbjgyJShFngnmOog==
X-Received: by 2002:a05:6214:202f:b0:432:4810:1b34 with SMTP id 15-20020a056214202f00b0043248101b34mr20615023qvf.35.1646228447892;
        Wed, 02 Mar 2022 05:40:47 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 75-20020a37044e000000b006492ac3b501sm7961735qke.7.2022.03.02.05.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 05:40:47 -0800 (PST)
Message-ID: <7f16a81e-d806-57f9-51c4-ff9462c388e5@github.com>
Date:   Wed, 2 Mar 2022 08:40:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 0/8] Sparse index: integrate with 'read-tree'
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>
References: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
 <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
 <CABPp-BHxt2cM0E47eYTn=+H-FYJEQ54O7x2TAbqawwFMWAGYgA@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BHxt2cM0E47eYTn=+H-FYJEQ54O7x2TAbqawwFMWAGYgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/2/2022 2:22 AM, Elijah Newren wrote:
> On Tue, Mar 1, 2022 at 12:24 PM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:

> I've read through all of these.  This round is:
> 
> Reviewed-by: Elijah Newren <newren@gmail.com>

Thanks to your and Ævar's extra eyes, this series has
only improved since I reviewed v1.

Thanks,
-Stolee
