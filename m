Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE0BC4332F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB71D61264
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbhJDQ7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbhJDQ7u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:59:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F46EC0613EC
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 09:57:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id a131-20020a1c7f89000000b0030d4c90fa87so521082wmd.2
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hJTprmd6l9eGdcrH8bWYEQJ64Pw67KrU1jFu1jkOkoM=;
        b=LN2ZzZJF9LC5p7sEIja6I7f/ExAfhCPKu9Z9cSLLxQu41GfGJueL4G0IpACJVLC3hu
         4HzLsy09fQ9vR1aGVWx6P5oNarRoZs2PdOkcaxcgF4hJeCEOMFQu822h1EceVkxogUNa
         ipQPgUEUf9YgwmHVVcCupf337lzf27/RL/PhLmpi/gQ8sNBZNfqb9k8jdDWaGIbKQXSx
         eJghkQ/nrgIFeFmETqKuyjntQ/tnQT/SnzDkh3t/u5j/a/GVXQ2m/LHs5FVroNk944/I
         zj3p50Ee89IEFkxw/iLniait1/g66/U8ox+6thN+998VSFidGsHYOooQjxB09TtT/kGg
         3tHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hJTprmd6l9eGdcrH8bWYEQJ64Pw67KrU1jFu1jkOkoM=;
        b=x7qyhwxv1An5klkuQkwPH62bD0UZOBafGLs2yEN53KxTQjrIYsFlPWFQ7MYrdNzoTy
         AiZKMd6M7PYSl3qK4x/w9UZywOC0vaTwl7QPmsz9lgbFFJaF/XViMPVuEO3qStEWmRex
         oSJ1oIOn7atudRc9UCGc5gYBjtx09C8nN70oyAQ48GHg8kTuzyd8qSLZa884mJoy4Brt
         E6WgH5XDIjZUOkRs8v67Ss3XAXhLTJ2jZHB/fegHEb1f9aau73xBpR/pKSPWNDI4kSFn
         gazHguzO4+NUDdLdSdynkre5lea8UVNk6h4uTB3OOEEXEZAfg5BpyBNKvl2rsmc3YB7Y
         QN7Q==
X-Gm-Message-State: AOAM532/sfGyddC0vuVWvWNJ2cvgdX7ZaVSmqIgYaYGpx4Ctvs5nxkHP
        eCRBGvFFxFToRy8UGKTWn/w2563l4fk=
X-Google-Smtp-Source: ABdhPJzcPpM+wEQWIBsqLbppz0yqCm1WvLCJ1uYYT4AH9S53ssTi/jBQWlze0R8/3GNSGUeLuEADIw==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr20024370wme.94.1633366673325;
        Mon, 04 Oct 2021 09:57:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i92sm14634234wri.28.2021.10.04.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:57:53 -0700 (PDT)
Message-Id: <15767270984a87d6112ece4057dd10bb22bad1eb.1633366667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
References: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
        <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Oct 2021 16:57:44 +0000
Subject: [PATCH v8 6/9] update-index: use the bulk-checkin infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The update-index functionality is used internally by 'git stash push' to
setup the internal stashed commit.

This change enables bulk-checkin for update-index infrastructure to
speed up adding new objects to the object database by leveraging the
pack functionality and the new bulk-fsync functionality.

There is some risk with this change, since under batch fsync, the object
files will not be available until the update-index is entirely complete.
This usage is unlikely, since any tool invoking update-index and
expecting to see objects would have to synchronize with the update-index
process after passing it a file path.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/update-index.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 187203e8bb5..dc7368bb1ee 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "lockfile.h"
 #include "quote.h"
@@ -1088,6 +1089,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	the_index.updated_skipworktree = 1;
 
+	/* we might be adding many objects to the object database */
+	plug_bulk_checkin();
+
 	/*
 	 * Custom copy of parse_options() because we want to handle
 	 * filename arguments as they come.
@@ -1168,6 +1172,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
+	/* by now we must have added all of the new objects */
+	unplug_bulk_checkin();
 	if (split_index > 0) {
 		if (git_config_get_split_index() == 0)
 			warning(_("core.splitIndex is set to false; "
-- 
gitgitgadget

