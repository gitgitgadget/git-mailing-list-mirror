Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93FEB2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbdKUVPm (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:15:42 -0500
Received: from siwi.pair.com ([209.68.5.199]:59079 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbdKUVPl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:15:41 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F1231844F0;
        Tue, 21 Nov 2017 16:15:40 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 80A35844D5;
        Tue, 21 Nov 2017 16:15:40 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5 00/14] Parial clone part 3: clone, fetch, fetch-pack, upload-pack, and tests
Date:   Tue, 21 Nov 2017 21:15:14 +0000
Message-Id: <20171121211528.21891-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is V5 of part 3 of partial clone.  It assumes that V5 of
parts 1 and 2 are already present.

This version carries forward the cleanup described in part 1 WRT
filter argument encoding.

Jeff Hostetler (5):
  upload-pack: add object filtering for partial clone
  clone, fetch-pack, index-pack, transport: partial clone
  fetch: add object filtering for partial fetch
  remote-curl: add object filtering for partial clone
  partial-clone: define partial clone settings in config

Jonathan Tan (9):
  fetch: refactor calculation of remote list
  pack-objects: test support for blob filtering
  fetch-pack: test support excluding large blobs
  fetch: add from_promisor and exclude-promisor-objects parameters
  t5500: add fetch-pack tests for partial clone
  t5601: test for partial clone
  t5500: more tests for partial clone and fetch
  unpack-trees: batch fetching of missing blobs
  fetch-pack: restore save_commit_buffer after use

 Documentation/config.txt                          |   4 +
 Documentation/gitremote-helpers.txt               |   4 +
 Documentation/technical/pack-protocol.txt         |   8 ++
 Documentation/technical/protocol-capabilities.txt |   8 ++
 builtin/clone.c                                   |  22 ++++-
 builtin/fetch-pack.c                              |   4 +
 builtin/fetch.c                                   |  93 +++++++++++++++--
 cache.h                                           |   1 +
 config.c                                          |   5 +
 connected.c                                       |   2 +
 environment.c                                     |   1 +
 fetch-object.c                                    |  26 ++++-
 fetch-object.h                                    |   5 +
 fetch-pack.c                                      |  17 ++++
 fetch-pack.h                                      |   2 +
 list-objects-filter-options.c                     |  90 ++++++++++++++---
 list-objects-filter-options.h                     |   6 ++
 remote-curl.c                                     |  12 +++
 t/t5300-pack-object.sh                            |  26 +++++
 t/t5500-fetch-pack.sh                             | 115 ++++++++++++++++++++++
 t/t5601-clone.sh                                  | 101 +++++++++++++++++++
 t/test-lib-functions.sh                           |  12 +++
 transport-helper.c                                |   5 +
 transport.c                                       |   4 +
 transport.h                                       |   5 +
 unpack-trees.c                                    |  22 +++++
 upload-pack.c                                     |  22 ++++-
 27 files changed, 594 insertions(+), 28 deletions(-)

-- 
2.9.3

