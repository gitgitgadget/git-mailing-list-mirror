Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5DDC6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCSG2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCSG2L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:28:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E61F756
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m18-20020a05600c3b1200b003ed2a3d635eso5644008wms.4
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679207287;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=awhRirBED6FNk8Yy6Eowq9dCH5dx+GnQa4X+qoYLjiY=;
        b=GIdASfaS4GgRychnL+KdLiLimBt2hVi3FK1EaeESUvF7jnNVguy2MWdlCMdiJxiGZ2
         RyheDcPV7K2SeVN/dyj0czOQHw2wQHb7Knu+4U0ZKY/UyY9qoo/recQVhL4LGRrTnbCs
         QNN24ExX0Y4jKwIGC8RbdYL70rfGafojOzHtYt9AzcS6g5NKHY8QRy6Jmf++9yJxRmh6
         CsY9v9yB27DFGHara0Xf7Qb4Zd9+P4iorlixLqpwqhgSpYsUW3F8J4sjWg8Bts0UAxEl
         phHvptuWtCGLGIWWvd5y7XUv8LawnVJr2dkwOOG1M+4IalRBW78fq2tzTmyCwWMOZC3u
         Al2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679207287;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awhRirBED6FNk8Yy6Eowq9dCH5dx+GnQa4X+qoYLjiY=;
        b=qlYG79+pv02fCW5eAM5vfmIF9alHDjnLhJUrmCZ9ZLxPKYnnGDCIK2i1X/JJAwJHCI
         8qgsFhAaUMz3UvDEG6s75/x9+wyXzSUElnLC/PO6S8sKZk+zpQZy1FsoNYho+/wK18pA
         pxKNadEWlcx5vnqCRPRrZwAajF5eDTaO6TEDTJLqbeCFTYijWS/fRjepbgwEYxat12Eg
         xVauy0bhuwSFvd4Iq7ZjqfzWsVDuzHA2iJpOYQHMdS93PL5AMaZjqM2dyVwy9KLQdyvP
         T9axmhvE/GQ+Ya95wLg7Jz3CNb/ibJri6VyVkfPgxmSIVlgFIG9CTPTiOTXlQhPzl9px
         LF7g==
X-Gm-Message-State: AO0yUKXDiu2kmE8OroiD6MyGy8t/kq9recmKSF+DAvOCr2ntt/i2pl9Q
        zxWWLcQoP0AFOV7gq/jDjmW/zHOdEWg=
X-Google-Smtp-Source: AK7set8wexsN6+sXBHEFK57AH/wvLZKx3g/WK3BjG7vkQ34rB7+5HxrY0PJUmP/TtJ86tEhlTrdaIw==
X-Received: by 2002:a05:600c:3b24:b0:3ed:296b:4899 with SMTP id m36-20020a05600c3b2400b003ed296b4899mr22480546wms.15.1679207286989;
        Sat, 18 Mar 2023 23:28:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x33-20020a05600c18a100b003ede3f5c81fsm376304wmp.41.2023.03.18.23.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:28:06 -0700 (PDT)
Message-Id: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Mar 2023 06:27:46 +0000
Subject: [PATCH 00/16] Header cleanups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maintainer note: I dropped multiple changes from this series to avoid
conflicts with other in-flight series, but two small conflicts remain. In
order to merge with next, add the following declaration to abspath.h:

    /* Likewise, but path=="-" always yields "-" */
    char *prefix_filename_except_for_dash(const char *prefix, const char *path);


(from cache.h) and remove the entire conflicted region in cache.h. There is
also a semantic conflict with seen; to fix, include abspath.h in the new
file compat/fsmonitor/fsm-path-utils-linux.c.

This series picks up where en/header-cleanups leaves off and does more
header cleanups, trying to reduce the number of files depending on cache.h.
(There are still more that could be done, but again, this is a good chunk
for now.)

