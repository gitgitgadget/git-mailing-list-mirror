Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11CC820248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDFLhs (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:37:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38870 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfDFLhr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:37:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so4766902pfo.5
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vod4aOH+wA+JD7yNprXuqsVCLUsUss9P8ReeepwUd1o=;
        b=I5qgV6S0tIHK6xshYlwauSiDpgESTS22vAbQTQ2pn893l3hl+G6FOamCMsn5R9nz6S
         cQ1iXt/UG/AWLzthu02P0BBYarx/khXr78FtuL5JUN/FGamjlS3A7h+u14FvsZDiWHox
         4L62JVWABSn7Rv1GsSq35biWf5znVbYpKTBfiktubW9DlsrUOq7EDtp1Eny7g+QRkYXz
         EBTkgq6+zkC0mGpmwGC+kBWxm6UnsmNh3Jd6k72XsnDV4tszWO3VQYu5DyeNIYgPTnkk
         Wr7LqETL7VrbE9iyGfDBygVBS6XsdWgKF8zXglpEULldofHhPEJb9sfjS95bbONg7oTK
         1vcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vod4aOH+wA+JD7yNprXuqsVCLUsUss9P8ReeepwUd1o=;
        b=JIl3s4SQSP88BnSJwio0pKyv9SlPEi5gEqGHj8l5GQdBofPw4AGN5Kot9WC0Zk0uFl
         mWpgc10G6VEx5XecUmc9TV/a9eaRTEblHf2JEqWuVt9vTF244mQbxkIpt6EPhTGIAvPf
         HpUMFSKVmIow14OVfUflsnh91TQ97MtNRObgeR15KYYJGTMZk+DFX//oxMnuQvIY1Twx
         C0ppjGQ22gQ3CRTZrDRrrgBVzWaz8EShOTsUReEKwaBhTx2+Kd9y7W0TRRwCgaEieVX8
         uqLBsrHR58CIJtJ7QZD6J/D4rE5pXkBpNBSF0DCO8QlY3sx4ZJZXg35MuLGPAlfmNqLa
         YcLA==
X-Gm-Message-State: APjAAAUzwE6yOuoaGW7OzsrU/Tn+qZ2AY+pTrdllKv91+4n+RpMkF8+5
        1dmtnozVoyPtoltcZseftcs=
X-Google-Smtp-Source: APXvYqz7Q6YrMLb/Bfa8CllZind5zribSfPcfaUZpzZ1dbuTsK3qhgGloWrzKfecPzE+lGkdlPrLZg==
X-Received: by 2002:a63:2b03:: with SMTP id r3mr17167297pgr.105.1554550667230;
        Sat, 06 Apr 2019 04:37:47 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id f2sm7556332pgc.30.2019.04.06.04.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:37:46 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:37:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 28/33] sha1-name.c: remove the_repo from get_oid_with_context_1()
Date:   Sat,  6 Apr 2019 18:34:48 +0700
Message-Id: <20190406113453.5149-29-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sha1-name.c b/sha1-name.c
index 6b53ea2eeb..64a50d1291 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "repository.h"
+#include "submodule.h"
 #include "midx.h"
 #include "commit-reach.h"
 
@@ -1797,7 +1798,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			oc->path = xstrdup(cp);
 
 		if (!repo->index->cache)
-			repo_read_index(the_repository);
+			repo_read_index(repo);
 		pos = index_name_pos(repo->index, cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
@@ -1842,6 +1843,14 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			new_filename = resolve_relative_path(repo, filename);
 			if (new_filename)
 				filename = new_filename;
+			/*
+			 * NEEDSWORK: Eventually get_tree_entry*() should
+			 * learn to take struct repository directly and we
+			 * would not need to inject submodule odb to the
+			 * in-core odb.
+			 */
+			if (repo != the_repository)
+				add_to_alternates_memory(repo->objects->odb->path);
 			if (flags & GET_OID_FOLLOW_SYMLINKS) {
 				ret = get_tree_entry_follow_symlinks(&tree_oid,
 					filename, oid, &oc->symlink_path,
-- 
2.21.0.479.g47ac719cd3

