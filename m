Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0613C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiCAJja (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiCAJj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:39:29 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86091C116
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:38:48 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p14so30195656ejf.11
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 01:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SYgEDxWkG50P+htkNSGwblosRXmkCX1CTW5YRNWy7xw=;
        b=lXKHL92TVUbiw5XykDz+5m6di37TpnAGwcy9w/Bukq3eyt/nWk8i1sIcbxr1nHBk60
         4mEScxNo1QXbGpNcB+Wm0jUG/8v5NrfesSqQn9udU1rvA294uIkJYVGwYSdiJjc9MMT9
         2e08+38U2DU4EHBOF9JRRmEWWS+YuVqqeEKKDwZbJ6MLkToLWtn0DYXS4imoujnQaFFH
         5xF4lQsqEacybyEhsv4i78260TqgaibzLoyV80PBjrTfxOs2ovfyjO7lrMXM5jHDUHND
         K/eeunrYnvsDVSEY4XyPJgs4QWgzpQ5iuS/twyaOpzqh1qgUS4VDiokKC9W523edc2jj
         N3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SYgEDxWkG50P+htkNSGwblosRXmkCX1CTW5YRNWy7xw=;
        b=Zp+2qP/aGnVX4a/ErUNAJ5tv7izeZ6xneSfa134rFaa0DijHWSf6O5Gx0T7T9wMhnD
         rc7s3hcQR3MWwKt6Ux0/lGOCjaoSs/8YeR36xtJW/KoCy9CyqFjsoeGjhhSicnwkO6cM
         XMNVDaZtlxYWl6Vj8MsEsMOXRsZBA5rMjns2VlgpHO0BDTu+YL5O7PE5gKzSmKgXIzXp
         85fMC1VIayFNCu4XdCcfcijt/Ds5sBy3xbXSeR04P9V34uf+gA3nPrxdB3xXbmfi9ory
         AB9Lx/JfeKaJCfgi2KKNwREw6dnpf/RW4GT7ugVaZvhQ/UzmPCAR8nrG1ehtIcK4mVww
         C+vA==
X-Gm-Message-State: AOAM533l3iAWOKABs127NgtuXM6lkK2wMpWgaVX6815H/bUDGkJJArcX
        Jd9TP58rPfj68wa6ED4XcxU1NhDaFLM=
X-Google-Smtp-Source: ABdhPJygFT7KgqshjWHYa4TZb0Z4O6Hr5HgfCuue0fQSTu7j//2k/X4KNCEZ4H90iti0nY9r5KC7Rw==
X-Received: by 2002:a17:906:538f:b0:6ce:98ad:3100 with SMTP id g15-20020a170906538f00b006ce98ad3100mr18657944ejo.566.1646127527152;
        Tue, 01 Mar 2022 01:38:47 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gg38-20020a17090689a600b006ba4896f2d7sm5168948ejc.140.2022.03.01.01.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 01:38:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOyxy-00200D-0c;
        Tue, 01 Mar 2022 10:38:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] userdiff: Add diff driver for Kotlin lang and tests
Date:   Tue, 01 Mar 2022 10:37:21 +0100
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220301070226.2477769-2-jaydeepjd.8914@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220301070226.2477769-2-jaydeepjd.8914@gmail.com>
Message-ID: <220301.867d9e107u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Jaydeep P Das wrote:

> The xfuncname pattern finds func/class declarations
> in diffs to display as a hunk header.
>
> This patch adds xfuncname regex and some respective
> tests for Kotlin language.
>
> Also modifies `Documentation./gitattributes.txt` to state
> the same.
>
> Signed-off-by: Jaydeep P Das <jaydeepjd.8914@gmail.com>
> ---
>  Documentation/gitattributes.txt | 2 ++
>  t/t4018/kotlin-class            | 5 +++++
>  t/t4018/kotlin-enum-class       | 5 +++++
>  t/t4018/kotlin-fun              | 5 +++++
>  t/t4018/kotlin-inheritace-class | 5 +++++
>  t/t4018/kotlin-inline-class     | 5 +++++
>  t/t4018/kotlin-interface        | 5 +++++
>  t/t4018/kotlin-nested-fun       | 9 +++++++++
>  t/t4018/kotlin-public-class     | 5 +++++
>  t/t4018/kotlin-sealed-class     | 5 +++++
>  userdiff.c                      | 8 ++++++++

I didn't look at the regexes etc. at a glance, but this is missing the
corresponding tests for the word-diff part of the regexes. It would be
nice to have those tests too.

See the t/t4034/ directory for that (and no, this whole setup isn't very
discoverable, sorry!).
