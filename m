Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 908BB1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 03:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfHADOH (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 23:14:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33159 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfHADOG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 23:14:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so64521324qtt.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 20:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSW5Tro12EQLlgHV0FlNCmqZpSwMjPnKXT/kS4ZcwLM=;
        b=bweVnxMMEqspcLO3cqPxaWSXdRZ+0+D4T1q02xIvTXEzdCfqcOnb4mGn9wtcfqxz63
         Lzb+2lRrK1zv1ktYvPlCaCQGigmEPfM9/Pku/6EcywSLscP5u5StJ2qNcQENXJAhXsE/
         sO8AyADmMXpeNxlXOkJEXhmPcIZ5Yq93QqPXTvbhe210ocvOKyGxc8pecqjRE0B8dn3Y
         g4j7LYmHn/Yoj+SXw5Y2vnWG8GQFk9g9zowVvC/lZD0fx6PMbDqaCMnhbMMAi08PZJwa
         YtQc5qWSuQSsQD5nBYERQpFGUwBhfVIdsN3E3/UCGTtMQyyZy2Fs305RDW5f2jptEdFV
         +REg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSW5Tro12EQLlgHV0FlNCmqZpSwMjPnKXT/kS4ZcwLM=;
        b=kseAwSi8Kf3AvwmNogm6GQ9IVTfSlxfif9ADjpsyFs6gWNC04RJraRMnoPL0CdKV8s
         liV+lxsRSEbVkP27ogEly25a37d1mBvCboOw34qG8sMmEYmQAOMRhePqV2iYje1TkWDP
         sQXXu6cmRjtpbad1BO7eSt6xRkLqWe/jWxq6Em77Movo4E+wxzuxvkaYOKW7U1/VvE1G
         +Kaym5Vou72DELoBf3Ta4DJW8f1hiq5QPp4IG4/NY+CRyoElVhQqXDx7XRvcr0MDUQO9
         bOFS/dulQapxoPZoeZq5DvgR5QiGHYHW3LfSNgkoSh2337h+aBk/FCkCVebTfQz1UdWd
         s6+A==
X-Gm-Message-State: APjAAAUL6k/J4J5JBitZ/E37OFBOqdMM7e7eDa44ZDrqNPc/Opt1YJRk
        Akas0jOtBXtYvJcAWnly1CwlNA==
X-Google-Smtp-Source: APXvYqy/l7pa66Z8Fdd1NqxIoj5wopBSPbgm2NAxhQo91uFuyEL+79ntoAvYsUaLO3n+IKZGpWxNBA==
X-Received: by 2002:aed:2068:: with SMTP id 95mr87532266qta.265.1564629245492;
        Wed, 31 Jul 2019 20:14:05 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id c40sm41206970qtd.14.2019.07.31.20.14.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:14:04 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, jackdanielz@eyomi.org
Subject: [GSoC][PATCH v3] grep: fix worktree case in submodules
Date:   Thu,  1 Aug 2019 00:13:44 -0300
Message-Id: <901ddbf6a1d9eeff51b1b2282ebefad51e61b12d.1564629070.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <d1fdd091f289e836633b875d87341a66d1fc528a.1564587317.git.matheus.bernardino@usp.br>
References: <d1fdd091f289e836633b875d87341a66d1fc528a.1564587317.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running git-grep with --recurse-submodules results in a cached grep for
the submodules even when --cached is not used. This makes all
modifications in submodules' tracked files be always ignored when
grepping. Solve that making git-grep respect the cached option when
invoking grep_cache() inside grep_submodule(). Also, add tests to
ensure that the desired behavior is performed.

Reported-by: Daniel Zaoui <jackdanielz@eyomi.org>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v3:
- Replaced the "\* ignored *\" comment by a more meaningful note at the
  top of grep_submodule()

builtin/grep.c                     | 13 +++++++++----
 t/t7814-grep-recurse-submodules.sh | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 560051784e..df8cdecdae 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -400,10 +400,14 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len,
 		     int check_attr);
 
+/*
+ * The cached bit is only meaningful when a NULL oid is given (i.e. when not
+ * grepping inside a tree object).
+ */
 static int grep_submodule(struct grep_opt *opt,
 			  const struct pathspec *pathspec,
 			  const struct object_id *oid,
-			  const char *filename, const char *path)
+			  const char *filename, const char *path, int cached)
 {
 	struct repository subrepo;
 	struct repository *superproject = opt->repo;
@@ -475,7 +479,7 @@ static int grep_submodule(struct grep_opt *opt,
 		strbuf_release(&base);
 		free(data);
 	} else {
-		hit = grep_cache(&subopt, pathspec, 1);
+		hit = grep_cache(&subopt, pathspec, cached);
 	}
 
 	repo_clear(&subrepo);
@@ -523,7 +527,8 @@ static int grep_cache(struct grep_opt *opt,
 			}
 		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
 			   submodule_path_match(repo->index, pathspec, name.buf, NULL)) {
-			hit |= grep_submodule(opt, pathspec, NULL, ce->name, ce->name);
+			hit |= grep_submodule(opt, pathspec, NULL, ce->name,
+					      ce->name, cached);
 		} else {
 			continue;
 		}
@@ -598,7 +603,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			free(data);
 		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
 			hit |= grep_submodule(opt, pathspec, &entry.oid,
-					      base->buf, base->buf + tn_len);
+					      base->buf, base->buf + tn_len, 1);
 		}
 
 		strbuf_setlen(base, old_baselen);
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index a11366b4ce..edb64690e6 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -408,4 +408,24 @@ test_expect_success 'grep --recurse-submodules with submodules without .gitmodul
 	test_cmp expect actual
 '
 
+reset_and_clean () {
+	git reset --hard &&
+	git clean -fd &&
+	git submodule foreach --recursive 'git reset --hard && git clean -fd'
+}
+
+test_expect_success 'grep --recurse-submodules without --cached considers worktree modifications' '
+	reset_and_clean &&
+	echo "A modified line in submodule" >>submodule/a &&
+	echo "submodule/a:A modified line in submodule" >expect &&
+	git grep --recurse-submodules "A modified line in submodule" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --recurse-submodules with --cached ignores worktree modifications' '
+	reset_and_clean &&
+	echo "A modified line in submodule" >>submodule/a &&
+	test_must_fail git grep --recurse-submodules --cached "A modified line in submodule" >actual 2>&1 &&
+	test_must_be_empty actual
+'
 test_done
-- 
2.22.0

