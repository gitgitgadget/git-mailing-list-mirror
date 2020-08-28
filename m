Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCB5C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9C420872
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq5gX1aZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgH1Mr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbgH1MrN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:47:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE87C06121B
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o21so798796wmc.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=InUKzhmVJZsVoLdzQXNZrn9VeJlbgKIHXnzWsess1dk=;
        b=bq5gX1aZIqiARS+9uY4clBH90vyZNP0/Wg3Dy8Ib+3v+pX/adoxPOYLnYysBDnGQ6d
         GkKtrjMryQMX4NdoQ9Ab/QBS4A7w7zL3Se0mj3Ww6p25SFvP8dMzYkeQv+TwR39NxgAh
         8elHn/q2PAwgnZu4taXaCo6ThZ8wIVDBxT6DLSucUNnP5CBkUQGGrJTEBgLtiraKffPZ
         8xJQnvv/hfQoGusnsS1RalM9lNwC9nrwfHjhzeTnGt8viHcxGqyPaRciTvt/EwPM1F+M
         dhfM2LcK1Bm0GDLRVOMMMrcQz0/LWf6q8GlWPkc395fJyK/GznBa4VSZuU7Yh97FhRbP
         2w9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=InUKzhmVJZsVoLdzQXNZrn9VeJlbgKIHXnzWsess1dk=;
        b=BZ2V4jA7Oh2EQC2YZDxJq2jfDbR9PYyQmI8avtW0Aut0vv3YJj6isoDC7FoSoCiaie
         BGJo5QY7ek8Qc9W1GcM07n6GGuHzGN7y/XOvsKtC4RbrCwlBiMNxQh3AVtXDOfQLXtwf
         KFp8bIcLAudO8BrntQNeM7l736EhvtVlYcfGxQ/XkWrbpFgVR4Q2WT0JZiU9BtkH+dG1
         R8JFIt8FxRBtHd6vKAHbl8oSF8SsGYM5OTeF1eFQW6ZbwV1WlhOFw1zOA/LwAmyKD/lW
         iZPsqtSc5mdyGcgxDKtIudH7VR+IIULYdDY+JsD/kNDuktSkB85NbFCDzQJpv6MiPSiZ
         yiOQ==
X-Gm-Message-State: AOAM531VOa/8TjF37bxwEPd3ko4lx8l5oLD5m4PLVBKBkbviIx314BwG
        BPCA3NwEHO3WyFml/2cRD/5lf0BV8Rs=
X-Google-Smtp-Source: ABdhPJznaSB39p8NGAP7fzZb4ZfJ3RipbvHMQHQ5ien/GKULeplJ15UxFcQBJgqaQh8nc6CyEXhSyQ==
X-Received: by 2002:a1c:c20a:: with SMTP id s10mr1451508wmf.55.1598618831051;
        Fri, 28 Aug 2020 05:47:11 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id o66sm2176878wmb.27.2020.08.28.05.47.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 05:47:10 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 01/13] bisect--helper: BUG() in cmd_*() on invalid subcommand
Date:   Fri, 28 Aug 2020 14:46:05 +0200
Message-Id: <20200828124617.60618-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200828124617.60618-1-mirucam@gmail.com>
References: <20200828124617.60618-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cmd_bisect__helper() function, if an invalid or no
subcommand is passed there is a BUG.

BUG() out instead of returning an error.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index cdda279b23..f464e95792 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -720,7 +720,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		res = bisect_start(&terms, argv, argc);
 		break;
 	default:
-		return error("BUG: unknown subcommand '%d'", cmdmode);
+		BUG("unknown subcommand %d", cmdmode);
 	}
 	free_terms(&terms);
 
-- 
2.25.0

