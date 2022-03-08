Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E24C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350645AbiCHWQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243250AbiCHWQc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2061554BCE
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i8so240262wrr.8
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jbOjNU2UPDnti2uDmzPj9ZkhrM+9Lbl5QUOXunuauhU=;
        b=IU8U/qAdl/c/eCLlBYRq6h3FAoDFvtYbywVfNboAWlrIDA9+OtFQbBVofhI0Lee7uk
         0X3TzZlnEDzrirjCoDVnVh65pXMOe1hzDmx8sNdcOuqS8yVQx6LknsIa5n+C4AvGaTI2
         9bIA46NT47UmRg9Z3DxAQCvrac/0XSDctnbgdXwJzIpe+2Lhboh9Tq73rZcwbjRdAYzq
         rAqrOBCm6OAHgJ8keUVa/Vz3r8tHdMlCx5VjUFjA2mPl4Ro95NL5mJ2+702+LmH/o+bq
         GybzIwjyrLKawXXWFOz+NNiTymUefaQjoMp25Jg87+ZkH8fPIwX6kWTNt2A/jp42l134
         oI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jbOjNU2UPDnti2uDmzPj9ZkhrM+9Lbl5QUOXunuauhU=;
        b=gwAs1RPaBFfxYu/pR+JwB2LUt6Jl6dTo3eCoAdDumKhXRWzZfFFXORrc5lTvDSs+Hu
         D5quQWrvyd5bZmXPpgkRHQ6ghQS0FUGUq4xHDAAkU1Gvm/bZlEnEuEp2oRBzNq1UR8LP
         WFpSl03Y4oWelfbUxITz1+JKahriCzwgNE2AEtibHOC+VhnD0sOAaqDEeh5zSihSPDx4
         o4+zwJbBt549Rz3yylsQWYDL1OpqZc70ii6r/xei2/JiSp4RSO5K0o3hhijvtP8YHmkx
         5v3iLX41X3AaCZsXov4EsHWTvau0s+vsSNJkmqt54OCFfbrP3xubeaiit1jvzM5aemKJ
         WGuw==
X-Gm-Message-State: AOAM532MZD4b+ecrmnZ0hSLaBCV6PLs/8ZkmtkWhgiG7rLkUbjD0v/ls
        8nPc1GrpBMxzUocvGuNqX06IeSr6xGk=
X-Google-Smtp-Source: ABdhPJxaI0tSTGaVwkOHbwGBBm6uP+z67GQDMPLLodAg3nRyLll0XhHHPpVmp+eTz/Z7BkSqNlG6kw==
X-Received: by 2002:adf:eb86:0:b0:1e6:8c92:af6b with SMTP id t6-20020adfeb86000000b001e68c92af6bmr13769161wrn.116.1646777732511;
        Tue, 08 Mar 2022 14:15:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d6942000000b001f0485057c4sm95477wrw.74.2022.03.08.14.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:31 -0800 (PST)
Message-Id: <3a0f30b849a85ee0f2737a08fcf6a746020efdcf.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:02 +0000
Subject: [PATCH v2 02/27] t7527: test FSMonitor on repos with Unicode root
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
index dbca7f835eb..c2627f28865 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -666,4 +666,27 @@ do
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
+	test_expect_success "Unicode in repo root path: $u" '
+		test_when_finished "stop_daemon_delete_repo $u" &&
+
+		git init "$u" &&
+		echo 1 >"$u"/file1 &&
+		git -C "$u" add file1 &&
+		git -C "$u" config core.fsmonitor true &&
+
+		start_daemon "$u" &&
+		git -C "$u" status >actual &&
+		grep "new file:   file1" actual
+	'
+done
+
 test_done
-- 
gitgitgadget

