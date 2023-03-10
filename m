Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65383C6FD19
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 21:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjCJVtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 16:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjCJVst (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 16:48:49 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AD114DA25
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:45:56 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso3722353ota.1
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678484722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdEhSoGY7kpSBMMIUhZair9Bn6dKieS5VrAmkjaRaFA=;
        b=KPs0UlCnv+KmqxVpC995DyPVd9kC9HF+KdhmojLqZeWuhbQCLn62HpwOxzA3HYvnCh
         B/5LDMDtWmMI03+omNUVAQK8SB7cZOoWKV8/Lplp8+K6Jn3ZkncCqfLFm9VACzRwzOtj
         adiAYr5SS5tGAeOcBnq4fO41LC3jnYTRRBr2/BFaa8P/SP2Btxc7i4RbDSRbjRBdfOY5
         loWIwEZCJzqrj1kqanpfNpVOfm+m1s3FBYfNNBvO+LvMhaGZDJZNgUIg98oWQ4NUwiXJ
         d66FJPNehgmqbUz2P2Hodd0AJvPr5XPgssCPlootaZ2lFeaWu8jAWltUk2ya/g0vPhjK
         f39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdEhSoGY7kpSBMMIUhZair9Bn6dKieS5VrAmkjaRaFA=;
        b=cQPT18J4XPAioNPP2vxdxoeOkd2Iv7ynecj0rT9brk9KYQsSrsS75C7RfZGE1VPRq5
         aztv7N0oWesH8tyfx0t3DzlTH6vW7roPKcsqnmKR8+dyW2J59FltJrPMN3FYCe+Dxypt
         NYNW9Vu4kM4GOkVwVOP8IAImJVWpeZxIcTy2dgSsBrre4toiutICiIpsRxyM3Z7dgh4R
         RBWq4QrabGWe8xwV9lF+74Oac5/bUWaVS4UIGUbAbBjVfKaAHJfY6nygeZb3Ep04+qEq
         /nkSlJmz+4YhGIyrgMF5/Dw1RgzVuDqEPvRM2S/wa+n2h8FbgfNYIFJ9HvhgQOc5cK9P
         dgmQ==
X-Gm-Message-State: AO0yUKWOOlLCdYZAW9Ee8KpoSUQMqphwvSA76Umyq0Mui8u3T1V5+Ymn
        CAPya3r+Z1kvFOwsR21Q34OspEVHoxI=
X-Google-Smtp-Source: AK7set8Mt/1C+MeH5gs0N8okb38vXcwR/1GZf9WKNBFh6zerRjgUzMPiawzvSIsRx/SuiB7pMSCyVQ==
X-Received: by 2002:a9d:7206:0:b0:68b:dc52:10f9 with SMTP id u6-20020a9d7206000000b0068bdc5210f9mr13687369otj.5.1678484722200;
        Fri, 10 Mar 2023 13:45:22 -0800 (PST)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id i18-20020a9d6112000000b0068bcef4f543sm533353otj.21.2023.03.10.13.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:45:21 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 2/3] sha1-name: add @{tail} helpers
Date:   Fri, 10 Mar 2023 15:45:14 -0600
Message-Id: <20230310214515.39154-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0.rc2.1.gf652911b76.dirty
In-Reply-To: <20230310214515.39154-1-felipe.contreras@gmail.com>
References: <20230310214515.39154-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 object-name.c             | 30 +++++++++++++++++++++++++++++-
 t/t1514-rev-parse-tail.sh |  6 ++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/object-name.c b/object-name.c
index 2dd1a0f56e..a0f845c927 100644
--- a/object-name.c
+++ b/object-name.c
@@ -877,6 +877,20 @@ static inline int push_mark(const char *string, int len)
 	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
 }
 
+static inline int tail_mark(const char *string, int len)
+{
+	const char *suffix[] = { "@{tail}", "@{t}" };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
+		int suffix_len = strlen(suffix[i]);
+		if (suffix_len <= len
+		    && !memcmp(string, suffix[i], suffix_len))
+			return suffix_len;
+	}
+	return 0;
+}
+
 static enum get_oid_result get_oid_1(struct repository *r, const char *name, int len, struct object_id *oid, unsigned lookup_flags);
 static int interpret_nth_prior_checkout(struct repository *r, const char *name, int namelen, struct strbuf *buf);
 
@@ -925,7 +939,8 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 					continue;
 				}
 				if (!upstream_mark(str + at, len - at) &&
-				    !push_mark(str + at, len - at)) {
+				    !push_mark(str + at, len - at) &&
+				    !tail_mark(str + at, len - at)) {
 					reflog_len = (len-1) - (at+2);
 					len = at;
 				}
@@ -1608,6 +1623,13 @@ static int interpret_branch_mark(struct repository *r,
 	return len + at;
 }
 
+const char *branch_get_tail(struct branch *branch, struct strbuf *err)
+{
+	static struct strbuf tmp = STRBUF_INIT; /* TODO: find a proper place */
+	strbuf_addf(&tmp, "refs/tails/%s", branch->name);
+	return tmp.buf;
+}
+
 int repo_interpret_branch_name(struct repository *r,
 			       const char *name, int namelen,
 			       struct strbuf *buf,
@@ -1655,6 +1677,12 @@ int repo_interpret_branch_name(struct repository *r,
 					    options);
 		if (len > 0)
 			return len;
+
+		len = interpret_branch_mark(r, name, namelen, at - name, buf,
+					    tail_mark, branch_get_tail,
+					    options);
+		if (len > 0)
+			return len;
 	}
 
 	return -1;
diff --git a/t/t1514-rev-parse-tail.sh b/t/t1514-rev-parse-tail.sh
index da8e9ceef1..6024b4276c 100755
--- a/t/t1514-rev-parse-tail.sh
+++ b/t/t1514-rev-parse-tail.sh
@@ -20,4 +20,10 @@ test_expect_success 'test tail creation' '
 	test_cmp expect actual
 '
 
+test_expect_success 'test @{tail}' '
+	git rev-parse test@{tail} > actual &&
+	git rev-parse master > expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.40.0.rc2.1.gf652911b76.dirty

