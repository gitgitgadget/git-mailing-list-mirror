Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489311F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390559AbfGRNTW (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44669 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390469AbfGRNTT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so28637847wrf.11
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4E39/cJgnjFrWFwm9MSBe6qrPTWmtaSUqvous69vE58=;
        b=ni++GqyqdNNnTdbPuixwK+Argi0qD3HOMzUThLS2oiGiykyO7icRrYyJOKS7uDXAOc
         iKRqYlShaRZioYdDo626xk58d2ANUKjlTIxcAoAHIMpaWcQDsNrZDmgDpjS90+8ke9By
         CcCIrrY+A0hmy3bp7JCdaVpQ25178K9UAsTfgUvdO5v6NCAsRNnKfm945rq2GmftYHo8
         tiI7BzqeaPMh+jnBpHpfDfZYLd1An5MW26o2U7DvF6oOKTucGqmJhk7XBbDgIjUuIn4M
         VV9nwLJxETYtaMBbWSnrCIU8roWqJOLKBXsh63y0nEUujwKK4R6u97fZaKWEwXk6XK3u
         jQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4E39/cJgnjFrWFwm9MSBe6qrPTWmtaSUqvous69vE58=;
        b=Q6F1Gx6zKBmZn1X+YsyBuW1XkIa1KsfYp4w00PBAX3FFHsSz2aqNG5GYGiXZjIC5ZT
         gDXvPt/bY68vc36j21Q3auP+7VePgJtPXiES+CMl6oG4XGC6ylzikuhIaiAfMyaV3YJg
         dO4Lie3TNJB22SwErB3f+108A/hJws0Yl+w7sZ1QoXF32nzASJm8pX8cBB/7Khb2J5Tq
         wCELpDeAuek0irsrCDXtfkcL6DSki1WQcm62zQswMLq0IoBrE62tlUEQyDs8BprduSAe
         DbMdyd/SUiw8mtYMWYP41IRRWcrXhLdqAVzGIkHD9tnWRf9Yf8XrfuwZ7BdSL0ZWxeKs
         46sg==
X-Gm-Message-State: APjAAAU88vsyvAgOsG+7HxagA8HQCd5+O1LEC1NVFpZ3fKljIHjd7gI1
        V18wDA0Y43yrpKtJ+lbPG+zhUR8k
X-Google-Smtp-Source: APXvYqyroCV7deNO2RdW+eFxHI+yn/0756ZSYb+Ev2KQeZ+03I5RH6IQYerOWq5u2g2uLuvtXrXpbw==
X-Received: by 2002:a5d:5012:: with SMTP id e18mr21486717wrt.166.1563455957149;
        Thu, 18 Jul 2019 06:19:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12sm29863785wrg.5.2019.07.18.06.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:16 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:16 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:59 GMT
Message-Id: <151b9921d09dd622e27caa4571d260ed24f4d69b.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 24/24] git: avoid calling aliased builtins via their dashed
 form
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is one of the few places where Git violates its own deprecation of
the dashed form. It is not necessary, either.

As of 595d59e2b53 (git.c: ignore pager.* when launching builtin as
dashed external, 2017-08-02), Git wants to ignore the pager.* config
setting when expanding aliases. So let's strip out the
check_pager_config(<command-name>) call from the copy-edited code.

This code actually made it into upstream git.git already, but it was
disabled in `#if 0 ... #endif` guards so far.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/git.c b/git.c
index f4c0478f32..3049dae85b 100644
--- a/git.c
+++ b/git.c
@@ -743,8 +743,6 @@ static int run_argv(int *argcp, const char ***argv)
 		 */
 		if (!done_alias)
 			handle_builtin(*argcp, *argv);
-
-#if 0 // TODO In GFW, need to amend a7924b655e940b06cb547c235d6bed9767929673 to include trace2_ and _tr2 lines.
 		else if (get_builtin(**argv)) {
 			struct argv_array args = ARGV_ARRAY_INIT;
 			int i;
@@ -779,7 +777,6 @@ static int run_argv(int *argcp, const char ***argv)
 				exit(i);
 			die("could not execute builtin %s", **argv);
 		}
-#endif // a7924b655e940b06cb547c235d6bed9767929673
 
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);
-- 
gitgitgadget
