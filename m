Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2F451F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeBXAsz (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:55 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44519 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752445AbeBXAsW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:22 -0500
Received: by mail-pl0-f65.google.com with SMTP id w21so5842971plp.11
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qyW7tm1PnOqJ6Ztca4ce9aMfO8ny/I4JZj/bWN9yr08=;
        b=plDwzpnprRkEjsMKWvgFA0/VME1TOaWYUNfT7cO0A38F8ScrOBI+x/xiKfT2cTKa6c
         3BoFAqyZVkDSVyeKY4EcnryTaulzDUuPI0h0tpUSPAzxRteEoOlXYFca9G00hCy8RcpY
         slni7dPMzVq143b+HW3Smj1lMtRM02ek68wuUdG7BnA+UR48A4150NV6PRBk0warFaK1
         MzSR+TVLzV75P1/ybgy9cVpJPN522Bhn9ke8aMZZK79ZuCRs6C0njreN5I3PNU+EbaRO
         1EfcS6fDNn54Jn2oxvy1YPXRDI1jjib7pXpzHUeJF11P4afaPS7pzhxoxmZeXcJQOwwH
         eZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qyW7tm1PnOqJ6Ztca4ce9aMfO8ny/I4JZj/bWN9yr08=;
        b=D0gJ9+TbSnJsQEeQXODDqDOS1qHRBz2rSs6KBEcUbWnKaTjgE0UPCPKz6AcOA7+76h
         OWaAfh6ytTPRuJ5pAAMac+DqGhwoauULUSHL0MN2+QeP0IZXNqnpP0sWytejZD3eF5+u
         Xo3vhEtQoKXua9nDu+YpDDr6CnSMm//3wr3byjWDvOtx6R8noFtANVmVVH0/o+u2V5pX
         kwtg2solY20U14ZQ11B1D7DaOkst9+mbTbns8p/JQJZf18prbfNQZm6Nag+oALi8/nv5
         yuRBjmufueKjFfM66FGzSO4Us8Yk6ZqjNHPIOqOVH9FaKOJ43ff0FtKqolz7JN0WxqwZ
         Jofg==
X-Gm-Message-State: APf1xPBF2se1IGB3kgeb9nsnktUmLnaKQG0HEb2sP5osaQS2wO4GEtQS
        UNrYw10pgYx8zUKqan6a7Zrsfw==
X-Google-Smtp-Source: AH8x227KRQ/MZZKsTfOnD9PAzYfBs780IUd+nh9l6Gut5ozwZi/iNx7Z5gviYpLtKd+MvVfElI6ZmQ==
X-Received: by 2002:a17:902:7c11:: with SMTP id x17-v6mr3393104pll.59.1519433301958;
        Fri, 23 Feb 2018 16:48:21 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p9sm5501238pgs.35.2018.02.23.16.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:21 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 17/27] sha1_file: add repository argument to stat_sha1_file
Date:   Fri, 23 Feb 2018 16:47:44 -0800
Message-Id: <20180224004754.129721-18-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the stat_sha1_file caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8ef2f856035..b7e6e4a9bfc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -869,8 +869,9 @@ int git_open_cloexec(const char *name, int flags)
  * Note that it may point to static storage and is only valid until another
  * call to sha1_file_name(), etc.
  */
-static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
-			  const char **path)
+#define stat_sha1_file(r, s, st, p) stat_sha1_file_##r(s, st, p)
+static int stat_sha1_file_the_repository(const unsigned char *sha1,
+					 struct stat *st, const char **path)
 {
 	struct alternate_object_database *alt;
 	static struct strbuf buf = STRBUF_INIT;
@@ -1176,7 +1177,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(sha1, &st, &path) < 0)
+		if (stat_sha1_file(the_repository, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
@@ -1390,7 +1391,7 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		die("replacement %s not found for %s",
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
 
-	if (!stat_sha1_file(repl, &st, &path))
+	if (!stat_sha1_file(the_repository, repl, &st, &path))
 		die("loose object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), path);
 
-- 
2.16.1.291.g4437f3f132-goog

