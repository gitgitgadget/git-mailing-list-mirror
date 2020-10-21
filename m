Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F382C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 23:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A375F22249
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 23:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8AH9AeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507063AbgJUXPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 19:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507060AbgJUXPO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 19:15:14 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D111C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 16:15:14 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u17so3964373oie.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Yc4LMiMJ3AjUVsjMF+03GPCzOFGeXAye+LojWFKnWo=;
        b=u8AH9AeJm/g2Lh1oD7EFoAnzVvQpvxw1Gk1hhVXPIqJ3SRoccUNNeedblt1aRJNdNh
         IEN9NlU3G1VBU6idMMFX6lUYwB094mFzXd8b4yjeenWhaT+lnVgvl5a5q1qZTTRjidZU
         J+Kzv9BhH58viPYFaF0eUp4bcSmTAFKUQWJi6urQLC9M6Z1znnYoh69QU9R+Ql9WjgUH
         ROndLVNorw5xmFJZnBqF5q+wdRuGc21Nqomtw5EKyK6rVI3RODVtGau/YYc6TXCFaLS+
         3TdCo7skWfek8Z2icJ/l7vQjMuylKcXJC7IDDyk2ex0FnyQC7e6d6AgM8jMze90pPi22
         rvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Yc4LMiMJ3AjUVsjMF+03GPCzOFGeXAye+LojWFKnWo=;
        b=ncjQg3TACTYLssgDIrjjONuBdqDoIMUMrZQuVz2oSx/PYldEt4Nf5NE/dVgey/Cp1k
         Tiju2fMxyDc7rcC6SH8vT+5s/EPNhFmaMFlRb9wx5mtHOY/fe2R/+bzHSye0qWa9WExM
         rMGG8Tt4QQqFhNFZtiG6B8TLGcjuWFLx5tlcb+q1jatqf1Nf8FbCwnMR5mpTKHMLREMm
         C0q5r9vjTGdXIr+CdO6KLhi/MGDsHp8O+EPW1LCeThmNwpAIOZMsJtkk9eTiCqg50bmm
         uAyZZNvwPHLJAQ/LkJD6f7p2Z9I46Z7VAkIE6pT6N9bZ7B133aAomnRKoYd2Yk8hoSow
         DFNg==
X-Gm-Message-State: AOAM532Ha8GcXnoeeIeQRULYJKj5rtz31gG/HpGEVvIl32UG6CygLgAE
        pwSfXqyizAcNmJht7lgEb5DdNjtnSySv2PMjPIN+E4aIbs9Cnw==
X-Google-Smtp-Source: ABdhPJzkk82PDMKSi3crj3RHzjbk3Mal1F74gDtfOH1aWgHxGeHamu6hl6dJbwAaU7ZMKdhxKc2CeYw50bK7J1Va0Bw=
X-Received: by 2002:aca:ec0d:: with SMTP id k13mr3798688oih.93.1603322113836;
 Wed, 21 Oct 2020 16:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.767.git.1603303474.gitgitgadget@gmail.com> <20201021205208.GA1270359@nand.local>
In-Reply-To: <20201021205208.GA1270359@nand.local>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Thu, 22 Oct 2020 00:15:02 +0100
Message-ID: <CAN8Z4-WxLcBzxrRsj4sRmMAKRZyLXpMA82r0Ce7RUiegtHWQ3Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] fsmonitor inline / testing cleanup
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'm fine with both of these patches, but it may help to have a bit
> more information about how they will be used. Presumably more patches
> are coming that make use of the new public functions, but it'd be good
> to know a little bit of why these changes are necessary.

I believe the externs are just there to avoid pulling in `dir.h` from
the include file - since
it's only needed in the implementation. I believe at the time
(12/2017) `dir.h` was not imported from
`fsmonitor.h`, but it does appear imported now. I've eliminated the
import of `dir.h` as it
no longer appears necessary - which I will include in the next
iteration of this diff.

The test helper merely makes it easier to debug fsmonitor tests - will
be useful to any
developer working on fsmonitor related changes. I have an upcoming one
related to
fsmonitor in git checkout, which I've also revived, but I'm not 100%
sure I'll get it through,
but regardless, I believe this test-debugging change will be good.

--Nipunn
