Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F6DEE14D8
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 06:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjIZGXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 02:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjIZGXE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 02:23:04 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBC8E6
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 23:22:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9338e4695so133130241fa.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 23:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695709375; x=1696314175; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceA0TI3jP9gOpFTmi76WbT/7/j3QjlLxAcPW0ad0NOY=;
        b=IwJACPaxGs85USuZkhmdmUp3+sx3WhCcqmxKpSt2VGMvmuQ1Vr3MXo1aS0f2iciaXo
         vMMqJ20RWI/RgJs89+7SsHzb98dC1y9RI7ZdcgGpvzeyUXELBoXUJqAbl6koJPIbpaLP
         j4Z4AXUZM6Eoi0iIUZajHsFZaAbHGwNhlqjLgMXKfAaXNRE39dlsP2ku8IZ6HRmZWRnh
         wEpZy0zER8MfNwVGu4P3Wih8yYACP1gRtS0eybxv2pU1TQiw4lxMWRxZiN60aLA1C1c5
         Gkrjhnmw9doVpLd//1QycuRpUId+QUXg2+3Hb5xuP9OVEnoqUGg7KjKLybyDETP0x328
         o2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695709375; x=1696314175;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceA0TI3jP9gOpFTmi76WbT/7/j3QjlLxAcPW0ad0NOY=;
        b=J/CNRZyZ8WntEax5Ra4CSjXmDBZG30QA8jPVBTKyAXJzH4bE6ByZ5NOXAJPwbKRb6H
         bliomg7E2JEoHHEsJAeuXkpmGarR1WAi3SneiyfKJRBGQrmvVVj4e/ndPkyCdpacIlXc
         V9wslnb319/iTYH1PTbOY664xEW+l3eDj9tMsUj3rp9+FFTV7L8KQ5yXcUADplJ6EB/W
         H/lTjcYoi8lV+GIo7RP+4jaG96G5UmtWt98AvEBVq8ZPaqg944WWGjGxngeE5UUgKCuz
         JAt2i2557vzUAnm/04Tunx6ekVHnzbAC41hREVmRRMmsIRHLOV5yFAzYTCGXzsQ/DUE2
         +9dA==
X-Gm-Message-State: AOJu0YzP0PQXzP7QrckuD30rf+QmEkOAqMad8w1oTSbyFdYt0CzLt+d7
        JJkVHhf2SRk5HfbzDIiPSQ8+BCrASW0=
X-Google-Smtp-Source: AGHT+IGl39TagpcdrCP9gA/Aa1ZjfNBozKouAEEPqZUD4cyWb7YJ7pmFA2HqhI/fwIGSECPFLK0VeQ==
X-Received: by 2002:a05:6512:b0a:b0:4fb:9fa7:dcda with SMTP id w10-20020a0565120b0a00b004fb9fa7dcdamr8780694lfu.26.1695709374699;
        Mon, 25 Sep 2023 23:22:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k28-20020ac2457c000000b00501c673e776sm2101348lfm.45.2023.09.25.23.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 23:22:54 -0700 (PDT)
Message-ID: <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
References: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Sep 2023 06:22:48 +0000
Subject: [PATCH v4 0/4] Trailer readability cleanups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches were created while digging into the trailer code to better
understand how it works, in preparation for making the trailer.{c,h} files
as small as possible to make them available as a library for external users.
This series was originally created as part of [1], but are sent here
separately because the changes here are arguably more subjective in nature.

These patches do not add or change any features. Instead, their goal is to
make the code easier to understand for new contributors (like myself), by
making various cleanups and improvements. Ultimately, my hope is that with
such cleanups, we are better positioned to make larger changes (especially
the broader libification effort, as in "Introduce Git Standard Library"
[2]).


Updates in v4
=============

 * The first 3 patches in v3 were merged into 'master'. Necessarily, those 3
   patches have been dropped.
 * Patch 4 in v3 ("trailer: rename *_DEFAULT enums to *_UNSPECIFIED") has
   been dropped, as well as Patch 9 in v3 ("trailer: make stack variable
   names match field names"). These were dropped to simplify this series for
   what I think is the more immediate, important change (see next bullet
   point).
 * Patches 5-8 in v3 are the only ones remaining in this series. They still
   solely deal with --no-divider and trailer block start/end cleanups.


Updates in v3
=============

 * Patches 4 and 6 (--no-divider and trailer block start/end cleanups) have
   been reorganized to Patches 5-8. This ended up touching commit.c in a
   minor way, but otherwise all of the changes here are cleanups and do not
   change any behavior.


Updates in v2
=============

 * Patch 1: Drop the use of a #define. Instead just use an anonymous struct
   named internal.
 * Patch 2: Don't free info out parameter inside parse_trailers(). Instead
   free it from the caller, process_trailers(). Update comment in
   parse_trailers().
 * Patch 3: Reword commit message.
 * Patch 4: Mention be3d654343 (commit: pass --no-divider to
   interpret-trailers, 2023-06-17) in commit message.
 * Added Patch 6 to make trailer_info use offsets for trailer_start and
   trailer_end (thanks to Glen Choo for the suggestion).

[1]
https://lore.kernel.org/git/pull.1564.git.1691210737.gitgitgadget@gmail.com/T/#mb044012670663d8eb7a548924bbcc933bef116de
[2]
https://lore.kernel.org/git/20230627195251.1973421-1-calvinwan@google.com/
[3]
https://lore.kernel.org/git/pull.1149.git.1677143700.gitgitgadget@gmail.com/
[4]
https://lore.kernel.org/git/6b4cb31b17077181a311ca87e82464a1e2ad67dd.1686797630.git.gitgitgadget@gmail.com/
[5]
https://lore.kernel.org/git/pull.1563.git.1691211879.gitgitgadget@gmail.com/T/#m0131f9829c35d8e0103ffa88f07d8e0e43dd732c

Linus Arver (4):
  commit: ignore_non_trailer computes number of bytes to ignore
  trailer: find the end of the log message
  trailer: use offsets for trailer_start/trailer_end
  trailer: only use trailer_block_* variables if trailers were found

 builtin/commit.c |   2 +-
 builtin/merge.c  |   2 +-
 commit.c         |   2 +-
 commit.h         |   4 +-
 sequencer.c      |   2 +-
 trailer.c        | 105 ++++++++++++++++++++++++++++++-----------------
 trailer.h        |  15 ++++---
 7 files changed, 83 insertions(+), 49 deletions(-)


base-commit: bcb6cae2966cc407ca1afc77413b3ef11103c175
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1563%2Flistx%2Ftrailer-libification-prep-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1563/listx/trailer-libification-prep-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1563

Range-diff vs v3:

  1:  4f116d2550f <  -:  ----------- trailer: separate public from internal portion of trailer_iterator
  2:  c00f4623d0b <  -:  ----------- trailer: split process_input_file into separate pieces
  3:  f78c2345fad <  -:  ----------- trailer: split process_command_line_args into separate functions
  4:  47186a09b24 <  -:  ----------- trailer: rename *_DEFAULT enums to *_UNSPECIFIED
  5:  da52cec42e1 =  1:  4ce5cf77005 commit: ignore_non_trailer computes number of bytes to ignore
  6:  ab8a6ced143 =  2:  c904caba7e1 trailer: find the end of the log message
  7:  091805eb7d9 =  3:  796e47c1e5f trailer: use offsets for trailer_start/trailer_end
  8:  1762f78a613 =  4:  64e1bd4e4be trailer: only use trailer_block_* variables if trailers were found
  9:  a784c45ed71 <  -:  ----------- trailer: make stack variable names match field names

-- 
gitgitgadget
