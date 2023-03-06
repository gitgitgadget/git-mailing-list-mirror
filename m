Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EB6C6FD1D
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 14:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjCFOHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCFOHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 09:07:16 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE6B25B8F
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 06:06:49 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id g3so8936569wri.6
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 06:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678111602;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vD91cJyXrD/zI1PRGWlL6b8RPw6pZbakKRIOAQ2YxEc=;
        b=OoGJSCX2lK56+9ARPfStcYImz+XPcmsAZ6Wjc0rjrw1oLa4jlHLFAzIKVI70+vJ6hP
         80HISJQQ+dF9rdXXh2EAXv7+wr1RqwcR4FyRrUEqigcUyYRZnkJj01+DIViJkKBbrpEI
         a50qmzygVtYir0O1PUKnctMrl3hHNsB15MmSUNlF0RA+aeA1QAnUIGD8JmbOwX2J7Qv0
         YcMDxtTbZuG5GTk2+mHPyAO5Lyoq2Un7sAcUrr3YmBzrRcHW7K0LrUnnm14OHfBglkGA
         /mnHfwi8a4VHfMGpdWB5hcANcO1Tg+C4ZCGiqO0kJtrv+RkN1QtUPwsT60nVxutonuwo
         WQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111602;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vD91cJyXrD/zI1PRGWlL6b8RPw6pZbakKRIOAQ2YxEc=;
        b=0sfiqQJrNFjuBJfGNIldYB5L9qqbgG1Il5kDge0AYs1FgzyvtK9NvAL+IoWxx+pj6M
         FmGN9AW0/oBIzmc+HW8CgH1KlOU49jsFuRh6eBn8vDAnzUxIJpW+x+U7atlelQzzSLub
         KhRnWuoRzoX/JCWuLS4q9F5o3VKO72Ewb5BWjKhtegsLLRGFahJ15FzHasEDenht2JRc
         qdUCSetSTgluas2YzjqrK7iUp3i/wF72pV/yR0gNnDfzuuf8DS+nNHGUMYWlE9SmlYm7
         158PjY46bNTBw6Dm9N6RegKTl6/fN2PQI4IGwPlbRMw3Ey6sJXbtnpFelDoIQdeE3yre
         PkpQ==
X-Gm-Message-State: AO0yUKUF909V5YeMaKRcScLK6alyvPHGP6oVg9b5rE36pj0oCXhXLPaB
        yb4EW6jm36PXJo7x/TMmh6NSmNFXVi4=
X-Google-Smtp-Source: AK7set81BSlXt8Auc5/tdIIs0L0cobl9iQkX/FCfSR9Xqfdv1OC/+T9j3JcrS9yC2q7K8sqgJ86hIQ==
X-Received: by 2002:adf:e6cc:0:b0:2ca:de61:b234 with SMTP id y12-20020adfe6cc000000b002cade61b234mr5158314wrm.51.1678111601700;
        Mon, 06 Mar 2023 06:06:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b003b47b80cec3sm15914585wmq.42.2023.03.06.06.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:06:41 -0800 (PST)
Message-Id: <b1d022c7cac5aed6e2d64b45f20dba5b3297536c.1678111599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Mar 2023 14:06:33 +0000
Subject: [PATCH 3/8] ahead-behind: implement --ignore-missing option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When parsing the tip revisions from the ahead-behind inputs, it is
important to check that those tips exist before adding them to the list
for computation. The previous change caused the builtin to return with
errors if the revisions could not be resolved.

However, when running 'git ahead-behind' in an environment with
concurrent edits, such as a Git server, then the references could be
deleted from underneath the caller between reading the reference list
and starting the 'git ahead-behind' process. Avoid this race by allowing
the caller to specify '--ignore-missing' and continue using the
information that is still available.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-ahead-behind.txt | 6 ++++++
 builtin/ahead-behind.c             | 8 +++++++-
 t/t4218-ahead-behind.sh            | 6 ++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ahead-behind.txt b/Documentation/git-ahead-behind.txt
index 0e2f989a1a0..2dd5147f6b2 100644
--- a/Documentation/git-ahead-behind.txt
+++ b/Documentation/git-ahead-behind.txt
@@ -50,6 +50,12 @@ OPTIONS
 	Read revision tips and ranges from stdin instead of from the
 	command-line.
 
+--ignore-missing::
+	When parsing tip references, ignore any references that are not
+	found. This is useful when operating in an environment where a
+	reference could be deleted between reading the reference and
+	starting the `git ahead-behind` process.
+
 
 SEE ALSO
 --------
diff --git a/builtin/ahead-behind.c b/builtin/ahead-behind.c
index c1212cc8d46..e4f65fc0548 100644
--- a/builtin/ahead-behind.c
+++ b/builtin/ahead-behind.c
@@ -8,13 +8,18 @@ static const char * const ahead_behind_usage[] = {
 	NULL
 };
 
+static int ignore_missing;
+
 static int handle_arg(struct string_list *tips, const char *arg)
 {
 	struct string_list_item *item;
 	struct commit *c = lookup_commit_reference_by_name(arg);
 
-	if (!c)
+	if (!c) {
+		if (ignore_missing)
+			return 0;
 		return error(_("could not resolve '%s'"), arg);
+	}
 
 	item = string_list_append(tips, arg);
 	item->util = c;
@@ -30,6 +35,7 @@ int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
 	struct option ahead_behind_opts[] = {
 		OPT_STRING('b', "base", &base_ref, N_("base"), N_("base reference to process")),
 		OPT_BOOL(0 , "stdin", &from_stdin, N_("read rev names from stdin")),
+		OPT_BOOL(0 , "ignore-missing", &ignore_missing, N_("ignore missing tip references")),
 		OPT_END()
 	};
 
diff --git a/t/t4218-ahead-behind.sh b/t/t4218-ahead-behind.sh
index 3b8b9dc9887..56f16515896 100755
--- a/t/t4218-ahead-behind.sh
+++ b/t/t4218-ahead-behind.sh
@@ -19,6 +19,12 @@ test_expect_success 'git ahead-behind with broken tip' '
 	grep "could not resolve '\''bogus'\''" err
 '
 
+test_expect_success 'git ahead-behind with broken tip and --ignore-missing' '
+	git ahead-behind --base=HEAD --ignore-missing bogus 2>err >out &&
+	test_must_be_empty err &&
+	test_must_be_empty out
+'
+
 test_expect_success 'git ahead-behind without tips' '
 	git ahead-behind --base=HEAD 2>err &&
 	test_must_be_empty err
-- 
gitgitgadget

