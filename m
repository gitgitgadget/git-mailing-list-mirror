Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF1EC433EF
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 19:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiFQTGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 15:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbiFQTGb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 15:06:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4275676A
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 12:06:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i81-20020a1c3b54000000b0039c76434147so4808762wma.1
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 12:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1aclt8qarEKATJ+/GzKFdAWEVcurzVYKQFGwF4AHpIU=;
        b=SniYYqPwQzAkBDW2Q+rSSAJAuAWIAp4P0UQuEKzJcTrvsLZWAmBGL5F8sKAHMfm55L
         0BXqr/YygxEq/sNrPw3pSGppbpWF8EAvkUHFOhQypFPeDXCAx+fsWuaDFF8FZK6YMAiO
         4+ckhOyJv1vlq4Nb9ecIs/xSCEt2PEYFOI/+e/iT8zqkrWfmqAhwqIlYhNII+TzsKocj
         cPZ4y3mkDxT35plfF6mL08e/noTzq4HNsLpLUV/hjU2+8VObwP7kH0xnUCaFPwXuQ1kx
         gAC/A+ithKvpGYBm1LxnkDu6cfzWfbDjo3y42tA7R2ykSf8fC/ok4MY5391ntFSHx73M
         SHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1aclt8qarEKATJ+/GzKFdAWEVcurzVYKQFGwF4AHpIU=;
        b=xBmz65zsfFrmGd9BnMKNNjQe4QclNzDFlsm7+CXjtnCwCG8TYdoO8eLZ0Ftd4APIn8
         RCRfsJVz4ORn9SG5BJqvPwVZ9YxoCRgl5DjV3M2NeOZMkwOdEgztXXAAQ7PgB0fvdod6
         PnOF/lNetfrDkKKuXM9EiX4z5XaSm3LaAlPeaRJbI9ke5fm2jp6W8UChtli7bDaFnNvx
         qUFbQw4kgg1ogKmICeb6cq0o9Ac62r+hx55Nar8vqldP7AFVSr56zKJhohrxaNfIiDTt
         yXRxZ7GMTfVAZ3Tj7y7e/u4dixfnRb1bcrRoHxiNyKtfGo2pesi6FVfCbsLuR8x4pmJQ
         bwqw==
X-Gm-Message-State: AOAM5301HtRruUYT2V0lTh48TUPq7YrJGfdvkzwjMHJOAbQTdGNiy4to
        VS3Osi8t1XufLjBkM89h6itS9q5iQEIAjw==
X-Google-Smtp-Source: ABdhPJwgGNcDBiz9Duf1mpnT8SOBlQDFcklm04LAE5di0g97Y19qCwC4lH1y8kJr0o7T5SLcfezaAQ==
X-Received: by 2002:a05:600c:10cf:b0:39c:8270:7b86 with SMTP id l15-20020a05600c10cf00b0039c82707b86mr22440900wmd.180.1655492780659;
        Fri, 17 Jun 2022 12:06:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c4f0900b0039db500714fsm6915886wmq.6.2022.06.17.12.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 12:06:19 -0700 (PDT)
Message-Id: <pull.1263.v4.git.1655492779228.gitgitgadget@gmail.com>
In-Reply-To: <pull.1263.v3.git.1655438361228.gitgitgadget@gmail.com>
References: <pull.1263.v3.git.1655438361228.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jun 2022 19:06:19 +0000
Subject: [PATCH v4] send-pack.c: add config push.useBitmaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, kylezhao <kylezhao@tencent.com>,
        Jeff King <peff@peff.net>, Kyle Zhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kyle Zhao <kylezhao@tencent.com>

Reachability bitmaps are designed to speed up the "counting objects"
phase of generating a pack during a clone or fetch. They are not
optimized for Git clients sending a small topic branch via "git push".
In some cases (see [1]), using reachability bitmaps during "git push"
can cause significant performance regressions.

Add a new "push.useBitmaps" configuration variable to allow users to
tell "git push" not to use bitmaps. We already have "pack.bitmaps"
that controls the use of bitmaps, but a separate configuration variable
allows the reachability bitmaps to still be used in other areas,
such as "git upload-pack", while disabling it only for "git push".

