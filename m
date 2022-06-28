Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02957C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 13:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbiF1NBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346009AbiF1NBV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 09:01:21 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99013054B
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:01:20 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u9so17036090oiv.12
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=9yc5BGZkSjtHkR/bHooQ4tIIYZ7/9dzBetbKBY8eNkI=;
        b=ez53IZrz3NE5Q59lrz7kQgKnNkW83Eoket6Z8jqmjQYIEviKIVZUJ3cLBTdwXOxl6h
         Y04wjEbvHNtusRsc9NyICSoy4oP/Ffzdyc653ru/g2cwIGZXR7LzncPTLV1JJtQoE6s/
         GLsZGer22lHIHE/3+546Bd30hnFoMkjk4f+YLNW+IfPPBupN6Bb2g2tzv7fbhb8KDIiz
         FhhzYk9e3cfYa1eyAwb4CoCR7ZAVtodXgFkU2c0TIvtp8uxb3arpwZgBH+ymVo7R9MIR
         RYo9a4La89HB0wFICM1LC1VWqNfDGfHiXgcoy/xEDJvV/3WAsz4m1TQ5EqsvsWx6xrK8
         9hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9yc5BGZkSjtHkR/bHooQ4tIIYZ7/9dzBetbKBY8eNkI=;
        b=jsLIVZpbf2ISAv8lSDkxZGVR9DRkWN8BQZhlMtRZZhR9etnxQr67u3m8sgCjvt8GhL
         QdBXM0T2f4ub/amdmYNuOyji1xbMEXbkg0ahTEur/kVAbNF3/Ll9edUGQ57aByrnn7F+
         tLQoRyivkiUHiraPt5fj/t89PZXIflHl2Yvslzvk/c266Yw0+ZKnylHxAv/tJ7JrdOT1
         CLJyqNIenFacz0XahATjzjlbGbmOh0X3Gr9GK+ibD1YoMwPpWCACU48PnKDV+eORo8I5
         1ysfW94GFiYiaQMpPAiUO0Jn91yf+ddOszLDsOIdR8gOd0iX9K/UuDFJxMki8Jzebv5i
         4qXA==
X-Gm-Message-State: AJIora/V+s3n1OXD/rB74HdeFk6W+jIEvIyk1By07axtvYVwTixf/ZTb
        vTbhWeFUsB36ecXZR5tRedXFgseUcE0O
X-Google-Smtp-Source: AGRyM1tuhPpJcMn2D5GA+zYLBAVQr1ZQ496JAeDIWc2RVeY6+pWNXPXgkSAtF70hreQKQeEc0ORgtQ==
X-Received: by 2002:a05:6808:14cf:b0:335:3595:c62d with SMTP id f15-20020a05680814cf00b003353595c62dmr14222122oiw.88.1656421279367;
        Tue, 28 Jun 2022 06:01:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9537:28a2:3225:9796? ([2600:1700:e72:80a0:9537:28a2:3225:9796])
        by smtp.gmail.com with ESMTPSA id p25-20020a056830319900b00616d412174dsm2849413ots.78.2022.06.28.06.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 06:01:19 -0700 (PDT)
Message-ID: <6439e948-ff79-9e10-97f5-378806e25b5b@github.com>
Date:   Tue, 28 Jun 2022 09:01:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: How to reduce pickaxe times for a particular repo?
Content-Language: en-US
To:     Pavel Rappo <pavel.rappo@gmail.com>,
        Git mailing list <git@vger.kernel.org>
References: <CAChcVumN66OxOjag9gPqgLq7gQrgdaEkZAJabusE-gGC7LLVyw@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAChcVumN66OxOjag9gPqgLq7gQrgdaEkZAJabusE-gGC7LLVyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2022 6:50 AM, Pavel Rappo wrote:

Hi Pavel! Welcome.

> I have a repo of the following characteristics:
> 
>   * 1 branch
>   * 100,000 commits

This is not too large.

>   * 1TB in size

This _is_ large.

>   * The tip of the branch has 55,000 files

And again, this is not large.

This means you have some very large files in your repo, perhaps
even binary files that you don't intend to search.

>   * No new commits are expected: the repo is abandoned and kept for
> archaeological purposes.
> 
> Typically, a `git log -S/-G` lookup takes around a minute to complete.
> I would like to significantly reduce that time. How can I do that? I
> can spend up to 10x more disk space, if required. The machine has 10
> cores and 32GB of RAM.

You are using -S<string> or -G<regex> to see which commits change the
number of matches of that <string> or <regex>. If you don't provide a
pathspec, then Git will search every changed file, including those
very large binary files.

Perhaps you'd like to start by providing a pathspec that limits the
search to only the meaningful code files?

As far as I know, Git doesn't have any data structures that can speed
up content-based matches like this. The commit-graph's content-changed
Bloom filters only help Git with questions like "did this specific file
change?" which is not going to be a critical code path in what you're
describing.

I'm not sure what you're actually trying to ask with -S or -G, so maybe
it is worth considering other types of queries, such as -L<n>,<m>:<file>
or something. This is just a shot in the dark, as you might be doing the
only thing you _can_ do to solve your problem.

Thanks,
-Stolee
