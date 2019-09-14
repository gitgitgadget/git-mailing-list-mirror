Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D18B1F463
	for <e@80x24.org>; Sat, 14 Sep 2019 21:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfINVC2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 17:02:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58712 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbfINVC1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Sep 2019 17:02:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d92:edb:bada:18ab])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BA48B6074C
        for <git@vger.kernel.org>; Sat, 14 Sep 2019 21:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1568494945;
        bh=Pa96g0kdIgxe/oLVeOJBfbA446D984/+FjohOqXuR74=;
        h=From:To:Subject:Date:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=o/Rnzwf/aLjjh7VWj03qK92LXSuRJimzh4SlD/+Lx+LMxZ/VBRjE/UTIMJ4yz7tRF
         KCCjnUb0vzO2F3M7sOVm4O3pjCmlk85ngNFHH5j3hCbrUJ6LTP5Vmi9rffpBdXMUEc
         wKL4UDAYxY6J63AocD2u3IEygwLMvN+GqzjCQdJE6GLNw7Khv85Lk1ck6Bc0SdUFn1
         cCSb2b96zvT8QgXY1CXG18tDcU9g2af7hzaDvsz5vg8921P0RbJXqV0YKM5DbvPyfH
         bgy+w9FmwjINgAImpP1jXj4SD0Mcdf5Ya+hPQ3wpV8lq7DwxTksBubQ0vbueHaNRfn
         /FIB4iNJBUK6bSVoiD9phFpHjEePFLmSIcixDQ97syyuk4+dNrl/K4dt0fFyqss+IN
         rsSO1OnATGfBIFz0PJmY32R+nXg1TU3VlsDxYchLaHtw67kA2MnfkOT9p9dcD7gOBW
         O3kR3M0NfWDDGoXXtWz9KWhvz2UMTgGGar3qWXISj5XyUAy21E1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH] doc: provide guidance on user.name format
Date:   Sat, 14 Sep 2019 21:02:19 +0000
Message-Id: <20190914210219.753136-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's a frequent misconception that the user.name variable controls
authentication in some way, and as a result, beginning users frequently
attempt to change it when they're having authentication troubles.
Document that the convention is that this variable represents some form
of a human's personal name, although that is not required.  In addition,
address concerns about whether Unicode is supported.

Use the term "personal name" as this is likely to draw the intended
contrast, be applicable across cultures which may have different naming
conventions, and be easily understandable to people who do not speak
English as their first language.  Indicate that "some form" is
conventionally used, as people may use a nickname or preferred name
instead of a full legal name.

Point users who may be confused about authentication to an appropriate
configuration option instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
There are a *lot* of users on Stack Overflow who have difficulty with
what user.name controls, such that it may be one of the top questions.
Additionally, we occasionally see issues from new contributors to Git as
well.  Furthermore, other VCS systems do things differently, so it's
best to document the conventional expectations for users explicitly.

Users may or may not read the documentation, but at least we've done our
best at providing them helpful information should they choose to do so.

 Documentation/git-commit-tree.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 4b90b9c12a..34a8496b0e 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -92,6 +92,12 @@ if set:
 
 (nb "<", ">" and "\n"s are stripped)
 
+The author and committer names are by convention some form of a personal name,
+as opposed to a username, although Git does not enforce or require any
+particular form. Arbitrary Unicode may be used, subject to the constraints
+listed above. This name has no effect on authentication; for that, see the
+`credential.username` variable in linkgit::git-config[1].
+
 In case (some of) these environment variables are not set, the information
 is taken from the configuration items user.name and user.email, or, if not
 present, the environment variable EMAIL, or, if that is not set,
