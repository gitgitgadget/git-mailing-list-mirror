Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22960C33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22B624681
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8xJjmlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgA1S0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:26:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34224 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgA1S0s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 13:26:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id s144so2372901wme.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nmJO3VBKbjI5mIYtdbDI6cnVFgW5ji0K5IDiq70ZpFc=;
        b=D8xJjmlrEcVdY+C/CeK5YKnNEyWlVbwF9DssYHn0CHuoEEVoqDIDjVj6k1ICqRrvpG
         g0dGv8xQf7vOun7v59IMv2tsbJIhVzsbBvc6zlbAKT1umMnRfIRCQUBtcV6IpPb30XDR
         IynBzuHmFdn1aKUhRSOsTivHXIrWqmdIjPnV5RrQL2UaVwr7tBSYze1tgVnizt4QeO3V
         kTTPVZPY1C798d6Mly7+8FmeJDOI3AvUu+Lws39o8IbLBNOSX0ncezGa9YZ0F7zQrmIw
         Xa2LYCVkbKVhVdNDDVFv/d1OlnwiQBLxXQ5MYsE055Gj6JdL8ernHuLYHa9lCvW1RZFg
         kUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nmJO3VBKbjI5mIYtdbDI6cnVFgW5ji0K5IDiq70ZpFc=;
        b=U3qXj3Pr/rvsxmuBlAzWhujl+wzErie/yLK6ImCJNYDD5Ey6bws0jfuIZdZpMTr0ev
         +zEgiOyXpoyQfoqExk7o8cY3j5z7GhYBUODrJTw3lCVZuaooW0v4p7ygqoEGlx364JJ/
         MI+64Dtz/eoBB5H21voIdrkLFgx26LYlwCZ3Ru1Ctx+EOBo6/JEXI568C39TescSXOEk
         sZBud2aSDx7FG/0+0urUex9LppG5RPhQtSBNzHf+dG/ILMoE3diRVWftwh+HcWYDeoHZ
         mIJPMBmyaN7jVBpenzu7mQE3yqXfa+94EGlMPKKmry8F+E0pn6va+l2lCkkxYyCWtMeI
         UPNA==
X-Gm-Message-State: APjAAAUG6C+H4NKzUBl63KAISRb9vZNip60Q9LCzJoBwvipZwOGKzzAl
        wJbHeM25lrT0m/tOmgko9ipUy3g/
X-Google-Smtp-Source: APXvYqyTXAW8yuNL77U2apTxVvqaXPdDoA3O6fC9oA1qCVfFkwPYINdqLulSUuTL7SrEqqeIyCUaHw==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr6462599wmi.0.1580236004561;
        Tue, 28 Jan 2020 10:26:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d12sm26539960wrp.62.2020.01.28.10.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:26:43 -0800 (PST)
Message-Id: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jan 2020 18:26:31 +0000
Subject: [PATCH v3 00/12] Harden the sparse-checkout builtin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on ds/sparse-list-in-cone-mode.

This series attempts to clean up some rough edges in the sparse-checkout
feature, especially around the cone mode.

Unfortunately, after the v2.25.0 release, we noticed an issue with the "git
clone --sparse" option when using a URL instead of a local path. This is
fixed and properly tested here.

Also, let's improve Git's response to these more complicated scenarios:

 1. Running "git sparse-checkout init" in a worktree would complain because
    the "info" dir doesn't exist.
 2. Tracked paths that include "*" and "\" in their filenames.
 3. If a user edits the sparse-checkout file to have non-cone pattern, such
    as "**" anywhere or "*" in the wrong place, then we should respond
    appropriately. That is: warn that the patterns are not cone-mode, then
    revert to the old logic.

Updates in V2:

 * Added C-style quoting to the output of "git sparse-checkout list" in cone
   mode.
 * Improved documentation.
 * Responded to most style feedback. Hopefully I didn't miss anything.
 * I was lingering on this a little to see if I could also fix the issue
   raised in [1], but I have not figured that one out, yet.

