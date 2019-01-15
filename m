Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32CF81F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 15:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfAOPHV (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 10:07:21 -0500
Received: from [192.252.130.194] ([192.252.130.194]:25436 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728653AbfAOPHV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 10:07:21 -0500
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id 15AB1A2102;
        Tue, 15 Jan 2019 10:07:19 -0500 (EST)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv2] new-workdir: Never try to recurse into submodules on the initial checkout.
Date:   Tue, 15 Jan 2019 10:07:19 -0500
Message-Id: <20190115150719.19277-1-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.20.1.1.gfb6d716d28
In-Reply-To: <20190114172702.19959-1-marcnarc@xiplink.com>
References: <20190114172702.19959-1-marcnarc@xiplink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new workdir is empty before the checkout, so attempts to recurse into
a non-existent submodule directory fail.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

Changed to use --no-recurse-submodules instead of -c submodule.recurse=false,
as Jonathan suggested.

		M.

 contrib/workdir/git-new-workdir | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 888c34a521..d88765e73f 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -102,4 +102,4 @@ trap - $siglist
 
 # checkout the branch (either the same as HEAD from the original repository,
 # or the one that was asked for)
-git checkout -f $branch
+git checkout --no-recurse-submodules -f $branch
-- 
2.20.1.1.gfb6d716d28