[1]: https://lore.kernel.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/

Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
---
    send-pack.c: add config push.useBitmaps
    
    This patch add config push.useBitmaps to prevent git push using bitmap.
    
    The origin discussion is here:
    https://lore.kernel.org/git/b940e705fbe9454685757f2e3055e2ce@tencent.com/
    
    Thanks, -Kyle
    
    Changes since v1:
    
     * changed the commit message
     * modified and added missing \n to push.txt
     * used test_subcommand for test
     * modified "if" statement for "git_config_get_bool()" in send-pack.c
    
    Changes since v2:
    
     * enable 'push.useBitmaps" by default
     * fix nit in t/t5516-fetch-push.sh
    
    Changes since v3:
    
     * changed the commit message
     * s/no_use_bitmaps/disable_bitmaps in send-pack.h and send-pack.c
     * I modified the document about "push.useBitmaps". When it is true, Git
       will keep the historical behaviour. So I mainly introduced what
       happens when it set to false.
     * use test_config and test_unconfig for test.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1263%2Fkeyu98%2Fkz%2Fpush-usebitmps-config-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1263/keyu98/kz/push-usebitmps-config-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1263

Range-diff vs v3:

 1:  a523cb52542 ! 1:  9d35d926638 send-pack.c: add config push.useBitmaps
     @@ Metadata
       ## Commit message ##
          send-pack.c: add config push.useBitmaps
      
     -    This allows you to disable bitmaps for "git push". Default is true.
     -
          Reachability bitmaps are designed to speed up the "counting objects"
          phase of generating a pack during a clone or fetch. They are not
          optimized for Git clients sending a small topic branch via "git push".
          In some cases (see [1]), using reachability bitmaps during "git push"
          can cause significant performance regressions.
      
     -    Add a new "push.useBitmaps" config option to disable reachability
     -    bitmaps during "git push". This allows reachability bitmaps to still
     -    be used in other areas, such as "git rev-list --use-bitmap-index".
     +    Add a new "push.useBitmaps" configuration variable to allow users to
     +    tell "git push" not to use bitmaps. We already have "pack.bitmaps"
     +    that controls the use of bitmaps, but a separate configuration variable
     +    allows the reachability bitmaps to still be used in other areas,
     +    such as "git upload-pack", while disabling it only for "git push".
      
          [1]: https://lore.kernel.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/
      
     @@ Documentation/config/push.txt: push.negotiate::
       	in common.
      +
      +push.useBitmaps::
     -+	If this config and `pack.useBitmaps` are both `true`, then Git will
     -+	use reachability bitmaps during `git push`, if available. If set to
     -+	`false`, may improve push performance without affecting use of the
     -+	reachability bitmaps for other operations. Default is true.
     ++	If set to "false", disable use of bitmaps for "git push" even if
     ++	`pack.useBitmaps` is "true", without preventing other git operations
     ++	from using bitmaps. Default is true.
      
       ## send-pack.c ##
      @@ send-pack.c: static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
       		strvec_push(&po.args, "--progress");
       	if (is_repository_shallow(the_repository))
       		strvec_push(&po.args, "--shallow");
     -+	if (args->no_use_bitmaps)
     ++	if (args->disable_bitmaps)
      +		strvec_push(&po.args, "--no-use-bitmap-index");
       	po.in = -1;
       	po.out = args->stateless_rpc ? -1 : fd;
     @@ send-pack.c: int send_pack(struct send_pack_args *args,
       		get_commons_through_negotiation(args->url, remote_refs, &commons);
       
      +	if (!git_config_get_bool("push.usebitmaps", &use_bitmaps))
     -+		args->no_use_bitmaps = !use_bitmaps;
     ++		args->disable_bitmaps = !use_bitmaps;
      +
       	git_config_get_bool("transfer.advertisesid", &advertise_sid);
       
     @@ send-pack.h: struct send_pack_args {
       		stateless_rpc:1,
      -		atomic:1;
      +		atomic:1,
     -+		no_use_bitmaps:1;
     ++		disable_bitmaps:1;
       	const struct string_list *push_options;
       };
       
     @@ t/t5516-fetch-push.sh: test_expect_success 'push warns or fails when using usern
      +test_expect_success 'push with config push.useBitmaps' '
      +	mk_test testrepo heads/main &&
      +	git checkout main &&
     ++	test_unconfig push.useBitmaps &&
      +	GIT_TRACE2_EVENT="$PWD/default" \
      +	git push testrepo main:test &&
      +	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
      +		--thin --delta-base-offset -q <default &&
      +
     -+	git config push.useBitmaps true &&
     ++	test_config push.useBitmaps true &&
      +	GIT_TRACE2_EVENT="$PWD/true" \
      +	git push testrepo main:test2 &&
      +	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
      +		--thin --delta-base-offset -q <true &&
      +
     -+	git config push.useBitmaps false &&
     ++	test_config push.useBitmaps false &&
      +	GIT_TRACE2_EVENT="$PWD/false" \
      +	git push testrepo main:test3 &&
      +	test_subcommand git pack-objects --all-progress-implied --revs --stdout \


 Documentation/config/push.txt |  5 +++++
 send-pack.c                   |  6 ++++++
 send-pack.h                   |  3 ++-
 t/t5516-fetch-push.sh         | 22 ++++++++++++++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index e32801e6c91..7386fea225a 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -137,3 +137,8 @@ push.negotiate::
 	server attempt to find commits in common. If "false", Git will
 	rely solely on the server's ref advertisement to find commits
 	in common.
+
+push.useBitmaps::
+	If set to "false", disable use of bitmaps for "git push" even if
+	`pack.useBitmaps` is "true", without preventing other git operations
+	from using bitmaps. Default is true.
diff --git a/send-pack.c b/send-pack.c
index bc0fcdbb000..662f7c2aeb9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -84,6 +84,8 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
 		strvec_push(&po.args, "--progress");
 	if (is_repository_shallow(the_repository))
 		strvec_push(&po.args, "--shallow");
+	if (args->disable_bitmaps)
+		strvec_push(&po.args, "--no-use-bitmap-index");
 	po.in = -1;
 	po.out = args->stateless_rpc ? -1 : fd;
 	po.git_cmd = 1;
@@ -487,6 +489,7 @@ int send_pack(struct send_pack_args *args,
 	struct async demux;
 	const char *push_cert_nonce = NULL;
 	struct packet_reader reader;
+	int use_bitmaps;
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
@@ -498,6 +501,9 @@ int send_pack(struct send_pack_args *args,
 	if (push_negotiate)
 		get_commons_through_negotiation(args->url, remote_refs, &commons);
 
+	if (!git_config_get_bool("push.usebitmaps", &use_bitmaps))
+		args->disable_bitmaps = !use_bitmaps;
+
 	git_config_get_bool("transfer.advertisesid", &advertise_sid);
 
 	/* Does the other end support the reporting? */
diff --git a/send-pack.h b/send-pack.h
index e148fcd9609..7edb80596c7 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -26,7 +26,8 @@ struct send_pack_args {
 		/* One of the SEND_PACK_PUSH_CERT_* constants. */
 		push_cert:2,
 		stateless_rpc:1,
-		atomic:1;
+		atomic:1,
+		disable_bitmaps:1;
 	const struct string_list *push_options;
 };
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index dedca106a7a..b3734dd2fe9 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1865,4 +1865,26 @@ test_expect_success 'push warns or fails when using username:password' '
 	test_line_count = 1 warnings
 '
 
+test_expect_success 'push with config push.useBitmaps' '
+	mk_test testrepo heads/main &&
+	git checkout main &&
+	test_unconfig push.useBitmaps &&
+	GIT_TRACE2_EVENT="$PWD/default" \
+	git push testrepo main:test &&
+	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
+		--thin --delta-base-offset -q <default &&
+
+	test_config push.useBitmaps true &&
+	GIT_TRACE2_EVENT="$PWD/true" \
+	git push testrepo main:test2 &&
+	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
+		--thin --delta-base-offset -q <true &&
+
+	test_config push.useBitmaps false &&
+	GIT_TRACE2_EVENT="$PWD/false" \
+	git push testrepo main:test3 &&
+	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
+		--thin --delta-base-offset -q --no-use-bitmap-index <false
+'
+
 test_done

base-commit: 8168d5e9c23ed44ae3d604f392320d66556453c9
-- 
gitgitgadget
