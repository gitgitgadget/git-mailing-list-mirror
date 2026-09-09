Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645753A89E
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952397; cv=none; b=l91exDAmB5Mijf4FV/Bnxvnb3+LuMbbBJxcRtkWbnK1Lk/61g97FMAR1AA9HHrBrQT6VmlOBUpK88kRGG8hscslhUuSkd4nAje7t+Y5Qve7ikd5Lj5dbJFDftNCzq3srs9K6U8SsLVUjAUR8Y1A0nyPzdogkZ4gUpW//brpvex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952397; c=relaxed/simple;
	bh=YBVB+fAC0cHAFEwXHQedGWZqCHylsQN44OeLwzd9oV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bAWrRWZJ/3/3dRhtqmkxAGvksguQT4mJFG2VBINevoaD3/5y9rZKk1/4pK9V84ZzE0TZtau8NTg7RQsFenkAeSnThUh0YchoF+Vj0kJTF5StDv/3a0LmEe/aHBNBTm/mz5kp4GGJk2bvXXbJnyS5E5YBx+zzZK3sE/9wp+29hj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=u0MJDt7q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pPY0pZ23; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u0MJDt7q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pPY0pZ23"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 839BF1400085;
	Wed,  9 Sep 2026 07:13:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 09 Sep 2026 07:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788952389;
	 x=1789038789; bh=ugtzUTUg/aw12avzq30l960UVg4pycnhgZWDzFI0CR8=; b=
	u0MJDt7qVpd5Dtbxwu8S0sxnDIfNA2DHil596ZDqEaWAxgedYFQQsqAB2qrz7mgX
	PFLma+goh+XJuJnBdvaYhJf5WABNo5qLZIp16MMz21rr3BKdNx3dDvZXm133ITQh
	zVycm3IiGInGhJ3CdXTW8oQ6bIhgI0I+lJ+fxk8wsENapx4LEveZEvYnWv7HnxRg
	Sbk8qtgV12xRMuyk+O1HdnLG72rpp5iqX9Uh3j/nxikx6xrAvQpsXhF0XnwrE77W
	zz94QTqPZpQb6+4buL+vvCaB4O0BI63Rc+m0eN1ic471mlHxeX34Gq1c7e8hIVv5
	XE3TALe1V5Sm9pbuXUes+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788952389; x=
	1789038789; bh=ugtzUTUg/aw12avzq30l960UVg4pycnhgZWDzFI0CR8=; b=p
	PY0pZ236qivfRfpQAPLLTRXBFUKypn8xN9WOHUMcbqJtd5WfZjRHEauGZMr8Bl0f
	mcsyWTmVxQBLPNoIvWRiMhTpDMrCSzZxDtnwveeWpmxpYGGfLUBwkslbcOO+M3lb
	sRll3g3iBrsd/xj0MtyHltWljkYca+467osJLiTy2rwoAiIvSQcIa8mm7mWHzq64
	KF8OIatro/4YwZijYumHvZr8/QNW+UxEtlqTgpWGpS/I4k3ZAAzl9wShKE6mN3+0
	Jkt6XALoFHTHhz0v7T/VRNCr5LK7WhO1zMqGR4IzllKsDjNE2ctx40UbNg+EyIOq
	C+7XvAOBuOqUO75XjpaKQ==
X-ME-Sender: <xms:RT-hajWc1Y2qYrx4V0hqcPthPLA9N0FrliS2lu9dAgrBYfd2cEgdsg>
    <xme:RT-hainhVajUWPTRkP9gHSYXOyBCxLgyS3leevvH0FMeQs1RKjj2c8J1PMt4mgdHX
    e5zWn7kp5RaCyHvk0nIX2l5I13MLRIX93pBeNH3UPhhq1HKIbRXBBg>
