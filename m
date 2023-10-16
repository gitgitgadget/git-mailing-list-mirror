Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9220B20
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvaF0cFp"
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465E9AC
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 03:38:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so7462456a12.3
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697452721; x=1698057521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FovC1Plfvoa/kial0Q+l1vpZy/dgkXp1PGmAyXGaODY=;
        b=IvaF0cFp4vWKIebXmezL/Vs8WyIjRnuu+gse31MVqko3uV8cxpPIgaiMg/9mLAcuO/
         kTtsoJMZwubK+/ZMO7u1e2gNiVKM+51y4/jHiLCV76EZ1e22CYgBG1g8GE0ytHWgRhB+
         cebyFWBKBmj8ZbEVC5zU9mP3rPEIMsOmm7MUOcr2pyEWd3OwLkQaONSM6qOZFAAuiG7+
         UXwHsV8lFYbCo7FUBqDmxjc/TfkK7dYXvogp2LgV6VMRoexa+AFcOKLRY0f1GWNff656
         oHIMdPfY7CA4nKXSYVF7MkQ91lOoJx5A+2GprLjMVwnCFsW5cnU7wHRahjTKtL3iWZFE
         BHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697452721; x=1698057521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FovC1Plfvoa/kial0Q+l1vpZy/dgkXp1PGmAyXGaODY=;
        b=hxEmEzPV1LCVaB7aEOjszCSVwYE5CPZrjmyB/qob6j1Z843W8KKJoJGaCvT9zVEG/8
         Kr9vmB1YpCm2PWW6G99i/z7QAMAXs0q9pzoxSFp2cKfOHtlpExnSekbrqcpYjB+qcxvZ
         ZsWAIuXrdERjnIQn5W+tie/Mn/FH/6LUBFMx888Z+AC0VcW8o77S+37qLX/5YvUkCHh1
         pRybdtkHkEVK28eP1f44mvp+rIda5HThj0Jx93fMs4xr1d7vupC2zUNEQ66rvmGcbHuc
         RNSMfAJwM9cIf333oN/CJ5FAg1TfK5Ob8PKAOQ9qeniI7JR/ATFQp4V0CiadKhpYuYWN
         loBQ==
X-Gm-Message-State: AOJu0Yyk+zDEf1TBMZCkJX8kuxbYyyk1jhlBo3WYFtfMOv6+S4vnf+c8
	NoVRt7LKSMxoqT5cyp7wQDA=
X-Google-Smtp-Source: AGHT+IGCgM45/0wqaIFp+oFOgzXnBF95z8LlUVMxl9V1+DjJTOfKR3p5xy58+6A++2clIfPE3EFNpA==
X-Received: by 2002:a17:907:70b:b0:9bd:a165:7822 with SMTP id xb11-20020a170907070b00b009bda1657822mr7398432ejb.47.1697452720461;
        Mon, 16 Oct 2023 03:38:40 -0700 (PDT)
Received: from worklaptop.fritz.box ([2a02:2454:56d:f00:b15b:356c:2a07:7b52])
        by smtp.gmail.com with ESMTPSA id jx17-20020a170907761100b009ad875d12d7sm3784390ejc.210.2023.10.16.03.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:38:39 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 0/3] rev-list: add support for commits in `--missing`
Date: Mon, 16 Oct 2023 12:38:27 +0200
Message-ID: <20231016103830.56486-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009105528.17777-1-karthik.188@gmail.com>
References: <20231009105528.17777-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The `--missing` option in git-rev-list(1) was introduced intitally
to deal with missing blobs in the context of promissory notes.
Eventually the option was extended to also support tree objects in
7c0fe330d5 (rev-list: handle missing tree objects properly,2018-10-05).

This patch series extends the `--missing` option to also add support for
commit objects. We do this by introducing a new flag `MISSING` which is
added whenever we encounter a missing commit during traversal. Then in
`builtin/rev-list` we check for this flag and take the appropriate
action based on the `--missing=*` option used.

This series is an alternate to the patch series I had posted earlier:
https://lore.kernel.org/git/20230908174208.249184-1-karthik.188@gmail.com/.
In that patch, we introduced an option `--ignore-missing-links` which
was added to expose the `ignore_missing_links` bit to the user. The
issue in that patch was that, the option `--ignore-missing-links` didn't
play well the pre-existing `--missing` option. This series avoids that
route and just extends the `--missing` option for commits to solve the
same problem.

