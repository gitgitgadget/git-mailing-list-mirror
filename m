Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFE3C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 22:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BFBD60FC2
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 22:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhHIWtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhHIWtX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 18:49:23 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D347C0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 15:49:02 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id y65so669354vsy.3
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 15:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lePjEQnn1ipTqvhmiSzPa+V9nz2hkfsiYs/Od79HwCA=;
        b=avgzCWO+zDyktpC31cWAMgqpqHI+8t1U3CSoPbc93ZG9LIBSeECL8awhq322K7Ybmw
         WTzIQumLFuSrf0xOlU/woZpdX/3yvu1IT5+g4dQP6lJHvmLvtZPUvd4UyqWIUuXAlRhH
         jXY7o+Gps+TV1s0l1CJsZk/XlgZ0MLZeozrem+4npQBkCviofBBHpXt1OeGBzaXv0jUU
         SL8pZSjSGtvxc4asz/9ZMZTxBvtuNE1Cbl+m1MF0uNIr9ZY1Rc3quaMBqETWnTkuDevI
         /K5ofVoBvMUlXxVv7k5qgBLO0ZSzJVnrC0wKevalPSJDSWUqaREFM39hLuol1PkX0roB
         5dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lePjEQnn1ipTqvhmiSzPa+V9nz2hkfsiYs/Od79HwCA=;
        b=VJoLWq5LFbv6ZDmDzj8QwRoxjhesdwTUUBA/Q3f2iFaW0whjLSzvEnLi6sy4gpK1Ib
         vRnUqBVVxxsf3IjZJ/VRhYFJLti25db911kmApu4zAEgZOAt15R//wVRWCCoQ4W7juUL
         Cz041XV44v4RtvvTBnM5sYoVo/wbhC2kvEes+P3J8KKjAdbZ7g8aGhP68UO05dQ9/IvF
         xPw8RPc6gj7MwFH26M8eZaOU07Bp3KzWuD1sn1UqxdehOIIj0jWjiiCR913e8Kwjc6FR
         6zVrbavoz/cLlKD35zAPMk3K9G0R/MSZBmUD8K8bRvkGe2FZ1FEz5C7//baLmSXcLTXx
         40Qg==
X-Gm-Message-State: AOAM5308HfPfA0dfMJifhoYGTOWABXYuRCn8nUqdiPXQqD/QjbWChd0t
        j48L8C7Oi4eYvr/F5kjaO6sbp5yXqaA2MUEV2JFSd70WGMg=
X-Google-Smtp-Source: ABdhPJzzTDJowERmuMBkiNFGAmeUjYJOWobeXYYySRAKLdeeQEwuE0VZjOe8iTVm2EU7+Z/OJH3BrdADan9R4CLZNI0=
X-Received: by 2002:a67:f144:: with SMTP id t4mr19007336vsm.44.1628549341609;
 Mon, 09 Aug 2021 15:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com> <20210809013833.58110-4-carenas@gmail.com>
 <1b096830-3e01-efbe-25dc-c0505c8bac7b@gmail.com>
In-Reply-To: <1b096830-3e01-efbe-25dc-c0505c8bac7b@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 9 Aug 2021 15:48:48 -0700
Message-ID: <CAPUEspgh54AywgqMuOXJf5uPZdR2AN9JLrzJwcOtoec7sRnN7w@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/3] ci: run a pedantic build as part of the GitHub workflow
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, e@80x24.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 9, 2021 at 7:56 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Totally unrelated to this patch but while looking at the ci scripts I
> noticed that we only run the linux-gcc-4.8 job on travis, not on github.

it is actually related and part of the reason why I sent this as an RFC.
travis[1] itself is not running, probably because it broke when
travis-ci.org was
shutdown some time ago.

maybe wasn't as useful as a CI job using valuable CPU minutes when it could
run in the development environment before the code was submitted? the same
could apply to this request if you consider that unlike the other
similar jobs (ex: sparse or "Static Analysis")
there is no need to install an additional (probably tricky to get tool)

Carlo

[1] https://travis-ci.com/github/git
