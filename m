Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2262A1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbdFHXlS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:18 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33073 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdFHXlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:16 -0400
Received: by mail-pg0-f47.google.com with SMTP id f185so20734972pgc.0
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jZpGkFOE5eW+x0Th+G39NhG1E9676FxzolHSXfl7edQ=;
        b=u0JUQjtRFXWLFOohjxNVWtofcCTHCjhwgNU8fvqhzhwaIBHYAGul/FoXmaClveSLgW
         CgaOxxg/8LVzRzMGAarXN4U3wSSwd/8FlYWb0U/Wm1zRHAc0CgfoDFyDliXIV5cvDjjA
         5n8E3WSsnyGho2bubSiFyxKfj9WIFLKPKB4MwsOu7J6Zj7zvV3yCeGHmVok76J13WmdJ
         nEMB4K2CbSaFqhz5DiU0kLcymPcc0RWMsvro8w8fL4ZBK9DRhwiDFF+3iY8xImnz/Irb
         soWCSZlEyzP9y33k22P0bc6swObMnUqM+bAulxDmmUZNbd+TPcJRGZf9AvfNRcN+1a1z
         c/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jZpGkFOE5eW+x0Th+G39NhG1E9676FxzolHSXfl7edQ=;
        b=Bg+mRHpOsqMN0/Uon6tZdsJO0TV1JBNMe4VwjoavDUu+RWyUXxddulZgA+pmimOYB3
         35KusQoAXk2d8m4mRoaLe3W7f5uN1ig0zRI/gGPw1Z3DbxNzY3PymzhkzKX+ygPsa/4I
         uI6sK9z1EZ8JFCbqPxcRS6a7f+/sTHmr84PFuSWysRohXaV1rCwMIvypbFwiDOY99oh7
         kbajQR8OoKsLK3HFeUSNVNJJx1IMCTlDKHUSuLFX59xGNoJGIF6rkD/PGXanYnjxw/9C
         rKdiFtOc1z42N3GX6pBaNs7e2BBG9mc+lTGUOwHOfVMojxLwPrgWwF5OmQQwP6+6kxF/
         Ca0g==
X-Gm-Message-State: AODbwcDFbQCCAUzDmXZRGd7ec+t0sq2NbSupuyF65dZAyw3v0MaYQllD
        MRtSW2266uM3T1hPFrJQsw==
X-Received: by 10.99.143.90 with SMTP id r26mr40493014pgn.102.1496965272550;
        Thu, 08 Jun 2017 16:41:12 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:11 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 00/32] repository object
Date:   Thu,  8 Jun 2017 16:40:28 -0700
Message-Id: <20170608234100.188529-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I sent out my RFC series there seemed to be a lot of interest but I
haven't seen many people jump to review this series.  Despite lack of review I
wanted to get out another version which includes some changes to fix things
that were bugging me about the series.  Hopfully this v2 will prod some more
people to take a look.

The meat of the series is really from 04-15 and patch 32 which converts
ls-files to recurse using a repository object.  So if you're pressed for time
you can focus on those patches.

You can find this series at: https://github.com/bmwill/git/tree/repository-object

What's different in v2:
* 'struct repo' has been renamed 'struct repository'.  Really just an aesthetic
  change and it looks more "official" without having a shortened name.
* Better commit messages on a few of the patches which were soarly lacking.
* I found that 'git_config_iter' was being exported without an implementation
  so I added a patch to remove it.
* repo_init is a bit cleaner and is written in such a way to not call 'die()',
  instead it returns a non-zero return value upon failure.

Thanks for your help!

