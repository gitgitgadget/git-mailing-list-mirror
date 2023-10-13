Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A2224CC
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDg8t4GV"
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC80E7
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 10:39:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-323168869daso2220846f8f.2
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 10:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697218773; x=1697823573; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jP8p/CibwC5H5pEKwg8txpt9pKLJR7/n27kSWKf2ng=;
        b=FDg8t4GV9nJF8UGEi9GuHELLGLTfn/J3XhzDTMZgPd45Jw5HYksvQn4FgZdQeMkPi2
         AY0mNaG3Ax2SmAqpndJjUTQfiRaatCPBGWThC5VV7MeCNjeeEFeTK286HgNqUlKUNlQo
         4BunXMa1OC4h5zuEph5EftK+1FtMdh31rzdK0pnKiswRYvN0M7wQHMKB3PESutZ5fYZ5
         qrZ+SqluvrPdSyNrys9OHYnl5LQ+B/kPt7qOufwgIPlNmatef7En7uuNbuDFHBeojEK9
         O5jwxYYOXKNcr/mt/QWn9hUcg1FMq0Sp7Yi62UsgU6XX7kdykxFVn+0HRxxx3koWcuKr
         6Ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697218773; x=1697823573;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jP8p/CibwC5H5pEKwg8txpt9pKLJR7/n27kSWKf2ng=;
        b=PVEqaI2IxP2AqApkT22iS+lozF69v/6uwqKjn2sJRpj1Mk5wAu9w+IB0dIxD//mQ3N
         wsqqSKziyraIB+k4B288ZxkaLpn/v50GjKbY714HJ82WH0Qshanoq3B33KKuzT4J34xC
         FtGzAQH6SaSVQQrux2+QfcINPFFtdi9xhDpAkwNPjphDyROhWwclXiWPV5uziy3g40PR
         SlwDD6BOpFFzaRyt+HckPXhtlHGAy33Hs2wfed2q1RdPvmBBbVLGIoyGdTe3vHGOcts0
         FEZanbHKDaRfm7G4oUXlOC4i04argHUhZyhisIviOi8PBPNYVIIb7Brz6a6xn+ki3QRE
         iPbA==
X-Gm-Message-State: AOJu0Yz6P5X/QkiVxj7zSmCs51HyuRHqtJy9SQ3aaeu37QzOOZ5ie3AC
	9UdGM7zW95C/5zSEho6PyUmqx20DPKg=
X-Google-Smtp-Source: AGHT+IGbF7By34hZ3ZtYDjzyxab+aH63t9mgBbWMkZ3EO4M6tEi/1zpbxIHzq6EfhmttshZoOC73sg==
X-Received: by 2002:adf:a1d4:0:b0:32d:a310:cc2e with SMTP id v20-20020adfa1d4000000b0032da310cc2emr370991wrv.34.1697218772560;
        Fri, 13 Oct 2023 10:39:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g12-20020adff40c000000b0031c6581d55esm3350149wro.91.2023.10.13.10.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 10:39:32 -0700 (PDT)
Message-ID: <eaa27c478105606b39917bdadbdcfdce2b1b3521.1697218770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.v5.git.git.1697218770.gitgitgadget@gmail.com>
References: <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
	<pull.1577.v5.git.git.1697218770.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Oct 2023 17:39:29 +0000
Subject: [PATCH v5 1/2] attr: read attributes from HEAD when bare repo
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    Jonathan Tan <jonathantanmy@google.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: John Cai <johncai86@gmail.com>

The motivation for 44451a2e5e (attr: teach "--attr-source=<tree>" global
option to "git" , 2023-05-06), was to make it possible to use
gitattributes with bare repositories.

To make it easier to read gitattributes in bare repositories however,
let's just make HEAD:.gitattributes the default. This is in line with
how mailmap works, 8c473cecfd (mailmap: default mailmap.blob in bare
repositories, 2012-12-13).

Signed-off-by: John Cai <johncai86@gmail.com>
---
 attr.c                  | 12 +++++++++++-
 t/t0003-attributes.sh   | 11 +++++++++++
 t/t5001-archive-attr.sh |  2 +-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 71c84fbcf86..bf2ea1626a6 100644
--- a/attr.c
+++ b/attr.c
@@ -1194,6 +1194,7 @@ static void collect_some_attrs(struct index_state *istate,
 }
 
 static const char *default_attr_source_tree_object_name;
+static int ignore_bad_attr_tree;
 
 void set_git_attr_source(const char *tree_object_name)
 {
@@ -1205,10 +1206,19 @@ static void compute_default_attr_source(struct object_id *attr_source)
 	if (!default_attr_source_tree_object_name)
 		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE_ENVIRONMENT);
 
+	if (!default_attr_source_tree_object_name &&
+	    startup_info->have_repository &&
+	    is_bare_repository()) {
+		default_attr_source_tree_object_name = "HEAD";
+		ignore_bad_attr_tree = 1;
+	}
+
 	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
 		return;
 
-	if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source))
+	if (repo_get_oid_treeish(the_repository,
+				 default_attr_source_tree_object_name,
+				 attr_source) && !ignore_bad_attr_tree)
 		die(_("bad --attr-source or GIT_ATTR_SOURCE"));
 }
 
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 26e082f05b4..5665cdc079f 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -342,6 +342,17 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
 	)
 '
 
+
+test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
+	test_when_finished rm -rf test bare_with_gitattribute &&
+	git init test &&
+	test_commit -C test gitattributes .gitattributes "f/path test=val" &&
+	git clone --bare test bare_with_gitattribute &&
+	echo "f/path: test: val" >expect &&
+	git -C bare_with_gitattribute check-attr test -- f/path >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'bare repository: with --source' '
 	(
 		cd bare.git &&
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 0ff47a239db..eaf959d8f63 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -138,7 +138,7 @@ test_expect_success 'git archive with worktree attributes, bare' '
 '
 
 test_expect_missing	bare-worktree/ignored
-test_expect_exists	bare-worktree/ignored-by-tree
+test_expect_missing	bare-worktree/ignored-by-tree
 test_expect_exists	bare-worktree/ignored-by-worktree
 
 test_expect_success 'export-subst' '
-- 
gitgitgadget

