Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97596C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 19:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E684611C1
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 19:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbhJFT2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 15:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhJFT2X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 15:28:23 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D005C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 12:26:30 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id t11so3944346ilf.11
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 12:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NvhRRYZDgg8ueNb0SAGTjXyPXTCHI/8ujEF6fzWRJ/8=;
        b=cK2qtd22wUIqMiWX/DfmXh3gXisiEdRbuFNbZy+kGfXKqCSBq2zss8g0m6awSz0SZN
         trRFMM0myBTnqOC4JAIDwRxe2y2eXCXptBBy20iGWalWeZ1Sn+j0/dVDx+LZjTDn7597
         ZaewuVO8SX592loyOtYS5IV26QRWNyHIbkJXcf4KrLKFOdiEUKAzd0XdRh9FXruuOgbJ
         5y/rO8+5nW1Qi7bFxTopJBKfKSB23xVNaOMYLWZUDbuHJI5KDcYmLTokNhJr+l1KAQhy
         cfBABh2HZuhapBtuL2Cb82MYE1gxp41/aBnXcJtQiJH6UCDFnm2mu5N3rXmQ4oUp4Oln
         17Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NvhRRYZDgg8ueNb0SAGTjXyPXTCHI/8ujEF6fzWRJ/8=;
        b=n4orWWPfrU9OLb+wm/bzU7MR5mdlGzESbxFNbqf8RyrYZvFBlm/0ZMZEFvgYZfSy0z
         z4W0BFs+1QQXgZdn8MXlOsArtnZuicZ6nzT4PLZBYzagRYR/1QDPR+/FLoziewVq0XOP
         7Ze6SK0JfnGOGmljdchOUEbWpxlzE+x/XPwMfWevZnPVg+yORWf0QNNwJH/3SspX5g8y
         +iY/ELPpinrIHxxnsTdgt1kAomdxZRFq27fWVDjLdoupOcC/yw90yT1rG38B92+YeabN
         WsThe6udwrEdpWqUnVNrgrGndWfnzEWyySZzhQGqYIQBjQooCy0ytmUn/hDZ+l6uZmCg
         iDTg==
X-Gm-Message-State: AOAM532xcQPuf5I2WHKv4BIjyR4scmB/kjSXQOt6FL2O2F2Nns0I/8Y8
        G8/0/eGVsrUD36Dkss6r6mjuuA==
X-Google-Smtp-Source: ABdhPJwVuFlrw+rJfw3E6a6d/4sUd3OYApC6oMq/W+2lE7AITwYQ9OmaZZ7v65ppSdUiJj2mySSQfA==
X-Received: by 2002:a05:6e02:1cab:: with SMTP id x11mr9139172ill.254.1633548390021;
        Wed, 06 Oct 2021 12:26:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a4sm10792259ild.52.2021.10.06.12.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:26:29 -0700 (PDT)
Date:   Wed, 6 Oct 2021 15:26:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] t/perf/perf-lib.sh: remove test_times.* at the end
 test_perf_()
Message-ID: <YV34ZJXqF6KtpNM1@nand.local>
References: <pull.1051.git.1633386543759.gitgitgadget@gmail.com>
 <YVyPH59LpxFLHep0@nand.local>
 <YV3314Dnhj7srFZ4@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YV3314Dnhj7srFZ4@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 06, 2021 at 03:24:07PM -0400, Jeff King wrote:
> All that said, I do think cleaning up the test_time files after each
> test_perf is a good precuation, even if I don't think it's a good idea
> in general to flip the REPEAT_COUNT variable in the middle of a test.

Thanks for putting it so concisely, I couldn't agree more.

Thanks,
Taylor
