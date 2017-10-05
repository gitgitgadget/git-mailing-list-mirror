Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0269E1FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 20:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbdJEUzK (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:55:10 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34183 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbdJEUzG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:55:06 -0400
Received: by mail-qk0-f193.google.com with SMTP id b124so8147203qke.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d6YIx8qOTGJITZPcBaRd87Pzf3FMZoyWNiC4TVxjibo=;
        b=Jnr7gFziu+Y7S3BhddeLxitZU2ROh2CrWWO+LZtGGaIx/2b05l1gioQksGfcQzqKLx
         iamLfC+wvvja09AhjK6X1HuSP6+klm0FMW7YsLS6enTa8sH6RinYwWKu+GtxWBiojX92
         fs/JkMTlT9XVz+gKnf4uhIdhXIAncfaBpH/5ki1m6z77Xs1XwjygZFWnxuhGfiOnr4V5
         Re4+X68+SDd1AeJTpXGI+hcPc9aQQlVN+ZulV2z9zhJE0XYQoKBB9v7pApZ6g3uiTPah
         vA5tvWJfsYisFXR+Q6BNwSCIqKfu5LTHhzirdX/PYYPmQpKVq3x4c3XCFl5LcntKEjwn
         aCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d6YIx8qOTGJITZPcBaRd87Pzf3FMZoyWNiC4TVxjibo=;
        b=Na2WVKLMV07OTx4aSXU1eNoSuq6yrXjPLZRPhuymkoblOSNkAMKJkTl2mGexxfLaBb
         MaLuYcTvjJ21vPFOlXp/QQ0RgSG/ytQqxGgU8N6SD1OKs6KjPt5gP9V+1jvsDQG8lImm
         S/oEELZL7F67nVQKV5PHMP26WmoAVForJJoUA7wfdKKNgxuBvghCNi0jGd3OfGmi6Saj
         e1TOmlrFAP7kBsZHY4yGRXBmjtA/5fAffjMndpQLGsApiFOi2TV6V3B2Yg4uvlXpRADh
         nWJvzb192JVL4kxf48WV2dQHE8U4ubemlDoIiXRBZqCtxGkLw9nFPXXYKgJcEMjUZRlM
         D9wA==
X-Gm-Message-State: AMCzsaXAJj5USD5nldaQQpC7IDoR9gQqr/zoA5h24foKhqrRO989q6IB
        64GcpKtHkIHhQ4D2Lz8TqJ+2LGZEtFw=
X-Google-Smtp-Source: AOwi7QAPeHkc7QeuDNcaqrkIlHveQAggCVewk6I3veo1pfmCSnhFT4ARqQ6xWVH55FZhuJmCP09Lzg==
X-Received: by 10.55.12.130 with SMTP id 124mr13957422qkm.186.1507236904851;
        Thu, 05 Oct 2017 13:55:04 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id x127sm11871596qkd.3.2017.10.05.13.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 13:55:04 -0700 (PDT)
From:   jameson.miller81@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, bmwill@google.com,
        sbeller@google.com, Jameson Miller <jamill@microsoft.com>
Subject: [PATCH 6/6] Handle unsupported combination status arguments
Date:   Thu,  5 Oct 2017 16:54:43 -0400
Message-Id: <20171005205443.206900-7-jameson.miller81@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171005205443.206900-1-jameson.miller81@gmail.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

It is not clear what the correct behavior should be when you ask for
specific ignored behavior without reporting untracked files. For now,
report this as an unsupported combination of input arguments, so it
can be modified in the future without back compat concerns.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 builtin/commit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 34443b45d3..7812e106ad 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1400,6 +1400,11 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	handle_untracked_files_arg(&s);
 	handle_ignored_arg(&s);
 
+	/* Check for unsupported combination of args */
+	if (s.show_ignored_mode == SHOW_MATCHING_IGNORED &&
+	    s.show_untracked_files == SHOW_NO_UNTRACKED_FILES)
+		die(_("Unsupported combination of ignored and untracked-files arguments"));
+
 	parse_pathspec(&s.pathspec, 0,
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
-- 
2.13.6

