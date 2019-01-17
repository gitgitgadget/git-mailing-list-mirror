Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56851F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfAQNMs (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:12:48 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40447 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfAQNMs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:12:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so4816663pfo.7
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mb5rXN+m6m3P7DB4NjHwNJFk7tnu3IwkQdB2hj+bd94=;
        b=n4Gdjz4rpWpOOTmd33ZkDlkbLFeQw9QfRzW+eZXHa7ciblgVg/F2zW8tlFDGLvO6QV
         AMfONGwU67mgbVJWgbRZG0/FlmT61NsG2GaAjR8RJHnjupBZHRaNEiQ1fTA+YiXAOurr
         cO96F0JZsTxyRN90nk7OiOwbF/KspDuRrJamhnt7uU7HubiLuMkTyqGcODMPH0INAeN2
         Fsy4umd8cNSo1V1JZy59v2o8iIzy2H1PSl8mF9r29IYgmDxIaqrrNBAinXFrx9x1OC2w
         ruY3OC9JEYjp8zgL5o/5crzFReGDxTPZCtb7c9MfICBghq+ofYeHQPGYFq1Yz5QXXDan
         ahbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mb5rXN+m6m3P7DB4NjHwNJFk7tnu3IwkQdB2hj+bd94=;
        b=m/e4lgd9kwAHWqg0lQiN2afmafLPWsvOj7LccDfRJoRgmYbLR8HQkNpcudGePUXve3
         qPTZLjcPS8+KS50bQg0zkwv+4d549UeMsrPZT9ltbYM4uJVhDUErzHuxHy/mO21Iyb/i
         gQoCNaDwoXXR+Re1Mgra+F+pxlqoaM3igsEYc5rn45cOJEujzDaLfzenG1OaEx32eKS+
         EPVfflCI2hnq8ehjMLoYNyXLYmhjFe18ZiRjJ67EeQ/FFpiPnkIVoGDnpDW3/L5YUO9+
         L4pYX3wnloamFSURnd8jCPFs8eri4HgziwVp27DSH+qIkCimlekoK0ieBujMTFNLVDjO
         s5NQ==
X-Gm-Message-State: AJcUukf80kxn/4n8aDQlDTHYerW3LHGAQI3K6dSUt+bEQ/ky7sJ270mJ
        C8R3nR1fqborIUI5L66ODOOB8jcP
X-Google-Smtp-Source: ALg8bN6oc3RDrOsHO+VP8y1MVz1C7Yk5S48U5tljLu4IgyqywnSUYbU1oq22V3mj4/omthwPYpQ0oQ==
X-Received: by 2002:a63:62c4:: with SMTP id w187mr12472159pgb.230.1547730767318;
        Thu, 17 Jan 2019 05:12:47 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 125sm3104334pfg.39.2019.01.17.05.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:12:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:12:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 76/76] am: avoid diff_opt_parse()
Date:   Thu, 17 Jan 2019 20:06:15 +0700
Message-Id: <20190117130615.18732-77-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
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
index 95370313b6..0cbf285459 100644
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
index daccc8226f..b8e58e817b 100644
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
index 03c6afda22..f88482705c 100644
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

