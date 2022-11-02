Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC59C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 08:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiKBIYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 04:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKBIYg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 04:24:36 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD9422501
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 01:24:31 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id l127so14416123iof.12
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 01:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Yhch1ACVsEVOLr0R2mtR2AjQ4GpydRaGEPzjhRZGZ8=;
        b=IDHks3Z0K7qEHHVrc7kq06G6ca8fK37JsNbmUHz6IcjIV/UqtguDCYyB1CGjWsNpKu
         ouroTg45CbkjK8Sr8oHJ1VD4lGeHRNsA2tOILotDNeg4kj/LsUYqZl8FNwO1mdLYVoEz
         feFUXPQjXUw1qy4cbZP+9Vad0xqjBlq8+J3g9ekG2Ief5YXiEP+XGiY4rvYkFRWw+Uj6
         wFI4IheezW6ZEmwOUo2VNiPLydtrh3m4CPwR9o3fZq2CjG/LMcMWg5tt0zqo75n9oNgv
         JM5I61E3iUg6mNe11v4QkkSXhlpb7+BAClsP3fNlXK65E9auAQWrTv4znEAc8dX2+WVQ
         g5SQ==
X-Gm-Message-State: ACrzQf0zR5sDvlCd8u6VGj6RuFKM7CFaRfPPqLyueKWHwie1zzsECno6
        zRqokiyk4mHMV6+J8ab6ZD+UQxnh86r5HFfApuzVq9Go
X-Google-Smtp-Source: AMsMyM4FAlUiA9IWygFXToJZ1YXSPiMzD26HPe4bwmaHBMHAzJyuD4kMbmaIXKo6WdePAlSlKdgII1C+n+hXIA4lcTA=
X-Received: by 2002:a05:6638:134f:b0:372:8558:1e34 with SMTP id
 u15-20020a056638134f00b0037285581e34mr14186802jad.285.1667377471109; Wed, 02
 Nov 2022 01:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <CABYbkvP=fMmaFUD3bQbeQ-XKiMSP6g-u0p7Vq1Qt_K5=D5WJ+A@mail.gmail.com>
 <Y2EPgICMsmzKvCC8@coredump.intra.peff.net> <38d50c30-c6a3-5989-6e01-47c5467d9d6b@gmail.com>
 <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
In-Reply-To: <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 Nov 2022 04:24:20 -0400
Message-ID: <CAPig+cRkHyjoBNEbuUB9+MXnGMRD3W_ynpX4Gco16Y5dVJN=eg@mail.gmail.com>
Subject: Re: Git Bug Report: out of memory using git tag
To:     Jeff King <peff@peff.net>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Martin Englund <martin@englund.nu>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 2, 2022 at 3:44 AM Jeff King <peff@peff.net> wrote:
> After sleeping on it, I think I fully understand what's going on. There
> are actually _two_ bugs, but they are closely related. ;)
>
> Here are patches which fix them both. I may be setting a new record for
> the ratio of commit message lines to changed code. But it took me a
> while to figure out what was going on, so I wanted to explain it fully.

Well explained. For someone who has (probably) never looked at that
code (me), the explanations made perfect sense.

(Oh, and I didn't even have to report any s///.)
