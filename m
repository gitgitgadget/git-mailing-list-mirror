Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743F6C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 13:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiF0Nz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 09:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiF0Nz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 09:55:58 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77C1B1DB
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 06:55:57 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id w3-20020a4ab6c3000000b0041c1e737283so1900549ooo.12
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bz+MVlq2rHngA7FPSC2kYKmtz/i8DyTqV0EPF2Bx43c=;
        b=W1y5hs72aMObrvkH46p4F5oWgAXdOPJ6u/UaAk0Vyr3kvwZa7OIpt0dC8tuFSex86d
         aBVDMERSPEtsgExx2nKzdeFlgUoTqyNsyy0UqL6Hxiv7Rf2wRBH75jfOPA1pFOvONsze
         tuvYu+7iNS66g7DlpbQYocShfwGElqBV9dAmhKfVrMAnqqk5g9Wa6r5jcLp7ep+cUJao
         cvdo3DY81ziDiOW/zA8eYzYdMZcODn3ZfOA3+sY9Xh+0DtQnB1ZNeJuNh7qG3vepr/Ge
         POhzbtiFbF0bDx32PkYwVbphmumQG0VbgxtdEnEgDJ3+KF0QFi/BxhKcqaMZQ9TVs7Ed
         CRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bz+MVlq2rHngA7FPSC2kYKmtz/i8DyTqV0EPF2Bx43c=;
        b=LfiDh5E5R+wEDfJJGZ3JHa67lmCpi0CVuTkg/qdFByuAeREecj2T/NySvBSst/xc4g
         sZK0cXLlIY9HStUvGBrCpr3GIZ5b50WY4Mpw1839Yx6eSEL66xI3cjFhEd4kCHMEBawF
         UH0ul0YlHwpCkxu4wSR09G7kefuL4qov+H3B7C+VaGIOk8DY95IgdFTYdME5YhKjRoZX
         ToF0amVn0y8exlrSiUNlaBq0VLDDrX22lAH5ENA7z6P0OXTw/4H9JRO66vCV2957RXSR
         d0fkl3Yt9i7WRdKMl5YarCwz7ehDRvgJUiKP03TKOnSHMHlKdoMgUfAui5i0DRRCok3A
         h7VQ==
X-Gm-Message-State: AJIora8BQiD4T7y+08CbrF781jAY0w3QpSzNdoKG2T5LaUj/0nWgEy2b
        Y/+heF/OjOJqdk8t5qhkWNTR
X-Google-Smtp-Source: AGRyM1tgEXY7VURFwlNDCS11qedlMgRUE82jXiEnU8OoBjD8NRu+Cdfzlxd1dLN02jB5Xg7rQNEAZQ==
X-Received: by 2002:a4a:944c:0:b0:41c:18de:d334 with SMTP id j12-20020a4a944c000000b0041c18ded334mr5817251ooi.4.1656338157189;
        Mon, 27 Jun 2022 06:55:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:714a:b337:6fac:e704? ([2600:1700:e72:80a0:714a:b337:6fac:e704])
        by smtp.gmail.com with ESMTPSA id n21-20020a4ad415000000b0042560c9876dsm5900084oos.23.2022.06.27.06.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 06:55:56 -0700 (PDT)
Message-ID: <5585614d-0bb2-a889-4be3-1d1710f9ddb5@github.com>
Date:   Mon, 27 Jun 2022 09:55:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 2/7] mv: update sparsity after moving from out-of-cone
 to in-cone
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-3-shaoxuan.yuan02@gmail.com>
 <3e84bdc5-31e7-a7aa-8404-228424810f35@github.com>
 <f9e32b31-8b4a-2d07-4074-be10347764fa@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <f9e32b31-8b4a-2d07-4074-be10347764fa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/24/2022 4:04 AM, Shaoxuan Yuan wrote:
> 
> On 6/23/2022 11:08 PM, Derrick Stolee wrote:
>> On 6/23/2022 7:41 AM, Shaoxuan Yuan wrote:
>>> Originally, "git mv" a sparse file from out-of-cone to
>>> in-cone does not update the moved file's sparsity (remove its
>>> SKIP_WORKTREE bit). And the corresponding cache entry is, unexpectedly,
>>> not checked out in the working tree.
>>>
>>> Update the behavior so that:
>>> 1. Moving from out-of-cone to in-cone removes the SKIP_WORKTREE bit from
>>>    corresponding cache entry.
>>> 2. The moved cache entry is checked out in the working tree to reflect
>>>    the updated sparsity.
>>
>> Since this is a behavior change, can we test it? It would be good
>> to verify that the new path exists in the worktree after 'git mv'
>> succeeds.
> 
> I don't think we can effectively test this based on the change per se.
> This change is preparing a correct behavior for the next few
> commits, so I'll say it's tested along with the next few commits
> (i.e. move "sparse" file/directory ones)?

Ah, right. There are other reasons why moving from out-of-cone to
in-cone is blocked at this point in time.

Thanks,
-Stolee
