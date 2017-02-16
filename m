Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52B2920136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754291AbdBPL3u (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:29:50 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35531 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbdBPL3s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:29:48 -0500
Received: by mail-lf0-f68.google.com with SMTP id v186so1219571lfa.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cOWZhvuZj+CnfxJxYpf5FBjIT7BUFJl3+NMzZGN/QT0=;
        b=Fb0Mdih/uyxsWh1fU71tL9JsOCUcvMpjNrlOdT3UheOg79lZFLHg3NwAbA3dTQObbo
         suxEUCs9sLN+nWfQg0w7Pz8ZGbrdAalojaZQBea4r0AvxdCmKljne5EmnGbHybFi7xaW
         bwt+Bptqj3zwsvLJwMPFMkFMKwPfuHDs+vPXVtRN4c1h2ZwViipWJGKZvlqjWUEo60nB
         lPp20HCw7FTYLswqZgAHy8+MCNjdhKhVmUYFtqVLWy0ARtlA98uoSDqkxMwnbGQ7qavf
         9Awp4cnjlkzIq4rlDGBxqnDsNxlgioAyHomzbzKvHHEPJv74nlezhY3TpgLt/Ne5+bKO
         YcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cOWZhvuZj+CnfxJxYpf5FBjIT7BUFJl3+NMzZGN/QT0=;
        b=QNeP0+HPtGj8NdRIkObjMVJb5I3pEqr77f2zDd8XF1SA7UsOgDd9zVdsCd90xzJ/1r
         CtLduHGdpGJWNIx29nOvluQUOzy1C6N4E/HHx8riOhb2l2TlFmvRgkh/ejFR0dtyUEkx
         DT4c9JWBTjL63Tgof0RklSqGFtbVyoqIu/fsHFsLN28vYr/XNEedO439lubU09xbo/V2
         4HNNBe7c5YOWWACdWVS8qT+C/Dag1DLu6xOceDQa1SZkDQxaMM4Cby/BtsFrCHjEQBRE
         eVGBi/NCe0ocNyZNf3DFodAMQBrco3a5mwRme65rhJ1frsumC4MqmL+XrwlxZkYmprKK
         DiKw==
X-Gm-Message-State: AMke39mhQqoqtJmlh2uMzj/NsM2I4DUUpzltsuTxr2JFPXkAkrb1Z0JaMX5ir+v35k87Lg==
X-Received: by 10.46.88.85 with SMTP id x21mr534240ljd.90.1487244586251;
        Thu, 16 Feb 2017 03:29:46 -0800 (PST)
Received: from localhost.localdomain ([193.106.40.78])
        by smtp.gmail.com with ESMTPSA id v3sm1641430ljd.65.2017.02.16.03.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:29:45 -0800 (PST)
From:   Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Subject: [PATCH 1/3] add git_psprintf helper function
Date:   Thu, 16 Feb 2017 14:28:27 +0300
Message-Id: <20170216112829.18079-2-franchesko.salias.hudro.pedros@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170216112829.18079-1-franchesko.salias.hudro.pedros@gmail.com>
References: <20170216112829.18079-1-franchesko.salias.hudro.pedros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a number of places in the code where we call
xsnprintf(), with the assumption that the output will fit into
the buffer. If the buffer is small, then git die.
In many places buffers have compile-time size, but generated string
depends from current system locale (gettext)and can have size
greater the buffer.
Just run "LANG=ru_RU.UTF8 git bisect start v4.9 v4.8"
on linux sources - it impossible.

git_psprintf is similar to the standard C sprintf() function
but safer, since it calculates the maximum space required
and allocates memory to hold the result.
The returned string should be freed with free() when no longer needed.

Signed-off-by: Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
---
 git-compat-util.h |  3 +++
 wrapper.c         | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 87237b092..fa98705d0 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -878,6 +878,9 @@ static inline size_t xsize_t(off_t len)
 	return (size_t)len;
 }
 
+__attribute__((format (printf, 1, 2)))
+extern char *git_psprintf(const char *fmt, ...);
+
 __attribute__((format (printf, 3, 4)))
 extern int xsnprintf(char *dst, size_t max, const char *fmt, ...);
 
diff --git a/wrapper.c b/wrapper.c
index e7f197996..deee46d2d 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -635,6 +635,25 @@ char *xgetcwd(void)
 	return strbuf_detach(&sb, NULL);
 }
 
+char *git_psprintf(const char *fmt, ...)
+{
+	va_list ap;
+	int len;
+	char *dst;
+
+	va_start(ap, fmt);
+	len = vsnprintf(NULL, 0, fmt, ap);
+	va_end(ap);
+
+	dst = xmallocz(len);
+
+	va_start(ap, fmt);
+	vsprintf(dst, fmt, ap);
+	va_end(ap);
+
+	return dst;
+}
+
 int xsnprintf(char *dst, size_t max, const char *fmt, ...)
 {
 	va_list ap;
-- 
2.11.1

