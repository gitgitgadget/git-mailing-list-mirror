Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37E6E1F406
	for <e@80x24.org>; Tue, 15 May 2018 20:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeEOUAu (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 16:00:50 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36141 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752645AbeEOUAo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 16:00:44 -0400
Received: by mail-pl0-f67.google.com with SMTP id v24-v6so667412plo.3
        for <git@vger.kernel.org>; Tue, 15 May 2018 13:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/VoSlbJvPyLI+wEigwbSAzQSX2qDb0Bvpbs5NUbR6nA=;
        b=g78KbUxBZzL+vacQbnbzFmzHJS2vZ1Mb4XZe9k8bOgl/YYUkdLQxcpP9OhfB67QX2R
         x/4s7eRWOar7zTDdc5t8yElIOwXwKKtMJkGoSwmm/yWit4Rk2bBS52SwoZ/5Yb8yskQ4
         V3blYkTd5VpTALTOWXQF2eI4pKx+yNEiylvZBobHfACWhT1l4rpgvaqZTJNZDSpaI/C7
         o7/Hhso5tD17rmtGYqqkaJeY8grgB1dm8myUaaju92rFvbgTWMLmpisBx9rPfRGhOE4o
         hEsUjBvLwVSCI2ExdR/IF/n3xs5WAowh1PHps2wqcwkShrUUMP5DEytsrUIvpnaQngpN
         lP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/VoSlbJvPyLI+wEigwbSAzQSX2qDb0Bvpbs5NUbR6nA=;
        b=hlwagEnvlVSax3PbtTtYcPlynhLiDXN6D6mThM4/YFrh59z+sEIcT4Y0UP5DeNvOLq
         4ezRlBl+czvlY4v0VaTNOanVHDfsg6mMiV/SaU+M9qzlrm2jJrpkejaIIhcC7+6Ofm/A
         u15uywvaam8PB+E1g5W5/eRYR/810rhh6h5MB8L6lpCp8oapAdro7BRW030iN0K5rAIv
         tDlAnJ27GmHU4I+Owyqrr6chHW0mdwL5GznQinlAsrr2zoGYlim3hTeOXEA+Eyv7r2za
         fLzx/SXzI+mUHPSpdE3kre2gfQOLHTBLbBE9d5r2InxisP9vRk79JGwA8G6+7gTmxtRK
         i7Cw==
X-Gm-Message-State: ALKqPwdF3UrMWvknimcl4nb6/+63/WFIi7PtjD18DJzTbhoSTmhncsRi
        /35iYqH2DxDIX9QwGIfPHCrxZXzb5Hs=
X-Google-Smtp-Source: AB8JxZq5BTSvg1V+ZUK4J/cfh299af21406BoRzkws1fZPPXZfZxZwXcXimDEsbRhg2RVIlHGCWrTA==
X-Received: by 2002:a17:902:4081:: with SMTP id c1-v6mr15832220pld.60.1526414443667;
        Tue, 15 May 2018 13:00:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id s65-v6sm1092639pfj.124.2018.05.15.13.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 13:00:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, leif.middelschulte@gmail.com
Cc:     gitster@pobox.com, newren@gmail.com,
        Leif Middelschulte <Leif.Middelschulte@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] Inform about fast-forwarding of submodules during merge
Date:   Tue, 15 May 2018 13:00:30 -0700
Message-Id: <20180515200030.88731-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515200030.88731-1-sbeller@google.com>
References: <20180515200030.88731-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Leif Middelschulte <Leif.Middelschulte@gmail.com>

Inform the user about an automatically fast-forwarded submodule. The
silent merge behavior was introduced by commit 68d03e4a6e44 ("Implement
automatic fast-forward merge for submodules", 2010-07-07)).

Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 merge-recursive.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 0571919ee0a..29a430c418a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1093,10 +1093,26 @@ static int merge_submodule(struct merge_options *o,
 	/* Case #1: a is contained in b or vice versa */
 	if (in_merge_bases(commit_a, commit_b)) {
 		oidcpy(result, b);
+		if (show(o, 3)) {
+			output(o, 1, _("Fast-forwarding submodule %s to the following commit:"), path);
+			output_commit_title(o, commit_b);
+		} else if (show(o, 2))
+			output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(b));
+		else
+			; /* no output */
+
 		return 1;
 	}
 	if (in_merge_bases(commit_b, commit_a)) {
 		oidcpy(result, a);
+		if (show(o, 3)) {
+			output(o, 1, _("Fast-forwarding submodule %s to the following commit:"), path);
+			output_commit_title(o, commit_a);
+		} else if (show(o, 2))
+			output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(a));
+		else
+			; /* no output */
+
 		return 1;
 	}
 
-- 
2.17.0.582.gccdcbd54c44.dirty

