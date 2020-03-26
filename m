Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890B2C2D0E7
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619D82070A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcDixF0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgCZI2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:28:20 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40206 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgCZI2U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:28:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id l25so5548398qki.7
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/AsdvesCcNuKy+GJVPCFBByvyQ5W6NdG+7vAcWePzVc=;
        b=NcDixF0PJFwWJHYi9gyZObWxa0Gj1HCn0jPxUzTVvQG9vuRa21T320LnKaUBo+MJgF
         oENtUXntvlydL/dKWR17UBomFxQSeKBiQsnD/E0kCSWTB9bvE8w9aWCRX0ijh0j5VeqE
         l/8ni5OcQ/bfMgXU2Ii9ljk/F/RX09vvhzprN0uQcfErvc3LtetPTKJ3odblkmhYS5v8
         c7y9lFvFZlsywtUgVkz1sc2AkQlqq+agxzin94tBRtEkmBB9hajMUj9IXEnfQ2izAtlP
         yKx3FYg9McIr561jgnqeDnK759pZXRbt9yi9k6RhmIAY12HNMDFGzRLiL6gyT/l3oGFD
         Q3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/AsdvesCcNuKy+GJVPCFBByvyQ5W6NdG+7vAcWePzVc=;
        b=fhPeEDo9KNGn4ABanspG6meqdYiKj4dmB1lHYOSmkrd6N3WKePDR+CVgMPry/YDwqF
         H0af4SRyq52QqMkyR4zk3DF2I8fSLcy1MAKXpj7OFO8TJdNUZ1nKqIbC6RlpMTmLrCS4
         //IBDtVQUqvWzcFLLzNm/FsHcE8oLJEnVvPw893hLL16Dl+m38KDR0mIMlHsY5s85UOJ
         XIOraJU4grk0PdwuWP5ixmtmAnMwnfuoPpUZKoW4t8MRP1yBX2IymUIIYKV5USmFK4cY
         2M1JfWV+Q/Jxz3c3L2ZFnR2rDON2OlJqR6r/MdaGc7nioep5FNFJvVwtpmZqVRZq6AI6
         e7LA==
X-Gm-Message-State: ANhLgQ0+MkD04OpYOsP6klMTfdrGPW2qp+NsNQ4WhA1xIPzfBBaVOpcI
        4RrJijaRovRvxXM8I0juSeJTYyYE
X-Google-Smtp-Source: ADFU+vsNiTvKWCheannuaS0N696N+y2krwxsYCE5Uf8DOS4XaoVQFq1zYSL5tfM+kLv+m6/ffWWELg==
X-Received: by 2002:a37:496:: with SMTP id 144mr6753888qke.403.1585211297901;
        Thu, 26 Mar 2020 01:28:17 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id g187sm935789qkf.115.2020.03.26.01.28.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 01:28:17 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 3/8] t5512: stop losing return codes of git commands
Date:   Thu, 26 Mar 2020 04:27:50 -0400
Message-Id: <986ba1dd3921251a03c1c4cf92e7439e012b07ed.1585209554.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585209554.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com> <cover.1585209554.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a pipe, only the return code of the last command is used. Thus, all
other commands will have their return codes masked. Rewrite pipes so
that there are no git commands upstream so that their failure is
reported.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5512-ls-remote.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index dcb7349b0b..8928d1f62d 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -21,11 +21,11 @@ test_expect_success setup '
 	git tag mark1.1 &&
 	git tag mark1.2 &&
 	git tag mark1.10 &&
-	git show-ref --tags -d | sed -e "s/ /	/" >expected.tag &&
-	(
-		echo "$(git rev-parse HEAD)	HEAD" &&
-		git show-ref -d	| sed -e "s/ /	/"
-	) >expected.all &&
+	git show-ref --tags -d >expected.tag.raw &&
+	sed -e "s/ /	/" expected.tag.raw >expected.tag &&
+	generate_references HEAD >expected.all &&
+	git show-ref -d	>refs &&
+	sed -e "s/ /	/" refs >>expected.all &&
 
 	git remote add self "$(pwd)/.git"
 '
@@ -185,8 +185,8 @@ do
 		test_config $configsection.hiderefs refs/tags &&
 		git ls-remote . >actual &&
 		test_unconfig $configsection.hiderefs &&
-		git ls-remote . |
-		sed -e "/	refs\/tags\//d" >expect &&
+		git ls-remote . >expect.raw &&
+		sed -e "/	refs\/tags\//d" expect.raw >expect &&
 		test_cmp expect actual
 	'
 
-- 
2.26.0.159.g23e2136ad0

