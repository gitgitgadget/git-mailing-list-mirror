Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723B6C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 04:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DC620705
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 04:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3Ca7+GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgAHE17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 23:27:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39635 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgAHE17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 23:27:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so1895254wrt.6
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 20:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2ygyq47roKzG+XXGTquJj8wOXE9edWS1J294jagnwXA=;
        b=C3Ca7+GWyRypuQTsRhxbrZTptI+7bEdMnOPvWWi/liEuRg4KUBtwOCyx71gXjP81VM
         mczPDQEOGNlCP8q9LBntPRuuEQtfb9N/QFn7rnIJL2Zf7QlZIU39RTSHm+0cr1X7RtZ8
         c6A8q91IVqBSLVP3Plbj7juCqQM+mcYYswjFDOxMxwloVXj668GX/8VnrNbDJ3IQJibS
         bMvIXGq45pVJbmNFg+xBUTUmRB/W0fsqkAfwsDYWoKLYJxiB/C5eQojeJVreqDjTvFTI
         DY32i8iVsrF6hxsbtgumeuxc5H5udv5C0C5k1UQJGyjDinaVkD6X6Fr/hNkEhFKUxmXY
         ch8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2ygyq47roKzG+XXGTquJj8wOXE9edWS1J294jagnwXA=;
        b=KW9oo14xUTreG4usAOnxs0fle3djTAFJJyf2nYFKZXM0OCdIz3iA4kXDXl65c4EJB8
         CNGyPZbcoRUU0HPfH6gXAgCMKHe1k43TaklmA08iZ/idszPXTUQNjrwyJeFgEuc5lX+p
         JGRhJaTFcUuKiAKi8qQJG4QKFtVI58sfiBaKHcv92oYBslKTphU3wEgZJd1ubmTElzuX
         ZbH7TSTeApLlSapfgtuxv3nx3LpCet8o/mkvK4ujF1Kpa6Okqqn3Jf8D8xBW2umPheq6
         LxsF3RFf68LEjOg8j/oz8SzyqJORRGhCy5bv3wp3UNqxAAHELPyowIVZr8rEV9HcMZdP
         /AFg==
X-Gm-Message-State: APjAAAUrpInnT7N1h1Gnx7vDGaLVwaKLOr5jK9zQF532E95pwMvHFeHv
        VRicJpnonMrKTdh2mL15i4CzwIih
X-Google-Smtp-Source: APXvYqxuyVK1wO1uLyj4MOz9u7B5kq4PGy39RB+27S/w7M0QqqpiADHuWSFdmBptpHnvoQM5lww+1g==
X-Received: by 2002:a5d:4392:: with SMTP id i18mr2257914wrq.199.1578457677066;
        Tue, 07 Jan 2020 20:27:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8sm32820584wmd.2.2020.01.07.20.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 20:27:56 -0800 (PST)
Message-Id: <0977ead712e5b77fdfac703d8b2e8dc495bc393b.1578457675.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.518.git.1578457675.gitgitgadget@gmail.com>
References: <pull.518.git.1578457675.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Jan 2020 04:27:54 +0000
Subject: [PATCH 1/2] graph: add test to demonstrate horizontal line bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jcoglan@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

A previous test in t4215-log-skewed-merges.sh was added to demonstrate
exactly the topology of a reported failure in "git log --graph". While
investigating the fix, we realized that multiple edges that could
collapse with horizontal lines were not doing so.

Specifically, examine this section of the graph:

	| | | | | | *
	| |_|_|_|_|/|\
	|/| | | | |/ /
	| | | | |/| /
	| | | |/| |/
	| | |/| |/|
	| |/| |/| |
	| | |/| | |
	| | * | | |

Document this behavior with a test. This behavior is new, as the
behavior in v2.24.1 has the following output:

	| | | | | | *-.
	| | | | | | |\ \
	| |_|_|_|_|/ / /
	|/| | | | | / /
	| | |_|_|_|/ /
	| |/| | | | /
	| | | |_|_|/
	| | |/| | |
	| | * | | |

The behavior changed logically in 479db18b ("graph: smooth appearance
of collapsing edges on commit lines", 2019-10-15), but was actually
broken due to an assert() bug in 458152cc ("graph: example of graph
output that can be simplified", 2019-10-15). A future change could
modify this behavior to do the following instead:

	| | | | | | *
	| |_|_|_|_|/|\
	|/| | | | |/ /
	| | |_|_|/| /
	| |/| | | |/
	| | | |_|/|
	| | |/| | |
	| | * | | |

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t4215-log-skewed-merges.sh | 62 ++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 5661ed5881..099e4b89b4 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -311,4 +311,66 @@ test_expect_success 'log --graph with multiple tips and colors' '
 	test_cmp expect.colors actual.colors
 '
 
+test_expect_failure 'log --graph with multiple tips' '
+	git checkout --orphan 7_1 &&
+	test_commit 7_A &&
+	test_commit 7_B &&
+	test_commit 7_C &&
+	git checkout -b 7_2 7_1~2 &&
+	test_commit 7_D &&
+	test_commit 7_E &&
+	git checkout -b 7_3 7_1~1 &&
+	test_commit 7_F &&
+	test_commit 7_G &&
+	git checkout -b 7_4 7_2~1 &&
+	test_commit 7_H &&
+	git checkout -b 7_5 7_1~2 &&
+	test_commit 7_I &&
+	git checkout -b 7_6 7_3~1 &&
+	test_commit 7_J &&
+	git checkout -b M_1 7_1 &&
+	git merge --no-ff 7_2 -m 7_M1 &&
+	git checkout -b M_3 7_3 &&
+	git merge --no-ff 7_4 -m 7_M2 &&
+	git checkout -b M_5 7_5 &&
+	git merge --no-ff 7_6 -m 7_M3 &&
+	git checkout -b M_7 7_1 &&
+	git merge --no-ff 7_2 7_3 -m 7_M4 &&
+
+	check_graph M_1 M_3 M_5 M_7 <<-\EOF
+	*   7_M1
+	|\
+	| | *   7_M2
+	| | |\
+	| | | * 7_H
+	| | | | *   7_M3
+	| | | | |\
+	| | | | | * 7_J
+	| | | | * | 7_I
+	| | | | | | *   7_M4
+	| |_|_|_|_|/|\
+	|/| | | | |/ /
+	| | |_|_|/| /
+	| |/| | | |/
+	| | | |_|/|
+	| | |/| | |
+	| | * | | | 7_G
+	| | | |_|/
+	| | |/| |
+	| | * | | 7_F
+	| * | | | 7_E
+	| | |/ /
+	| |/| |
+	| * | | 7_D
+	| | |/
+	| |/|
+	* | | 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
 test_done
-- 
gitgitgadget

