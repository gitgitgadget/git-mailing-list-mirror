Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A99C32771
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 02:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbiHQCs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 22:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbiHQCsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 22:48:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E0E13F94
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 19:48:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bs25so14692172wrb.2
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 19:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=MbomNopfmmQD1Y47Qi8oi7a5HLe3dwvWvXksjapybgo=;
        b=SoQy94lAMnOVYcV3fepPgnsuMfF2lTNmfqKJrKzdU44AaaClHmT8c4z/rpc8tHgJHJ
         m1MWTIJ1dAXTLBZo+qTGnh0/Y1+l4f2FRcuEZfkQJspwwo7aUdA692APlGXaYQVOeh4Y
         UvJ8WIHSYnAyakaGP5SF/O1xe9vBildc3zBth0VtWM8iPjpsV+9StjA7bdeLyNdO08Lt
         9JjXuFuhp4asmCAKAiiREsT+7C1W1FlnVShFGCGI92u2lzYRm+YACaSyCnhwIWT6Yo8h
         VQNovLeD8rZWBXvxj3bPQYumiiUeWUd9+2pgO56AO0Y2LwXA1/K/ScosT2s6luFzZp5Z
         8VeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=MbomNopfmmQD1Y47Qi8oi7a5HLe3dwvWvXksjapybgo=;
        b=VPQb7/CzJpH3WtVaqNt2+jBo8CvJcGnCaNIGiwSzO7aFbI+I4JsCqmUe5Bh4iQZMZY
         dRcTpmNXHBFJ/SoGcK/4gG+BS4NPLKw/qlHa46O7MA6jUY73QH9kZSiAIvtOi5v8rwTY
         nK65GVnulz04jx6omNHbG/STDELQPDK3olfS9nS7rAJvRFEg/1NzbcNO3LmWj8ge30Vg
         EUrwG7S+X5Vn6b2wDt7ZNn9YVumZ2/aF/N6yN0KLvY47/qj73lLfviDLJdkBQfkkCXLc
         9UlkEiBCQBWaVqHAWN8x/y24DoLI983VrIZ7L73A7T6ds0jRWMSs5WQQ1dY1ngi/D/1w
         6B0g==
X-Gm-Message-State: ACgBeo2pjKQMRASxp7H5MyBwGbcEtPsiGZS+nQv+mY+SD7kJVExMe5pd
        RCoUUisDIgOb5Cj10S4+2Cx4umMApiw=
X-Google-Smtp-Source: AA6agR5uSfZWay5Myv0xPimostLCC+4kyTXUWmXj4tYEk7HcW34BLXRC1bKZbNdRamelhLuZs7vJXw==
X-Received: by 2002:a05:6000:1863:b0:220:6d5f:deb5 with SMTP id d3-20020a056000186300b002206d5fdeb5mr12711863wri.470.1660704500125;
        Tue, 16 Aug 2022 19:48:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c2cd700b003a2e1883a27sm725801wmc.18.2022.08.16.19.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 19:48:19 -0700 (PDT)
Message-Id: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 02:48:16 +0000
Subject: [PATCH 0/2] Allow --ancestry-path to take an argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This came out of a previous thread[1], where I wanted to be able to run
something like

git log --oneline --ancestry-path=ab/submodule-cleanup main..seen


and see the commits in main..seen which contained ab/submodule-cleanup in
their ancestry path. Let me start by defining the terminology "X is in a
commit's ancestry path". By that, I just mean that either the commit is X,
the commit is an ancestor of X, or the commit is a descendant of X. With
that definition...

The command

git log --ancestry-path A..B


means find the commits in A..B which contain A in their ancestry path. I
sometimes still want to use A..B to get the basic range, but would like to
use a commit other than A for specifying which ancestry path is of interest.
So, for example, I might want to use

git log --ancestry-path=C A..B


to mean find the commits in A..B which contain C in their ancestry path, or
use

git log --ancestry-path=C --ancestry-path=D A..B


to mean find the commits in A..B which contain either C or D in their
ancestry path.

This series implements this request, by allowing --ancestry-path to take an
optional argument. With it, I can find the answer to my question in the
thread at [1] within the git.git repository (replacing branch names with
actual hashes since the branches have since moved on):

$ git log --oneline --ancestry-path=5b893f7d81 8168d5e9c2..ac0248bfba | wc -l
36


This returns the answer I want, whereas dropping the '=5b893f7d81' from the
command line gives me 192 unwanted commits (228 total), and various other
command line flags (--first-parent, --boundary, etc.) also fail to give me
the set of commits I am looking for.

[1]
https://lore.kernel.org/git/CABPp-BF+8aqysioP_e27Q9kJ02rE2SuSqXu+XphzKWnk5a_Q+A@mail.gmail.com/

Elijah Newren (2):
  rev-list-options.txt: fix simple typo
  revision: allow --ancestry-path to take an argument

 Documentation/rev-list-options.txt | 47 +++++++++++++----
 object.h                           |  2 +-
 revision.c                         | 83 ++++++++++++++++++++----------
 revision.h                         |  3 ++
 t/t6019-rev-list-ancestry-path.sh  | 47 ++++++++++++++++-
 5 files changed, 140 insertions(+), 42 deletions(-)


base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1303%2Fnewren%2Fancestry-path-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1303/newren/ancestry-path-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1303
-- 
gitgitgadget
