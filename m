Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4133020248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDCLh3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:37:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37672 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCLh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:37:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id w23so4960776ply.4
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1353qhiBFkvg4CjMPjTgaQAM7MfVk9j47bxGFKrEJdQ=;
        b=k8yr8qbwV5EeljhROVOlPglqvIsjIfQp57qFMTFzot69uo+eD/4ok72euUyKQUnVet
         K3+fqTBzU2AaMhDIFcIArMU1oESYbGgkMqQoC+4+ClulUBm5SYc7r1SFNRlA86hMLkys
         8mQp2hsCBYqRBJUca74UIqyeNNAZTK4d+pz1MYSlCFeg1h/+8rfRjn13rex/qzeXHgH1
         4AQ9z+ab6kGGJVoaMBfRYXwQl4k0TB/C7GxFvcoHVBHKvHdfhjXXBf7DRv5eU0Afa/7L
         Z2DL7tmkEaOp9s7lXL9q95GE/zrjk3Y4EONAmLxl75AkhN5R5CexpB4Sss1tcI+fQhgK
         Y59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1353qhiBFkvg4CjMPjTgaQAM7MfVk9j47bxGFKrEJdQ=;
        b=GteyuMeOUYSS8v+D2ffjuC4dVplz56CnoX/QDzeMB+l7xIHN2QOefh+wBpclibw68K
         qT7g0TVEBdkb0P7vsYBbQDpiwIJNA8SRPToJS1puFFFqwdgY7oyvGtcK3iTq+Ab+kKD0
         K7UlkLVyzfcjH7ynH+a+Qr1dbGH0wk5LovaGkJhWBmhrFbzqUNU0ElP1OGqbnk68/Z/B
         SWJMnrpBHIhsml/8I/hsLwaYxEJTAqg8+/GOc28KbR8DBCXuajILQiaqt3uXn5OSXozT
         OZtLkqYFv2IWk9MoiCm9pQzDFqEofHh5JcLIrxLV8E7rIllhiWGOw6duOXJy1A50lLVA
         Ne2g==
X-Gm-Message-State: APjAAAWoGnh++T5ruPpJ2A7f+77TUVSa5TPofTSaBRrttTnyyMepIl9t
        DXRyjQV8lxu0sUkagfTCcjs=
X-Google-Smtp-Source: APXvYqxMNFjdKJUuZ6G/F4LXuEJp1jguo6JJrpzwFjbKLpWXKVeJ8Ec+Vc3nIf0wF/igP6e+DWeFIg==
X-Received: by 2002:a17:902:526:: with SMTP id 35mr72629541plf.276.1554291448205;
        Wed, 03 Apr 2019 04:37:28 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id h65sm43295625pfd.108.2019.04.03.04.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:37:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:37:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 26/32] sha1-name.c: remove the_repo from resolve_relative_path()
Date:   Wed,  3 Apr 2019 18:34:51 +0700
Message-Id: <20190403113457.20399-27-pclouds@gmail.com>
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

"remove" is not entirely correct. But at least the function is aware
that if the given repo is not the_repository, then $CWD and
is_inside_work_tree() means nothing.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 6caf3f4e3a..6b53ea2eeb 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1719,12 +1719,12 @@ static void diagnose_invalid_index_path(struct repository *r,
 }
 
 
-static char *resolve_relative_path(const char *rel)
+static char *resolve_relative_path(struct repository *r, const char *rel)
 {
 	if (!starts_with(rel, "./") && !starts_with(rel, "../"))
 		return NULL;
 
-	if (!is_inside_work_tree())
+	if (r != the_repository || !is_inside_work_tree())
 		die("relative path syntax can't be used outside working tree.");
 
 	/* die() inside prefix_path() if resolved path is outside worktree */
@@ -1785,7 +1785,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			stage = name[1] - '0';
 			cp = name + 3;
 		}
-		new_path = resolve_relative_path(cp);
+		new_path = resolve_relative_path(repo, cp);
 		if (!new_path) {
 			namelen = namelen - (cp - name);
 		} else {
@@ -1839,7 +1839,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			const char *filename = cp+1;
 			char *new_filename = NULL;
 
-			new_filename = resolve_relative_path(filename);
+			new_filename = resolve_relative_path(repo, filename);
 			if (new_filename)
 				filename = new_filename;
 			if (flags & GET_OID_FOLLOW_SYMLINKS) {
-- 
2.21.0.479.g47ac719cd3

