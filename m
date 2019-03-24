Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED4BE20248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfCXIVS (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:21:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35026 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfCXIVS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:21:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so4312683pfe.2
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ik/UldvKgnqQWpze7cA9tPU5bbegyTpwMEKC5nUu6bI=;
        b=rJnE++oSFnyzSyrm/hIBn5P4yB8oB92DAG/2ipgLgpWb3v/RggMmS1O1xI0Bktm2Ht
         r+/6L2tyB3vGTs9/zclDxlT9xf+ahEm8FSvXqutRpHAF15Uq8GLfveIzj1JF/dpedfep
         58QpOx+GNs75JWV1dXdWJgrtQcL2mP8kobjpxdSyugRi1l4aLqV2dECP7SH89KfA1sfc
         VThmbzqVXWV9P4bXrGJoHs/pEvATOHC7enh5pU0u1iQiNh2A54kODWQ7BElxKsrrOBIK
         ZMvVopCsW9oKMtGo81cERgrB8WbNa2eJL0Z+Nb4kMGVMbKMQH7ye9gtZmm+6RDtFki1K
         kwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ik/UldvKgnqQWpze7cA9tPU5bbegyTpwMEKC5nUu6bI=;
        b=B4bzOzxzuNHY1xm3JN0pNd3mTivbFPDL2zw5dubWV5RIryhtxK7AP50N2HCYKHxLPy
         HLwhWuPhxNwRyo1dXNMZlF7ZMyWR+/kxphCiQu9vo70PI4WD1/I2bqjZUmigjqxrjIoJ
         ZwFqfarz/KlL2rvvVAdxKf1OrZiU4/2INsVnqeoStGwrD8VYiIH55nM+iRBM00nvUlSM
         O+K8Fckn1fnqgpuPHQueLKrPdVsCmdLT/dZu69a8vBvBvZILNxsUdYKv06jUokXJKsGw
         1HyFg+1cc8Yk3WWbXmZtX2G3h9EnS2n3znt3bi+Aq0EEfLjkCydscCoFzsXpPNpvDwXN
         UANg==
X-Gm-Message-State: APjAAAUnYfcMA+SgnTLMNgm9021mGKoU5z1i3gDAzIOcuDc96Lx/b7y4
        t8b+YZ8hsqEWyd7eDS9PoPI=
X-Google-Smtp-Source: APXvYqxh4kYAc1fCxaKxZOCPxgt009MbSf+LnGocUZqrl55nnYq20LU83uIrHPtwaEX0L8YLMq7Y7w==
X-Received: by 2002:aa7:82d9:: with SMTP id f25mr17993855pfn.45.1553415677582;
        Sun, 24 Mar 2019 01:21:17 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id e15sm15443314pgk.30.2019.03.24.01.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:21:16 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:21:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 01/20] diff-parseopt: convert --ws-error-highlight
Date:   Sun, 24 Mar 2019 15:19:55 +0700
Message-Id: <20190324082014.2041-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190324082014.2041-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
 <20190324082014.2041-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark one more string for translation while at there.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index ce118bb326..7bfdf08137 100644
--- a/diff.c
+++ b/diff.c
@@ -4801,17 +4801,18 @@ static void enable_patch_output(int *fmt)
 	*fmt |= DIFF_FORMAT_PATCH;
 }
 
-static int parse_ws_error_highlight_opt(struct diff_options *opt, const char *arg)
+static int diff_opt_ws_error_highlight(const struct option *option,
+				       const char *arg, int unset)
 {
+	struct diff_options *opt = option->value;
 	int val = parse_ws_error_highlight(arg);
 
-	if (val < 0) {
-		error("unknown value after ws-error-highlight=%.*s",
-		      -1 - val, arg);
-		return 0;
-	}
+	BUG_ON_OPT_NEG(unset);
+	if (val < 0)
+		return error(_("unknown value after ws-error-highlight=%.*s"),
+			     -1 - val, arg);
 	opt->ws_error_highlight = val;
-	return 1;
+	return 0;
 }
 
 static int parse_objfind_opt(struct diff_options *opt, const char *arg)
@@ -5234,6 +5235,9 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("show full pre- and post-image object names on the \"index\" lines")),
 		OPT_COLOR_FLAG(0, "color", &options->use_color,
 			       N_("show colored diff")),
+		OPT_CALLBACK_F(0, "ws-error-highlight", options, N_("<kind>"),
+			       N_("highlight whitespace errors in the 'context', 'old' or 'new' lines in the diff"),
+			       PARSE_OPT_NONEG, diff_opt_ws_error_highlight),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5397,9 +5401,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
-		return parse_ws_error_highlight_opt(options, arg);
-	else if (!strcmp(arg, "--ita-invisible-in-index"))
+	} else if (!strcmp(arg, "--ita-invisible-in-index"))
 		options->ita_invisible_in_index = 1;
 	else if (!strcmp(arg, "--ita-visible-in-index"))
 		options->ita_invisible_in_index = 0;
-- 
2.21.0.548.gd3c7d92dc2

