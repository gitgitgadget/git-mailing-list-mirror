Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26187C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 03:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357782AbiFPDhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 23:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiFPDhC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 23:37:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AE742A2C
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 20:37:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o16so146934wra.4
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 20:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OrbgePDG6vY9IhVtUHHXDaTPPsh2WIOXl+alKcTwFY4=;
        b=hz6Gr/8V+hPWOgAKFOKD2WIOL/USrpiIjWr76chNnWvadoHQCixhbouYXq0m87Fmjh
         U9XyhS14YqCfAcboBLn56Z+wQ78GlZ2UhJwerLOdsYyutLw+/MAGUTaxWebjlfGX0+wT
         o/4XXhaCbtRmikllAq1c4rQpyFB7Mwo957/C3T5FD/ADgwdGgrtLDbcjUGQ10fgsuG6J
         tdEo4ZoNHmLup3J6cqJerGjZLe85lvQEWWCGHl6Cmd5JgK38w5M7nnX7KaTDnpA16zaD
         2Tqs6EYm4Jt7mehLo+OKFIOsiypcdzwObu3Cna2/M+1Gg5M6og9wYu8UUjlfsMevKQeR
         CDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OrbgePDG6vY9IhVtUHHXDaTPPsh2WIOXl+alKcTwFY4=;
        b=CacTsCBScLP3OLa9RpYJON5tFP2JWBvFOpr/F4xA/2FpsK3uxuzSnoMwtSUa0jpXO/
         r9zkBtAnlJEpzTf+bwVBfK5AnHu1nRITOXJOWsbtm6RIRGRGJmCGTI9R0SUiuI2lq1Qb
         ZdWe8RPMRyMv8rJtnr8QUBXx+kiMNiUpFopCTykFAaLXR2W+Z4K85FRQTPgVhnnVmGHc
         joLJIUM/dapCb/0a3n7EbXMZjOKdjDtLojEGY5Q4+YFuk8gFGoVwbU4NqMp2xTDcVyTU
         N9yHDUnxjWgKaB2OZdwD8hSUDwVf3KGV7NLcF4A5pkkMRmjkdJU7kQZ6rQufkyd1g9pR
         XWMg==
X-Gm-Message-State: AJIora+A32peDaozvlbnacaOu6cyaQIXsKBgcgoJRx3qCiNe8/zl/H6T
        LZ2FhQ+DDmCvLw6muMYO9DQrWvYzMCICnw==
X-Google-Smtp-Source: AGRyM1vxZ0841XxWaJKRa5R5A1YHPtN6Ons9BuIBifwUAV4vIOHS8RAt919srWWMeFHepZC+4FbVyg==
X-Received: by 2002:adf:e2cb:0:b0:20c:c1bb:9fcb with SMTP id d11-20020adfe2cb000000b0020cc1bb9fcbmr2605182wrj.35.1655350619151;
        Wed, 15 Jun 2022 20:36:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i2-20020adffdc2000000b00213ba4b5d94sm695541wrs.27.2022.06.15.20.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 20:36:58 -0700 (PDT)
Message-Id: <pull.1263.v2.git.1655350617442.gitgitgadget@gmail.com>
In-Reply-To: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
References: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 03:36:57 +0000
Subject: [PATCH v2] send-pack.c: add config push.useBitmaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, kylezhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kyle Zhao <kylezhao@tencent.com>

This allows you to disable bitmaps for "git push". Default is false.

Reachability bitmaps are designed to speed up the "counting objects"
phase of generating a pack during a clone or fetch. They are not
optimized for Git clients sending a small topic branch via "git push".
In some cases (see [1]), using reachability bitmaps during "git push"
can cause significant performance regressions.

Add a new "push.useBitmaps" config option to disable reachability
bitmaps during "git push". This allows reachability bitmaps to still
be used in other areas, such as "git rev-list --use-bitmap-index".

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1263%2Fkeyu98%2Fkz%2Fpush-usebitmps-config-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1263/keyu98/kz/push-usebitmps-config-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1263