Update in V3:

 * Input now uses Peff's recommended pattern: unquote C-style strings over
   stdin and otherwise do not un-escape input.

[1] 
https://lore.kernel.org/git/062301d5d0bc$c3e17760$4ba46620$@Frontier.com/

Thanks, -Stolee

Derrick Stolee (11):
  t1091: use check_files to reduce boilerplate
  t1091: improve here-docs
  sparse-checkout: create leading directories
  clone: fix --sparse option with URLs
  sparse-checkout: cone mode does not recognize "**"
  sparse-checkout: detect short patterns
  sparse-checkout: warn on incorrect '*' in patterns
  sparse-checkout: properly match escaped characters
  sparse-checkout: write escaped patterns in cone mode
  sparse-checkout: use C-style quotes in 'list' subcommand
  sparse-checkout: improve docs around 'set' in cone mode

Jeff King (1):
  sparse-checkout: fix documentation typo for core.sparseCheckoutCone

 Documentation/git-sparse-checkout.txt |  19 +-
 builtin/clone.c                       |   2 +-
 builtin/sparse-checkout.c             |  48 +++-
 dir.c                                 |  68 +++++-
 t/t1091-sparse-checkout-builtin.sh    | 323 +++++++++++++++-----------
 5 files changed, 305 insertions(+), 155 deletions(-)


base-commit: 4fd683b6a35eabd23dd5183da7f654a1e1f00325
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-513%2Fderrickstolee%2Fsparse-harden-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-513/derrickstolee/sparse-harden-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/513

