Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8C11FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 05:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbcFYFYS (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 01:24:18 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33097 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbcFYFYP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 01:24:15 -0400
Received: by mail-lf0-f68.google.com with SMTP id l188so23746887lfe.0
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 22:24:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tUNa/6RjbesH6mVHj/v/34pzryi+NtiwoijmiZlranc=;
        b=E7yuGGPYDEE3BHxSjM4HL64Egf8S8rBd68B0020x3QlQC/knIfQHGLueBjq6JZTxKR
         rRqwzHKpNZfvQf9sXKsdL0MJeIZejfmxp4f/wCqL5NXge8kGK2CIrU4oT3BcSIQ2TTMf
         mXSrVejnyOSL625NipQAZW67aBIfLGAEAfJwpJeOQu2HW0tbbldeM/DIDdude2+WeE5N
         qt9YVNZ3vRnJMmgtBXj5MMVtP0oo+/QPT3MEqYUAp/M+drAFnEpq6gq0HKZSIry4XMMJ
         bpt2iK2sgCoHQ8DJ1Ry6QZO2gTdLwDSYqOZynDCAi9Kzx9y+lMNpFHn32gCAT/Zo8cqH
         WbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tUNa/6RjbesH6mVHj/v/34pzryi+NtiwoijmiZlranc=;
        b=ap6bnSr0j17k/gcoL4Jl+5j5xvOagXvorka+zqsYCy1FXZFsdZZNCLj9bYqoxO1U6f
         DGanjrKMOe9XOawJBvhvos8edNOwxl+7lNWyN5FxBXrJdkB3vYLuHBQ4teao2o7Tvlrg
         kh22FGFsiDLPzN4qZo2TXzxkhXrsi96bBTuq9sXIWml27tlClsT4mwF3F2XYPU2Pg19u
         FkkuzkoNyInl2TxsygdRVflKA/XQRyLE/czHAEZo/smxx2oUpBRM4uVvbJDDvkm2rTJn
         1GguvlUTWNUFprVcfgL5+JdJz03ciwfeWIanYxCXRFPoRcUlXcfKO0ehPVvqWOq1nqTg
         PzEQ==
X-Gm-Message-State: ALyK8tLxjRE3LemQqzU0z7joH2vP9ZLkmr7LO4Raig7hzRTc8Fw7ENIKHU7m+ivsjeAt4Q==
X-Received: by 10.46.33.152 with SMTP id h24mr2180390lji.38.1466832253602;
        Fri, 24 Jun 2016 22:24:13 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s87sm1450921lfg.46.2016.06.24.22.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 22:24:12 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/12] grep/pcre: support utf-8
Date:	Sat, 25 Jun 2016 07:22:35 +0200
Message-Id: <20160625052238.13615-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625052238.13615-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
 <20160625052238.13615-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In the previous change in this function, we add locale support for
single-byte encodings only. It looks like pcre only supports utf-* as
multibyte encodings, the others are left in the cold (which is
fine).

We need to enable PCRE_UTF8 so pcre can find character boundary
correctly. It's needed for case folding (when --ignore-case is used)
or '*', '+' or similar syntax is used.

The "has_non_ascii()" check is to be on the conservative side. If
there's non-ascii in the pattern, the searched content could still be
in utf-8, but we can treat it just like a byte stream and everything
should work. If we force utf-8 based on locale only and pcre validates
utf-8 and the file content is in non-utf8 encoding, things break.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Helped-by: Plamen Totev <plamen.totev@abv.bg>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c                          |  2 ++
 t/t7812-grep-icase-non-ascii.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/grep.c b/grep.c
index 8cf4247..3d63612 100644
--- a/grep.c
+++ b/grep.c
@@ -329,6 +329,8 @@ static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
 			p->pcre_tables = pcre_maketables();
 		options |= PCRE_CASELESS;
 	}
+	if (is_utf8_locale() && has_non_ascii(p->pattern))
+		options |= PCRE_UTF8;
 
 	p->pcre_regexp = pcre_compile(p->pattern, options, &error, &erroffset,
 				      p->pcre_tables);
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 1929809..08ae4c9 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -20,6 +20,21 @@ test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
 	git grep -i "TILRAUN: HALLÓ HEIMUR!"
 '
 
+test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 icase' '
+	git grep --perl-regexp    "TILRAUN: H.lló Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.lló Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.LLÓ HEIMUR!"
+'
+
+test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 string with "+"' '
+	test_write_lines "TILRAUN: Hallóó Heimur!" >file2 &&
+	git add file2 &&
+	git grep -l --perl-regexp "TILRAUN: H.lló+ Heimur!" >actual &&
+	echo file >expected &&
+	echo file2 >>expected &&
+	test_cmp expected actual
+'
+
 test_expect_success REGEX_LOCALE 'grep literal string, with -F' '
 	git grep --debug -i -F "TILRAUN: Halló Heimur!"  2>&1 >/dev/null |
 		 grep fixed >debug1 &&
-- 
2.8.2.526.g02eed6d

