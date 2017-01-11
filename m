Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F59A205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 18:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754099AbdAKSrn (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 13:47:43 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36774 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753918AbdAKSrm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 13:47:42 -0500
Received: by mail-pf0-f180.google.com with SMTP id 189so51870228pfu.3
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 10:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XVKbIEE5CQWkhOFS50vM9d/qRQK+eqKnWZQNZtC15+c=;
        b=ndVvFpsMS1wURETV4FtXg6fClGd+NYlx74b8tS14VAK4M+WH8/G+po9shMxbHSE9dQ
         Z7z2MhVsgvxZnnscaRGdYcQb2EA05221eVPyqL/lS6uZHQpqE7XJ7o0+g7GjKKeP7+ZL
         71KmBqfWzBbmPCqepUv9a3qLnSc9MJhstlTcBp0kVeddA86KHTmP5ozKLMufg2x+lPXc
         VkMCgUfWOF31V4LKvgMY8b0quiwtvPEV6/vjLehBrZ20M53KGIlh/wpPAbvB/ZVIN3px
         9nToto6wByPqFRTzGKX7D6d5FsOAGQeX9Dm79WqOlapnVgqx1mMFDBBYMKzvFfa5ANxY
         ktSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XVKbIEE5CQWkhOFS50vM9d/qRQK+eqKnWZQNZtC15+c=;
        b=Ew62xudfxHc7di2yQl/wK7TYjWvKe+FM9ck1e9V/ZvcaosSm7eJ4Zgpm2JRE+6S3Fo
         pviIIJM0aK9RPmIk6bPaM0CN9g0uDwWLgntc5JV1VoFLiwZg1DuZlbk1XPfvwdAMNKcv
         J9PLDWKkRVsgtztsEUt0LS8n3LML11opZ2JC197tXMCeKN3IbKk/bjOC/zwyOXjBE1FP
         CEJN4WnTY0qsEajFytMDQISuNwU/2rI+BMFrkDnIJtv05oQsMc7XxYg9fKAiMkUV1fwE
         Iiu+2yOvCv+HizXvSiIUs7PEbd5w33HASMISRmK40QWVRAL9cVgONDtPdaBKMKstu7/z
         Y35Q==
X-Gm-Message-State: AIkVDXIbLuoSNHSDtKbFPBEWzuNceHtb/d3sCLGBRlEKo0SrxO/eHpNYymkYlJeTjk70s+gb
X-Received: by 10.84.179.194 with SMTP id b60mr15492758plc.147.1484160461312;
        Wed, 11 Jan 2017 10:47:41 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:f4d3:924a:46a9:5f47])
        by smtp.gmail.com with ESMTPSA id s8sm15580456pfj.30.2017.01.11.10.47.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Jan 2017 10:47:40 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] lib-submodule-update.sh: drop unneeded shell
Date:   Wed, 11 Jan 2017 10:47:32 -0800
Message-Id: <20170111184732.26416-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.259.g7b30ecf4f0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In modern Git we prefer "git -C <cmd" over "(cd <somewhere && git <cmd>)"
as it doesn't need an extra shell.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

And because it is in a setup function, we actually save the invocation
of 22 shells for a single run of the whole test suite.

Noticed while adding a lot more in near vincinity, though not as near
to cause merge conflicts, so sending it extra.

Thanks,
Stefan

 t/lib-submodule-update.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 79cdd34a54..915eb4a7c6 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -69,10 +69,7 @@ create_lib_submodule_repo () {
 
 		git checkout -b "replace_sub1_with_directory" "add_sub1" &&
 		git submodule update &&
-		(
-			cd sub1 &&
-			git checkout modifications
-		) &&
+		git -C sub1 checkout modifications &&
 		git rm --cached sub1 &&
 		rm sub1/.git* &&
 		git config -f .gitmodules --remove-section "submodule.sub1" &&
-- 
2.11.0.259.g7b30ecf4f0

