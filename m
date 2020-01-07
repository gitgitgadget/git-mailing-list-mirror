Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BE7C33C9B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 21:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449F3222D9
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 21:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDnDzmIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgAGV1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:27:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37448 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgAGV1G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 16:27:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so365639wmf.2
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 13:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pQShPUpfJKh2EXoOKJW4J+2FQKvLVTm5FR/RHAPciB0=;
        b=RDnDzmIJXAnRenzTHRd2Lg9NNnmJVuyopE+bcs3lVY4/Ta5lFAzpOEbJDksH9irx22
         zk2NI778DusgVIZOfTQVQ2nkNORBt7u1PYMB9TM+wnpKMOgE8BSVMYCZM9A5MQb3Q4bd
         ncBst4UmAgDwouN3M53RYu5+BRh/Ca3v8gheyOHLU9LXtPFI9VmIvqCJWIKEEcF8PubO
         63pxUgS83EhLoFdXteuMIdNnLmTEPIUS0YpobwtQc6jIvz7PkPSibT+E3zd2v6KMA9Ks
         eHXEKFcju9gvgBqSDfnRWglQw2bRZuezD7DcMFsyLyx3w5w/ZmAE536/6ihn8dq8G9aQ
         oSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pQShPUpfJKh2EXoOKJW4J+2FQKvLVTm5FR/RHAPciB0=;
        b=j5K6ntBUyNK/pgSVGiyg0BLRlBFisTIJ2/b2ZWtHQ2qMFWDZA7h4FD2oRMdpa++7UO
         ZjrENybxwNNcxKsaOoN7e/OAMDnDhlFogMv6bL/r69+N7/sLZb9A7ZCYnlC7waZHLicU
         LsiN+xbZvkNE/AA1VXRXyynoT1bAywP913+j81nmmgbclD2ZTZGSmIetN1An6y65MACp
         QiyaE0oJJDFincFCEtyM8UG7a4VGKuo3x9OXtIgkDaOELg3XaaciL6XDHvGemcnLmJut
         lz67og5xb0ezflkIw4dJJsP2KduMSaNm3CAAnpNES4jngZX6w0Z8e62qgU8Ax7lZWEC2
         hn9w==
X-Gm-Message-State: APjAAAUuWwKxeyfLE2EQZRHbnXAPBoGl0tMOxrNiwpCUK55/b84Etn0e
        Kn0uryI1Zb0Qdu/aA1Al0MgDox1S
X-Google-Smtp-Source: APXvYqwrhCJ8VhieSbpz82fTTjSlazoNPGTVkU5feS683SOqyk2nGUEbGc0x4eVzWKEbbE9rM40zDQ==
X-Received: by 2002:a1c:1dd7:: with SMTP id d206mr323664wmd.5.1578432424219;
        Tue, 07 Jan 2020 13:27:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18sm1504629wru.50.2020.01.07.13.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 13:27:03 -0800 (PST)
Message-Id: <c05fe2c37a87b254157eec1c8a0f8ca206e1cd31.1578432422.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.517.v2.git.1578432422.gitgitgadget@gmail.com>
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
        <pull.517.v2.git.1578432422.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 21:27:01 +0000
Subject: [PATCH v2 1/2] graph: fix case that hit assert()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, brad@brad-smith.co.uk, sunshine@sunshineco.com,
        James Coglan <jcoglan@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

A failure was reported in "git log --graph --all" with the new
graph-rendering logic. The code fails an assert() statement when
collapsing multiple edges from a merge.

The assert was introduced by eaf158f8 (graph API: Use horizontal
lines for more compact graphs, 2009-04-21), which is quite old.
This assert is trying to say that when we complete a horizontal
line with a single slash, it is because we have reached our target.

This assertion is hit when we have two collapsing lines from the
same merge commit, as follows:

    | | | | *
    | |_|_|/|
    |/| | |/
    | | |/|
    | |/| |
    | * | |
    * | | |

It is actually the _second_ collapsing line that hits this assert.
The reason we are in this code path is because we are collapsing
the first line, and in that case we are hitting our target now
that the horizontal line is complete. However, the second line
cannot be a horizontal line, so it will collapse without horizontal
lines. In this case, it is inappropriate to assert that we have
reached our target, as we need to continue for another column
before reaching the target. Dropping the assert is safe here.

The new behavior in 0f0f389f12 (graph: tidy up display of
left-skewed merges, 2019-10-15) caused the behavior change that
made this assertion failure possible. In addition to making the
assert possible, it also changed how multiple edges collapse.

In a larger example, the current code will output a collapse
as follows:

	| | | | | | *
	| |_|_|_|_|/|\
	|/| | | | |/ /
	| | | | |/| /
	| | | |/| |/
	| | |/| |/|
	| |/| |/| |
	| | |/| | |
	| | * | | |

However, the intended collapse should allow multiple horizontal lines
as follows:

	| | | | | | *
	| |_|_|_|_|/|\
	|/| | | | |/ /
	| | |_|_|/| /
	| |/| | | |/
	| | | |_|/|
	| | |/| | |
	| | * | | |

This behavior is not corrected by this change, but is noted for a later
update.

Helped-by: Jeff King <peff@peff.net>
Reported-by: Bradley Smith <brad@brad-smith.co.uk>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 graph.c                      |  4 ----
 t/t4215-log-skewed-merges.sh | 42 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/graph.c b/graph.c
index 66ae18add8..f514ed3efa 100644
--- a/graph.c
+++ b/graph.c
@@ -1219,13 +1219,9 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 			 *
 			 * The space just to the left of this
 			 * branch should always be empty.
-			 *
-			 * The branch to the left of that space
-			 * should be our eventual target.
 			 */
 			assert(graph->mapping[i - 1] > target);
 			assert(graph->mapping[i - 2] < 0);
-			assert(graph->mapping[i - 3] == target);
 			graph->mapping[i - 2] = target;
 			/*
 			 * Mark this branch as the horizontal edge to
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 18709a723e..ddf6f6f5d3 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -240,4 +240,46 @@ test_expect_success 'log --graph with octopus merge with column joining its penu
 	EOF
 '
 
+test_expect_success 'log --graph with multiple tips' '
+	git checkout --orphan 6_1 &&
+	test_commit 6_A &&
+	git branch 6_2 &&
+	git branch 6_4 &&
+	test_commit 6_B &&
+	git branch 6_3 &&
+	test_commit 6_C &&
+	git checkout 6_2 && test_commit 6_D &&
+	git checkout 6_3 && test_commit 6_E &&
+	git checkout -b 6_5 6_1 &&
+	git merge --no-ff 6_2 -m 6_F &&
+	git checkout 6_4 && test_commit 6_G &&
+	git checkout 6_3 &&
+	git merge --no-ff 6_4 -m 6_H &&
+	git checkout 6_1 &&
+	git merge --no-ff 6_2 -m 6_I &&
+
+	check_graph 6_1 6_3 6_5 <<-\EOF
+	*   6_I
+	|\
+	| | *   6_H
+	| | |\
+	| | | * 6_G
+	| | * | 6_E
+	| | | | * 6_F
+	| |_|_|/|
+	|/| | |/
+	| | |/|
+	| |/| |
+	| * | | 6_D
+	| | |/
+	| |/|
+	* | | 6_C
+	| |/
+	|/|
+	* | 6_B
+	|/
+	* 6_A
+	EOF
+'
+
 test_done
-- 
gitgitgadget

