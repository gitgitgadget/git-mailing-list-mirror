Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC4DECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 21:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiH3Vgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiH3Vgf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 17:36:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3124475FD3
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 14:36:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 76so12622201pfy.3
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 14:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=LZsbkyDvYQ+Eg3sTJgv/kcJGlpxkz3Ys0D2NLp8u4Wg=;
        b=ZgxLa8ptNF8PlHaYYr0kYvd8ssjY8Y10ZMeUw+p6yo1xPHRdE+LIx1X9iUKPMD8zJG
         gmnZn+xEoHwfIYPj/s6Y1y5Sm7Mv/S2/HmswrbXAFwCJx/dLDpkzIWgcbxqtt71EA9LG
         aqqeEC3Z2+ezF2qOG837miejjjAs2KtQBSEg8LETYJ0rxy+LAvmyptOTUI2L5awkGOMb
         Qm5wFtbBtmtgIlWqd1B2AyMHvVYqaTZv949aS6uLxm4rGRIA/lsWY/sw0yfnCVuZLdJx
         YW/ujEKNYkQd2ZHU6ZxLYHHcszY4jEJQ/IZu49F2g7nek1EjUzA/G3ff2PyYzjCJhJZU
         uC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=LZsbkyDvYQ+Eg3sTJgv/kcJGlpxkz3Ys0D2NLp8u4Wg=;
        b=eBgeO/jT2bU7b7WQVkxFiYr7tX7Nvmcs45qxeTZTO1YxVSVcYXgYfj6HdaZwOfQbwk
         VyMtxuHqYS/ttGQHt6ngb3MFCM055V7oKNtC1ABd8HkjRpwe+T2Me4NjpG0wOayeR1Sa
         TWhp2ESn0uDFF8cnjQGQMROhqHMithlWvFigAmrq0SKdt03xSGu5qWotvCXbmYEPXsPx
         UJV5Ueykz30BSjcEFU3EX0fzk1THWmDMKaHkZ/hSlcCPR4ktPG+2qwF9uMt/m1Z7NVdb
         ndGxkMBLL4C2B4z6d6pRDZFe4UQC4fCP9dpar+hln3oE2RRBqvKB/oMnu6wooIrzOZEA
         Z1Sw==
X-Gm-Message-State: ACgBeo2ivzoth0yAwnD5pvFB6criD0r5GGI+HC9wprubB6TKqnJ+oxub
        czEY18Yz2LpX9ejaNfCnrQ4=
X-Google-Smtp-Source: AA6agR4TN7s6RWUUTDLimXCM3fdWXUh089DNdqQF83eOL9sZ3IdujxDnMvSiolMuFeQhET9W2N0PYA==
X-Received: by 2002:a05:6a00:234f:b0:525:1f7c:f2bf with SMTP id j15-20020a056a00234f00b005251f7cf2bfmr23364824pfj.14.1661895394606;
        Tue, 30 Aug 2022 14:36:34 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w13-20020a6556cd000000b0042ba1a95235sm2064426pgs.86.2022.08.30.14.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:36:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 1/5] t3701: redefine what is "bogus" output of a diff
 filter
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
        <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
        <a01fa5d25e4a94dd8ece5e328f853c000a2ad0f9.1661785916.git.gitgitgadget@gmail.com>
        <9261de42-3287-6ccb-6cf5-21c0a8ee1f17@gmail.com>
Date:   Tue, 30 Aug 2022 14:36:33 -0700
In-Reply-To: <9261de42-3287-6ccb-6cf5-21c0a8ee1f17@gmail.com> (Phillip Wood's
        message of "Tue, 30 Aug 2022 14:17:49 +0100")
Message-ID: <xmqq7d2pifby.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> The existing test deletes the first line of the diff[1] - so it is
> removing the "diff --git ..." header not the hunk header. This patch
> changes the filter to delete everything except the diff header which
> seems like a less realistic test.

Is it that all it cares about is that the output has the same number
of lines as the input?  If so, I agree that it is much less realistic,
but it may not matter in practice.  Even an "exit 0" might do ;-)

I may be quite off the mark on this one, though.

