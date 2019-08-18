Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575D31F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfHRUFc (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57912 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfHRUFb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 683F56047B;
        Sun, 18 Aug 2019 20:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158728;
        bh=jsapbxa6zPQiAIMG28LrXbP/uQhvuSvDIzneP3v68io=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wrvA4MYm8G6lZBo4YeAPSIeirJwzlVM/kKA7F5HLNayxQKRI6PbVf2yTNnI4TqEkx
         2C3Uh7DTUb9J7iFio9mNnln18r0uiWU4hiIkcCLxmj8weTZIiNsbyqD7yDV6GmuAbB
         5cz+taoE9KnIJ7DJlwxd6Te4gT/QSjdEpwQzjjuqvzMwopqevbkexaURsWcxIiBroR
         x41k1R3iDECODaek6VgpfYPsdBQZbs1SGsQKCXCTgvRx8/Vep2RZ0qZnyG6xLI7bSx
         pGKmKEIPEvvIaK9iXqvjvckAe2TZOhE16oxUIJv4lWshshyZa7MsyoAlOluMDzE79n
         WNb16eL4Ob/Iq3bQ3VwBsjffVxVSjVzSC9Sl/p9FRHXbz0Gt118fSWtglP2pr1TSyk
         XFc5zoKa6lq39fCPXo1u5Mv6A7E2165tmvz53SquKIOOzygfFTZc3iMBe3HvlUkXvm
         qDckHFZXhRNm++et9SHzA+5kpIBmOXIBWA3A/WROasUZCw8MjCH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 00/26] object_id part 17
Date:   Sun, 18 Aug 2019 20:04:01 +0000
Message-Id: <20190818200427.870753-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the seventeenth and final object_id series. The patches mostly
switch sha1_to_hex to hash_to_hex, remove null_sha1 in favor of
null_oid, and replace some hard-coded constants (along with
GIT_SHA1_HEXSZ) to use the_hash_algo.

This series may downloaded from the normal places as "object-id-part17".

Additional patches for test fixes will be required, but beyond that, the
next series of actual code changes will involve introducing the
`extensions.objectFormat` flag and the ability to create repositories
and run the testsuite with SHA-256.  A preview of this work may be seen
in the "transition-stage-4" branch.

brian m. carlson (26):
  builtin/replace: make hash size independent
  patch-id: convert to use the_hash_algo
  fetch-pack: use parse_oid_hex
  builtin/receive-pack: switch to use the_hash_algo
  builtin/blame: switch uses of GIT_SHA1_HEXSZ to the_hash_algo
  builtin/rev-parse: switch to use the_hash_algo
  blame: remove needless comparison with GIT_SHA1_HEXSZ
  show-index: switch hard-coded constants to the_hash_algo
  connected: switch GIT_SHA1_HEXSZ to the_hash_algo
  bundle: switch to use the_hash_algo
  combine-diff: replace GIT_SHA1_HEXSZ with the_hash_algo
  config: use the_hash_algo in abbrev comparison
  sha1-lookup: switch hard-coded constants to the_hash_algo
  bisect: switch to using the_hash_algo
  sequencer: convert to use the_hash_algo
  pack-write: use hash_to_hex when writing checksums
  builtin/repack: write object IDs of the proper length
  builtin/worktree: switch null_sha1 to null_oid
  cache: remove null_sha1
  wt-status: convert struct wt_status to object_id
  packfile: replace sha1_to_hex
  builtin/index-pack: replace sha1_to_hex
  builtin/receive-pack: replace sha1_to_hex
  rerere: replace sha1_to_hex
  builtin/show-index: replace sha1_to_hex
  midx: switch to using the_hash_algo

 bisect.c                    |  2 +-
 blame.c                     |  2 +-
 builtin/blame.c             |  7 +++---
 builtin/clone.c             |  2 +-
 builtin/commit.c            |  4 +--
 builtin/index-pack.c        |  4 +--
 builtin/patch-id.c          | 11 ++++----
 builtin/receive-pack.c      | 50 ++++++++++++++++++-------------------
 builtin/repack.c            |  2 +-
 builtin/replace.c           |  7 +++---
 builtin/rev-parse.c         |  5 ++--
 builtin/show-index.c        | 13 +++++-----
 builtin/submodule--helper.c |  2 +-
 builtin/worktree.c          |  2 +-
 bundle.c                    |  4 +--
 cache.h                     |  8 +-----
 combine-diff.c              |  2 +-
 config.c                    |  2 +-
 connected.c                 |  7 +++---
 diff.c                      | 46 +++++++++++++++++-----------------
 diff.h                      |  2 +-
 fetch-pack.c                | 12 ++++-----
 midx.c                      | 11 ++++----
 pack-write.c                |  8 +++---
 packfile.c                  |  4 +--
 rerere.c                    |  8 +++---
 sequencer.c                 |  6 ++---
 sha1-file.c                 |  1 -
 sha1-lookup.c               |  8 +++---
 wt-status.c                 |  2 +-
 wt-status.h                 |  2 +-
 31 files changed, 121 insertions(+), 125 deletions(-)

