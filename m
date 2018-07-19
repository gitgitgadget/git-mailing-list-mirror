Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6553C1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 18:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbeGSTkz (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:40:55 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:35484 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732179AbeGSTkz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:40:55 -0400
Received: by mail-io0-f201.google.com with SMTP id y4-v6so634339iol.2
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=O9zUoLTS/Y06IQSHdio4q7OIBngldd5L4C6pepVI0OQ=;
        b=oe52KiepYZJBVOL0H4qgXu8dtpovOBKwmzNBTe/FyUrOapCFVFJRENBD/OjpcXvuYi
         KnHugXyr3LZO7jUSeAszZsx+ctqOTef9eu2+a+e2iUdUmKbiBQvGYqbiZYygYZM2WnhY
         na9N8kTvRE2BeKUhbqXuY/wH0xTdYd6Qn02m6RgVncFSup6+Osb0MiiwC51ZHufiYbbR
         E0L9Fr2o8Q5p09e3A+KyVhgOJrwS/XhJSx1J7AeduIGWfScf3nke8SEBBU0sNztS+qOp
         u/+75KdhjAsggyIt3hEw0MxJYk/Qj0nqsEtgnGMmrH9LpYtInFDXgh7G/DvrTMuA6etp
         6AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=O9zUoLTS/Y06IQSHdio4q7OIBngldd5L4C6pepVI0OQ=;
        b=icf/Yh9JOzdDWsl0NXbwTgkIaedW85ki1j1D5OW2OCsWnIw3N+m+Ump3lT16s6Nxso
         kh8or45rUWz8/oSaRlSG+WHmiBCq0r3ww1VjYABEXz2rllm/GkIAdF5clUkuZrcmgVE9
         xJDvZtu+M+lfeeYIuXNC2rbLSdC49Q1SHz1BmA5mY5ENs6DpdMicfHsaDWBPyiB1P4vf
         c0cf+0laYlsF69Cvh1Q05l6QXfYMFeNEf2lVxA3Aptoho7Q5znSIoTlNoKkIBiSN3d6D
         0oeZiV27YBZKYglJK/GhsQ5gj3b8SHewDIzLJ0yVtkKZaTcd9/IY/W44DDUCcNDKT4El
         q57Q==
X-Gm-Message-State: AOUpUlHotzbNlL4RXbjHJHAshFQc10UVWFUTWqWnp53sDG/Qfew7Udit
        iRi/u+CXyxVnaj2NqfIxguQKtGxOGf9IxE2BmyuP+9DNDx50ju46cji3G6kfJA3EfIPUmlfFkmm
        V71A5haiAD2mUUW7LZjTnR5X7Xk4TfPROJ5gQUeIuckW61r/tTZYI3aByCDlx
X-Google-Smtp-Source: AAOMgpcpzeIs4i7yIYdvPDxtauR/8acgUoP/F7DrpNAam5F4hpaCAg59cBmsDk9tKfQktjb2R6egNpiR2yQ6
MIME-Version: 1.0
X-Received: by 2002:a24:324d:: with SMTP id j74-v6mr3460435ita.26.1532026586943;
 Thu, 19 Jul 2018 11:56:26 -0700 (PDT)
Date:   Thu, 19 Jul 2018 11:56:18 -0700
In-Reply-To: <20180719185620.124768-1-sbeller@google.com>
Message-Id: <20180719185620.124768-2-sbeller@google.com>
References: <20180719185620.124768-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 1/3] xdiff/xhistogram: pass arguments directly to fall_back_to_classic_diff
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By passing the 'xpp' and 'env' argument directly to the function
'fall_back_to_classic_diff', we eliminate an occurrence of the 'index'
in histogram_diff, which will prove useful in a bit.

While at it, move it up in the file. This will make the diff of
one of the next patches more legible.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff/xhistogram.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 73210cb6f3f..6e20f75fe85 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -233,6 +233,16 @@ static int try_lcs(struct histindex *index, struct region *lcs, int b_ptr,
 	return b_next;
 }
 
+static int fall_back_to_classic_diff(xpparam_t const *xpp, xdfenv_t *env,
+		int line1, int count1, int line2, int count2)
+{
+	xpparam_t xpparam;
+	xpparam.flags = xpp->flags & ~XDF_DIFF_ALGORITHM_MASK;
+
+	return xdl_fall_back_diff(env, &xpparam,
+				  line1, count1, line2, count2);
+}
+
 static int find_lcs(struct histindex *index, struct region *lcs,
 	int line1, int count1, int line2, int count2) {
 	int b_ptr;
@@ -248,16 +258,6 @@ static int find_lcs(struct histindex *index, struct region *lcs,
 	return index->has_common && index->max_chain_length < index->cnt;
 }
 
-static int fall_back_to_classic_diff(struct histindex *index,
-		int line1, int count1, int line2, int count2)
-{
-	xpparam_t xpp;
-	xpp.flags = index->xpp->flags & ~XDF_DIFF_ALGORITHM_MASK;
-
-	return xdl_fall_back_diff(index->env, &xpp,
-				  line1, count1, line2, count2);
-}
-
 static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
 	int line1, int count1, int line2, int count2)
 {
@@ -320,7 +320,7 @@ static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
 
 	memset(&lcs, 0, sizeof(lcs));
 	if (find_lcs(&index, &lcs, line1, count1, line2, count2))
-		result = fall_back_to_classic_diff(&index, line1, count1, line2, count2);
+		result = fall_back_to_classic_diff(xpp, env, line1, count1, line2, count2);
 	else {
 		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
 			while (count1--)
-- 
2.18.0.233.g985f88cf7e-goog

