Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A79A01F462
	for <e@80x24.org>; Wed, 22 May 2019 02:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfEVCom (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 22:44:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41091 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfEVCom (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 22:44:42 -0400
Received: by mail-io1-f66.google.com with SMTP id a17so621449iot.8
        for <git@vger.kernel.org>; Tue, 21 May 2019 19:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HnbsVfXXnhYiss2FTKR37cWlxAS+37qAAwdi1udmNp8=;
        b=mnFgKcjEIqUlpBOb8OKuExleBhpENE7YzVI4Gz5e6nEGjvX5pjwAs158VWVVzdQ9Ji
         /ABedySMsKLzNkw2YCnvli89PGl5/yvt6jBD79W3N5gKPADlyafPq7caIzady2B+i1Pu
         d5ZlcKH0oT/fmIl2Yn/aon3/5LfAJkd/r0PpGA9zfLmmefxaXmXq0THcV3miI3sPhfwh
         +Ia+IqW9AX8GL3OeZJnmEjhk7Y3/TCAHLF2r1oGMxQYAyG4y82bpotm4kgUD6cyJV0q6
         2PzvJULx58F6Z5Ma9PHwaYDVArquhF7wqqhYBfyGQSq9yV8nKt+msSnrSHUymbt24Oh8
         dvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HnbsVfXXnhYiss2FTKR37cWlxAS+37qAAwdi1udmNp8=;
        b=olgMbrIbK70JQhOuLlShDzraoESnGJk5KU7dGqm6+x1EprfY/c/m+fLlpA7HwMamTX
         EsQw4HNE1y7XM6r/eH3V/TDgaPKxnHcfYOLJvzkz3y5L7J/j6f+i84Px9GFBDTE7thQI
         QLB+pPh5Zu17UEllVtuthpQd69WSxLPkIaXKTv/ynKXCBBqKfhPpSBRlB0Apvu6JzMSH
         Sz7yaMnEW23qq0sbzOitdVAx14ownLpAKD8Sbwk6nT0qflRWJJmLhveu3XR3m79tz+v5
         s+Jt+I0AT1Ri+2K+EJHnfaerbPk2iwBB6MUUoJxlcfDnhlfzwfidX9MT/xpJZm5HoKUc
         Kraw==
X-Gm-Message-State: APjAAAVlPGKewwM0KeLUNHYTalnxVuUa8fKq6c71YXdUtqrbNi8H17ec
        NcpabfugaL5f9D5RSQI/Ej06BBnH
X-Google-Smtp-Source: APXvYqxwXu7iNTXjJhL5n9AbXLsIALX2frcTqJvhWmbYBrMz71VP84nNvaBYHIvUZsz+qI27U8x6kw==
X-Received: by 2002:a6b:b7ce:: with SMTP id h197mr24281164iof.169.1558493080961;
        Tue, 21 May 2019 19:44:40 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id 7sm8343280iob.73.2019.05.21.19.44.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 19:44:40 -0700 (PDT)
Date:   Tue, 21 May 2019 22:44:39 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/8] format-patch: move output_directory logic later
Message-ID: <70e28c54724984b88ccddf639282fd25f4e2fa06.1558492582.git.liu.denton@gmail.com>
References: <cover.1558052674.git.liu.denton@gmail.com>
 <cover.1558492582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558492582.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
2.22.0.rc1.169.g49223abbf8

