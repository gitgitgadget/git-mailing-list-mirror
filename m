Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C071C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A1A610FC
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJTBIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 21:08:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37008 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhJTBIq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Oct 2021 21:08:46 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7C2B060795;
        Wed, 20 Oct 2021 01:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634691992;
        bh=yIZPYXOfzG0y4x1BLigMTh0K/e/zAR7jUYLrODIgg44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=WHLfjTBWNnHbLogRmIa0bB5TYRklmF+YORmB1yKEfH93WImmBocxDA/7jNP2ecec9
         MLP8+Qcw+yfwL/8C66xBMEkIoZ8be6d9tomNk1LZyB4TQCpdg1XZ3fOqJhjKdLwO/y
         0KEYl1TPBgx3pgPhq1JLCbSEtXR+MCL+U+++69ynMG0xelZJDjFuBFg0umeQqetORQ
         bb7dSDAd2VhN54ZcwqvrJVDKcCk7S0ho+zc9bCFU1RnzNNSVfNvA5fHTiEVPAu0df+
         KYfFOiuKQCHK9Aa5ChlN6hHWiq7MMQbyBuNPct4wJ+of+Wk/XqcQNUzpXzp/FvYUM7
         WrivxyXjbXwHlH2LGxfC7FrLgI0sDfpdsyxxgs3l/KVSJ9boQ801IWwciriSBagDKr
         IL8UqztQ9hh1eT+5Af4iadz75AQY09WRSW2tvQiH1SbE1F10rnrx2kTseUnRZS1r4L
         wua3+pxkK0BOax2VnJi6osv32fbP+8Ss10+BgPmWUq+HHinw/3e
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 3/4] gitfaq: give advice on using eol attribute in gitattributes
Date:   Wed, 20 Oct 2021 01:06:22 +0000
Message-Id: <20211020010624.675562-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2
In-Reply-To: <20211020010624.675562-1-sandals@crustytoothpaste.net>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the FAQ, we tell people how to use the text attribute, but we fail to
explain what to do with the eol attribute.  As we ourselves have
noticed, most shell implementations do not care for carriage returns,
and as such, people will practically always want them to use LF endings.
Similar things can be said for batch files on Windows, except with CRLF
endings.

Since these are common things to have in a repository, let's help users
make a good decision by recommending that they use the gitattributes
file to correctly check out the endings.

In addition, let's correct the cross-reference to this question, which
originally referred to "the following entry", even though a new entry
has been inserted in between.  The cross-reference notation should
prevent this from occurring and provide a link in formats, such as HTML,
which support that.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index abc0f62e6c..85ac99c7b2 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -401,8 +401,9 @@ I'm on Windows and git diff shows my files as having a `^M` at the end.::
 +
 You can store the files in the repository with Unix line endings and convert
 them automatically to your platform's line endings.  To do that, set the
-configuration option `core.eol` to `native` and see the following entry for
-information about how to configure files as text or binary.
+configuration option `core.eol` to `native` and see
+<<recommended-storage-settings,the question on recommended storage settings>>
+for information about how to configure files as text or binary.
 +
 You can also control this behavior with the `core.whitespace` setting if you
 don't wish to remove the carriage returns from your line endings.
@@ -464,14 +465,25 @@ references, URLs, and hashes stored in the repository.
 +
 We also recommend setting a linkgit:gitattributes[5] file to explicitly mark
 which files are text and which are binary.  If you want Git to guess, you can
-set the attribute `text=auto`.  For example, the following might be appropriate
-in some projects:
+set the attribute `text=auto`.
++
+With text files, Git will generally the repository contains LF endings in the
+repository, and will honor `core.autocrlf` and `core.eol` to decide what options
+to use when checking files out.  You can also override this by specifying a
+particular line ending such as `eol=lf` or `eol=crlf` if those files must always
+have that ending (e.g., for functionality reasons).
++
+For example, the following might be appropriate in some projects:
 +
 ----
 # By default, guess.
 *	text=auto
 # Mark all C files as text.
 *.c	text
+# Ensure all shell files end up with LF endings and all batch files end up
+# with CRLF endings in the working tree and both end up with LF in the repo.
+*.sh text eol=lf
+*.bat text eol=crlf
 # Mark all JPEG files as binary.
 *.jpg	binary
 ----
