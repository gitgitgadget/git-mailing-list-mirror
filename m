Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99620C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 14:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbiFBORH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 10:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiFBORF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 10:17:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103481FCE3
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 07:17:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id jx22so10199891ejb.12
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 07:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CvLLXgqy1vcWOz9M49Qh+EH7rqWf1bCKMVmOIu+o14I=;
        b=RX4Z7eBfCzDFgU1sF/g2QcBfvlnFVpXpTWdzHsgj5mpd31/KB6FDIU/iGlEXKr7vib
         C1oGG7+xEfIat/0fkI5ll8Pl5efq537QWJGaDxaT3xcQMeOM7j8EbLmpnvqHcfQ82rr8
         /F2XLUMWkO9Yd/Kdolc9wPQD+ZhiP7/S8A5EGdkXIpYUUV/p1CRf8ib5p1cV2cAkEicp
         NRHFDR5mWHfFK0E4odJuAgM2v47o8LP3SD4r/ZTW62FlnJV3kPdmSvo08ki2dbVecaJu
         RhhUSupxPd5WsNtJsHaT57k6FXm3bUhYXbSISG5R4snef/DbEtKNlDfiZJTZduzahxgs
         8nZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CvLLXgqy1vcWOz9M49Qh+EH7rqWf1bCKMVmOIu+o14I=;
        b=lB/cuhV4TOFStClwO/fyFazV9UyoBQHOXBOm6JglaHQtJjlShnrLo1zNEjCvYjVBfH
         Si6KGimyx2lTQNR/UVN+cc4c5PvOi8epp4lFcAYL2STeCRPXpUAqXZwZZZeH+GskGNsw
         G6MX3vZjyUPHSJpp0Nl52P7dFbZUKRYgglRAh5NrbHd45iMR7XoEE4iL1kvlqdGnt/fV
         zAxvMJE4EmCzgVms4R8RQZaKzwRYt4yJ9wL0ELK/kAa9916jMAPZIXv2PeRvTIIkgQ0+
         KP9IlmiKLSdPV6q5aiBdNq5xsNP0pYoIhKo/X0VTjMn9o8Hv9NmP2VXuqQ0l77bhB4en
         aX3Q==
X-Gm-Message-State: AOAM531/PURVbOVIUTn2Hy0ScjzFAKWFBymoVewEo38DzGeVJxp8L7KO
        DIyJx3jLDAfnOr/s7OYEPRM=
X-Google-Smtp-Source: ABdhPJy/bmIOexs7HY4F7pDd2jgpe5U2FDy3qw5nEr4pfJyuoQIhJU77Ll3iY+xYsRTSoEwr2ANoyQ==
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id cr16-20020a170906d55000b007047ba69854mr4400268ejc.579.1654179422376;
        Thu, 02 Jun 2022 07:17:02 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id rn13-20020a170906d92d00b006f3ef214df2sm1739933ejb.88.2022.06.02.07.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:17:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwldE-001VzE-Ri;
        Thu, 02 Jun 2022 16:17:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Integrate Scalar into the CI builds
Date:   Thu, 02 Jun 2022 16:13:54 +0200
References: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
 <d0448d28-b33c-3f42-901d-3cd7f4201c78@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <d0448d28-b33c-3f42-901d-3cd7f4201c78@github.com>
Message-ID: <220602.865yljywtf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 02 2022, Derrick Stolee wrote:

> On 6/2/2022 5:05 AM, Johannes Schindelin via GitGitGadget wrote:
>> Note that the changes to the GitHub workflow are somewhat transient in
>> nature: Based on the feedback I received on the Git mailing list, I see some
>> appetite for turning Scalar into a full-fledged top-level command in Git,
>> similar to gitk. Therefore my current plan is to do exactly that in the end
>> (and I already have patches lined up to that end). This will essentially
>> revert the ci/run-build-and-tests.sh change in this patch series.
>
> I expect that this won't be a full remote, since we will still want to
> exclude Scalar from the build without INCLUDE_SCALAR enabled.

"a full remote"?

Scalar (well, scalar.o, not scalar the binary) has been included in the
default build (including CI) for a while now.

What we haven't been doing until this series it to link it with libgit.a
or running its tests.

So perhaps that's what you mean, but in an earlier series it wasn't
building scalar.o, and I remember there being some confusion on this
point in the past, seemingly based on a mental model of the scalar
patches that pre-dated the re-roll that eventually got merged.
