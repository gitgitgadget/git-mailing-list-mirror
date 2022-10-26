Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499E8C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 18:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiJZSyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 14:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiJZSyo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 14:54:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA023B9AF
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 11:54:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id io19so10115659plb.8
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwQ36s9pINkPEwWFZbJzZDLLbCozBZVYhKPJo0vrr2w=;
        b=i3iCnMEO+3C+FI+ICe4FMCXdxoWD8dy4qsG5BiVEMspYCT1VFM7ewLhcGdm6Sci4Y2
         OPvOEPw+pgHN7dDrQXDEDabZvTRZbmFiZxcbRSLBaj8nGXayHWwI4w1Ne/e9Emhl0vn9
         OZKpidJPAXGTjJ/+AEap3fPk0a7P2vL5wP3c+T/ACIv6bZv7jI5V+NgE+6LAAOsI5iji
         DYsruP2CXQbYhTcj2thGVDxW2G/mXDo5dlELgdpyDMHrwzFkaNoEMAj5cItXfLr/7RUt
         6McMor87/dGPEf2GDIoaKapmEMUdR98Kf+vleQwHL0wEgC1GWEPDiX8tS+KMMAY6Hzl7
         heyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kwQ36s9pINkPEwWFZbJzZDLLbCozBZVYhKPJo0vrr2w=;
        b=YSQny5DzDVg0Bavb/ZGZQSANapj5C3kEaRTFvgx2HMYco7JBDomsbdrgtJdRj983TS
         S6DOGHmlSr/Htt0gUQFsp7ZPweofTcfyKveCFvCOywqfKxYQnwFanZ69IP8s4Y13RtHj
         REUESc3TyOh0IxF3zQJz+BNUxjDz08X20fsDpIQ2yxMdJg8ynIxezWFkPy1eqINYbRwh
         WXEKgfRBI5HltRyLKOGjo+L8pL533e4JxXSP/wRIDFPI12sDrdT4eFVrq+HO4CViwhks
         jT7e4kccLcvW/izFiP/q0A6d2Epeuznx1/uBX0PiF0yOyNZVGe75fZuST2O6OG/AKU5J
         AZCQ==
X-Gm-Message-State: ACrzQf3E0HGDvZi2cwNcQyyMl7K86lhUIevZSMpmBQJWkHyOguTO5pbW
        MeAxiOr9RtuqojXpq6+7bAw=
X-Google-Smtp-Source: AMsMyM4aSpHBQcWwroXy0OU35ES8BS9U53HUighUxfy7KPbx3vHA9U3k1F9SeALOJUPs/Fi5ra4HEQ==
X-Received: by 2002:a17:90a:6394:b0:212:f19e:16a3 with SMTP id f20-20020a17090a639400b00212f19e16a3mr5766109pjj.231.1666810482850;
        Wed, 26 Oct 2022 11:54:42 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y76-20020a62644f000000b0056bc1a41209sm3322655pfb.33.2022.10.26.11.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 11:54:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v5 12/12] bundle-uri: suppress stderr from remote-https
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
        <5729ff2af4bb56a68624b7942b8afa67601adb43.1665579160.git.gitgitgadget@gmail.com>
Date:   Wed, 26 Oct 2022 11:54:41 -0700
In-Reply-To: <5729ff2af4bb56a68624b7942b8afa67601adb43.1665579160.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 12 Oct 2022
        12:52:39 +0000")
Message-ID: <xmqqmt9ih0um.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When downloading bundles from a git-remote-https subprocess, the bundle
> URI logic wants to be opportunistic and download as much as possible and
> work with what did succeed. This is particularly important in the "any"
> mode, where any single bundle success will work.
>
> If the URI is not available, the git-remote-https process will die()
> with a "fatal:" error message, even though that error is not actually
> fatal to the super process. Since stderr is passed through, it looks
> like a fatal error to the user.
>
> Suppress stderr to avoid these errors from bubbling to the surface. The
> bundle URI API adds its own warning() messages on these failures.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  bundle-uri.c                |  1 +
>  t/t5558-clone-bundle-uri.sh | 16 ++++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)

So this is the same in spirit as [11/12] to squelch errors from an
action that we are prepared to fail.  If we had an easy way to
squelch only one class of errors (e.g. the resource no longer exists
at the URI) while allowing others to pass (e.g. we downloaded but it
was corrupt), that might be even better when somebody is debugging
the thing, but to an end user, it is a hopefully ignorable failure
either way, as long as there are other alternatives in the set of
bundles in the "any" mode.
