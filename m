Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2053EB64DA
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 22:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjFMWKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFMWKh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 18:10:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B58D2691
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 15:10:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56cd82e48bfso794027b3.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686694186; x=1689286186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bzPO/smfbA0h/4/GMk8tnQRXtk/Dd4hEyXCnXnPKlT0=;
        b=A4nFxMwNRD+n7JLW7MJLg6yoJ06rCMXG/XtGf7VlzDZ3zLc1vsLDm88ViduvtJ7J9e
         tlmwH/Vw3G32yLtEBY564sqBgWCtJt+93ipsuzKeJRdc7EpiHlGsN3AROVBCpYqADMgI
         lxgLPZqkMcj/hhtQvQfpJRLCAPyGcale2Q7l69jgbLOVekHmklFUXI0KdOitESgJGD4g
         xF3yiUL2YYxa7sfndEeCoYpJZZIBR/Qexad3sRjcJZ3E0vWjgwm3z8kQoUa1j4Gr3FbF
         ZZHaAv4+IbKArTCHojXBkaz/sHp93fBLxMR+eAeGcHvuu1vOw5HRMO7odcoH0j8iq/zJ
         MqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686694186; x=1689286186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzPO/smfbA0h/4/GMk8tnQRXtk/Dd4hEyXCnXnPKlT0=;
        b=YzdZgmQs+QGmUASMAdzVOnKCRGagk+3LouGQJB429nvBFpZ2fEElld61D/+kmK2vVY
         vKfSq1KzSjRLVOwe1GAkrnyA4GnQQUIsKsq5Wund8D0brC/yn/lwo47VQFqrh4VJRnaX
         whr0QyTyr9MTBfFtFvaxOSvrEHAiCwBqGHF5FL3cMUEoJFN1BRu9ZOlZUUE4BrxnOAPq
         K7dUwVHF4wNsVE/QSjC5917Oxtw0+E8ZyNj1m0wgBKcYCE3CvzqTnuVrNM1T2wXUZii0
         E4LpNGiLoHnCQVJwPIqgudTlZEEhvol1l/mzUlV+NO5X0n+b3mo8unkjufTWpYbPiunS
         1w2Q==
X-Gm-Message-State: AC+VfDwN9LFxUkyLBy9XHwvYxs0/mRsDTpAlW+46V1TXLJqHv7AhLc12
        f5I3w1Is7U43B6ywJKbPfSSu62y0pqgdSg==
X-Google-Smtp-Source: ACHHUZ6nxDTe/fBRtY8YZMzl7iOsLNPZxqxEvUtwnjNW5fnw7W0Iitsn/fnpGTU7r5fXyVF+3ru1t61LydvkwA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:abc3:0:b0:bd6:776a:eaa9 with SMTP id
 v61-20020a25abc3000000b00bd6776aeaa9mr233445ybi.2.1686694186036; Tue, 13 Jun
 2023 15:09:46 -0700 (PDT)
Date:   Tue, 13 Jun 2023 15:09:43 -0700
In-Reply-To: <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com> <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
Message-ID: <kl6lfs6v815k.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 0/3] Fix behavior of worktree config in submodules
From:   Glen Choo <chooglen@google.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * Added a commit to move 'struct repository' out of 'git_config_source',
>    rather than creating a dummy 'config_source' just to hold a repository
>    instance.
>  * Changed the config setting in the new tests from 'feature.experimental'
>    to 'index.sparse' to tie these changes to their intended use case.
>  * "super project" -> "superproject"

Thanks! Discounting the discussions on the side thread (which we've
decided are mostly out of scope) I think this version is good enough to
merge as-is.

In

  https://lore.kernel.org/git/kl6llegnfccw.fsf@chooglen-macbookpro.roam.corp.google.com

I said that this series is better if we squash in a patch to drop the
setup code from discover_git_directory(), but on hindsight, I think it
also makes perfect sense for me to send that as a standalone patch. Let
me know if you plan to squash it in or not so I'll know whether to send
it :)
