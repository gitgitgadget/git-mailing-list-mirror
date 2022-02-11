Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A373C433FE
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353617AbiBKU5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353619AbiBKU4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:52 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F4FD90
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:46 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so17131655wrg.12
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cICaJgBohsHV+EmyoPh9Wyfjbnch78C4hzNaZHXwftw=;
        b=P6XrCOBXonOqJ1rVMnZE6XYJufKQ11wLRpS4eRY5fuEeTUMXPCClQb0iWnEb8fFusL
         zasBD2JeNlC8VUKdqmrbohcfbKIpC/o+8Uwyh8TVO5Bd5eGq64BzvnDQQmxNiEb2lNkf
         udWj0xeyb0UfZtyydkh2TCOUcbFmqV/6A7mnCC+2GTTI/xSYY5fS7KjX1ISyOSMe6Uif
         dGU9K82KL9dnPg0CFq9kgAEJt7rmlcDxH/YSBAmLqO0pf8jAsK+D43zR0wCMTk3zhvfQ
         MJzMJ+dIVjH6xnoKExAdCct7b00oWweYLECaTxMJyGhkZL8W36OXZCR19YnAAzBkb6Kv
         5Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cICaJgBohsHV+EmyoPh9Wyfjbnch78C4hzNaZHXwftw=;
        b=0Fyiqd5eKckJmdyoB3b8Fb8sx7wLebDIAO9fYnhnd7zuDwAuhcBOVBPAPQ+fqRmu3Z
         Phmh0wsY1V9QqtnUMaOcfLYB6xiusWtQ8f4EPh/QCaYE1YCKqBVcwV1QyXYMyGhz9cCF
         D3b7QywQadNiJi9iXR6H/bf+sX9CJ+nqp37mkPPpKMzyy2MaqNORyegyjT6X4Jq/Mk8C
         KG50JnKDXdi730p7FF1+j4GdiWNUimClalzmUAA5V2YYRx21DiAmJI/TFRLpFRJaV0Se
         9FWtF1OZuzTtFr44AWiogwHb/Xltyb/fN7pXSs/pU9ZOioSpBfjCWIP595xGm1AhSrob
         yCdQ==
X-Gm-Message-State: AOAM5315XWS+YqmNED4YPu4W00/X2Ztu8pp1pIggtn1nvzKZd8YIwjKK
        EJ/8LZtuIul7C/rZK7H6pmbiPRCpceY=
X-Google-Smtp-Source: ABdhPJwDC3KEfzBKlo7p67L/mtU5N1dNgp9X09DVrHvx5vm6nxlruWf3G1ulaY4LUm4YNaNG/XLhLA==
X-Received: by 2002:a5d:6084:: with SMTP id w4mr2706253wrt.667.1644613005234;
        Fri, 11 Feb 2022 12:56:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm27088857wre.45.2022.02.11.12.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:44 -0800 (PST)
Message-Id: <d6039987df80c217cf798e59bc88cb46f5a22707.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:18 +0000
Subject: [PATCH v5 29/30] t7527: test status with untracked-cache and
 fsmonitor--daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create 2x2 test matrix with the untracked-cache and fsmonitor--daemon
features and a series of edits and verify that status output is
identical.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 93 ++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 5f7b8e54233..0ccbfb9616f 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -162,6 +162,8 @@ test_expect_success 'setup' '
 	.gitignore
 	expect*
 	actual*
+	flush*
+	trace*
 	EOF
 
 	git -c core.fsmonitor=false add . &&
@@ -508,4 +510,95 @@ test_expect_success 'cleanup worktrees' '
 	stop_daemon_delete_repo wt-base
 '
 
+# The next few tests perform arbitrary/contrived file operations and
+# confirm that status is correct.  That is, that the data (or lack of
+# data) from fsmonitor doesn't cause incorrect results.  And doesn't
+# cause incorrect results when the untracked-cache is enabled.
+
+test_lazy_prereq UNTRACKED_CACHE '
+	git update-index --test-untracked-cache
+'
+
+test_expect_success 'Matrix: setup for untracked-cache,fsmonitor matrix' '
+	test_unconfig core.fsmonitor &&
+	git update-index --no-fsmonitor &&
+	test_might_fail git fsmonitor--daemon stop
+'
+
+matrix_clean_up_repo () {
+	git reset --hard HEAD &&
+	git clean -fd
+}
+
+matrix_try () {
+	uc=$1
+	fsm=$2
+	fn=$3
+
+	test_expect_success "Matrix[uc:$uc][fsm:$fsm] $fn" '
+		matrix_clean_up_repo &&
+		$fn &&
+		if test $uc = false && test $fsm = false
+		then
+			git status --porcelain=v1 >.git/expect.$fn
+		else
+			git status --porcelain=v1 >.git/actual.$fn &&
+			test_cmp .git/expect.$fn .git/actual.$fn
+		fi
+	'
+}
+
+uc_values="false"
+test_have_prereq UNTRACKED_CACHE && uc_values="false true"
+for uc_val in $uc_values
+do
+	if test $uc_val = false
+	then
+		test_expect_success "Matrix[uc:$uc_val] disable untracked cache" '
+			git config core.untrackedcache false &&
+			git update-index --no-untracked-cache
+		'
+	else
+		test_expect_success "Matrix[uc:$uc_val] enable untracked cache" '
+			git config core.untrackedcache true &&
+			git update-index --untracked-cache
+		'
+	fi
+
+	fsm_values="false true"
+	for fsm_val in $fsm_values
+	do
+		if test $fsm_val = false
+		then
+			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor" '
+				test_unconfig core.fsmonitor &&
+				git update-index --no-fsmonitor &&
+				test_might_fail git fsmonitor--daemon stop
+			'
+		else
+			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] enable fsmonitor" '
+				git config core.fsmonitor true &&
+				git fsmonitor--daemon start &&
+				git update-index --fsmonitor
+			'
+		fi
+
+		matrix_try $uc_val $fsm_val edit_files
+		matrix_try $uc_val $fsm_val delete_files
+		matrix_try $uc_val $fsm_val create_files
+		matrix_try $uc_val $fsm_val rename_files
+		matrix_try $uc_val $fsm_val file_to_directory
+		matrix_try $uc_val $fsm_val directory_to_file
+
+		if test $fsm_val = true
+		then
+			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor at end" '
+				test_unconfig core.fsmonitor &&
+				git update-index --no-fsmonitor &&
+				test_might_fail git fsmonitor--daemon stop
+			'
+		fi
+	done
+done
+
 test_done
-- 
gitgitgadget

