Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F96C207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031595AbdDTL0u (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:26:50 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33773 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942132AbdDTL0c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:26:32 -0400
Received: by mail-io0-f194.google.com with SMTP id k87so15222150ioi.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FW+T+NYyCka4H75R+PeTKF4CpW0ymUVubObqzz3C1BI=;
        b=IuLigi/qTfkp/yMp2zZ8Hvu5xoL5kDBeEX2fOPfqhIdGNS9F2N59jXaQq1ARKquUJv
         vQHhhiWjSqtNerNLP9XQksU8rNjAmmsSQkcZu5Nx+ga3qxwVcRBlUh9djtMnvmBSiF3X
         5hvhBLV1R8F2klXB/7A0no3Bud2HjvZy6xKDL2SIGPaj+WqIHtYG2o+wQ2vHG63fcDQx
         Jurv6cYD2jHrtvye6T6xg9YDKeIZ86Zt9jB232MaILM+eIqYnBz8jwiYOL6VBjNAFIEB
         +ap8JMPNduF8VvUYCKJWfwoL5pUXIAiTd2YgUQxS9gva8hyVVNn5O8TRDctx47IXj8Dt
         3iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FW+T+NYyCka4H75R+PeTKF4CpW0ymUVubObqzz3C1BI=;
        b=S6gRXDPWFSOP+AQiw4itrbKuM2MTi+/rIvZXgZUoqMLuI7PLoaDfbiOtaITQoXOmR7
         KGIfmisZWpkM2L8d+K2gSeue/zIVGZ9Attcr+wLsiGQsSOWZX1WkMCE2ze+CtHVqqKp7
         Idu2tO6EHVOolGWNLtRrvPxRIRNn4RfOfuIOR5xw3m3gIprvJSfliOWIFah3sMvHIUcK
         7mPN/8dwk1n3fq7N338XgONe8MvJDt5Mgym6FW9u67K3apUGuuLV4jTQ04fOTMK6Hzhz
         AwsRSe/OrnH6LbFkV6cQ99d+8PRVk54qYPMsI1a5GOted3GNPK1NbSotaqGqot1Trxrb
         dIlA==
X-Gm-Message-State: AN3rC/7Aqc6JzpL/inFuLy2/cJxy5V/UoeJus1udf71oKOTyJMVh0Gno
        BgFNNGJNSo9dcQ==
X-Received: by 10.99.55.78 with SMTP id g14mr7621939pgn.191.1492687586888;
        Thu, 20 Apr 2017 04:26:26 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id s83sm9672667pfa.128.2017.04.20.04.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:26:26 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:26:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/15] config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
Date:   Thu, 20 Apr 2017 18:25:55 +0700
Message-Id: <20170420112609.26089-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420112609.26089-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable is added [1] with the assumption that on a sane system,
fopen(<dir>, "r") should return NULL. Linux and FreeBSD do not meet this
expectation while at least Windows and AIX do. Let's make sure they
behave the same way.

I only tested one version on Linux (4.7.0 with glibc 2.22) and
FreeBSD (11.0) but since GNU/kFreeBSD is fbsd kernel with gnu userspace,
I'm pretty sure it shares the same problem.

[1] cba22528fa (Add compat/fopen.c which returns NULL on attempt to open
    directory - 2008-02-08)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 config.mak.uname | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 399fe19271..a25ffddb3e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -36,6 +36,7 @@ ifeq ($(uname_S),Linux)
 	NEEDS_LIBRT = YesPlease
 	HAVE_GETDELIM = YesPlease
 	SANE_TEXT_GREP=-a
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
@@ -43,6 +44,7 @@ ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_PATHS_H = YesPlease
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),UnixWare)
 	CC = cc
@@ -201,6 +203,7 @@ ifeq ($(uname_S),FreeBSD)
 	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
 	HAVE_BSD_SYSCTL = YesPlease
 	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
-- 
2.11.0.157.gd943d85

