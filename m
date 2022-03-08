Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213B7C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350667AbiCHWQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350647AbiCHWQg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E7D56220
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b5so275812wrr.2
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mfnUzrBPZiTqZr1H3mJX0p6D1Lxzn9AnXn9ve4rZMkY=;
        b=HhI5gut4RGIU7caKM/itonwCuW7CDksSEYh7aO+HDTkWQV/M8voUukDtd/SHZ87qEA
         VqIOOmhLr7rocI8E4BFEo5ajDfrTUuDKK/5dPHDzCBP9WEN3kKPXKsR4aaBJGsXNP3r7
         3gMLxW1R2+kpdzJB37IxKo4GPl8Xnlv8mxb/bIxJt3L9QSj4ljrH+DFo9C2ZA2PlJwsO
         TsswaO3JQlSBjNX5hC0i7QAIUT8kNYi9MrVj6JRgXlurnx5g9LCQ7UKzSAmRQOeAswPr
         FhqWhYeuJbQjW+eu2/aI6eO8Uruu4Vgu3Qtgmo16T1v6+G14t/4BSuL77SuRSdKik3ZR
         r1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mfnUzrBPZiTqZr1H3mJX0p6D1Lxzn9AnXn9ve4rZMkY=;
        b=sthDA/KcE2aQX35bLUujhrmuAjQ+YmWX4hQI3U3LsXUZHE+4K6VfXN15hgnK2Rr9Z9
         8m2zXJKabwVI6fhkH5CocjQf6B74WKTkN+CSDWU/r6vJCpQT7hJibpZphIm8E5xMFknX
         zf63pGjKvzaB10cW3/waumtyUj66U8H4nksqt60yeMDH7igRPOYFE32PYOjKjDNcYdo0
         8/XeidNjLgvDz9zIc2P1fizA6RRAHLhNvqxgHFEnCwOvn3w64KupdK9BqpuLHXUhVDqh
         gkGEn63XpkL54ZhrSbYXwl9mwxRmoUq5dbQXBzRvPzONaaAkyi/p4JQ7U7iu3od7y1hq
         tEIQ==
X-Gm-Message-State: AOAM533/vkiFLpdgS80vgqTZ1o4In0rO3Z94oM/wZpfT75P5/S87SvD3
        nPT6ahyzP1IEoJNI/kmrTSADxUM0GM8=
X-Google-Smtp-Source: ABdhPJyPOiASidmYMcNCqL/FRqCGj9alDXn8MSlRAebiOXcwEC95125Mai9ZhpGTqbFHYqf2DfqNCg==
X-Received: by 2002:a5d:648b:0:b0:1f1:fc40:91e0 with SMTP id o11-20020a5d648b000000b001f1fc4091e0mr7532433wri.712.1646777736798;
        Tue, 08 Mar 2022 14:15:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcc0b000000b0037e0c362b6dsm61668wmh.31.2022.03.08.14.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:36 -0800 (PST)
Message-Id: <fa9e86e7de7352a2cf9c1f465a38f834c6ec4ffe.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:06 +0000
Subject: [PATCH v2 06/27] fsmonitor-settings: VFS for Git virtual repos are
 incompatible
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

VFS for Git virtual repositories are incompatible with FSMonitor.

VFS for Git is a downstream fork of Git.  It contains its own custom
file system watcher that is aware of the virtualization.  If a working
directory is being managed by VFS for Git, we should not try to watch
it because we may get incomplete results.

We do not know anything about how VFS for Git works, but we do
know that VFS for Git working directories contain a well-defined
config setting.  If it is set, mark the working directory as
incompatible.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-settings-win32.c | 26 ++++++++++++++++++++++++++
 fsmonitor-settings.c                  |  3 +++
 fsmonitor-settings.h                  |  1 +
 t/t7519-status-fsmonitor.sh           |  9 +++++++++
 4 files changed, 39 insertions(+)

diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index 7fce32a3c5b..ee78bba38e3 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -3,7 +3,33 @@
 #include "repository.h"
 #include "fsmonitor-settings.h"
 
+/*
+ * VFS for Git is incompatible with FSMonitor.
+ *
+ * Granted, core Git does not know anything about VFS for Git and we
+ * shouldn't make assumptions about a downstream feature, but users
+ * can install both versions.  And this can lead to incorrect results
+ * from core Git commands.  So, without bringing in any of the VFS for
+ * Git code, do a simple config test for a published config setting.
+ * (We do not look at the various *_TEST_* environment variables.)
+ */
+static enum fsmonitor_reason check_vfs4git(struct repository *r)
+{
+	const char *const_str;
+
+	if (!repo_config_get_value(r, "core.virtualfilesystem", &const_str))
+		return FSMONITOR_REASON_VFS4GIT;
+
+	return FSMONITOR_REASON_OK;
+}
+
 enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 {
+	enum fsmonitor_reason reason;
+
+	reason = check_vfs4git(r);
+	if (reason != FSMONITOR_REASON_OK)
+		return reason;
+
 	return FSMONITOR_REASON_OK;
 }
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 1b16b551d87..ea3e365dfc4 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -177,6 +177,9 @@ const char *fsm_settings__get_reason_msg(struct repository *r)
 
 	case FSMONITOR_REASON_BARE:
 		return _("bare repos are incompatible with fsmonitor");
+
+	case FSMONITOR_REASON_VFS4GIT:
+		return _("virtual repos are incompatible with fsmonitor");
 	}
 
 	BUG("Unhandled case in fsm_settings__get_reason_msg '%d'",
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index be25272c012..7950529611b 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -16,6 +16,7 @@ enum fsmonitor_mode {
 enum fsmonitor_reason {
 	FSMONITOR_REASON_OK = 0, /* no incompatibility or when disbled */
 	FSMONITOR_REASON_BARE,
+	FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
 };
 
 void fsm_settings__set_ipc(struct repository *r);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index cf258d88f04..285508fb67e 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -78,6 +78,15 @@ test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
 	grep "bare repos are incompatible with fsmonitor" actual
 '
 
+test_expect_success MINGW,FSMONITOR_DAEMON 'run fsmonitor-daemon in virtual repo' '
+	test_when_finished "rm -rf ./fake-virtual-clone actual" &&
+	git init fake-virtual-clone &&
+	test_must_fail git -C ./fake-virtual-clone \
+			   -c core.virtualfilesystem=true \
+			   fsmonitor--daemon run 2>actual &&
+	grep "virtual repos are incompatible with fsmonitor" actual
+'
+
 test_expect_success 'setup' '
 	mkdir -p .git/hooks &&
 	: >tracked &&
-- 
gitgitgadget

