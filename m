Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C09D33095
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rona1yuQ"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7134B18D
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:34:07 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso53569645e9.2
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058845; x=1700663645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4zd/oScWv0eVySkwahsDIwB3AHXeq3kAyFFQOU+wro=;
        b=Rona1yuQuQ/MQwusHo0oDhX8zeD1FJl3o/gbpih7YleFw+8MIdRtESReqkkUAvApyD
         PSWXnAjiv0wFC9aDfynui8bL+7aUqlrjRbm/i9Wz4TE8MIbH+We3f2z+t98ibLtgggUn
         EUCXj1DublILzUUidjYHiLTqCVyyTeQce6IEWB9OqfP6kcuUDq1nP7+TrAYQlLGJ7l1Z
         S7RKDCFAPEoNufwMtJkT8j7ZSVKK15aHf08WHHMxJCc9LAjOwrDbdsbI+pEa7oedTjxq
         KdYNIXrHYO6uXU/W5W0K4Avv1T102xFfNCOGS+W7N8Z3lHq0xkE54I6cwRyoU9W+ZXYx
         ohlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058845; x=1700663645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4zd/oScWv0eVySkwahsDIwB3AHXeq3kAyFFQOU+wro=;
        b=v2lU3uCeAy1sc5G+H0DQN2eZmR7h6SxId5P0GXjW4jk8R8A8yV4wlLYC70Daq1Qlw6
         TevgA6o8VH0g6mYApG8Ul2y4o38imn7RpJ5cYJFNLcoqqMElsmbpAoBLKAfIOsNfDbuH
         fAOmn6+IEe/X5JljqzyodaQ+4U/dSxbxQrWhzhSuxJ1czP1xG+1S303FPFy39fmc6nbV
         DoAIaiGrvwwfPuz2E44q4HJoK4U9l65o9SXUxesjlaUUEHFRtg4RiyKU4K5uCjf2h/RJ
         vOxTq56vU6x2M+Zr5MUGvXHEOgHrHS7vT97m+a4bjrDwfO4GGZRVhhYqpaJB8a9HxQ3o
         SchA==
X-Gm-Message-State: AOJu0YxNFNeLZRxufm6EVVek3kD7DXkFHl2dO+RnsWtXOPwzLYHeK9uk
	SOWiAIQd8s2EqojHQywTlqHJA79lpQc=
X-Google-Smtp-Source: AGHT+IFMmJryh7567TG6Uxavg7gL51TrFUXeIdfvLoGEplaKFF3pMIA5q5UGY6C7VfteKSqsNmT/lA==
X-Received: by 2002:a05:600c:1f87:b0:40a:55a6:793a with SMTP id je7-20020a05600c1f8700b0040a55a6793amr6212813wmb.21.1700058845010;
        Wed, 15 Nov 2023 06:34:05 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:a40b:e654:dd4c:2f5f])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b004060f0a0fd5sm15207643wmo.13.2023.11.15.06.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:34:03 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 13/14] replay: add --contained to rebase contained branches
Date: Wed, 15 Nov 2023 15:33:26 +0100
Message-ID: <20231115143327.2441397-14-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.15.g29556bcc86
In-Reply-To: <20231115143327.2441397-1-christian.couder@gmail.com>
References: <20231102135151.843758-1-christian.couder@gmail.com>
 <20231115143327.2441397-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

Let's add a `--contained` option that can be used along with
`--onto` to rebase all the branches contained in the <revision-range>
argument.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replay.txt | 12 +++++++++++-
 builtin/replay.c             | 13 +++++++++++--
 t/t3650-replay-basics.sh     | 29 +++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index 6daa5b4275..133d7af9ee 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -9,7 +9,7 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-'git replay' (--onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL
+'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL
 
 DESCRIPTION
 -----------
@@ -96,6 +96,16 @@ top of the exact same new base, they only differ in that the first
 provides instructions to make mybranch point at the new commits and
 the second provides instructions to make target point at them.
 
+What if you have a stack of branches, one depending upon another, and
+you'd really like to rebase the whole set?
+
+------------
+$ git replay --contained --onto origin/main origin/main..tipbranch
+update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
+update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
+update refs/heads/tipbranch ${NEW_tipbranch_HASH} ${OLD_tipbranch_HASH}
+------------
+
 When calling `git replay`, one does not need to specify a range of
 commits to replay using the syntax `A..B`; any range expression will
 do:
diff --git a/builtin/replay.c b/builtin/replay.c
index 1a419cb7fd..e14e33bcc5 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -258,6 +258,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	const char *advance_name = NULL;
 	struct commit *onto = NULL;
 	const char *onto_name = NULL;
+	int contained = 0;
 
 	struct rev_info revs;
 	struct commit *last_commit = NULL;
@@ -268,7 +269,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	int ret = 0;
 
 	const char * const replay_usage[] = {
-		N_("git replay (--onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL"),
+		N_("git replay ([--contained] --onto <newbase> | --advance <branch>) "
+		   "<revision-range>... # EXPERIMENTAL"),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -278,6 +280,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "onto", &onto_name,
 			   N_("revision"),
 			   N_("replay onto given commit")),
+		OPT_BOOL(0, "contained", &contained,
+			 N_("advance all branches contained in revision-range")),
 		OPT_END()
 	};
 
@@ -289,6 +293,10 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		usage_with_options(replay_usage, replay_options);
 	}
 
+	if (advance_name && contained)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--advance", "--contained");
+
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	/*
@@ -377,7 +385,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			continue;
 		while (decoration) {
 			if (decoration->type == DECORATION_REF_LOCAL &&
-			    strset_contains(update_refs, decoration->name)) {
+			    (contained || strset_contains(update_refs,
+							  decoration->name))) {
 				printf("update %s %s %s\n",
 				       decoration->name,
 				       oid_to_hex(&last_commit->object.oid),
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 68a87e7803..d6286f9580 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -114,4 +114,33 @@ test_expect_success 'replay fails when both --advance and --onto are omitted' '
 	test_must_fail git replay topic1..topic2 >result
 '
 
+test_expect_success 'using replay to also rebase a contained branch' '
+	git replay --contained --onto main main..topic3 >result &&
+
+	test_line_count = 2 result &&
+	cut -f 3 -d " " result >new-branch-tips &&
+
+	git log --format=%s $(head -n 1 new-branch-tips) >actual &&
+	test_write_lines F C M L B A >expect &&
+	test_cmp expect actual &&
+
+	git log --format=%s $(tail -n 1 new-branch-tips) >actual &&
+	test_write_lines H G F C M L B A >expect &&
+	test_cmp expect actual &&
+
+	printf "update refs/heads/topic1 " >expect &&
+	printf "%s " $(head -n 1 new-branch-tips) >>expect &&
+	git rev-parse topic1 >>expect &&
+	printf "update refs/heads/topic3 " >>expect &&
+	printf "%s " $(tail -n 1 new-branch-tips) >>expect &&
+	git rev-parse topic3 >>expect &&
+
+	test_cmp expect result
+'
+
+test_expect_success 'using replay on bare repo to also rebase a contained branch' '
+	git -C bare replay --contained --onto main main..topic3 >result-bare &&
+	test_cmp expect result-bare
+'
+
 test_done
-- 
2.43.0.rc1.15.g29556bcc86

