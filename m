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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D4DC2D0A3
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70B420936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLKM6JNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766893AbgJYDO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766872AbgJYDOS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:18 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709DC0613D5
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:17 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u127so6939504oib.6
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2UJ3X5+N4ZAQHv8HkKkNMFYEh3PzoPfsOWhG1pBM9E4=;
        b=BLKM6JNHjSOeds9vy+7Eo7uoHowrHKJEAXfUMvD/GcbAdeiJwgeVCCjKaQ1IPAYdkE
         48Y2MjkyNsBTN8vaK4pPcBZuQuuiv53/h8dO8kIW6ol6/m2jMxdhSeot1H8tVfy4G5eu
         pI8GRys8F8XSBr4oJI56LnzxPjGiZiw0x1iPU5ec5+ah0EdsrZn7wPWKVf5wajT6r6f9
         ZU7gw2IF7BkzLYTDYpQGaT5AB4gP4p8+G60ddKud/lJGaO0dEcs0JlKMsyGTWOlvugJT
         DGEtMaP5OiupeqdAhhhb+FRFH/jchGUMTgIYRH0mRQ7o8MpH7Z5diEU29VEr8bv9PxoF
         DKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2UJ3X5+N4ZAQHv8HkKkNMFYEh3PzoPfsOWhG1pBM9E4=;
        b=uPO/H6bgr/+PN/dewhgzQ0BFbhltdts44EBBHiAgKP/b+SI+Nrd1FL+gJwL+bxrZfj
         M1e7Qf49HrKFCPXutXG8zBBi47owcxZYBvODSBasKcSxJy196B99hr/KnVmU5kfxfZVm
         Q5tKeYGSw3rbCvyciDB4pb2eVMsE37oQMDijMmcbWBOcip7wO/aE7pZQn5SrSujKFw1D
         BWbfbOszeePwLf3hTVkqlGPUPlIv1tDNKklMtlO+XfJ6fW6oHym4uVCZLQgfSxD6dTe8
         UA0LOerKcD548P/vw9uNRrLLaYFJK43lGtQ3POGOkoMWPzDgRXqahj/EySW5rVZaZ3gu
         4KYg==
X-Gm-Message-State: AOAM531JZUiErFhqSbqzB2GARGeKu6astTEQl+MhfZ2kAL7wOI65C0Ep
        mL6P1AKeo/KMHb4yhgKUDnuP6Lss6+7C8A==
X-Google-Smtp-Source: ABdhPJwd02WDoVYjWYFTsL2uvMH+kCL+H7qhVFNrjbx311TMzHVkDxzXuGNhTtGV22vVJ9DniYnqzg==
X-Received: by 2002:aca:5f46:: with SMTP id t67mr6467207oib.156.1603595657195;
        Sat, 24 Oct 2020 20:14:17 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h7sm1585595ool.34.2020.10.24.20.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:16 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 21/29] completion: zsh: refactor command completion
Date:   Sat, 24 Oct 2020 22:13:35 -0500
Message-Id: <20201025031343.346913-22-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 179e8ff07d..702ce8db25 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -127,20 +127,32 @@ __gitcomp_file_direct ()
 	__gitcomp_file "$1" ""
 }
 
+__git_complete_command ()
+{
+	emulate -L zsh
+
+	local command="$1"
+	local completion_func="_git_${command//-/_}"
+	if (( $+functions[$completion_func] )); then
+		emulate ksh -c $completion_func
+		return 0
+	else
+		return 1
+	fi
+}
+
 __git_zsh_bash_func ()
 {
 	emulate -L ksh
 
 	local command=$1
 
-	local completion_func="_git_${command//-/_}"
-	declare -f $completion_func >/dev/null && $completion_func && return
+	__git_complete_command "$command" && return
 
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
 		words[1]=$expansion
-		completion_func="_git_${expansion//-/_}"
-		declare -f $completion_func >/dev/null && $completion_func
+		__git_complete_command "$expansion"
 	fi
 }
 
-- 
2.29.0

