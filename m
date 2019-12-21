Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415FEC2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF415206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jkqcQuHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfLUTuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:05 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41944 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727126AbfLUTuF (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:05 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 967B360787;
        Sat, 21 Dec 2019 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957804;
        bh=mxsBzAVdUvuILREuQZQB7PSsCn5Z6UyUn5zG/ABBdvc=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jkqcQuHAC5fm5fbXgxLWmZc7jRTSaHbMe5dMwyZdmEJ2OCVBVIZg2rltHfGGLcTrQ
         kekfZ74B/+9Jysgh2uFftT7UyzBfYRT01qplo8nZyZ4y3jMKbgqfUPzV1rEedI4CtK
         ZqzZgqQEW8pnXRFlrW76tGGSF5vgc1Wctlybv3/mL5EM7EJBIjZ9eDhUa1Xuj85DDB
         fAZWQsbKkq7MU+e+nnyEfIyvdKvUHhUkyPhA79xQ5RWL1S0kf6Wwaf05P5XiH8NDk3
         rypBYIASeFv9l/+BrtcBiGFvM0rPRLxLCIU4IKD95ydHDcfFW/DoztbOcsfM2bXyTC
         AzpscJQjMlWTMkd5ik1dg4Pf37ujggwNAMh6wHZL9F3Or8pC29vlN+4CCKVIBq/nGH
         WP5Aijp5+IqDXqjLCtQXtYMctXjQWMoc/ojxsaWMhaYSZE0lzspziyFAku2HdCzsPH
         nuMo6lQBvrk7UPEv8ecmlekpdNYBiUG6s/K+TCm+IThTUJmiiM5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/20] SHA-256 test fixes, part 7
Date:   Sat, 21 Dec 2019 19:49:16 +0000
Message-Id: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the seventh in a series of test fixes to make our testsuite work
with SHA-256.  Included in this series are fixes to a variety of tests
from t4054 to t5604.

I don't expect any of these to be terribly controversial (or, honestly,
that exciting), but of course any feedback is welcome.

There will likely be two or three more series of test fix patches coming
down the line.  I'll try to be a bit better about getting them sent out
in a timely manner.

I fully realize that we're entering a time of the year when many people
will be off and with family and friends (and this is true for me as
well), so it's fine if folks don't get to this series right away.  As is
usual with these series, there will likely be a couple versions, so
there will be plenty of time to incorporate any feedback.  Please feel
free to respond when it's convenient for you.

brian m. carlson (20):
  t4054: make hash-size independent
  t4066: compute index line in diffs
  t4134: compute appropriate length constant
  t4200: make hash size independent
  t4202: abstract away SHA-1-specific constants
  t4204: make hash size independent
  t4300: abstract away SHA-1-specific constants
  t5318: update for SHA-256
  t5319: change invalid offset for SHA-256 compatibility
  t5319: make test work with SHA-256
  t5324: make hash size independent
  t5504: make hash algorithm independent
  t5510: make hash size independent
  t5512: abstract away SHA-1-specific constants
  t5530: compute results based on object length
  t5537: make hash size independent
  t5540: make hash size independent
  t5562: use $ZERO_OID
  t5601: switch into repository to hash object
  t5604: make hash independent

 t/t4054-diff-bogus-tree.sh             |   3 +-
 t/t4066-diff-emit-delay.sh             |  10 +-
 t/t4134-apply-submodule.sh             |   5 +-
 t/t4200-rerere.sh                      |   3 +-
 t/t4202-log.sh                         | 127 +++++++++--------
 t/t4204-patch-id.sh                    |   2 +-
 t/t4300-merge-tree.sh                  | 188 ++++++++++++-------------
 t/t5318-commit-graph.sh                |   2 +-
 t/t5319-multi-pack-index.sh            |  26 +++-
 t/t5324-split-commit-graph.sh          |  13 +-
 t/t5504-fetch-receive-strict.sh        |  17 +--
 t/t5510-fetch.sh                       |   9 +-
 t/t5512-ls-remote.sh                   |  17 +--
 t/t5530-upload-pack-error.sh           |  26 ++--
 t/t5537-fetch-shallow.sh               |   8 +-
 t/t5540-http-push-webdav.sh            |   6 +-
 t/t5562-http-backend-content-length.sh |   2 +-
 t/t5601-clone.sh                       |   4 +-
 t/t5604-clone-reference.sh             |   5 +-
 19 files changed, 254 insertions(+), 219 deletions(-)

