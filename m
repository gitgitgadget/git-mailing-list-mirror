Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3631FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdEaVod (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:44:33 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34177 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdEaVoc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:44:32 -0400
Received: by mail-pf0-f182.google.com with SMTP id 9so18575102pfj.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CkFqukrsLq2QGBFLylyEIizUCmcYxCvm8CRf2Qqo8OY=;
        b=oP4E2/YVQ/FWjjvItGzk9ssZHH6dEUeJ1/7HsCyVcNt8yE90qYcOhznxoq22gf897h
         ZDf7KLe1mJOguXHZt6c3y0VAr7tQH8zy4IhXKMmnaAFZ5JwmEza3/Hw6rGdlbJwyalQD
         TGkoRlDFgX5HHmRVfrXT0Tkt55gikekEVvZWxY6WXntXvheHn3KGeIcF3xQNzpfxcqPa
         VhkC306ajkrohRvx73BjP4mLIbYlOqF+IbDYT+jvyZqv1m0qi0zNnfXDlV+a2eBzuZxn
         h7d6EiW79eY6sUAInWebjTrzdIGPbHXswkXbF6zTENvhri8Qo/w3JtFFfaBRoMRtPk/+
         Bk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CkFqukrsLq2QGBFLylyEIizUCmcYxCvm8CRf2Qqo8OY=;
        b=d6nzkwFC2ZCExH98Omwm/4fKTlNqdAo8k0xO7aGMkW6dPkTtEqVwEbgOZpJPiMYkUi
         oP397YTAm66UCepn+fUc+Ae+ShdD0svD7Cq+4hvJiGGw/NWmmuwGEwTryCR7z3r8MKLV
         Hj2eSQbKb6pu9SXzReIqONkI98iZBbGhf499PzBgH5XcTsgBSynyJJC8hY2mJz5fI1j7
         V0MxVU73BbhfW3zamURONR7URVEFAJHc/5vPez4XPp1skgeLiDQV+hk4Ak/CJmCw2ne+
         mHAbg10olHx42N6Nz6PwWRChQ6ixR3wGoqrdMFvHi2N30FXox0UhMTfWqgkAjfh6+nDQ
         qJaA==
X-Gm-Message-State: AODbwcCzOn0cr1uaAs2XW5D8k97cbYrbBSUGPTj2xG4FuCS+cxDISzxf
        AuJsBpTDAimZCO/LkVlVuA==
X-Received: by 10.99.115.29 with SMTP id o29mr36174807pgc.140.1496267070665;
        Wed, 31 May 2017 14:44:30 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:29 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 00/31] repository object
Date:   Wed, 31 May 2017 14:43:46 -0700
Message-Id: <20170531214417.38857-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Given the vast interest expressed when I sent out my RFC series I decided it
would be worth it to invest more time to making a repository object a reality.

This series is an extension of the last series I sent out (in that ls-files is
converted to working on submodules in-process using repository objects instead
of spawning a child process to do the work).  The big difference from the RFC
series is that I went through and did the work to migrate key repository state
from global variables in 'environment.c' to being stored in a repository object
itself.  I migrated the bits of state that seemed reasonable for this series,
there is still a lot of global state which could be migrated in the future.

I do think that we need to be slightly cautious about moving global state into
the repository object though, I don't want 'struct repo' to simply become a
kitchen sink where everything gets dumped.  But this is just a warning for the
future.

Since this is a v1 I'm fairly certain that it still has a lot of rough edges
(like I think I need to write better commit messages, and we should probably
have more comments documenting object fields/contract) but I want to get the
review process started sooner rather than later since I'm sure people will have
opinions (e.g. should it be called 'struct repo' or 'struct repository'?!).

So here it is!  Thank you so much for taking the time review this, any and all
comments would be appreciated.

- Brandon

Patches [01-14] -> Introducing the Repository object and migrating some state
		   to be stored in 'the_repository'.

Patches [15-31] -> Converting ls-files to use 'struct repo' in order to recurse
		   submodules in-process.

Brandon Williams (31):
  config: create config.h
  config: don't include config.h by default
  config: don't implicitly use gitdir
  setup: don't perform lazy initialization of repository state
  environment: remove namespace_len variable
  repo: introduce the repository object
  environment: place key repository state in the_repository
  environment: store worktree in the_repository
  setup: add comment indicating a hack
  config: migrate the_configset to the_repository
  repo: add index_state to struct repo
  submodule-config: store the_submodule_cache in the_repository
  repo: add repo_read_gitmodules
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
 builtin/ls-files.c                     | 343 ++++++++++++++++-----------------
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
 cache.h                                | 196 +------------------
 color.c                                |   1 +
 column.c                               |   1 +
 combine-diff.c                         |   2 +-
 config.c                               | 186 +++++++++++-------
 config.h                               | 204 ++++++++++++++++++++
 connect.c                              |   1 +
 convert.c                              |  32 +--
 convert.h                              |  19 +-
 credential-cache--daemon.c             |   1 +
 credential.c                           |   1 +
 daemon.c                               |   1 +
 diff.c                                 |   7 +-
 dir.c                                  |   3 +-
 environment.c                          | 101 +++-------
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
 repo.c                                 | 192 ++++++++++++++++++
 repo.h                                 |  45 +++++
 rerere.c                               |   1 +
 send-pack.c                            |   1 +
 sequencer.c                            |   1 +
 setup.c                                |  34 ++++
 sha1_file.c                            |   7 +-
 sha1_name.c                            |   1 +
 submodule-config.c                     |  72 +++++--
 submodule-config.h                     |  10 +
 submodule.c                            |  22 +--
 submodule.h                            |   3 +-
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
 157 files changed, 1130 insertions(+), 593 deletions(-)
 create mode 100644 config.h
 create mode 100644 repo.c
 create mode 100644 repo.h

-- 
2.13.0.506.g27d5fe0cd-goog

