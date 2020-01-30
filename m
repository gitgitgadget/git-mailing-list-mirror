Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08177C33CB2
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 01:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5438206A2
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 01:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFaMWo/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgA3BLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 20:11:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54939 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbgA3BLp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 20:11:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id g1so1865604wmh.4
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 17:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1d6gLWFIq2kTd7wlHxeZ52oq8JQ2eECDIZPFr++YXNk=;
        b=pFaMWo/ThabJfRSrGOHUrBExNYnt6pNNbWMDfEGWbeBHEjqHNq1COMkVDNNlWBURxM
         j1NT7A9TEaHc9PiTIdIvvtf9WFCSHqFBR7o9rONfRBNhjaQee0gsXHs5uMLvogeC7YLv
         VP8DK39w06T3DLNutdvZ8bSVlKNu6FPJgrCcdIyWEwKeOrSzMLN8d2kOO9O2OZWv+Ni6
         lLmQS5KwYOhsWV/bMhGngIbYblV96DplkLR93Ri/dzpvrZSS29hUEN34TdGWGWUQkFSG
         j4LHW6o87Q/UM4HQ6Z8j5x/gIVixtj3OV3c8sp62iO9L+qGVqVtJBi4yHDb6paDWlLZy
         EgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1d6gLWFIq2kTd7wlHxeZ52oq8JQ2eECDIZPFr++YXNk=;
        b=dd7y+rAiucnOYtVFPxRUlbUIxkcz9v6ZM0l6TAcR3MaWJEadzYgF1hwZLnYICTaGj4
         brFViHnySgf13oSAe/gK+tFSE5767HdIKwfP00XHIVR3dnu8pAT4c6cFsZHdXevtgbJz
         r3Ws4ZeL9VGtybVy2FH9wyWXiqQCAaxkOhvAn9Lwaoql9v3Wlb0VMzSrUADjzKY/cNVS
         qLMwuQrhJlc7yLodutihpfTr++nGi6Jt/BuMi7RVbO6wdQZZ3hP7dtpjwFJrr6SjnYsU
         1tNXIicfe1phgMc7TrkRu7ElXRNFLRZq3ivmHOlGfrwf328KQIKS5IFCbYjVFK/kZEhX
         RIkQ==
X-Gm-Message-State: APjAAAWbiNTXbwW0OHJcQXwXIN/zQyLOMnGYzH75vK2mS5P2hxKGj6+U
        kv6L1Hzd7w9MLms54LFc0wI1A4i9
X-Google-Smtp-Source: APXvYqyMD9lTAJxock7NTfbKbMRcURXL2znIfN/kNkahyFkRH5IkzPktY440MBh39ZC0EqBbUWDqQA==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr1983084wmf.100.1580346703065;
        Wed, 29 Jan 2020 17:11:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm5167021wrx.25.2020.01.29.17.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 17:11:42 -0800 (PST)
Message-Id: <pull.508.v3.git.1580346702203.gitgitgadget@gmail.com>
In-Reply-To: <pull.508.v2.git.1578438752.gitgitgadget@gmail.com>
References: <pull.508.v2.git.1578438752.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jan 2020 01:11:41 +0000
Subject: [PATCH v3] add: use advice API to display hints
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

In the "add" command, use the advice API to display hints to users,
as it provides a neat and a standard format for hint messages, and
the message visibility will be configurable.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
    [Outreachy] add: use advise API to display hints
    
    In the "add" command, use the advice API to display hints to users, as
    it provides a neat and a standard format for hint messages, and the
    message visibility will be configurable.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-508%2FHebaWaly%2Fformatting_hints-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-508/HebaWaly/formatting_hints-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/508

