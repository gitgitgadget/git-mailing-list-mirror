Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B090CC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 16:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjEHQ5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 12:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjEHQ5j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 12:57:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464ED4EFB
        for <git@vger.kernel.org>; Mon,  8 May 2023 09:57:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba22ced2f40so5089186276.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683565057; x=1686157057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtA9Wb7ICC1hjAziolNqJ6QgWB+H3qIvFHBctkFETNQ=;
        b=BVHiB3r5in3eHK2mST7o4QaKtfHjTJfoE3mlDJL0XNvzkIFmg7NoSAJ2VMrabQR7SW
         7z69uVFhesZelOl0BWZ+jP5R0I7dtqvDoEoMpiz33ERdr1s+MjvouIIKj8a2TM1mUwJu
         CaNytSdT71hVV4o7Jb8mvzBPdDmOzCzFcwY79rf7z8/axQ8cDdsYHO+JlannJgag/T4O
         8KGNN9SuFUCBAFMNQoSpF7S6wIwPICxHpZBujQrdwsqunE57As5vYJKNZX00mKas+aOC
         K01MFNdHEFtkwtvhtC0QwSJ6Z7fBpxk6d82CWscT6oKHtB2CchFADpwb+Z4bHoGxgu13
         V//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683565057; x=1686157057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NtA9Wb7ICC1hjAziolNqJ6QgWB+H3qIvFHBctkFETNQ=;
        b=ffcxkwHlQMjteYYg9N6EUIUNk5R2ivxEReWvs5I5lpmpDkffFuhhFLEQen7In4cQ3r
         guYAuih4Bbz+HnpAeLkhlrrOxAZnqLyAX10HNy66OhqMAMlswB/Sno64IL9Y1J8GFl5l
         5qFS+XRwSYi7u/WARro7fqhd5cq/zRGxxtqo5AWDUpa7SzBh/S7m2AHDgxW8EEUW5F9A
         2xZ3aKE1hPG/CloiNj/Blisvmh9ajBv5WnoraxeZybqoxN45XQxLNNgx115fRh2y8iFq
         /Fa1qBViDJauL0oQ5fyeci8XcRCVkGlCRoR5e9VhMtJgx3V8SJ+YFuW/R++2eExiWNmV
         SlRw==
X-Gm-Message-State: AC+VfDxEU9SudiFbp575jdNpcf2mIts8miy6m9BKz5EBM68WTcjbdXmP
        OAT4jnrXx4zQ0incCf38vWXjSre28rioC2yxh7wiQVQ58fuIbUUG3NFcX20tkPOIgM54xS+v3Vy
        JWmFwDZyhIDwYzqA+xK6tXN0WJ+R8qV91rxsWCalBTG7CAb/3mbJeBu6k0phWz+tSYQ==
X-Google-Smtp-Source: ACHHUZ5wI831Hf0gO5mfwNFjEke+uacq0FKQ6u6jrr3dUwBaUVPM5CsOGZH0eN6dZF3VwHGPG/MyA4a+XkpN/x0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6902:154f:b0:b78:8bd8:6e77 with SMTP
 id r15-20020a056902154f00b00b788bd86e77mr7363069ybu.8.1683565057478; Mon, 08
 May 2023 09:57:37 -0700 (PDT)
Date:   Mon,  8 May 2023 16:57:28 +0000
In-Reply-To: <20230503184849.1809304-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230503184849.1809304-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230508165728.525603-1-calvinwan@google.com>
Subject: [PATCH v4 0/7] strbuf cleanups
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reroll include suggestions made by Elijah and Junio, clarifying
commit messages in patches 2/4/5 and s/environment variable/global
variable in patch 7. 

Calvin Wan (7):
  strbuf: clarify API boundary
  abspath: move related functions to abspath
  credential-store: move related functions to credential-store file
  object-name: move related functions to object-name
  path: move related function to path
  strbuf: clarify dependency
  strbuf: remove global variable

 abspath.c                  |  36 +++++++++++++
 abspath.h                  |  21 ++++++++
 add-patch.c                |  12 +++--
 builtin/am.c               |   2 +-
 builtin/branch.c           |   4 +-
 builtin/commit.c           |   2 +-
 builtin/credential-store.c |  19 +++++++
 builtin/merge.c            |  10 ++--
 builtin/notes.c            |  16 +++---
 builtin/rebase.c           |   2 +-
 builtin/stripspace.c       |   6 ++-
 builtin/tag.c              |   9 ++--
 fmt-merge-msg.c            |   9 ++--
 gpg-interface.c            |   5 +-
 hook.c                     |   1 +
 object-name.c              |  15 ++++++
 object-name.h              |   9 ++++
 path.c                     |  20 +++++++
 path.h                     |   5 ++
 pretty.c                   |   1 +
 rebase-interactive.c       |  15 +++---
 sequencer.c                |  24 +++++----
 strbuf.c                   | 106 +++----------------------------------
 strbuf.h                   |  53 +++++--------------
 tempfile.c                 |   1 +
 wt-status.c                |   6 +--
 26 files changed, 220 insertions(+), 189 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  e0dd3f5295 strbuf: clarify API boundary
1:  ec1ea6ae4f ! 2:  48fb5db28b abspath: move related functions to abspath
    @@ Metadata
      ## Commit message ##
         abspath: move related functions to abspath
     
    -    Move abspath-related functions from strbuf.[ch] to abspath.[ch] since
    -    paths are not primitive objects and therefore strbuf should not interact
    -    with them.
    +    Move abspath-related functions from strbuf.[ch] to abspath.[ch] so that
    +    strbuf is focused on string manipulation routines with minimal
    +    dependencies.
     
      ## abspath.c ##
     @@ abspath.c: char *prefix_filename_except_for_dash(const char *pfx, const char *arg)
2:  2d74561b91 = 3:  a663f91819 credential-store: move related functions to credential-store file
3:  30b5e635cb ! 4:  ccef9dd5f2 object-name: move related functions to object-name
    @@ Commit message
         object-name: move related functions to object-name
     
         Move object-name-related functions from strbuf.[ch] to object-name.[ch]
    -    since paths are not a primitive object that strbuf should directly
    -    interact with.
    +    so that strbuf is focused on string manipulation routines with minimal
    +    dependencies.
     
      ## object-name.c ##
     @@ object-name.c: static void find_abbrev_len_packed(struct min_abbrev_data *mad)
4:  6905618470 ! 5:  0d6b9cf0f7 path: move related function to path
    @@ Metadata
      ## Commit message ##
         path: move related function to path
     
    -    Move path-related function from strbuf.[ch] to path.[ch] since path is
    -    not a primitive object and therefore strbuf should not directly interact
    -    with it.
    +    Move path-related function from strbuf.[ch] to path.[ch] so that strbuf
    +    is focused on string manipulation routines with minimal dependencies.
     
      ## path.c ##
     @@ path.c: int normalize_path_copy(char *dst, const char *src)
5:  caf3482bf7 = 6:  5655c56a6d strbuf: clarify dependency
6:  3bbaebf292 ! 7:  874d0efac3 strbuf: remove environment variable
    @@ Metadata
     Author: Calvin Wan <calvinwan@google.com>
     
      ## Commit message ##
    -    strbuf: remove environment variable
    +    strbuf: remove global variable
     
         As a library that only interacts with other primitives, strbuf should
    -    not utilize the comment_line_char environment variable within its
    +    not utilize the comment_line_char global variable within its
         functions. Therefore, add an additional parameter for functions that use
         comment_line_char and refactor callers to pass it in instead.
     
-- 
2.40.1.521.gf1e218fcd8-goog

