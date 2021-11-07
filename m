Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66186C4332F
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 22:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4666761458
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 22:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhKGW7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 17:59:13 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50828 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235989AbhKGW7D (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 7 Nov 2021 17:59:03 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1F7CD60794;
        Sun,  7 Nov 2021 22:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1636325749;
        bh=mYh1xxhOyB2jHzGLgbO1JNyo+E17hYE/3lREk4ImlX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=QQmi+QAWJcex4qOferHV0xjdq3X8YR/U9oJPtPYx7s8Q/419OEvlT+/u2XWYZNooD
         mMDjGgtZRzEaYC7NCkmvcXbmwJkH6Io7WA3zvoGRBSHaJnZBXsc9WDdGkRFPmKu+RT
         j4WaEPzrUIs0gCKYvIQVxTt+pZG5iH2Jy8yiZIfnTW95pIVshu1YPDe2+Cn20Qo8bZ
         EfGuTDtRmoK9O7DpdeZ956g5wp62VB15OZG1buaFFgdDbkYKJdFV6iBgpiic5r9KI3
         TKhxKNUKye0THZPffOqyvLOsiJ6mOGQNCTaOK9/hpT+JAI0Vqa9Up3Ha3pOEdddMdo
         iTpkS3YIkBuh7aEg7y/FTk0FaeNuM4igMreWJyZKb1I0GOzK3ZjW8MJcI8lbGFvxQQ
         UGeWE6ueCZjS2avyW7j8nqQlEKTVIsxgGqLBTD2wnqDFXlytPQmpKahCuYIFk8w4th
         g+TfCtTag+wC57QJXluL9NRnSJVxIT6KgPWfDwD/Qdo2r9gO7bw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 2/3] gitfaq: give advice on using eol attribute in gitattributes
Date:   Sun,  7 Nov 2021 22:55:24 +0000
Message-Id: <20211107225525.431138-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f
In-Reply-To: <20211107225525.431138-1-sandals@crustytoothpaste.net>
References: <20211107225525.431138-1-sandals@crustytoothpaste.net>
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
index 5c21951f7b..ae1b526565 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -406,8 +406,9 @@ I'm on Windows and git diff shows my files as having a `^M` at the end.::
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
@@ -469,14 +470,25 @@ references, URLs, and hashes stored in the repository.
 +
 We also recommend setting a linkgit:gitattributes[5] file to explicitly mark
 which files are text and which are binary.  If you want Git to guess, you can
-set the attribute `text=auto`.  For example, the following might be appropriate
-in some projects:
+set the attribute `text=auto`.
++
+With text files, Git will generally ensure that LF endings are used in the
+repository, and will honor `core.autocrlf` and `core.eol` to decide what options
+to use when checking files out.  You can also override this by specifying a
+particular line ending such as `eol=lf` or `eol=crlf` if those files must always
+have that ending in the working tree (e.g., for functionality reasons).
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
