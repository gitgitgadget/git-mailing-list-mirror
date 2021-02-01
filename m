Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873C4C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450BD64EA9
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhBARJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhBARJY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 12:09:24 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFC9C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 09:08:44 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c1so12796768qtc.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 09:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rJpXme6dbF1oebneAV0T9JF9OpnCzYrxjx7yOlDTQzg=;
        b=n1gP/tSFBGN0YGuUfkZttIwVc7ejkD0c6B/GBsGvIz+AFoii2/9+P04NB+O1fFW7B/
         ajD7ImlG7iu/KAQ1MEN/VV4hPDw+Jb+0DXUGZ3784XQ97RK32XsQxeA8UG7HwHTL9BXf
         sqsXjnc7O6kInN4ETGMvC73Iyj2ZMpGYIPWH8hU/kwwwCPK50ozqzufzEx48CTnYl5st
         0Ysy19FRnDQd4bDxcb+00xovBHDrgmGgNc5Ny1HOOz7zbL70mwSXNdu1Jld4aJXgaysS
         KC/o+FX4iRZA269lUYA1P2D+uqXI/bIcLZSbqZdKzDZjAGcgPtRd+PXU3xmmXaYsdtqv
         RiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rJpXme6dbF1oebneAV0T9JF9OpnCzYrxjx7yOlDTQzg=;
        b=gacKuZJt8r1nzb2UGVq8FK1ccxGxsU3VRMw9A+72OXmOdDRnr429L6dRhoYZx75P6w
         m4+Xjo+ZlWX5m0ZD5iFRs3Qf0mOPNbKH3GEvs2g+wyMdLsaEzjbInHQHZKaQlISLP0EY
         Z9yvlhnU/vAa//UIMYkKHH1DknTSWhehc83HT2+Jl4d4TzvKL+Uzg2HXjhuHP83inI6y
         BwTwT31Hd2+/KUcrfw68TWGiFsDwjF2vugGarG/ICD9TekjN5/HfbuJwGCh3eEMdA1Ls
         6Crc5Q7ZHWkq8E1eLG5lZ3uaSX7ScYTPsMVXT+r8KH0ClvEJpFuCYmFD8chzVCFd/BPY
         SEMQ==
X-Gm-Message-State: AOAM531UrT1YYSLWzjDVn8uM4ZW2PJA0DJqvMCOOaMXyY1DtBSO2Qf5L
        Xvvc4t3oaVP5yJHvkAV2766KqQ==
X-Google-Smtp-Source: ABdhPJzxt35isahrq/4S1dCI3aK6S/C+otMs9Xc2jF7yciPFPWrdw/n+gkWn9VEqaxCoYB/VfWJldA==
X-Received: by 2002:a05:622a:2d4:: with SMTP id a20mr15962542qtx.217.1612199323458;
        Mon, 01 Feb 2021 09:08:43 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:8bd2:a84b:ef4c:2356])
        by smtp.gmail.com with ESMTPSA id v18sm14991081qkv.62.2021.02.01.09.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 09:08:41 -0800 (PST)
Date:   Mon, 1 Feb 2021 12:08:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Terry Warren <trwarren@me.com>
Cc:     git@vger.kernel.org
Subject: Re: git config file
Message-ID: <YBg1lbg6koRG3aBA@nand.local>
References: <46D52CDE-15F2-4DA6-8E89-56E0EF86FFF4@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46D52CDE-15F2-4DA6-8E89-56E0EF86FFF4@me.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Terry,

On Mon, Feb 01, 2021 at 06:19:01AM -0800, Terry Warren wrote:
> can git environment variables (such as GIT_TRACE) be added to the git
> config file? The reason I am asking this question is that I am trying
> to troubleshoot a problem that only occurs when running git from
> within an IDE. Running from the command line shell works as expected.

There isn't a way to define the GIT_TRACE variable, nor is there a
general way to define arbitrary environment variables that should be set
at the beginning of every Git process.

You can use the new trace2 sub-system, which does have configuration
variables that you can hook into:

  https://git-scm.com/docs/git-config#Documentation/git-config.txt-trace2normalTarget

(beginning at the above link and continuing down). Alternatively, if
your IDE supports it, you could set an environment variable by setting
your git executable to be something like

  env GIT_TRACE=xyz /path/to/git


> thanks for any response
> Terry Warren

Thanks,
Taylor
