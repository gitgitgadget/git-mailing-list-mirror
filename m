Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8F771F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 05:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeKNP0w (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 10:26:52 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39617 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeKNP0w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 10:26:52 -0500
Received: by mail-it1-f193.google.com with SMTP id m15so22107154itl.4
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 21:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rqhc5FSyIvLQM32fWWnSu0bjkk3luOMJ+AT6RewXqVc=;
        b=gRed1Q4Pk7mJD74Y5AnijCesLbFcYnu4l88yNrnHXEcn5qBXlXjZwoJ+EZO8nZffff
         +kQoMCW0m0/MUo4iGxfjOY4DyUed85zR2vcdmiWUxkaDFvVvC2dtKUeY9ebmCEBFYeYm
         uXuwzXWyzqlaw7UoQx6vUTMgAx+5/wj+HPYCqx6leuyjpogo16c2//yOjaf0+n/h2YWr
         0dsVSdXWeJzaVlLJucpf7MvKMCb7x3rVEk8Wt3J+jol57irEcQ0DIPX3n9FJzU3kcD7Q
         DOtORQ3oS31rTUf/VwzItgE4Hz4edhAxs5dXJGrreGAUMbFFLYhKfk+CUuRp8xNFh5bz
         rLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rqhc5FSyIvLQM32fWWnSu0bjkk3luOMJ+AT6RewXqVc=;
        b=c+Ml8zY1DJjVijXBaDnjbKZTrz9bAdpND6kxtbm+1/1x+COEYse1aIAjLD8SeKH1p6
         MMEpzQZ+oxTcbLtBkcrkvV2qtGurSQy+qPUMwVp0Xv3RjQ0dh050AYD5iRZoftGfaz2F
         DCsStSIwgK4GgijB+MCfJ3D+I3nH/mF8QbW6ag9e2+dU1AI7mXRLJ7Cz1w04bu5W6Ehw
         kVOyHS78GwWCtqHNUR1IjbBR/wItJaFBgiPBPISiWbFOnV0RYSmr5ewBQMYZB/op9k3m
         es1dr6TwTUXHgxggVYmc/nhq2AXYUUUh5fXCqxxpwKg6ROW2kYXTcbkJgop1V/f8GCua
         oLug==
X-Gm-Message-State: AGRZ1gKOaDazCvZW97x5xhup62tmZbwrfVIZ86KoSoY+t7m1AExY7Hn9
        i4FiGHNf7o57S5O3v5p/aoyBblCW
X-Google-Smtp-Source: AJdET5ea7MilbQispJJ2odLIJVlaQHqarAUd8GVV/5eIXjGAgmjqdKPRy2Jj66KsX9kkWHKGILzczg==
X-Received: by 2002:a24:d204:: with SMTP id z4-v6mr800589itf.11.1542173112053;
        Tue, 13 Nov 2018 21:25:12 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id o74sm3469479itc.44.2018.11.13.21.25.11
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 21:25:11 -0800 (PST)
Date:   Wed, 14 Nov 2018 00:25:09 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 2/2] merge: add scissors line on merge conflict
Message-ID: <a1d4f535416689f3e5e629bcafd01515ad8dd6ae.1542172724.git.liu.denton@gmail.com>
References: <cover.1542172724.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542172724.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a bug where the scissors line is placed after the Conflicts:
section, in the case where a merge conflict occurs and
merge.cleanup = scissors.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/merge.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 8f4a5065c2..c5010cee5e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -36,6 +36,7 @@
 #include "packfile.h"
 #include "tag.h"
 #include "alias.h"
+#include "wt-status.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -96,6 +97,9 @@ enum ff_type {
 
 static enum ff_type fast_forward = FF_ALLOW;
 
+const char *cleanup_arg;
+int put_scissors;
+
 static int option_parse_message(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -243,6 +247,7 @@ static struct option builtin_merge_options[] = {
 		N_("perform a commit if the merge succeeds (default)")),
 	OPT_BOOL('e', "edit", &option_edit,
 		N_("edit message before committing")),
+	OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
 	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
 	OPT_SET_INT_F(0, "ff-only", &fast_forward,
 		      N_("abort if fast-forward is not possible"),
@@ -606,6 +611,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
+	else if (!strcmp(k, "commit.cleanup"))
+		return git_config_string(&cleanup_arg, k, v);
 	else if (!strcmp(k, "merge.renormalize"))
 		option_renormalize = git_config_bool(k, v);
 	else if (!strcmp(k, "merge.ff")) {
@@ -894,6 +901,13 @@ static int suggest_conflicts(void)
 	filename = git_path_merge_msg(the_repository);
 	fp = xfopen(filename, "a");
 
+	if (put_scissors) {
+	    fputc('\n', fp);
+	    wt_status_add_cut_line(fp);
+	    /* comments out the newline from append_conflicts_hint */
+	    fputc(comment_line_char, fp);
+	}
+
 	append_conflicts_hint(&msgbuf);
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
@@ -1402,6 +1416,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (option_edit < 0)
 		option_edit = default_edit_option();
 
+	put_scissors = cleanup_arg && !strcmp(cleanup_arg, "scissors");
+
 	if (!use_strategies) {
 		if (!remoteheads)
 			; /* already up-to-date */
-- 
2.19.1

