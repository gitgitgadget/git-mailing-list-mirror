Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14AED1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeCWRWt (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40899 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbeCWRV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:58 -0400
Received: by mail-lf0-f67.google.com with SMTP id e5-v6so19403799lfb.7
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dvuz44orehHeNXHJkSo/Fuh6MNuQP78Etpnq57ybLV0=;
        b=IKP9k5f7H5QblINQg0Iels8CVkLayycPR1ESMy3riSRdezJHwvpe598tMlIAVn1a8H
         L7GXtwp+HTpRg4q00WsvKXh56e0zZ0UFEXdOCdvuSaOj2vQl4OAlgGGQ2MnknplExRXM
         +Q0BcATrqAD3FrLR5Mz/H0/vRgmeHNC7jcZM+8LcX4LXUCgwxm36Q1oGerF9QFUSwpo0
         rw/J74oSAuRYROO3MLGQW9aPE3LyKx6f1xodT+VG8RJRSEgdZHHq7gR7gLuKnzAHynOX
         I0fA+lSVNVWnpV/uRnkeYXYAhbbOQyzHn7mnIrNiQkZFj2ivqg9lNijLnkOeMrtc/C0G
         k44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dvuz44orehHeNXHJkSo/Fuh6MNuQP78Etpnq57ybLV0=;
        b=GNqDhrBSIcpazqWGtbE+sWUmiLA0nesg8IZRxyxU2ij0I8sLs9ksSyClM0M/D04+ql
         lqShQp7gM+HAHyZdx9gO3k7QK5ZUejFL2Yyp9Tx6zj1rnYitVNlzMIi3LLKi8ff2g/+t
         B8ZXQuf1+HHUbTNtIivvLlUQbTZ61YaxQszgN1SdxbBuri0vyCStbtBKdkvF3/u2QJ70
         by52uYmbjEoW0BJY8T4kSKpTJUWmQ+6oz7GT8kybxdS+c4KUyXEHTTf3BaaCRN/P9wFy
         gUXbNUiCYcdC9LZGVmrOAnZXixY7dpccIdW5u+eEokvwoEGxU74EFfo10g3kUvr46q9+
         wPHw==
X-Gm-Message-State: AElRT7HUVn/X9xlGILh1ppidqYkchxPmpMrocr5/3snlxngdI6KnCB51
        6aAlWM52s50gVEBoL+a0iNoHgw==
X-Google-Smtp-Source: AG47ELv2o72+4w6Xk1NBml/+uHkCw+/w3rEo53za42xddLHJbKqnWXPS+ZuwA7Hkf1yq+gCDqOWx+g==
X-Received: by 2002:a19:ef08:: with SMTP id n8-v6mr18927945lfh.1.1521825715475;
        Fri, 23 Mar 2018 10:21:55 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:54 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/27] sha1_file: add repository argument to link_alt_odb_entries
Date:   Fri, 23 Mar 2018 18:21:06 +0100
Message-Id: <20180323172121.17725-13-pclouds@gmail.com>
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

See previous patch for explanation.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1_file.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 81ad2a84f2..ba4fc9103b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -468,8 +468,12 @@ static const char *parse_alt_odb_entry(const char *string,
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
@@ -512,7 +516,7 @@ static void read_info_alternates_the_repository(const char *relative_base,
 		return;
 	}
 
-	link_alt_odb_entries(buf.buf, '\n', relative_base, depth);
+	link_alt_odb_entries(the_repository, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
@@ -566,7 +570,8 @@ void add_to_alternates_file(const char *reference)
 		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
 		if (the_repository->objects->alt_odb_tail)
-			link_alt_odb_entries(reference, '\n', NULL, 0);
+			link_alt_odb_entries(the_repository, reference,
+					     '\n', NULL, 0);
 	}
 	free(alts);
 }
@@ -579,7 +584,8 @@ void add_to_alternates_memory(const char *reference)
 	 */
 	prepare_alt_odb();
 
-	link_alt_odb_entries(reference, '\n', NULL, 0);
+	link_alt_odb_entries(the_repository, reference,
+			     '\n', NULL, 0);
 }
 
 /*
@@ -678,7 +684,8 @@ void prepare_alt_odb(void)
 
 	the_repository->objects->alt_odb_tail =
 			&the_repository->objects->alt_odb_list;
-	link_alt_odb_entries(the_repository->objects->alternate_db,
+	link_alt_odb_entries(the_repository,
+			     the_repository->objects->alternate_db,
 			     PATH_SEP, NULL, 0);
 
 	read_info_alternates(the_repository, get_object_directory(), 0);
-- 
2.17.0.rc0.348.gd5a49e0b6f

