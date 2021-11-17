Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB40C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 01:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C4861C12
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 01:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhKQB3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 20:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhKQB3E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 20:29:04 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC7EC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 17:26:06 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b13so740906plg.2
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 17:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqWOjCLd8I3Flr3DnEd+hno+9D0KdpOuAKGRTMkalJ8=;
        b=Kyn+eZuHhJHVzc+t/MHLig2xc8KtbXZTycUs+lLSzdsuLDpR9t0C6whQL5xHjDe3E2
         64BAuseqsUbFS2N5NY7KcmnpBH3K17ZHe3EZRQZMewoDn1WjryLcQ/nuL5tBL4dNWLLC
         I60yybxRB9Hnlc/4TC3nhfzI5dtrXKarto2+djyg6xtgoPHj4J7a946khNKof8I/RAgR
         qMkF27X5RJAcVssVlpjhB8bluzYVFQ6AAwR2CPlYOOqVgvqEpCdtb6Wj58vVFn0Nm5Xm
         lypaG38on1uD9h4ZpUlRjOoMrk/PORcx+BkcJBlrMuQZa74711iI9tpn6TP0M1kaSEbu
         fEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqWOjCLd8I3Flr3DnEd+hno+9D0KdpOuAKGRTMkalJ8=;
        b=GU9ki6Uj0STGLp9yP2Kg26WnzUK8lO5hqvX99VVhGqF7uiPkvV+ZscXTf7X71JoEbU
         /YLhCNy/uV0+0oGRO3ZxiM6C9P/ynFw7xjgEYao8ZJKOEjiuo2fu8/QTE1QK8im2b3Jw
         flZWVZXKQ+isE2nmu4MJJkUnoRSHWUfUVhceDlGQC4NX0PfpWUn5Wzr77ize7t+9iT6a
         fYTf4s9AhGtsixNSiYGy3ANnOZHrs4IFCbAsFzkPbksazv5o4nyv/N9fPlc26tvn1yNJ
         OBF93YHNxdx/7lsHdkGjBnda4Q9e4HXS2ZL6LW+DFPfcOwltrfTWfcS8wxVyhxFTs++K
         Ik0w==
X-Gm-Message-State: AOAM5320RCpRmcLpATekCUoww1UIzwcwmv4snrb8Ilh1ABM5rFSaRBSk
        LnqjbYd3EVp2Zw6Rs8nXKuMY10zgVsQ=
X-Google-Smtp-Source: ABdhPJxpwuSjJchlMQzD2/+oIbT04GXYdfg8xjtcntJ+CMkaM54vay4m0Z4AG5PNbYO5oQVnTnUBiw==
X-Received: by 2002:a17:90a:3e09:: with SMTP id j9mr4586705pjc.24.1637112366044;
        Tue, 16 Nov 2021 17:26:06 -0800 (PST)
Received: from athena.localdomain ([2402:800:63b8:c954:57f3:fdbb:8ade:b454])
        by smtp.gmail.com with ESMTPSA id f21sm16088416pfc.191.2021.11.16.17.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 17:26:05 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] Makefile: fix parallel build race
Date:   Wed, 17 Nov 2021 08:25:55 +0700
Message-Id: <7d82342089a80b19e54ac8997d5765a33951499f.1637112066.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.34.0.388.gfd5f8144ad.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* builtin/bugreport.c includes hook-list.h, hence generated files from
it must depend on hook-list.h

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 241dc322c0..413503b488 100644
--- a/Makefile
+++ b/Makefile
@@ -2222,6 +2222,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
 help.sp help.s help.o: command-list.h
 hook.sp hook.s hook.o: hook-list.h
+builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-list.h
 
 builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
-- 
2.34.0.rc1

