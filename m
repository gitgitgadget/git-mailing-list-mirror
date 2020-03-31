Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3602C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 12:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87044208E0
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 12:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDFdyNUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbgCaMsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:48:37 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:37817 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730437AbgCaMsh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 08:48:37 -0400
Received: by mail-ed1-f43.google.com with SMTP id de14so24943439edb.4
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 05:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bEOGbVoIe1j6s3cTWOj9hduylt2UYqMzQN+bsF5iVXY=;
        b=WDFdyNUe9+UCMUo7yx1a466paCpLNtUOULxxOaSuD6+ynRFU2uYYN78SrhwwDsq2Yk
         5BV4zmMVmLWqBXib9EKsRW3mQPeYKITb3CfzRs9fnRV4mSZHVPhdwrzhSlWswlg88ynp
         mbaDZOcRnWQyMiehdpNn46kUUliHE6C2RIs3mtpfkVe2oxyMlugnm52DdNWR3mpeaoum
         YjDgKljkzS+AcByLrhnfASwHqSCQRh76P+Wp6J1EnUGYpnuEknDtxwIFl9yrq5l48me4
         D57TbOGumds75RR8F8ieFNWzXVXwFujere7GUsYH4NeS4wx2HPCf85ixiJDinR+YGfyE
         +jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bEOGbVoIe1j6s3cTWOj9hduylt2UYqMzQN+bsF5iVXY=;
        b=ERUVamrIhUA3Cr30BQ7NjGranDANXsbrPVxyRoFQjVnmZSzeW9+GLW+oJDGuq8Wruk
         cEcGFk0ZV547pmPYHB0Ky+RMhgIG4HjkJcQQpUAsTVqZD1SnbwBjSW7ImVRM/7WxJTL0
         q4DPRHlKZ9u81hFTIEP+AbLLr+sSQQGibg3LgENdl0/0ehiyofOrZZZls+NbBQS6Kmus
         3A487GFx/8vsGyH6Ity+nu3GqYhpnOJAqDTbFZjkRVBMJzSMPjehkv13PppF9A0leN6f
         ru4ZjuxC+udxBuYOz0CfJbGz/LZ2ywjr19veV71mItQLmaB0VyUrBkO7b6mNQDSxJIoX
         f3xw==
X-Gm-Message-State: ANhLgQ1tOl21tjDwnGQBXDPItb7V+Csge7wJmNKuiNOxEM1fDSFilDYn
        p5fx3c8TnOQ+PBRyBIfWdxNrETzY
X-Google-Smtp-Source: ADFU+vvIcp2aw1ARryWaM4E5wDbp/iH2yCtFXc6yLjkYs+MwCWC7vbnlAxXVHtVdd4L8zvc+qrKklA==
X-Received: by 2002:a50:ed93:: with SMTP id h19mr15089639edr.255.1585658915077;
        Tue, 31 Mar 2020 05:48:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s29sm2330912edc.25.2020.03.31.05.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:48:34 -0700 (PDT)
Message-Id: <447ea0c2f6dc9403af3a8f0bae6c23f82bc96838.1585658913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Mar 2020 12:48:29 +0000
Subject: [PATCH 1/5] ci/lib: if CI type is unknown, show the environment
 variables
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This should help with adding new CI-specific if-else arms.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index a90d0dc0fd2..8d73551a12f 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -138,6 +138,7 @@ then
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 else
 	echo "Could not identify CI type" >&2
+	env >&2
 	exit 1
 fi
 
-- 
gitgitgadget

