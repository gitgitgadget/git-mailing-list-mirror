Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9996CC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 22:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0272076A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 22:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="Cgwf3FRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbgJOWKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 18:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731728AbgJOWKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 18:10:06 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Oct 2020 15:10:06 PDT
Received: from pine.sfconservancy.org (pine.sfconservancy.org [IPv6:2001:4801:7822:103:be76:4eff:fe10:7c55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1805C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 15:10:06 -0700 (PDT)
Received: from localhost (unknown [216.161.86.19])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id 72905E9CA;
        Thu, 15 Oct 2020 22:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1602799333;
        bh=tgU4HLdheir1K9hh0lGNU29hApkOja0geChpPQanR+4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Cgwf3FRr+gIbL8m2iEo8jVOf2JJZ38N8gJ3OybWRCdUD/9iJYpMzFwpWLGLtZ/at1
         4VN/or79BmxJLggSWZHYwTRQARb6P86It2Av7jxPO1KrzS1SZEqKWdoTGXTwvp7jX6
         m5VKKHGG0ozBL7URnT80zolaxE2jKb98rmCrM0tOiqsNTJtNZNqa7fK5V2kz/D7EFQ
         +pQCP8RwRJcaehkU3gTwaAqst+hmOgaHvqqkMT0iXy8cTolK7P5ut58JbijrCDriaX
         fI2mqCC+73il2kbFFIsrdkRg4LO7g8ubNcWAKS1Qmb3XJ7eWY/xrWzRoBNN3gEvmog
         2nfkIMJk0eHFA==
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     git@vger.kernel.org
Subject: [PATCH 1/1] Documentation: Clarify and expand description of --signoff
Date:   Thu, 15 Oct 2020 14:59:33 -0700
Message-Id: <20201015215933.96425-2-bkuhn@sfconservancy.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201015215933.96425-1-bkuhn@sfconservancy.org>
References: <20201015215933.96425-1-bkuhn@sfconservancy.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Building on past documentation improvements in Commit
b2c150d3aa (Expand documentation describing --signoff, 2016-01-05),
further clarify that any project using Git may and often does set its
own policy.

However, leave intact reference to the Linux DCO, which Git also
uses.  It is reasonable for Git to advocate for its own Signed-off-by
methodology in its documentation, as long as the documentation
remains respectful that YMMV and other projects may well have very
different contributor representations tied to Signed-off-by.

Signed-off-by: Bradley M. Kuhn <bkuhn@sfconservancy.org>
---
 Documentation/git-commit.txt    | 13 ++++++++-----
 Documentation/merge-options.txt | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a3baea32ae..93bbae4ded 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -166,11 +166,14 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 -s::
 --signoff::
 	Add Signed-off-by line by the committer at the end of the commit
-	log message.  The meaning of a signoff depends on the project,
-	but it typically certifies that committer has
-	the rights to submit this work under the same license and
-	agrees to a Developer Certificate of Origin
-	(see http://developercertificate.org/ for more information).
+	log message.  The meaning of a signoff depends on the project to which
+	you're committing.  For example, it may certify that the committer has
+	the rights to submit the work under the project's license or agrees to
+	some contributor representation, such as a Developer Certificate of
+	Origin.  (See http://developercertificate.org for the one used by the
+	Linux kernel and Git projects.)  Consult the documentation or
+	leadership of the project to which you're contributing to understand
+	how the signoffs are used in that project.
 
 -n::
 --no-verify::
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 80d4831662..c9df9cc0f4 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -80,11 +80,14 @@ actual commits being merged.
 --signoff::
 --no-signoff::
 	Add Signed-off-by line by the committer at the end of the commit
-	log message.  The meaning of a signoff depends on the project,
-	but it typically certifies that committer has
-	the rights to submit this work under the same license and
-	agrees to a Developer Certificate of Origin
-	(see http://developercertificate.org/ for more information).
+	log message.  The meaning of a signoff depends on the project to which
+	you're committing.  For example, it may certify that the committer has
+	the rights to submit the work under the project's license or agrees to
+	some contributor representation, such as a Developer Certificate of
+	Origin.  (See http://developercertificate.org for the one used by the
+	Linux kernel and Git projects.)  Consult the documentation or
+	leadership of the project to which you're contributing to understand
+	 how the signoffs are used in that project.
 +
 With --no-signoff do not add a Signed-off-by line.
 
-- 
2.26.1

