Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F15D20373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbdCMUn6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:43:58 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34608 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdCMUn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:43:57 -0400
Received: by mail-qk0-f195.google.com with SMTP id v125so38504822qkh.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VLejMEo2mG/use/cthL/qHx7/JzeIvZVY/DZ0LUwLvE=;
        b=Sc6e2WYlnZz09Zt2gSg3or5Zy2+SmnwvQYQiE9m9eEbtrms5GbwMzeq7Lm57811xs1
         ySCOpDhGiaCJ60tcgZATZEYY/WcQU5AHzLAAho5pWJ81U8ZoqyagNCY8UrifVslT91zi
         UAxOEv7oEVQO/0yFaRpmcssgk3At1GeQSR2k3i9hIqRi5rbnMT+ldYWGijJe3azG5QHu
         7AnTlwalCQRZ/4OBZQJ89nNZTcNWSD/IJ3X39xW6tc5cCwJYWEa/69xEcRMfCZPz0Zrh
         8QhcJE32NBHmdEOlRjOBwi+zTMHy0laLvFDhBAaEl4JKlRw4O+bi2x4foNzAtgLyFX66
         L2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VLejMEo2mG/use/cthL/qHx7/JzeIvZVY/DZ0LUwLvE=;
        b=l/lDi1Xbhy7isFt2I1RDZrM5/Iw9OpYJcCTXxqFM4DF193gKSecYlsmwvzPI3IWGS6
         vYV0F9q9jN93xfgEark3OWNZAQ+uTs2Vl7c8dGTvIXj8Xe/KOW/PTrchay1UwGFuaf/W
         8Ykhqkml1pYFiovJzq8LfmUOlTwHwGNXxm/cy9tIQoIm+SgAgLlDJ6cSufrl93Gd+9m9
         88marspXw6b1ztmoQdVlF3XIOS5xHupYD5IQuF3Tt7mwFJycTJaPUVIiCj3GbqzKsmNT
         JD4v4xZx/g/6PuzCDvFheytQcDHxIxbnHqB1ZwfqSl4reunKEkx+dIjM5PCCIQB83TED
         e18g==
X-Gm-Message-State: AFeK/H0la1PW23qLGTZESqhdcX8pKcRdrgqRkHPrItX/l8gFSPMfIy0nWqBMm773CJf4GA==
X-Received: by 10.55.221.1 with SMTP id n1mr32030732qki.221.1489437836124;
        Mon, 13 Mar 2017 13:43:56 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-329.cit.cornell.edu. [128.84.125.73])
        by smtp.googlemail.com with ESMTPSA id p19sm12952657qtp.36.2017.03.13.13.43.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 13:43:55 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com
Cc:     git@vger.kernel.org
Subject: [GSoC][PATCH v2 1/2] path.c: add xdg_cache_home
Date:   Mon, 13 Mar 2017 16:43:54 -0400
Message-Id: <20170313204355.56559-1-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170313172232.96678-4-lehmacdj@gmail.com>
References: <20170313172232.96678-4-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have xdg_config_home to format paths relative to
XDG_CONFIG_HOME. Let's provide a similar function xdg_cache_home to do
the same for paths relative to XDG_CACHE_HOME.

Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
---
 cache.h |  7 +++++++
 path.c  | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/cache.h b/cache.h
index 8c0e64420..378a636e1 100644
--- a/cache.h
+++ b/cache.h
@@ -1169,6 +1169,13 @@ extern int is_ntfs_dotgit(const char *name);
  */
 extern char *xdg_config_home(const char *filename);
 
+/**
+ * Return a newly allocated string with the evaluation of
+ * "$XDG_CACHE_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
+ * "$HOME/.config/git/$filename". Return NULL upon error.
+ */
+extern char *xdg_cache_home(const char *filename);
+
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
 #define LOOKUP_UNKNOWN_OBJECT 2
diff --git a/path.c b/path.c
index efcedafba..22248436b 100644
--- a/path.c
+++ b/path.c
@@ -1272,6 +1272,21 @@ char *xdg_config_home(const char *filename)
 	return NULL;
 }
 
+char *xdg_cache_home(const char *filename)
+{
+	const char *home, *cache_home;
+
+	assert(filename);
+	cache_home = getenv("XDG_CACHE_HOME");
+	if (cache_home && *cache_home)
+		return mkpathdup("%s/git/%s", cache_home, filename);
+
+	home = getenv("HOME");
+	if (home)
+		return mkpathdup("%s/.cache/git/%s", home, filename);
+	return NULL;
+}
+
 GIT_PATH_FUNC(git_path_cherry_pick_head, "CHERRY_PICK_HEAD")
 GIT_PATH_FUNC(git_path_revert_head, "REVERT_HEAD")
 GIT_PATH_FUNC(git_path_squash_msg, "SQUASH_MSG")
-- 
2.11.0

