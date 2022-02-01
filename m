Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A509AC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 14:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbiBAOxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbiBAOxS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 09:53:18 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC59C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 06:53:18 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l129-20020a1c2587000000b0035394fedf14so2073110wml.5
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 06:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/YnrmKIUmKAcfu5dI+UyLCBo1+b2iqsEzQaKZcqw3mc=;
        b=LEpXZEgK1lszt77hT2wBIX9J7EjOuQaZz3pOI/vVZ54ebIUhqFHE+HsR6xifZeZpP8
         /drZgeqYb2/Yk4v8JV9jElux0XnczBQaYfwMhuTZPrEXiThD6cLD0kkeaSOHrjivCelZ
         6dudNxmUsD234R41wb4vBpgx6J/sSb5zq8YlTscmCbBVvgS0uLKxWDv9bDYFD1XQ69q3
         GRmTo/lEt8b5Tplz/zQ0rCEVP3/1B9ETJnL2SpIXgxoPSOVbGlVVHrRc9RVhFZ48e3tA
         Q404zSrGXEEIDktai7/tbyg8m1tt89XE/3JvZigzrjEasJDGWaXf9u5KtDkwDf/FYF0l
         YYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/YnrmKIUmKAcfu5dI+UyLCBo1+b2iqsEzQaKZcqw3mc=;
        b=tOxMPylHy7UZAycLD+kMNuZHCqlAHgR5iG/35MUEd4WGkAfqMxs+MZdzt42fduKAle
         EGsPyFcXE6qJnlQvJNV4YdP2HIYeq7D2SWkRS1lakJ0HmX7mtbjTbX0zBSaezu3w2vBo
         DwEKQu+QT+++dpvq5XNyBSUNOV/T/NUvIS1XnI+bdLera7F2fTgZg8uEilxmCkTHddmY
         kvnHrStdxEwqinnZh9jSSr2V9N92aurOUunaDMmz3iMBKu5QVosHJ+RW0Dx+qQZvWstT
         LxankVfTIactTsx+a0nYTdlkoelvca/yqQeRbVnXR+VWU5y9iNs6R+R72zLsBMwLZIf7
         mjEQ==
X-Gm-Message-State: AOAM531YW1sFgFZnrQjARMtewsCiotDcJjvbNGEF0BCrxR4JYbEbFxF3
        RKk+OqxEI81ShS9SNO1CNsZwlV54E6t4Bg==
X-Google-Smtp-Source: ABdhPJzEwQBDxM8WAQX7/naeQKPHUCs4/sKMogWxlm+FG1tzR5DgmCfyF4wFTgfSBvF/7G/v4bdggw==
X-Received: by 2002:a1c:4e09:: with SMTP id g9mr2114572wmh.188.1643727196145;
        Tue, 01 Feb 2022 06:53:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg17sm2492054wmb.2.2022.02.01.06.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 06:53:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] object-file API: pass object enums, tidy up streaming interface
Date:   Tue,  1 Feb 2022 15:53:02 +0100
Message-Id: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.913.g12b4baa2536
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is intended to help along the "unpack large blobs in stream"
series that Han Xin has been submitting. The v9 of it is available
at[1], but not currently picked up by Junio.

This changes those parts of the object-file.c API that took a "const
char *" type to take an "enum object_type" instead. We had a lot of
places that would convert back & forth between the two for no good
reason. We're still left with the "literally" interface for "git
hash-object --literally", but it's now a tiny part of the API that's
sidelined.

This also has various small API cleanups, such as returning "void" in
a case where no caller did (or should) use a return value in the case
of hash_object_file().

We then introduce the format_object_header() helper, part of that was
in Han Xin's version, but we had various other in-tree users that
could use it (which I found later, after my initial RFC patch).

We can then split up the two classes of API users of
check_object_signature() to use two different functions, which suits
their uses much better. Half of them were making use of a very early
return.

1. https://lore.kernel.org/git/20220120112114.47618-1-chiyutianyi@gmail.com/

Ævar Arnfjörð Bjarmason (10):
  object-file.c: split up declaration of unrelated variables
  object-file API: return "void", not "int" from hash_object_file()
  object-file API: add a format_object_header() function
  object-file API: have write_object_file() take "enum object_type"
  object-file API: provide a hash_object_file_oideq()
  object-file API: replace some use of check_object_signature()
  object-file API: have hash_object_file() take "enum object_type"
  object-file API: replace check_object_signature() with stream_*
  object-file.c: add a literal version of write_object_file_prepare()
  object-file API: pass an enum to read_object_with_reference()

 apply.c                  |  12 ++--
 builtin/cat-file.c       |  11 +--
 builtin/checkout.c       |   2 +-
 builtin/fast-export.c    |   4 +-
 builtin/fast-import.c    |  12 ++--
 builtin/grep.c           |   4 +-
 builtin/hash-object.c    |   4 +-
 builtin/index-pack.c     |  10 ++-
 builtin/mktag.c          |   7 +-
 builtin/mktree.c         |   2 +-
 builtin/notes.c          |   3 +-
 builtin/pack-objects.c   |   2 +-
 builtin/receive-pack.c   |   2 +-
 builtin/replace.c        |   4 +-
 builtin/tag.c            |   2 +-
 builtin/unpack-objects.c |   8 +--
 bulk-checkin.c           |   4 +-
 cache-tree.c             |   8 +--
 cache.h                  |  13 ++--
 commit.c                 |   2 +-
 convert.c                |   2 +-
 diffcore-rename.c        |   2 +-
 dir.c                    |   2 +-
 http-push.c              |   2 +-
 log-tree.c               |   2 +-
 match-trees.c            |   2 +-
 merge-ort.c              |   4 +-
 merge-recursive.c        |   2 +-
 notes-cache.c            |   2 +-
 notes.c                  |   8 +--
 object-file.c            | 142 ++++++++++++++++++++++++++-------------
 object-store.h           |  39 ++++++++---
 object.c                 |   6 +-
 pack-check.c             |   8 ++-
 read-cache.c             |   2 +-
 tree-walk.c              |   6 +-
 36 files changed, 213 insertions(+), 134 deletions(-)

-- 
2.35.0.913.g12b4baa2536

