Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE79211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbeL0Q0G (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:26:06 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41669 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729490AbeL0Q0F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:26:05 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so12992296lfj.8
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 08:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+a2D0EmS2f/2kbPOXkC7EjsXKFs3wpiK0KJBISi4z0=;
        b=IeWAJUHzWIAdeHTi35yZ/6JCjjOv0jWXJs308g7lA05QiK9L4JqNqz4YEDzUnzXeOp
         ptWM3FQb8zEPp6txVdHYa5A5Zt4Pay+6P4gjiyphNDRj5X/3gewQl2o77g3xw8+u+jxK
         R8LocevAOnrqvC5d0+bk+NJMz5Lgkrf4hoFz5q6Qx8g1SOfRYL3KlYmW/QWOimIgCL+M
         EP0eN/xng0boQdpvkIeY3DBA9Tm9F4EMY95kdmwk3xvtBnUmWJwTAz/kxE8H1s0h3Yf4
         deT+OMZphxPhHxBNF6mM1UXAqFZdXaV/alvcDsAVNjLbQemkZQMBpWaDRGmKE1eOSeax
         DVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+a2D0EmS2f/2kbPOXkC7EjsXKFs3wpiK0KJBISi4z0=;
        b=oBfyInUFsnyzguriNpA7VfNVcWt9ALZzYYpTX+9cTBlzfynOxgQuOk14M9MEpmKwgg
         idlQAPk7cxcs0Rbp9hr1H6EjummRvogY5SIn6QAlWhx1OhqM51yQFU9jT3KCQBjDr3Ga
         MqR/es5EOCH0qKb2R0LGfJPHEX83nxbKjE9qf6GYPcPo6WY+doaI7eEJeEzluxdsA6kT
         uo7q1tk2jGntss8Dd5V8RgEx83QdbSck3eNcQiSChhOk9bvEGc6JA/HbSnDWGdqm8snT
         QiG6wzpMvK+alnTqQfhewDQxNxvISI27C0wdYEiUJYYLNaU45Yk1Fr8rDulTQsmq0W7M
         w6/g==
X-Gm-Message-State: AA+aEWa4evyOxOHgU5f5Idiz/+GgdiQjIDp4gnKMuuCuXDO61lvfGFyA
        8HKAPNLyhQP8sQmZedgS2mRiK3dO
X-Google-Smtp-Source: AFSGD/UntYxJRgBd2rRTCcM1jCUeuMc1Da9LukUhN1jcf5t1H/cPcCwmXFv+G+2+lyvXIjvt6ulMIw==
X-Received: by 2002:a19:c650:: with SMTP id w77mr12640638lff.56.1545927963312;
        Thu, 27 Dec 2018 08:26:03 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id a127sm7643106lfe.73.2018.12.27.08.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:26:01 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 75/75] am: avoid diff_opt_parse()
Date:   Thu, 27 Dec 2018 17:25:36 +0100
Message-Id: <20181227162536.15895-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227162536.15895-1-pclouds@gmail.com>
References: <20181227162536.15895-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff_opt_parse() is a heavy hammer to just set diff filter. But it's
the only way because of the diff_status_letters[] mapping. Add a new
API to set diff filter and use it in git-am. diff_opt_parse()'s only
remaining call site in revision.c will be gone soon and having it here
just because of git-am does not make sense.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/am.c | 4 ++--
 diff.c       | 6 ++++++
 diff.h       | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8f27f3375b..a98e65f440 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1515,11 +1515,11 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		 * review them with extra care to spot mismerges.
 		 */
 		struct rev_info rev_info;
-		const char *diff_filter_str = "--diff-filter=AM";
 
 		repo_init_revisions(the_repository, &rev_info, NULL);
 		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
-		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.prefix);
+		rev_info.diffopt.filter |= diff_filter_bit('A');
+		rev_info.diffopt.filter |= diff_filter_bit('M');
 		add_pending_oid(&rev_info, "HEAD", &our_tree, 0);
 		diff_setup_done(&rev_info.diffopt);
 		run_diff_index(&rev_info, 1);
diff --git a/diff.c b/diff.c
index 43ae8d4d2c..8a7011b928 100644
--- a/diff.c
+++ b/diff.c
@@ -4756,6 +4756,12 @@ static unsigned filter_bit_tst(char status, const struct diff_options *opt)
 	return opt->filter & filter_bit[(int) status];
 }
 
+unsigned diff_filter_bit(char status)
+{
+	prepare_filter_bits();
+	return filter_bit[(int) status];
+}
+
 static int diff_opt_diff_filter(const struct option *option,
 				const char *optarg, int unset)
 {
diff --git a/diff.h b/diff.h
index 44843d8929..48cfa3f0a6 100644
--- a/diff.h
+++ b/diff.h
@@ -233,6 +233,8 @@ struct diff_options {
 	struct option *parseopts;
 };
 
+unsigned diff_filter_bit(char status);
+
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
 void diff_emit_submodule_add(struct diff_options *o, const char *line);
 void diff_emit_submodule_untracked(struct diff_options *o, const char *path);
-- 
2.20.0.482.g66447595a7

