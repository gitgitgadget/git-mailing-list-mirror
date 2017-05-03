Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207A8207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbdECKS0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:18:26 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33993 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753114AbdECKSY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:18:24 -0400
Received: by mail-pg0-f65.google.com with SMTP id t7so27645870pgt.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXtRINX1ByqqKowcefovxBjm9qrh8qwJMqBEVuoy03Y=;
        b=VSEMoFqWFCRJlpAhb+lQ1ot/a7/JHz3mbGpqZTUa12boj87cgl4OlRAxrQB3Rx5mFu
         uuNFa2ccl4N067y987nW+AXc82O3khCZjiGrlXDzKw6SuWXtrq6vNU8Fjh+sKykSd4tZ
         h3UjBDod7ErCDhbPcGfKLf9Y74gSRWwRRcvDwfk5cTkDbx//e+/qnQMSfTqtxHt4gaZp
         1R35HBfC9HfM2ghIbYvAlJvMLdVYA8tkglZmARM5w6PEZs4mnvilVdfyxUSJYBu4GwWB
         Gt0BXpEOnyhlnJKJam7nvu4VZtK9rKE5OBEBm8HAb8aIMEgFCOFjNaznB26SbtMWtuZP
         4xRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXtRINX1ByqqKowcefovxBjm9qrh8qwJMqBEVuoy03Y=;
        b=t5JvnyyyidjAlqzyepuWFiiY4ltIhMAuroaAPNKypODSxnH4qxc7ISMMJECEv5APsg
         8EOeOBGY1u1D9K0HEyQTh0tTMDNi5oWXTSGL9j+kjxvAHCvJx0tFbQ5n5dlmzqCNQ3fR
         m6FV/1RH3UJLBWZDYWiuBCl+E5nxCXgdXnrtcraWUPKiXF0XxJug/LFcWR+wkpzZ/0AA
         GgmChBCjkrCP21ngU/ROySqVctnzP2I8nRl7FNKX1iEvWyAT9wP31CYcOxX7BwGAKfrm
         wGRdYjF5aEowjSag/xJ6FxF7DdEFK9h1B7vYsakG3Aulp++EKEUGP0/+PJs+2Nsc/b79
         Ahrw==
X-Gm-Message-State: AN3rC/6WDOr07oOaog67DUxo7hkqu1gB2ujEKAdHUL4dxkBtcmaBVl8k
        UjjvKlntNjMDdw==
X-Received: by 10.98.46.69 with SMTP id u66mr3975927pfu.262.1493806703409;
        Wed, 03 May 2017 03:18:23 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id q6sm3955076pfq.18.2017.05.03.03.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:18:22 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:18:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 04/21] wrapper.c: add warn_on_fopen_errors()
Date:   Wed,  3 May 2017 17:16:49 +0700
Message-Id: <20170503101706.9223-5-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 dir.c             |  3 +--
 git-compat-util.h |  2 ++
 wrapper.c         | 10 ++++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index f451bfa48c..8218a24962 100644
--- a/dir.c
+++ b/dir.c
@@ -745,8 +745,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 
 	fd = open(fname, O_RDONLY);
 	if (fd < 0 || fstat(fd, &st) < 0) {
-		if (errno != ENOENT)
-			warn_on_inaccessible(fname);
+		warn_on_fopen_errors(fname);
 		if (0 <= fd)
 			close(fd);
 		if (!check_index ||
diff --git a/git-compat-util.h b/git-compat-util.h
index bd04564a69..c5b59c23e8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1099,6 +1099,8 @@ int access_or_die(const char *path, int mode, unsigned flag);
 
 /* Warn on an inaccessible file that ought to be accessible */
 void warn_on_inaccessible(const char *path);
+/* Warn on an inaccessible file if errno indicates this is an error */
+int warn_on_fopen_errors(const char *path);
 
 #ifdef GMTIME_UNRELIABLE_ERRORS
 struct tm *git_gmtime(const time_t *);
diff --git a/wrapper.c b/wrapper.c
index d837417709..20c25e7e65 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -418,6 +418,16 @@ FILE *fopen_for_writing(const char *path)
 	return ret;
 }
 
+int warn_on_fopen_errors(const char *path)
+{
+	if (errno != ENOENT && errno != ENOTDIR) {
+		warn_on_inaccessible(path);
+		return -1;
+	}
+
+	return 0;
+}
+
 int xmkstemp(char *template)
 {
 	int fd;
-- 
2.11.0.157.gd943d85

