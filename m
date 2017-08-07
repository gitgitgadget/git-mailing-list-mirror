Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D0E208B4
	for <e@80x24.org>; Mon,  7 Aug 2017 18:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbdHGSV0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:21:26 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38267 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbdHGSVX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:21:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id y206so1898676wmd.5
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0TGk4gOMBG/J93GovELTJieEKk4kUx/+1LTD/ya60F0=;
        b=siidOib4xWOCStjw/O1zlYGrn8WWWy+0e+NPO4vxZqmuOWtntj8yvaesg7zmDFrqwh
         mgEdwY+LjvalH4DeQM60LR8BU1spOxWJ8ss1Swo9kKOEqRtxx95J/bA5WVV18UClDfGN
         Qot5zL6uTTdGSh4yl9QojqZm1EKm4cbW2DZeFDigDFqIjqNKGX74Zgph/rwOpgRglzsB
         4fRrW6JanigOFiY1FDVdkOF7oozWDn5OSCA+U7at7ZRrE5zaxMyUb37XnhmzEYtNk6qV
         J3KmoEVvek/f8yuGLgfVeHeHKRuX2g5pyJXq0sSrzhUXX+l7boCJWQSXB9QDc0kLw05c
         Lnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TGk4gOMBG/J93GovELTJieEKk4kUx/+1LTD/ya60F0=;
        b=Igsv9OlYc1fEEL5ihIay35y8p/SLP36kd5h0lM6tqgQK9ODRZOrtSgo+9bhcLwP+Wm
         hc+Qcqxn/iMIef7OWO+sagAWmqTatBXVaeVV50vRKofa4u3af5vt4bOOURvy715XNVsq
         a2Hc01wbIvgkw1PiekX5jt7Tf2iO6icrITGtQOhkoyPgqNRnQd8vr6UkVc8Ku54cBAiD
         EGNkFiHgkxeDFAxVnfRXL8LCiLsDipVBqtmdtqJcbADfLCbAI+9rwsVK5LhWfG7GcCT1
         MRHvca34/t22iBrlyKFlGtWLX+Fzo7VKMCJs0/CNqW7waVhaZdjzSQZWxSEed1667JGA
         J5zw==
X-Gm-Message-State: AHYfb5g+8KEs4CpLcRPELVw+pakw+6mXhgV0l+uRmy9NGKi09CoGXJwC
        YetliTCKvZVWlIvI
X-Received: by 10.28.20.65 with SMTP id 62mr1144792wmu.51.1502130081658;
        Mon, 07 Aug 2017 11:21:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id e27sm11519422wra.25.2017.08.07.11.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 11:21:20 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Dave Borowitz <dborowitz@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/6] config: introduce git_parse_maybe_bool_text
Date:   Mon,  7 Aug 2017 20:20:47 +0200
Message-Id: <c244a7bfd521f99d79d0eae67395ff1dd6cd01d1.1502128418.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.5.g0f7b1ed27
In-Reply-To: <cover.1502128418.git.martin.agren@gmail.com>
References: <cover.1502128418.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 9a549d43 ("config.c: rename git_config_maybe_bool_text and export
it as git_parse_maybe_bool", 2015-08-19) intended git_parse_maybe_bool
to be a replacement for git_config_maybe_bool, which could then be
retired. That is not obvious from the commit message, but that is what
the background on the mailing list suggests [1].

However, git_{config,parse}_maybe_bool do not handle all input the same.
Before the rename, that was by design and there is a caller in config.c
which requires git_parse_maybe_bool to behave exactly as it does.

Prepare for the next patch by renaming git_parse_maybe_bool to ..._text
and reimplementing the first one as a simple call to the second one. Let
the existing users in config.c use ..._text, since it does what they
need.

[1] https://public-inbox.org/git/xmqq7fotd71o.fsf@gitster.dls.corp.google.com/

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 config.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 231f9a750..7df57cec0 100644
--- a/config.c
+++ b/config.c
@@ -928,7 +928,7 @@ ssize_t git_config_ssize_t(const char *name, const char *value)
 	return ret;
 }
 
-int git_parse_maybe_bool(const char *value)
+static int git_parse_maybe_bool_text(const char *value)
 {
 	if (!value)
 		return 1;
@@ -945,9 +945,14 @@ int git_parse_maybe_bool(const char *value)
 	return -1;
 }
 
+int git_parse_maybe_bool(const char *value)
+{
+	return git_parse_maybe_bool_text(value);
+}
+
 int git_config_maybe_bool(const char *name, const char *value)
 {
-	int v = git_parse_maybe_bool(value);
+	int v = git_parse_maybe_bool_text(value);
 	if (0 <= v)
 		return v;
 	if (git_parse_int(value, &v))
@@ -957,7 +962,7 @@ int git_config_maybe_bool(const char *name, const char *value)
 
 int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
-	int v = git_parse_maybe_bool(value);
+	int v = git_parse_maybe_bool_text(value);
 	if (0 <= v) {
 		*is_bool = 1;
 		return v;
-- 
2.14.0.5.g0f7b1ed27

