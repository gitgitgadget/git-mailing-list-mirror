Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D653C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 21:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E25B6140F
	for <git@archiver.kernel.org>; Mon, 24 May 2021 21:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhEXVoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 17:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbhEXVoV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 17:44:21 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E290BC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 14:42:51 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id a7so10659538qvf.11
        for <git@vger.kernel.org>; Mon, 24 May 2021 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=48jqazlIjsJQ19SHLvpDADtof+bZyqzRdLw8jhIGkVo=;
        b=Fh8wBzP57ZUm5c4veGZoTO3RF8Esvl/5dGO4gGrp+yoS0stPM0EbbLOLtilcOn06tA
         Hxwjc9f3eIddSKubfhgDxh4AJIdU6UPmJISN1k6MjLIUnl6+tpVl901woqhu1yZscFkh
         vWtsseNfRwys7CQvbB4hy+LETZfEsfSjnuXgx8Tggb1ouVVqu3CkfwRzfgQFwJ9/5uNp
         EnECrE0B/H1oAnx8ZWqdQizco2gyP9EzbGaVaALTfEokY984tItay9zgfZa6XAq6besb
         CgCTCZemx4y189NWnpaq/Brm0HlAWxPYsUbDY5YHT5oa2NT2wfBZGD2v3k9O0WBL5Uie
         dHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=48jqazlIjsJQ19SHLvpDADtof+bZyqzRdLw8jhIGkVo=;
        b=Sx8Yc+u3zIbcNbPRabr1WC+dOyLT4/Fu3hU9ctwirB2u3yu1FbdrEY0nCqkX/zCGZk
         PkVYL+oaHbJaD7BPR+BFW+dCAGG1p2+pg18n+PbiduRRvss91WIFd29ecuBU9HIwCnPe
         RJ4URjiQ6GBXsWEV7lhwzhhQ+Pj2Alza3dBDbMcocicDlwLzS3+Wc+ogkFd++2rolxHL
         pOR8h3a5FYKcVBhpuxXT/nTzomsT7bzQtBza/oNwmIWlPxAGYNYm1IZjWzJAUjt5Vm6z
         bCVm5zNzXygLPop0y0fl1bxG7jZAkTmN4ghYqs6WUoXCwnJKNdTpWadcxoAIIupXv0Km
         pGWg==
X-Gm-Message-State: AOAM532059FirGuy6VTQbrzhLk80JAFAUc9Haq/WWzE5obefIJtdBWJz
        OSXpwwu3MKwgam82knmK//tEBw==
X-Google-Smtp-Source: ABdhPJwwBrqNuZg42pIj0Ls132pvmgpA8H8T2sOvwh4pj2jMvDKjIjeQG7mXd0qlaXNrL82kLCPODw==
X-Received: by 2002:a0c:ec04:: with SMTP id y4mr33430887qvo.51.1621892571097;
        Mon, 24 May 2021 14:42:51 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1c2e:9388:c87:38ef])
        by smtp.gmail.com with ESMTPSA id w4sm11517324qki.57.2021.05.24.14.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 14:42:50 -0700 (PDT)
Date:   Mon, 24 May 2021 17:42:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
Message-ID: <YKwd2e5VxVmU6zqj@nand.local>
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
 <YKwMU13DOtTIgaeP@google.com>
 <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 24, 2021 at 04:38:18PM -0400, Derrick Stolee wrote:
> On 5/24/21 4:28 PM, Jonathan Nieder wrote:
> > Hm, I think this test strategy is going to be fundamentally flaky
> > regardless: Git doesn't intend to guarantee any kind of stability in
> > the exact stderr output it writes.
>
> There are no expectations that stderr is stable across
> versions of Git. These tests don't add friction to developers
> making new features or changing the error messages that appear
> over stderr. It's just that these tests should catch any
> unintended inconsistency across these modes.

I agree with Stolee that these tests are valuable for asserting that
output is the consistent whether or not you are using the sparse index.

I find setting GIT_PROGRESS_DELAY to a large number to a be a little
ugly, but there isn't an apparent better way to accomplish the same
thing. Of course, it would be nice to have an environment variable to
specify where progress meters are written to, or a global option to
disable progress meters altogether.

But I don't think this isolated instance should push in the direction of
adding support for either of the above, regardless of how easy it might
be.

What would perhaps make more sense is to silence the progress meters
from the commands themselves. AFAICT the only command called by
run_on_sparse() which generates a progress meter is 'git checkout',
'git merge', and 'git submodule', all of which support '--no-progress'.
Might it be worth passing that option instead of setting
GIT_PROGRESS_DELAY to a large value?

(For what it's worth, I have no strong opinion either way, so I would be
happy to attach my Reviewed-by to even the current version of this patch).

Thanks,
Taylor
