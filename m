Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF0D1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbeCXHpd (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:45:33 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:37772 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeCXHpc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:32 -0400
Received: by mail-lf0-f42.google.com with SMTP id m16-v6so17661699lfc.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6dgYQSOtl+7FSJsYnthCLu/7FAVPSXQ0DXelGQlNWvw=;
        b=fruh/MQAJI09VkWVzKNedY/BZHfBfhO+/Qsvrl/lPW/egNT/fPISOuvoZRyFnfnGP9
         6aHX/+nwBXnYhnvVNHxEyJHyOvQgoc4XNjAJiaanPz39sSZJX/OHtzP9+x1w6MihOhRs
         kod6YhN47w4nrxCAvnyKu18nsNdxbNdhmIiJ0ByP5g7ihG0I17uDkkE07IC46HXM1Wcd
         R2FXZ+BSfXB0a7Tx+3j8yxrwXt4nwJNETRot6WXyhLo1VV/17mbFOPnG87Xjulk8hMKS
         eo1ff9z2XJrdSt8th6cvgBgnZ9UphcsA1S9GHYm4xxaP9XjRCv+VufA71MR8NkUQog9C
         UsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6dgYQSOtl+7FSJsYnthCLu/7FAVPSXQ0DXelGQlNWvw=;
        b=ukdRlWx2yf67Dl+uW9a8JnWMpu6vsaZH2SAzXkpLqvtZiYglXBcamnQWEhITeBiAsg
         6vSwL2N/MBePu87Duq7zidY4g/XGUwfie6LyUgUmokuhz2+C7FwAp679rfv9OFZTX68R
         M3U8nyk3uaVm6i0JbGgmzBMt/eHau5sDV2R2qfjDSWSLk6h4OriJVcVv18o+b3mMISLE
         EbBAk+gt+NXTVWYrAktAPV1n58Dokmo2crHTUS1ocBv0NNPh2GDOM+4XZwBKvu9TWV/6
         JdE5v3wHbJSjzV92EEnfwuYTpPfm+HbsevTIWoZy17INCjR4dp8PvgJT65Cdl+ESXR/U
         cLYA==
X-Gm-Message-State: AElRT7Ei3Y7RldJ5c70cb4sCaiziyJZ92YmoGLX+HldmAd7jt9R6JilB
        LenLVul9wtEone3AouEwKm4=
X-Google-Smtp-Source: AG47ELuFQryBAa99QP27TqUoRJB/vnjTutuWerl1B/+xJ+OW0ky29dxdZg1DL0wxfc8IhkURyXsSKA==
X-Received: by 10.46.118.18 with SMTP id r18mr8877915ljc.16.1521877531093;
        Sat, 24 Mar 2018 00:45:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:30 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/36] Combine t/helper binaries into a single one
Date:   Sat, 24 Mar 2018 08:44:29 +0100
Message-Id: <20180324074505.19100-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180317075421.22032-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 fixes a couple of typos in commit messages and use the cmd__ prefix
for test commands instead of test_, which avoids a naming conflict
with the existing function test_lazy_init_name_hash

[the previous v2 send out was aborted because I messed it up with some
other patches]

