Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35972C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 19:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiKHTIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKHTIh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 14:08:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FC11A3B9
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 11:08:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso12356111wme.5
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 11:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=on/4vP0p+r5K/3ZgVEnHnYbYbOC4LbqGAnITk1yDRD4=;
        b=QrlB0NSsqDXqgO1HdWEIn8Lls84QEGu04NMfiXqU0lr9Mhey8o4PUOCLJUUi2VADIi
         2hF0LIg3TldjiZebkKH2ysITVKt7dPBtLUHrH5PannJN5IawpLFCxZeKCPg20JuHKyQ5
         8zvPVDQqo1vfIRgmnfNw6zWcQL6mpUL1wGoqLrIjrr92YkPnz80RUnRfjrPHxHxtoWX5
         5pCFNmyrP9TGG9dMN/hatO0jgsEByge0ynKNhBuD/69TvEQBL0lHyxy1BJTgGn7REslV
         xinwaejZpJ1Qc9/9LmgO/8lOlIZUACE58x2zaOB+BcwtQHlQWMWaY6a8n9azo5gvtf9J
         nMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=on/4vP0p+r5K/3ZgVEnHnYbYbOC4LbqGAnITk1yDRD4=;
        b=WppbxMaMrGs1ovjMdDSNyp+vgNbWF96KRvEGYgLQMOkDhRYcGQGHWrFb7lXhB8rOk+
         asgSkvXSJULwOWBJ5pSHIxf/6yplVC+W1TflR/IHzmMsKCHOCq2MImCbboIDKq0GDs45
         uv+sq+88Z4jep+s14mSRwgRQTjaqMoK2X7GqkDGuwaImBsrI+CJziv/Nuh2E0kfvtkqr
         MghdGHqXuGaF549D3wakTvyeye5X1HzX0ScseM7F0119/D947ZcbeCRgRnR7UhBvEmyd
         SWhia2A9FWEZzGk/zKY0I0EezFyIOebq4tfZeB0f1a0T3UO8k2cS7UH3kk3ZfD8eFjmN
         XUTQ==
X-Gm-Message-State: ACrzQf2qUewgdXb4Wlu29F+xdkf3j2MS41Jk1P3cSWhSRH60C7lARX5x
        G9SGMWJ0rOQfbS3cRnLw+J/IyInvwgo=
X-Google-Smtp-Source: AMsMyM59N758Q2261JJrg/uxXWZDKQ66rzNaOB8Ya2d/971q3LDCe+IemMCckIzobjGil5uP4/Rgqw==
X-Received: by 2002:a05:600c:24c:b0:3cf:6ab3:49a4 with SMTP id 12-20020a05600c024c00b003cf6ab349a4mr34506192wmj.10.1667934511403;
        Tue, 08 Nov 2022 11:08:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2-20020a7bcb42000000b003cf4ec90938sm12077475wmj.21.2022.11.08.11.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:08:31 -0800 (PST)
Message-Id: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Nov 2022 19:08:26 +0000
Subject: [PATCH 0/4] chainlint: improve annotated output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When chainlint detects problems in a test, such as a broken &&-chain, it
prints out the test with "?!FOO?!" annotations inserted at each problem
location. However, rather than annotating the original test definition, it
instead dumps out a parsed token representation of the test. Since it lacks
comments, indentation, here-doc bodies, and so forth, this tokenized
representation can be difficult for the test author to digest and relate
back to the original test definition.

An earlier patch series[1] improved the output somewhat by colorizing the
"?!FOO?!" annotations and the "# chainlint:" lines, but the output can still
be difficult to digest.

This patch series further improves the output by instead making chainlint.pl
annotate the original test definition rather than the parsed token stream,
thus preserving indentation (and whitespace, in general), here-doc bodies,
etc., which should make it easier for a test author to relate each problem
back to the source.

This series was inspired by usability comments from Peff[2] and Ævar[3] and
a bit of discussion which followed[4][5].

(Note to self: Add Ævar to nerd-snipe blacklist alongside Peff.)

FOOTNOTES

[1]
https://lore.kernel.org/git/pull.1324.v2.git.git.1663041707260.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/Yx1x5lme2SGBjfia@coredump.intra.peff.net/
[3] https://lore.kernel.org/git/221024.865yg9ecsx.gmgdl@evledraar.gmail.com/
[4]
https://lore.kernel.org/git/CAPig+cRJVn-mbA6-jOmNfDJtK_nX4ZTw+OcNShvvz8zcQYbCHQ@mail.gmail.com/
[5]
https://lore.kernel.org/git/CAPig+cT=cWYT6kicNWT+6RxfiKKMyVz72H3_9kwkF-f4Vuoe1w@mail.gmail.com/

Eric Sunshine (4):
  chainlint: add explanatory comments
  chainlint: tighten accuracy when consuming input stream
  chainlint: latch start/end position of each token
  chainlint: annotate original test definition rather than token stream

 t/chainlint.pl                                | 107 +++++++++++-------
 t/chainlint/block-comment.expect              |   2 +
 t/chainlint/case-comment.expect               |   3 +
 t/chainlint/close-subshell.expect             |   3 +-
 t/chainlint/comment.expect                    |   4 +
 t/chainlint/double-here-doc.expect            |  14 ++-
 t/chainlint/empty-here-doc.expect             |   3 +-
 t/chainlint/for-loop.expect                   |   4 +-
 t/chainlint/here-doc-close-subshell.expect    |   4 +-
 t/chainlint/here-doc-indent-operator.expect   |  10 +-
 .../here-doc-multi-line-command-subst.expect  |   5 +-
 t/chainlint/here-doc-multi-line-string.expect |   4 +-
 t/chainlint/here-doc.expect                   |  24 +++-
 t/chainlint/if-then-else.expect               |   4 +-
 t/chainlint/incomplete-line.expect            |  10 +-
 t/chainlint/inline-comment.expect             |   4 +-
 t/chainlint/loop-detect-status.expect         |   2 +-
 t/chainlint/nested-here-doc.expect            |  27 ++++-
 t/chainlint/nested-subshell-comment.expect    |   2 +
 t/chainlint/subshell-here-doc.expect          |  28 ++++-
 t/chainlint/t7900-subtree.expect              |   4 +
 t/chainlint/while-loop.expect                 |   4 +-
 22 files changed, 206 insertions(+), 66 deletions(-)


base-commit: 63bba4fdd86d80ef061c449daa97a981a9be0792
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1375%2Fsunshineco%2Fchainlintpreserve-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1375/sunshineco/chainlintpreserve-v1
Pull-Request: https://github.com/git/git/pull/1375
-- 
gitgitgadget
