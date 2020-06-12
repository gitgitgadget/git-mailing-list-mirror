Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04314C433E1
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 15:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38452074B
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 15:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="hZ1/brKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgFLPpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLPpU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 11:45:20 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06726C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 08:45:20 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b27so9376102qka.4
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUU3kG2njJdwu6kxo7ucxWl6Z9P+M9pcu/vz3EAnCTc=;
        b=hZ1/brKQvbQFPZxM30jwcextOPoyIE4PSzWihNTY2TeO0xq14ovOSWer11qskFGX7j
         LJx1FO/WeliUaTYkM2rhVmBaGJIlBPaqy0801IuQggpE0sYqXKi9WJr8V4828wJULC38
         Nd4mPnTASVaXfDG89XlvMI31263VD/Hvxoair/N6hCAvYrhHAcrU7E8axb2eOGF3RqoU
         5vJhwftNd8tM7W5k5Y4Jix6wmfRcjv1r+k6RB1uMzRge+wcJjynC85ZAsq98cHNtW5mv
         Z2OpU6Kf43Zab4D5CVj3YhtsNsAena435jv7qC0xDAcNmwHW7RwnNjS2Bt1xrR0Phpq7
         X/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUU3kG2njJdwu6kxo7ucxWl6Z9P+M9pcu/vz3EAnCTc=;
        b=JXQMb9MtjjqLrSN3prgMAaprjHW5pDHrBd/BOcHXdjwLLFvNP5cqN4tgfnny+vsYHf
         eatLiSPTWKDkvQ3hUyI5tqyVY3sdGJViEPuiR/it4EHPN2EWIUDNzzv4c0iSe8x9tLQW
         Cwy1aX+504+dKL0p/WPcBjpN2G4yJeKKAnl9806emYUqrLX1siXV7hZCh7uE3N5EL0wa
         DT1wJMgXLrj4jS7PYyhfxnGXmFkVD/1GIs0VCYBZNAORmjWEGbcHBUCsglOqvIHHyn6v
         sgf99Nd8QedNqtp/7f9D7lrz8D/zAIGVys1gtUlqVbBwGl1KRGB2mJC3NlgKRnfpWZU9
         yYnA==
X-Gm-Message-State: AOAM530YH14PD7So0NpyLOev891BtXRSemSNr6qOkrk8XN4+w9tJpvzO
        Mas3OvSNX7GVTYCqYpQVy/F1nRzhGfh5gw==
X-Google-Smtp-Source: ABdhPJzsuHvn6XruNZeqVfwSGZongSl+nS96N3g2il0J4xZF0MMAShC3rCwxVH+GTaMeKFhRIz3d3g==
X-Received: by 2002:a37:50c2:: with SMTP id e185mr3751917qkb.140.1591976718501;
        Fri, 12 Jun 2020 08:45:18 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::3])
        by smtp.gmail.com with ESMTPSA id r37sm4988157qtk.34.2020.06.12.08.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 08:45:17 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: [PATCH v4 1/6] doc: grep: unify info on configuration variables
Date:   Fri, 12 Jun 2020 12:44:59 -0300
Message-Id: <99cf2124f349a98b10fc603137e10d38c7ea533a.1591974940.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591974940.git.matheus.bernardino@usp.br>
References: <cover.1591974940.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Explanations about the configuration variables for git-grep are
duplicated in "Documentation/git-grep.txt" and
"Documentation/config/grep.txt", which can make maintenance difficult.
The first also contains a definition not present in the latter
(grep.fullName). To avoid problems like this, let's unify the
information in the second file and include it in the first.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/config/grep.txt | 10 ++++++++--
 Documentation/git-grep.txt    | 36 ++++++-----------------------------
 2 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index 44abe45a7c..dd51db38e1 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -16,8 +16,14 @@ grep.extendedRegexp::
 	other than 'default'.
 
 grep.threads::
-	Number of grep worker threads to use.
-	See `grep.threads` in linkgit:git-grep[1] for more information.
+	Number of grep worker threads to use. See `--threads`
+ifndef::git-grep[]
+	in linkgit:git-grep[1]
+endif::git-grep[]
+	for more information.
+
+grep.fullName::
+	If set to true, enable `--full-name` option by default.
 
 grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index a7f9bc99ea..9bdf807584 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -41,34 +41,8 @@ characters.  An empty string as search expression matches all lines.
 CONFIGURATION
 -------------
 
-grep.lineNumber::
-	If set to true, enable `-n` option by default.
-
-grep.column::
-	If set to true, enable the `--column` option by default.
-
-grep.patternType::
-	Set the default matching behavior. Using a value of 'basic', 'extended',
-	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
-	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
-	value 'default' will return to the default matching behavior.
-
-grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
-	option is ignored when the `grep.patternType` option is set to a value
-	other than 'default'.
-
-grep.threads::
-	Number of grep worker threads to use. If unset (or set to 0), Git will
-	use as many threads as the number of logical cores available.
-
-grep.fullName::
-	If set to true, enable `--full-name` option by default.
-
-grep.fallbackToNoIndex::
-	If set to true, fall back to git grep --no-index if git grep
-	is executed outside of a git repository.  Defaults to false.
-
+:git-grep: 1
+include::config/grep.txt[]
 
 OPTIONS
 -------
@@ -269,8 +243,10 @@ providing this option will cause it to die.
 	found.
 
 --threads <num>::
-	Number of grep worker threads to use.
-	See `grep.threads` in 'CONFIGURATION' for more information.
+	Number of grep worker threads to use. If not provided (or set to
+	0), Git will use as many worker threads as the number of logical
+	cores available. The default value can also be set with the
+	`grep.threads` configuration.
 
 -f <file>::
 	Read patterns from <file>, one per line.
-- 
2.26.2

