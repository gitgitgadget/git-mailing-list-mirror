Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B29320958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934494AbdCWNGb (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:06:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35266 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753670AbdCWNG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:06:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id z133so16562419wmb.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aq8y1v8W9rTeUtHVseEccwh8kGLm7OnM4IDMGOw2xLA=;
        b=RQlyee2ADIjmMvr+O024+E6qJ2Rt37ozvOROQ6OLV0y7i9fjmZYz2CioZCpIUhIC0X
         q/L2BuKbaFncpvxGqQKga+nyYt+lVAuFC6cSw087/pA0zL0ilNOawy4LN1dVgTEC8SRR
         mG1mLKeNUFnd6WI4HkEnsOl5eHuTYgIOFUmwYO7LjTEXpGJPd3y/GAb3XYm4fXZRXuSR
         PJczMdOOxyEtuBL8zjCcrtVQq0aOX8XKve4U+Rfp3/xWuwlTwXmEVh4obrzRYdrgynY/
         hPAbPU8TJnIcRWZUbeov0s8dO/CtG7K6pOzJ4xqw8hB8nRdho2Cs28id1A2gTOeCHNAu
         rQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aq8y1v8W9rTeUtHVseEccwh8kGLm7OnM4IDMGOw2xLA=;
        b=ZxX1jnvoWvYuifglivPGQr3bSQo2YE8FTIANUE3Wiijj6N2QW3EaUNx7zz6hHr0x2t
         SPf7thGgo1/mssx6oqKuDbXoG146mB8bw8a1FZEJ5PO7KMXL8i5bwbtoAe6NJzWpdNX0
         u3XdM4srQ/YMBeSBzOZkSPvqbjtOv6be5tD8SMh4UXttj5QILWfDBi7F1onV19NImaew
         8FYEFUsefxoXFCUs1CFkLxXIk8aOaXtMbrhZoxrmS8ZzxchpidXzv50CCgm6BtXo6oGR
         5R/Fj7YMucywvvQzt0FS3CsOUXfSbdXPqPT6emCb8dqs2u0b02YUIIUEjDEeon6RZoFP
         SB7Q==
X-Gm-Message-State: AFeK/H3y8qWJsW/fEv3WRjcEUsISE2QgxLGh7S1N9P3nlCends6PK5DXZ9MrAuMeAPQm4Q==
X-Received: by 10.28.203.197 with SMTP id b188mr3069533wmg.110.1490274387217;
        Thu, 23 Mar 2017 06:06:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:06:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/16] ref-filter: add test for --contains on a non-commit
Date:   Thu, 23 Mar 2017 13:05:18 +0000
Message-Id: <20170323130529.11361-6-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170323130529.11361-1-avarab@gmail.com>
References: <20170323130529.11361-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the tag test suite to test for --contains on a tree & blob. It
only accepts commits and will spew out "<object> is a tree, not a
commit".

It's sufficient to test this just for the "tag" and "branch" commands,
because it covers all the machinery shared between "branch" and
"for-each-ref".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3201-branch-contains.sh | 9 +++++++++
 t/t7004-tag.sh             | 4 +++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 7f3ec47241..daa3ae82b7 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -130,6 +130,15 @@ test_expect_success 'implicit --list conflicts with modification options' '
 
 '
 
+test_expect_success 'Assert that --contains only works on commits, not trees & blobs' '
+	test_must_fail git branch --contains master^{tree} &&
+	blob=$(git hash-object -w --stdin <<-\EOF
+	Some blob
+	EOF
+	) &&
+	test_must_fail git branch --contains $blob
+'
+
 # We want to set up a case where the walk for the tracking info
 # of one branch crosses the tip of another branch (and make sure
 # that the latter walk does not mess up our flag to see if it was
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 45790664c1..3439913488 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1461,7 +1461,9 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag -n 100 &&
 	test_must_fail git tag -l -m msg &&
 	test_must_fail git tag -l -F some file &&
-	test_must_fail git tag -v -s
+	test_must_fail git tag -v -s &&
+	test_must_fail git tag --contains tag-tree &&
+	test_must_fail git tag --contains tag-blob
 '
 
 # check points-at
-- 
2.11.0

