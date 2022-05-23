Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C923FC433FE
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiEWUM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiEWUMw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:12:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218835D5D8
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:12:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s28so22760071wrb.7
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LKUw9/jQ5pKOTmRH7NqnSRqnbMLjrfCSfR++z8h3F08=;
        b=XmyuMR73Oyoq89safGLRjZu59lYQzCdf4fXKLGnSwYqJbR95YDSZ3NDZoDzYX/mgi/
         JzJ6lNcdUt5uJ0LN+nC3q2YbdCHZX2xHNlFsGcBzRfZcEg5mSoC2T2vbKolP9pOAqCJN
         RdFD4e4jzRdzyM1StgPyKfVv5NM2tlsjSVBgwhREEwbA3InJy32gV+pP/iE5aWE6Q1Nv
         XAOe6sQxlJkNO4NQCOD75G6KgeRk16K3p4+bKMvGLpOq6ttidNh9wTR6KmAo9ZzOIEBR
         ScApa+Ej3BRxtHMNGJDPaUQcjJ3z+6Dv/MtTGwFFKVGv82RWn0O+UgBqNZs7Xib5wiDH
         WmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LKUw9/jQ5pKOTmRH7NqnSRqnbMLjrfCSfR++z8h3F08=;
        b=ENhNVaI0ADYVHmIXkuK8oLvitFJ2ajkmlSWG7zCbQyjkZY8caByoFI6dXZCLJU5zoq
         amF13b7WmLrLWUPulZ8z93CrkPqzldwpkpOrZOfM9Gd+qGTYytfWubu7/mrU4otsyurn
         tcuBXEyAo8UvavrKyR/kQ0p3mkW7bPo7lh0RoaImVVB6SZ/3oPIiw3PVh1TZUsqWbY7z
         FPk/DS4bcV9q/GKfY72ko2zFtuVAF6IXj41bhsiDZ6DpynnIEFWa7wTZWn+A7qYKBTYs
         07EEUEIn/hPi3SNv7vtClFrxb8GATTkdqcHbjkSO/3gNX+ystdgU2FKS72DOlIObWtV8
         iZSg==
X-Gm-Message-State: AOAM532br8rrNdXqkJ77aj2OuhbLCRHcR/12UI4PXwfEaPZ5rU2Xishy
        WEnlkz1pY/sJ8DrhmJL0uC/AErlWcEs=
X-Google-Smtp-Source: ABdhPJzHisy6SFoeKyu3dPV+MoUP13Vg9aHrHts7X4auQ+7d6bvWw4ab+nB6bfBidQmPjDuKGxGXgw==
X-Received: by 2002:a5d:6d8b:0:b0:20f:e42a:96d0 with SMTP id l11-20020a5d6d8b000000b0020fe42a96d0mr4331776wrs.518.1653336769331;
        Mon, 23 May 2022 13:12:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15-20020adf8b0f000000b0020e5b4ebaecsm11122712wra.4.2022.05.23.13.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:12:48 -0700 (PDT)
Message-Id: <1bf2e36b6adb127dd1654bba0b6ba84f626535a0.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:17 +0000
Subject: [PATCH v7 02/30] t7527: test FSMonitor on repos with Unicode root
 paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create some test repos with UTF8 characters in the pathname of the
root directory and verify that the builtin FSMonitor can watch them.

This test is mainly for Windows where we need to avoid `*A()`
routines.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 1be21785162..12655958e71 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -671,4 +671,27 @@ do
 	done
 done
 
+# Test Unicode UTF-8 characters in the pathname of the working
+# directory root.  Use of "*A()" routines rather than "*W()" routines
+# on Windows can sometimes lead to odd failures.
+#
+u1=$(printf "u_c3_a6__\xC3\xA6")
+u2=$(printf "u_e2_99_ab__\xE2\x99\xAB")
+u_values="$u1 $u2"
+for u in $u_values
+do
+	test_expect_success "unicode in repo root path: $u" '
+		test_when_finished "stop_daemon_delete_repo $u" &&
+
+		git init "$u" &&
+		echo 1 >"$u"/file1 &&
+		git -C "$u" add file1 &&
+		git -C "$u" config core.fsmonitor true &&
+
+		start_daemon -C "$u" &&
+		git -C "$u" status >actual &&
+		grep "new file:   file1" actual
+	'
+done
+
 test_done
-- 
gitgitgadget

