Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC4AECAAD8
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 06:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiHaGVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 02:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiHaGVx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 02:21:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4867D7F0A2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 23:21:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b16so9237640wru.7
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 23:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=IGPr71XZSn2shdlpJK9v+Wp0xAoNu52E34uwWtVY04A=;
        b=Jz9pzNQtxJ76sTgZA0jmUhtIf56y6tEV5LO+Ntb6EdC9fLk28Goj9fcmiDE3O9y7ft
         pr0vNizl97VqAipeICaogFxkQbMbhAQc+rujPjqXSixdmBqSMvog5YENOpWqQD+2iykk
         IR4yfhOX1+soSny65P9rOH95BnbiSEihdqhP/R2ShrUdOO9EwD841zvZ3AVVchUnDR3Z
         QtbReCjUDVW2cYHQnI3LOhJ4ZOj+1qi1FZZ4fqIynCLwtbjxb+3y1dJrZblJZA1Vja02
         RJSo3yxOKADBnYpu068i3JiLegH4M3Xwe/UvtR8vplOSMYDulk1Zy5vTxBmgtbimqEZU
         VcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=IGPr71XZSn2shdlpJK9v+Wp0xAoNu52E34uwWtVY04A=;
        b=kYYftLTzAWGVDNZ9Da52rWst1zChEBpFTsSd1AH58KzTduXzCvNu40QicMpHX7gNGA
         vcrvDQdMUa2nJXGagI+zq+izZtBrJINDvFx+UxClNei1bOjnVRQ++6rN798mpySVPvkx
         psjgBzAmIuzGnyuro/n3knpD8C9oICAzsjaOJ7Z1Di7Bxn3GOiDjU8U9SEksUj7zEjLu
         KJJLsvgyMVwUsSL5O041LkPh2grwnXwIYWXNpMagkxEH0YXay3neaPsq5+ufcgjN8App
         jL0oSb+GvlyYLDQn5YHKJWgCVsoK8uChEncvx4m8j2dML2PB1s0pSjGlYoIqWVqmh/rZ
         envQ==
X-Gm-Message-State: ACgBeo25VyVwOgbWkjNfYZeb3Sl3Tw74Jlau9DeHYwTE1lxrdNwNTY8+
        2+7CBhl1FGY+68PzcjsDmUs/hthhrl0=
X-Google-Smtp-Source: AA6agR7vpy1GBjqpiRDKxLnNZZPn5hjJZt2UEhoPbADLJvUzBNQs2hXoNlZJ5krAhpVfU5m6TyOMow==
X-Received: by 2002:a5d:4302:0:b0:225:5303:39e5 with SMTP id h2-20020a5d4302000000b00225530339e5mr11090472wrq.380.1661926910575;
        Tue, 30 Aug 2022 23:21:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9-20020adfe9c9000000b0022586045c89sm11685643wrn.69.2022.08.30.23.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 23:21:49 -0700 (PDT)
Message-Id: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 06:21:45 +0000
Subject: [PATCH 0/3] Output fixes for --remerge-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain found and reported a couple issues with the output of
--remerge-diff[1]. After digging in, I think one of them actually counts as
two separate issues, so here's a series with three patches to fix these
issues. Each includes testcases to keep us from regressing.

Note: The issue fixed by the third commit for --remerge-diff is also an
issue exhibited by 'git log --cc $FILTER_RULES $COMMIT' (or by -c instead of
--cc). However, as far as I can tell the causes are different and come from
separate codepaths; this series focuses on --remerge-diff and hence makes no
attempt to fix independent (even if similar) --cc or -c issues.

[1]
https://lore.kernel.org/git/43cf2a1d-058a-fd79-befe-7d9bc62581ed@gmail.com/

Elijah Newren (3):
  diff: have submodule_format logic avoid additional diff headers
  diff: fix filtering of additional headers under --remerge-diff
  diff: fix filtering of merge commits under --remerge-diff

 diff.c                  |  9 +++++++--
 t/t4069-remerge-diff.sh | 30 +++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 3 deletions(-)


base-commit: 6c8e4ee870332d11e4bba84901654b355a9ff016
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1342%2Fnewren%2Fremerge-diff-output-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1342/newren/remerge-diff-output-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1342
-- 
gitgitgadget
