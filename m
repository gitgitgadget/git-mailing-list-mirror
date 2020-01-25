Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A14C35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85732071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fEfnXkFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgAYXAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:00:41 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46790 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727440AbgAYXAl (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:41 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 874BA60479;
        Sat, 25 Jan 2020 23:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993240;
        bh=UW1ZezJ8XrAPeKGvYY+Qm/8hvNaHDP+dBcqu9mOoWoY=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fEfnXkFC61dfrxEIFR/Rxsb8FtLwK/oDgFmGmQnBtGaXMnkXk4XkXBjxBQ60e1DYy
         wDLMS1roupf60FFNlcoj4pJ/b32D/RLGuShtso4VoQE3Tbx+X5iT1iKVsAdI+5dfja
         vAbeDsDJQiHzUTxFfmkoEb3eRlLA5xA6fVDeScU564tNNKTnbtpgUmrGoKe9b5wyfr
         cSJLiYgk2XZtCVE/1NCImMRdE87FZ3plDgmuUOa3iesCUWTaQhHvUnEOAqHsXBKrA4
         qvIVZvmFO80Rk5PgR2dNnBsx9AMB2Q8fJSch99wALsR/OmFSZpLf7LiTwVcpVxo/cT
         hxMJxclKKIgF6t8+UbRGb7cZK07DjI0zrqzkOpXQb8dfkYpRTVPQ8SHWB0GRaaqmAj
         RnPei2QWXQa+FO++f/iHpuNJMuHyWTZqp9rvnmN8uJfxk1qRJ7DQFpGLSk4xhtWFub
         Hat5gfuTyvwkMPIHgJHmKTpb47hInoFLtXK7R0RaZzVadFjMxHv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 00/23] SHA-256 test fixes, part 8
Date:   Sat, 25 Jan 2020 23:00:06 +0000
Message-Id: <20200125230035.136348-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second-to-last series of test fixes for SHA-256.

As mentioned previously, the patch for t3305 seems to indicate a bug in
the notes code and I'm not familiar enough with that code to apply a
fix.  This is a band-aid to get it working with SHA-256, but any
comments on a more robust approach would of course be welcome.

Changes from v1:
* Drop patch for t3404 in favor of Dscho's fix.
* Drop patch for t5616 in favor of Jonathan Tan's fix.
* Add missing sign-off.
* Move test_oid_init into the correct patch.

brian m. carlson (22):
  t/lib-pack: support SHA-256
  t3206: make hash size independent
  t3305: annotate with SHA1 prerequisite
  t3308: make test work with SHA-256
  t3309: make test work with SHA-256
  t3310: make test work with SHA-256
  t3311: make test work with SHA-256
  t4013: make test hash independent
  t4060: make test work with SHA-256
  t4211: make test hash independent
  t5302: make hash size independent
  t5309: make test hash independent
  t5313: make test hash independent
  t5321: make test hash independent
  t5515: make test hash independent
  t5318: update for SHA-256
  t5607: make hash size independent
  t5703: make test work with SHA-256
  t5703: switch tests to use test_oid
  t6000: abstract away SHA-1-specific constants
  t6006: make hash size independent
  t6024: update for SHA-256

 t/lib-pack.sh                                |  35 ++-
 t/t3206-range-diff.sh                        |  14 +-
 t/t3305-notes-fanout.sh                      |   2 +-
 t/t3308-notes-merge.sh                       |  83 ++++---
 t/t3309-notes-merge-auto-resolve.sh          | 228 ++++++++++++-------
 t/t3310-notes-merge-manual-resolve.sh        |  84 ++++---
 t/t3311-notes-merge-fanout.sh                |  60 +++--
 t/t4013-diff-various.sh                      |  44 +++-
 t/t4060-diff-submodule-option-diff-format.sh | 126 +++++-----
 t/t4211-line-log.sh                          |  14 +-
 t/t5302-pack-index.sh                        |  18 +-
 t/t5309-pack-delta-cycles.sh                 |  10 +-
 t/t5313-pack-bounds-checks.sh                |  19 +-
 t/t5318-commit-graph.sh                      |   4 +-
 t/t5321-pack-large-objects.sh                |   4 +-
 t/t5515-fetch-merge-logic.sh                 |  51 ++++-
 t/t5607-clone-bundle.sh                      |   2 +-
 t/t5703-upload-pack-ref-in-want.sh           |   7 +-
 t/t6000-rev-list-misc.sh                     |  13 +-
 t/t6006-rev-list-format.sh                   |   4 +-
 t/t6024-recursive-merge.sh                   |  15 +-
 21 files changed, 559 insertions(+), 278 deletions(-)

