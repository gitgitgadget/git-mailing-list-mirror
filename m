Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0D9C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 19:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25AAA610A8
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 19:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhFBTq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 15:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhFBTq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 15:46:59 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3239BC06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 12:45:15 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id e18so1947315qvm.10
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y0Bn4ZCVGkTukF54UhstNRaeZuM6K9rD+aR+GX/eUBk=;
        b=La/gU42U2ZUo+26QB5Xri7fOtIsFRO7Keo5cjlylVcFsveTOAgtv4DTfq2S3m4XI3i
         t5iPMI9/n+Id6MV/9xhBTrt3lhTOqFRf7qzQnQkiTgwbtf4s4cV3NBsRWKHRCRbD74P/
         WgWkQkV3Om2oQwU2816q4JQbhpA4mqHc9sd0HywBg+83Ir22XGlGSVP3E8X/vDLT+OFp
         5kUEo6LekO4I56zSN/n/He+TDlIh1wxf970kciEQD9q3LR79N7yz326Mu9ZDfARKK2Pz
         rCdgaVYG9KGi7lMUaJ4pGcEhLJQAf+PcsCqe754p48BlY6bzs6j6fql24gYcjbedTFPS
         Ui3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y0Bn4ZCVGkTukF54UhstNRaeZuM6K9rD+aR+GX/eUBk=;
        b=YoljR5gK7vBaBEdee62a/k8V9LWtiyy5CcARw+0nY9v4fR93ghVMqkK2YuQgBOBTVs
         uO7o4BtHqzzQc+r+are3pkCEtksbpydBVx9/sklS9dJZw1YfvcVYuFjSksa68XMsfdma
         /w7Lm0eemKHS6od8xqW4h6k1IV4XJjoxvDuOrD9t2oyQIS2HFxrarQihXZPPgL3WNykn
         YAEwI36MtKutewY5eR5Zzhm7ERGxP4nlTn3hlop/DOz/cqnhr3fRgCRWw1qHLj+6htOL
         DGxdsDLf6WhsB6NQF3xoLNb6haMqPSqbzs9SM3TLOHsykKOtgHtKAS/QTg3KORgSWW9q
         TVRg==
X-Gm-Message-State: AOAM533XoRMmTzhgdP7wyOksIjOUkIXkg4KUJp9OAMP+onrp3+8oMPmt
        wgwwIKP2q62NMdb3HYO4a5KvSg==
X-Google-Smtp-Source: ABdhPJyfEW6PPrTpJRH3Id0dO6gPK7r2B4nKGq5wqew9gKRLpl2c9+8dRvTlz34lM5YAEHhUOSxfGw==
X-Received: by 2002:ad4:5b81:: with SMTP id 1mr30604638qvp.12.1622663114387;
        Wed, 02 Jun 2021 12:45:14 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9178:81cf:a7f0:8e5d])
        by smtp.gmail.com with ESMTPSA id h8sm440254qtp.46.2021.06.02.12.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:45:13 -0700 (PDT)
Date:   Wed, 2 Jun 2021 15:45:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] Remove warning that repack only works on non-promisor
 packfiles
Message-ID: <YLffyI3rp9hSZZdy@nand.local>
References: <pull.968.git.1622634446643.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.968.git.1622634446643.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 11:47:26AM +0000, Tao Klerks via GitGitGadget wrote:
> From: Tao Klerks <tao@klerks.biz>
>
> The git-repack doc clearly states that it *does* operate on promisor
> packfiles (in a separate partition), with "-a" specified. Presumably
> the statements here are outdated, as they feature from the first doc
> in 2017 (and the repack support was added in 2018)

Yeah, this all originally comes from Jeff H.'s design document in
637fc4467e (partial-clone: design doc, 2017-12-14), but probably should
have been updated in 5d19e8138d (repack: repack promisor objects if -a
or -A is set, 2018-08-08).

This looks good to me, but I'll add Jonathan Tan to the CC list to
double check.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