Notes:

 * As I mentioned in my last series, Dscho's gitgitgadget is super helpful
   for a series like this.
 * As with my previous series (en/header-cleanup), I used the scripts at my
   header-cleanup-scripts branch
   [https://github.com/newren/git/commit/db81c8d7fb554b3edf04320e218bddeb98bb6194],
   and some tweaks thereof, repeatedly while making this series (though they
   are prone to produce both false positive and false negatives, so if you
   use them, only use them to generate hints about which files to look at).

Elijah Newren (16):
  treewide: remove unnecessary cache.h inclusion from a few headers
  treewide: be explicit about dependence on gettext.h
  treewide: remove unnecessary inclusion of gettext.h
  treewide: remove unnecessary cache.h inclusion from several sources
  environment: move comment_line_char from cache.h
  abspath.h: move absolute path functions from cache.h
  cache.h: remove expand_user_path()
  path.h: move function declarations for path.c functions from cache.h
  wrapper.h: move declarations for wrapper.c functions from cache.h
  treewide: remove unnecessary includes of cache.h
  environment.h: move declarations for environment.c functions from
    cache.h
  treewide: remove cache.h inclusion due to environment.h changes
  setup.h: move declarations for setup.c functions from cache.h
  treewide: remove cache.h inclusion due to setup.h changes
  write-or-die.h: move declarations for write-or-die.c functions from
    cache.h
  csum-file.h: remove unnecessary inclusion of cache.h

 abspath.c                                    |   4 +-
 abspath.h                                    |  30 +
 add-interactive.c                            |   1 +
 add-patch.c                                  |   2 +
 apply.c                                      |   5 +
 archive-tar.c                                |   2 +
 archive-zip.c                                |   2 +
 archive.c                                    |   4 +
 attr.c                                       |   3 +
 bisect.c                                     |   2 +
 blame.c                                      |   2 +
 branch.c                                     |   2 +
 builtin/add.c                                |   1 +
 builtin/am.c                                 |   4 +
 builtin/apply.c                              |   1 +
 builtin/archive.c                            |   1 +
 builtin/bisect.c                             |   3 +
 builtin/blame.c                              |   4 +
 builtin/branch.c                             |   3 +
 builtin/bugreport.c                          |   5 +-
 builtin/bundle.c                             |   3 +
 builtin/cat-file.c                           |   3 +
 builtin/check-attr.c                         |   4 +
 builtin/check-ignore.c                       |   2 +
 builtin/check-mailmap.c                      |   2 +
 builtin/check-ref-format.c                   |   1 +
 builtin/checkout--worker.c                   |   1 +
 builtin/checkout-index.c                     |   2 +
 builtin/checkout.c                           |   3 +
 builtin/clean.c                              |   3 +
 builtin/clone.c                              |   4 +
 builtin/column.c                             |   1 +
 builtin/commit-graph.c                       |   2 +
 builtin/commit-tree.c                        |   1 +
 builtin/commit.c                             |   2 +
 builtin/config.c                             |   5 +
 builtin/count-objects.c                      |   2 +
 builtin/credential-cache--daemon.c           |   2 +
 builtin/credential-cache.c                   |   3 +
 builtin/credential-store.c                   |   2 +
 builtin/describe.c                           |   3 +
 builtin/diagnose.c                           |   2 +
 builtin/diff-index.c                         |   1 +
 builtin/diff-tree.c                          |   1 +
 builtin/diff.c                               |   2 +
 builtin/difftool.c                           |   5 +
 builtin/fast-export.c                        |   1 +
 builtin/fast-import.c                        |   4 +
 builtin/fetch-pack.c                         |   1 +
 builtin/fetch.c                              |   2 +
 builtin/fmt-merge-msg.c                      |   2 +
 builtin/for-each-ref.c                       |   1 +
 builtin/for-each-repo.c                      |   1 +
 builtin/fsck.c                               |   1 +
 builtin/fsmonitor--daemon.c                  |   3 +
 builtin/gc.c                                 |   5 +
 builtin/get-tar-commit-id.c                  |   1 +
 builtin/grep.c                               |   3 +
 builtin/hash-object.c                        |   4 +
 builtin/help.c                               |   2 +
 builtin/hook.c                               |   1 +
 builtin/index-pack.c                         |   4 +
 builtin/init-db.c                            |   5 +
 builtin/interpret-trailers.c                 |   1 +
 builtin/log.c                                |   4 +
 builtin/ls-files.c                           |   2 +
 builtin/ls-remote.c                          |   1 +
 builtin/ls-tree.c                            |   1 +
 builtin/mailinfo.c                           |   3 +
 builtin/mailsplit.c                          |   1 +
 builtin/merge-base.c                         |   1 +
 builtin/merge-file.c                         |   3 +
 builtin/merge-recursive.c                    |   1 +
 builtin/merge-tree.c                         |   1 +
 builtin/merge.c                              |   4 +
 builtin/mktag.c                              |   1 +
 builtin/mktree.c                             |   1 +
 builtin/multi-pack-index.c                   |   3 +
 builtin/mv.c                                 |   4 +
 builtin/name-rev.c                           |   2 +
 builtin/notes.c                              |   2 +
 builtin/pack-objects.c                       |   3 +
 builtin/pack-redundant.c                     |   1 +
 builtin/pack-refs.c                          |   1 +
 builtin/patch-id.c                           |   1 +
 builtin/prune-packed.c                       |   1 +
 builtin/prune.c                              |   2 +
 builtin/pull.c                               |   1 +
 builtin/push.c                               |   2 +
 builtin/range-diff.c                         |   1 +
 builtin/read-tree.c                          |   2 +
 builtin/rebase.c                             |   4 +
 builtin/receive-pack.c                       |   4 +
 builtin/reflog.c                             |   1 +
 builtin/remote.c                             |   1 +
 builtin/repack.c                             |   2 +
 builtin/replace.c                            |   2 +
 builtin/rerere.c                             |   2 +
 builtin/reset.c                              |   3 +
 builtin/rev-list.c                           |   2 +
 builtin/rev-parse.c                          |   4 +
 builtin/revert.c                             |   1 +
 builtin/rm.c                                 |   2 +
 builtin/send-pack.c                          |   1 +
 builtin/shortlog.c                           |   3 +
 builtin/show-branch.c                        |   2 +
 builtin/show-index.c                         |   1 +
 builtin/show-ref.c                           |   1 +
 builtin/sparse-checkout.c                    |   3 +
 builtin/stash.c                              |   4 +
 builtin/stripspace.c                         |   3 +
 builtin/submodule--helper.c                  |   4 +
 builtin/symbolic-ref.c                       |   1 +
 builtin/tag.c                                |   3 +
 builtin/unpack-file.c                        |   1 +
 builtin/unpack-objects.c                     |   2 +
 builtin/update-index.c                       |   4 +
 builtin/update-ref.c                         |   1 +
 builtin/update-server-info.c                 |   1 +
 builtin/upload-pack.c                        |   1 +
 builtin/verify-commit.c                      |   1 +
 builtin/verify-pack.c                        |   1 +
 builtin/verify-tag.c                         |   1 +
 builtin/worktree.c                           |   4 +
 builtin/write-tree.c                         |   2 +
 bulk-checkin.c                               |   4 +-
 bulk-checkin.h                               |   2 +-
 bundle-uri.c                                 |   2 +
 bundle.c                                     |   3 +
 bundle.h                                     |   1 -
 cache-tree.c                                 |   3 +-
 cache.h                                      | 568 -------------------
 chdir-notify.c                               |   1 +
 chunk-format.c                               |   2 +
 color.c                                      |   1 +
 combine-diff.c                               |   1 +
 commit-graph.c                               |   4 +-
 commit.c                                     |   3 +
 common-main.c                                |   2 +
 compat/disk.h                                |   2 +
 compat/fsmonitor/fsm-health-win32.c          |   1 +
 compat/fsmonitor/fsm-listen-darwin.c         |   1 +
 compat/fsmonitor/fsm-listen-win32.c          |   1 +
 compat/fsmonitor/fsm-path-utils-darwin.c     |   1 +
 compat/fsmonitor/fsm-path-utils-win32.c      |   1 +
 compat/linux/procinfo.c                      |   2 +-
 compat/mingw.c                               |   4 +
 compat/precompose_utf8.c                     |   2 +
 compat/simple-ipc/ipc-shared.c               |   2 +-
 compat/simple-ipc/ipc-unix-socket.c          |   1 +
 compat/simple-ipc/ipc-win32.c                |   2 +
 compat/terminal.c                            |   4 +-
 config.c                                     |   7 +-
 connect.c                                    |   2 +
 connected.c                                  |   3 +-
 convert.c                                    |   2 +
 copy.c                                       |   1 +
 credential.c                                 |   2 +
 csum-file.c                                  |   3 +-
 csum-file.h                                  |   2 +-
 daemon.c                                     |   4 +
 date.c                                       |   1 +
 delta-islands.c                              |   3 +-
 diagnose.c                                   |   2 +
 diff-lib.c                                   |   1 +
 diff-no-index.c                              |   2 +
 diff.c                                       |   5 +
 dir.c                                        |   5 +
 editor.c                                     |   3 +
 entry.c                                      |   3 +
 environment.c                                |   5 +
 environment.h                                | 220 +++++++
 exec-cmd.c                                   |   3 +
 fetch-pack.c                                 |   5 +-
 fmt-merge-msg.c                              |   3 +-
 fsck.c                                       |   2 +-
 fsmonitor-ipc.c                              |   1 +
 fsmonitor.c                                  |   1 +
 gettext.c                                    |   4 +-
 git.c                                        |   3 +
 gpg-interface.c                              |   6 +-
 grep.c                                       |   3 +-
 http-backend.c                               |   5 +-
 http-fetch.c                                 |   2 +
 http-push.c                                  |   2 +
 imap-send.c                                  |   3 +
 line-log.c                                   |   2 +-
 list-objects-filter-options.h                |   1 +
 list-objects-filter.c                        |   1 +
 list-objects.c                               |   1 +
 ll-merge.c                                   |   1 +
 lockfile.c                                   |   4 +-
 log-tree.c                                   |   2 +
 ls-refs.c                                    |   4 +-
 mailmap.c                                    |   2 +
 merge-ort-wrappers.c                         |   1 +
 merge-ort.c                                  |   2 +
 merge-recursive.c                            |   3 +
 merge.c                                      |   1 +
 midx.c                                       |   4 +-
 name-hash.c                                  |   2 +
 negotiator/default.c                         |   2 +-
 negotiator/skipping.c                        |   2 +-
 notes-cache.c                                |   2 +-
 notes-merge.c                                |   2 +
 notes-utils.c                                |   4 +-
 notes.c                                      |   1 +
 object-file.c                                |   7 +-
 object-name.c                                |   3 +
 object.c                                     |   1 +
 pack-bitmap-write.c                          |   5 +-
 pack-bitmap.c                                |   3 +-
 pack-check.c                                 |   1 +
 pack-mtimes.c                                |   3 +-
 pack-revindex.c                              |   1 +
 pack-write.c                                 |   2 +
 pack.h                                       |   2 +
 packfile.c                                   |   5 +-
 packfile.h                                   |   4 +-
 parallel-checkout.c                          |   2 +
 parse-options-cb.c                           |   2 +
 parse-options.c                              |   3 +-
 parse-options.h                              |   2 +
 patch-ids.c                                  |   2 +-
 path.c                                       |   6 +-
 path.h                                       |  62 +-
 pathspec.c                                   |   4 +
 pkt-line.c                                   |   3 +
 preload-index.c                              |   2 +
 pretty.c                                     |   2 +
 progress.c                                   |   1 -
 promisor-remote.c                            |   1 +
 prompt.c                                     |   3 +-
 protocol.c                                   |   1 +
 prune-packed.c                               |   2 +
 range-diff.c                                 |   2 +
 reachable.c                                  |   3 +-
 read-cache.c                                 |   3 +
 rebase-interactive.c                         |   3 +
 ref-filter.c                                 |   4 +-
 ref-filter.h                                 |   1 +
 reflog.c                                     |   3 +-
 refs.c                                       |   6 +-
 refs.h                                       |   1 -
 refs/files-backend.c                         |   7 +-
 refs/iterator.c                              |   2 +-
 refs/packed-backend.c                        |   4 +-
 refspec.c                                    |   1 +
 remote-curl.c                                |   4 +
 remote.c                                     |   6 +-
 replace-object.c                             |   3 +-
 repository.c                                 |   2 +
 rerere.c                                     |   3 +
 rerere.h                                     |   1 +
 reset.c                                      |   1 +
 revision.c                                   |   3 +
 run-command.c                                |   2 +
 scalar.c                                     |   2 +
 send-pack.c                                  |   4 +-
 sequencer.c                                  |   4 +
 server-info.c                                |   4 +-
 setup.c                                      |   4 +
 setup.h                                      | 168 ++++++
 shallow.c                                    |   3 +-
 sideband.c                                   |   2 +
 sparse-index.c                               |   2 +
 split-index.c                                |   1 +
 strbuf.c                                     |   6 +-
 streaming.c                                  |   2 +
 streaming.h                                  |   4 +-
 submodule-config.c                           |   2 +
 submodule.c                                  |   6 +-
 symlinks.c                                   |   2 +
 t/helper/test-advise.c                       |   2 +-
 t/helper/test-bitmap.c                       |   3 +-
 t/helper/test-bloom.c                        |   4 +-
 t/helper/test-bundle-uri.c                   |   1 +
 t/helper/test-cache-tree.c                   |   2 +
 t/helper/test-config.c                       |   2 +-
 t/helper/test-delta.c                        |   2 +-
 t/helper/test-dump-cache-tree.c              |   2 +-
 t/helper/test-dump-fsmonitor.c               |   1 +
 t/helper/test-dump-split-index.c             |   1 +
 t/helper/test-dump-untracked-cache.c         |   1 +
 t/helper/test-fast-rebase.c                  |   5 +-
 t/helper/test-fsmonitor-client.c             |   2 +
 t/helper/test-hash.c                         |   1 -
 t/helper/test-lazy-init-name-hash.c          |   2 +
 t/helper/test-match-trees.c                  |   1 +
 t/helper/test-oid-array.c                    |   1 +
 t/helper/test-oidmap.c                       |   1 +
 t/helper/test-oidtree.c                      |   1 +
 t/helper/test-pack-mtimes.c                  |   2 +-
 t/helper/test-parse-pathspec-file.c          |   1 -
 t/helper/test-partial-clone.c                |   4 +-
 t/helper/test-path-utils.c                   |   3 +
 t/helper/test-pkt-line.c                     |   3 +-
 t/helper/test-proc-receive.c                 |   4 +-
 t/helper/test-progress.c                     |   1 -
 t/helper/test-reach.c                        |   3 +
 t/helper/test-read-cache.c                   |   2 +
 t/helper/test-read-graph.c                   |   2 +-
 t/helper/test-read-midx.c                    |   1 +
 t/helper/test-ref-store.c                    |   2 +-
 t/helper/test-repository.c                   |   3 +-
 t/helper/test-revision-walking.c             |   2 +-
 t/helper/test-run-command.c                  |   1 -
 t/helper/test-scrap-cache-tree.c             |   1 +
 t/helper/test-serve-v2.c                     |   3 +-
 t/helper/test-submodule-config.c             |   1 +
 t/helper/test-submodule-nested-repo-config.c |   2 +-
 t/helper/test-submodule.c                    |   2 +-
 t/helper/test-subprocess.c                   |   2 +-
 t/helper/test-trace2.c                       |   2 +-
 t/helper/test-userdiff.c                     |   2 +-
 t/helper/test-write-cache.c                  |   1 +
 tag.c                                        |   2 +
 tempfile.c                                   |   4 +-
 tmp-objdir.c                                 |   2 +
 trace.c                                      |   4 +
 trace2/tr2_cfg.c                             |   4 +-
 trace2/tr2_cmd_name.c                        |   3 +-
 trace2/tr2_dst.c                             |   4 +-
 trace2/tr2_sid.c                             |   3 +-
 trailer.c                                    |   4 +-
 transport-helper.c                           |   3 +
 transport.c                                  |   4 +-
 transport.h                                  |   1 -
 tree-walk.c                                  |   1 +
 unpack-trees.c                               |   3 +
 upload-pack.c                                |   3 +
 usage.c                                      |   4 +-
 walker.c                                     |   1 +
 worktree.c                                   |   5 +
 wrapper.c                                    |   3 +
 wrapper.h                                    |  36 ++
 write-or-die.c                               |   4 +-
 write-or-die.h                               |  78 +++
 wt-status.c                                  |   3 +
 xdiff-interface.c                            |   2 +-
 340 files changed, 1308 insertions(+), 666 deletions(-)
 create mode 100644 abspath.h
 create mode 100644 setup.h
 create mode 100644 wrapper.h
 create mode 100644 write-or-die.h


base-commit: 950264636c68591989456e3ba0a5442f93152c1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1493%2Fnewren%2Fheader-cleanup-2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1493/newren/header-cleanup-2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1493
-- 
gitgitgadget
