Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1DEC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 00:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiLOAVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiLOAVc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 19:21:32 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2736626E
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 16:21:18 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g10so5123405plo.11
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 16:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgXLcuZZQxxnxfEH5rqbus4uv1j3TO6GErCW0raOYak=;
        b=I2/D86kfL3gxfu/pZEv6fgHCWqWRx8nILUYo9J2+gP6mZgYKH8UkdEe63URHtrvMKd
         T0Mi+Xi/bKovCvdOg+vlFSzSK210MR62xNZrvxU15BZSzb+9GNST/joZsqD0paztXXWp
         v10rftO2EZMTICNygBzQQb7t8okkLO9ujY8WRQjnJePM0Wl4G9MgmqiJYOJsHUfALLx1
         D8kGxjUfMMDWS9YSrcQwkMmPzrQFmJLkIbiPehVeduWB3EnCH4Mgd0mSlQiO6WcdPAz6
         ZjkKPWlPyJx3sRplkd56F7M/V7dJc/4120upv2zmqXpbjVJr/8IwAkSs2yuWhMhuwsOn
         I1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NgXLcuZZQxxnxfEH5rqbus4uv1j3TO6GErCW0raOYak=;
        b=rC3CG7tLCEus3KE7oX8HNavEtjUjnuTy8Vf3Hpqu51dibwYUaiV9Xb122ibh0+XSM1
         eO/hKXw56zKlLtyk2PRM6OkCj7RDxRQ/hA1zqEJEnQAkr9CIkaRwMH1QKF0lGVIIdCVd
         VyJVnR7hPOgITkfXhJvDE7zTx5mSWk22D0ldeMIc5TfiMV1vXoCnZhrbZEfCCjdXtPL8
         HAyu2qWUcpj/vWz4ggvlWin7fMolMZdTTSF3phg51ua3cOwoaIV0xs1CIJFK3eWjAE2D
         ewgj7dZKCjjU2vtimiF/v5snIsjNWGkDlYODENyfapy1NmiOse5lsPYrtSPRBoaGrL4O
         PknA==
X-Gm-Message-State: AFqh2kp7IdPUKxIyPb51QR5fg4pkbsrymWTyNB5AVtpJ53PzIDVlQ8uv
        uPSOZBZMB+W7aix+fy8RM/Q=
X-Google-Smtp-Source: AMrXdXskRF9m9xNm/Z3wR3Hwfs099ooAxXsxev5JETAGwivWRO15VXMjtNOYECC4u4hM9ydk5zeCsQ==
X-Received: by 2002:a17:90b:210:b0:223:2edf:857e with SMTP id fy16-20020a17090b021000b002232edf857emr5612474pjb.8.1671063678372;
        Wed, 14 Dec 2022 16:21:18 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a284900b00219bf165b5fsm1932459pjf.21.2022.12.14.16.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:21:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
Subject: Re: [PATCH v4 8/8] t5556: add HTTP authentication tests
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
        <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
        <8ecf63835229676677e3f7e33f634eb5d3a568b7.1670880984.git.gitgitgadget@gmail.com>
        <1dc44716-2550-47de-e666-9972b102905d@github.com>
Date:   Thu, 15 Dec 2022 09:21:17 +0900
In-Reply-To: <1dc44716-2550-47de-e666-9972b102905d@github.com> (Victoria Dye's
        message of "Wed, 14 Dec 2022 15:48:08 -0800")
Message-ID: <xmqqpmcltt36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> A general comment about this series - the way you have the patches organized
> means that the "feature" content you're trying to integrate (the first two
> patches) is contextually separated from these tests. For people that
> learn/understand code via examples in tests, this makes it really difficult
> to understand what's going on. To avoid that, I think you could rearrange
> the patches pretty easily:
> ...

Thanks for a thorough review of the entire series, with concrete
suggestions for improvements with encouragements sprinkled in.

Very much appreciated.

