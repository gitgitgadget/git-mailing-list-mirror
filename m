Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437A5C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 01:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA6E20DD4
	for <git@archiver.kernel.org>; Thu, 28 May 2020 01:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="JZum0ZDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgE1BNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 21:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgE1BNp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 21:13:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E716FC03E96E
        for <git@vger.kernel.org>; Wed, 27 May 2020 18:13:44 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h9so10772565qtj.7
        for <git@vger.kernel.org>; Wed, 27 May 2020 18:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUU3kG2njJdwu6kxo7ucxWl6Z9P+M9pcu/vz3EAnCTc=;
        b=JZum0ZDQ0QYWRoFe79cGgjmoNKJXOKvPS6MHY/jABr2eSb9V7WZR6U/7aYskGgyAo2
         C75NufezxeYHbnB6KSgPdbU1Adc+8zh0K0hFUvFjA1vRTYhuZaqmKoOGFQTx/4CAvN7z
         8JMusjNmRdJLZMXdJQxpWRq1NlthbOojju7v3/rbzQ1IE5W0ymiZbZ3C5sBg4gwTEBUb
         2D41uA36HOjjO9RZAeiF6q0eWbZuqy52Tqi9mND7swGVJ4tbE8sFwyZRlkzCKgO9tN5f
         8ED1AZRtN9Lr2usAZJNOf0hkrosr8X9+Ki8sIwU0rTJj0w55cp7Si9zVN77XIvc8A+h3
         c09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUU3kG2njJdwu6kxo7ucxWl6Z9P+M9pcu/vz3EAnCTc=;
        b=sdX7yxAAI0nQLziuxcxK2bhIXPVSNn/jQJ0Jz3U7p2ERUZ06OWFgfn953uZKA2ZU6Y
         SX5RrgFJU2EUcNLMjKQtBMzlvEvp5JxOtL31eUW6M8dPS4OgED3ouMao2CIroa3+t6cR
         rFQywq51InECsxN9XTkv4gJiZwgz8kDvegtZXWYJvqI5brj3TQ6sKSZFfk5Gs7jnu1fZ
         1NXnEDEHqbXppp0IkfW4P4al6/r/1xqrbb+Tu5aRNyV0ksxKAAelaJhPlQSoYKzMip4R
         RJ4JcfGKYscPQHlSmaIs2M9n58MrPD38ARvT1sAEoxTn4GeU91m0bkJhSTDHsiTx+Jla
         K4Zg==
X-Gm-Message-State: AOAM533zcN2Mbz6Twm5wa2T2WRzUt2rSbRT3TaXMgCVYoB2cDohNjkcE
        KEgcRKDyCeeic41JTXJ+bk6f2lSKfhG+BQ==
X-Google-Smtp-Source: ABdhPJzGPzFQKI7cjzDJ7/D3XPCo1kfkbo+oNT2/vEQTxUi6CuxjbVj93l93qlMF3Y+LavdcHG8Tow==
X-Received: by 2002:ac8:4741:: with SMTP id k1mr725978qtp.250.1590628423701;
        Wed, 27 May 2020 18:13:43 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::1])
        by smtp.gmail.com with ESMTPSA id a188sm3547872qkg.11.2020.05.27.18.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 18:13:42 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: [PATCH v3 1/5] doc: grep: unify info on configuration variables
Date:   Wed, 27 May 2020 22:12:59 -0300
Message-Id: <63c195d737dea1dbdc44294483d11a8400f608cc.1590627264.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590627264.git.matheus.bernardino@usp.br>
References: <cover.1590627264.git.matheus.bernardino@usp.br>
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

