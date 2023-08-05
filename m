Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74514EB64DD
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 04:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjHEEpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 00:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHEEpm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 00:45:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205BF468C
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 21:45:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so26449695e9.2
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 21:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691210739; x=1691815539;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzn8DcNt+JzKDqr2HfQ7vrEayEi7eKHFmZ91Q0RJ2UY=;
        b=CU5jIjAEI95ohI2G0tZLRinJxMMutbg6ncVT7TjZwss2ZSkgj1Pa5BU0OjKoRBWeTH
         VBye71Daxv2VI/g52BDpBAcLge/xnM86bCjA7qdofX84GdgqRTcXPt6hRyD8zNXnaoxj
         3jWMa020QDJOi0HIhavNb4Z65h1wjA49ansSkfLOHf1OJh8JZsAvDYe/sWd0dHrLKLdz
         PiyIKp7Tc/llW6/kJqUNfnU0nwxKOxufiNqbjA88f4KnH8DtAUtyrAPt20SVD70ucPSu
         fClF7oBYp+Oi6W7XpJiN2pxijQ2tD3zSJ5d+Xlbinu68THF6shfj5gsDJoHScV2DWlgW
         MIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691210739; x=1691815539;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xzn8DcNt+JzKDqr2HfQ7vrEayEi7eKHFmZ91Q0RJ2UY=;
        b=K7Z/PhUJ6FBrdqD2bxozoKqtDL8QWvq0lMTMZbN99aUkprfcK5DfaYaH+T+xLlfmpp
         H/NITfIMOtGa3YZofd/9i2EfS2N0J7lmi+IarjYCsh9kgAQUrwK2sacroq7WLfECLXm8
         i3SL+FsrFeQTbUNoyqi65Kz6t12Eau2SCVoUsX6/LHFnLKH1ZH639u7Xp2as+sl9Q+Tc
         dTU7nxX+mxDCW0ihQA1OwAF22t6r2L1mDncSe5T09Zq82h14E5C0SRavWRHUUCBOghIT
         Lzv+gzqVzQgAYo+tG9X/qd+ifY50QlkZ6BmEc7Yj4vsrMjXySstya43NyRotE9UrorwJ
         dc7A==
X-Gm-Message-State: AOJu0Yy3rwrXOwxN0/TsoXbNyQELWv6PlwJDYPve+MvpHGPndcStno6E
        Ms/i2didEzmcT+ORAIuh+x6ia1+9Cv8=
X-Google-Smtp-Source: AGHT+IEeB9McB0dwSvAPNpHzurD3Ic7+wM3T7JzpgpZxNP7fZ+5WENoB9dOvSbgDKJ4Q96OIYEv0tQ==
X-Received: by 2002:a1c:7715:0:b0:3fc:182:7eac with SMTP id t21-20020a1c7715000000b003fc01827eacmr2828137wmi.33.1691210739083;
        Fri, 04 Aug 2023 21:45:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c210600b003fbc0a49b57sm3970076wml.6.2023.08.04.21.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 21:45:38 -0700 (PDT)
Message-ID: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Aug 2023 04:45:32 +0000
Subject: [PATCH 0/5] Fixes to trailer test script, help text, and documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series contains various fixes to the trailer code. They pertain to
fixes to the test script, the command line help text for the
interpret-trailers builtin, and the documentation.

Patch 1 is the biggest one, but also perhaps the most important as it does
cleanups in the tests where we used 'git config' in a test case without
cleaning up that state for the next test. This makes the tests
self-contained, making it easier to add new tests anywhere along the script,
without worrying about previously-set implicit state. These test cleanups
exposed lots of cases where the test cases are mutating more configuration
state than is necessary to test the specific behavior in the test; however
such extraneous configurations were not cleaned up to make these patches
easier to review (again, we are not changing any behavior and we are also
not changing what the test cases themselves purport to do).

Note that Patch 1 was originally a 22-commit series, but was squashed
together to make it easier to see the final diff for each test case. You can
see the 22-commit breakdown at
https://github.com/listx/git/tree/backup-trailer-22-commit-breakdown

Patch 3 adds some tests to check the behavior of '--no-if-exists' and
'--no-if-missing', which weren't previously tested. It also adds
similarly-themed test cases for '--no-where' which only had 1 test case for
it.

The other patches aren't as important, but are included here because I think
they are too small to include in a separate series.

Linus Arver (5):
  trailer tests: make test cases self-contained
  trailer test description: this tests --where=after, not --where=before
  trailer: add tests to check defaulting behavior with --no-* flags
  trailer: trailer location is a place, not an action
  trailer --no-divider help: describe usual "---" meaning

 Documentation/git-interpret-trailers.txt |  14 +-
 builtin/interpret-trailers.c             |   4 +-
 t/t7513-interpret-trailers.sh            | 506 +++++++++++++++++++----
 3 files changed, 443 insertions(+), 81 deletions(-)


base-commit: 1b0a5129563ebe720330fdc8f5c6843d27641137
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1564%2Flistx%2Ftrailer-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1564/listx/trailer-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1564
-- 
gitgitgadget