Range-diff vs v2:

 1:  9f9febd3f4 ! 1:  410a66953d add: use advise function to display hints
     @@ -1,16 +1,28 @@
      Author: Heba Waly <heba.waly@gmail.com>
      
     -    add: use advise function to display hints
     +    add: use advice API to display hints
      
     -    Use the advise function in advice.c to display hints to the users, as
     -    it provides a neat and a standard format for hint messages, i.e: the
     -    text is colored in yellow and the line starts by the word "hint:".
     -
     -    Also this will enable us to control the messages using advice.*
     -    configuration variables.
     +    In the "add" command, use the advice API to display hints to users,
     +    as it provides a neat and a standard format for hint messages, and
     +    the message visibility will be configurable.
      
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      
     + diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
     + --- a/Documentation/config/advice.txt
     + +++ b/Documentation/config/advice.txt
     +@@
     + 	submoduleAlternateErrorStrategyDie:
     + 		Advice shown when a submodule.alternateErrorStrategy option
     + 		configured to "die" causes a fatal error.
     ++	addIgnoredFile::
     ++		Advice shown if a user attempts to add an ignored file to
     ++		the index.
     ++	addEmptyPathspec::
     ++		Advice shown if a user runs the add command without providing
     ++		the pathspec parameter.
     + --
     +
       diff --git a/advice.c b/advice.c
       --- a/advice.c
       +++ b/advice.c
     @@ -18,7 +30,8 @@
       int advice_checkout_ambiguous_remote_branch_name = 1;
       int advice_nested_tag = 1;
       int advice_submodule_alternate_error_strategy_die = 1;
     -+int advice_add_nothing = 1;
     ++int advice_add_ignored_file = 1;
     ++int advice_add_empty_pathspec = 1;
       
       static int advice_use_color = -1;
       static char advice_colors[][COLOR_MAXLEN] = {
     @@ -26,7 +39,8 @@
       	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
       	{ "nestedTag", &advice_nested_tag },
       	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
     -+	{ "addNothing", &advice_add_nothing },
     ++	{ "addIgnoredFile", &advice_add_ignored_file },
     ++	{ "addEmptyPathspec", &advice_add_empty_pathspec },
       
       	/* make this an alias for backward compatibility */
       	{ "pushNonFastForward", &advice_push_update_rejected }
     @@ -38,7 +52,8 @@
       extern int advice_checkout_ambiguous_remote_branch_name;
       extern int advice_nested_tag;
       extern int advice_submodule_alternate_error_strategy_die;
     -+extern int advice_add_nothing;
     ++extern int advice_add_ignored_file;
     ++extern int advice_add_empty_pathspec;
       
       int git_default_advice_config(const char *var, const char *value);
       __attribute__((format (printf, 1, 2)))
     @@ -51,8 +66,10 @@
       		for (i = 0; i < dir->ignored_nr; i++)
       			fprintf(stderr, "%s\n", dir->ignored[i]->name);
      -		fprintf(stderr, _("Use -f if you really want to add them.\n"));
     -+		if (advice_add_nothing)
     -+			advise(_("Use -f if you really want to add them.\n"));
     ++		if (advice_add_ignored_file)
     ++			advise(_("Use -f if you really want to add them.\n"
     ++				 "Turn this message off by running\n"
     ++				 "\"git config advice.addIgnoredFile false\""));
       		exit_status = 1;
       	}
       
     @@ -61,8 +78,10 @@
       	if (require_pathspec && pathspec.nr == 0) {
       		fprintf(stderr, _("Nothing specified, nothing added.\n"));
      -		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
     -+		if (advice_add_nothing)
     -+			advise( _("Maybe you wanted to say 'git add .'?\n"));
     ++		if (advice_add_empty_pathspec)
     ++			advise( _("Maybe you wanted to say 'git add .'?\n"
     ++				  "Turn this message off by running\n"
     ++				  "\"git config advice.addEmptyPathspec false\""));
       		return 0;
       	}
       
     @@ -76,6 +95,8 @@
       ignored-file
      -Use -f if you really want to add them.
      +hint: Use -f if you really want to add them.
     ++hint: Turn this message off by running
     ++hint: "git config advice.addIgnoredFile false"
       EOF
       cat >expect.out <<\EOF
       add 'track-this'


 Documentation/config/advice.txt |  6 ++++++
 advice.c                        |  4 ++++
 advice.h                        |  2 ++
 builtin/add.c                   | 10 ++++++++--
 t/t3700-add.sh                  |  4 +++-
 5 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index d4e698cd3f..a72615c68d 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -110,4 +110,10 @@ advice.*::
 	submoduleAlternateErrorStrategyDie:
 		Advice shown when a submodule.alternateErrorStrategy option
 		configured to "die" causes a fatal error.
+	addIgnoredFile::
+		Advice shown if a user attempts to add an ignored file to
+		the index.
+	addEmptyPathspec::
+		Advice shown if a user runs the add command without providing
+		the pathspec parameter.
 --
diff --git a/advice.c b/advice.c
index 249c60dcf3..97f3f981b4 100644
--- a/advice.c
+++ b/advice.c
@@ -31,6 +31,8 @@ int advice_graft_file_deprecated = 1;
 int advice_checkout_ambiguous_remote_branch_name = 1;
 int advice_nested_tag = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
+int advice_add_ignored_file = 1;
+int advice_add_empty_pathspec = 1;
 
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
@@ -91,6 +93,8 @@ static struct {
 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
 	{ "nestedTag", &advice_nested_tag },
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
+	{ "addIgnoredFile", &advice_add_ignored_file },
+	{ "addEmptyPathspec", &advice_add_empty_pathspec },
 
 	/* make this an alias for backward compatibility */
 	{ "pushNonFastForward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index b706780614..0e6e58d9f8 100644
--- a/advice.h
+++ b/advice.h
@@ -31,6 +31,8 @@ extern int advice_graft_file_deprecated;
 extern int advice_checkout_ambiguous_remote_branch_name;
 extern int advice_nested_tag;
 extern int advice_submodule_alternate_error_strategy_die;
+extern int advice_add_ignored_file;
+extern int advice_add_empty_pathspec;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/builtin/add.c b/builtin/add.c
index 4c38aff419..37b6cbac53 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -390,7 +390,10 @@ static int add_files(struct dir_struct *dir, int flags)
 		fprintf(stderr, _(ignore_error));
 		for (i = 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
-		fprintf(stderr, _("Use -f if you really want to add them.\n"));
+		if (advice_add_ignored_file)
+			advise(_("Use -f if you really want to add them.\n"
+				 "Turn this message off by running\n"
+				 "\"git config advice.addIgnoredFile false\""));
 		exit_status = 1;
 	}
 
@@ -480,7 +483,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (require_pathspec && pathspec.nr == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
-		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
+		if (advice_add_empty_pathspec)
+			advise( _("Maybe you wanted to say 'git add .'?\n"
+				  "Turn this message off by running\n"
+				  "\"git config advice.addEmptyPathspec false\""));
 		return 0;
 	}
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index c325167b90..88bc799807 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -326,7 +326,9 @@ test_expect_success 'git add --dry-run of an existing file output' "
 cat >expect.err <<\EOF
 The following paths are ignored by one of your .gitignore files:
 ignored-file
-Use -f if you really want to add them.
+hint: Use -f if you really want to add them.
+hint: Turn this message off by running
+hint: "git config advice.addIgnoredFile false"
 EOF
 cat >expect.out <<\EOF
 add 'track-this'

base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
-- 
gitgitgadget
