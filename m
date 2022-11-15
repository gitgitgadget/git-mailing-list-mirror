Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6BCC4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 16:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbiKOQnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 11:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbiKOQmp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 11:42:45 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D4B2FC02
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 08:42:38 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id bp12so7671771ilb.9
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 08:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cZJodwdpa0sokEmPhn2uNIe2FQSaCvdRtvfU98Oxsw8=;
        b=J0muhh9n3AaUTxM7FEAgaG2ymmXDInnB8SbbVx3303SVxB1wJlgcDYZvuVf3PK13Gp
         7p/iMdjgfwoBvsxlmuVlr6Gk8KrajZ7JFw9w5dIgVygF7a2zE4sBMlOpkW77kwy4lBna
         oI9/znW9pxmyMXVtgWpUXP/Hp0gYWSqtQqH5VdMP8RZKhIBOIyo/hrgSz1i71QEMfbNy
         FWSjPBMcZCZ6xDCMv//jFQKUT2iYMUG1VC6ZYUnSrZ9zLg0utpO9ng0YV1VzsVw8H39M
         mH6O62pxYBQ52l15YbajjKBnYQAMCz8Z7/hb5D/Xp2Ez22WOpknZ+DW06TuyYZA1yQ5m
         GgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZJodwdpa0sokEmPhn2uNIe2FQSaCvdRtvfU98Oxsw8=;
        b=L6aDjNfnqLZhtmy/TnyXwvqW7Em8TyZOtlndtPYVPwzWG7/vw579AZ8KNuGxcgRKjy
         lWNKVlPxMiGU6Dn3IW8sVSc666WaB4AhP1iooiGEa7wjkSZQjjJUkx1osZDqm5DNbrSG
         wU/gxlxhvehxSFKKKma7EmNlBjNiOeVNH1bBgmhrCUmYC+h3WGTX8MH6ApiXzvg7Sydg
         Uv2DLix8CwdJtd/9JKbKwr8bvbUH/gOs7QpL2DAqed9z5oRzECfvUABlwC+KghX7pk7J
         SDGRtcJz5xvHH4dZZ1XT/JX7e7pj7A3HomAB7jjKwS1/LnX4rVCDnaMhsRnarGiI8F4u
         xffw==
X-Gm-Message-State: ANoB5plWCUT04csj4H+lTUHhri41fE22Sp3XZ7VuO3zYZ85OgL1HyaUQ
        gVn/Ifj906WEdJ1Mw+dBKp2FOhDtnTUTGHAjtxc=
X-Google-Smtp-Source: AA0mqf6+SkM+flsg9x50azaEbKwYIQSAHTJcfQTGrLNLQhkU+/xnVBTuHGcmx6xJJf1KYj9ZspO1oEyT2jAmJ5mlQ5I=
X-Received: by 2002:a92:dc4f:0:b0:302:5733:664e with SMTP id
 x15-20020a92dc4f000000b003025733664emr5095165ilq.42.1668530557621; Tue, 15
 Nov 2022 08:42:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v4.git.1668055574050.gitgitgadget@gmail.com>
 <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com> <454089ac-3d0d-9820-26a4-e5650c2604d2@jeffhostetler.com>
In-Reply-To: <454089ac-3d0d-9820-26a4-e5650c2604d2@jeffhostetler.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Tue, 15 Nov 2022 10:42:26 -0600
Message-ID: <CANaDLWJVQV_RRTmjv2C1+WRJFmZN+LPNCDdawBs_-pLHcYamKQ@mail.gmail.com>
Subject: Re: [PATCH v5] status: long status advice adapted to recent capabilities
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think V5 has addressed all of the concerns.

I confirm I don't think there was any concern expressed so far that I
didn't find a way to address in some way.

> Thanks for your persistence!

My absolute pleasure!
