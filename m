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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AE561F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388658AbfKHUI2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:08:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44908 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388378AbfKHUI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:08:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id az9so3725037plb.11
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 12:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ovt30J/086frQrlPGWoc9V0Rs2pu2axvgyDrnAnjtJs=;
        b=nVXg1sIeESbuuxzJW8aTLNFIZZ/DyiXL+ELn0u0wupiHwa468JZ+OJMq+5JBdCK7Zy
         Uk3cyYFkZ+5d0QVpHDfnZgSku9NcSHpQ9zY3OAFhH2lEH/ggI3j8iiarc/mYn5Vwj8wd
         b1OsrXFjojHhVUcrfOgh42AJw7YWnoHkgotIp9HTPNApMrWHvh7K1u3XAd5YmIJtq/s/
         ynMXTa+uAO4YdQEc8wqVWv6UljisTirgestQfIRwyy3ln5yqz6U5gGK6Y7PvNVgEo7/N
         K2eSA3CqVTMeyeNnyo5xpMxAITM2bET+j+A19dFZsiF65m+VH1A9mPBNBukc3IGMfNAe
         Ymdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ovt30J/086frQrlPGWoc9V0Rs2pu2axvgyDrnAnjtJs=;
        b=I4T4ms7OnNnvifKXvjZxTk3Tc0wJD1wPQuJiYdPr5j2cktyuzY1FaMTXFAzsjeBTvV
         jpExAqyvYIv1AwIocdnBzNGkxxhRFj7fKC5hymxdAgRqIfQAIVk/d9tgAiPiWoi0Yi4/
         GTmzuGXSZhSgGdGq5HSod4MSuOPsWNS9hu9HbxDowvM058Yg5iv9TI3sEpoGe1SMKHUt
         I1R4X4BqGlQ4GLN7E7rW90O1yUl5k2ha5galyKf+LxGwWm1nAc9LCSo3oHtzYnV19p5M
         +bHYe6LTi/EPv6uW6Abyndz5NgqZSJcgZ330aE8SrZx3cn1aAxgb0bmdFRoaoSU8OdRn
         FgrQ==
X-Gm-Message-State: APjAAAXW5BByYItfag4axxxgXWOwYM7MyvACYluEIbksW+robcZEjQKw
        0zEvQXEljvOUNnyd/GuxxSNEK4gm
X-Google-Smtp-Source: APXvYqyxm1K2Apdh+BBFflo1n55HtaNu5IQAgCiqZLtNK430QCFWMtXsRs2LS6OvFq1flMNk5ydMpA==
X-Received: by 2002:a17:902:d891:: with SMTP id b17mr138262plz.256.1573243705558;
        Fri, 08 Nov 2019 12:08:25 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id j6sm6538530pfa.124.2019.11.08.12.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:08:25 -0800 (PST)
Date:   Fri, 8 Nov 2019 12:08:23 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/10] revision: change abbrev_commit_given to
 abbrev_commit_explicit
Message-ID: <b970e52b57d2f5f743d2be038bb8deaca5982fe9.1573241590.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573241590.git.liu.denton@gmail.com>
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
2.24.0.298.g3e88fbd976