X-ME-Received: <xmr:RT-hakbCkWINizgmW0ufHLAzpDRl3lzgjyuC5b5m7tRAyrShvwkXdrw3zKYPWIAJ8qYVNA>
X-ME-Proxy-Cause: dmFkZTEgs4mPvK/J4KadefVWhuMxnXVkl/Ljr8GuCQd0gcO5l63UJ7EXlC8TLyLpUtEIKR
    oJINO8cAKEKUB+NdWoMBAysV15i9YbwWsP8TaPW5YBjSlD7KzITnOaPqW9YWL+fu4+8nLq
    Y0L+VUQcat6bZ9NpIXFy+ByD9h5RH9yHa6Qa/0THEVS8DVCcr9CEUXeDsgDRabq0kHPwSV
    FOJOK9H1RmwKYbxnkX9ULWp7wMrrWom7VFI/pPBoke88eaoyNT4OqKVGuTkQ6h1ROWpTq/
    c2DO1rMiZoIJM0i9Pgla0k7tRCg4BD86RwtEXctgHfj8Z58H6kf0XTviw0NiU3SYA5auSP
    UzunQbgX0QBCK50H3yntzUKDzfJV2Re/731vgmg4/WgpU7pMUxTvq5qWZtvatg9y4CQ5Zb
    ei/gUvDcO7IVtpemHlEol4CIRyBPBonvNTwBNLTvqESnZySyXZgzJfUFGh/yjvGFLQoyIx
    Y23q9iu4cZrcwdWzeTodxY0gc46vJ1Ir7higKmXToeySR/l9U8wv/coQxsMxrpt9vW8O+H
    sfrn2/nlxfbJR8LWxR5biGZkvEuScOQfp36viHFbgOwqrc56TyO7CP6iNYazW4Wuk8vtE5
    Z9SdYWbRS7/gUE5zBtEiL18koXzefRrqqRxtlJwYyNxjTlW+XVkmVMNcspHg
X-ME-Proxy: <xmx:RT-hatOpQpIFM2O86pTNY1Gbk9qHXVGvm1x4WzMUZhwMmDUJnBhjzA>
    <xmx:RT-hapYWu2DHTGpBpb7xvkbvojD6M6I7w1NhAsTW2N1vaoDvbFgt4w>
    <xmx:RT-har2v0XqlQNInb7dVbVpzwdCt1R4TsZ5EvDmndLK-zZ3kiu92zQ>
    <xmx:RT-have0Uh8JEA6z8Z2cHld0AXGwIKO8PFDMY6r8QvG4HmTUU8WtPQ>
    <xmx:RT-hav47HgIW-Q7aQ8jIJDNbcO2QsucNnManZHiNbM0LC1A3HzXa1Dx7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 07:13:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed972082 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 11:13:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 13:12:51 +0200
Subject: [PATCH v3 05/13] builtin/submodule: rename "--ref-format=" to
 "--ref-storage-format="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-pks-unify-ref-storage-format-v3-5-ca041fb40ad8@pks.im>
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename "--ref-format=" to
"--ref-storage-format=" and keep the old name as an alias.

Note that this commit is a bit more complex compared to the others as we
also need to adapt the submodule helper for consistency. But overall,
the changes are straight-forward and in the same spirit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-submodule.adoc       | 14 ++++++++------
 builtin/clone.c                        |  2 +-
 builtin/submodule--helper.c            | 21 ++++++++++++---------
 git-submodule.sh                       | 20 ++++++++++----------
 t/t7424-submodule-mixed-ref-formats.sh |  6 +++---
 5 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index 722d827908..e9c81a7170 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -34,7 +34,7 @@ COMMANDS
 With no arguments, shows the status of existing submodules.  Several
 subcommands are available to perform operations on the submodules.
 
-`add [-b <branch>] [-f | --force] [--name <name>] [--reference <repository>] [--ref-format <format>] [--depth <depth>] [--] <repository> [<path>]`::
+`add [-b <branch>] [-f | --force] [--name <name>] [--reference <repository>] [--ref-storage-format <format>] [--depth <depth>] [--] <repository> [<path>]`::
 	Add the given repository as a submodule at the given path
 	to the changeset to be committed next to the current
 	project: the current project is termed the "superproject".
@@ -72,8 +72,9 @@ location, and only the superproject's URL needs to be provided.
 git-submodule will correctly locate the submodule using the relative
 URL in `.gitmodules`.
 +
-If `--ref-format <format>`  is specified, the ref storage format of newly
-cloned submodules will be set accordingly.
+If `--ref-storage-format <format>` or its deprecated alias `--ref-format
+<format>` is specified, the ref storage format of the newly cloned submodules
+will be set accordingly.
 
 `status [--cached] [--recursive] [--] [<path>...]`::
 	Show the status of the submodules. This will print the SHA-1 of the
