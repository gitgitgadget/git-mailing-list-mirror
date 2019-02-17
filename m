Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 749141F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfBQKJU (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:09:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41504 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKJU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:09:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so7069801pfi.8
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fIyGnUVfLLlETPhu4SUSwFuztaClDKWE+1izuuFin0=;
        b=gLqHD2md4W/5+iOfKqtMYAAtx4+Rb5Sb4dU2vnN7CCkcJNpASBkqHZp87P3Dfq4y3k
         HyP0idZVH7CwPuBJM/KT3u5zltgrgGbq5EtJUAHLBg/P7kIcFcdC4Lw1infU0sodAvNb
         3idkhV65EkGqVm530WVU+b1NniU/SyVzWEPvn+B0P9pwwwTObGv++4zdGxs2jtm5yTFB
         iRhHda36u4Obgx0xuwoMMebR9tY/JV12uFQ/AOUKnycmDjn/b4walmEawypSPd2VIvfP
         PCYnparNerwL3PseTpEPB8Gamcbj6cmUV48rq0Rx4aLxBYj2+Ufs0j4Pm+v40P4CZdRV
         hpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fIyGnUVfLLlETPhu4SUSwFuztaClDKWE+1izuuFin0=;
        b=IB2HxPGecvw46wgPxsE8hIGXWTmCX0uN6XnlqCREWp7MIDmGNxihxxlsoPqcb6c8rm
         8todyD0Go9HEYKdt1yZmEmR0OdBjhIF3feNY+qST9xIL9ExAT1KDM/uobt/kG6J2RmkR
         r7mthJ464R7wX2Qe0AbeTbiw7XvTQG97ADeHuCVU7N7VU+Rg8pEQ50JJNPnM299SZOFw
         M+0q0JuCEu98CUhCFm0PCYJdJ0cK74pTeDaH+wgXEAWrFzeCB4UofYN9D7JBX5wXec9e
         UAXffDWiugu06ZGwBLcTPTdeKdshJAHQEeJq4L4kLa9Z+fkO8FPuaEI0VWYbvMk0s7wH
         P4vQ==
X-Gm-Message-State: AHQUAuYwn9x3LgaHCenx5IWUZsz7mPeWv/5w554dujX1IyuDrGR66h7h
        LnAYm7lyBquJEEn9S0i6WuXaqxts
X-Google-Smtp-Source: AHgI3IYrscQeHNwQGaPU7NBenFooA5CfThfYrLqp8e3iFUEDGPOQc3xrAmACDQr9VTKUX/hR2pyekg==
X-Received: by 2002:a65:4383:: with SMTP id m3mr12911737pgp.96.1550398158980;
        Sun, 17 Feb 2019 02:09:18 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id n6sm11388122pgv.86.2019.02.17.02.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:09:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:09:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/31] Kill the_repository in sha1-name.c
Date:   Sun, 17 Feb 2019 17:08:42 +0700
Message-Id: <20190217100913.4127-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This whole series is to fix a known issue from
ao/submodule-wo-gitmodules-checked-out. Commit 76e9bdc437 (submodule:
support reading .gitmodules when it's not in the working tree -
2018-10-25) makes "git grep --recurse-submodules" print

    warning: nested submodules ... not supported yet

one line per submodule. And it's really annoying when a repo has lots
of (non-nested) submodules.

Fixing it requires resolving an extended SHA-1 syntax from a separate
repository. Which basically means the whole sha1-name.c has to be
aware of 'struct repository' (and a bit more from refs.c as well).

Technically merge-recursive.c, tree-walk.c and config.c have to take
'struct repository *' too, but I reduce the scope a bit since it's
already long.

The main fix is 28/31. The rest is just converting code to use 'struct
repository *'. Patches after 28/31 are technically not needed, but
since I have converted most of sha1-name.c, might as well convert the
rest.

There is a new function get_oidf() from another series on 'pu', which
can't be converted right now of course. But it could be fixed easily
later. It also causes a conflict in cache.h but resolving is straight
forward.

Nguyễn Thái Ngọc Duy (31):
  packfile.c: add repo_approximate_object_count()
  refs.c: add refs_ref_exists()
  refs.c: add refs_shorten_unambiguous_ref()
  refs.c: remove the_repo from substitute_branch_name()
  refs.c: remove the_repo from expand_ref()
  refs.c: add repo_dwim_ref()
  refs.c: add repo_dwim_log()
  refs.c: remove the_repo from read_ref_at()
  commit.c: add repo_get_commit_tree()
  sha1-name.c: remove the_repo from sort_ambiguous()
  sha1-name.c: remove the_repo from find_abbrev_len_packed()
  sha1-name.c: add repo_find_unique_abbrev_r()
  sha1-name.c: store and use repo in struct disambiguate_state
  sha1-name.c: add repo_for_each_abbrev()
  sha1-name.c: remove the_repo from get_short_oid()
  sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
  sha1-name.c: remove the_repo from interpret_branch_mark()
  sha1-name.c: add repo_interpret_branch_name()
  sha1-name.c: remove the_repo from get_oid_oneline()
  sha1-name.c: remove the_repo from get_describe_name()
  sha1-name.c: remove the_repo from get_oid_basic()
  sha1-name.c: remove the_repo from get_oid_1()
  sha1-name.c: remove the_repo from handle_one_ref()
  sha1-name.c: remove the_repo from diagnose_invalid_index_path()
  sha1-name.c: remove the_repo from resolve_relative_path()
  sha1-name.c: remove the_repo from get_oid_with_context_1()
  sha1-name.c: add repo_get_oid()
  submodule-config.c: use repo_get_oid for reading .gitmodules
  sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
  sha1-name.c: remove the_repo from other get_oid_*
  sha1-name.c: remove the_repo from get_oid_mb()

 builtin/show-branch.c              |   6 +-
 cache.h                            |  50 ++--
 commit.c                           |   5 +-
 commit.h                           |   3 +-
 dir.c                              |   8 +
 dir.h                              |   4 +-
 packfile.c                         |  14 +-
 packfile.h                         |   3 +-
 refs.c                             |  71 ++++--
 refs.h                             |   9 +-
 setup.c                            |   7 +-
 sha1-name.c                        | 388 ++++++++++++++++++-----------
 submodule-config.c                 |  20 +-
 t/t7814-grep-recurse-submodules.sh |   6 +-
 upload-pack.c                      |   2 +-
 15 files changed, 371 insertions(+), 225 deletions(-)

-- 
2.21.0.rc0.328.g0e39304f8d

