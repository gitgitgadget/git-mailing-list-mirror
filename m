Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE72C48BE4
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 20:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbiHXUbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 16:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbiHXUbT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 16:31:19 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F59A6B8C4
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 13:31:17 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q63so1768656pga.9
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references:cc
         :to:from:sender:from:to:cc;
        bh=bUQNWixrEINihvb/1wZGO8lICV3zwOSMrKjBpG06Su8=;
        b=qooEqYdqZK2M2UGlqWnsHyeoB5B3cQkvhWa9ocqXDs5wxr+bioQtLzFiDDyWjPcyav
         ViYntQpuXwvkHJEN937zMv5XlgYbPi1+a3TJfccbhHn7d8HMAM80QnehjpRXh/N7Q1lp
         KFGn2C7yD+8vxYr1DJiEqFigAVXMDAJxYryMvIrFNuojb5uPxBxwTLL3dGR/yMtCpmm1
         aUJ54b+/E69RfdVnuHDtrz15Y7+1cAGn/nJt7B1JT1Z+h+36gswZbMN7ycS3Pho2eYUB
         PpRSiyL33zsvG2B8cc5rqTEKAcEAM7KnFfaPeyjYphRETlipTwDviFXQL2lqbZ8Q7wkp
         mIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=bUQNWixrEINihvb/1wZGO8lICV3zwOSMrKjBpG06Su8=;
        b=kP2EQFqKVf7lLFZOPlIJCiaOPM0dGTtfWXFOzG42AtLhB5+8Tqr6qk0oZXpvvRTeTG
         KaVvZzfcywwPkDtYFI8CKJrQdbZG6mY2dzKpJfs+3EwCdV7oAC/JxX5PCQyf85F8wQfX
         7cKAXDI2KBk1R7l1mzjlwHin3SolM7oZ5H0vWBosevtO/lf41naZzNYUW9YVhqm8lQTu
         E+iRYwvZto+MmMZnV8r0RaZ+f1mGsfmrH3tstcYEli+XjzqMzq09FWmph+sDgyNLBDPO
         pLcNPNL1fcoOWZpUjHFUpQm34AQ1cbX3TstgeckRIWvaud7iVG4uMcBP+YSdLsRAtKGB
         j6NA==
X-Gm-Message-State: ACgBeo3X7eCa59g7sxIQPHqpfIXd529Rodj5W3/VwVMhlRxQs473p5Hj
        FZqSUVfB3K05qKeDJ5+2K+8=
X-Google-Smtp-Source: AA6agR7BCV2bpKWG9AXzy1cYRe9oMkFxSIh8QPJQRVy2nd2SyHTaPSG46+Wkdt7yxURx/fDOOMAefA==
X-Received: by 2002:a05:6a00:a19:b0:535:49ee:da43 with SMTP id p25-20020a056a000a1900b0053549eeda43mr749350pfh.53.1661373077057;
        Wed, 24 Aug 2022 13:31:17 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z24-20020aa79f98000000b0053627e0e860sm10750914pfr.27.2022.08.24.13.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 13:31:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "edecosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
References: <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
        <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
        <f977d140afac8b2d205a66ad4deb1ec1913588fb.1661280941.git.gitgitgadget@gmail.com>
Date:   Wed, 24 Aug 2022 13:31:15 -0700
In-Reply-To: <f977d140afac8b2d205a66ad4deb1ec1913588fb.1661280941.git.gitgitgadget@gmail.com>
        (edecosta via GitGitGadget's message of "Tue, 23 Aug 2022 18:55:41
        +0000")
Message-ID: <xmqqpmgp5qp8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"edecosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: edecosta <edecosta@mathworks.com>

Do you have some specific reason to avoid using

    Eric DeCosta <edecosta@mathworks.com>

to identify yourself?  Otherwise, we'd prefer to see it that way.

> Subject: Re: [PATCH v3 2/2] Check working directory and Unix domain socket file for compatability

This project is wider than just its fsmonitor part, so please make
sure to give your change a title that will not be lost in the noise
when it is shown together with other patfches in the output from
"git shortlog --no-merges".  I haven't spent more than 30 seconds so
you may be able to summarize it better, but perhaps

fsmonitor: ensure filesystem and unix socket are usable by fsmonitor

or something?  If I am reading the early part of the patch
correctly, the value of this change primarily comes from the fact
that it separates (1) filesystems that are inherently incompatible
(e.g. cannot create sockets) and (2) filesystems that pretend to
successfully create sockets but the sockets are unusable, so a title
with "separately" somewhere might convey its essence more clearly.
I dunno.

The patch itself looked sensible (I didn't look for typos in
constants etc., though).

Thanks.