@@ -139,7 +140,7 @@ If you really want to remove a submodule from the repository and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
 options.
 
-`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference=<repository>] [--ref-format=<format>] [--depth=<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter=<filter-spec>] [--] [<path>...]`::
+`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference=<repository>] [--ref-storage-format=<format>] [--depth=<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter=<filter-spec>] [--] [<path>...]`::
 +
 --
 Update the registered submodules to match what the superproject
@@ -188,8 +189,9 @@ submodule with the `--init` option.
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 
-If `--ref-format <format>`  is specified, the ref storage format of newly
-cloned submodules will be set accordingly.
+If `--ref-storage-format <format>` or its deprecated alias `--ref-format
+<format>` is specified, the ref storage format of the newly cloned submodules
+will be set accordingly.
 
 If `--filter <filter-spec>` is specified, the given partial clone filter will be
 applied to the submodule. See linkgit:git-rev-list[1] for details on filter
diff --git a/builtin/clone.c b/builtin/clone.c
index 42cae9e0f6..dd722e4de1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -725,7 +725,7 @@ static int checkout(int submodule_progress,
 		}
 
 		if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
-			strvec_pushf(&cmd.args, "--ref-format=%s",
+			strvec_pushf(&cmd.args, "--ref-storage-format=%s",
 				     ref_storage_format_to_name(ref_storage_format));
 
 		if (filter_submodules && filter_options->choice)
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e7cd3225fa..41883af2ac 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1941,7 +1941,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 					     item->string, NULL);
 		}
 		if (clone_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
-			strvec_pushf(&cp.args, "--ref-format=%s",
+			strvec_pushf(&cp.args, "--ref-storage-format=%s",
 				     ref_storage_format_to_name(clone_data->ref_storage_format));
 		if (clone_data->dissociate)
 			strvec_push(&cp.args, "--dissociate");
@@ -2057,8 +2057,9 @@ static int module_clone(int argc, const char **argv, const char *prefix,
 		OPT_STRING_LIST(0, "reference", &reference,
 			   N_("repo"),
 			   N_("reference repository")),
-		OPT_STRING(0, "ref-format", &ref_storage_format, N_("format"),
-			   N_("specify the reference format to use")),
+		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
+			   N_("specify the reference storage format to use")),
+		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
 		OPT_BOOL(0, "dissociate", &dissociate,
 			   N_("use --reference only while cloning")),
 		OPT_INTEGER(0, "depth", &clone_data.depth,
@@ -2357,7 +2358,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (suc->update_data->require_init)
 		strvec_push(&child->args, "--require-init");
 	if (suc->update_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
-		strvec_pushf(&child->args, "--ref-format=%s",
+		strvec_pushf(&child->args, "--ref-storage-format=%s",
 			     ref_storage_format_to_name(suc->update_data->ref_storage_format));
 	strvec_pushl(&child->args, "--path", sub->path, NULL);
 	strvec_pushl(&child->args, "--name", sub->name, NULL);
@@ -2801,7 +2802,7 @@ static void update_data_to_args(const struct update_data *update_data,
 			strvec_pushl(args, "--reference", item->string, NULL);
 	}
 	if (update_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
-		strvec_pushf(args, "--ref-format=%s",
+		strvec_pushf(args, "--ref-storage-format=%s",
 			     ref_storage_format_to_name(update_data->ref_storage_format));
 	if (update_data->filter_options && update_data->filter_options->choice)
 		strvec_pushf(args, "--filter=%s",
@@ -3010,8 +3011,9 @@ static int module_update(int argc, const char **argv, const char *prefix,
 			SM_UPDATE_REBASE),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
 			   N_("reference repository")),
-		OPT_STRING(0, "ref-format", &ref_storage_format, N_("format"),
-			   N_("specify the reference format to use")),
+		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
+			   N_("specify the reference storage format to use")),
+		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
 		OPT_BOOL(0, "dissociate", &opt.dissociate,
 			   N_("use --reference only while cloning")),
 		OPT_INTEGER(0, "depth", &opt.depth,
@@ -3659,8 +3661,9 @@ static int module_add(int argc, const char **argv, const char *prefix,
 		OPT_BOOL(0, "progress", &progress, N_("force cloning progress")),
 		OPT_STRING(0, "reference", &add_data.reference_path, N_("repository"),
 			   N_("reference repository")),
-		OPT_STRING(0, "ref-format", &ref_storage_format, N_("format"),
-			   N_("specify the reference format to use")),
+		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
+			   N_("specify the reference storage format to use")),
+		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
 		OPT_BOOL(0, "dissociate", &dissociate, N_("borrow the objects from reference repositories")),
 		OPT_STRING(0, "name", &add_data.sm_name, N_("name"),
 			   N_("sets the submodule's name to the given string "
diff --git a/git-submodule.sh b/git-submodule.sh
index 2999b31fad..8632194138 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -95,13 +95,13 @@ cmd_add()
 		--reference=*)
 			reference="$1"
 			;;
-		--ref-format)
+		--ref-format|--ref-storage-format)
 			case "$2" in '') usage ;; esac
-			ref_format="--ref-format=$2"
+			ref_storage_format="--ref-storage-format=$2"
 			shift
 			;;
-		--ref-format=*)
-			ref_format="$1"
+		--ref-format=*|--ref-storage-format=*)
+			ref_storage_format="$1"
 			;;
 		--dissociate)
 			dissociate=$1
@@ -147,7 +147,7 @@ cmd_add()
 		$progress \
 		${branch:+"$branch"} \
 		${reference:+"$reference"} \
-		${ref_format:+"$ref_format"} \
+		${ref_storage_format:+"$ref_storage_format"} \
 		$dissociate \
 		${name:+"$name"} \
 		${depth:+"$depth"} \
@@ -302,13 +302,13 @@ cmd_update()
 		-r|--rebase)
 			rebase=$1
 			;;
-		--ref-format)
+		--ref-format|--ref-storage-format)
 			case "$2" in '') usage ;; esac
