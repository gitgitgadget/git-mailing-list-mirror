Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C3A1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 16:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeKHCVS (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 21:21:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36766 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbeKHCVR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 21:21:17 -0500
Received: by mail-lf1-f65.google.com with SMTP id h192so11983250lfg.3
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 08:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74dtnGY9c0C48hIEsRSG8U2+ft9y8jJQp3Us+cvV/Sw=;
        b=FDd0jqLDlXBHX0diYbiVOx5xHwSCikLJEcMSHT3u+ni8U/Rv3laflXYsZaDYjjJHQ7
         iKDMB7thJEcU8+6hQI8OfZaHiv3HZuEQjzK8Q6isWm5RPrtoHNWaUuhu6sySBQ8+dOEX
         L53PPyeQz2rrXg/Zt8zp0DEw+FQ/41FjpiUC8enk75qsfI8KdKc46riEYzbezheWE3Tl
         a/f8WcQ1W+jpqz/f+ElVmx+J3+tRzAAoBOQpoChyqKi4ZqztJTP4taC9RdsPU3VhgtNn
         evnoPib2rLW+zckzQ6gwL7TGWAnFhhJJiVPXlOiNw/5EnXwSRFbH76xkiIbQfeVohbKD
         1KHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74dtnGY9c0C48hIEsRSG8U2+ft9y8jJQp3Us+cvV/Sw=;
        b=m2g4BJxtISPND5+gblCzA+65SyIPVM5kfUUoVymTnj0iGJbOro4ZTWFry00F2JptPY
         HklpRFo/b3HLJM1pATdfeA9r4WKYlUVAJ0QfRzFRC9B7OTEPI+4KFuVKHc/hj9LBF4Aw
         JlXqMdTH6fJ8ukp5OCywPq7jGNuHlZthS9SODbrfqwdR2XocCEqPVZBnSZLnHSE3AVn0
         97+p8X6LAp1WgQqnspUcRnXlOqcMzvJTNdMRBJaelgaowBG/dxzWwW9L5/pT9o9wDarw
         Sd5YrH8rgpN6q37HOHl8Ngh+B9DvbeW0WAUOetlvVrT//ugWqyrX59bfrweUn9O5vWi5
         FG9g==
X-Gm-Message-State: AGRZ1gLIMj1zVnYQ+N6x1gVM74kra6SPmnIQLhXG3CJhBrdPKzKBAFcX
        ztQE9R6t9ud+vep3eNGdKSk=
X-Google-Smtp-Source: AJdET5ef8GUKxRgoeo42RLYjQe8NAEKo8KJYn5bJUATab+HCjeGhV6b7LoG5Ut2tHUPxeQnPLEN57A==
X-Received: by 2002:a19:c801:: with SMTP id y1mr565142lff.53.1541609405804;
        Wed, 07 Nov 2018 08:50:05 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b19sm195531lfc.80.2018.11.07.08.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 08:50:04 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     leif.lindholm@linaro.org
Cc:     git@vger.kernel.org, gitster@pobox.com, lersek@redhat.com,
        pclouds@gmail.com
Subject: [PATCH v2] format-patch: respect --stat in cover letter's diffstat
Date:   Wed,  7 Nov 2018 17:49:53 +0100
Message-Id: <20181107164953.24965-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181106104811.14625-1-leif.lindholm@linaro.org>
References: <20181106104811.14625-1-leif.lindholm@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 43662b23ab (format-patch: keep cover-letter diffstat wrapped in
72 columns - 2018-01-24) uncondtionally sets stat width to 72 when
generating diffstat for the cover letter, ignoring --stat from command
line. But it should only do so when stat width is still default
(i.e. stat_width == 0).

In order to fix this, we should only set stat_width if stat_width is
zero. But it will never be. Commit 071dd0ba43 (format-patch: reduce
patch diffstat width to 72 - 2018-02-01) makes sure that default stat
width will be 72 (ignoring $COLUMNS, but could still be overriden by
--stat). So all we need to do here is drop the assignment.

Reported-by: Laszlo Ersek <lersek@redhat.com>
Helped-by: Leif Lindholm <leif.lindholm@linaro.org>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/log.c          |  2 --
 t/t4052-stat-output.sh | 48 +++++++++++++++++++++++++++++-------------
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 061d4fd864..1a39c6e52a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1009,8 +1009,6 @@ static void show_diffstat(struct rev_info *rev,
 
 	memcpy(&opts, &rev->diffopt, sizeof(opts));
 	opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
-	opts.stat_width = MAIL_DEFAULT_WRAP;
-
 	diff_setup_done(&opts);
 
 	diff_tree_oid(get_commit_tree_oid(origin),
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 6e2cf933f7..b1ce0d9b97 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -44,42 +44,50 @@ show --stat
 log -1 --stat
 EOF
 
-while read cmd args
+cat >expect.40 <<-'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+EOF
+cat >expect.6030 <<-'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+EOF
+cat >expect2.40 <<-'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+EOF
+cat >expect2.6030 <<-'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+EOF
+while read expect cmd args
 do
-	cat >expect <<-'EOF'
-	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
-	EOF
 	test_expect_success "$cmd --stat=width: a long name is given more room when the bar is short" '
 		git $cmd $args --stat=40 >output &&
 		grep " | " output >actual &&
-		test_cmp expect actual
+		test_cmp $expect.40 actual
 	'
 
 	test_expect_success "$cmd --stat-width=width with long name" '
 		git $cmd $args --stat-width=40 >output &&
 		grep " | " output >actual &&
-		test_cmp expect actual
+		test_cmp $expect.40 actual
 	'
 
-	cat >expect <<-'EOF'
-	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
-	EOF
 	test_expect_success "$cmd --stat=...,name-width with long name" '
 		git $cmd $args --stat=60,30 >output &&
 		grep " | " output >actual &&
-		test_cmp expect actual
+		test_cmp $expect.6030 actual
 	'
 
 	test_expect_success "$cmd --stat-name-width with long name" '
 		git $cmd $args --stat-name-width=30 >output &&
 		grep " | " output >actual &&
-		test_cmp expect actual
+		test_cmp $expect.6030 actual
 	'
 done <<\EOF
-format-patch -1 --stdout
-diff HEAD^ HEAD --stat
-show --stat
-log -1 --stat
+expect2 format-patch --cover-letter -1 --stdout
+expect diff HEAD^ HEAD --stat
+expect show --stat
+expect log -1 --stat
 EOF
 
 
@@ -95,6 +103,16 @@ test_expect_success 'preparation for big change tests' '
 	git commit -m message abcd
 '
 
+cat >expect72 <<'EOF'
+ abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+EOF
+test_expect_success "format-patch --cover-letter ignores COLUMNS (big change)" '
+	COLUMNS=200 git format-patch -1 --stdout --cover-letter >output &&
+	grep " | " output >actual &&
+	test_cmp expect72 actual
+'
+
 cat >expect72 <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
-- 
2.19.1.1005.gac84295441

