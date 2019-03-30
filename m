Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2334A20248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfC3LU1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:20:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43965 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730682AbfC3LU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:20:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id m10so2213676plt.10
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QA3twl5Vz3Tm1FGsmk1Rx1PkWvBXBf435cYd5TFzyGE=;
        b=HvA6AlgddZb6Ind0M+cdrkdIy+by5ohMqSHbvDntsfOlvdTe/mfVZzMPWywpTA9gry
         0BVt+Iq/1CSK3AZcDrbpAnDQByC2u2loXUF2UwMIfjRXRXRmXXNIfVJaxn1t799qknSp
         lHjV2W5KIkEVTVM01yCAUaa5795oGhd7Zh7g2s+1ATkk+wUPgkQ72diwEnfxBbd0vnPF
         xWIEFbrEsXRbS6KnKBtNCEt2q+24eWg+TXjaAZnDvZxEOxADyMN5NrsYWwoBB5Jl94rA
         8aJeZZxSIJTqIyn9j3DS0rDoX5Rj9DjeA04/kn7jGSiyh0BETNuC3JXwxgWKXnI5bz2Z
         LKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QA3twl5Vz3Tm1FGsmk1Rx1PkWvBXBf435cYd5TFzyGE=;
        b=aRgCF46xTF71B5wpTcpsCCkeMP/68SD44P6/25IhyWP06LHz7nZnuLgWn0iUjlUwCj
         WP6vnsYYPw7wrM/iepLbMXeXXNG9LmL3b8H1txZ+gPCrDW4TfOrI3Ok4XB1iO2Sh8zOT
         6hiQFEIq4M2lzTtlMxqTHpscNHGmTcWAjdKlHiSJFsXd3gLSgwMONmIsBiO2yCPZCE/S
         g/BlNll60VWnvFr8FEDhqpl1mMqSMvQlZ9glGVVMd75dwYnq506wJNXK6Ogu7BvfgX0j
         hGAo89YhJf3SFia4a7DXT06FuUZGuicGfm6am3ErXAhVcsmlnBV0aUo/mCLIK59JzyF2
         uMlQ==
X-Gm-Message-State: APjAAAUrr3mX03aJe+iGEX9bwiBalAL71azfTK23hlr004M1eexGK9hm
        NiXhvAr4griA2VOSYChkgLh1zg61
X-Google-Smtp-Source: APXvYqzCy7953mnR9zKmZzqzw/S43RkEXx9BlFUxo+gPE5oN1o8PDbimoqxN6GQR037E2+Sg0ztaYg==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr52580932pla.226.1553944825347;
        Sat, 30 Mar 2019 04:20:25 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id t12sm3552656pfl.59.2019.03.30.04.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:20:24 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:20:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/31] Kill the_repository in sha1-name.c
Date:   Sat, 30 Mar 2019 18:18:56 +0700
Message-Id: <20190330111927.18645-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
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
2.21.0.479.g47ac719cd3

