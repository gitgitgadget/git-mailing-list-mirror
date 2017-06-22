Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81F8D1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbdFVSoD (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:03 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35883 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdFVSoC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:02 -0400
Received: by mail-pf0-f182.google.com with SMTP id q86so12530247pfl.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TVtjlgL/dRDrJUJlFBdBrEl6JLckJh/aoUmTjO5z8y0=;
        b=rqQOt7j7R0y5r5FOHD6XTa/Y4QdvfX4hksVj415GIxx/xvJSx28Ob/Ir3+nIWk1G0E
         j3YvM7mzlOzCUwgpzK3EEbV8B/BeFwMt58E8inwSUOEPdSXQTCe80scBbz507gvGTZbD
         wy6eezE6DijNUgFXNbq7jUnap0Ylm4Mcd4AqjkjDJ8ZlyiXA2YFidV31y5lESmWmoeSf
         z39qLvX/GmgZVIx/kWhsfBN9tB9RkVcF7MHA9hLH+gQiiiQGDkQna+srKWP9XP9Fr+kU
         X/NX5kUtqVp2KLxgWr3z/vl9Ce13FMgKUoKMVubOl2kEnTEgXE6nYjw4KCRP4zUFeG85
         rsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TVtjlgL/dRDrJUJlFBdBrEl6JLckJh/aoUmTjO5z8y0=;
        b=sBufp5eY8pzvbgXC96WYdj3fwsvY0ZSVT8wTZrSTrtz/IBcoLLuGmFB66h7YY9yi+q
         VNXqOUngOYI2TidocPRhmIVyUQZkkxo5zJWAMiFui6bF/FA67UdatbpQek8+20nJvkRs
         rA6AJtG+HkdNC6hI0pIKOL/Ap2wpmwwjtz5ylvwETT78bfRa8OYnbpsX483rS8gKe6rr
         RtGbZTN2enIlW2azShDmFP71SMQWwNDpRoDXpobVGvS2U2o+v+NGjebRZFkLOy+GQ03J
         NRE6fmIOePj4yk0D+9+azgXxIpnruuAXZmkUTqmEqDZ1jdI2jfD6itYXo2J6TZG07NlU
         b8jg==
X-Gm-Message-State: AKS2vOxBaWKGvib+KNnEpUgA0poUUZBSuce7Q9/QIoF1I78DI2jcd/HX
        VEMvv9u2Z7JFNkQtJhRbCA==
X-Received: by 10.84.232.137 with SMTP id i9mr4586554plk.154.1498157040906;
        Thu, 22 Jun 2017 11:44:00 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:43:59 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 00/20] repository object
Date:   Thu, 22 Jun 2017 11:43:28 -0700
Message-Id: <20170622184348.56497-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As before you can find this series at:
https://github.com/bmwill/git/tree/repository-object

Changes in v4:

* Patch 11 is slightly different and turns off all path relocation when a
  worktree is provided instead of just for the index file (Thanks for the help
  Jonathan Nieder).
* 'repo_init()' has a tighter API and now requires that the provided gitdir is
  a path to the gitdir instead of either a path to the gitdir or path to the
  worktree (which has a .git file or directory) (Thanks Jonathan Tan).
* Minor comment and commit message chagnes

Note: Like v3 this series is dependent on on 'bw/config-h' and
      'bw/ls-files-sans-the-index'

Brandon Williams (20):
  setup: don't perform lazy initialization of repository state
  setup: add comment indicating a hack
  environment: remove namespace_len variable
  repository: introduce the repository object
  environment: place key repository state in the_repository
  environment: store worktree in the_repository
  path: create path.h
  path: always pass in commondir to update_common_dir
  path: convert strbuf_git_common_path to take a 'struct repository'
  path: convert do_git_path to take a 'struct repository'
  path: worktree_git_path() should not use file relocation
  path: add repo_git_path and strbuf_repo_git_path
  path: add repo_worktree_path and strbuf_repo_worktree_path
  config: read config from a repository object
  repository: add index_state to struct repo
  submodule-config: store the_submodule_cache in the_repository
  submodule: add repo_read_gitmodules
  submodule: convert is_submodule_initialized to work on a repository
  repository: enable initialization of submodules
  ls-files: use repository object

 Makefile                               |   1 +
 builtin/grep.c                         |   3 +-
 builtin/ls-files.c                     | 192 +++++++++++---------------
 builtin/submodule--helper.c            |   9 +-
 cache.h                                |  62 +--------
 config.c                               | 216 +++++++++++++++++++----------
 config.h                               |  24 ++++
 environment.c                          |  91 ++++---------
 git.c                                  |   2 +-
 path.c                                 | 130 ++++++++++++++----
 path.h                                 |  82 +++++++++++
 repository.c                           | 242 +++++++++++++++++++++++++++++++++
 repository.h                           |  97 +++++++++++++
 setup.c                                |  33 +++++
 submodule-config.c                     |  70 +++++++---
 submodule-config.h                     |  10 ++
 submodule.c                            |  35 +++--
 submodule.h                            |   4 +-
 t/t3007-ls-files-recurse-submodules.sh |  39 ++++++
 worktree.c                             |   3 +-
 20 files changed, 972 insertions(+), 373 deletions(-)
 create mode 100644 path.h
 create mode 100644 repository.c
 create mode 100644 repository.h

-- 
2.13.1.704.gde00cce3c-goog

