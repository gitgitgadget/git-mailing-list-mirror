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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9938DC4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4E220936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9uuuVmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766884AbgJYDOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766880AbgJYDOW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:22 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F916C0613D7
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:22 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id f7so6958098oib.4
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ivPVDZshxEmKG8T2X7nY7SDCvKqPSnHv2R5zyEqBPQs=;
        b=k9uuuVmcKed6BC1GKQTKCpYBdqL6Cdg96Q7EugEheHOONpeDiEkPR36tvxKU4nA1A1
         iANg9/pSphMPNlg5pYROHQV2/XqDIa9p7ul2yUL1/UR9VWOVYdikuB//3f1IpGRx8rwl
         EOG336ku9DqE5S/Vs/ox/QJQQ+Hk0UMj6E7Z9QluZXsvYcMMD87avWM5rT2iIclY011p
         2zxQeQNZFovH9V/F7wbi3dHOGv0mkQ/r8dyuFB8l3lzGMK3XiUYENUaCU4koC9iFTzaa
         a5NcLWFvij2Ge9sbKfzBjdRamJ68AziuRve4/DWwkR0eFMCpljFbBsrIFoibkN39drrZ
         ublQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivPVDZshxEmKG8T2X7nY7SDCvKqPSnHv2R5zyEqBPQs=;
        b=AkpAiPOW4lYWOcRtniSE6gi5DIAdlMjdpoJZry7shNGPJN/AOAmgBUVSvAH2yKxkQm
         yOAriS7GdDgFQuK6p/DItLbmoHtPlo4oZP8vPOg3d32qfq+MJVnCepBIPsvLm/5HZcx/
         yvFJuanLYAHrv6qB7yjLDK6pTCJf++Xiq+mr9twa5Yvn5hmscyshPfV27+rAspkYTWpW
         MWoWiM7rux87ScvU0sI7dHL7LTtDhgOCeGi0r1NEoEJkdTyZYnw3rayHUGZx7nS+y9aJ
         CQbfzavj6Yhi8FsjIp3tPoeTEmjZasFIMDsHjaMq3Ov33dQfBPpfbsUB5tRiXguaknpP
         AxLQ==
X-Gm-Message-State: AOAM532utKRXqed2RW0wC9z9tIY56NFfPmwwxfNKyrRvH/KYht7Mi/CQ
        QxUYePtTQlIE1CUSifogAtM5F4ajGbtoNw==
X-Google-Smtp-Source: ABdhPJxdnKInieZMFG3MtHi9EpqNMG66BCxQa/5TVFcS4Jn4iFoYHKfvblOoLuB7q7c9wE3OPQ1Wzw==
X-Received: by 2002:aca:cfce:: with SMTP id f197mr8215622oig.44.1603595661762;
        Sat, 24 Oct 2020 20:14:21 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h6sm1889887oia.51.2020.10.24.20.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:21 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 24/29] completion: zsh: trivial simplification
Date:   Sat, 24 Oct 2020 22:13:38 -0500
Message-Id: <20201025031343.346913-25-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From upstream bash simplification:

  d9ee1e0617 (completion: simplify inner 'case' pattern in __gitcomp())

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index d90eb6863b..1b2a43150d 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -78,7 +78,7 @@ __gitcomp ()
 			fi
 			c="$c${4-}"
 			case $c in
-			--*=*|*.) ;;
+			--*=|*.) ;;
 			*) c="$c " ;;
 			esac
 			array+=("$c")
-- 
2.29.0

