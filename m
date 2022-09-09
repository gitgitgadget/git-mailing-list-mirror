Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB33ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 14:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiIIOUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 10:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiIIOUm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 10:20:42 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93D386FE3
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 07:20:40 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h22so1378196qtu.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=nguzpg1EW6utzC3o3u45YW7ZJ+Bh5YQtQhiZgqBmsHE=;
        b=aR+Q5DcbfNpTdGi/rbm4zS8Urnh0gyTiRJ1xivK1RzXn1Nrpvi0lPTE8wwyV7SOtG4
         V4ygSNJhQQk+Ig3lC1HhT4OzeIBMHJPCtq/6YL6gry8eXK7LT4RHEkdyE5+VcxRK/Njn
         XdXe/QAmIan5tcr7j0TS8Sq3c0cdH7GOGvhKnahHrRoJbnKz2mP7DlREKKIGsLO5HuBO
         I4IFzmmCDN6SzqlNaugR5e/nyB9JFlbu1VBRmiEy7cKzMfkXipUB+dOJZRvWyc8dQRpy
         8nPapTsuJydA6v3nzAUqJLSgx8hbSNoLSnNfr/r7Om2ZX9McXMf4AuUlxbJ+IVyXqUbW
         H1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nguzpg1EW6utzC3o3u45YW7ZJ+Bh5YQtQhiZgqBmsHE=;
        b=uU9c91dHO4BWI0Sv8vuWVlXO4G6ns5UaXg+tgnujCV6h8Hk/opLnk/TA1nTyB9dqs7
         SFJ8MRI33/+mhK6JsegoKXZS3RsgTY+On1N14ZXT9ZuH/H0podGQ2Q+nfgWuViRPjg+u
         m6IGwAL0aHyJoCV416ont3BGULUWHslStkpOOLHKkejymLg6cAp+h3I2QsBG+/nConX1
         LR0uH8fnsWawob4czh+3GdsV4WKMAV0muvcRBy9nQnUfxa8gGBsB4RLfXSZA5sq643Va
         UeJhiudjlPykWs7WVJEHtMVov7Rbk4/noXWK01fz9WHW8KhFwZbwhpXFf1IFlXE6y/nX
         6erg==
X-Gm-Message-State: ACgBeo0St+CTZYcpl2jR2+0fqpx1+ysYWcH5+fX4ewQ6LJaIE/lD+aHU
        lPbMA1NfsTxwJ5Bzg1bjozwLZ8z+X7ce
X-Google-Smtp-Source: AA6agR50oA4Meo4ZFjle3rpbdUZs9bwQtvisUgmi3QIX0WillwEN1hS/pIngv3yvg2Vm0drBlkl6Ow==
X-Received: by 2002:ac8:5b05:0:b0:343:3ce4:c34c with SMTP id m5-20020ac85b05000000b003433ce4c34cmr13067618qtw.233.1662733239775;
        Fri, 09 Sep 2022 07:20:39 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f11-20020a05620a280b00b006bb7ccf6855sm556327qkp.76.2022.09.09.07.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 07:20:39 -0700 (PDT)
Message-ID: <15688f6a-4757-e201-9106-663899e35fec@github.com>
Date:   Fri, 9 Sep 2022 10:20:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/5] plugging some list-objects-filter leaks
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/2022 12:52 AM, Jeff King wrote:
> The test I sent earlier in [1] fails the linux-leaks CI job, not because
> it introduces new leaks, but just because it runs existing leaks in a
> test marked as passing-leaks.
> 
> Of course we can drop the passing flag, but I figured it would probably
> be an easy fix. Famous last words. It turned into quite a rabbit hole of
> actual leaks (albeit small and bounded per process) and some
> questionable memory ownership semantics.

Reading the patches, you make good arguments about the various trade-
offs in these sticky places. I agree with you in all cases, mostly
because the alternatives would not be any better unless we did a _lot_
of work to rewrite a lot more code than these patches. Even then, the
benefit is unclear.

> Here's the series I came up with. I'm cc-ing Stolee as the last person
> unfortunate enough to have touched this area. :)

Lucky me!

These patches look good. Thanks!

-Stolee
