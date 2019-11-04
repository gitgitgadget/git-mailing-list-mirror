Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF51C1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 20:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfKDUD5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 15:03:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35883 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfKDUD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 15:03:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so8120654plp.3
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 12:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bH4fJjFPG3gave2oZpr+9i1o4EYmpJA4A1zunk6z7ps=;
        b=L2Ssoidl43RDPEUF6xVavpL98gdrxFBzyNttLcfft0FLqb7rX5VcT8goxX5AVtCuqV
         K9NTX2UVdpp2LMaI1zbnL/uNDyW66ESinZ/gJaXcuKEpS2D9zfgqn/TG9v6J7TJdNABA
         32kBiJD94RFkjmhMkRvxb+ZotEOXtXXYSRZ7CTAl2cfJsbXhYTt+vB057CkHyHMKfn5t
         EzciuIfBn32n/fGhel0pi3oP7lSbrZzZleEPyMzcAE9xZIuUybmdMU8n5B4WY1HVOd0F
         xytCJ9qNWdjDcIOFQU+8iWzR3J6/ro9Gh4w9pJ4fN1izgxHVqQyz09Vpsqw56U+qSJ0Y
         tsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bH4fJjFPG3gave2oZpr+9i1o4EYmpJA4A1zunk6z7ps=;
        b=DG8d/RENWFzTzLcdRlmjlPbEGUumd31rUkvCvi0PIzGpLDPUVQhGJTz9yPLaH4RH2T
         hBTnyc6atNmw5RjyJtdJg+aVxnDwWcwQwKV4FDrskRMRtvLtel5vaOL6LqIgMB9BdQGF
         q1qT94AusSGQaQN7YubuaWTCm8XLXgW8QjzhfhUS5pUILIwPtsqeb2SJWjKTLtAF1grF
         Lkq/7km+Xk9JK/TIkEHWaC1qU2a/aiPp7GRMGm7Cxab4fGlr6Vm3Rr8Dta+DYrbVCNun
         xEb91izmuvFz1Z6QavBo8FAbSdkXfiY2rs3k/iEuFZQr6icKfqyqLRT7LDoNwNezDcx3
         LhVw==
X-Gm-Message-State: APjAAAW+AeFYWIzxqokW8fitBOmR0bUhXlMvGHm4wKlkRa6OVoNbtmZP
        Ujq4Zxr7SqVTd9/ig28VW5lKKGfS
X-Google-Smtp-Source: APXvYqwRhRtkZoG9aFbkpqEuxUVDB89ZwiOvhSE5eidLmy7B3CbmtNi2gM+mS+4CNS1ROSsQAfF8aA==
X-Received: by 2002:a17:902:5a04:: with SMTP id q4mr29273165pli.34.1572897835415;
        Mon, 04 Nov 2019 12:03:55 -0800 (PST)
Received: from generichostname ([204.14.236.210])
        by smtp.gmail.com with ESMTPSA id b9sm17858853pfp.77.2019.11.04.12.03.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 12:03:54 -0800 (PST)
Date:   Mon, 4 Nov 2019 15:03:52 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/8] revision: change abbrev_commit_given to
 abbrev_commit_explicit
Message-ID: <f6f6b3d6710c7375db3e92f97245f8cf20231d1d.1572897736.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572897736.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we want to know if `--[no-]abbrev-commit` arguments
have been explicitly provided. Since `rev_info.abbrev_commit_given` is
only used in one place, co-opt it to become
`rev_info.abbrev_commit_explicit`. This information will be used in a
future patch.

With this change, the semantics of the original usage (in
the `--pretty=raw` codepath) aren't altered.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c | 2 +-
 revision.c    | 3 ++-
 revision.h    | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 89873d2dc2..e4df16be79 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -230,7 +230,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		 */
 		if (!decoration_given)
 			decoration_style = 0;
-		if (!rev->abbrev_commit_given)
+		if (!rev->abbrev_commit_explicit)
 			rev->abbrev_commit = 0;
 	}
 
diff --git a/revision.c b/revision.c
index 2151b119b7..02b49ab754 100644
--- a/revision.c
+++ b/revision.c
@@ -2271,9 +2271,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			revs->abbrev = hexsz;
 	} else if (!strcmp(arg, "--abbrev-commit")) {
 		revs->abbrev_commit = 1;
-		revs->abbrev_commit_given = 1;
+		revs->abbrev_commit_explicit = 1;
 	} else if (!strcmp(arg, "--no-abbrev-commit")) {
 		revs->abbrev_commit = 0;
+		revs->abbrev_commit_explicit = 1;
 	} else if (!strcmp(arg, "--full-diff")) {
 		revs->diff = 1;
 		revs->full_diff = 1;
diff --git a/revision.h b/revision.h
index addd69410b..7670f29973 100644
--- a/revision.h
+++ b/revision.h
@@ -185,7 +185,7 @@ struct rev_info {
 			show_signature:1,
 			pretty_given:1,
 			abbrev_commit:1,
-			abbrev_commit_given:1,
+			abbrev_commit_explicit:1,
 			zero_commit:1,
 			use_terminator:1,
 			missing_newline:1,
-- 
2.24.0.rc2.262.g2d07a97ef5