-			ref_format="--ref-format=$2"
+			ref_storage_format="--ref-storage-format=$2"
 			shift
 			;;
-		--ref-format=*)
-			ref_format="$1"
+		--ref-format=*|--ref-storage-format=*)
+			ref_storage_format="$1"
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
@@ -385,7 +385,7 @@ cmd_update()
 		$rebase \
 		$merge \
 		$checkout \
-		${ref_format:+"$ref_format"} \
+		${ref_storage_format:+"$ref_storage_format"} \
 		${reference:+"$reference"} \
 		$dissociate \
 		${depth:+"$depth"} \
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
index e61389af05..2ef85289b3 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -44,7 +44,7 @@ test_expect_success 'add submodules with different ref storage format' '
 	test_commit -C submodule submodule-initial &&
 	git init upstream &&
 	test_ref_format upstream "$GIT_DEFAULT_REF_FORMAT" &&
-	git -C upstream submodule add --ref-format="$OTHER_FORMAT" "file://$(pwd)/submodule" &&
+	git -C upstream submodule add --ref-storage-format="$OTHER_FORMAT" "file://$(pwd)/submodule" &&
 	test_ref_format upstream/submodule "$OTHER_FORMAT"
 '
 
@@ -82,7 +82,7 @@ test_expect_success 'clone submodules with different ref storage format' '
 
 	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
 	test_ref_format downstream "$GIT_DEFAULT_REF_FORMAT" &&
-	git -C downstream submodule update --init --ref-format=$OTHER_FORMAT &&
+	git -C downstream submodule update --init --ref-storage-format=$OTHER_FORMAT &&
 	test_ref_format downstream/submodule "$OTHER_FORMAT"
 '
 
@@ -122,7 +122,7 @@ test_expect_success 'recursive pull with mixed formats' '
 	# Clone the upstream repository such that the main repo and its
 	# submodules have different formats.
 	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
-	git -C downstream submodule update --init --ref-format=$OTHER_FORMAT &&
+	git -C downstream submodule update --init --ref-storage-format=$OTHER_FORMAT &&
 	test_ref_format downstream "$GIT_DEFAULT_REF_FORMAT" &&
 	test_ref_format downstream/submodule "$OTHER_FORMAT" &&
 

-- 
2.55.0.1074.ge7621b4bad.dirty