Nguyễn Thái Ngọc Duy (36):
  t/helper: add an empty test-tool program
  t/helper: merge test-chmtime into test-tool
  t/helper: merge test-sha1 into test-tool
  t/helper: merge test-lazy-init-name-hash into test-tool
  t/helper: merge test-config into test-tool
  t/helper: merge test-ctype into test-tool
  t/helper: merge test-date into test-tool
  t/helper: merge (unused) test-delta into test-tool
  t/helper: merge test-drop-caches into test-tool
  t/helper: merge test-dump-cache-tree into test-tool
  t/helper: merge test-dump-split-index into test-tool
  t/helper: merge test-example-decorate into test-tool
  t/helper: merge test-genrandom into test-tool
  t/helper: merge test-hashmap into test-tool
  t/helper: merge test-index-version into test-tool
  t/helper: merge (unused) test-match-trees into test-tool
  t/helper: merge (unused) test-mergesort into test-tool
  t/helper: merge test-mktemp into test-tool
  t/helper: merge test-online-cpus into test-tool
  t/helper: merge test-path-utils into test-tool
  t/helper: merge test-prio-queue into test-tool
  t/helper: merge test-read-cache into test-tool
  t/helper: merge test-ref-store into test-tool
  t/helper: merge test-regex into test-tool
  t/helper: merge test-revision-walking into test-tool
  t/helper: merge test-run-command into test-tool
  t/helper: merge test-scrap-cache-tree into test-tool
  t/helper: merge test-sha1-array into test-tool
  t/helper: merge test-sigchain into test-tool
  t/helper: merge test-strcmp-offset into test-tool
  t/helper: merge test-string-list into test-tool
  t/helper: merge test-submodule-config into test-tool
  t/helper: merge test-subprocess into test-tool
  t/helper: merge test-urlmatch-normalization into test-tool
  t/helper: merge test-wildmatch into test-tool
  t/helper: merge test-write-cache into test-tool

 .../howto/recover-corrupted-object-harder.txt |   2 +-
 Makefile                                      |  79 +++---
 t/helper/test-chmtime.c                       |  15 +-
 t/helper/test-config.c                        |   5 +-
 t/helper/test-ctype.c                         |   3 +-
 t/helper/test-date.c                          |  17 +-
 t/helper/test-delta.c                         |   5 +-
 t/helper/test-drop-caches.c                   |   3 +-
 t/helper/test-dump-cache-tree.c               |   3 +-
 t/helper/test-dump-split-index.c              |   3 +-
 t/helper/test-example-decorate.c              |   3 +-
 t/helper/test-genrandom.c                     |   3 +-
 t/helper/test-hashmap.c                       |   5 +-
 t/helper/test-index-version.c                 |   3 +-
 t/helper/test-lazy-init-name-hash.c           |  13 +-
 t/helper/test-match-trees.c                   |   3 +-
 t/helper/test-mergesort.c                     |   3 +-
 t/helper/test-mktemp.c                        |   3 +-
 t/helper/test-online-cpus.c                   |   3 +-
 t/helper/test-path-utils.c                    |   3 +-
 t/helper/test-prio-queue.c                    |   3 +-
 t/helper/test-read-cache.c                    |   3 +-
 t/helper/test-ref-store.c                     |   3 +-
 t/helper/test-regex.c                         |   7 +-
 t/helper/test-revision-walking.c              |   3 +-
 t/helper/test-run-command.c                   |   3 +-
 t/helper/test-scrap-cache-tree.c              |   3 +-
 t/helper/test-sha1-array.c                    |   3 +-
 t/helper/test-sha1.c                          |   3 +-
 t/helper/test-sha1.sh                         |   4 +-
 t/helper/test-sigchain.c                      |   3 +-
 t/helper/test-strcmp-offset.c                 |   3 +-
 t/helper/test-string-list.c                   |   3 +-
 t/helper/test-submodule-config.c              |   3 +-
 t/helper/test-subprocess.c                    |   3 +-
 t/helper/test-tool.c                          |  62 ++++
 t/helper/test-tool.h                          |  40 +++
 t/helper/test-urlmatch-normalization.c        |   5 +-
 t/helper/test-wildmatch.c                     |   3 +-
 t/helper/test-write-cache.c                   |   3 +-
 t/lib-git-p4.sh                               |   2 +-
 t/lib-git-svn.sh                              |   2 +-
 t/lib-pack.sh                                 |   2 +-
 t/perf/p0002-read-cache.sh                    |   2 +-
 t/perf/p0004-lazy-init-name-hash.sh           |   8 +-
 t/perf/p0007-write-cache.sh                   |   2 +-
 t/perf/p0071-sort.sh                          |   2 +-
 t/perf/p7519-fsmonitor.sh                     |  12 +-
 t/t0005-signals.sh                            |   6 +-
 t/t0006-date.sh                               |   8 +-
 t/t0009-prio-queue.sh                         |   6 +-
 t/t0011-hashmap.sh                            |   4 +-
 t/t0013-sha1dc.sh                             |   2 +-
 t/t0021-conversion.sh                         |   4 +-
 t/t0060-path-utils.sh                         |  60 ++--
 t/t0061-run-command.sh                        |  24 +-
 t/t0062-revision-walking.sh                   |   2 +-
 t/t0063-string-list.sh                        |  48 ++--
 t/t0064-sha1-array.sh                         |  16 +-
 t/t0065-strcmp-offset.sh                      |   2 +-
 t/t0070-fundamental.sh                        |   8 +-
 t/t0090-cache-tree.sh                         |  18 +-
 t/t0110-urlmatch-normalization.sh             | 266 +++++++++---------
 t/t1006-cat-file.sh                           |   2 +-
 t/t1050-large.sh                              |   6 +-
 t/t1300-repo-config.sh                        |   2 +-
 t/t1305-config-include.sh                     |   2 +-
 t/t1308-config-set.sh                         |  22 +-
 t/t1309-early-config.sh                       |  12 +-
 t/t1405-main-ref-store.sh                     |   2 +-
 t/t1406-submodule-ref-store.sh                |   2 +-
 t/t1407-worktree-ref-store.sh                 |   4 +-
 t/t1501-work-tree.sh                          |  10 +-
 t/t1600-index.sh                              |   2 +-
 t/t1700-split-index.sh                        |  64 ++---
 t/t2022-checkout-paths.sh                     |   4 +-
 t/t2104-update-index-skip-worktree.sh         |   6 +-
 t/t3008-ls-files-lazy-init-name-hash.sh       |   4 +-
 t/t3070-wildmatch.sh                          |  14 +-
 t/t3306-notes-prune.sh                        |   2 +-
 t/t3404-rebase-interactive.sh                 |   4 +-
 t/t3418-rebase-continue.sh                    |   4 +-
 t/t3501-revert-cherry-pick.sh                 |   2 +-
 t/t3510-cherry-pick-sequence.sh               |   4 +-
 t/t3600-rm.sh                                 |   2 +-
 t/t3700-add.sh                                |   2 +-
 t/t4011-diff-symlink.sh                       |   2 +-
 t/t4013-diff-various.sh                       |   2 +-
 t/t4035-diff-quiet.sh                         |   2 +-
 t/t4151-am-abort.sh                           |   4 +-
 t/t4200-rerere.sh                             |  22 +-
 t/t5000-tar-tree.sh                           |   4 +-
 t/t5300-pack-object.sh                        |   4 +-
 t/t5301-sliding-window.sh                     |   2 +-
 t/t5302-pack-index.sh                         |  14 +-
 t/t5303-pack-corruption-resilience.sh         |  10 +-
 t/t5304-prune.sh                              |  16 +-
 t/t5310-pack-bitmaps.sh                       |   2 +-
 t/t5313-pack-bounds-checks.sh                 |   4 +-
 t/t5314-pack-cycle-detection.sh               |   2 +-
 t/t5316-pack-delta-depth.sh                   |   2 +-
 t/t5400-send-pack.sh                          |   2 +-
 t/t5516-fetch-push.sh                         |   2 +-
 t/t5546-receive-limits.sh                     |   2 +-
 t/t5547-push-quarantine.sh                    |   2 +-
 t/t5608-clone-2gb.sh                          |   2 +-
 t/t6022-merge-rename.sh                       |  30 +-
 t/t6500-gc.sh                                 |   2 +-
 t/t6501-freshen-objects.sh                    |   4 +-
 t/t7411-submodule-config.sh                   |  18 +-
 t/t7508-status.sh                             |   6 +-
 t/t7701-repack-unpack-unreachable.sh          |   6 +-
 t/t7812-grep-icase-non-ascii.sh               |   2 +-
 t/t9004-example.sh                            |   2 +-
 t/t9100-git-svn-basic.sh                      |   4 +-
 t/t9300-fast-import.sh                        |   2 +-
 t/t9802-git-p4-filetype.sh                    |   2 +-
 t/t9803-git-p4-shell-metachars.sh             |   4 +-
 t/t9813-git-p4-preserve-users.sh              |   6 +-
 t/t9820-git-p4-editor-handling.sh             |   2 +-
 t/test-lib.sh                                 |  10 +-
 121 files changed, 684 insertions(+), 542 deletions(-)
 create mode 100644 t/helper/test-tool.c
 create mode 100644 t/helper/test-tool.h

-- 
2.17.0.rc0.348.gd5a49e0b6f

