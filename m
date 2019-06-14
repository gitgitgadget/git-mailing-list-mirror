Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2441F462
	for <e@80x24.org>; Fri, 14 Jun 2019 21:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfFNV4h (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 17:56:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33489 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfFNV4a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 17:56:30 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so9074981iop.0
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 14:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kqjZCSflzN6j8/TTkKr+vWntuYO0HGAtdgpQQQ/WlHc=;
        b=EuAl62419bZJIK0grhEaldGKnp9qFrTi6ektZld8rleVsgLuu30JG2o4bcy5HKAW01
         F+3Hlbn2HC+UvcPzaMwFQhxUhj7uuEWeltku6Kdk5bnDAqbn0ahBN/vlewwXJ6D4ZNej
         TEDC11XGFT7/60AgwuKyQ/Nx9T7iAKh/QJ7G9hOKAFyFLFsDtTnVs7M6bbnOqjFUbWpM
         5vX3ZMLOaoZRj4jyCNcHFkydgyCIAeXeqBxiUUh+FDDDrIxeXSnkKAUNrsjii3TlUPQ+
         6ovy0GUFTva5imevsFhozhkcv7TwObk9he75LzApxtkvgjPp9wzqge9aD2Z7kbGiTwbC
         J6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kqjZCSflzN6j8/TTkKr+vWntuYO0HGAtdgpQQQ/WlHc=;
        b=cuJgdFkoYIdgyuVMmh4oksloZAelU3p9oEW95/18n0gOvLPIccH41zmtQxJWa8IvnV
         ZMGcunnC4xgNcQed2P6jxFXpmY07LgQCNUC719l6B26AFPj1YnozgcdkqQ1NavEkEbpH
         MEnOhm45WMFr5jqYtzH7S7jUzCElrLr90wO/u7WSXM3YZAnYhQqk+DqMnEZzjkggexsm
         9omgUaEDrCPMqHcbsBd1Gm8WmJjcefm/3ftRcJgaCG3sXV7Q0M0BuB9tpuY9cUdwPehr
         iNH0HxVCraRLzX1DgNmIjL1DRJPM4P5gNKz/620f81Ze4oePc0Dhdra37pFxsHu61x1n
         zrUw==
X-Gm-Message-State: APjAAAWZEwioPrsk2OVxxoUsIK0N5lV7LsJpYNZaPgPq9H8e0UQAwS95
        Y1pT33EuIhIY4S5rtbpSnTtGVBcI
X-Google-Smtp-Source: APXvYqw7E/XMGNlPTomRA5L3kVO/wf0fUQEQyYKTPi3PnQvOL7Z6ZPBSzEMAvvgZ/bSnVJhie83ERw==
X-Received: by 2002:a6b:8b0d:: with SMTP id n13mr50322725iod.222.1560549389232;
        Fri, 14 Jun 2019 14:56:29 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id q15sm3472485ioi.15.2019.06.14.14.56.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 14:56:28 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:56:27 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RESEND PATCH v3 7/8] format-patch: move output_directory logic later
Message-ID: <3bc1b95a4e34a0957e1c4f671d1424448d4dbe7a.1560547501.git.liu.denton@gmail.com>
References: <cover.1558492582.git.liu.denton@gmail.com>
 <cover.1560547500.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560547500.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we need to create the output_directory after the
branch_name logic. Simply transpose this logic later in the function so
that this happens. (This patch is best viewed with `git diff
--color-moved`.)

Note that this logic only depends on `git_config` and the parseopt logic
and is depended on by the patch creation logic which is directly below
it so this move is effectively a no-op as no dependencies being
reordered.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt |  4 ++--
 builtin/log.c                      | 36 +++++++++++++++---------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 76e61b746a..707b4bdc6b 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -358,8 +358,8 @@ with configuration variables.
 	inferCoverSubject = true
 ------------
 
-In addition, for a specific branch, you can specify a custom cover
-letter subject, and add additional "To:" or "Cc:" headers.
+In addition, for a specific branch, you can add additional "To:" or
+"Cc:" headers.
 
 ------------
 [format "branch-name"]
diff --git a/builtin/log.c b/builtin/log.c
index cb9ccdc59c..97980881ec 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1771,24 +1771,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.show_notes)
 		init_display_notes(&rev.notes_opt);
 
-	if (!output_directory && !use_stdout)
-		output_directory = config_output_directory;
-
-	if (!use_stdout)
-		output_directory = set_outdir(prefix, output_directory);
-	else
-		setup_pager();
-
-	if (output_directory) {
-		if (rev.diffopt.use_color != GIT_COLOR_ALWAYS)
-			rev.diffopt.use_color = GIT_COLOR_NEVER;
-		if (use_stdout)
-			die(_("standard output, or directory, which one?"));
-		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
-			die_errno(_("could not create directory '%s'"),
-				  output_directory);
-	}
-
 	if (rev.pending.nr == 1) {
 		int check_head = 0;
 
@@ -1822,6 +1804,24 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (!output_directory && !use_stdout)
+		output_directory = config_output_directory;
+
+	if (!use_stdout)
+		output_directory = set_outdir(prefix, output_directory);
+	else
+		setup_pager();
+
+	if (output_directory) {
+		if (rev.diffopt.use_color != GIT_COLOR_ALWAYS)
+			rev.diffopt.use_color = GIT_COLOR_NEVER;
+		if (use_stdout)
+			die(_("standard output, or directory, which one?"));
+		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
+			die_errno(_("could not create directory '%s'"),
+				  output_directory);
+	}
+
 	add_branch_headers(&rev, branch_name);
 
 	for (i = 0; i < extra_hdr.nr; i++) {
-- 
2.22.0.355.g3bfa262345

