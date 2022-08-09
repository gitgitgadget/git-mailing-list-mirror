Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F94FC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 15:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244390AbiHIPuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 11:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiHIPut (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 11:50:49 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D54167D1
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 08:50:48 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w28so874378qtc.7
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Kfm50wiQ+7F89CmKi4GWKVtMXjqJLt3eaQZxyIMNcEk=;
        b=HiWWoRaLNRv9NuXYhcCleDQuw3MfP99B6rftCpUKC0VHpHE1aBYSeoLjhjaU1btrtB
         6sRdbR2mHYCkHJ0Bpp41dnpp7RJ1i2WHulxaoI2Vio9ghyFZbBaY9EKGvd7hqH+xoggo
         hhXBhEqB0/1yXV/BxmNgfJNDQFBoBbx9B49r+WhYtzUNDUShR2+ixEx3HzXCIutsF4Oz
         ce/TB0fXD8oHYRXmffONtli1uPNdHZb4l/8SAsn0sDVjtvb970T9NaS4M3OO7H2kLGQ2
         /uidjg0q6pspQkrc6BFXUdSJxMvUb8l6yD4BbFv+ZytZk8pGKhjvw6coxVmr94hFfDnj
         9vKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Kfm50wiQ+7F89CmKi4GWKVtMXjqJLt3eaQZxyIMNcEk=;
        b=cICrIif5Zkw3sxfMyZR1bx/hOuaG4LXz/eARRksaajJriQlDsG8+NdtC54GlzvqPO7
         BqzfRCMNtaIXapIpugC+tqr4bP2dMY/tw3rYQBaTvG6/O78/4StASec/IcQ8PJ5mqwnx
         eUAhZJ2VTJrM+4kSDWhJ5/y0+aLJ6eI+hBdDndPopKMI/iMC2R4LLTopbJhyjTD28L32
         RSI3jsAlFha1Zr88ttD+ZTZCpQMe/xYdaJg/bIKiqwGhGS2q+njIBi1WdO9Cs4b+2pqS
         AsvdGn0lbzCFMqsjXB+sAC/Frlhk9yDaymAXR5aRLbYXLUWC1qvksasNvh9+hMZ0lI7y
         3+Ew==
X-Gm-Message-State: ACgBeo0XjizHzeytUNuV/bjreM3GVTh4PW3wols/zK+jwgeHu74S1JMf
        5RgeuUGl+M1pp5o4Rr/AYQx8
X-Google-Smtp-Source: AA6agR4gzv9lFh2zAjsySxkCQzJVD7hYMwVKB28os1uywQRkk5a2m1w/1HU9lu+lp2y2C7lSbgNoSw==
X-Received: by 2002:a05:622a:1212:b0:31f:266:de9 with SMTP id y18-20020a05622a121200b0031f02660de9mr21081773qtx.515.1660060247490;
        Tue, 09 Aug 2022 08:50:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:14e1:3e6e:802:8594? ([2600:1700:e72:80a0:14e1:3e6e:802:8594])
        by smtp.gmail.com with ESMTPSA id y4-20020ac81284000000b00342f4fc290esm5605783qti.71.2022.08.09.08.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 08:50:46 -0700 (PDT)
Message-ID: <bce18d3e-ac37-7c7a-d411-d0aad87a8f68@github.com>
Date:   Tue, 9 Aug 2022 11:50:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 0/2] bundle URIs: design doc
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
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
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <5b98f1d8-e829-98db-1d13-7aba6c126f8d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/9/2022 9:49 AM, Phillip Wood wrote:
> Hi Stolee
> 
> On 09/08/2022 14:12, Derrick Stolee via GitGitGadget wrote:
>> This is the first of series towards building the bundle URI feature as
>> discussed in previous RFCs, specifically pulled directly out of [5]:
>>
>> [1]
>> https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
>>
>> [2]
>> https://lore.kernel.org/git/cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com/
>>
>> [3]
>> https://lore.kernel.org/git/pull.1160.git.1645641063.gitgitgadget@gmail.com
>>
>> [4]
>> https://lore.kernel.org/git/RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com/
>>
>> [5]
>> https://lore.kernel.org/git/pull.1234.git.1653072042.gitgitgadget@gmail.com
>>
>> THIS ONLY INCLUDES THE DESIGN DOCUMENT. See "Updates in v3". There are two
>> patches:
>>
>>   1. The main design document that details the bundle URI standard and how
>>      the client interacts with the bundle data.
>>   2. An addendum to the design document that details one strategy for
>>      organizing bundles from the perspective of a bundle provider.
> 
> I thought the document was well written and left me with a good understanding
> of both the problem being addressed and the rationale for the solution.

Thanks for the kind words!

> One small query - the document mentions CI farms as benefiting from this work
> but my impression is that those commonly use shallow clones which are (quite
> reasonably) not supported in this proposal.

There are two different kinds of CI farms.

The most common one is a SaaS CI system that provides machines on-demand,
but each run starts from some "clean" state. For example, GitHub Actions
runs CI builds of the Git project across a number of platforms. These
machines need the source at HEAD, but do not need the full history. Further,
they will erase the repository entirely at the end of the build, never
fetching from those repositories. Thus, a shallow clone makes sense to
minimize the data transfer. Bundles don't make sense here for multiple
reasons, including that bundles must be closed under reachability and do
not work for representing a shallow clone (see [1]). The other reason is
that CI builds typically are triggered immediately after the commit appears
on the origin Git server, so there is no time for a bundle provider to
create a bundle representing that shallow clone.

[1] https://github.com/git/git/blob/c50926e1f48891e2671e1830dbcd2912a4563450/Documentation/technical/bundle-format.txt#L65-L69

The less common one is a private build farm. These machines are long-lived
and controlled by the repository owner. They come pre-loaded with all of
the software needed to build the repository. The best practice in this
type of build farm is to keep a full clone of the repository in a well-
known location and use incremental fetches to update the client repositories
to download the commit necessary for the build. This type of build farm is
typically self-hosted, but could also be hosted by a cloud provider. The
bundle URI design allows ways to quickly bootstrap new build machines using
a bundle provider (probably co-located with the build machines) as well as
improving fetch times by creating frequent incremental bundles. The new
commit being built is unlikely to exist immediately in the bundles, but it
is unlikely to be too far ahead of any of the bundles.

While private build farms are less common, they do become necessary for
large projects. Engineering teams that have the resources to self-host a
build farm are likely to also have the resources to self-host a bundle
server. They may not have the connections or desire to advertise those
bundle server URIs from the origin Git server.

I hope this helps clarify my perspective as to why build farms using long-
lived copies of the repository could take advantage of bundle URIs.

Thanks,
-Stolee
