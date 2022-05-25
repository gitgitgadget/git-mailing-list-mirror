Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60E3C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 13:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiEYNa7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 09:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiEYNa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 09:30:58 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F07A35843
        for <git@vger.kernel.org>; Wed, 25 May 2022 06:30:57 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id q10so25014948oia.9
        for <git@vger.kernel.org>; Wed, 25 May 2022 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kXCKlRp9Q0BM46+oHeXuksKT53rT0dpjGHIrL7Cl+zo=;
        b=TvxWJMUEygw0B0Z7ld6SeR/0YnoYhd3oH5XOYezy6isK2j6Q4hw3IATHW/0bDnTr6+
         wFWtxVdPkybyshFzE4afoRnYKBEqmEYTa9Y9d5CJ5gr0mDrkHBVPYSnPrJaNNHucape6
         sY0kgzxiwdmgyKaZMBj1e+ofBS8aPqfmjqMzMLMly4vvnO3iC9HVnRD7iUQyOwFpYkCm
         nhkHusMDsIkqUBsbDNUo/c/9zGis6Gi1RZ6p/orn6l+x7lHa9TLTn7tTV2nQ6NEENNDP
         CxmAeCQftkDqU10hD+uQJDKcl2PHDQQPmoSisSoaPhoJ/yZdKxEzBUIoBrkbAChqLBsf
         m9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kXCKlRp9Q0BM46+oHeXuksKT53rT0dpjGHIrL7Cl+zo=;
        b=wnqQFmkpoH1PZATWuENZ7ObB4s55OJLGwkW268lniH1cTUAHl60QW5c6r5UILolrT/
         Px76zw6WElU6ALYxN+Kq3ZVNtRjVfIVQHFhVVM6f5zBZ2p8RqbXmOMaVl1AgK/YX21IX
         RsFoonfdbmbk1B2O7jUsfnBfO1tKHzZ7o4Pf1C/IAPhCVnmRlLU9/OM/i8gsErcvVOm/
         2XjAb1zFtFkswC2TXpWc7EUgtZCQtOMTlmVk8jfPSNnQTBk6DoIoEOCFOLmOjR06heC8
         /PAkSykXR0N9CvUtZh8Ho2qjkAM4JGUtHeNuGgIlD/hmZ6M/gs18lnjQ/oohy5rWTI1e
         gNCg==
X-Gm-Message-State: AOAM532AkOaihjM2lnm/XVsOGCgBBayCP4xxM5wKMYA5QsbBWAQ4nt3Y
        samuMvEsgy3Ue4D3QbDRdENE
X-Google-Smtp-Source: ABdhPJzQWjusU1/JcF6UuIyj3rVOmcoVPVdwkYprU9Q3N9deD9RCfMJNxXXGiM4xv7zZwfrn3viMaw==
X-Received: by 2002:a05:6808:2212:b0:32b:653c:3b85 with SMTP id bd18-20020a056808221200b0032b653c3b85mr4985932oib.57.1653485456666;
        Wed, 25 May 2022 06:30:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b144:5f1c:7ca1:15fd? ([2600:1700:e72:80a0:b144:5f1c:7ca1:15fd])
        by smtp.gmail.com with ESMTPSA id w19-20020a056870431300b000f26a4e2cdfsm3292949oah.18.2022.05.25.06.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 06:30:56 -0700 (PDT)
Message-ID: <32db3720-e9c8-e192-6278-c55855ce1d3e@github.com>
Date:   Wed, 25 May 2022 09:30:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: adding new 32-bit on-disk (unsigned) timestamp formats (was:
 [PATCH v5 02/17] pack-mtimes: support reading .mtimes files)
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     rsbecker@nexbridge.com, 'Jonathan Nieder' <jrnieder@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        tytso@mit.edu
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
 <Yo0ysWZKFJoiCSqv@google.com> <015d01d86fa6$a10519f0$e30f4dd0$@nexbridge.com>
 <Yo1bUbys+Fz7g+6h@nand.local> <016e01d86fc5$64ecf180$2ec6d480$@nexbridge.com>
 <Yo1zW7ntTuNakpOD@nand.local> <220525.86o7zmt0l0.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220525.86o7zmt0l0.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/25/2022 5:11 AM, Ævar Arnfjörð Bjarmason wrote:
> I must say that I really don't like this part of the format. Is it
> really necessary to optimize the storage space here in a way that leaves
> open questions about future time_t compatibility, and having to
> introduce the first use of unsigned 32 bit timestamps to git's codebase?

The commit-graph file format uses unsigned 34-bit timestamps (packed
with 30-bit topological levels in the CDAT chunk), so this "not-64-bit
signed timestamps" thing is something we've done before.
 
> Yes, this is its own self-contained format, so we don't *need* time_t
> here, but it's also really handy if we can eventually consistently use
> 64 time_t everywhere and not worry about any compatibility issues, or
> unsigned v.s. signed, or to create our own little ext4-like signed 32
> bit timestamp format.

We can also use a new file format version when it is necessary. We
have a lot of time to add that detail without overly complicating the
format right now.

> If we really are trying to micro-optimize storage space here I'm willing
> to bet that this is still a bad/premature optimization. There's much
> better ways to store this sort of data in a compact way if that's the
> concern. E.g. you'd store a 64 bit "base" timestamp in the header for
> the first entry, and have smaller (signed) "delta" timestamps storing
> offsets from that "base" timestamp.

This is a good idea for a v2 format when that is necessary.

Thanks,
-Stolee
