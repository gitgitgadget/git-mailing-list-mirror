Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A20AC04AA5
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 21:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbiHXVV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiHXVV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 17:21:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEAE165B7
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:21:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bs25so22294667wrb.2
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Od1kbTidoOdNpH0yOTDDO7vO4r9QtkStjTB2a95SYxc=;
        b=nys0il+rSoIDWOzpQxVlNE5tTlhE3xmQ5hjzbG9p4Co1A7lbCJL+6D4zZNoB52agnB
         +plzVxBEQE8/3A+PmQn0qVts//HZwbN/ithQ8/fag8AvBSy+aCZ/tUNWYA0WovkeX7Oi
         7Aj0b8QS3H0BlgcRXN59n9dz85Fz2XxSwAjLqvAQZWr44vAANCouoalOs8931J9x8q02
         NCzzQE3RgZ1qMQt36NXA6gBTR2TKZjT6DGulEpup1K5y4MgDB/Krf5sEi4J/D4jBfxJl
         MAf9Vb3vCt/rucmCDBSS9TGFQ7GYz3xNg7Truo8/LAxz3eJUZYkntBz4NHtlo1jiBnW5
         uMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Od1kbTidoOdNpH0yOTDDO7vO4r9QtkStjTB2a95SYxc=;
        b=OpJmP66m3zfyI2PhzR2vtuNbAb756vBCYmtw0NOTshyjDFbG6re1Z+8S4Ov1dZ4eag
         Tr6qSLhdVw+FcE5/PC1A2pE8BwtSUPGUdAqnGwiDB1tbf1S6NYIk5LLJiUV9eKdkbWVl
         PIojMuEhusWlDwqdPsEi6qAxCENZRulvDq/4giYa2JOv2wyTsxGq9MaZLudVNPJpt0EL
         fnYSjUTjbEubChKIchk+MeFze69IpYVfiifdNr6LvLgUBdaAmb6yNSnXH7lhFD/Tx97G
         HE2ZwLmHHyrzOmmm+XrVJl1unoOI3SFQDj1GM+4MVSz0Lmcnh4Fumpt0LzTD8KOjTssA
         5Sqw==
X-Gm-Message-State: ACgBeo2Z/uVvcjeWBe+VRp0OGLJXkbxOtS+lzuUbpDoQKWVZzIfBb2+y
        Hra/LthNob3bfVA0b6G2IoMYoUdWi3Y=
X-Google-Smtp-Source: AA6agR5dnTz5A7r3U3vR1IIAdF4umsnt2bPTq+0IAW45OQ90wDL/ltzopf9tmfxtDlwjlXL8XQ6guA==
X-Received: by 2002:a5d:6712:0:b0:225:337c:3889 with SMTP id o18-20020a5d6712000000b00225337c3889mr512479wru.59.1661376113131;
        Wed, 24 Aug 2022 14:21:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b003a1980d55c4sm2994515wmq.47.2022.08.24.14.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:21:52 -0700 (PDT)
Message-Id: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Aug 2022 21:21:47 +0000
Subject: [PATCH v2 0/4] built-in add -p: support diff-so-fancy better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain reported in
https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com
that there is a problem when running the built-in version of git add -p with
diff-so-fancy [https://github.com/so-fancy/diff-so-fancy] as diff colorizer.
The symptom is this:

    error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ file:1 @?[1m?[0m'


This patch series addresses that and should fix
https://github.com/so-fancy/diff-so-fancy/issues/437

Changes since v1:

 * Added a commit to ignore dirty submodules just like the Perl version
   does.

Johannes Schindelin (4):
  t3701: redefine what is "bogus" output of a diff filter
  add -p: gracefully ignore unparseable hunk headers in colored diffs
  add -p: handle `diff-so-fancy`'s hunk headers better
  add -p: ignore dirty submodules

 add-patch.c                | 24 ++++++++++++++----------
 t/t3701-add-interactive.sh | 24 +++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 11 deletions(-)


base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1336%2Fdscho%2Fdiff-so-fancy-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1336/dscho/diff-so-fancy-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1336

Range-diff vs v1:

 1:  74ab50eeb1c = 1:  74ab50eeb1c t3701: redefine what is "bogus" output of a diff filter
 2:  b07f85a0359 = 2:  b07f85a0359 add -p: gracefully ignore unparseable hunk headers in colored diffs
 3:  9dac9f74d2e = 3:  9dac9f74d2e add -p: handle `diff-so-fancy`'s hunk headers better
 -:  ----------- > 4:  540ce27c38a add -p: ignore dirty submodules

-- 
gitgitgadget