Changes from v1:
1. The patch series is now rebased on top of Patrick's work to make
commit-graphs more reliable. With this, we need to be more diligant
around which commits are missing and only parse required commits. So
we add some extra checks here, especially because we don't want to
allow missing commit's tree and parent to be parsed.
2. The tests were preivously testing a commit with no parents, add
an additional commit to ensure that the missing commit's parents aren't
parsed.

Range diff:

1:  be2ac0a331 = 1:  c1c892aa86 revision: rename bit to `do_not_die_on_missing_objects`
2:  b44983967f = 2:  67f6bfeaf7 rev-list: move `show_commit()` to the bottom
3:  306d918aef ! 3:  6d8e3c721f rev-list: add commit object support in `--missing` option
    @@ builtin/rev-list.c: static void show_commit(struct commit *commit, void *data)
      		total_disk_usage += get_object_disk_usage(&commit->object);
      
     
    + ## list-objects.c ##
    +@@ list-objects.c: static void do_traverse(struct traversal_context *ctx)
    + 		 * an uninteresting boundary commit may not have its tree
    + 		 * parsed yet, but we are not going to show them anyway
    + 		 */
    +-		if (!ctx->revs->tree_objects)
    ++		if (!ctx->revs->tree_objects || commit->object.flags & MISSING)
    + 			; /* do not bother loading tree */
    + 		else if (repo_get_commit_tree(the_repository, commit)) {
    + 			struct tree *tree = repo_get_commit_tree(the_repository,
    +
      ## object.h ##
     @@ object.h: void object_array_init(struct object_array *array);
      
    @@ object.h: void object_array_init(struct object_array *array);
       * walker.c:                 0-2
     
      ## revision.c ##
    +@@ revision.c: static int process_parents(struct rev_info *revs, struct commit *commit,
    + 	struct commit_list *parent = commit->parents;
    + 	unsigned pass_flags;
    + 
    +-	if (commit->object.flags & ADDED)
    ++	if (commit->object.flags & ADDED || commit->object.flags & MISSING)
    + 		return 0;
    + 	commit->object.flags |= ADDED;
    + 
     @@ revision.c: static int process_parents(struct rev_info *revs, struct commit *commit,
      	for (parent = commit->parents; parent; parent = parent->next) {
      		struct commit *p = parent->item;
    @@ t/t6022-rev-list-missing.sh (new)
     +# available and we can hide commit 1.
     +test_expect_success 'create repository and alternate directory' '
     +	test_commit 1 &&
    -+	test_commit 2
    ++	test_commit 2 &&
    ++	test_commit 3
     +'
     +
     +for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
    @@ t/t6022-rev-list-missing.sh (new)
     +			git rev-list --objects --no-object-names \
     +				HEAD ^$obj >expect.raw &&
     +
    -+			# Since both the commits have the `1.t` blob, rev-list
    -+			# will print it since its reachable from either commit. Unless
    -+			# the blob itself is missing.
    ++			# Blobs are shared by all commits, so evethough a commit/tree
    ++			# might be skipped, its blob must be accounted for.
     +			if [ $obj != "HEAD:1.t" ]; then
    -+				echo $(git rev-parse HEAD:1.t) >>expect.raw
    ++				echo $(git rev-parse HEAD:1.t) >>expect.raw &&
    ++				echo $(git rev-parse HEAD:2.t) >>expect.raw
     +			fi &&
     +
     +			mv "$path" "$path.hidden" &&
    @@ t/t6022-rev-list-missing.sh (new)
     +	done
     +done
     +
    -+
     +test_done


Karthik Nayak (3):
  revision: rename bit to `do_not_die_on_missing_objects`
  rev-list: move `show_commit()` to the bottom
  rev-list: add commit object support in `--missing` option

 builtin/reflog.c            |  2 +-
 builtin/rev-list.c          | 93 +++++++++++++++++++------------------
 list-objects.c              |  4 +-
 object.h                    |  2 +-
 revision.c                  | 11 +++--
 revision.h                  | 20 ++++----
 t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++
 7 files changed, 147 insertions(+), 59 deletions(-)
 create mode 100755 t/t6022-rev-list-missing.sh

-- 
2.41.0

