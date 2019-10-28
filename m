Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 365841F4C1
	for <e@80x24.org>; Mon, 28 Oct 2019 00:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfJ1A7V (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:59:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54222 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728837AbfJ1A7V (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 20:59:21 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2158060443;
        Mon, 28 Oct 2019 00:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572224360;
        bh=hbUax/Brfw3UUW+HWn/sQVe62FaGMPAfh4wpTcq0C0k=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=k3sCdjGWsI0iCkbewNYjpRX05J+H9+pys7j1AULE8MnrOG/fBl/y3R1ap+NKmLAcM
         AAcIVOSKgpz9EKXoyLdd7i5fARIyBvX+1pRn9tB3eWMhDuVBe+1MXZZflt5NI38vPL
         qtHQArzzkgsLpOikdIZX+Of6Rrk1ycswuK3hYZpWX4VdIU2ymuqx4ije3yreyfPRW4
         9BME3wmhadYCtHxDfECBIrg5wRMrDCsVRQXjBIx8Bb80q1DhJRuMakH4n7ReYelhLi
         b+WOb6+o0zmNFFTmwo2ezQ2ZWhCpCltf9rcU9WMrPtQWv2s1iU4h6ZIvybPKgxT/7+
         TlUPwfVJDLN3szZQvnBmrkUiYsS8Dpf1Ey9j6ZAGSDdr6wc3SlXOpz3OQg4jLBjZo3
         bSuEBq1ZONrWQpJ7psnGQnQHfFzxtgZ4dJ2TF0X+ekWzF8lpUGJ6d+vPBjWO6BN/wS
         Ymc8OvWu++7t6Dk76snpQKyqg17lmC1SgJ86md6X37VMC+6mHRx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 00/15] SHA-256 test fixes, part 6
Date:   Mon, 28 Oct 2019 00:58:52 +0000
Message-Id: <20191028005907.24985-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series consists mostly of additional test fixes for SHA-256, plus
some test framework improvements and a new option to rev-parse.

I've opted to change the option from --object-format to
--show-object-format, since I think this is more consistent with our
other --show* options in rev-parse and it leaves --object-format as a
possible additional option for *controlling* (not listing) the output
format in the future.

Of course, opinions on this or other aspects of the series are welcome.

Changes from v1:
* Improve readability of t4011 by using helper functions.
* Change rev-parse option name to --show-object-format.

brian m. carlson (15):
  t/oid-info: allow looking up hash algorithm name
  t/oid-info: add empty tree and empty blob values
  rev-parse: add a --show-object-format option
  t1305: avoid comparing extensions
  t3429: remove SHA1 annotation
  t4010: abstract away SHA-1-specific constants
  t4011: abstract away SHA-1-specific constants
  t4015: abstract away SHA-1-specific constants
  t4027: make hash-size independent
  t4034: abstract away SHA-1-specific constants
  t4038: abstract away SHA-1 specific constants
  t4039: abstract away SHA-1-specific constants
  t4044: update test to work with SHA-256
  t4045: make hash-size independent
  t4048: abstract away SHA-1-specific constants

 Documentation/git-rev-parse.txt     |  7 +++
 builtin/rev-parse.c                 | 11 ++++
 t/oid-info/hash-info                |  9 +++
 t/t1305-config-include.sh           |  2 +-
 t/t1500-rev-parse.sh                | 15 +++++
 t/t3429-rebase-edit-todo.sh         |  2 +-
 t/t4010-diff-pathspec.sh            | 20 ++++---
 t/t4011-diff-symlink.sh             | 40 +++++++++----
 t/t4015-diff-whitespace.sh          | 89 ++++++++++++++++-----------
 t/t4027-diff-submodule.sh           | 16 ++---
 t/t4034-diff-words.sh               | 93 +++++++++++++++++------------
 t/t4038-diff-combined.sh            | 19 ++++--
 t/t4039-diff-assume-unchanged.sh    |  3 +-
 t/t4044-diff-index-unique-abbrev.sh | 46 +++++++++-----
 t/t4045-diff-relative.sh            |  2 +-
 t/t4048-diff-combined-binary.sh     | 58 ++++++++++--------
 16 files changed, 277 insertions(+), 155 deletions(-)

