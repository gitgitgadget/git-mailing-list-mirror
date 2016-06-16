Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 296161FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 13:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbcFPNTI (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 09:19:08 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34910 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbcFPNTF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 09:19:05 -0400
Received: by mail-pa0-f66.google.com with SMTP id hf6so3745080pac.2
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 06:19:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppyMGhz6rylmN35j64XM3q/5nqCRWLiXnxw0VNTbUWo=;
        b=N9rFye+SSoAbv+2acPMyOWKLLbmMRtvfhCMo6VIi5bxX2qKI9cyhQ+bhE6bo4y1qMR
         /7/v79LU1bRFLS5gDEQEkbEgwu6JPx8o0zbtcmePEmhq0pqbiTSV4P67HJmERuoYmb9a
         agPcYPccFPOE4kRFZH+BhDVJaToFIDHwGMm1u2PJIeWi31J4JCZomSwb03XrU12djndg
         KTEaQEYTJE7nZX8RrUZiG2cdhybNqtp0OF6JOssGLKeUNvFLKbBuC7PQB6rZ1Rwp7jZt
         moL5llWepoW0gJVUcaBk9lG831Dkdq0Kgti7WDUmdXmsBR5kQG1wcfSJ0JzRp3PS2nu4
         COLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppyMGhz6rylmN35j64XM3q/5nqCRWLiXnxw0VNTbUWo=;
        b=Df9mGTQmnR460YDdEY+HzGYye9HHuAhn6Y7M+uthUHI1K1/HWjQMMAx8tvc8b4fbgs
         EF4EPDIveYAniNsMB05jfzWWThlZqHa2eAq/c1oIIAU2DfZY0ay9Oe14tdozo7zHDT9y
         cpAXfFR09g2Qx+dyErqB8aMoR+tthY65lwuoEVnjLEkFjSmVMGi1G4704y9v7qz+kBUM
         IrB2ijBVMtAzgCcJKRwpM/mnKpIgixkcVkzfko3yuz9NKAigXpwNZ9ZcB7Gf9t4WI/Vt
         +4VfSjRYNLeY4WD7IxFqWQKaNIKhSf8Bn3kjQMz2HmGYX3S1YZRFfk4iLlKcsbl0c81R
         0X6A==
X-Gm-Message-State: ALyK8tJNfmcWJvbuZZRT3L/KkkWtDl9CVv1Ci+oq7onJGDMaw6i0Qs6kYhyW7v/ZMRmPow==
X-Received: by 10.66.50.105 with SMTP id b9mr5073317pao.122.1466083144873;
        Thu, 16 Jun 2016 06:19:04 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id vb6sm60859369pac.16.2016.06.16.06.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2016 06:19:04 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Jun 2016 20:19:00 +0700
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, josef@kufner.cz,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] pretty.c: support <direction>|(<negative number>) forms
Date:	Thu, 16 Jun 2016 20:18:38 +0700
Message-Id: <20160616131838.14440-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160616131838.14440-1-pclouds@gmail.com>
References: <20160616131838.14440-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

%>|(num), %><|(num) and %<|(num), where num is a positive number, sets a
fixed column from the screen's left border. There is no way for us to
specifiy a column relative to the right border, which is useful when you
want to make use of all terminal space (on big screens). Use negative
num for that. Inspired by Go's array syntax (*).

(*) I know Python has this first (or before Go, at least) but the idea
didn't occur to me until I learned Go.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pretty.c                      |  8 +++++++-
 t/t4205-log-pretty-formats.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 4f33b09..1c67b23 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1022,9 +1022,15 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
 		int width;
 		if (!end || end == start)
 			return 0;
-		width = strtoul(start, &next, 10);
+		width = strtol(start, &next, 10);
 		if (next == start || width == 0)
 			return 0;
+		if (width < 0) {
+			if (to_column)
+				width += term_columns();
+			if (width < 0)
+				return 0;
+		}
 		c->padding = to_column ? -width : width;
 		c->flush_type = flush_type;
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index d75cdbb..d9f6242 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -176,6 +176,17 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'left alignment formatting at the nth column' '
+	COLUMNS=50 git log --pretty="tformat:%h %<|(-10)%s" >actual &&
+	qz_to_tab_space <<EOF >expected &&
+$head1 message two                    Z
+$head2 message one                    Z
+$head3 add bar                        Z
+$head4 $(commit_msg)            Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting at the nth column. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%h %<|(40)%s" >actual &&
 	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
@@ -308,6 +319,17 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'right alignment formatting at the nth column' '
+	COLUMNS=50 git log --pretty="tformat:%h %>|(-10)%s" >actual &&
+	qz_to_tab_space <<EOF >expected &&
+$head1                      message two
+$head2                      message one
+$head3                          add bar
+$head4              $(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting at the nth column. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%h %>|(40)%s" >actual &&
 	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
@@ -397,6 +419,17 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'center alignment formatting at the nth column' '
+	COLUMNS=70 git log --pretty="tformat:%h %><|(-30)%s" >actual &&
+	qz_to_tab_space <<EOF >expected &&
+$head1           message two          Z
+$head2           message one          Z
+$head3             add bar            Z
+$head4       $(commit_msg)      Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'center alignment formatting at the nth column. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%h %><|(40)%s" >actual &&
 	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-- 
2.8.2.524.g6ff3d78

