Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34B220D14
	for <e@80x24.org>; Tue, 20 Jun 2017 19:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdFTTUK (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:10 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33263 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdFTTUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:09 -0400
Received: by mail-pg0-f49.google.com with SMTP id f185so66729824pgc.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i8xjQy0F2LjVAoDV/d3AyOOZ0u1A0j8Rr+HLziKjlno=;
        b=ak44ZUrgh8Z5/g8LidrHUHSzEVU9q64VzB1wPZDRTJ/ZiuRnQrE1ktyw8P2BFwdI4V
         dVI0RYr/D1IxWe0HRdPJl0R+DmYzWnfC+oNxu6h8JkO/Pww+paL3dYSiooWRXryiKYRd
         0+vKI8T83T2hefycXetbdmq3zq/gIe2CaOFVnDOmJdAg0R3Wp4qtj5rrko8lVt+rJATg
         LvsJpxNeuLc4cgr9hxP2QGucGgkXqksv9xa1qnzirynFuN3csRfZzGcQwcdFk5SXxgpK
         rx4D+sR5hRw6z5z1VucYd+lBtJx72+3jxDKzPxi26A1R4K8sQA7rzdxRuCkzMQd+VQmz
         nQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i8xjQy0F2LjVAoDV/d3AyOOZ0u1A0j8Rr+HLziKjlno=;
        b=F0Yo9CVvYS/NL+ITqxI0wRS6tzugWy3dXNxH/NdDLIxAnTIp9v6l4G4c6MhoHaivlP
         LzDeqDKvfBMEWC/oAj9LgVTdrl3mhBBW3bwjir1FDKZCAm905fs6jlStWVlCQNhnepC7
         8RxpuQ2Zth+TGO8IcvwThO+yTokNBxLfMYGm9qGPpDdiG+9hWT92WgkIYYvjqomq5RQB
         vcMK0ymTODAmHJJHWBMidrSFU5soFSpGworbKURYsULgu7kZnsREqj21MCmjL2Mzc8HB
         XMIUuRxyoMR+GRwIa6ncf+wC+VLRf+Eoc61Ifcga/nKuFMOsC0gFHJ8f0DFH0sMScWYw
         ZF3Q==
X-Gm-Message-State: AKS2vOzm0pjpsaIUxJvFpTW+M2NL4LTi/V26EBs5h9ZJUmbBZyp5LSKn
        eUPpnD3jnMAgg6u9Ia9f+w==
X-Received: by 10.84.176.3 with SMTP id u3mr2736030plb.134.1497986408406;
        Tue, 20 Jun 2017 12:20:08 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:05 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 00/20] repository object
Date:   Tue, 20 Jun 2017 12:19:31 -0700
Message-Id: <20170620191951.84791-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I decided to split up the original series into three parts in order to make
review a little bit easier.  As such this series is dependent on on
'bw/config-h' and 'bw/ls-files-sans-the-index' which should be moving into
'next' soon.  Due to this I was able to greatly shrink this series in terms of
number of patches so hopefully it is a little easier to review.

As before you can find this series at:
https://github.com/bmwill/git/tree/repository-object

Chagnes in v3:

 * Once v2 was merged to 'pu' a bug was discovered in how the 'do_git_path'
   function handled worktree's.  v3 addresses this by ensuring to only replace
   'gitdir/index' with 'repository->index_file' when not operating specifically
   on a 'struct worktree'.

 * Added a bunch of path related functions to facilitate construction of paths
   into a repository's gitdir or in a repository's worktree.

 * Added an additional initialization function to allow initializing a 'struct
   repository' as a submodule of another 'struct repository'.

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
  path: construct correct path to a worktree's index
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
 builtin/ls-files.c                     | 195 +++++++++++---------------
 builtin/submodule--helper.c            |   9 +-
 cache.h                                |  62 +--------
 config.c                               | 216 +++++++++++++++++++----------
 config.h                               |  24 ++++
 environment.c                          |  91 ++++--------
 git.c                                  |   2 +-
 path.c                                 | 136 ++++++++++++++----
 path.h                                 |  82 +++++++++++
 repository.c                           | 245 +++++++++++++++++++++++++++++++++
 repository.h                           |  76 ++++++++++
 setup.c                                |  33 +++++
 submodule-config.c                     |  70 +++++++---
 submodule-config.h                     |  10 ++
 submodule.c                            |  35 +++--
 submodule.h                            |   4 +-
 t/t3007-ls-files-recurse-submodules.sh |  39 ++++++
 worktree.c                             |   3 +-
 20 files changed, 962 insertions(+), 374 deletions(-)
 create mode 100644 path.h
 create mode 100644 repository.c
 create mode 100644 repository.h

-- 
2.13.1.611.g7e3b11ae1-goog

