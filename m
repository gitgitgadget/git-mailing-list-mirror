Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025C9C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 22:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbiC2Wwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbiC2Wwy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 18:52:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0ECA0BF3
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 15:51:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so172073pjo.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 15:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IrjuCuCa64uewGHszZ8Ym/I1/dJIYPnLavmfoDUZBdk=;
        b=A4QPuUz0S+DFNXu9vmH2i5wAd39WvO8FZ+ajtdsN1vYy3xqn+0vc8lCk0JOxSCe60n
         nri+oHT7L8pm1FiwWge3AvpKLiZqLz2TzaeOcoiIdAkxlg/fdhzK7j0LtXOmpjKF+yoV
         otup/hV0yJJlz8lb0pRKkM4SobucfPdWszWMq4Lfa9DJRLtGjYSKaJX+Aj8ZTelmpjm4
         VeFj1b3Tk01XzHvjXff+jMAEU1P3Vkh34EA0Og9wUvJ4h5LBcdncG8ZOVq7x9wveDQYg
         aYjQQMuaHjZEdsgLJuFJpXOejuxxN+Ktd9ujtt/Ad3xxZ/SpWKrkH273mCqXVEWaTU2B
         PBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IrjuCuCa64uewGHszZ8Ym/I1/dJIYPnLavmfoDUZBdk=;
        b=RKLKgwf1vAB01p1bNWoPmaEcTY3kT1sbEiDE7Q/bVLIBpEQ7rRo9IUjBYh975pwkqc
         zqWAkZqVkOqqAXmCnl6UZUXUIJYwBOycDNBMJt+Kp+bo+IRBCWcftQ3QdjL8CS4wHoER
         U75vWxQDDbeaKWhuFQ08G36xwdGMpKt5tcZ9IAIFuxhJGuCEITqSaH6tQlmqm+5tDOUW
         9mAa2o30vw1Fm/dmyGbSBomsjEyT3oLRCSF/SY92EcLjTN4I2lAkr84RS/0bRcKTekFj
         SI0KM6PJiLiT0/GdNufsdHnd/2uCqsFF1dso10uz+8gxzfSYJlQpEEXLEC2Ah07O5SAV
         HNpQ==
X-Gm-Message-State: AOAM532FEgHTVdE8TMLwFTl4CCOFnxMrCBHsdSx77CSan72ow8AYjFSp
        GUUsVPiifj20o1E1T1mSEOyiES4Ei7sxHQ==
X-Google-Smtp-Source: ABdhPJz+A+MJ5wtrusQ6nEbsiKK4DzqXur41omrMic3ldfF9RfMoe4TarpEO5fl4iIBCDRIVMRZgXQ==
X-Received: by 2002:a17:902:bd47:b0:154:abdd:929c with SMTP id b7-20020a170902bd4700b00154abdd929cmr32836393plx.63.1648594269893;
        Tue, 29 Mar 2022 15:51:09 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090a4f0b00b001c6e4898a36sm3925645pjh.28.2022.03.29.15.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 15:51:09 -0700 (PDT)
Date:   Tue, 29 Mar 2022 15:51:06 -0700
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2022, #06; Mon, 28)
Message-ID: <20220329225106.GA12169@neerajsi-x1.localdomain>
References: <xmqqo81pxzt4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo81pxzt4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 28, 2022 at 07:22:47PM -0700, Junio C Hamano wrote:
> 
> * ns/core-fsyncmethod (2022-03-15) 6 commits
>   (merged to 'next' on 2022-03-17 at c8a52f8cbe)
>  + core.fsync: documentation and user-friendly aggregate options
>  + core.fsync: new option to harden the index
>  + core.fsync: add configuration parsing
>  + core.fsync: introduce granular fsync control infrastructure
>  + core.fsyncmethod: add writeout-only mode
>  + wrapper: make inclusion of Windows csprng header tightly scoped
>  (this branch is used by ns/batch-fsync and ps/fsync-refs.)
> 
>  Replace core.fsyncObjectFiles with two new configuration variables,
>  core.fsync and core.fsyncMethod.
>  source: <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
> 

There's a fix for this series at:
https://lore.kernel.org/git/pull.1191.git.1648590113062.gitgitgadget@gmail.com/
<pull.1191.git.1648590113062.gitgitgadget@gmail.com>

The net effect of the bug being fixed is that anyone using the default
core.fsync config is syncing everything except loose objects.

Apologies for the bug. I noticed it when revising the perf tests and
debugging the number of fsyncs. I'm submitting a separate patch to
log fsync info through trace2.

Thanks,
Neeraj