Range-diff vs v2:

  1:  1cc825412f =  1:  1cc825412f t1091: use check_files to reduce boilerplate
  2:  b7a6ad145a =  2:  b7a6ad145a t1091: improve here-docs
  3:  5497ad8778 =  3:  5497ad8778 sparse-checkout: create leading directories
  4:  4991a51f6d =  4:  4991a51f6d clone: fix --sparse option with URLs
  5:  ae78c3069b =  5:  ae78c3069b sparse-checkout: fix documentation typo for core.sparseCheckoutCone
  6:  2ad4d3e467 =  6:  2ad4d3e467 sparse-checkout: cone mode does not recognize "**"
  7:  aace064510 =  7:  aace064510 sparse-checkout: detect short patterns
  8:  d2a510a3bb =  8:  d2a510a3bb sparse-checkout: warn on incorrect '*' in patterns
  9:  65c53d7526 !  9:  9ea69e9069 sparse-checkout: properly match escaped characters
     @@ -20,7 +20,7 @@
       	return strncmp(ee1->pattern, ee2->pattern, min_len);
       }
       
     -+char *dup_and_filter_pattern(const char *pattern)
     ++static char *dup_and_filter_pattern(const char *pattern)
      +{
      +	char *set, *read;
      +	char *result = xstrdup(pattern);
     @@ -69,18 +69,6 @@
       	hashmap_entry_init(&translated->ent,
       			   ignore_case ?
      
     - diff --git a/dir.h b/dir.h
     - --- a/dir.h
     - +++ b/dir.h
     -@@
     - 		   const struct hashmap_entry *a,
     - 		   const struct hashmap_entry *b,
     - 		   const void *key);
     -+char *dup_and_filter_pattern(const char *pattern);
     - int hashmap_contains_parent(struct hashmap *map,
     - 			    const char *path,
     - 			    struct strbuf *buffer);
     -
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
       --- a/t/t1091-sparse-checkout-builtin.sh
       +++ b/t/t1091-sparse-checkout-builtin.sh
 10:  c27a17a2fc ! 10:  e2f9afc70c sparse-checkout: write escaped patterns in cone mode
     @@ -24,11 +24,24 @@
          unescaped names in the hashsets for the cone comparisons, then escape
          the patterns later.
      
     +    Use unquote_c_style() when parsing lines from stdin. Command-line
     +    arguments will be parsed as-is, assuming the user can do the correct
     +    level of escaping from their environment to match the exact directory
     +    names.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
       --- a/builtin/sparse-checkout.c
       +++ b/builtin/sparse-checkout.c
     +@@
     + #include "resolve-undo.h"
     + #include "unpack-trees.h"
     + #include "wt-status.h"
     ++#include "quote.h"
     + 
     + static const char *empty_base = "";
     + 
      @@
       	return result;
       }
     @@ -77,52 +90,28 @@
       }
       
      @@
     - {
     - 	struct pattern_entry *e = xmalloc(sizeof(*e));
     - 	e->patternlen = path->len;
     --	e->pattern = strbuf_detach(path, NULL);
     -+	e->pattern = dup_and_filter_pattern(path->buf);
     -+	strbuf_release(path);
     -+
     - 	hashmap_entry_init(&e->ent,
     - 			   ignore_case ?
     - 			   strihash(e->pattern) :
     -@@
     + 		pl.use_cone_patterns = 1;
       
     - static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
     - {
     -+	int i;
     - 	strbuf_trim(line);
     - 
     - 	strbuf_trim_trailing_dir_sep(line);
     -@@
     - 	if (!line->len)
     - 		return;
     - 
     -+	for (i = 0; i < line->len; i++) {
     -+		if (line->buf[i] == '*') {
     -+			strbuf_insert(line, i, "\\", 1);
     -+			i++;
     -+		}
     + 		if (set_opts.use_stdin) {
     +-			while (!strbuf_getline(&line, stdin))
     ++			struct strbuf unquoted = STRBUF_INIT;
     ++			while (!strbuf_getline(&line, stdin)) {
     ++				if (line.buf[0] == '"') {
     ++					strbuf_setlen(&unquoted, 0);
     ++					if (unquote_c_style(&unquoted, line.buf, NULL))
     ++						die(_("unable to unquote C-style string '%s'"),
     ++						line.buf);
      +
     -+		if (line->buf[i] == '\\') {
     -+			if (i < line->len - 1 && line->buf[i + 1] == '\\')
     -+				i++;
     -+			else
     -+				strbuf_insert(line, i, "\\", 1);
     ++					strbuf_swap(&unquoted, &line);
     ++				}
      +
     -+			i++;
     -+		}
     -+	}
     + 				strbuf_to_cone_pattern(&line, &pl);
     ++			}
      +
     -+	if (line->buf[0] == '"' && line->buf[line->len - 1] == '"') {
     -+		strbuf_remove(line, 0, 1);
     -+		strbuf_remove(line, line->len - 1, 1);
     -+	}
     -+
     - 	if (line->buf[0] != '/')
     - 		strbuf_insert(line, 0, "/", 1);
     - 
     ++			strbuf_release(&unquoted);
     + 		} else {
     + 			for (i = 0; i < argc; i++) {
     + 				strbuf_setlen(&line, 0);
      
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
       --- a/t/t1091-sparse-checkout-builtin.sh
     @@ -142,7 +131,7 @@
       	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" &&
       	git -C escaped sparse-checkout init --cone &&
      -	cat >escaped/.git/info/sparse-checkout <<-\EOF &&
     -+	git -C escaped sparse-checkout set zbad\\dir zdoes\*not\*exist zdoes\*exist &&
     ++	git -C escaped sparse-checkout set zbad\\dir "zdoes*not*exist" "zdoes*exist" &&
      +	cat >expect <<-\EOF &&
       	/*
       	!/*/
 11:  526d5becbc ! 11:  ec714a4cf0 sparse-checkout: use C-style quotes in 'list' subcommand
     @@ -12,14 +12,6 @@
       diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
       --- a/builtin/sparse-checkout.c
       +++ b/builtin/sparse-checkout.c
     -@@
     - #include "resolve-undo.h"
     - #include "unpack-trees.h"
     - #include "wt-status.h"
     -+#include "quote.h"
     - 
     - static const char *empty_base = "";
     - 
      @@
       
       		string_list_sort(&sl);
 12:  1b5858adee = 12:  1867746d97 sparse-checkout: improve docs around 'set' in cone mode

-- 
gitgitgadget