Range-diff vs v1:

 1:  000d033584b ! 1:  42e0b4845b2 send-pack.c: add config push.useBitmaps
     @@ Metadata
       ## Commit message ##
          send-pack.c: add config push.useBitmaps
      
     -    This allows you to disabled bitmaps for "git push". Default is false.
     +    This allows you to disable bitmaps for "git push". Default is false.
      
     -    Bitmaps are designed to speed up the "counting objects" phase of
     -    subsequent packs created for clones and fetches.
     -    But in some cases, turning bitmaps on does horrible things for "push"
     -    performance[1].
     +    Reachability bitmaps are designed to speed up the "counting objects"
     +    phase of generating a pack during a clone or fetch. They are not
     +    optimized for Git clients sending a small topic branch via "git push".
     +    In some cases (see [1]), using reachability bitmaps during "git push"
     +    can cause significant performance regressions.
     +
     +    Add a new "push.useBitmaps" config option to disable reachability
     +    bitmaps during "git push". This allows reachability bitmaps to still
     +    be used in other areas, such as "git rev-list --use-bitmap-index".
      
          [1]: https://lore.kernel.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/
      
     @@ Documentation/config/push.txt: push.negotiate::
       	in common.
      +
      +push.useBitmaps::
     -+	If this config and `pack.useBitmaps` are both "true", git will
     -+	use pack bitmaps (if available) when git push. Default is false.
     - \ No newline at end of file
     ++    If this config and `pack.useBitmaps` are both `true`, then Git will
     ++    use reachability bitmaps during `git push`, if available (disabled
     ++    by default).
      
       ## send-pack.c ##
      @@ send-pack.c: static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
     @@ send-pack.c: static int pack_objects(int fd, struct ref *refs, struct oid_array
       	po.out = args->stateless_rpc ? -1 : fd;
       	po.git_cmd = 1;
      @@ send-pack.c: int send_pack(struct send_pack_args *args,
     - 	int use_push_options = 0;
     - 	int push_options_supported = 0;
     - 	int object_format_supported = 0;
     -+	int use_bitmaps = 0;
     - 	unsigned cmds_sent = 0;
     - 	int ret;
       	struct async demux;
     + 	const char *push_cert_nonce = NULL;
     + 	struct packet_reader reader;
     ++	int use_bitmaps;
     + 
     + 	if (!remote_refs) {
     + 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
      @@ send-pack.c: int send_pack(struct send_pack_args *args,
     - 	git_config_get_bool("push.negotiate", &push_negotiate);
       	if (push_negotiate)
       		get_commons_through_negotiation(args->url, remote_refs, &commons);
     -+	git_config_get_bool("push.usebitmaps", &use_bitmaps);
     -+	if (use_bitmaps)
     -+		args->use_bitmaps = 1;
       
     ++	if (!git_config_get_bool("push.usebitmaps", &use_bitmaps))
     ++		args->use_bitmaps = use_bitmaps;
     ++
       	git_config_get_bool("transfer.advertisesid", &advertise_sid);
       
     + 	/* Does the other end support the reporting? */
      
       ## send-pack.h ##
      @@ send-pack.h: struct send_pack_args {
     @@ t/t5516-fetch-push.sh: test_expect_success 'push warns or fails when using usern
      +test_expect_success 'push with config push.useBitmaps' '
      +	mk_test testrepo heads/main &&
      +	git checkout main &&
     -+	GIT_TRACE=1 git push testrepo main:test >/dev/null 2>stderr &&
     -+	grep "no-use-bitmap-index" stderr &&
     ++	GIT_TRACE2_EVENT="$PWD/default" \
     ++	git push testrepo main:test &&
     ++	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
     ++	--thin --delta-base-offset -q --no-use-bitmap-index <default &&
      +
      +	git config push.useBitmaps true &&
     -+	GIT_TRACE=1 git push testrepo main:test2 >/dev/null 2>stderr &&
     -+	! grep "no-use-bitmap-index" stderr
     ++	GIT_TRACE2_EVENT="$PWD/true" \
     ++	git push testrepo main:test2 &&
     ++	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
     ++	--thin --delta-base-offset -q <true &&
     ++
     ++	git config push.useBitmaps false &&
     ++	GIT_TRACE2_EVENT="$PWD/false" \
     ++	git push testrepo main:test3 &&
     ++	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
     ++	--thin --delta-base-offset -q --no-use-bitmap-index <false
      +'
      +
       test_done


 Documentation/config/push.txt |  5 +++++
 send-pack.c                   |  6 ++++++
 send-pack.h                   |  3 ++-
 t/t5516-fetch-push.sh         | 21 +++++++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index e32801e6c91..3f3ff66fe7c 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -137,3 +137,8 @@ push.negotiate::
 	server attempt to find commits in common. If "false", Git will
 	rely solely on the server's ref advertisement to find commits
 	in common.
+
+push.useBitmaps::
+    If this config and `pack.useBitmaps` are both `true`, then Git will
+    use reachability bitmaps during `git push`, if available (disabled
+    by default).
diff --git a/send-pack.c b/send-pack.c
index bc0fcdbb000..627e79d7623 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -84,6 +84,8 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
 		strvec_push(&po.args, "--progress");
 	if (is_repository_shallow(the_repository))
 		strvec_push(&po.args, "--shallow");
+	if (!args->use_bitmaps)
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
+		args->use_bitmaps = use_bitmaps;
+
 	git_config_get_bool("transfer.advertisesid", &advertise_sid);
 
 	/* Does the other end support the reporting? */
diff --git a/send-pack.h b/send-pack.h
index e148fcd9609..f7af1b0353e 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -26,7 +26,8 @@ struct send_pack_args {
 		/* One of the SEND_PACK_PUSH_CERT_* constants. */
 		push_cert:2,
 		stateless_rpc:1,
-		atomic:1;
+		atomic:1,
+		use_bitmaps:1;
 	const struct string_list *push_options;
 };
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index dedca106a7a..0d416d1474f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1865,4 +1865,25 @@ test_expect_success 'push warns or fails when using username:password' '
 	test_line_count = 1 warnings
 '
 
+test_expect_success 'push with config push.useBitmaps' '
+	mk_test testrepo heads/main &&
+	git checkout main &&
+	GIT_TRACE2_EVENT="$PWD/default" \
+	git push testrepo main:test &&
+	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
+	--thin --delta-base-offset -q --no-use-bitmap-index <default &&
+
+	git config push.useBitmaps true &&
+	GIT_TRACE2_EVENT="$PWD/true" \
+	git push testrepo main:test2 &&
+	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
+	--thin --delta-base-offset -q <true &&
+
+	git config push.useBitmaps false &&
+	GIT_TRACE2_EVENT="$PWD/false" \
+	git push testrepo main:test3 &&
+	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
+	--thin --delta-base-offset -q --no-use-bitmap-index <false
+'
+
 test_done

base-commit: 8168d5e9c23ed44ae3d604f392320d66556453c9
-- 
gitgitgadget
