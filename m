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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E29C56201
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFE822260
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GihXQZL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766840AbgJYDOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766825AbgJYDOB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:01 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CA1C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:51 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id x7so887711ota.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aGA+vh4pwS05AX6WR8w1fgNifpIZvH7XjfOtj1s0RJY=;
        b=GihXQZL2Xe8dcJUfwKXkp+CKvVxSuaK5SVr+zBDsDGv/FJd7mMudjHc3R/knk4VPsf
         Mkv2HJVgjfwDHyM6goW8JHziMYVRj+1HEhvFLcZ1NJjtc/W8Qv9W8aB32rmUnBbAA8P2
         J4Y8xNuvB4jwQx3WOhsqJNYBL/rOr0vX50bTnfUOq5OYiNRUrGyMwjXoUOHW1mYFA72N
         7m3Wx1xcEytv9UIytUidqFDV0IcKkjJ8kiu7zYiqJLxsUZyNuDiUOuMYBqoA7pOTGPz6
         Ynz6xlEru0lxPYuzS24/ifSqt7x7bKXK4ERCSe86ori9hYdWv+U1y0zpm5cq4hmLfW6H
         Ds8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aGA+vh4pwS05AX6WR8w1fgNifpIZvH7XjfOtj1s0RJY=;
        b=HBSNyJlBmTSRvbOtdVYYqVpUSYxR6LlZIuoWGOwQI2bPlbvNUjIDbXxFCBYiknNKdx
         UsI9V0bGUyjOHLaAd7tsOqxKmNHhZGBJ6ythxYO6V/HUIcpCB1enb6cE/zO0FwFCP8Vl
         sfePT4NdGdA7p+D5Iw51s/2oydxxyJu4JkODmcMtrTynbIYpYVLLERBx0pNY80fG4lI4
         yhUMFtIACpVq2qpwGlfxDCtpxdDj16PS2Z4vDfGm8rx/KPXswVqZOOSPSnb+aiOqkPG3
         QQag6V8ydIR6oXmjUey4xmQc3OSIQnLS67+7GU3ZVTB0SHUiMikunCjyrHZSDlaZFdU9
         RFQQ==
X-Gm-Message-State: AOAM532NalDiDy/kdLTy3Y9tOMscK9GK2ElEkuqh3Q+NE3n00CCnOUL2
        TlYowOK0Rhf50ZztU19TywZqoYKD+57rDg==
X-Google-Smtp-Source: ABdhPJx7RVjEFeZi+HlY0e8Ou/y52uEVtobn+BOHEH/oyAcnd2n81KxszCsZDlYVG/v2uwi2/lvrOA==
X-Received: by 2002:a9d:734f:: with SMTP id l15mr8776224otk.260.1603595630337;
        Sat, 24 Oct 2020 20:13:50 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j84sm1903095oia.25.2020.10.24.20.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:13:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Peter van der Does <peter@avirtualhome.com>
Subject: [PATCH v2 03/29] completion: zsh: fix bash script extension
Date:   Sat, 24 Oct 2020 22:13:17 -0500
Message-Id: <20201025031343.346913-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 0e5ed7cca3 wrongly changed the extension of the bash script
to .zsh; the zstyle configuration is for the slave script (bash), not
the master one (zsh).

For example it could be:

  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash

The extension doesn't really matter, but it confuses people into
thinking it's a zsh script; it's not.

Cc: Peter van der Does <peter@avirtualhome.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 6d451355fd..712ce2f4d1 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -9,7 +9,7 @@
 #
 # If your script is somewhere else, you can configure it on your ~/.zshrc:
 #
-#  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
+#  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
 #
 # The recommended way to install this script is to make a copy of it as a
 # file named '_git' inside any directory in your fpath.
-- 
2.29.0

