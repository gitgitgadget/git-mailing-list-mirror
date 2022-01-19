Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F7EC433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 00:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350324AbiASABI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 19:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350322AbiASABH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 19:01:07 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E82C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:01:07 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id ft15-20020a17090b0f8f00b001b4f9b64cc7so348609pjb.8
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rMcxUYa+pYWoaPyu7/jTRBRqiC6fopgEoB9QwP13mZM=;
        b=kZ/9oSC6MX0XDmlNcQ7MKYmprD1BVYL3RonSfGyZKT42E+m4B+rb4PQDDEa2RIcexM
         s5dcQVViFeoIVXF1M3f6jkFZQtMhBlJ/ZQEmKkEO9sesCPlGcYNIIGRiB4tdS2IcEO+2
         BKTMD2Lp9UK9LtP1psO8DV2iVOz1dWQ5aMEw9u9y6NbYS4RBkn4Ap0+iVmJSnzKPlDRS
         PXGGeYiLwY5fwtZacQmPOXL7vEyfiOSO2sX8YQZdqSn5kmLCEnozOWsCY+IseV8l/XkH
         L5evVVcQZ0gmPmovXja1K+6sZfbA/ugzv7XI/3GvYZ5g5GBQWQpC3RlJF5xUIjbZ9K4k
         EbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rMcxUYa+pYWoaPyu7/jTRBRqiC6fopgEoB9QwP13mZM=;
        b=i6ifHrzf+Hrv7grm2fZb3uSegfLB6lV9btVJucnUqJovtpH+9llPCBZhclKc/VROTw
         ZGA74hCDlIJwxwY4pOrW1YsbyTf+G1Ykt5dVqjzOhYaC9Jd3ZMAXDQRFhGLdO4KndK+e
         O6MvvoXQCgVNvvmA0CmwzfuWlnX9fIiPIqmRDdfRZVLKUoN78aiH8AXSLdihHXEmYxpN
         +lC5UFKjsec35N5lW1wYYkqdHm6qeBMhB8SGC+lz616OLXuxQyWnDcK7B8jbkWG7Sri9
         HSqMnTUzWU71X/G/EAmkr9Hux60r1qTRdVyl5oCKFNTsSZVCtXQM8nOA0SUsnmXN/t4k
         6Bkg==
X-Gm-Message-State: AOAM531OFofwz2A6cO+IvfJ6mX1SHLnaWAF7m29tZfng0WhwandknRE1
        6iHwxl96taKwvQNrmle7NW6pTD5hzwvBE4McOYq3wmk3vJKnnhHKW083m7hMh9CJ+MGnA14Nv6y
        w5VT35pwR/dA/2deDI0z12T9JQfmJW/LghtbVpnxa/9WZT5T9+VB3qRsT1pjIEBc=
X-Google-Smtp-Source: ABdhPJzYkIBbazZqjYJUPNpijXWzyLCIQrkA6rXXEvO7yRwi3kkxBA9ox1dVW56+q7ggo3phSkpSShttFhewug==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:6bcc:b0:14a:bd99:1ae9 with SMTP
 id m12-20020a1709026bcc00b0014abd991ae9mr11671972plt.62.1642550466470; Tue,
 18 Jan 2022 16:01:06 -0800 (PST)
Date:   Tue, 18 Jan 2022 16:00:54 -0800
In-Reply-To: <20220119000056.58503-1-chooglen@google.com>
Message-Id: <20220119000056.58503-2-chooglen@google.com>
Mime-Version: 1.0
References: <20220118185453.33710-1-chooglen@google.com> <20220119000056.58503-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v6 1/3] fetch: use goto cleanup in cmd_fetch()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace an early return with 'goto cleanup' in cmd_fetch() so that the
string_list is always cleared (the string_list_clear() call is purely
cleanup; the string_list is not reused). This makes cleanup consistent
so that a subsequent commit can use 'goto cleanup' to bail out early.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fetch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index eaab8056bf..0a625cb137 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2095,7 +2095,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			gtransport->smart_options->acked_commits = &acked_commits;
 		} else {
 			warning(_("protocol does not support --negotiate-only, exiting"));
-			return 1;
+			result = 1;
+			goto cleanup;
 		}
 		if (server_options.nr)
 			gtransport->server_options = &server_options;
@@ -2151,8 +2152,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		strvec_clear(&options);
 	}
 
-	string_list_clear(&list, 0);
-
 	prepare_repo_settings(the_repository);
 	if (fetch_write_commit_graph > 0 ||
 	    (fetch_write_commit_graph < 0 &&
@@ -2170,5 +2169,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (enable_auto_gc)
 		run_auto_maintenance(verbosity < 0);
 
+ cleanup:
+	string_list_clear(&list, 0);
 	return result;
 }
-- 
2.33.GIT

