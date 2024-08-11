Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7655E1537C7
	for <git@vger.kernel.org>; Sun, 11 Aug 2024 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723397695; cv=none; b=O/OnPnxyP2e7yl4R+Pbu2ZAzB8cUOIuFjs+ojFW7jEufWJdRZPbM7yLgwmCWyS/6tYJyLAYhyzlW6UCBaXifA8UsRrpHpBKwILztcxNsQG4/6ast5WTPDcBbcuf+mJWQdFivTpmBto6TXkc5e8Vs6N5CWK4OIpEmJtRrUAvixNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723397695; c=relaxed/simple;
	bh=jgBi6oNQL+qdRE7utMh8FfsQo+FyxbRlKAjlGaLSrHE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hlbV8CA7/mTIbOysyPJvPbIRpOM7Uu3cwyuPyd/d20gLqBX8Mcxa6x88EYqDW8iptt5FkIUaG3W6OFVkPCotmGJG4HAhpPzsWBIQMLqm0WXuqbRQDNiuC/Qr6yw/gnJFe91Hmz+IIsUSEJdJ0/MSKBMMfHG4gJqPQ1wuL7c0jl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4OHMZm5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4OHMZm5"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428243f928fso35520035e9.0
        for <git@vger.kernel.org>; Sun, 11 Aug 2024 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723397691; x=1724002491; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56hSNiOlt1LylH+n3beA4JrC5B+sMVlxoMQsGPznpV4=;
        b=l4OHMZm5/FA/JBjx8Q4AVg/ucC+ceSHSdQEJuPVMsXLT7qdijYPmg3YJechp3/Y7w4
         NVN52SZUO8me299HXq4pFUvpG2c3zNGHZ4zFFJBfha3R+9zt/W4OWkaMkrfrD23NjYJY
         I1N180bQm80VZXVepzHCcD1ZsSlTV4Au4O376ufzhbp7lEwWOdxEvH5yaXW4dmcijGNy
         lhngoRw0YvexAEGxheVIpq8NIvS+lkKH+qk8/h7l/oqj3GPTOJd80K91ihuAjVtjYnRA
         bNkJZOFofumvfZsKUl9G3I3kw5MW4KQEb1dK1O5f0DK/XJ+wqep0xxke0a0HESBFeSQC
         j9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723397691; x=1724002491;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56hSNiOlt1LylH+n3beA4JrC5B+sMVlxoMQsGPznpV4=;
        b=iC5j1tDrqj23fvivlCLmojosl4oG+LUPGGE76KF7a1ZZ9ksGJyIqrWKXJ+hhNxsO+M
         d3KuVrJ5jlEs2bto9HEUkYgsikeNK++rvkVfAWCQyj+S2Al1sPm8k0i3zX0BnGl7QtTt
         mz//iR+dfhMxN+SbBwufNFH7auWXERJAyVvLgdlxSg72OpyDjC+Jng46ZSLcWx7ThsM3
         /8Xm6i7gRNHk8wYfImEPNfZ/G0A/tygjo3bkOtkE/p/ncR8eSkhjAixyChBmGZ2b/D+9
         hidKmuHhQqN9sx5TGkGakf0uiKBrrOQ7EeEAt8VjWk+2+cQWuJl6KLh0yyumB9MGwnIq
         UoCQ==
X-Gm-Message-State: AOJu0YzEe9VO/FDzlYzifC+HdwQAt0QTnu4iffnu844lkeGU1mRBQyWw
	P8NJLiAI5CPNIcQdWRaUlkdiUq0RjQOGQGGigVvdkGxfBNVz+q8sNrB90A==
X-Google-Smtp-Source: AGHT+IERKq450yzqZEgcnl+oOlEEO0o2pntUMWxMrW4CRZ9yms49Kd2IXDvllbbDzGWrt7XZubbmYw==
X-Received: by 2002:a05:600c:190c:b0:428:f0a:3f92 with SMTP id 5b1f17b1804b1-429c3a2a3d2mr62774255e9.21.1723397691249;
        Sun, 11 Aug 2024 10:34:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c77374a5sm73415535e9.30.2024.08.11.10.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 10:34:50 -0700 (PDT)
Message-Id: <757c20090dbcca7b87c30138bd383eb55656ba90.1723397687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
References: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
	<pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Aug 2024 17:34:47 +0000
Subject: [PATCH v2 3/3] p1500: add is-base performance tests
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    vdye@github.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous two changes introduced a commit walking heuristic for finding
the most likely base branch for a given source. This algorithm walks
first-parent histories until reaching a collision.

This walk _should_ be very fast. Exceptions include cases where a
commit-graph file does not exist, leading to a full walk of all reachable
commits to compute generation numbers, or a case where no collision in the
first-parent history exists, leading to a walk of all first-parent history
to the root commits.

The p1500 test script guarantees a complete commit-graph file during its
setup, so we will not test that scenario. Do create a new root commit in an
effort to test the scenario of parallel first-parent histories.

Even with the extra root commit, these tests take no longer than 0.02
seconds on my machine for the Git repository. However, the results are
slightly more interesting in a copy of the Linux kernel repository:

Test
---------------------------------------------------------------
1500.2: ahead-behind counts: git for-each-ref              0.12
1500.3: ahead-behind counts: git branch                    0.12
1500.4: ahead-behind counts: git tag                       0.12
1500.5: contains: git for-each-ref --merged                0.04
1500.6: contains: git branch --merged                      0.04
1500.7: contains: git tag --merged                         0.04
1500.8: is-base check: test-tool reach (refs)              0.03
1500.9: is-base check: test-tool reach (tags)              0.03
1500.10: is-base check: git for-each-ref                   0.03
1500.11: is-base check: git for-each-ref (disjoint-base)   0.07

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p1500-graph-walks.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/perf/p1500-graph-walks.sh b/t/perf/p1500-graph-walks.sh
index e14e7620cce..5b23ce5db93 100755
--- a/t/perf/p1500-graph-walks.sh
+++ b/t/perf/p1500-graph-walks.sh
@@ -20,6 +20,21 @@ test_expect_success 'setup' '
 		echo tag-$ref ||
 		return 1
 	done >tags &&
+
+	echo "A:HEAD" >test-tool-refs &&
+	for line in $(cat refs)
+	do
+		echo "X:$line" >>test-tool-refs || return 1
+	done &&
+	echo "A:HEAD" >test-tool-tags &&
+	for line in $(cat tags)
+	do
+		echo "X:$line" >>test-tool-tags || return 1
+	done &&
+
+	commit=$(git commit-tree $(git rev-parse HEAD^{tree})) &&
+	git update-ref refs/heads/disjoint-base $commit &&
+
 	git commit-graph write --reachable
 '
 
@@ -47,4 +62,20 @@ test_perf 'contains: git tag --merged' '
 	xargs git tag --merged=HEAD <tags
 '
 
+test_perf 'is-base check: test-tool reach (refs)' '
+	test-tool reach get_branch_base_for_tip <test-tool-refs
+'
+
+test_perf 'is-base check: test-tool reach (tags)' '
+	test-tool reach get_branch_base_for_tip <test-tool-tags
+'
+
+test_perf 'is-base check: git for-each-ref' '
+	git for-each-ref --format="%(is-base:HEAD)" --stdin <refs
+'
+
+test_perf 'is-base check: git for-each-ref (disjoint-base)' '
+	git for-each-ref --format="%(is-base:refs/heads/disjoint-base)" --stdin <refs
+'
+
 test_done
-- 
gitgitgadget
