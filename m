Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2C1E1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390961AbfIEWEz (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:04:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38527 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfIEWEz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:04:55 -0400
Received: by mail-io1-f68.google.com with SMTP id p12so8309622iog.5
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hx0JhVRD8KfXO3QJ+mr2aw55f/Gw86K6j5hHPQpXDT8=;
        b=WY3vj4ZexoMtMDiMBXPBCeC3xN2k6F6vRzcctIDHYeXDkZHRamyoJjqOCVjHXZj3t4
         3sthXy5dRL117nXqqXw42UN08OCFn9hBIwDZqJ06IjsvXCKpU+SyPao5C12cR+Ixf/nx
         Bf7kxTjcdMvtkYGeUvnTerd5WzWpIJ+LkVxXeejDCCjShKSJJfD6tzB40JwfkzD5xDrx
         mPx32VPLaRXKn5Dqa2uRcpjf2Olmn5/FzOCqpoTZQeL6jowV5QjhiXoVRVyh5A+pPYRq
         xgWn59vKJMkRFT2kzn+e36RPJakCOHQ48l26i3jHf6AlAeZZQlFdP6c9r5YIbQ7HMsPI
         6HQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hx0JhVRD8KfXO3QJ+mr2aw55f/Gw86K6j5hHPQpXDT8=;
        b=r8dC2WEHJK1Mgs+IA8uqhQ84ubcU/ftFgkdI/tCybKkb1Hdpjwe/FC1u7xw6+dUUeg
         2nJqAP+Y/1qym2MdfjoP4R9cFBoWBg4/e8qtBSoVKhGOzPIhDTyDI4SfjveA1CJj6eKr
         edxZlFW6kjVJv2Q+hjxi0iRI2+Nefp7f3QjxQeeC6BgUAp2fa5mm7ZzDZ50KIQmYQRp7
         M+1iGRQDj4S5K0NY4L12UNwRxgQmd/hCV98M67XRFd6bF70Yv7esHAVlxZ5+XPtXXOoC
         IjEfR8+NH6raRfeAxKnuPbF7pOKWlP3MhCetwWXqr3T5Ze1GwwRoOWA9agSxST01v7db
         JPfg==
X-Gm-Message-State: APjAAAVqItPMZ5z237JU+8R6QlZ9SuPxEcLlyTLLQg3ftH3QAI+BdotA
        nuo4cIYy6xljfci4Tk6GEhDTh1hIG/qOMg==
X-Google-Smtp-Source: APXvYqyoxsbheUSmg4LXbUdVAXT1or92VYa6Syyni6wf8kOGjnFlpRNWChyoyiPEoeIlhQhvBoGQPQ==
X-Received: by 2002:a5e:c311:: with SMTP id a17mr6819677iok.140.1567721094498;
        Thu, 05 Sep 2019 15:04:54 -0700 (PDT)
Received: from localhost ([2601:401:c500:7dd8:3c19:faad:a3bb:990d])
        by smtp.gmail.com with ESMTPSA id r138sm5349748iod.59.2019.09.05.15.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 15:04:54 -0700 (PDT)
Date:   Thu, 5 Sep 2019 18:04:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, peff@peff.net
Subject: [PATCH 1/3] t/t5318: introduce failing 'git commit-graph write' tests
Message-ID: <042a8ba8b2a98c269f9cd1a8e88488b80d686f0d.1567720960.git.me@ttaylorr.com>
References: <cover.1567720960.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1567720960.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When invoking 'git commit-graph' in a corrupt repository, one can cause
a segfault when ancestral commits are corrupt in one way or another.
This is due to two function calls in the 'commit-graph.c' code that may
return NULL, but are not checked for NULL-ness before dereferencing.

Before fixing the bug, introduce two failing tests that demonstrate the
problem. The first test corrupts an ancestral commit's parent to point
to a non-existent object. The second test instead corrupts an ancestral
tree by removing the 'tree' information entirely from the commit. Both
of these cases cause segfaults, each at different lines.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5318-commit-graph.sh | 43 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index ab3eccf0fa..c855f81930 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -585,4 +585,47 @@ test_expect_success 'get_commit_tree_in_graph works for non-the_repository' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'corrupt commit-graph write (broken parent)' '
+	rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+		empty="$(git mktree </dev/null)" &&
+		cat >broken <<-EOF &&
+		tree $empty
+		parent 0000000000000000000000000000000000000000
+		author whatever <whatever@example.com> 1234 -0000
+		committer whatever <whatever@example.com> 1234 -0000
+
+		broken commit
+		EOF
+		broken="$(git hash-object -w -t commit --literally broken)" &&
+		git commit-tree -p "$broken" -m "good commit" "$empty" >good &&
+		test_must_fail git commit-graph write --stdin-commits \
+			<good 2>test_err &&
+		test_i18ngrep "unable to parse commit" test_err
+	)
+'
+
+test_expect_failure 'corrupt commit-graph write (missing tree)' '
+	rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+		tree="$(git mktree </dev/null)" &&
+		cat >broken <<-EOF &&
+		parent 0000000000000000000000000000000000000000
+		author whatever <whatever@example.com> 1234 -0000
+		committer whatever <whatever@example.com> 1234 -0000
+
+		broken commit
+		EOF
+		broken="$(git hash-object -w -t commit --literally broken)" &&
+		git commit-tree -p "$broken" -m "good" "$tree" >good &&
+		test_must_fail git commit-graph write --stdin-commits \
+			<good 2>test_err &&
+		test_i18ngrep "unable to get tree for" test_err
+	)
+'
+
 test_done
-- 
2.23.0

