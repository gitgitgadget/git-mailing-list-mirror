Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671E1C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiG2I0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbiG2I0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:26:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE261286D5
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v17so5083596wrr.10
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=tCNM3NEMNbmGhKLDz6qswddj8boGkYGXHPE+yJJCXn4=;
        b=XqSXbAEUu1aJtn+4w/0uQQOLlwWiHEl74sbA/bptFu6zN/ebO7sYHU5UnQD8sGKyyU
         +HX+NxduFnuJ8I+fXaxHcbS1zJR8W4jsISaW/Q8OY84cXHmzEwE4nguAVG/cDuhrUSa0
         w89bYSEMIXveOAO7hzX2K6m/1f9IU0wvcIiC5Zv33Y4lfdoUOri46JiaHHB0SJhPZcB8
         z8rJd3chKa2Ywu9c72qQJSLFMM0Mwy7zWOZoQVQQyrrJ8W/B2wLdx/Cqe242drE2MD87
         e3LIDYk58aHXiAzJLwr/9vYVIz/KQC0cDW47QbAUSGRgf0yPiwViBR4cP6unZO6NTLAy
         l6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=tCNM3NEMNbmGhKLDz6qswddj8boGkYGXHPE+yJJCXn4=;
        b=daeA4YPafX/h9myKxDoYTuDmtuZzqf/YZE6720Ooj53bPD/1J7Lf7eFlmRoaCMyuKt
         1nhJ9+XbysNlRionMUkQf0BmkpT++bjfBCZ0l38INGkVx6XyN8IloBXwYSDAWNuAisrv
         YXXH1OWyIDmvtzWaD6CTA4lMcF0Ch3TFjMZ2v1NsS0hkutcyK3VEdMyzn/Gueg8toy4C
         9x4h5B5H/t05baOaJ4dKHbgOLsat0HHKdcFFj/07jSraMaJnJJfJk6JmuesOS2MhMkEJ
         1lwER+CTlhldIITyglhvjCjN38TD2LLKkjseA4UJ7EKUVW4aINnoiioTKXIX8mukbAvZ
         TAtQ==
X-Gm-Message-State: ACgBeo3+mGUQVf/NdA4uG/hDqxi7KoQgHYpRaj9279At90q/LZ4mqkPa
        ejrnPxpT4jSB3vSCPLeudm5vQhskuuEoUQ==
X-Google-Smtp-Source: AA6agR7kHb5UxlfHcJXNLhYXePZrxSEM+anr4HWIqs+PMgI+NLpnszUYkh6Op2yM2D9gB5/kLXF2YQ==
X-Received: by 2002:a5d:6483:0:b0:21e:999c:e1ca with SMTP id o3-20020a5d6483000000b0021e999ce1camr1593490wri.640.1659083159396;
        Fri, 29 Jul 2022 01:25:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0021e571a99d5sm2994802wrh.17.2022.07.29.01.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:25:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/9] grep docs: de-duplicate configuration sections
Date:   Fri, 29 Jul 2022 10:25:48 +0200
Message-Id: <patch-v2-2.9-5f07f87710c-20220729T081959Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
References: <cover.1657819649.git.matheus.bernardino@usp.br> <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Include the "config/grep.txt" file in "git-grep.txt", instead of
repeating an almost identical description of the "grep" configuration
variables in two places.

There is no loss of information here that isn't shown in the addition
to "grep.txt". This change was made by copying the contents of
"git-grep.txt"'s version over the "grep.txt" version. Aside from the
change "grep.txt" being made here the two were identical.

This documentation started being copy/pasted around in
b22520a37c8 (grep: allow -E and -n to be turned on by default via
configuration, 2011-03-30). After that in e.g. 6453f7b3486 (grep: add
grep.fullName config variable, 2014-03-17) they started drifting
apart, with only grep.fullName being described in the command
documentation.

In 434e6e753fe (config.txt: move grep.* to a separate file,
2018-10-27) we gained the include, but didn't do this next step, let's
do it now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/grep.txt |  7 +++++--
 Documentation/git-grep.txt    | 29 ++---------------------------
 2 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index 182edd813a5..e521f20390c 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -17,8 +17,11 @@ grep.extendedRegexp::
 	other than 'default'.
 
 grep.threads::
-	Number of grep worker threads to use.
-	See `grep.threads` in linkgit:git-grep[1] for more information.
+	Number of grep worker threads to use. If unset (or set to 0), Git will
+	use as many threads as the number of logical cores available.
+
+grep.fullName::
+	If set to true, enable `--full-name` option by default.
 
 grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 58d944bd578..dabdbe8471d 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -343,34 +343,9 @@ performance in this case, it might be desirable to use `--threads=1`.
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
+include::includes/cmd-config-section-all.txt[]
 
+include::config/grep.txt[]
 
 GIT
 ---
-- 
2.37.1.1196.g8af3636bc64

