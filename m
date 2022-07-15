Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148A0C433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 03:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiGODHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 23:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiGODGo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 23:06:44 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36577696A
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 20:06:43 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p81so2998132iod.2
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 20:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=sb3kM/A9UgTWNEt44I5WMDvP+l97nXMMU7dq8xnYxfE=;
        b=GP2A6qD5t9vhoD2FrcprLvlnWj4zCunu/qT/k+kaQvo5op/wnMal79WzqYtD3wTOYY
         4zsE0YGHubRfURZw2rZXy73NIpnWk5YM7JJ5CLyzuAipkXX3aoaSYUPuZ2oMUUypaU94
         wsKVQK91sNkarCGd2j9a/X4bFLMHLs5OtqvcgMPsmvJuxww4lfRQP3JzmETVJA3VCt6/
         Bpn7XxkAG97chBdgeV+x+AiOH4FMv67EDTvJS5nj66u3ISxFeXMwQf3OZ6E/9/lSuVa/
         04lGdqYnJcV1ZHHkuDK105SZ7eqjmngtMKeVk+eFQ1Vh5vSmY8UuJgzaCVMzZKU0TmCH
         fXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sb3kM/A9UgTWNEt44I5WMDvP+l97nXMMU7dq8xnYxfE=;
        b=2uAm8GnTooYVNnh9gQ6EDmegRRDvQmiKdXvzEzlc5m/rAmGftFBTh9l1miS53ydkqg
         M0jHjXO9IWgANTjEbuzy4V4EtQSU/vZGyrn83tG+/xKxvXhG1LQmWXUwzvMu7x1Vf/nN
         fQkjW2Tif2fTFvMmv668VvXhxdR3YruIMIEYoTU23XjICabbYkXbqTAsuYh+tt9rgOxU
         0xaTFXcYxSYUeEiBhfZ+DLrU+/WWZa4vRm9LwOW2yM5EYRrS72gIY+mmjpz/g8jNqm/3
         AM8B0gwr4ASjDa1SjcKPzMyhbbicaaMWFqPAfm2JYd7iPM63RQZALBjgMEmn5rfxQDhS
         /N1w==
X-Gm-Message-State: AJIora/SWkwSSC6xTqTOnkNMPIIYTqW0V/D5npiIsGDRCpd8dQZVcZvn
        a4x02tx7gv5rM4D5GVdN769O
X-Google-Smtp-Source: AGRyM1slCFIRCb+hSl9ONnAVn4Zt7jf93q1dtlBA3dD1YigLny7E5QLGQtppdvvaOCxdXuCtGVa4TQ==
X-Received: by 2002:a05:6602:14d:b0:67b:9536:680f with SMTP id v13-20020a056602014d00b0067b9536680fmr6045756iot.202.1657854403373;
        Thu, 14 Jul 2022 20:06:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a446:d79d:69be:6b29? ([2600:1700:e72:80a0:a446:d79d:69be:6b29])
        by smtp.gmail.com with ESMTPSA id p13-20020a02c80d000000b00339e2f0a9bfsm1458393jao.13.2022.07.14.20.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 20:06:42 -0700 (PDT)
Message-ID: <89310a11-b8cd-b643-5d46-c6d273f66b49@github.com>
Date:   Thu, 14 Jul 2022 23:06:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: 'git sparse-checkout add' hangs if local repo is using
 alternative objects store
Content-Language: en-US
To:     Dian Xu <dianxudev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CAKSRnEzYYQ1EOmbUvafQvzJUNW8kojLuD+BbakxU09JSm=niHA@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAKSRnEzYYQ1EOmbUvafQvzJUNW8kojLuD+BbakxU09JSm=niHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/2022 9:58 AM, Dian Xu wrote:

> Reproduction steps:
>     1. Local repo setup:
>         git init
>         git remote add origin <repo_url>
>         echo <alternative_objects_store> >! .git/objects/info/alternates

Is this alternative object store on the local disk? Or is it
across a network connection?

>         git config --unset-all remote.origin.fetch
>         git config --unset-all remote.origin.tagopt
>         git config --add remote.origin.tagopt --no-tags
>         git config --add remote.origin.fetch
> +refs/heads/main:refs/remotes/origin/main
>         git config core.sparsecheckout true
>         git config core.sparsecheckoutcone true
>         git fetch

This is interesting that you are fetching without having
any existing refs, only the alternate store. Are you using
something like the core.alternateRefsCommand config option?

Otherwise, I would expect this "git fetch" to act as if it
was a normal clone (unless of course the alternate already
has the current tip of 'main'). Maybe fetch negotiation helps
find some common commits that exist in the alternate, but the
client is useless in that discovery without refs.

>     2. Sparse checkout <dir1>:
>         git sparse-checkout set <dir1>
>         git checkout -b tmp1 origin/main
> 
>     3. Add another <dir2> via sparse-checkout, which hangs:
>         git sparse-checkout add <dir2>
>             09:39:11.169116 read-cache.c:2451       performance:
> 6.326754679 s:  read cache .git/index

Could you re-run this with GIT_TRACE2_PERF=1 so we can see
even more details about how this works?

> Repo and dir info:
>     <repo_url> is a large repo, containing large number of directories
> and 2 million files;
>     Local repo is using <alternative_objects_store>, which is working
> by verifying: git count-objects -vH;
>     <dir1> used here is one level deep, <dir2> used here is 5 level deep
> 
> Observations:
>     1. Even 'sparse-checkout add' hangs, scm code from <dir2> was
> actually downloaded pretty fast

I'm interested to learn what you mean by "downloaded" here.

>     2. If waited out 'sparse-checkout add', git seems start to
> download large number of objects from alternative objects store into
> local .git/objects

Hm. Adding the objects into .git/objects is strange. It should
recognize that the objects are in the alternate and not write
them to the local repo (this is independent of the sparse-checkout
builtin).

Thanks,
-Stolee
