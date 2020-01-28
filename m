Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81744C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5854B20716
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8JSonop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgA1S04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:26:56 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41519 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgA1S0y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 13:26:54 -0500
Received: by mail-wr1-f47.google.com with SMTP id c9so17219961wrw.8
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 10:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sEiFWOSlQ42jvfb1L5PRzdSfTmJ8VuICjLeI6WuAohQ=;
        b=a8JSonopEM+fHml86JpD3yKByrfXijEHUbv/Dii+nZnXjeHdg/gYh+jOBNo65l+MaT
         uzdAN4T8jac8b8jXm9PpZJvngKOBAMRJn4YyhJwytA1ehodTUl/CSK8DWkzksKIeLTad
         TY5Q316tSXNrcXLhtamyhzo8srhfyggJOY9nUSAHF9XwgOwE1og70TmavK952EKB1R3G
         1SqA6Af0jEasEbJFMxFQJYeCtX8DcAlYNUAUof1GhgnW9sEg4peSKg/uzFehGvXX/vXN
         LMrXbcSg3KaXTw44+sp2g/mDZJsLTeTWUtyccwmVHpJLmSvCQdP5S67No96qZwL1PHx4
         b+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sEiFWOSlQ42jvfb1L5PRzdSfTmJ8VuICjLeI6WuAohQ=;
        b=cNRzdrRpOKVV90h0cMAGGgXnJhVweARZOjE38BUQ81nG3TVHFJDmigqbU9flRc+YRN
         fXv+PxvzLBIbWu6hq8lpw/73tKmgVK3Ng+EQkwlfTsEke0v5MusXs8/U4w5RL0T8g9bC
         0PQILjj7h8E1WrTPkYe4RjrXKuuQgtexNJ6caev3MI4YW9jCgI9lnBkXx+sDoCSvB30Y
         nybquN9NjOU+tDBOISHiz6Vq1unF+53CLeKH8pbCM9CtHnu4vp35NKAOG06h/Ql6r+MA
         igZtg1/cLJjdBu5eZwHNj2z+Oi4ycH52LeR0/xL2VI8avcMekvEXHEy6/d3mH8Q3zaYZ
         F5Mw==
X-Gm-Message-State: APjAAAV1XSGvItFI2+pHHhNhJwvxz09q0skjU9+FHXCjL/VlkcuyAg42
        DnBMk93qbdhIWTEDyF12N4NYx8Xv
X-Google-Smtp-Source: APXvYqxnaggKpQhrw1c85lpWWJdAkKoV3+PXu1rmqj2KofjUfBypRnO0kzZAfnc2Wx1kDNf0CXKxGA==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr29588803wrn.384.1580236012802;
        Tue, 28 Jan 2020 10:26:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm27924281wrw.36.2020.01.28.10.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:26:52 -0800 (PST)
Message-Id: <ec714a4cf04e86f55057e17109a29e74021b73bf.1580236003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
        <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jan 2020 18:26:42 +0000
Subject: [PATCH v3 11/12] sparse-checkout: use C-style quotes in 'list'
 subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When in cone mode, the 'git sparse-checkout list' subcommand lists
the directories included in the sparse cone. When these directories
contain odd characters, such as a backslash, then we need to use
C-style quotes similar to 'git ls-tree'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 6 ++++--
 t/t1091-sparse-checkout-builtin.sh | 7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 61414fef18..b3c1e97dba 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -78,8 +78,10 @@ static int sparse_checkout_list(int argc, const char **argv)
 
 		string_list_sort(&sl);
 
-		for (i = 0; i < sl.nr; i++)
-			printf("%s\n", sl.items[i].string);
+		for (i = 0; i < sl.nr; i++) {
+			quote_c_style(sl.items[i].string, NULL, stdout, 0);
+			printf("\n");
+		}
 
 		return 0;
 	}
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 459715d541..7617fb027a 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -392,7 +392,8 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
 	EOF
 	test_cmp expect escaped/.git/info/sparse-checkout &&
 	check_read_tree_errors escaped "a zbad\\dir zdoes*exist" &&
-	git -C escaped ls-tree -d --name-only HEAD | git -C escaped sparse-checkout set --stdin &&
+	git -C escaped ls-tree -d --name-only HEAD >list-expect &&
+	git -C escaped sparse-checkout set --stdin <list-expect &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
@@ -403,7 +404,9 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
 	/zdoes\*exist/
 	EOF
 	test_cmp expect escaped/.git/info/sparse-checkout &&
-	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist"
+	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" &&
+	git -C escaped sparse-checkout list >list-actual &&
+	test_cmp list-expect list-actual
 '
 
 test_done
-- 
gitgitgadget

