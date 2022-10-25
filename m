Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BBDC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 18:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiJYSDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 14:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiJYSDP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 14:03:15 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D425E6
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 11:03:13 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id n9-20020a17090a2bc900b0021010dca313so4723577pje.7
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OWKMnCFHbZz0SQ1M2hFhbSTHWCrfbI7HWg0WMs+/LJ0=;
        b=Q9QfX82BeDlKTQLg2GURa4JX5dpntKTCZAtuLx6SJFjbVU551Jy+FEXZ+rWaH5Emno
         dujbEX1Lvjn84btKsgJMmD/iCNCfrKREl+vxLpHHYAYVQa/5JfQygWdV2KLnCM4Dt1nZ
         uWtk15din7tZP97dhkoaFD3lF1LecB4OS8i4QI3nlu5awyqmWRRMGSU4zb8fXchPUBJc
         YugHD6BmS1mf31ZjCqFzsQl47qgmhK/Nx1FqX37sImi4dmi7lgwIgIFkYEGNJc+JAmLM
         lLNfJFA9Tv2NuxJFqkH7wVoCFn5yakbPd4J8Ty7dK3hciIOhZY/TToz1jIBU7QKpSg/s
         03BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWKMnCFHbZz0SQ1M2hFhbSTHWCrfbI7HWg0WMs+/LJ0=;
        b=HlOx24ESsSR/lYPaWVtvaduUmgGn+5Pu4JYk+u75iXFOIXryfkNRCf/n8hC1izEzgP
         5k2XR1k6A9Y/E5vCKo8i4zVY71ld4xvqQG1PwcGPwxLH0rTUdrOXzoK1DjXgIX0OC7CM
         i2MqOX35ULgyrS+EWYZ+pZczjkfNAblAeRXttEe9YgB2nrZVj+O2pMsbeo3f8Ki8LZ6s
         WB5f06rPq2LnEP/88+ZvI3gtoeY1n4btU6E1OiCVyYfO6lEkPgHmkr5SzJflATTB9hj0
         1sMLsNvmpSl4jJ7qXgewVBbkfPmsLbZcwOZqtyso5Ij6sOM/9OV3zizJtv699vckENBW
         GjNQ==
X-Gm-Message-State: ACrzQf1xlulSl176C+aZqlKZ+FIxZ4SE8Q1u85/iJSszmsDZZMM4DL0x
        O1sypglVcfzPt4NOAADTjySiW+h1ShunLc/iyHMi
X-Google-Smtp-Source: AMsMyM6RG01YYbnt+na9uGYmXZFuA3IPix+iZX2RrUlv4GI2KeuXxIAtcNBmle2prlQgDCwDN7YwOS5Wl1qHm4yDOKeT
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:e5c1:b0:186:897f:b8ee with
 SMTP id u1-20020a170902e5c100b00186897fb8eemr6691plf.151.1666720993337; Tue,
 25 Oct 2022 11:03:13 -0700 (PDT)
Date:   Tue, 25 Oct 2022 11:03:10 -0700
In-Reply-To: <20499c62065d640b57bdcfd959e10b214f7e7297.1666297239.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221025180311.978182-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 2/7] repo-settings: add submodule_propagate_branches
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> +	/*
> +	 * If the environment variable is set, assume that it came from the
> +	 * superproject and ignore the config.
> +	 */

Might be clearer to say:

  If the environment variable is set, assume that it was set by an 
  invocation of git running in a superproject with 
  submodule.propagateBranches set and that is recursing into this repo as 
  a submodule. Therefore, we should ignore whatever is set in this  
  repo's config. 
