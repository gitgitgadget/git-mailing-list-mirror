Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AACC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 23:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825E961418
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 23:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhD3X0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 19:26:50 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:47080 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232888AbhD3X0r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 19:26:47 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 5335680593;
        Fri, 30 Apr 2021 19:25:58 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v4 3/5] git-fast-export.txt: clarify why 'verbatim' may not be a good idea
Date:   Fri, 30 Apr 2021 17:25:35 -0600
Message-Id: <20210430232537.1131641-4-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430232537.1131641-1-lukeshu@lukeshu.com>
References: <20210423164118.693197-1-lukeshu@lukeshu.com>
 <20210430232537.1131641-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---

Notes:
    v4: This commit is new in v4.

 Documentation/git-fast-export.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 593be7e9a2..a364812d9f 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -29,15 +29,19 @@ OPTIONS
 
 --signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
 	Specify how to handle signed tags.  Since any transformation
-	after the export can change the tag names (which can also happen
-	when excluding revisions) the signatures will not match.
+	after the export (or during the export, such as excluding
+	revisions) can change the hashes being signed, the signatures
+	may become invalid.
 +
 When asking to 'abort' (which is the default), this program will die
 when encountering a signed tag.  With 'strip', the tags will silently
 be made unsigned, with 'warn-strip' they will be made unsigned but a
 warning will be displayed, with 'verbatim', they will be silently
 exported and with 'warn-verbatim' (or 'warn', a deprecated synonym),
-they will be exported, but you will see a warning.
+they will be exported, but you will see a warning.  'verbatim' and
+'warn-verbatim' should only be used if you know that no
+transformations affecting tags will be performed, or if you do not
+care that the resulting tag will have an invalid signature.
 
 --tag-of-filtered-object=(abort|drop|rewrite)::
 	Specify how to handle tags whose tagged object is filtered out.
-- 
2.31.1

