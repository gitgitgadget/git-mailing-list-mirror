Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C69C433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 16:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF79660EE9
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 16:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhIRQEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 12:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbhIRQEA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 12:04:00 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EE8C061757
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 09:02:36 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id s20so7542788ioa.4
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tYY+HQuXJr8RAuykAVitdnBM9t4kpwQb6UJgRpbUxlk=;
        b=VrhiYi+w9m15A26StHUENF385ytDP5fAh9943OJ21o0ObyYYy57ae+0D9TAQ/7uKhK
         uImTHBGu02DdHG77qCGtzt6/42IdMsIjqFd77Y6BRIOh/5YEYto0FJmqEvWdLF/mxGUF
         63In1m0sJYqS/iaPozAZemjYvDkdqa2GHoKPEb0P5yh4WLQygG41Sn8KDr0X2HrNi5Zw
         7FkeBIBUYBVur7rQ39nlzVmt3GaTm+Q9x0ravnLnIo75YTcQ/zsISTbYDWL/gyLRzQlr
         +gU2ojwk/yR+9l0XbvrU4op61kPtLpgaONcxw2AOLP3nCqiLZPYaPiVoR7EZsjqfh2tv
         QAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tYY+HQuXJr8RAuykAVitdnBM9t4kpwQb6UJgRpbUxlk=;
        b=LxIZ1V5EkMnzvNZ46J6VLIvfM2edwSF3n/yIuUm+297Hm3vGzszM0200BZc1bSpeAE
         xh4DxCdfJw406uu/B2iJFBmt54RGk9zkIKTVJp7g+CQS78iucPdXxAlmCJTPROQ6GVDF
         Cl+aHxP+F/Zpm49zI6J3N29RGI9lfaE5kFRlrizDg/l5JBlMlQycF7Askc7aAg61TSns
         fv8g3eV043JWRIzOgucygbd7f1oUBQ0qnu8JnL1qaINSh87ZTA0P82ixGDOUALw7IVbQ
         tDjrXUyyikOnuHmK11qbxAqc0WbDEdr+bV9X/DQgccu5gblXEdzLUbh9HUKiCVz+10m2
         PMeQ==
X-Gm-Message-State: AOAM533QlgFX869c2tgDjKiHeut12HF2YjQ6wAn6K+Zw+uzqdxy3UR1G
        2rTJ0z3r0Vjdi/nQRO6y9i01HaWHByBAxcGg
X-Google-Smtp-Source: ABdhPJyLbDn0E1umGccDZZg0yYhxMGSFfZgP8pNRItM2O6Sn98j0nAsiLumOR1Hqklp07gVvRnn3mQ==
X-Received: by 2002:a5d:9c53:: with SMTP id 19mr12443510iof.192.1631980955679;
        Sat, 18 Sep 2021 09:02:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f14sm3225030ilk.29.2021.09.18.09.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 09:02:35 -0700 (PDT)
Date:   Sat, 18 Sep 2021 12:02:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, szeder.dev@gmail.com, avarab@gmail.com,
        dstolee@microsoft.com
Subject: [PATCH 0/1] commit-graph: drop top-level --[no-]progress
Message-ID: <cover.1631980949.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch provides one way to fix an issue that SZEDER described in [1]. The
issue is that `git commit-graph` began accepting `--[no-]progress` as a
top-level argument as an unintentional side-effect of 84e4484f12 (commit-graph:
use parse_options_concat(), 2021-08-23).

Some discussion beginning at [2] indicates a couple of reasons why this is
undesirable, and they are summarized in the patch below.

But most importantly, if we do want to get rid of the top-level
`--[no-]progress`, then we should act quickly to do it before 84e4484f12 (which
currently isn't tagged) is released.

An open question is whether the same should be done for the multi-pack-index
command, whose top-level support for `--[no-]progress` was released in v2.32.0
with 60ca94769c (builtin/multi-pack-index.c: split sub-commands, 2021-03-30).

[1]: https://lore.kernel.org/git/20210917211337.GC2118053@szeder.dev/
[2]: https://lore.kernel.org/git/YUUQzswYL5x74Tps@coredump.intra.peff.net/

Taylor Blau (1):
  builtin/commit-graph.c: don't accept common --[no-]progress

 builtin/commit-graph.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.33.0.96.g73915697e6
