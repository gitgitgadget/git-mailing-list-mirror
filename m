Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A2BC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B2360FA0
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbhH3VbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbhH3Va7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:30:59 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4311BC061760
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:30:05 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id s16so17842550ilo.9
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QhDg/pOMA/0CbsY0QOVuUSe5PIiOaSsF3nu8zfv2gxA=;
        b=oTDyTB7NTqcuZYAzirsSwsWJEyQ8CqFTkyPO5i6KrUxHjxCPogS6MjFjS76iE5Loaz
         bL94NaUZuMcCYkEsnGUYzAPx4A+QiIHAYtBN8pzQtWbHEVcK0inGJxQxieyBOL/hzRh0
         wIhOpOserPFWmKjuKJ6x3d3TYQIb9XflPCYHuXMeBkivbkOxxN7ReY5SINk1tBcXaLhA
         DJYU1jXohNH/cZxj2fiU2Q8nUyRkmKt+pd5H3Az0lRG5a5QvhKYWaVoBldGw8MYfCfcS
         MqpcQhig2DTUm2QSX2oNaCCsDUKsJ10inzhu9bMTcC4yrdsG9gy3Vwv/csipRAqqlnvZ
         Dxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QhDg/pOMA/0CbsY0QOVuUSe5PIiOaSsF3nu8zfv2gxA=;
        b=OFJIOmd8DR+nlWJtZksptnr58zu2WB5PJq2f4zugAQ6g2YtgIbvxHAqF33ZPCNBvyq
         VOZ0u0NjmRoywm6ifDUhQblEvLZsRbdoikprQYjFHyuh/2V0b8F1JJetynHANVovLap5
         SFCXi4E9BkXrhjqO8Z1oj9VrnFbw6vp+cL1T7IRBrV0lO3iIw6voxAadCiCZ89jyT/lW
         E79ew2WlRrsMvZHmmaEAgKonAYFZSmrPJgbW3j7XNSpwofc4ZplFBhO9DRzUBqmIwhwf
         aOeYVybnXqKLMLej5tjscWMTS/vONno6a1YTtJOD2Ub0piApD0ie3WLk/YmjkGUlf82n
         DX9A==
X-Gm-Message-State: AOAM533cpscmO2iu6PBbPArnDkwcVYqIGyO8qN2t1uCX488grMzWX+Ak
        /5Od5wRm7sTQxREMbGq3I63r82353HbZBtnf
X-Google-Smtp-Source: ABdhPJyR5WmaKVR/TLedt0O07g5h/ZrHlreaUH3gn+OuKq4ot4+rtXK35LTtYrKKAVl7rNtJ/oaq3w==
X-Received: by 2002:a92:c6d1:: with SMTP id v17mr18209729ilm.302.1630359004649;
        Mon, 30 Aug 2021 14:30:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a4sm8710312ioe.19.2021.08.30.14.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:30:04 -0700 (PDT)
Date:   Mon, 30 Aug 2021 17:30:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] pack-objects: simplify
 add_objects_in_unpacked_packs()
Message-ID: <YS1N2moWMnd5nq83@nand.local>
References: <cover.1630291682.git.me@ttaylorr.com>
 <YS1GemF3aKTe//Tn@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS1GemF3aKTe//Tn@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 04:58:34PM -0400, Jeff King wrote:
> Those unknown objects cost 72 bytes of heap each (the same size as a
> commit, since it's the biggest struct and the unknown object is a
> union). We've seen some real-world cases where there are 40M+
> unreachable objects. So that's almost 3GB of wasted RAM during
> pack-objects just to store those "did I see it already" bits. :)

I wondered if you could see the drop-off represented in GitHub's overall
"total heap allocated by Git" metrics, but they get drowned out in the
noise of other processes we're running.

But not wasting memory there is obviously good, even if it isn't
noticeable in the overall metrics.

Thanks,
Taylor
