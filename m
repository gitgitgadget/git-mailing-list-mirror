Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BAE2207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753104AbdECKSU (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:18:20 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32852 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbdECKSS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:18:18 -0400
Received: by mail-pg0-f65.google.com with SMTP id s62so16001810pgc.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FW+T+NYyCka4H75R+PeTKF4CpW0ymUVubObqzz3C1BI=;
        b=h64SU6Xe0F24at8ADg+GL62opIbYw1ooUEowfcOB3TthxYDe2ADuDHoFqF8iUZTQ0o
         sM+5TO+YQbv8lgkW4bTiWeoQWr41J8S69BY572BJoEHUzag5mP6DtZJip+/rSW51FxJN
         0hQ3Oxszj42S6OPKwpaTuN8Vh6w71UZk4PSnmsGiclaONL+feShvglDA8gVkM27Pcv8R
         LHdTeaWCJmKYsIlhnp26HIjQ/SHvpC8sUUv506KWDyLSKfDRCH4EHVqoGn1+FQO1z830
         IVIclhz8bw1F5ffPRjPeHVbIoADVLXk9NKT1OIURaw3yGJzUHUnjrZQD98Vz0l+6G1Mv
         PSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FW+T+NYyCka4H75R+PeTKF4CpW0ymUVubObqzz3C1BI=;
        b=qU3u2hzlq94Qxb15Jt/sPYCW8CRau3J5NlkYtuRAz3p4MPfuYc4cqMfvJhKjm1iyuf
         +mrirgINlSczCTqY37SZ1Czsi5H2wH4X6iZydyyBaAqceem1ZkizdtorXMUWJ+o8p+18
         Tx5l6nIXHP5raCk3Q6l4HON/8UrH3vv7+ij5dxwhyteBbxQQyy99Pxob6xoYlsMVN5H2
         fQctifVLh43SEN3imwRAQDuCCZiTiCEz8ccow9qnmUXwtlFIcr0aJs5Wq8Np8ubnFA9d
         IJZil7obKHma0PxkJyMfuFAxSbbL8P+IDvRYV1FIMRVdvPQFd6PEvFbSaZj5xYHPnvIl
         qLbw==
X-Gm-Message-State: AN3rC/77IikckOhsW97/lrw7u7irCQMFDPlnmyvO8s9rgOYwBOCweHSu
        aBPyq4oBVWzDfA==
X-Received: by 10.99.44.82 with SMTP id s79mr38682674pgs.219.1493806698043;
        Wed, 03 May 2017 03:18:18 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id g66sm3610641pfj.11.2017.05.03.03.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:18:17 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:18:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 03/21] config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
Date:   Wed,  3 May 2017 17:16:48 +0700
Message-Id: <20170503101706.9223-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170503101706.9223-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170503101706.9223-1-pclouds@gmail.com>
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

