Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FA8C35673
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 18:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC52206E2
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 18:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHNfmYCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBWS5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 13:57:16 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37447 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWS5P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 13:57:15 -0500
Received: by mail-ed1-f66.google.com with SMTP id t7so9311652edr.4
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 10:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jnmhxW1Y3p4Z8GCr3INi92MATkecvv9LWbRXgPg/Hss=;
        b=IHNfmYCoireALD5PkyUcEDbzaxjdvMHY2sZkNbFsLjwQkc/V2HrbweMtEMVFql6PKK
         XosAsRUJ1XiLIf7tBanK8U+LSzH3NyZ0EX8BbvwKofN1XCGEpN0c39Z0ad6SD2K604tO
         KMTziQnTX3Pz812jkiGv0ClCZ0EeDAoVDnUabwc0xhK/8YvGWMhcG9v25suDPzInZA0w
         H6J2WYg7KBnmbgl211c/y+O20omamTeqIMZgdfSVO23h9+8zO4CD9w3sXDItDxYquD8G
         sDKxDOKXZeIIT7yFBZuzXlTmbDoRu8oWHdx5wWVvs2X86/fRHHsnF0jSL5hEjUhJaTMZ
         /Seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jnmhxW1Y3p4Z8GCr3INi92MATkecvv9LWbRXgPg/Hss=;
        b=Y9bTez9vNTNY5h8Qx/ig4dixvbrDyLYN2QWR6yHgJxpxVJSLwJW4NHmK5qsSYxhJUB
         E9Pf/fr9wcM+EoCZ5FZ95Y1l4QBYhy0U8pvsD2ww0XNcGAYuSkNiGx3C0ZazEz2MvVSX
         JOb7W0E+LS9OrilHsvsIR+M3nXrb6TrgKJHnQGrowe5nSGNXbfX3OB/LM3dIATWhQMX4
         KPO66OZcVOAl/z+d5XxUvJoD6I1vslvimCL7MPKt8vH9ZpZzFmenZIyhnvEpt2h0CVsc
         utIKItDA/K71S4jZcdQCdCZqNHfMuSZOe0bI45P+8IivO82+YTrjsKefKMkO+UG2sG/k
         3lTQ==
X-Gm-Message-State: APjAAAVYessCCdZdfznOCZJb5mD0q19mdjz56xYI7adRMwqpQFB+Vs/S
        Ii4yN3WrecewKyJcag+81uJb/zI0
X-Google-Smtp-Source: APXvYqzUp7HDjMYS04yWXyc14itBw1ElDQ3bRLQsHfBdtD1DpGS4tNntxCDh3p3XId5p1lpzh5s3RQ==
X-Received: by 2002:a50:eb04:: with SMTP id y4mr42041695edp.170.1582484233962;
        Sun, 23 Feb 2020 10:57:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cb8sm657083ejb.42.2020.02.23.10.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 10:57:13 -0800 (PST)
Message-Id: <ae749310f067c43429741987cd9f47c1ae4ceb3f.1582484231.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.535.v3.git.1582484231.gitgitgadget@gmail.com>
References: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
        <pull.535.v3.git.1582484231.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 23 Feb 2020 18:57:09 +0000
Subject: [PATCH v3 2/3] t5509: use a bare repository for test push target
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

`receive.denyCurrentBranch` currently has a bug where it allows pushing
into non-bare repository using namespaces as long as it does not have any
commits. This would cause t5509 to fail once that bug is fixed because it
pushes into an unborn current branch.

In t5509, no operations are performed inside `pushee`, as it is only a
target for `git push` and `git ls-remote` calls. Therefore it does not
need to have a worktree. So, it is safe to change `pushee` to a bare
repository.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 t/t5509-fetch-push-namespaces.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index 75cbfcc392c..e3975bd21de 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -20,7 +20,7 @@ test_expect_success setup '
 	) &&
 	commit0=$(cd original && git rev-parse HEAD^) &&
 	commit1=$(cd original && git rev-parse HEAD) &&
-	git init pushee &&
+	git init --bare pushee &&
 	git init puller
 '
 
-- 
gitgitgadget

