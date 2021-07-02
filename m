Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427FDC07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D3A613D8
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhGBWXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 18:23:32 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54763 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229917AbhGBWXb (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 2 Jul 2021 18:23:31 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CA2275C0046;
        Fri,  2 Jul 2021 18:20:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 02 Jul 2021 18:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=furrypaws.ca; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=3omTTZqspUEJErpDuZyEt6Zaq9
        KWcUZch4/gH6PmQIE=; b=SPof7gacB7eCZt1ivVs79NQ0xgkqHBSIpjPGoGRj+v
        tP5EkDkwPmzTYYIIaHxU46rJTJ+F0CvgBZeQZsQNpTXXVA1SBtmUMa6xa7diBa+7
        629+RhImF19nP5rRew0F5yLVeAEfP0HgwvVpTyyJ0WtNgKZ6d5xg0GqPbSHRzOMH
        YyQnStg8Oc8Hy8JxFd+zjtMeVzfrTuNotCXwweT4srkL8OWu6QbVQD8MUfr8g1n8
        Sj7MWxVPO4iEUTi1qyS4PsuFcp1qhUjO+qj5PnAvOC0DnyTLSdzE44GiB5ly4W0z
        LSkpQGfElA5AF3MMP12D5fFdFETiG+/zWl0eaPHQH+FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3omTTZqspUEJErpDu
        ZyEt6Zaq9KWcUZch4/gH6PmQIE=; b=VtL6D0HVDtz4k8IGzlHMPwQvT45wPR4s9
        K6T47jl1qQijPwGp7sIZHGTVUEFMp9qeeQNn3Bkl402g2HxSA8zkNTEL6xAZHWmz
        tSz11bl1bV5ZNpVYOLGCoLwlMHsEw/beCmn5tYHYwo/w5A6HCRjZtnkv19UOJMHa
        dkBD7uQ2dqo1tJuX4EOSgS96MLv+2iTKJmk8ytvhFV10xlu15GUmrU37900XMjcj
        ZXkHpsE4LuXWOcbqSv7m8FEEoqYZDRBk5wltvSC7sAPefJpWwLRWJU7uqeYm/X/L
        ZFyXS5/t2GEPVtttK2yfuVOfV1R7g9dTu5jwcNZ4PXUeP5gDYT8XA==
X-ME-Sender: <xms:SZHfYIAl9W9gfnJmT5ZRcSFGoIqKh_FEuhC9_2XVmdJSQYhYw6gIyw>
    <xme:SZHfYKgTCMWqFYaKmX5cMJx0MyigYL2R1VBq3mJrtCi_VI9ycsB0whvbwcpeFe7xv
    8wFQItUNmj2BmtFug>
X-ME-Received: <xmr:SZHfYLmmWeyiQOEzVG2ibCFMju5zdrJcQyLtWCTR-RDiHJb5syFkT6sFixNgdZPZ0cosih9I2bUfCKZJ694n41iWcclmPddK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeiledgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifuceuvghrrhihuceorghnughrvgifsehfuhhrrhih
    phgrfihsrdgtrgeqnecuggftrfgrthhtvghrnhepfffgteeikeettdelhedvgeetudejte
    eivdeffeeivefggfefheduheevfeekheeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheprghnughrvgifsehfuhhrrhihphgrfihsrdgtrg
X-ME-Proxy: <xmx:SZHfYOyeZZPt7a8xYhUISL1V_DZfuWIG6LFoYBVigf_fJvA4aLLc5g>
    <xmx:SZHfYNR24HSsSvCcA2mKkbOEn-Lg4-tjrQEFcXSxWPskzqZv07LM3Q>
    <xmx:SZHfYJasq1IXz3qQnsylAIqNxdTn9H0PBakW0uFcRu2trn3WdRtCDQ>
    <xmx:SpHfYGKcyiR4kvU_92pgcKfaY-Ax4_hVSo49w86RRQFtkFiqa7K9lw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jul 2021 18:20:57 -0400 (EDT)
From:   Andrew Berry <andrew@furrypaws.ca>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Andrew Berry <andrew@furrypaws.ca>
Subject: [PATCH] docs: .gitignore in parents is current repo only
Date:   Fri,  2 Jul 2021 18:20:44 -0400
Message-Id: <20210702222044.72767-1-andrew@furrypaws.ca>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current documentation reads as if .gitignore files will be parsed in
every parent directory, and not until they reach a repository boundary.
This clarifies the current behaviour.

Signed-off-by: Andrew Berry <andrew@furrypaws.ca>
---
 Documentation/gitignore.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 53e7d5c914..534cda5747 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -27,10 +27,10 @@ precedence, the last matching pattern decides the outcome):
    them.
 
  * Patterns read from a `.gitignore` file in the same directory
-   as the path, or in any parent directory, with patterns in the
-   higher level files (up to the toplevel of the work tree) being overridden
-   by those in lower level files down to the directory containing the file.
-   These patterns match relative to the location of the
+   as the path, or in any parent directory in the same repository, with
+   patterns in the higher level files (up to the toplevel of the work tree)
+   being overridden by those in lower level files down to the directory
+   containing the file. These patterns match relative to the location of the
    `.gitignore` file.  A project normally includes such
    `.gitignore` files in its repository, containing patterns for
    files generated as part of the project build.
-- 
2.31.1

