Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DF7520248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfDCLhe (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:37:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40086 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCLhd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:37:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so8026812pfc.7
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vod4aOH+wA+JD7yNprXuqsVCLUsUss9P8ReeepwUd1o=;
        b=gM//HBHwSpGDsu10L6vYBKxP3cBSbMiLAKl6kvHixVgiTlFDOjKOEslCCApNjEmQ9P
         muOW/L1Ya5ulBQHxmQqR4W4iiJ3PGo+9g38KC5WE8VdwSUIc8xkGuqmEGHPCVh9EQCcx
         diZvFirFnCCMxJpdk1pr1rTIhWjqojTwCCoYJAGKZi2eZ2Xz1w+s3w2wIkMt8shUGkK9
         MJ7DrhXfN+3+U2ZyNTom/jivPl+oP11ILWQvT5kJ108E/in8I8bYXBT88ScAD2ELGTEl
         aVDPmkh6gXocOH8qdK/TYUaIlJ6URAnGEt9EoRP8gxTzNXAVzwGP5G8Fn1IB4CMKhYyO
         85Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vod4aOH+wA+JD7yNprXuqsVCLUsUss9P8ReeepwUd1o=;
        b=Gdk3KwkiR25AFziifjsIcHRD6OqNuu/WU7FFN6Xg7owBW9PQgpZgJrndJxBycdki31
         hQx6c9KaZeYM2z7P1vP6y+DiOOsKTUdtuFCDsUeKF7gWLP9Oqy1WVvgqjIuxULWZk/QV
         iwEtAEaqaZeARNhZDK+iDGXKFnOSoW0mtoLWahtAsuWqCJcBfkKza0YQrSGXWdCN/Ma0
         AOmkOVQbcQmoIzXOGmKddJ73BF1w9Hgi2AkFr/7geMRVm2Z0gV0NlDi7cfAFNTUam+4/
         b57u8aVtCqTo+A5lvmY1Co+Y11CshT9i0t8d8Ol4Ecr0yT9vWow+JtZsoO2t+LuGIDO+
         zjaQ==
X-Gm-Message-State: APjAAAW8+Fi0J+DtdUfrAzS5fsrXcTCqwMEjmMoeU6uNVEgvmElzBW69
        +LfgNiHDyf+Ird4/di7PojY=
X-Google-Smtp-Source: APXvYqwSY4rpweMT+pCMYFKi/FkWkBHpOGTXBDX0dClAM4XU47XGV+X3eMOtFldgAORWXZlKwh9/tg==
X-Received: by 2002:a65:6210:: with SMTP id d16mr22802248pgv.110.1554291453283;
        Wed, 03 Apr 2019 04:37:33 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id k10sm509555pgo.82.2019.04.03.04.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:37:32 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:37:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 27/32] sha1-name.c: remove the_repo from get_oid_with_context_1()
Date:   Wed,  3 Apr 2019 18:34:52 +0700
Message-Id: <20190403113457.20399-28-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
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

