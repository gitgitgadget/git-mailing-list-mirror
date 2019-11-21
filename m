Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB49BC33CA2
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9217B206F4
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acBDAguT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKUWUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:20:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40524 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfKUWUf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:20:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id 4so3023584wro.7
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Aw86E2JesYnBke1UD3Cn25oDyN4i0P0DvTe/Iw1CwQU=;
        b=acBDAguT8htPZkEpF7JO8OKVmqlb5FIiFfIZsRJ7uNsl8xF3Yzij2fgTQjNoegxggd
         ajvO9npDLVledwoLqrDHcew17xX2HEhPl31su4hjvoK5zli5vGpk5W3wex0RJiSs39ZD
         O+qmbcsXTj9WLpsPLrr1Fk4t8yhv0s7ApM1/NGPUVcYqwSp6fJJzx+C5pHapV7FK7dDH
         8VtQydBGcXd6FpvGt/+8VOQGQJj9PD5zSddTCRm+DyNLbLFXku7p/asKLGCFeF9iwq0x
         RMmMuWvZeBc75T+ZE+KlL6dVdfRCTgfTqyWfBBaf/T6IQzarmlK/bNE0k+zZa3bKTveU
         tk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Aw86E2JesYnBke1UD3Cn25oDyN4i0P0DvTe/Iw1CwQU=;
        b=aWtxiQTMLuKyRh/CY9zKJ9tm88CfLX9fyp+aJ5jpbruHL9HuRvQmsAymB4ApGExWpo
         lsX849vXT2iC6mDWT/7AEeitoBjGxEYUTup+GKGsbR8pUtY/3zUJxWp7UyZj9CFpLK67
         HrkEg0462Yfnd824RYDwgu0Vvv1r8u8JsbMObnyxca+GLT0hP9i+tMqYfgXVmaWbKVGn
         XzBE1cDMtEf/CwLbWhDys961qQPb2V9bofgxIA1rhsbcyiY3DWWsj8RlBAHeFT+e27Ok
         nwvcZc3gOMlK24klLyAeJ2WUNRBS5eo5uMFRCjn7TxPhqek56g3ARQ3xJamSmMWLelgq
         7E8w==
X-Gm-Message-State: APjAAAVAXQ+8jtxIUWjkyNFuyifyeqJRmce5CCSjxzvuMlocR7GfAx7/
        GhCa7/EUOD5lfCsmy4JU7HEWsklr
X-Google-Smtp-Source: APXvYqyE7m5cvAKv1a7DjvstlBfJqD0ZuBInC9yt81g3OZRLkl0pwz5UmZRfA5BdHLyGlLPdpdnbqQ==
X-Received: by 2002:adf:db4e:: with SMTP id f14mr13354997wrj.257.1574374833802;
        Thu, 21 Nov 2019 14:20:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm5430914wrx.78.2019.11.21.14.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:20:33 -0800 (PST)
Message-Id: <cd717ef5de44c965ae82607baccd1557fed02825.1574374826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.git.1574374826.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:20:25 +0000
Subject: [PATCH 10/11] t7519: disable external GIT_TEST_FSMONITOR variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The GIT_TEST_FSMONITOR variable was created specifically so the
t7519-status-fsmonitor.sh test script could tweak the expected
behavior depending on its value. However, if we set it externally
to use the Watchman integration, then it breaks the initial tests
that demonstrate behavior _without_ the fsmonitor feature.

Disable this variable at the start of the script.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7519-status-fsmonitor.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 81a375fa0f..443d2e653b 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -8,6 +8,9 @@ test_description='git status with file system watcher'
 # "git update-index --fsmonitor" can be used to get the extension written
 # before testing the results.
 
+# Disable an external value, as we will set it directly as needed.
+GIT_TEST_FSMONITOR=""
+
 clean_repo () {
 	git reset --hard HEAD &&
 	git clean -fd
-- 
gitgitgadget

