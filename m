Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9FEC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351939AbiCXQx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiCXQxV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D651996AD
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso2925415wmz.4
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m/7nmjzQrPWZOZRTUqvWzqRTYtxoxcBSCt/eY/PHK+w=;
        b=TIeOhv4kTZ1Ooi0AU2Tv+NeqpaXZVCSmZUrczXziu8xHCsx6nnARxFe0SdLatXmem/
         fub9qIe/BuLteAiuMAlNp4Ix7BKteYoVlxG8Hijlsa+Co20cOoumuSI1jMsHcKRQ7/7F
         fMd4kvq9kt8YXJT7GqB9yFXhTB8/e+GitnOKXH9l4+Hd94PB38vitHUg+99nIRP0z9w0
         QT5jzVzrbK9a6t2h1dG69IeT/YayiP1ER1PfSLsI2xoDqHF0KcdEoeSeRNcE9HleJcZz
         0RttmZs/MIeGc/ctgftKsuDDp+dSbsXerqqQMWniAkOrmpG4M9Q0W5xRAoHNbnDFoiHU
         oALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m/7nmjzQrPWZOZRTUqvWzqRTYtxoxcBSCt/eY/PHK+w=;
        b=RmbnjQDE4oMwQsNaAPZI1WpH/jysbaEoCsaJ0Mjl/D8T0Kppzl7fMXEK/Y0toFVwRh
         vvF1jAq5QzmVPB6zJrW8l57d3g/AXadgIqsJb7eqe5QhZPfiOQ12ys/sQMymCOFiEftW
         6wORS/OYDgDspPd6BQm7BtyYKWyJUlMQSzQuN1lLWKY20R1JJKqX25efln7WsUXjMFzm
         pp1tRiEoZHKa/LLYFMvld2RPJeLCkyS4eLBuMMOPQ3v91M/DViUVNphQD2Cc0LERUXAr
         HaHCYm+C+4q6x+4DNljXKtHmZJuc8sHXThSscEwGTKKuvOYFXfaAiqFmmxAAL6YgpZ4W
         avfA==
X-Gm-Message-State: AOAM531Q5RCLduwpeOFLRAtf4tmcoel00M7X021YzWwSLYY0in/UTruB
        KDbuLDwSLXBTIY/StIMdPCf5ROCSy/c=
X-Google-Smtp-Source: ABdhPJxSDdmMP2v7Y3/B2XgAOxavHeWW9q2qmUlkoOGwU4X7I/foiTJijE5H2X1QoV6zqSPlhgoO1A==
X-Received: by 2002:a05:600c:1910:b0:38c:bff7:b9db with SMTP id j16-20020a05600c191000b0038cbff7b9dbmr5669063wmq.182.1648140707765;
        Thu, 24 Mar 2022 09:51:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b00389cc36a3bfsm6899260wmp.6.2022.03.24.09.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:47 -0700 (PDT)
Message-Id: <48a590d2026292254f29bc8f691c9397e2c5a33a.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:12 +0000
Subject: [PATCH v4 19/27] fsm-listen-darwin: shutdown daemon if worktree root
 is moved/renamed
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach the listener thread to shutdown the daemon if the spelling of the
worktree root directory changes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 07113205a61..83d38e8ac6c 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -106,6 +106,11 @@ static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
 	strbuf_release(&msg);
 }
 
+static int ef_is_root_changed(const FSEventStreamEventFlags ef)
+{
+	return (ef & kFSEventStreamEventFlagRootChanged);
+}
+
 static int ef_is_root_delete(const FSEventStreamEventFlags ef)
 {
 	return (ef & kFSEventStreamEventFlagItemIsDir &&
@@ -215,6 +220,26 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			continue;
 		}
 
+		if (ef_is_root_changed(event_flags[k])) {
+			/*
+			 * The spelling of the pathname of the root directory
+			 * has changed.  This includes the name of the root
+			 * directory itself or of any parent directory in the
+			 * path.
+			 *
+			 * (There may be other conditions that throw this,
+			 * but I couldn't find any information on it.)
+			 *
+			 * Force a shutdown now and avoid things getting
+			 * out of sync.  The Unix domain socket is inside
+			 * the .git directory and a spelling change will make
+			 * it hard for clients to rendezvous with us.
+			 */
+			trace_printf_key(&trace_fsmonitor,
+					 "event: root changed");
+			goto force_shutdown;
+		}
+
 		if (ef_ignore_xattr(event_flags[k])) {
 			trace_printf_key(&trace_fsmonitor,
 					 "ignore-xattr: '%s', flags=0x%x",
-- 
gitgitgadget

