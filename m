Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042871F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 19:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbeKNFwp (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 00:52:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41222 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbeKNFwp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 00:52:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id v18-v6so14697771wrt.8
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 11:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WBOOUm3dGrk20CoAx67N32u981RlnDonF6EAWzF/7MY=;
        b=fLxKSewyFp07loTbHi0IuFNgSyA1w+bnYqeaO2h1UF3NT0E7dEfvqcKQOmy/B/dz3b
         4agXu5OPBapvU6tgR7QLIOGJyO7oFbN9+m9YkuvnuEaVR/L2RK5Saenz7CATw7pFRBIZ
         HFnGDsfNeQDol2zSrCB0JLvOGjx5zHoM4sdKydcX54kiDiLKM4SWOdsZGyqLGGClxt3s
         B470BOAqCL/qyhKYLjYrq+0lPsRB2El5VWUJ3NSOHMKyzLEALSP4nVkqrsDo3QDNuiba
         Ul8lbet3g1dWOMTUr0RvZw64mqVz2zmVUWfz9iy5wd9CgfiBwQyJJI29J/ENtksGSNZz
         k3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WBOOUm3dGrk20CoAx67N32u981RlnDonF6EAWzF/7MY=;
        b=My5YMaK96r8zln1bakSTGTAYfEeY0otfB5xbzDYNt370K8dy65+a/uAXIzma+pi5yW
         xaOHO71/7/m0Ibs4XSx/aNKebv94Jv8jXPAMME9JWfVl8Bd2MVIhyU2X99ZzBugDdDnq
         2aXZApoOeHgfgwW81tU87euKTSRAEtSdMmfIZ37dZjosj4iWo3Gn3I4sdDLGCEVfJxLL
         9b3kjuW1IWeBb951X0C0UFRO18LRkoEJ6+tGOQhohyqt1a37eoDFSKlugeYqObIinTWc
         4EWSaw/cpv76tzNr5eHxWxirNiudzE3cP+rpoSUyunkBT0pxACstgXoQKNmbPnGgWWvr
         jrbw==
X-Gm-Message-State: AGRZ1gKETe54eVB9lOBopJmEJSYrgafgsfWeQxa8fu58QxaeYTfMqi9o
        IgR+3zqK58wWgfGopgN3vLjmvts1HK8=
X-Google-Smtp-Source: AJdET5dfDJxiGRKjv3pQdfbKt+O9bWm9yiOTqaarCzdAOyln9QjK8/FDhcSi0xBZIoeLDYdkZS8Orw==
X-Received: by 2002:adf:b453:: with SMTP id v19-v6mr6294325wrd.47.1542138784568;
        Tue, 13 Nov 2018 11:53:04 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y7-v6sm13828560wmy.27.2018.11.13.11.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:53:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/7] push: test that <src> doesn't DWYM if <dst> is unqualified
Date:   Tue, 13 Nov 2018 19:52:44 +0000
Message-Id: <20181113195245.14296-7-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <20181026230741.23321-1-avarab@gmail.com>
References: <20181026230741.23321-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test asserting that "git push origin <src>:<dst>" where <src> is
a branch, tag, tree or blob in refs/remotes/* doesn't DWYM when <dst>
is unqualified. This has never been the case, but there haven't been
any tests for this behavior.

See f88395ac23 ("Renaming push.", 2005-08-03), bb9fca80ce ("git-push:
Update description of refspecs and add examples", 2007-06-09) and
f8aae12034 ("push: allow unqualified dest refspecs to DWIM",
2008-04-23) which are most relevant commits that have changed or
documented the behavior of the DWYM feature in the past.

These tests were originally meant to lead up to a patch that made
refs/remotes/* on the LHS imply refs/heads/* on the RHS, see [1]. That
patch proved controversial and may not ever land in git.git, but we
should have the tests that remind us what the current behavior is in
case it's ever changed.

1. https://public-inbox.org/git/20181026230741.23321-8-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5505-remote.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index f069cbcc24..883b32efa0 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1249,5 +1249,32 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 	)
 '
 
+test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
+	(
+		cd two &&
+		git tag -a -m "Some tag" my-tag master &&
+		git update-ref refs/trees/my-head-tree HEAD^{tree} &&
+		git update-ref refs/blobs/my-file-blob HEAD:file
+	) &&
+	(
+		cd test &&
+		git config --add remote.two.fetch "+refs/tags/*:refs/remotes/tags-from-two/*" &&
+		git config --add remote.two.fetch "+refs/trees/*:refs/remotes/trees-from-two/*" &&
+		git config --add remote.two.fetch "+refs/blobs/*:refs/remotes/blobs-from-two/*" &&
+		git fetch --no-tags two &&
+
+		test_must_fail git push origin refs/remotes/two/another:dst 2>err &&
+		test_i18ngrep "error: The destination you" err &&
+
+		test_must_fail git push origin refs/remotes/tags-from-two/my-tag:dst-tag 2>err &&
+		test_i18ngrep "error: The destination you" err &&
+
+		test_must_fail git push origin refs/remotes/trees-from-two/my-head-tree:dst-tree 2>err &&
+		test_i18ngrep "error: The destination you" err &&
+
+		test_must_fail git push origin refs/remotes/blobs-from-two/my-file-blob:dst-blob 2>err &&
+		test_i18ngrep "error: The destination you" err
+	)
+'
 
 test_done
-- 
2.19.1.1182.g4ecb1133ce

