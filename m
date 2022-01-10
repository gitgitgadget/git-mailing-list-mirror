Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3A1C4332F
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 19:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbiAJTAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 14:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242872AbiAJS76 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 13:59:58 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28571C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:59:57 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r9so26845823wrg.0
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2qgF1+BTQPuGV4qh5BCcVuYySkHoEJLcnieQpUFV2Z8=;
        b=GSURm2HwQdrPfRjgGvHAbgHgrVPDWsmJTSbdcH/F2Z43F34f1o4gpJGX7XRDpDMc2z
         oIpLAhImLZD8g36veEUPzxP7HBL/2Yub0csjoqEoWeET2Bj74oNcTt5E5EhmZb5xzQbz
         u1/W1sr7x3zwkTKNuBqRIGlHvw8tvDNKp3QPrYLpU7HO8Q8b+HrOWlBlamDsq/A8+4YB
         XN3occTZ8sVidNb9G0bGCb5G+Sok2Ji1iFcyTsgsYBULa9PRZywshg1iA7QFwAk8g8hi
         S+03ZVubu5yKARBb0WUNqbtXb5aRZK+tGfzd/LkO+x5ICnDhd0DJt1veK6A7/6P6JQKh
         4yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2qgF1+BTQPuGV4qh5BCcVuYySkHoEJLcnieQpUFV2Z8=;
        b=WIOS4TE2ZYIFYJvRe1m5zvpOaUJit+M0oo175+Ul4gJs7K5/0Db7uQkigFaYGmwKTf
         xowt4bQtCdF8G640aUXNEdKY2ZnyPml0ZMWg8cUSrtR8o+k8Fa+8tVbrzw/k/wFsPbJw
         Xqpik8t/3do2ZfUHM+DO5vOv1OfFJuDBNf3a5ssB2/hjzEz8yJZV1364wgJkAMk0SE9X
         O8uwTJOXm22Y4NabXw1nUJ5PdxzEYyMPSUSBQw10yzQOa+QAKfFTdHBpGvgPWaL3L3Vt
         q6G/Uz2sQ3SQRHHpCp1bpM0jILEz5vTPBonujGi8kOfxMf1KAckl4ShKs8sXlaMTovWd
         A1qQ==
X-Gm-Message-State: AOAM533DknwevYtZujtAS5GmYhKNvIlnPTRoCTEKXb9pDVlF1epeGmV8
        Unn4hRtWmcBSoj3zjaLtC4vZ1s0XUDQ=
X-Google-Smtp-Source: ABdhPJw0YKlnQ+QTHYPPDTLbnwvNCAwbTXdV5vxTIzxz/JRlR08m/8v0hc7OxyRzynzLvW7wbNwvcQ==
X-Received: by 2002:a5d:4d11:: with SMTP id z17mr830964wrt.182.1641841195602;
        Mon, 10 Jan 2022 10:59:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12sm7661944wmq.30.2022.01.10.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:59:55 -0800 (PST)
Message-Id: <bbc2d21e1d19f968fcf70d681d50f52d2235b8fa.1641841193.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
        <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Jan 2022 18:59:50 +0000
Subject: [PATCH v3 1/3] sparse-checkout: custom tab completion tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Add tests for missing/incorrect components of custom tab completion for the
sparse-checkout command. These tests specifically highlight the following:

1. git sparse-checkout <TAB> results in an incomplete list of subcommands
(it is missing reapply and add).
2. git sparse-checkout --<TAB> does not complete the help option.
3. Options for subcommands are not tab-completable.
4. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
both file names and directory names.

Although these tests currently fail, they will succeed with the
sparse-checkout modifications in git-completion.bash in the next commit in
this series.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 t/t9902-completion.sh | 85 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 518203fbe07..51d0f2d93a1 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1447,6 +1447,91 @@ test_expect_success 'git checkout - with --detach, complete only references' '
 	EOF
 '
 
+test_expect_failure 'sparse-checkout completes subcommands' '
+	test_completion "git sparse-checkout " <<-\EOF
+	list Z
+	init Z
+	set Z
+	add Z
+	reapply Z
+	disable Z
+	EOF
+'
+
+test_expect_failure 'sparse-checkout completes options' '
+	test_completion "git sparse-checkout --" <<-\EOF
+	--help Z
+	EOF
+'
+
+test_expect_failure 'sparse-checkout completes subcommand options' '
+	test_completion "git sparse-checkout init --" <<-\EOF &&
+	--cone Z
+	--no-cone Z
+	--sparse-index Z
+	--no-sparse-index Z
+	EOF
+
+	test_completion "git sparse-checkout set --" <<-\EOF &&
+	--cone Z
+	--no-cone Z
+	--sparse-index Z
+	--no-sparse-index Z
+	--stdin Z
+	EOF
+
+	test_completion "git sparse-checkout reapply --" <<-\EOF &&
+	--cone Z
+	--no-cone Z
+	--sparse-index Z
+	--no-sparse-index Z
+	EOF
+
+	test_completion "git sparse-checkout add --" <<-\EOF
+	--stdin Z
+	EOF
+'
+
+test_expect_failure 'sparse-checkout completes directory names' '
+	# set up sparse-checkout repo
+	git init sparse-checkout &&
+	(
+		cd sparse-checkout &&
+		mkdir -p folder1/0/1 folder2/0 folder3 &&
+		touch folder1/0/1/t.txt &&
+		touch folder2/0/t.txt &&
+		touch folder3/t.txt &&
+		git add . &&
+		git commit -am "Initial commit"
+	) &&
+
+	# initialize sparse-checkout definitions
+	git -C sparse-checkout sparse-checkout init --cone &&
+	git -C sparse-checkout sparse-checkout set folder1/0 folder3 &&
+
+	# test tab completion
+	(
+		cd sparse-checkout &&
+		test_completion "git sparse-checkout set f" <<-\EOF
+		folder1 Z
+		folder1/0 Z
+		folder1/0/1 Z
+		folder2 Z
+		folder2/0 Z
+		folder3 Z
+		EOF
+	) &&
+
+	(
+		cd sparse-checkout/folder1 &&
+		test_completion "git sparse-checkout add " <<-\EOF
+		./ Z
+		0 Z
+		0/1 Z
+		EOF
+	)
+'
+
 test_expect_success 'git switch - with -d, complete all references' '
 	test_completion "git switch -d " <<-\EOF
 	HEAD Z
-- 
gitgitgadget

