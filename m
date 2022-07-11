Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87ADC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 22:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiGKWzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 18:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiGKWzN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 18:55:13 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A629823
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 15:55:12 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id r12so1435140qvm.3
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 15:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=+GsB2SnDbCVZRNBUVB6gvi9lKrV92qhbBL226XpavSE=;
        b=a04YIfVN8wsebxWKQyGDrnGj8C0YJSk0uvMAlMav8fa4t+whCFKRh+z5YneiOqKBSj
         HC/4AWBfECfwSLjM3t9dJK8RmKtxK63axUq6/M5fTlAtt8uhT+4L0aDP8KOOqnhEL5kz
         lgCeW6Zl9qJZffQt+7OCGDSANw54DGV9AAem52i0ORr2NIJ20XBsbAUCEpJpwm4TImX0
         gZ1+Or+4L5kM0qg7LOCpJAd1qPzaLJqQEtBrHuocHerko9FqYutsZDmIf2o2/TTHUL6S
         JVDrzMXh6xHYGwvMGHI2QJjaB9fjl+5Xzf9IEGZyvOmTuDvMPtRsk0C7sP5NE4juK8If
         Zv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=+GsB2SnDbCVZRNBUVB6gvi9lKrV92qhbBL226XpavSE=;
        b=TwIh0MlfndLjNXsepv09Etqh0tOKeTMjx0Gn2JWSL7cZJ6jvm2TUqusfRJ7aqVz8iw
         w3bI2wZ/1Am0DT8oZpwippqmd6Db6TEBSL8I9xRrqrnEVak0wvWlWIBtVIH7lhvwXEj/
         KpQOgEQApZILxZPMmNFI5TydkYVf7m1+v1FPGR7AnBhTYlYqXKGQcn2Q6gnX1IzJ5t3O
         sHxZ+bg/NeR40EriB83xu0fy08r2YE/azeRUGGeLJu8traWwcpUSgkogM9aBXT5zm45V
         jNXPYgAMV7ZVch9GrxTUuyEpsAXYV4DS8XU9JHQvj6ki7iX1n/k+f4h6a0yzwM5KhRVv
         Um5g==
X-Gm-Message-State: AJIora/GGTqqRnXa69r2sKNI8FuNaZZ60/6XVfFkZFjE4uKAIoB7RrVW
        RyiNkrhdARLgqtefOVH731yy33HOiSXqPA==
X-Google-Smtp-Source: AGRyM1u7eRM2dNeeBPDce0gMz1YfTPFFj9OQvqOZ+OKuD3zqiRQDmAAi/gSwE4drkjYZ+8kR3QOM4g==
X-Received: by 2002:a05:6214:2346:b0:46e:5de3:9f67 with SMTP id hu6-20020a056214234600b0046e5de39f67mr15243851qvb.4.1657580111228;
        Mon, 11 Jul 2022 15:55:11 -0700 (PDT)
Received: from ?IPV6:2605:2a00:8000:dead:55a4:52ad:2bdc:5b8c? ([2605:2a00:8000:dead:55a4:52ad:2bdc:5b8c])
        by smtp.gmail.com with ESMTPSA id ay18-20020a05620a179200b006af0d99c7fesm7128361qkb.132.2022.07.11.15.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 15:55:11 -0700 (PDT)
Message-ID: <f0bb8ee8-9b38-45a7-a54b-24cf245bb3c8@gmail.com>
Date:   Mon, 11 Jul 2022 18:55:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Gerriko io <gerriko.iot@gmail.com>, git@vger.kernel.org
References: <CALF=2ANoq1eL-RqK_dLaVThoxbvfhzgPJXFHyD1kX8CFCPx3XA@mail.gmail.com>
From:   Thomas Guyot <tguyot@gmail.com>
Subject: Re: Why is reflog so obscure?
In-Reply-To: <CALF=2ANoq1eL-RqK_dLaVThoxbvfhzgPJXFHyD1kX8CFCPx3XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-07-11 17:02, Gerriko io wrote:
> I am trying to make sense of reflog as I need to know this to use
> revert and reset properly.
>
> I cannot find the most basic information in the git documentation or online.
>
> Surely the most basic question is whether the reflog is sequential or
> just random logs or whether it is in time ascending or descending
> order.
>
> Without this information I am left baffled and have to guess what this
> line means out of the many:
>
> a0bbd34 (HEAD -> master, origin/master, origin/main)
> refs/remotes/origin/main@{0}: update by push
>
> Why does it have to be so obscure?

Hi,

The reflog is simply a log of where you've been, in descending order 
(latest entry first), and is branch agnostic. It show every commit 
you've been on from latest to oldest, and each entry can be heads, tags, 
or detached commits. Some operations like rebase may even generate 
multiple entries if it's done in multiple steps (ex conflicts resolution).

I believe its main uses are to delay garbage collect (which happens only 
after entries have expired form the reflog) and to allow refs selection 
using @{date} and @{nth} specifiers (see git-rev-parse, and note @{date} 
is not the commit date but rather the reflog date!)... And it's 
obviously quite handy to recover a dropped/rewritten ref if you realize 
you need to undo what you've done.

Since the date is recorded for each entry you can also display it using 
the --date=<format> option. For example to display reflog entries in 
local human-readable time, use:

git reflog --date=local

The git-reflog log display options are mostly the same as git-log and 
documented in git-log's manpage.

Regards,

--
Thomas
