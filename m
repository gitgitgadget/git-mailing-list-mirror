Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4EEC433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 07:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355192AbiD2Hee (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 03:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346464AbiD2Hec (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 03:34:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4128B42ED
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 00:31:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e23so8042103eda.11
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuQsqfqY7ZnhMA0AY/uu+ejN6UHJ7/1imSvGp6CQDQg=;
        b=X2uTKkHq2HggWGR3SwauWmYQCwQHNuPpd15SDAGJCBs08W9JEMSjpqHYRsuiExb1hH
         CefWrRaHHb033N5hryJCY47EkOwzxf5q2DQZreCMn73FrQ0jS3kDJsRQmoDBLI0bR52U
         rzT04TZhRXfE3YNvyH4Y1ZEzb9XkXIn8vTe6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuQsqfqY7ZnhMA0AY/uu+ejN6UHJ7/1imSvGp6CQDQg=;
        b=PlaV2i5zCaY45NupR/MqECGBtEqAKnZ6JeVPp3J5JdLoMZ4zEticaD1p2r3GqmaIKh
         ra0UNQ3DzfG8tlEpwWQd/DhUWMi87keutyP27rk+K+ATwws8OgKUPYwK2PppJtqhpRuS
         fGUyPJSkiXZtk8Uhr28t6gIcXIrwX3Ro1PbD6JomWcvkMqPbYMyMoiiDtvzUI9QDBQeN
         013xYZpkYeziCgp3GiEo+GPlzlYfpRPtVgEfldZdO1djjbdR5kNtmtaMO62/vxLAaZ79
         NxFhPGQvZG5V7hsl0+/WxMsuH6xAticZDM2KtB/3aXdR/UAgCj8PCgCl+nwvAO4wMA6u
         MVWQ==
X-Gm-Message-State: AOAM533F1OUpAbDn4wWuseRrZ20tbtQS76z6cOzmo21uPzYilrfDSqF1
        +LDAdf6UHdLE/6zfLDVr1uALZ6t/3X1awIfPQQRctQ==
X-Google-Smtp-Source: ABdhPJzWuQ/SKWNUIbScMKBsBldKPkvl6lnAx9DdMXZgwj+MRXVceQt0LO+GtfY3y+tUbl6VIJeIxC/BFH9Lmm07ljM=
X-Received: by 2002:a05:6402:3508:b0:426:1b4:a2e2 with SMTP id
 b8-20020a056402350800b0042601b4a2e2mr15417985edd.387.1651217473442; Fri, 29
 Apr 2022 00:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
 <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com> <Yl2qwO0SMPOhb5h9@google.com>
 <CAPMMpogY5vZU8gyRSYh+BM4goPPtJw0cCiM-31sy-s_uGRv8uA@mail.gmail.com>
 <xmqqczhbr6pv.fsf@gitster.g> <CAPMMpohQei9vBBm=7hC=N5LPwzMCED=fZcXyePnrkLCHfCJTZw@mail.gmail.com>
 <xmqqlevzkxrf.fsf@gitster.g> <CAPMMpoiCD+fG=bs2j4Rin5Pvip9Mre9iqLcOb2LYnDQK9cuRxw@mail.gmail.com>
 <xmqqzgkddf8m.fsf@gitster.g> <CAPMMpoj+g-XFKXoAXzW4d6WZRSBO_uE6MRsw2jWUPAjqWFQt2A@mail.gmail.com>
 <xmqqv8v02yu9.fsf@gitster.g> <CAPMMpohn6+RQV=jg9fQc4nt1tK6zE38xAwejxNfGh+-4Dp_JNw@mail.gmail.com>
In-Reply-To: <CAPMMpohn6+RQV=jg9fQc4nt1tK6zE38xAwejxNfGh+-4Dp_JNw@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 29 Apr 2022 09:31:02 +0200
Message-ID: <CAPMMpoiD8KFMg2vwNNRN9ZM5tpkCTPswcknLtDsDJZ3YepnD7Q@mail.gmail.com>
Subject: Re: [PATCH v4] merge: new autosetupmerge option 'simple' for matching branches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 24, 2022 at 1:57 PM Tao Klerks <tao@klerks.biz> wrote:
>
>
> I will have another go at proposing a complete, easy-to-understand,
> easy-to-enter, "simple" workflow that emphasises local and remote
> branch "correspondence" by encouraging "branch.XXX.merge" to always
> and automatically be set to the same-name branch on the remote (and
> not any other "parent" you might have branched from when creating a
> topic branch), and a reasonable non-intrusive, non-misleading way to
> on-ramp into it.

I now have a complete proposal that I think is coherent, clear,
improves the user experience as desired, and does not interfere with
any of the existing functionality/workflows. There are a couple
niggles around naming that I'd like feedback on. I expect to submit
this new proposal today.

(nb: it's become a patch series again)
