Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B85C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 08:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A2E6109E
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 08:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbhGPIhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 04:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbhGPIhi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 04:37:38 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390ABC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 01:34:43 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hd33so13939963ejc.9
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=k8BMw0UfYCeckHf+bud17PtT0Ou0Ngd5CfOf66m+ykk=;
        b=CqZ3npublDo81itJysnLi2EUCc3UJeqxPxpsKdZ5VLcvCxVIZF9fnARmFK+LweNu73
         ZRnL/NqZ+SrypCntrbfoHDmGhoqOmP9VHkQzE9zWVjKKmBEfU+jXqtFNt+XQqPL8eozm
         rJF0UqycfzbVATsoVooMzi8UI9MJXR+gTAWppsxQ1uaMlbq20+M6J/zeixNAoacT51BM
         0WXKSPPoL1H5rptVr5AwW13+v+mZa7TAbDO5A2UEyczi2qXsfjaGbh3CZ+cxqnNzjfuJ
         ZdhypZ/24BnHk3JyjCa9wdDHzvo21TwkvcLwAhogitSsn7Efqm6UqHM5jWT2ittVGiJb
         HWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=k8BMw0UfYCeckHf+bud17PtT0Ou0Ngd5CfOf66m+ykk=;
        b=n8lW4vMfF5urZLPOIeJm9PqdzyoBDEe8pNF1fyadSc5A3Lkd1iDapvh9gCbQxWIAOk
         vg2mPkuanFwDa3G+CQvdMdly1yEeOBzEye4OJaLNZWCm/FBclUN/1eO/FM5ic8eZDRe5
         8v3KgP28u6kx+04VSSWLdDVgBoT4aUWxxfypufaQNPrsytoZVmn7/zkYQcUsxpm75kvc
         yZU/XBbwvY6lSC9oFWBpln2gtt49KNtzLMZGhHWp5yusxk7DCtFms6xniV8q2W03cPCx
         yLhRXz1tcwIQHAdfIr1SHUpOJ4qtm8oB8Ou+/UOy51xomhcy+1KogLJqCCAcX9wHcRKP
         GJQw==
X-Gm-Message-State: AOAM531k6wtXU6iEvZ2FOHfUy0lR2UzqGZiBdY8+Wx6NzuuZtex8vNa8
        6NM9qgq1mvtVTHym+84W9YGgtNDIwJs=
X-Google-Smtp-Source: ABdhPJxVtMFppeUXYGcYBInzD7hdp4cPUWmhpRu9s+FEF3RL2JfBbHgHuygC1AdvsT9rJ52cU20KsQ==
X-Received: by 2002:a17:907:62a7:: with SMTP id nd39mr10631553ejc.502.1626424480274;
        Fri, 16 Jul 2021 01:34:40 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w2sm3396807edx.58.2021.07.16.01.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:34:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/9] hook: allow out-of-repo 'git hook' invocations
Date:   Fri, 16 Jul 2021 10:33:25 +0200
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-8-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210715232603.3415111-8-emilyshaffer@google.com>
Message-ID: <87tukuy7vc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 15 2021, Emily Shaffer wrote:

> Since hooks can now be supplied via the config, and a config can be
> present without a gitdir via the global and system configs, we can start
> to allow 'git hook run' to occur without a gitdir. This enables us to do
> things like run sendemail-validate hooks when running 'git send-email'
> from a nongit directory.
>
> It still doesn't make sense to look for hooks in the hookdir in nongit
> repos, though, as there is no hookdir.

Hrm, I haven't tested but re the discussion we had about
RUN_SETUP_GENTLY on my re-rolled base topic is this really just a
regression in my changes there?

I.e. I assumed we could do RUN_SETUP for the bug-for-bug compatibility
step, but send-email runs out of repo hooks and we just didn't have
tests for it, or am I missing something?
