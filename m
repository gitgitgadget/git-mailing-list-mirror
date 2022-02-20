Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D3AC433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 21:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239862AbiBTWAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 17:00:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiBTWAD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 17:00:03 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448162714B
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 13:59:42 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id c23so9190630ioi.4
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 13:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zk3T9LnUWwO5YeJx4V9p68YCX/skS/x+rKrbdF1YJps=;
        b=nt9B9d/q09C+cgRhu0n8TPLLoJSduH3Km7YH1UcWAW+y+ddwppkfTlhCqmI9A23Ik8
         AWvH5w3HgRH12S0a5Fl3VbAf5RdjjF10Ekq2Q8hZmcrVZa96WdcBqLONjCFPb1lAjAAV
         83IAYul34qGV0zyY9dDpJ69cxatSZYtxsggJ6SRSBI11x6WEnaFsv2OGgFXD5P1Hg0zH
         6E5plx17TkWDzthdzLZTu/MRk/0K4ASeJFuarfYU23MtRM2A7eVcP/A7Dlc7nn+eKKNl
         /PvYU+gHO8Vk39pHtaC8ezAX2DPo3o8qLzdQBXpBE3iJ0CGYz8jgVU91jFAWPoPE5IPQ
         NMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zk3T9LnUWwO5YeJx4V9p68YCX/skS/x+rKrbdF1YJps=;
        b=xqrwIucXTSkNSfEGEQEiW39iwEVZuLKzRlEP9TFDlf5BeFmgM216mPDvZM9xRr9xcd
         8XHdr3zyRfxVDLs9PX+E1SXK/KJrz6EM8gIYUVXUuQuBB9f9hJZQa+VLyyunqUwdulWh
         AUg0gXVdnliYK50mq4qF+wTL3WOsJcgXJQC2JEVMUBoBvlNnJQKyK/kAO9PASa8l2/fP
         UwUm6J7kz6gy+Ck/35htCHY1XuLU5/YisPkxQfxRJAyXtK3iB4+10kddyi6tpMaq2FPc
         jnqhCHlsWYUQWR/sAXw8IOBUQKvZlLWralMfC91Y4SHad6HdHGgZ9u4OaEviLy1zf6qD
         agJg==
X-Gm-Message-State: AOAM530kfHMUkb4V5zPqxFbJga2NPHCSbt+dlk2KfbpXnU88AId2nst4
        UmA1SbADYa71mB/c42i79xCklfBeHy1dfrsJ
X-Google-Smtp-Source: ABdhPJy3FeVwHxo7+qiSEeeuRc4C7UVsssDreBpMskiIekkl3N8ekVcWVjHZ14w5pZuvDkrhTCs8KQ==
X-Received: by 2002:a02:b903:0:b0:30e:49cb:e65c with SMTP id v3-20020a02b903000000b0030e49cbe65cmr12554473jan.164.1645394381688;
        Sun, 20 Feb 2022 13:59:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k11sm8264021iob.23.2022.02.20.13.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 13:59:41 -0800 (PST)
Date:   Sun, 20 Feb 2022 16:59:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/11] worktree: extract checkout_worktree()
Message-ID: <YhK5zM4NHhUpLPMJ@nand.local>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <1e62e4e4fa1a543ad134d70d97740cac5826e587.1645379667.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e62e4e4fa1a543ad134d70d97740cac5826e587.1645379667.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 20, 2022 at 05:54:20PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> The ability to add the --no-checkout flag to 'git worktree' was added in
> ef2a0ac9a0 (worktree: add: introduce --checkout option, 2016-03-29).
> Recently, we noticed that add_worktree() is rather complicated, so
> extract the logic for this checkout process to simplify the method.

Thanks; all of these "worktree: extract ..." patches look fine to me. I
reviewed them locally with:

    $ git show <the-patch> --color-moved-ws=ignore-all-space --color-moved

and it was clear that all of the existing functionality was preserved.

Thanks,
Taylor
