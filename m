Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1899AC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68AC20716
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtTLY1s3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfLSSCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:05 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46489 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLSSCE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:04 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so5747443edi.13
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/50tsg0WF1RPAKWO+eD4BpY/4M3EHrjNNjTZh3wRJNU=;
        b=DtTLY1s3LdrEK6qhrCijyJTdlJFzojUwaD+YiKrKEAhRNYVQ8jTYfVSF8T1NTDj5Rb
         JKul4okn4NH0e51W+e/k+MPS1uUYPA/gd5T0+6zdjOMe3M3bEsQqkWW079kyNPmzIVWv
         CXWyLukNY0BwRuehgF0UircVPI+CyiQzcc2FMVdQ9Zf1asSSQkYkcoaaFa896NnjJze+
         Ubq21syIDVMd0U7rSKKKW/gawgdz7rVhy+PqSLP26khlLRX97Xfd+Y9zcwh9mf2/GzS0
         WXmS2td4ABlW6e77yFgzGv9SnrF+6GmsIkduJige9AY6kXl89MKWqM2Oxy8sx6mIwHgA
         uVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/50tsg0WF1RPAKWO+eD4BpY/4M3EHrjNNjTZh3wRJNU=;
        b=OpDv4FKX+TjeG7yImJBXCy1Yk43wNiY75usuZlsHEcNajuNu+5R9TmVhWBfPpgSntx
         VzFJ/aSYu7TGA8sGx8lWD2ms3+h4DdNHsGNXnpVVhTFIPmJPAYyg9h3GlRGwCpRYMZT2
         BusqQXOjhJZ3t0tQP4jtRa7BmTca/BvT9NgZObG17UN2wbRgwFqCMw3Qc/OtENq8e/O0
         nx7VNe9kRbK3ZsvDy3T5pcSBKZ5sdBqnKUU4XShwljBaW1NqOpuL89kxKs6Xr2P+ZKbb
         RUYVOsqI8RUJbXJ9XQQRl7PMvJydJgc2log/28mtQUx0aJBC106w1SB80P9pfCfa65MD
         h+1A==
X-Gm-Message-State: APjAAAXYA3oxsz6KljsqJi2ha5Y901RRwmM0oUfEtZojmO5BU71u1gns
        OPoslSXXZm2EapYGX4AooyXDASQ/
X-Google-Smtp-Source: APXvYqyOzSb05vbFViExYLaD9hedNT3T8rMyJjeBdE8XQxarXgMoMuh8kTzdRjk07gT3O1KXmdLCtg==
X-Received: by 2002:a17:906:5210:: with SMTP id g16mr4024811ejm.305.1576778522660;
        Thu, 19 Dec 2019 10:02:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t18sm553780edf.53.2019.12.19.10.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:02:02 -0800 (PST)
Message-Id: <2153350ac4af3dce12f5bc330208f028293e0dd6.1576778515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:42 +0000
Subject: [PATCH v3 05/18] cmd_add: prepare for next patch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Some code blocks were moved down to be able to test for `pathspec.nr`
in the next patch. Blocks are moved as is without any changes. This
is done as separate patch to reduce the amount of diffs in next patch.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/add.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index d4686d5218..3d1791dd82 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -430,10 +430,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (addremove && take_worktree_changes)
 		die(_("-A and -u are mutually incompatible"));
 
-	if (!take_worktree_changes && addremove_explicit < 0 && argc)
-		/* Turn "git add pathspec..." to "git add -A pathspec..." */
-		addremove = 1;
-
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
 
@@ -446,19 +442,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
-	flags = ((verbose ? ADD_CACHE_VERBOSE : 0) |
-		 (show_only ? ADD_CACHE_PRETEND : 0) |
-		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
-		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
-		 (!(addremove || take_worktree_changes)
-		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
-
-	if (require_pathspec && argc == 0) {
-		fprintf(stderr, _("Nothing specified, nothing added.\n"));
-		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
-		return 0;
-	}
-
 	/*
 	 * Check the "pathspec '%s' did not match any files" block
 	 * below before enabling new magic.
@@ -468,6 +451,23 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		       PATHSPEC_SYMLINK_LEADING_PATH,
 		       prefix, argv);
 
+	if (require_pathspec && argc == 0) {
+		fprintf(stderr, _("Nothing specified, nothing added.\n"));
+		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
+		return 0;
+	}
+
+	if (!take_worktree_changes && addremove_explicit < 0 && argc)
+		/* Turn "git add pathspec..." to "git add -A pathspec..." */
+		addremove = 1;
+
+	flags = ((verbose ? ADD_CACHE_VERBOSE : 0) |
+		 (show_only ? ADD_CACHE_PRETEND : 0) |
+		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
+		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
+		 (!(addremove || take_worktree_changes)
+		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
+
 	if (read_cache_preload(&pathspec) < 0)
 		die(_("index file corrupt"));
 
-- 
gitgitgadget

