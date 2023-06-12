Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7D9C7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjFLMxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjFLMxR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AFE10CB
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f735259fa0so43582315e9.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574385; x=1689166385;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhDEk93Fg0o2c/F17D1rZD+k18ouO62Bw/yMg100lUA=;
        b=iD944WS0dVubupUSBzWE9type4kXprD80YE7Yr4K9p7SWt57eNkyPVuLeZpawWLxqc
         Nnsum/3jzXxhvwabh+Rz9S0dsTuQzZF6uynlXYifcnbrTxsV8wowYTemRr/e3sMSxsaq
         4lfItEnuxJGS+FGzw21Of4+PeMpsmTcn3r0A3qlK1tNnGW2t3oJ6eJai4BWSSSaP/i49
         gT1G0h2nmFubDl50d2o0LjgTK1Pp3UpXdi2jiedhRZ0SU3LzV8jMckVYGxwQIaZQSR4B
         N2UiNvEDGVBqeqB1yqCc11TdYwUN0rUM13kpbS+8fdGo+/MRpHWo2519nrcbYSFg0bbi
         nPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574385; x=1689166385;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhDEk93Fg0o2c/F17D1rZD+k18ouO62Bw/yMg100lUA=;
        b=Fn5Zyh3zlVU9k/c3cdiNftovqQCzW4MTf9yr44PdJEuZL9pOvmNBytfGlmnpVDQiMl
         RbdSOH9yZWMPymqDsiHnmTyK8SB7GJj/1ncNT9LATkiS573cEM7HhBG5OwekODkNXox5
         hN9H9UkVmWgoyPdwlV5iAfLy5hvXsWfcDjQjkWiWaVoe3GPa0ytbwylA2irjODV7GX39
         KCFM4HQcKOR8Y5SL4+eCkzPAjMSRZX3ILalUq3IGq3bUk9GMcDEFYPIceHqS1BlpUG3p
         AYYHw3Xss0J3K6WLWSJ6XWZwpD4E7cj9BiiRN07gxhCtOjRUTphpTZQLc8xzlH96APub
         rbbg==
X-Gm-Message-State: AC+VfDyzJJZz0AC50nx6Vexz4P7LHO8hcL+cFUwj+IImNTKsa3MnIzcK
        mr6cHxooPmDe1y6EGkTGsAZAALM8Vx8=
X-Google-Smtp-Source: ACHHUZ5Wk2TWI5IWvTiumZD7W+RVdg1mfP2FuyE4ZroU/tXDOd7mSf4TJWLqSQjxaxzQORfkBf2FMw==
X-Received: by 2002:a7b:cc12:0:b0:3f7:f398:e1ca with SMTP id f18-20020a7bcc12000000b003f7f398e1camr7302471wmh.26.1686574385546;
        Mon, 12 Jun 2023 05:53:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003f42ceb3bf4sm11397553wml.32.2023.06.12.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:05 -0700 (PDT)
Message-Id: <5d32e972a0c6e099f1d30d4a2a8cbff6e204b09e.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:40 +0000
Subject: [PATCH v2 12/25] completion: complete --irreversible-delete
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b4d0643b049..e74636ebe86 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1757,6 +1757,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--textconv --no-textconv --break-rewrites
 			--patch --no-patch --cc --combined-all-paths
 			--anchored= --compact-summary --ignore-matching-lines=
+			--irreversible-delete
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

