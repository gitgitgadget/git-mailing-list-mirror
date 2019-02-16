Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 281971F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfBPLhz (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:37:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45310 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLhy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:37:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so6072849pgc.12
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s7MY/XfIX529YSTHE32PpcTM6WI44743a28+xdW9DAI=;
        b=uLexcmvtfFfCgM+AsgGOfHFUpL42Lvpp0X/N0o3kUQz22t/Ki0Rdwrkq3Q2MWIfJGA
         GNDrBiPROx0pzXUjrFq1hDp5ZNXkPjzd6kzBfW4dxGMZzWzsuI5Kyjr/98LXzL3BlHdd
         ECsL7x9J5IDCh9K7lrCdt47j8eLrnDvnzHMIYwVLpkFPj2cXvGFay7VFy3MA3gW3L7Qj
         Dv3fmWSGE9Bgxz7RTYOlafubKolnudi4vjSm33CvAsbwf+1ug3QwUJzeOMjCei+iCp+Y
         T1Fi7OWSwibBb4NOWo6yc/b5bQll6Cl7iCUebXP7X68KTE46PBEu+vZnMtwNNb7Qe/Zs
         VJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s7MY/XfIX529YSTHE32PpcTM6WI44743a28+xdW9DAI=;
        b=ksdP3BgyV8DkaZuNbDNP8OqYsYNP8m6ixcmT860VDKjRXOkgqFWJ9PrbRmH6J2AtXy
         iNJUO3s/1nxgKgAY/S2Jh2kyygVTYU7Y7+HE/LBab6QMKb9v+aTuXLGLxDcTGCA+pFo9
         FGzwgi0kQfOUS1K+V4t0mFMzqBUc/dd/TSxTzEau8UzmxGCKhLwo0X8OE2HN3JKmuPXv
         ECOp79Zl6afJ0tsHp/SCzbnRFkeKghvJ4ZOu7gJHNgrHgYO6LmQgaqZuyjr6Ixj0Sy8T
         xxbKSrDThZ7IYLccpsJ+R7Eb6WM5kCrUdfI5riI0hK5lphsf1m77wRrvfueF5sU92yQx
         kpiQ==
X-Gm-Message-State: AHQUAuYJhkLDMReCKSlxTi0z1wg1vF037NYKxsIVL+KCxonpV/Ppk2c8
        r9XZ5XA2PhIktyYAfAym1vdUc4HA
X-Google-Smtp-Source: AHgI3IZiiEuKs9/riC2Pou+rBk8Eh4zs9hUWUu9RlsbcPh4SahEucUgYW9vkmB3ChOGTRnNie5g8dA==
X-Received: by 2002:a62:5a81:: with SMTP id o123mr14190740pfb.109.1550317073910;
        Sat, 16 Feb 2019 03:37:53 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id f62sm15000411pgc.67.2019.02.16.03.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:37:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:37:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 09/21] diff-parseopt: convert -s|--no-patch
Date:   Sat, 16 Feb 2019 18:36:43 +0700
Message-Id: <20190216113655.25728-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190216113655.25728-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
 <20190216113655.25728-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 99047fb5fe..9c8f5336bc 100644
--- a/diff.c
+++ b/diff.c
@@ -4906,6 +4906,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BITOP('p', "patch", &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
+		OPT_BIT_F('s', "no-patch", &options->output_format,
+			  N_("suppress diff output"),
+			  DIFF_FORMAT_NO_OUTPUT, PARSE_OPT_NONEG),
 		OPT_BITOP('u', NULL, &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
@@ -4983,9 +4986,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
-		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
-	else if (starts_with(arg, "--stat"))
+	if (starts_with(arg, "--stat"))
 		/* --stat, --stat-width, --stat-name-width, or --stat-count */
 		return stat_opt(options, av);
 	else if (!strcmp(arg, "--compact-summary")) {
-- 
2.21.0.rc0.328.g0e39304f8d

