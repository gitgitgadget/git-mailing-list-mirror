Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AC0C433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 01:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbiDSBeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 21:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiDSBeB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 21:34:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA25A1E3F7
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 18:31:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id x3so9692151wmj.5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 18:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=b4Wr9fIacD6l7/OynwA+OakBbWDqSZ89SSU1NMyE6dQ=;
        b=He5fATv6lUr1KpbXdDIeJwPRa64ITnfpHF8AlE9oB9fSUeGjexSzmK2wfjZBcZjo9V
         KCYSy4kDFrn85FaOTk2UeA1JrtSLnl3wGyQpxrA0vYyvI45pgk/oXV8jIrCbKyw2O5s4
         6X02lr509ZfnZX76ixr/TfBu6I6TkAdU+OBx69LCJ0ZZjXLiZkeI40C8LL5rzs6T5fPp
         hwJN8Tfz6IFlLgM7/1IztrYNkP3uOzhTCV6VGcv4wl+N+ikjJ3PKMFsQX3TMK27J5yUy
         hlp6QaztnmYcgbmMKTSHTeiM0GgBBd+K6zntP7gbnVZUFlbJrd7ndHQNxLq6E0MIFXTD
         mizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b4Wr9fIacD6l7/OynwA+OakBbWDqSZ89SSU1NMyE6dQ=;
        b=7InK7zVsTC8SLewM8/oO5YLNbIwdDUN9Y6X/WYRbWvtIEQQ+eH2QvVOM6bnF9Uw9z1
         PJsJ7Xi9oqXw7AD/+55zyZ+fbXT6w0hdlPt25HEF4YLDWHVGkeEUKTs05uYKGBCSwec2
         KImM4BMFdIulfNPPu6zpovxF+ncfqlWwFLjkppuj93M8BqOPsIGHSh5RXl4ZtCuNPbw/
         2qH3hZK/kQUot8KY9V4qTXbgVtGkw0XmCBYJv1eF5Fo9nm2gfuKig2FfI+UY8sapBsyK
         GiohDWTJ69b0jMQEibybZi4calFMpq7+0Sq3JUHCsW9pImlo1knBNkH2byzloG5eCg1f
         Ez0A==
X-Gm-Message-State: AOAM532VCIJYcl+Rpaj8dVP71l1+TZBnQuLRowRsnS10alZK3BDlaxZw
        9li0rQ6g0pAmJEoZwRF59SPmqYLaph0=
X-Google-Smtp-Source: ABdhPJxjOjX01w9CTwn6p0CW//kcdSe/AxQBwddj78Jfqbwe+tHU7/vR8dQNTK3NbCJ2yZtzIH2lYA==
X-Received: by 2002:a05:600c:1584:b0:38e:c80e:b8b5 with SMTP id r4-20020a05600c158400b0038ec80eb8b5mr17373987wmf.99.1650331878154;
        Mon, 18 Apr 2022 18:31:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg8-20020a05600c3c8800b0038e4c5967besm15343510wmb.3.2022.04.18.18.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 18:31:17 -0700 (PDT)
Message-Id: <pull.1220.git.1650331876.gitgitgadget@gmail.com>
From:   "Jack McGuinness via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Apr 2022 01:31:13 +0000
Subject: [PATCH 0/3] [GSoC][Patch] area: t4202-log.sh, modernizing test script
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jack McGuinness <jmcguinness2@ucmerced.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am using this thread to redo my previous attempt to modernize, where I
mistakenly replaced spaces with tabs incorrectly, and to complete the rest
of the modernization of t4202. I am really new to gitgitgadget, and
contributing to open source in general, so I expect I will mess up again,
but hopefully I can get manage to get through it when i do.

Thank you Derrick Stolee for reviewing my last patch, it's clear I still
have a lot of work to do on understanding style and bash scripting. Thanks
for checking this, -Jack McGuinness jmcguinness2@ucmerced.edu

Jack McGuinness (3):
  [GSoC][Patch] area: t4202-log.sh, modernizing test script
  [GSoC][Patch] area: t4202-log.sh, modernizing test script p2
  [GSoC][Patch] area: t4202-log.sh, modernizing test script p3

 t/t4202-log.sh | 156 +++++++++++++++++++++++++------------------------
 1 file changed, 80 insertions(+), 76 deletions(-)


base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1220%2FJackMcGu%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1220/JackMcGu/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1220
-- 
gitgitgadget
