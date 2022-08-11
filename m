Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C861AC19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 15:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiHKPvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 11:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbiHKPvG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 11:51:06 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E0C9E107
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 08:42:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z17so21777494wrq.4
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=4jPw+HTYCUzNlBhqYEUPIbyHJ/BJ7XaUl7HRVWGen0o=;
        b=JTYSVKooYLZy9HxqHmP2y1cPRntDyosAimpQqVXi99irg0tUsb52cOKsqiIgeBDIfA
         16d2W6ljao/g9YAXOlT3cLkd4P/yY6UfCv9jIzCZvq2J4tynDcGt4oJxTJxI5MAYTFdw
         bGz3EVh5Ky7ExQOkuC7Pg4ay7ig7z1f5CxgaDVPmlLGJW6otouF2OcuUp4hccwouIPCY
         jcxERmMOfs/zEyhbYFu/tMgWBG3Uy+KmXLJck38XwQx2Z20NMWYN3LcOh1npKmFnRwVO
         2LzbjezGxucBG7p0pbLQ3HOd9ZREMvBYgeiypxvlH22vwgUHUUXRm1LfGhE/FnhEhrPP
         ei/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=4jPw+HTYCUzNlBhqYEUPIbyHJ/BJ7XaUl7HRVWGen0o=;
        b=fzMqelWHfhyw/cukCEStmvLWoubRgak30tcTPg2ndZZUOtQ21ntraM4IAhK/GmJPPp
         yKxBcqsa4LxxA1EvTbt21EvQaTBG5oH464m1bz16YE9kV7zdr5psYJ2bgk4POYU36OrH
         g1UeVwexmYX39hyN/7rd7W0/FuLY8aVFNdqYD976RxKTftajcUAGklbZFHnIxM8IaBBL
         ey60N7c1HoQ93lrzm6wbKIidc2vONGEQ8FCTiGVYc0QxFKS97vRJesClpbvAdwHsuALS
         Z4puOslIXDQk/y3kQB18BOU3vsXZdrOOkr4dGC6DiWIeTSby7V5NPwMDn2ier4ArRCCJ
         qONQ==
X-Gm-Message-State: ACgBeo2u5zMme00J/s/HkCN9RskxeFIP/XpTZ2qzoM2k5sdIF0izLaE9
        /xrXjGJKvJP5qYGKGbrarSk=
X-Google-Smtp-Source: AA6agR7JLNFmnhf31fgFHiiYOwovTo+PEdeofTPhIeB/lnMgUqDH4hbPvfYaT5vCbMaCyMU4+gQILg==
X-Received: by 2002:a5d:4907:0:b0:21f:bc42:989 with SMTP id x7-20020a5d4907000000b0021fbc420989mr20470699wrq.375.1660232568429;
        Thu, 11 Aug 2022 08:42:48 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id q10-20020adff94a000000b0021d80f53324sm19269312wrr.7.2022.08.11.08.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 08:42:48 -0700 (PDT)
Message-ID: <9524d32c-6726-d556-730d-2324b300dc72@gmail.com>
Date:   Thu, 11 Aug 2022 16:42:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/2] bundle URIs: design doc
Content-Language: en-GB-large
To:     Derrick Stolee <derrickstolee@github.com>,
        phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Josh Steadmon <steadmon@google.com>
References: <pull.1248.v3.git.1658757188.gitgitgadget@gmail.com>
 <pull.1248.v4.git.1660050761.gitgitgadget@gmail.com>
 <5b98f1d8-e829-98db-1d13-7aba6c126f8d@gmail.com>
 <bce18d3e-ac37-7c7a-d411-d0aad87a8f68@github.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <bce18d3e-ac37-7c7a-d411-d0aad87a8f68@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 09/08/2022 16:50, Derrick Stolee wrote:
>> One small query - the document mentions CI farms as benefiting from this work
>> but my impression is that those commonly use shallow clones which are (quite
>> reasonably) not supported in this proposal.
> 
> There are two different kinds of CI farms.
> 
> The most common one is a SaaS CI system that provides machines on-demand,
> but each run starts from some "clean" state. For example, GitHub Actions
> runs CI builds of the Git project across a number of platforms. These
> machines need the source at HEAD, but do not need the full history. Further,
> they will erase the repository entirely at the end of the build, never
> fetching from those repositories. Thus, a shallow clone makes sense to
> minimize the data transfer. Bundles don't make sense here for multiple
> reasons, including that bundles must be closed under reachability and do
> not work for representing a shallow clone (see [1]). The other reason is
> that CI builds typically are triggered immediately after the commit appears
> on the origin Git server, so there is no time for a bundle provider to
> create a bundle representing that shallow clone.
> 
> [1] https://github.com/git/git/blob/c50926e1f48891e2671e1830dbcd2912a4563450/Documentation/technical/bundle-format.txt#L65-L69
> 
> The less common one is a private build farm. These machines are long-lived
> and controlled by the repository owner. They come pre-loaded with all of
> the software needed to build the repository. The best practice in this
> type of build farm is to keep a full clone of the repository in a well-
> known location and use incremental fetches to update the client repositories
> to download the commit necessary for the build. This type of build farm is
> typically self-hosted, but could also be hosted by a cloud provider. The
> bundle URI design allows ways to quickly bootstrap new build machines using
> a bundle provider (probably co-located with the build machines) as well as
> improving fetch times by creating frequent incremental bundles. The new
> commit being built is unlikely to exist immediately in the bundles, but it
> is unlikely to be too far ahead of any of the bundles.
> 
> While private build farms are less common, they do become necessary for
> large projects. Engineering teams that have the resources to self-host a
> build farm are likely to also have the resources to self-host a bundle
> server. They may not have the connections or desire to advertise those
> bundle server URIs from the origin Git server.
> 
> I hope this helps clarify my perspective as to why build farms using long-
> lived copies of the repository could take advantage of bundle URIs.

Yes it does, thanks for taking the time to explain that.

Phillip

> Thanks,
> -Stolee
