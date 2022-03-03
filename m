Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A207BC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiCCQUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiCCQUp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:20:45 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACF8199D63
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:19:59 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i11so7256401eda.9
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5xUZjhqPG6/ebRtLtRRWTUmoCtdB9SHlstr2llP/f0k=;
        b=DjNmgU3+Tx5nK9Qj0fazDZy7x1m5Cjq87xMjCIXeHdOIwks9X64QH68rsZkFpYHM2T
         2n6CbNSVtsuMem1Pe2BWSn+vGZO0j9pShOnPxVbkOMXHwueIi+MkG/pM5HI+lD3lPqI0
         hipHmASdcBFS3D2ktnlCS6RtJIzGxiDw05uw+P/BaiGmjJZHrnm9O04eXBZWQ4g3f6Sb
         2xY2kvLKmMNZW4gyuhN+J6SbQJ6svDuudAqbmQdYxgzFv6TOPILPszDEC5Eok5mMy6Aw
         FmnDr6z/xgC8ghkgvqDf52fmbta2P2G6Se+8xM7SmBLDjSLOzoPlX2kzc9HVwT0FN0up
         1Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5xUZjhqPG6/ebRtLtRRWTUmoCtdB9SHlstr2llP/f0k=;
        b=huJ1UJkMrVQBX9mbC+ogYerzh7nY2NN+K3VdwBMkqc7r21+ChRaI6xfV3Pn8Xbi+0J
         WJU3pS5c8GoKTU8q5LGlx0Ssnl+SJz41d+OHnk2WgzIvOmpzRi1a+IktRpPuGPZKtyt8
         wF1ls8Ur5kGQCL9nTwHb+CLb3ycbpk1KRGreEIwnrqXE2rbeR9AvALROEjJe9iNhurfP
         anG8e4L4+6jQeUoy89EmKmUwxJZIvZl+gU2Bz5/5y2MR+M5BF9RHIBDZlv4iPoJC5F3/
         huM7Cg/IoyhcptOtKYDlgKmCFihOcQI5a241UVhRLecV4gjuXSLqQ9mt1XT1zdGF6VjX
         B88A==
X-Gm-Message-State: AOAM531CNWShq+qm5a7EKSKQJU7/dEirtAEGES78904l2I84NI2oOO2n
        pWMfboPA+uvGDE/9/x6oADA=
X-Google-Smtp-Source: ABdhPJwT2URi4HsjvzRTntPga9A2si8eynUKYP/N7oLkDB46aDONq5cvOnEaANh0LKLp2fVa+e9wIA==
X-Received: by 2002:a05:6402:5cb:b0:415:e04a:5230 with SMTP id n11-20020a05640205cb00b00415e04a5230mr3268610edx.352.1646324397972;
        Thu, 03 Mar 2022 08:19:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lk10-20020a170906cb0a00b006da92317793sm744083ejb.131.2022.03.03.08.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:19:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPoBJ-000dO3-0Q;
        Thu, 03 Mar 2022 17:19:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/14] index-pack: fix memory leaks
Date:   Thu, 03 Mar 2022 17:19:01 +0100
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
 <patch-01.14-bcba06e1d28-20220302T170718Z-avarab@gmail.com>
 <e3ad8853-a33d-a70b-4ace-92873c9d1401@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <e3ad8853-a33d-a70b-4ace-92873c9d1401@github.com>
Message-ID: <220303.86r17j2ekz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 02 2022, Derrick Stolee wrote:

> On 3/2/2022 12:10 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Fix various memory leaks in "git index-pack", due to how tightly
>> coupled this command is with the revision walking this doesn't make
>> any new tests pass, but e.g. this now passes, and had several failures b=
efore:
>>=20
>>     ./t5300-pack-object.sh --run=3D1-2,4,6-27,30-42
>
> Do you mean that these tests now pass under leak check?

Yes, i.e. test 3, 5 etc. fails before & after, and this change makes
tests in these ranges pass.

>> it is a bit odd that we'll free "opts.anomaly", since the "opts" is a
>
> s/it/It/

Thanks, will fix!

>> "struct pack_idx_option" declared in pack.h. In pack-write.c there's a
>> reset_pack_idx_option(), but it only wipes the contents, but doesn't
>> free() anything.
>>=20
>> Doing this here in cmd_index_pack() is correct because while the
>> struct is declared in pack.h, this code in builtin/index-pack.c (in
>> read_v2_anomalous_offsets()) is what allocates the "opts.anomaly", so
>> we should also free it here.
>
> Makes sense. Code diff looks good.

Thanks!
