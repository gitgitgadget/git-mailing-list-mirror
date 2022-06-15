Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C35C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 18:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356371AbiFOSSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 14:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357105AbiFOSSE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 14:18:04 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3458F2AE16
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 11:18:00 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c83so9373986qke.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 11:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xgxy69vQau34/fC3tg8ZGhXvu1epBsQOtUYst1QimxQ=;
        b=OtmlNf1NzuLK4HBl3PSuHXMWW0Du9LBDN9GGhEJi68NleBc51H2tytA5fmT1CC0C1s
         rfWT2m4VPXkNXStikhmE/JXD+DQluboBe9o8jhlSG/fInU5CJdXu2Bo9ZCqJhq0rdEj9
         r41vCkE3ptJPkmlhef7rkrbYAcrtUdOhtzLE5GTnTp6iPJBUW7Ivv5H6FceOU3J3bwJT
         cZIe4KVhfNq6pJ/FGfe0qPGb6Ixf5+2BCQcjAigwxcSBeuTZJEzyfO86KiUHqGOK01vW
         KG0OQJ6nfqpbrIFBZzFAxDrrSNYjhOvg08nBs5PJPOaB1xcnuuJgqypKe1jagI8klP9g
         Nd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xgxy69vQau34/fC3tg8ZGhXvu1epBsQOtUYst1QimxQ=;
        b=uyGjjkx6hiaeJ4+HKpTFJemus5HNKp36RDV66izTXEpEIDQ2sFIWTojnEAB7SZzIqW
         kMLrCOA5GFlW0BpyfIU0pz3bYQWT1Qs19phFb0OVssaD2NL/1xSywbfPEx+MJsqcFjl1
         abmJIuVJzbVJhwpRvVz8dCk0MfIDgDtKcIdHz/uamG+73Ubqa1ULuH7BW2dX0Ah6XD41
         mWO6GR8hbt1GsDLWVPylieAXlv6ueAY8YuieoQLZuHLArnNadgLU1THt2fdq5RqvurYl
         jd0zW271lVFaremfHKwFQkDuYwa+clY0OiBwCxAOpez+nIAkvSLn9rFylOfo+krFZMz/
         R+/A==
X-Gm-Message-State: AJIora/KAt0CmDOR0IkdT/p8US91A6sE4o7h/jqNWyyMLFn+6BvZXRlf
        VrCNkIUBDwIjGDrCFTL2JzJD7nRgWM8t
X-Google-Smtp-Source: AGRyM1tPNUh18g+41Xp+jr26K9setIMqXUGdfLPbn0XhYjPoqLFIV8gvbr7iKsv8VegYm4FOajS4NA==
X-Received: by 2002:a05:620a:1264:b0:6a6:e38c:3213 with SMTP id b4-20020a05620a126400b006a6e38c3213mr782667qkl.315.1655317079200;
        Wed, 15 Jun 2022 11:17:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:39b0:f38b:602a:a5c2? ([2600:1700:e72:80a0:39b0:f38b:602a:a5c2])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87148000000b0030501abadabsm9721432qtp.19.2022.06.15.11.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 11:17:58 -0700 (PDT)
Message-ID: <1fe6c00a-806c-89de-cb67-d063dc4a5279@github.com>
Date:   Wed, 15 Jun 2022 14:17:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mktree: learn about promised objects
Content-Language: en-US
To:     Richard Oliver <roliver@roku.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
 <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
 <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
 <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
 <YqkpRE8nykqVv8cn@nand.local> <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
 <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/2022 1:40 PM, Richard Oliver wrote:
> On 15/06/2022 05:00, Jeff King wrote:

>> So it is not just lookup, but actual tree walking that is expensive. The
>> flip side is that you don't have to store a complete separate list of
>> the promised objects. Whether that's a win depends on how many local
>> objects you have, versus how many are promised.

This is also why blobless (or blob-size filters) are the recommended way
to use partial clone. It's just too expensive to have tree misses.

>> But it would be possible to cache the promisor list to make the tradeoff
>> separately. E.g., do the walk over the promisor trees once (perhaps at
>> pack creation time), and store a sorted list of fixed-length (oid, type)
>> records that could be binary searched. You could even put it in the
>> .promisor file. :)
>>
>> -Peff
> 
> I like the idea of caching the promisor list at pack creation time;
> I'll start work on a patch set that implements this.
> 
> Meanwhile, is it worth considering a '--promised-as-missing' option
> (or a config option) for invocations such as 'mktree --missing' that
> prevents promised objects being faulted-in? Currently, the only
> reliable way that I've found to prevent 'mktree --missing' faulting-in
> promised objects is to remove the remote. Such an option could either
> set the global variable 'fetch_if_missing' to '0' or could ensure
> 'OBJECT_INFO_SKIP_FETCH_OBJECT' is passed appropriately.

One issue I've had with the current design of partial clone is that we
put all of the filter logic into the remotes, not the repository itself.
This means that if I use "git remote add" to add a new remote, then that
remote does not inherit the filter (and hence fetches can be too large
or even fail because we are "missing" an object pointed to by the
resulting pack).

If we had a repository-scoped notion of the filter, then we could
special-case this mktree logic to assume a blob if the filter only
excludes blobs. That would be even faster than looking up the type
from a "promised objects" file.

Just thinking about smaller steps that could simplify things before
adding a new data format. Feel free to continue pursuing that lookup
file if that's what you think will work best.

Thanks,
-Stolee
