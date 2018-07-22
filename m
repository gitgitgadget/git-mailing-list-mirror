Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01F351F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeGVKyS (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:54:18 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45019 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbeGVKyR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:54:17 -0400
Received: by mail-io0-f196.google.com with SMTP id q19-v6so13256334ioh.11
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/U5thiL9fmFGnG5zS9F0+oVPxKbIDYYXF0dmEHcQ2UQ=;
        b=NOgeuFS16S+uJ4NphHEdWHagd/Jw5D8IQLE6vwDNpRMH8yXcS3cxbZhxDQN0o58aT1
         gC0S14kEECaiVH0swwG0FUD/qAGfalAmUjMoAYcOcstr8VNrLHn5PfFXRiYUNYvmkWI5
         qtpZMfLQNZLRlS/r79DX2umhzhW3SQZLzJEw6WsKNB0Iaeyn4c/324LqlkW9sGrVho+c
         +wKZq/t4hWiTszht5oHq9RPW+xo1nVSr8U8QDmGL8XmTS0nNIrU2OSCRPjHoyLQxdLbj
         jLFp3o9iqVcmjZeYxD/mnmmkciZCRAIZOj07PbUAaXyoA1M+35GOmvWNFQFt2YQXXMnt
         Pwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/U5thiL9fmFGnG5zS9F0+oVPxKbIDYYXF0dmEHcQ2UQ=;
        b=Vce17H2ptTjBWquFPicrPLsDMbzi7lBRY6N3djamWcUuahp2pBVENN3kKOhkA0S/6/
         9P84ZvdkLi4vHuqKGkTGonhEihpTKtF9UoU9mjgr9NrGyaDuVM67xZr3AQDkkQPnKGXi
         7f391Zn1SeymMMufGy4BCGNBPMVa6m2VcO02ajmVbY6f2O3R7j5tEADF1cw+MVEtAk1P
         oJhtOsdwK/MDTTz6mf9CNK7jSIrkMY8l77auekZsBSCG9LlgyJIEHkYsAE/4kH+WD374
         7SpfYFojV4zx9D07ZumZs5uDf6wXxCpnklZfAFM8zAmetsIHfR9BRRDbTxmnOfDpVS3K
         ORMQ==
X-Gm-Message-State: AOUpUlEswb2ZseklNYYauHet4J60ZV2JiejUt8NP6N/LBIpYu3vT0BOQ
        zAG6KzYs3ZMUI/cofUHKxMcvRcC2
X-Google-Smtp-Source: AAOMgpcD24pc8bwrBKgVLymkFBDV9myWIEq6aMrK2V0LFIkVIuCLfkZjEXNA1Pc+eFmTJ1Rgs9F/iw==
X-Received: by 2002:a6b:103:: with SMTP id 3-v6mr7226974iob.78.1532253488023;
        Sun, 22 Jul 2018 02:58:08 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3681298itb.29.2018.07.22.02.58.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 02:58:07 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 13/14] format-patch: add --creation-factor tweak for --range-diff
Date:   Sun, 22 Jul 2018 05:57:16 -0400
Message-Id: <20180722095717.17912-14-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180722095717.17912-1-sunshine@sunshineco.com>
References: <20180722095717.17912-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When generating a range-diff, matching up commits between two version of
a patch series involves heuristics, thus may give unexpected results.
git-range-diff allows tweaking the heuristic via --creation-factor.
Follow suit by accepting --creation-factor in combination with
--range-diff when generating a range-diff for a cover-letter.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-format-patch.txt |  8 +++++++-
 builtin/log.c                      | 10 +++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 425145f536..9b2e172159 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -24,7 +24,7 @@ SYNOPSIS
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
 		   [--interdiff=<previous>]
-		   [--range-diff=<previous>]
+		   [--range-diff=<previous> [--creation-factor=<percent>]]
 		   [--progress]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
@@ -250,6 +250,12 @@ feeding the result to `git send-email`.
 	disjoint (for example `git format-patch --cover-letter
 	--range-diff=feature/v1~3..feature/v1 -3 feature/v2`).
 
+--creation-factor=<percent>::
+	Used with `--range-diff`, tweak the heuristic which matches up commits
+	between the previous and current series of patches by adjusting the
+	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
+	for details.
+
 --notes[=<ref>]::
 	Append the notes (see linkgit:git-notes[1]) for the commit
 	after the three-dash line.
diff --git a/builtin/log.c b/builtin/log.c
index fdb2180d7e..10c3801ceb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1497,6 +1497,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf rdiff1 = STRBUF_INIT;
 	struct strbuf rdiff2 = STRBUF_INIT;
 	struct strbuf rdiff_title = STRBUF_INIT;
+	int creation_factor = -1;
 
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
@@ -1575,6 +1576,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			     parse_opt_object_name),
 		OPT_STRING(0, "range-diff", &rdiff_prev, N_("refspec"),
 			   N_("show changes against <refspec> in cover letter")),
+		OPT_INTEGER(0, "creation-factor", &creation_factor,
+			    N_("percentage by which creation is weighted")),
 		OPT_END()
 	};
 
@@ -1807,6 +1810,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 					     _("Interdiff against v%d:"));
 	}
 
+	if (creation_factor < 0)
+		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
+	else if (!rdiff_prev)
+		die(_("--creation-factor requires --range-diff"));
+
 	if (rdiff_prev) {
 		if (!cover_letter)
 			die(_("--range-diff requires --cover-letter"));
@@ -1815,7 +1823,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 					origin, list[0]);
 		rev.rdiff1 = rdiff1.buf;
 		rev.rdiff2 = rdiff2.buf;
-		rev.creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
+		rev.creation_factor = creation_factor;
 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
 					     _("Range-diff:"),
 					     _("Range-diff against v%d:"));
-- 
2.18.0.345.g5c9ce644c3

