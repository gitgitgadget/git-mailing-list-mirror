Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868D8C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C6A6124C
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhKKWm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 17:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhKKWmz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 17:42:55 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6334C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 14:40:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h24so5184213pjq.2
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 14:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ro4jdpf1Sggp05Z1+5dklrF75H/jpfP+G5fwS5frdA8=;
        b=o0FS0u3K164L0XJlqcRu8Zkric5Hbgt9GW5nj4d5X3c/DI6OoHURR7sV+sk5Oa44rj
         0rFPewC2K+sUV+b0vtGinsrjIRsHSm6eyDIclp3I7CubsK+FVfyTGn/72dEcnTp39MGp
         WIigxuyY4kz8YTD+UQEdTYVe3Rot9hu1sFBBzb1UDtVlHkGXjA1pL/pJNCH/Qp7r6KdU
         WzDn7Ij3cApOBcaQS+y3P9nTU1QAJbQ9/zPIgWSzV2xEB29B8K+P/yo8pGTqfBa8I79h
         2DPDpzgA5DBBzREId0Y88bDa0On9K91ncvuWfkphOZr2bSpnuWu3HZRwXqSgags7LHkT
         5HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ro4jdpf1Sggp05Z1+5dklrF75H/jpfP+G5fwS5frdA8=;
        b=NY/OqvMWORxmkr1E+kP4Rl9Meh4ovuGZLw99J+b0BpmoKqLNaLdjxsllaUrUpTHbv+
         +aTKzmt9xbfUH/izCkHkPUVha2ckpL9XJgTx6X0iRf4zYQB/bZERkJq306MRC2AA/fuN
         rNCgWF5ZyCcT6ChqJTnWJm6gYKAhqbNfEQA+VFSvZH4Wqp1fS8IGqBSQ4cmFwh7RCjgz
         Pr7G0kXGaWZ3XUbo6so1SXPBgXFs866WyKWNgXms6bBDwPXU0wj40QGyruwWPf+8RpU7
         OZ3lA89igi0/kP4Vir7V7HSqDKSppN0G6TfpVbt1N/GJm9/U4s+v9bxG+sXluNFXtTDz
         d0bw==
X-Gm-Message-State: AOAM530BL8w50mHE6dbIgv6WbLhHWPK/nNNIoGojW6PAtgrjqOWoLMPr
        FE0ymcZjTfOhM3SNtL36Lj0rwIk1a+jJpL02
X-Google-Smtp-Source: ABdhPJxyfKItsXpk4MJTuvgR2YI3BJ/DGlWdUHlpmD2QklI8QSB668GHnrKulkhRK0KKD0ePFgaPig==
X-Received: by 2002:a17:902:b210:b0:143:789a:7418 with SMTP id t16-20020a170902b21000b00143789a7418mr2772763plr.38.1636670405105;
        Thu, 11 Nov 2021 14:40:05 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:ab2f:d045:9fa5:64f1])
        by smtp.gmail.com with ESMTPSA id o7sm3291276pjf.33.2021.11.11.14.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 14:40:04 -0800 (PST)
Date:   Thu, 11 Nov 2021 14:40:00 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2021, #03; Tue, 9)
Message-ID: <YY2bwMQTtg/DY+39@google.com>
References: <xmqqy25wygek.fsf@gitster.g>
 <YY2W6ESIxSz9lakK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY2W6ESIxSz9lakK@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 11, 2021 at 02:19:20PM -0800, Emily Shaffer wrote:
> 
> Once more, updates to submodule-UX-overhaul related work.
[...]
> 
> Jonathan Tan: WIP v2 Conditional config includes remotes based on remote URL
> https://lore.kernel.org/git/cover.1635527389.git.jonathantanmy%40google.com
> 
> Additional discussion ongoing, Jonathan is working on another reroll,
> with a substantially different implementation but same user-facing
> feature. I think this discussion can benefit from reviews with an open
> mind - this is another effort to solve "how can a team ship configs for
> anybody developing their project, in the least painful (to the user) way
> possible?" In other words, this is a spiritual successor to the
> "remote-suggested hooks" topic, in that we are still trying to solve the
> same problem.

Seems I slipped and missed a few others too.

Glen Choo: make create_branch accept any repository
https://lore.kernel.org/git/20211111171643.13805-1-chooglen@google.com/

More cleanup of implicit the_repository, this time in create_branch().


Glen Choo: RFC: Branches with --recurse-submodules
https://lore.kernel.org/git/kl6lv912uvjv.fsf%40chooglen-macbookpro.roam.corp.google.com

Some deeper discussion of branching strategy with regard to recursing
into submodules. This would be a really good one to follow and weigh in
on, because it is an unusual case where Git will need to be opinionated
about workflow in order to be useful, so we'd better be sure our opinion
is a good one.

 - Emily
