Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB850C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A1E611CA
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhEMKBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 06:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhEMKBB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 06:01:01 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E620EC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 02:59:51 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id x15so11106114oic.13
        for <git@vger.kernel.org>; Thu, 13 May 2021 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=nAlB6C1d8UVDfKhRLUrSk44AEtXGd3j5KMGBzAul0Ec=;
        b=QUjRZOZ5Ubza+UwSw0OOFfAxFT4KirhqItujHANGK49pvkPYeNpXUO51iPq/59zJnp
         ofylQuy1Dq6l4GuNXgYmI05/ic3oqTxE8ReWIHhHqQVKlfsMjLTjdMuH98P0S1qLN90j
         cX5KrVP1i0MVrcSpR1P9A5buP5cB1KKhoPmJKQ8DK/SLHLzli/GsUpFq3a7j9ZXPTVkS
         c8WfSE/6cQ53/EI3y61AO3q/Cdpxg1aRfuD230WMr5jWa2q8xH72lR+dsNB7c13hHwma
         Ekfg/vOuE80pAjA6LvwAN/csDfzpqkQJKF5UmuPpQqJVsEW6rljqJz+5dZH0Pe2m3TGa
         YKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=nAlB6C1d8UVDfKhRLUrSk44AEtXGd3j5KMGBzAul0Ec=;
        b=HWULLitH4Cn6w8PrIn4CjisrM+2vOxB7E3HxrYIokbuVkPKHDq9u4IgUlwaDpvFXc0
         zGwBhMKLMvVc7xvvicyLl2YpLiViPsFBz0h96XkVLaTkc1ytqkt/EgbgBHrQA5ap2ony
         iq9pP6NoB1fK0hLdvMYs0hWX2c/9pXfA7kjLCT78408r7cO5fRff7AGdiRMDbFAx7qkk
         RCBp9aAmXPvYCvmbnHJMbrRsmIdgc0jcBcVj6Yh4KP3+s5LeruA4ahiVvNZbDX9/LevL
         4ANrTkCRL5CMZYYfQq+hsnhel5DInKUxxoCSpuVWQriYHImpTeORANIegT1jDtjlf47I
         0G0w==
X-Gm-Message-State: AOAM531KU7uRcxMCt8zJgbdhMyw1n6zY0eQzC+ZeXWIG8Tuawte3jwks
        7jaiy+JRBYTFsNW+utwzglLjPxAd0CEeRQ==
X-Google-Smtp-Source: ABdhPJyeTaHc5EurLagLGfkjf85qJ/DCWWV3PGQzCvyQHKDeHCe8I/xMpLsGHzDhM7KMavZBroqCgQ==
X-Received: by 2002:aca:e141:: with SMTP id y62mr29741806oig.146.1620899991379;
        Thu, 13 May 2021 02:59:51 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a12sm548999oti.12.2021.05.13.02.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 02:59:50 -0700 (PDT)
Date:   Thu, 13 May 2021 04:59:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Robert Coup <robert.coup@koordinates.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Message-ID: <609cf89587279_1ec320836@natae.notmuch>
In-Reply-To: <20210513094818.GH8544@kitsune.suse.cz>
References: <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz>
 <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
 <20210512170153.GE8544@kitsune.suse.cz>
 <609c112066acd_71bd1208aa@natae.notmuch>
 <20210512180418.GF8544@kitsune.suse.cz>
 <609c2f98932f3_71bd120840@natae.notmuch>
 <20210513074622.GG8544@kitsune.suse.cz>
 <CAFLLRpJeU3BFKmsGgFoKQRLCw-uGRRH1Ob7PZBHUEQu_Pqshgw@mail.gmail.com>
 <20210513094818.GH8544@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> Yet Felipe insists that 'impact' is somehow generally bad word to use o=
r
> that it should be abolished solely because he finds it bad and nobody
> objected to the alternative wording.

That is most certainly not what I said.

-- =

Felipe Contreras=
