Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EEA91F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeCWRWC (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:02 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34078 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeCWRVy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:54 -0400
Received: by mail-lf0-f67.google.com with SMTP id c78-v6so14702996lfh.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ie3h4iPXl6fegoz3pR8/+kl63tS85hmqcaJSZr3thwY=;
        b=nFvHSeFg6FUNG+QhloD56XXataEGOLn63csriKbxt2Myl0VwSho1Hxi0koJhKIUhEX
         WjCce76T9ub4XwOIlnaJuaYEUAhBmANxVgNub2teULg5Q3+PlXjUHLtMaUGVRQOS6EVa
         GvkVM37npkAHQNWyadrFxQO1fDh5MPwelsBD4mYaGpBkZP95q4Z5VZUkX93gJQY1ysKM
         gT3sxmoJuKCK28q+bOvmQM5k7MceXMyeNVg8f3H/o35xdo3m3hE2fZjOWpUo/seWQS+7
         86/1csTtZJlH3KXt6BVj7GwJ0hVL+aXXb++gZx2o7ZUBoNdooSckanakkpDHb/n3hRry
         rsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ie3h4iPXl6fegoz3pR8/+kl63tS85hmqcaJSZr3thwY=;
        b=nuW4KWjEHro+Rbyx/rBnCwjjG7toPA9FSXlxFvC9EuOZ6EU8UZz+Kl/31TOAWqgL/r
         ar/xZXmVhxaWsZg5++VlGC1idNOkhHikFG90CF3cM4ZWzgkSB5umrOXGkrPVN0reH1dk
         QC6IQR8sznQbBy12F+WIySyhTnwU5OuVDWmwxjDX03k3c5QBJmxootzvzo5H/8i1yWTc
         PqJOyhNV5uBJCrKJfysVcVSAGsFFmTO/5iTSUPOAgnICU6z9xS+8oZZVM20eelT85n8Y
         1SVtt2e9ewayM6pwTzDkO83gTTIINkKncuRVICWhpfyy17F7tHf4XwHSvMfVK10qfjID
         ceGw==
X-Gm-Message-State: AElRT7E24Q228Ko8m4Shaj2rBX5eJISKEKwqZ+EH/iQJgR3A310uR1eV
        at2ft/CwVwLGSWI8uu1AYUONZQ==
X-Google-Smtp-Source: AG47ELtHqGxPCc78rONRdy4PW1Qhbpq8RzAO3d8/bpKHrzJwNzq0FuRWgJRKx77gULUboPrMlaz1qg==
X-Received: by 10.46.151.136 with SMTP id y8mr12218549lji.84.1521825712905;
        Fri, 23 Mar 2018 10:21:52 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:52 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/27] sha1_file: add repository argument to link_alt_odb_entry
Date:   Fri, 23 Mar 2018 18:21:04 +0100
Message-Id: <20180323172121.17725-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Add a repository argument to allow the link_alt_odb_entry caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Since the implementation does not yet work with other repositories,
use a wrapper macro to enforce that the caller passes in
the_repository as the first argument. It would be more appealing to
use BUILD_ASSERT_OR_ZERO to enforce this, but that doesn't work
because it requires a compile-time constant and common compilers like
gcc 4.8.4 do not consider "r == the_repository" a compile-time
constant.

This and the following three patches add repository arguments to
link_alt_odb_entry, read_info_alternates, link_alt_odb_entries
and prepare_alt_odb. Three out of the four functions are found
in a recursive call chain, calling each other, and one of them
accesses the repositories `objectdir` (which was migrated; it
was an obvious choice) and `ignore_env` (which we need to keep in
the repository struct for clarify); hence we will pass through the
repository unlike just the object store object + the ignore_env flag.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 097c372d03..7c0ace646a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -391,8 +391,9 @@ static int alt_odb_usable(struct raw_object_store *o,
  * terminating NUL.
  */
 static void read_info_alternates(const char * relative_base, int depth);
-static int link_alt_odb_entry(const char *entry, const char *relative_base,
-	int depth, const char *normalized_objdir)
+#define link_alt_odb_entry(r, e, rb, d, n) link_alt_odb_entry_##r(e, rb, d, n)
+static int link_alt_odb_entry_the_repository(const char *entry,
+	const char *relative_base, int depth, const char *normalized_objdir)
 {
 	struct alternate_object_database *ent;
 	struct strbuf pathbuf = STRBUF_INIT;
@@ -489,7 +490,8 @@ static void link_alt_odb_entries(const char *alt, int sep,
 		alt = parse_alt_odb_entry(alt, sep, &entry);
 		if (!entry.len)
 			continue;
-		link_alt_odb_entry(entry.buf, relative_base, depth, objdirbuf.buf);
+		link_alt_odb_entry(the_repository, entry.buf,
+				   relative_base, depth, objdirbuf.buf);
 	}
 	strbuf_release(&entry);
 	strbuf_release(&objdirbuf);
-- 
2.17.0.rc0.348.gd5a49e0b6f

