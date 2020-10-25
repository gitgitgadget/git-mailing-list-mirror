Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D6BC55179
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE8320936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVgoJl0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766868AbgJYDOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766857AbgJYDOM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:12 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECCBC0613D0
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:00 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id v123so1555287ooa.5
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jtR+pU9ehZJVaRdI0ewS8VlmChzN75RxQJ9UCA6Faqo=;
        b=ZVgoJl0JIUWoBfW0XAKZxS3gYF98Z70j3bgx1KHaKXTIiOEfs07q0ROi76eFt+Z+KF
         0piUoHDzYY2SYTpXxnkIH96ribZtngSs0qcinRQ9diItPUr1CNFLcFTIYytcuBtbdb5t
         bRaoCX0Jc0hWnKJ2qTJ8AiB9quaMFi+iWhQ9VLfd2Ct62mRyL/3AjuHUV7hPsmzf+a8b
         z8y4NfWTsCRRWIp/ZPmDRB3WJNUkdY2AYF4SgH7pwQoN3c4ewkTEcVu93mNoGxD22Amu
         TGN4MmdD0/FSjKt/Fi4hTOlXijFObnbZcs+JjGrDptrYMg+RsQ0VqlFJbenATU8hjo5z
         Jk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jtR+pU9ehZJVaRdI0ewS8VlmChzN75RxQJ9UCA6Faqo=;
        b=Iyl+3Vr+aR+84E8oLHQ94gcl0Hgjmrib7e4zxEoodMDkqotBUyKUlTZGO22NXDlSlt
         CAgMsPd7P5wXVkzIGnQNddcNL1WYzkAe7So2k/zbCRTSLtGGXJk0UPfeifV6M7ss2iQ/
         cyE06topWb7m3DxJErcK8WzUqnSQeMtPJYfh2NLJ7F8RC3rh0+xAa5gOUWvUr/ZYmle/
         1j4wDot+hH5/bp5GCY5hasvmfBTj5J/FoLigT1xwXb7BvrxqiHLxaJW+VIPs1mW/VlJU
         71TZCaTwHyzxgl3u32ZSWp1J5aWxjD2oZuaekMBLXqj9VSzN5Ff2z6qNFDiNaSpEh812
         otdg==
X-Gm-Message-State: AOAM531viUeZB5XY5zJf2lFnDrTW0S+IZMi8wJnKlaRqRtfBKqiTyGjt
        GF3WbJ6oTku9z2JZAX523eSq63MHATy0yw==
X-Google-Smtp-Source: ABdhPJx292uQnianSCIGYotPj5FkKbYJXpcR8Z+arV6vP+IYB0gxlvA7J/y9rx0kXnLCSs8bsmdH9Q==
X-Received: by 2002:a4a:b34a:: with SMTP id n10mr8527284ooo.46.1603595639539;
        Sat, 24 Oct 2020 20:13:59 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z12sm630514oos.12.2020.10.24.20.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:13:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/29] completion: bash: synchronize zsh wrapper
Date:   Sat, 24 Oct 2020 22:13:23 -0500
Message-Id: <20201025031343.346913-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A function was missing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ec7dd12a41..40affd40e2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3510,6 +3510,14 @@ if [[ -n ${ZSH_VERSION-} ]] &&
 		compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 	}
 
+	__gitcomp_nl_append ()
+	{
+		emulate -L zsh
+
+		local IFS=$'\n'
+		compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	}
+
 	__gitcomp_file_direct ()
 	{
 		emulate -L zsh
-- 
2.29.0