Brandon Williams (32):
  config: create config.h
  config: remove git_config_iter
  config: don't include config.h by default
  config: don't implicitly use gitdir
  setup: don't perform lazy initialization of repository state
  environment: remove namespace_len variable
  repository: introduce the repository object
  environment: place key repository state in the_repository
  environment: store worktree in the_repository
  setup: add comment indicating a hack
  config: read config from a repository object
  repository: add index_state to struct repo
  submodule-config: store the_submodule_cache in the_repository
  submodule: add repo_read_gitmodules
  submodule: convert is_submodule_initialized to work on a repository
  convert: convert get_cached_convert_stats_ascii to take an index
  convert: convert crlf_to_git to take an index
  convert: convert convert_to_git_filter_fd to take an index
  convert: convert convert_to_git to take an index
  convert: convert renormalize_buffer to take an index
  tree: convert read_tree to take an index parameter
  ls-files: convert overlay_tree_on_cache to take an index
  ls-files: convert write_eolinfo to take an index
  ls-files: convert show_killed_files to take an index
  ls-files: convert show_other_files to take an index
  ls-files: convert show_ru_info to take an index
  ls-files: convert ce_excluded to take an index
  ls-files: convert prune_cache to take an index
  ls-files: convert show_files to take an index
  ls-files: factor out debug info into a function
  ls-files: factor out tag calculation
  ls-files: use repository object

 Makefile                               |   1 +
 advice.c                               |   1 +
 alias.c                                |   1 +
 apply.c                                |   3 +-
 archive-tar.c                          |   1 +
 archive-zip.c                          |   1 +
 archive.c                              |   1 +
 attr.c                                 |   1 +
 bisect.c                               |   1 +
 branch.c                               |   1 +
 builtin/add.c                          |   1 +
 builtin/am.c                           |   1 +
 builtin/blame.c                        |   3 +-
 builtin/branch.c                       |   1 +
 builtin/cat-file.c                     |   1 +
 builtin/check-attr.c                   |   1 +
 builtin/check-ignore.c                 |   1 +
 builtin/check-mailmap.c                |   1 +
 builtin/checkout-index.c               |   1 +
 builtin/checkout.c                     |   1 +
 builtin/clean.c                        |   1 +
 builtin/clone.c                        |   1 +
 builtin/column.c                       |   1 +
 builtin/commit-tree.c                  |   1 +
 builtin/commit.c                       |   4 +-
 builtin/config.c                       |   3 +
 builtin/count-objects.c                |   1 +
 builtin/describe.c                     |   1 +
 builtin/diff-files.c                   |   1 +
 builtin/diff-index.c                   |   1 +
 builtin/diff-tree.c                    |   1 +
 builtin/diff.c                         |   1 +
 builtin/difftool.c                     |   1 +
 builtin/fast-export.c                  |   1 +
 builtin/fetch.c                        |   1 +
 builtin/fmt-merge-msg.c                |   1 +
 builtin/for-each-ref.c                 |   1 +
 builtin/fsck.c                         |   1 +
 builtin/gc.c                           |   1 +
 builtin/grep.c                         |   4 +-
 builtin/hash-object.c                  |   1 +
 builtin/help.c                         |   1 +
 builtin/index-pack.c                   |   1 +
 builtin/init-db.c                      |   1 +
 builtin/log.c                          |   1 +
 builtin/ls-files.c                     | 330 ++++++++++++++++-----------------
 builtin/ls-tree.c                      |   1 +
 builtin/merge-base.c                   |   1 +
 builtin/merge-file.c                   |   1 +
 builtin/merge.c                        |   1 +
 builtin/mv.c                           |   1 +
 builtin/name-rev.c                     |   1 +
 builtin/notes.c                        |   1 +
 builtin/pack-objects.c                 |   1 +
 builtin/patch-id.c                     |   1 +
 builtin/pull.c                         |   1 +
 builtin/push.c                         |   1 +
 builtin/read-tree.c                    |   1 +
 builtin/rebase--helper.c               |   1 +
 builtin/receive-pack.c                 |   1 +
 builtin/reflog.c                       |   1 +
 builtin/remote.c                       |   1 +
 builtin/repack.c                       |   1 +
 builtin/replace.c                      |   1 +
 builtin/rerere.c                       |   1 +
 builtin/reset.c                        |   1 +
 builtin/rev-list.c                     |   1 +
 builtin/rev-parse.c                    |   1 +
 builtin/revert.c                       |   1 +
 builtin/rm.c                           |   1 +
 builtin/send-pack.c                    |   1 +
 builtin/shortlog.c                     |   1 +
 builtin/show-branch.c                  |   1 +
 builtin/stripspace.c                   |   1 +
 builtin/submodule--helper.c            |  10 +-
 builtin/symbolic-ref.c                 |   1 +
 builtin/tag.c                          |   1 +
 builtin/unpack-file.c                  |   1 +
 builtin/unpack-objects.c               |   1 +
 builtin/update-index.c                 |   1 +
 builtin/update-ref.c                   |   1 +
 builtin/update-server-info.c           |   1 +
 builtin/var.c                          |   1 +
 builtin/verify-commit.c                |   1 +
 builtin/verify-pack.c                  |   1 +
 builtin/verify-tag.c                   |   1 +
 builtin/worktree.c                     |   1 +
 builtin/write-tree.c                   |   1 +
 cache.h                                | 196 +-------------------
 color.c                                |   1 +
 column.c                               |   1 +
 combine-diff.c                         |   2 +-
 config.c                               | 210 ++++++++++++++-------
 config.h                               | 217 ++++++++++++++++++++++
 connect.c                              |   1 +
 convert.c                              |  32 ++--
 convert.h                              |  19 +-
 credential-cache--daemon.c             |   1 +
 credential.c                           |   1 +
 daemon.c                               |   1 +
 diff.c                                 |   7 +-
 dir.c                                  |   3 +-
 environment.c                          | 101 ++++------
 fast-import.c                          |   1 +
 fetch-pack.c                           |   1 +
 git.c                                  |   3 +-
 gpg-interface.c                        |   1 +
 graph.c                                |   1 +
 grep.c                                 |   1 +
 help.c                                 |   1 +
 http-backend.c                         |   1 +
 http-fetch.c                           |   1 +
 http.c                                 |   1 +
 ident.c                                |   1 +
 imap-send.c                            |   1 +
 ll-merge.c                             |   3 +-
 log-tree.c                             |   1 +
 mailinfo.c                             |   1 +
 merge-recursive.c                      |   5 +-
 notes-utils.c                          |   1 +
 notes.c                                |   1 +
 pager.c                                |   1 +
 parse-options.c                        |   1 +
 path.c                                 |  11 +-
 pathspec.c                             |   1 +
 pretty.c                               |   1 +
 prompt.c                               |   1 +
 read-cache.c                           |   1 +
 refs.c                                 |   1 +
 refs/files-backend.c                   |   1 +
 remote-curl.c                          |   1 +
 remote.c                               |   1 +
 repository.c                           | 216 +++++++++++++++++++++
 repository.h                           |  45 +++++
 rerere.c                               |   1 +
 send-pack.c                            |   1 +
 sequencer.c                            |   1 +
 setup.c                                |  34 ++++
 sha1_file.c                            |   7 +-
 sha1_name.c                            |   1 +
 submodule-config.c                     |  71 +++++--
 submodule-config.h                     |  10 +
 submodule.c                            |  36 ++--
 submodule.h                            |   4 +-
 t/helper/test-config.c                 |   1 +
 t/helper/test-submodule-config.c       |   1 +
 t/t3007-ls-files-recurse-submodules.sh |  39 ++++
 trailer.c                              |   1 +
 transport.c                            |   1 +
 tree.c                                 |  28 ++-
 tree.h                                 |   3 +-
 unpack-trees.c                         |   1 +
 upload-pack.c                          |   1 +
 userdiff.c                             |   1 +
 versioncmp.c                           |   1 +
 wrapper.c                              |   1 +
 xdiff-interface.c                      |   1 +
 157 files changed, 1199 insertions(+), 586 deletions(-)
 create mode 100644 config.h
 create mode 100644 repository.c
 create mode 100644 repository.h

-- 
2.13.1.508.gb3defc5cc-goog

