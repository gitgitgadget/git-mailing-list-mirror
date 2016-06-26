Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4FF61FE4E
	for <e@80x24.org>; Sun, 26 Jun 2016 07:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbcFZHHK (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 03:07:10 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33973 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbcFZHHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 03:07:09 -0400
Received: by mail-lf0-f48.google.com with SMTP id h129so138784898lfh.1
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 00:07:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BLmE8WFTSZIR2rZ+YiiyQpzfqES0r8wS8lwAdCTe8Kg=;
        b=RDDUfBp/OXp+6sfufRYkWBzQqz8dV1HXVlTqimyHaJOJL1JlfPVGKpzWo+yhK9MII2
         r3KdJyvMDXkDs2jSSXvAWdndlXR/sYUDtmbegNEOe/uqmt3+uu5UBOIkWq/Q/Cx2o6+7
         Q1lkR146Go7D2xPLejqnp0AEK24pztLhYrzyfJ/E7OHvyNUE/ht5Jxf7zr4gPn+o0efV
         EYiqF6RdCahIu1irleU6cC/odCznZDsuUaDsEKnAAdXFWMV/zGOofmUu3lu9ONOgqU9z
         alJW+hMh11jTK7HAdqfA/cG+Cy9cIIqWt5lqn4tZzMp04Y0NSWyK2oKVgBc4ddi66FUt
         hU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BLmE8WFTSZIR2rZ+YiiyQpzfqES0r8wS8lwAdCTe8Kg=;
        b=Maro+6slTYlfl+ewTRMQ68GSxiNBVBjW8YWlmUC1QTjm2FFFem81ykBW8Rpad/N+MO
         4oVy76SU/0+gvY7fDvX5jBAoNg3JGJ4/3s1gC9w6/dQ+u0LEv+MKEXU/0jSjfuJyxdTw
         cDAYw0R+nl4Gj7Zta3sgauSoaNYzFM+VqJMedOo8bIxaxpFR9M0Mc3rQ7O2Xu1w8Jt8l
         Ac4BigvxGQVSDpuBQOTO56fYDKGVSKDDRJURv6aEMWrtPNysKVsPoAoggEKQIqxlICAM
         mBQM6CJ4Cqq0psFz1YsJcOC7ERxFq7v32vGlK4A/kxdkcqXqvDDLwpZ53nyrXOwEMHPG
         /vrQ==
X-Gm-Message-State: ALyK8tKtHJdd2VyjhMoncj6Fg2gsUV5rNNKVAVqqNg1BRLYp7QbCDwTtYGKfUNlprMYGQw==
X-Received: by 10.25.41.83 with SMTP id p80mr3872566lfp.32.1466924827306;
        Sun, 26 Jun 2016 00:07:07 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s18sm2231965lfd.30.2016.06.26.00.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 00:07:06 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	sschuberth@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] config: add conditional include
Date:	Sun, 26 Jun 2016 09:06:17 +0200
Message-Id: <20160626070617.30211-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If the path argument in "include" starts with "gitdir:", it is
followed by a wildmatch pattern. The include is only effective if
$GIT_DIR matches the pattern. This is very useful to add configuration
to a group of repositories.

For convenience

 - "~" is expanded to $USER

 - if the pattern ends with '/', "**" will be appended (e.g. foo/
   becomes foo/**). In other words, "foo/" automatically matches
   everything in starting with "foo/".

 - if the pattern contains no slashes, it's wrapped around by "**/"
   and "/**" (e.g. "foo" becomes "**/foo/**"). In other words, "foo"
   matches any directory component in $GIT_DIR.

The combination of the first two is used to group repositories by
path. While the last one could be used to match worktree's basename.

This code is originally written by Jeff King [1]. All genius designs
are his. All bugs are mine (claiming bugs is just more fun :).

[1] http://thread.gmane.org/gmane.comp.version-control.git/273811/focus=273825

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Original thread is [1]. Sebastian may not need it but I do and not
 just for user.* stuff. So I'm bringing it back. I deleted Jeff's
 de-anchoring and replaced with something a bit more restrictive. Once
 we settle that, I'll add tests and stuff.

 config.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index f51c56b..dd55a5f 100644
--- a/config.c
+++ b/config.c
@@ -140,9 +140,58 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	return ret;
 }
 
+static int include_condition_is_true(const char *cond, int cond_len)
+{
+	const char *value;
+
+	/* no condition (i.e., "include.path") is always true */
+	if (!cond)
+		return 1;
+
+	/*
+	 * It's OK to run over cond_len in our checks here, as that just pushes
+	 * us past the final ".", which cannot match any of our prefixes.
+	 */
+	if (skip_prefix(cond, "gitdir:", &value)) {
+		struct strbuf text = STRBUF_INIT;
+		struct strbuf pattern = STRBUF_INIT;
+		char *buf;
+		int ret;
+
+		strbuf_add_absolute_path(&text, get_git_dir());
+
+		strbuf_add(&pattern, value, cond_len - (value - cond));
+		buf = expand_user_path(pattern.buf);
+		if (buf) {
+			strbuf_reset(&pattern);
+			strbuf_addstr(&pattern, buf);
+			free(buf);
+		}
+
+		if (pattern.len && pattern.buf[pattern.len - 1] == '/') {
+			/* foo/ matches recursively */
+			strbuf_addstr(&pattern, "**");
+		} else if (!strchr(pattern.buf, '/')) {
+			/* no slashes match one directory component */
+			strbuf_insert(&pattern, 0, "**/", 3);
+			strbuf_addstr(&pattern, "/**");
+		}
+
+		ret = !wildmatch(pattern.buf, text.buf, 0, NULL);
+		strbuf_release(&pattern);
+		strbuf_release(&text);
+		return ret;
+	}
+
+	/* unknown conditionals are always false */
+	return 0;
+}
+
 int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
+	const char *cond, *key;
+	int cond_len;
 	int ret;
 
 	/*
@@ -153,8 +202,12 @@ int git_config_include(const char *var, const char *value, void *data)
 	if (ret < 0)
 		return ret;
 
-	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(value, inc);
+	if (!parse_config_key(var, "include", &cond, &cond_len, &key) &&
+	    include_condition_is_true(cond, cond_len)) {
+		if (!strcmp(key, "path"))
+			ret = handle_path_include(value, inc);
+		/* else we do not know about this type of include; ignore */
+	}
 	return ret;
 }
 
-- 
2.8.2.526.g02eed6d

