Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3687EB64DD
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 05:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjHEFEr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 01:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEFEo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 01:04:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EDE11B
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 22:04:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so26083475e9.0
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 22:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691211881; x=1691816681;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e2v9jdaYrK0c4YNaRRzgKiQc8QXutZiUOYMx6d64gkU=;
        b=fFFKtF4v1GzOy5m0bGcdh2yHiEj7kgv5tMcpX4XC3cv9s51ftS918k0MAIiIqVUpZh
         lEcJWR4LAyfJqPzlYLh4Jfcl5vs66R8gsjsCC6XxATU21AF3UOJ+5kh+DRdCXh5GhQQh
         SKF1mJnRNUooKip+UoxfmTZSS1Rk/d0NiqiBEXlRzJE0yYrA+rjS5KcXEQtp3YbXyCu2
         WsilZF6PqnNYnOh3MGzRnn094dphWWsRQF+JPtltMuebAFmZr5XgK7UVpdQcTb2mJCdY
         mvWdMq85ocMsFOB8ByFrsfDrdvlN1MPW2il9gycbx6N+BRhee9Q+ZCFwumvm2lysYC06
         U61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691211881; x=1691816681;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2v9jdaYrK0c4YNaRRzgKiQc8QXutZiUOYMx6d64gkU=;
        b=RaJGOos5PPAuYMvV2tangfMURtX4Z4Y3Zv6FgOCVyLq6AujUhBWMOYUENCcVaBrLY4
         9ct5LxURzn4Po+5eUh4ZG1Nu5hrQyJeOxumGnJdX0fNnkoP/KfosbdQsXg54lmuOE+CV
         77Do6om5XJP1Oo3Wmwpxwt4DekALhNgXiB7ZwL6y/4/mbbI/Cveg2MDrM17wLLyy+n7d
         0bnLRIOXVSbRwe5qip0fcIA0nR4Bj3qLXuIddbkrnoBdmRMrs191QDES3NSllTikr5pe
         i10bAKH0m3Qyun+L39yq5BLPTkgEOwSF5SdpP3Y43I4DwvwsZZx+XftR5M0CdT/RQlel
         iS7g==
X-Gm-Message-State: AOJu0Yz2EfmyA7CZw8QFbpVhgMnQsST7aTN8dK+IMHyKm6isKbcxLNF7
        UVZeTW8/rByobWUg0HA45P0/0E8lheQ=
X-Google-Smtp-Source: AGHT+IHjKdMQN+U7GvzzvUXs2BqngM30D6rhBX0ZzaD0gSl4cWrxM0VnNvcrCFz102HeBaNPO/4pRA==
X-Received: by 2002:a7b:cd8b:0:b0:3fc:a5:2c3a with SMTP id y11-20020a7bcd8b000000b003fc00a52c3amr2767330wmj.41.1691211880862;
        Fri, 04 Aug 2023 22:04:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c1d1300b003fe4e1c5bcfsm469524wms.0.2023.08.04.22.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 22:04:40 -0700 (PDT)
Message-ID: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Aug 2023 05:04:34 +0000
Subject: [PATCH 0/5] Trailer readability cleanups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches were created while digging into the trailer code to better
understand how it works, in preparation for making the trailer.{c,h} files
as small as possible to make them available as a library for external users.
This series was originally created as part of [1], but are sent here
separately because the changes here are arguably more subjective in nature.
I think Patch 1 is the most important in this series. The others can wait,
if folks are opposed to adding them on their own merits at this point in
time.

These patches do not add or change any features. Instead, their goal is to
make the code easier to understand for new contributors (like myself), by
making various cleanups and improvements. Ultimately, my hope is that with
such cleanups, we are better positioned to make larger changes (especially
the broader libification effort, as in "Introduce Git Standard Library"
[2]).

Patch 1 was inspired by 576de3d956 (unpack_trees: start splitting internal
fields from public API, 2023-02-27) [3], and is in preparation for a
libification effort in the future around the trailer code. Independent of
libification, it still makes sense to discourage callers from peeking into
these trailer-internal fields.

Patches 2-3 aim to make some functions do a little less multitasking.

Patch 4 makes the find_patch_start function care about the "--no-divider"
option, because it that option matters for determining the start of the
"patch part" of the input.

Patch 5 is a renaming change to reduce overloaded language in the codebase.
It is inspired by 229d6ab6bf (doc: trailer: examples: avoid the word
"message" by itself, 2023-06-15) [4], which did a similar thing for the
interpret-trailers documentation.

[1]
https://lore.kernel.org/git/pull.1564.git.1691210737.gitgitgadget@gmail.com/T/#mb044012670663d8eb7a548924bbcc933bef116de
[2]
https://lore.kernel.org/git/20230627195251.1973421-1-calvinwan@google.com/
[3]
https://lore.kernel.org/git/pull.1149.git.1677143700.gitgitgadget@gmail.com/
[4]
https://lore.kernel.org/git/6b4cb31b17077181a311ca87e82464a1e2ad67dd.1686797630.git.gitgitgadget@gmail.com/

Linus Arver (5):
  trailer: separate public from internal portion of trailer_iterator
  trailer: split process_input_file into separate pieces
  trailer: split process_command_line_args into separate functions
  trailer: teach find_patch_start about --no-divider
  trailer: rename *_DEFAULT enums to *_UNSPECIFIED

 trailer.c | 113 ++++++++++++++++++++++++++++++------------------------
 trailer.h |  12 +++---
 2 files changed, 69 insertions(+), 56 deletions(-)


base-commit: 1b0a5129563ebe720330fdc8f5c6843d27641137
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1563%2Flistx%2Ftrailer-libification-prep-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1563/listx/trailer-libification-prep-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1563
-- 
gitgitgadget
