Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0175C63705
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 22:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiLGWkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGWkY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 17:40:24 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B7883240
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 14:40:23 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id x11so7664955ilo.13
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 14:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BuJcS99cuDtxi+P9lLHQT0oPWPXWodCCPVIW6iugAIg=;
        b=WNfsbebk7MdfSvsMvkQEKwr3hKUR92qwye96f3sgCufYSe2e+5UFLMxeW48SyqHy0C
         hWv8qdN3H9F3wgMInCjHnorSHVLSTv4AJ2wraBHPkm73yp1Wd7Kd5zOmzHBareTxW3ds
         tqZY/QMRpJwAuRTHMzLmrFGuM0ySg6vGju+AoAJKbQWjSFJ7Hl2G+jYtDBZ75OvoesvB
         A4NhNHcXqVUT2s7NxjYKm67k5NRIsfVspXIbVRsSRPaRvi2K9rJEwBCWP9e+qI/n/Lbw
         5323h61G3Ao8uoWHwCTX7XJfb8AnbKNf5z5Ooq8/Qvor6R4l2rYNBVJmTlsRQ7tPuSi9
         TK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuJcS99cuDtxi+P9lLHQT0oPWPXWodCCPVIW6iugAIg=;
        b=p+krrxvGtrwd91b2lgHMDzOzdidUZu7LeCkyyTqCImAWxnajL51jj41DuG+xoOg7TN
         LcV0pPIg9CW9a4nDAVqInTIBxskQ/GoBEkBYvL3h7SS4nG0N3nsVR2DaI6PLeo2s4uhf
         ZcPDVqtaytP2/sDivTAg3xVYxNQGVqi6/8uJWlNHdDSAlUn+OELkh4FoyiSlyX5mA8P3
         vydNLxVYFDAhHuiPyY+4MCjjQw/m5rkUcNBRxcU+0uvIZilA0/H19gm1nY7OZ0dO5YGp
         8qOrE4B6qkCT3NvfWlwKXNJQ7nbBHVDuL7NrI4BwVwzlPr2CjMrZB2Lmam4UkveuOKCk
         E0dQ==
X-Gm-Message-State: ANoB5plYtlH1mPdTp57C5Jmm63AprRetLSLlrvDatZzju9c+S3P7NcQj
        MXfiMfNaep5Y4QuQ49nnvKgjzBgjUOYrqAej
X-Google-Smtp-Source: AA0mqf42QjaQqMYU3BLqg6iTiW3xJu5655HVc5imeGKZRxcZtjZJ4iRVyY4jAcimqSxjEeB4b5etfA==
X-Received: by 2002:a92:ccc2:0:b0:302:f954:e7a with SMTP id u2-20020a92ccc2000000b00302f9540e7amr673801ilq.24.1670452822845;
        Wed, 07 Dec 2022 14:40:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q18-20020a920512000000b0030341bffab8sm240349ile.31.2022.12.07.14.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:40:22 -0800 (PST)
Date:   Wed, 7 Dec 2022 17:40:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Avoid using deprecated features in Git's GitHub
 workflows
Message-ID: <Y5EWUNbR1X+GrrNs@nand.local>
References: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2022 at 02:34:36PM +0000, Johannes Schindelin via GitGitGadget wrote:
> Johannes Schindelin (4):
>   ci: use a newer `github-script` version
>   ci: avoid deprecated `set-output` workflow command
>   ci: avoid using deprecated {up,down}load-artifacts Action
>   ci(l10n): avoid using the deprecated `set-output` workflow command

These all look reasonable to me, minus the first one which is already
on 'master' as-is (unless I am missing something, but see my reply to
that email).

Thanks,
Taylor
