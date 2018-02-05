Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C75D1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeBEX4B (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:56:01 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33050 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBEXzp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:45 -0500
Received: by mail-pl0-f67.google.com with SMTP id t4so93345plo.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bDwgb2fvGSZKF6hljuS8PWI99gPa5Ef2PIDJEgnoZJQ=;
        b=DnvxGaxzStmTAnSxhyJDX+DbS8MiuZdHri2nUxWJbY6GiilJc9m76IzWmncCTJVU8B
         7HnQwz1G2Wtm8Ilk7t+pixCPV9U/xOzCxTjuhUtlzWQknU9HgxJD4hLk5H6lvm+hDTQe
         CRePufiS5cIgCZI1tHWFQaieWA3O1PwCfgiInqOc2/nGx2smzVAi+KNeGrgR44EBim6G
         DGBl1VLBjchTaJ8GFx19ckJRmO6CXMcMbnEx8VDRQeLq3IyyyXjH9qcxmxfiyqstS6i+
         aKUErWZZXGo0Y3LDfHD9ady7bISbMelwOHa2tXeI7TouNPIUmygfbTZFgxByrsiESjz3
         TuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bDwgb2fvGSZKF6hljuS8PWI99gPa5Ef2PIDJEgnoZJQ=;
        b=bSdyeq4LjGjS5MgY4c238mSR4o5QDoxoTNua0XVxOKXmTiD/LxeJwF39511R39j88Q
         4h4P1I1biBCRgJGI0ehS2eLxW6YQVPXNfFuKEUb23wjwhoY3gGTgbwm+reMlWmlb5DAi
         wxK0zIOh1AnI7cg0KNoTJXNOiejYKhK21REeBcZZBh23rGvWuoLbuGKg7jx79ngAF4Eu
         A0qvsf+V7SxUaKfC1+vKdxFJf8P81g5ea5cg4aSRcOayxu4eAizjlxVP41yA6rivCZ6u
         Oc7/LsvN9jMzt16SLA8TCC3gwCRVsM8PiZlyg5bajGGXi8iMXFlNMpwnEKVnLnMaHx2G
         dC9Q==
X-Gm-Message-State: APf1xPDcrUzUQa3Q5CJjTDDTkWAMDS2A60tTh3bIehc9nO2P/U+jb8+v
        oo+g89KLuN3g3x67J/HPwOTm6JCFiwg=
X-Google-Smtp-Source: AH8x226hoxPoKWYkrW+HHs4CRcOAknQnClvbn6k52dRGs6PeiVVJUaleooXcbDmPc3PNkFOmp6mOmA==
X-Received: by 2002:a17:902:7b81:: with SMTP id w1-v6mr463380pll.295.1517874945032;
        Mon, 05 Feb 2018 15:55:45 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id q65sm14389998pfi.115.2018.02.05.15.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:44 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 009/194] sha1_file: add repository argument to link_alt_odb_entries
Date:   Mon,  5 Feb 2018 15:52:03 -0800
Message-Id: <20180205235508.216277-10-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the link_alt_odb_entries caller to
be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index acb00b9680..d9f9046f31 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -471,8 +471,12 @@ static const char *parse_alt_odb_entry(const char *string,
 	return end;
 }
 
-static void link_alt_odb_entries(const char *alt, int sep,
-				 const char *relative_base, int depth)
+#define link_alt_odb_entries(r, a, s, rb, d) \
+	link_alt_odb_entries_##r(a, s, rb, d)
+static void link_alt_odb_entries_the_repository(const char *alt,
+						int sep,
+						const char *relative_base,
+						int depth)
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
 	struct strbuf entry = STRBUF_INIT;
@@ -515,7 +519,7 @@ static void read_info_alternates_the_repository(const char *relative_base,
 		return;
 	}
 
-	link_alt_odb_entries(buf.buf, '\n', relative_base, depth);
+	link_alt_odb_entries(the_repository, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
@@ -569,7 +573,8 @@ void add_to_alternates_file(const char *reference)
 		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
 		if (the_repository->objects.alt_odb_tail)
-			link_alt_odb_entries(reference, '\n', NULL, 0);
+			link_alt_odb_entries(the_repository, reference,
+					     '\n', NULL, 0);
 	}
 	free(alts);
 }
@@ -582,7 +587,8 @@ void add_to_alternates_memory(const char *reference)
 	 */
 	prepare_alt_odb();
 
-	link_alt_odb_entries(reference, '\n', NULL, 0);
+	link_alt_odb_entries(the_repository, reference,
+			     '\n', NULL, 0);
 }
 
 /*
@@ -685,7 +691,8 @@ void prepare_alt_odb(void)
 
 	the_repository->objects.alt_odb_tail =
 			&the_repository->objects.alt_odb_list;
-	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
+	link_alt_odb_entries(the_repository, alt,
+			     PATH_SEP, NULL, 0);
 
 	read_info_alternates(the_repository, get_object_directory(), 0);
 }
-- 
2.15.1.433.g936d1b9894.dirty

