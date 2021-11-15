Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17083C433FE
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EB461B66
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbhKPD1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244139AbhKPD00 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 22:26:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0D1C126D03
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:10 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w29so33827825wra.12
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hJTprmd6l9eGdcrH8bWYEQJ64Pw67KrU1jFu1jkOkoM=;
        b=R8sguujjto+EFvSRgU5AGV4NcXGppsPTEWu2pqpXh1++rEs8IZaTZBFmUmiYtiyGIc
         h4olNABc4tIdmiPGMFHAU5g/khpOF15BoxWnIxXhfLALuHj1YH82b2FccZNDvWVHAUjK
         l8awAh6vwZwWNqeDcIFat1sg/PvIfPRNHxXKagn/N0SWQbu5hlsnv6QoMoxLpuRurmN3
         blRNnSU+p/NMyzCIxBO8EkwsHjMUrpVWzUD7BRCW1jS44KlXIoTuXbDsq8sVFXkuHE3G
         cNwcxprfKhNGoU1m8urr0uAy2phbQS2YeDUBDBRwT87J8FOPahDFjG/btmafnw7rpnbL
         eUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hJTprmd6l9eGdcrH8bWYEQJ64Pw67KrU1jFu1jkOkoM=;
        b=VDxmA6/mnJmjOldQWEYr9CHXYAz1ye+DYqoZABi8nZzX/t8JEkr8q2I5BsbKnTpiYe
         /BCH2kWZ2gfnfSvkoEaIY2PmzZi+QXJCRl0WlYyNPM/RKT/uUaHuTz70h7mcyR07esle
         vJeyM1cOB+SDLTyD2N+Kv3GdrYpir1kWBBnnTPwI4rijF68W52sLpTFn81cTHy8ZR+iG
         N8+K5/nTL7M2YNZFE0rB3/oTClculx2nN3bw6OpmLrRMkXywbrJOO44nYIryskZf3qg0
         6r1ZC0wtj2ZCJnwJRj/4CigamQAPGxx43h3hqqhuUadYDCbJnqGzfn+afmcMzjmX/e1d
         JY2g==
X-Gm-Message-State: AOAM530YAva1a6U4+yDmeiuixsV+fD6LXdfs1sbjAxtYHDyYB7X9htaq
        +Tu7RIFHZpC1+luYp53DNFGEFmp6TfA=
X-Google-Smtp-Source: ABdhPJxtEs8y2xmQMy/j/izJ+5/4LCCnNvcUySdb8tT83PzSt+YC4WP+Io8iS06cdggn3OSORfHwKQ==
X-Received: by 2002:a5d:58c5:: with SMTP id o5mr3810524wrf.15.1637020269361;
        Mon, 15 Nov 2021 15:51:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 38sm7180264wrc.1.2021.11.15.15.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 15:51:09 -0800 (PST)
Message-Id: <4a40fd4a29a468b9ce320bc7b22f19e5a526fad6.1637020263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
        <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Nov 2021 23:51:00 +0000
Subject: [PATCH v9 6/9] update-index: use the bulk-checkin infrastructure
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

