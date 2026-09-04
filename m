Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD88470112
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518186; cv=none; b=S/GPwRGawBoBwcgEUE3QSwusbrhlv1b+rZ0DpiJWKHKIVpkYPNyeYDQodxdMV85PWGQMuBrIL9O6w0LYPwh7z/LwYD9u3P/58nwz1J7oDGvklT+0OGWmjtnWlKXPhr9TlIjAPGb03jLE+M8aU74hWDs5fLijeasLxxtV9+01Jr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518186; c=relaxed/simple;
	bh=A4UCHRyBVqFvXIhfQ8oFCd3NkpWqlDH+TeYoETdbBZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+AA/0Ra6cYJU1M2M3E32EFfipZNXlgSIeShbc9QRm80SBS2uOVAQAlONPX7genz78ZgHg8uCn9YJPYNFthLLWN3UXmv/JcDBu2v1LuaIGBJxnZtyHkN1DMXdYUDNR14uNS3B7ainskcOwXbnKlPVpuE+rMVp4AVJLeU7jU3TsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mRR16abr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YZo7tuna; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mRR16abr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YZo7tuna"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C68BD7A0138;
	Fri,  4 Sep 2026 06:36:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 06:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788518183;
	 x=1788604583; bh=0+ljCE5iYjdMRUUrqBnqtOgzRzLfMf1gP5IqkMmAEqc=; b=
	mRR16abri5CzD8xDMdLRkUvYk/ujTZtidmvwzdbn0Ts9IwzpxfQKLzELTreFZ8/o
	orQJY4dHxNjZusy23pzx2SksQqmH2yUiQ82oiUAzS31QLoC/upgMnemKHuBq+U1G
	Y5n7UQzICRUtCkQHts0vzxOOAKRWAErDeRpkymhM4IDfU/LPo5KjOKJTxfiYlBV8
	yTL0gaWTqIQlyQLGNufPEy78zFW4xcknGXWTGY1Y5rDr3VAwRWqVieKpH8flNhXE
	801Z/gGSYCD5apsfyk3Jb//OqaKSzumem3HLFZsWsAzF3RH7JsPEKLQKm4d1L7NS
	E+0MeYcNzJP6QhD/X5Ts1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788518183; x=
	1788604583; bh=0+ljCE5iYjdMRUUrqBnqtOgzRzLfMf1gP5IqkMmAEqc=; b=Y
	Zo7tunahWmSI8cUnVjPSwDZqpwUV98Zr5Z17daYluQqRO11ZMs19S3IB3/TinsXp
	qp8aIDwB8467iUbWrpcRa+K2Es/zvjy6SW1lYLujeyk47TfBbpK4AlkdFkpOnbV+
	O04JIeGiA9KLsfHw7JL7hZL8KLPjA8cyx5jtVt6xYCaMG1iKn13u0mhEfYd2809z
	q+hEJ+vskLSfzEnxt6ofBRVFT6+ATPJIhYpmZiP0X6VGhlglldqc27uXExl1vpZn
	MQi8S+e04+3kWPhbrTRLxmFtyK8RiXQv0HCDy93U8u2z/MGtI8QjhLpCFxnaS5b4
	Lyf6vby5qjYyETdcHrp5g==
X-ME-Sender: <xms:J5-aam4rBwPPqpavFPwWZX9XnQ83PrrlDZGLKVojikh56Y2ZbRIkgA>
    <xme:J5-aal7xDQHw65zD695qggdVDnxKxGf5nXx3TrFg0yjpR_LPCfsMqAsbErq5241pK
    C9D2d-q8Jc_Kg9rfaJvMFf2V4x_voXdhCeit-cZUBUCsyNCbBDITw>
X-ME-Received: <xmr:J5-aajEvuzQWgvruOE2eTfk7tqHhVoUAI1KuzrqXAJ2vzjzM4RJV6_8-kIwyO46zHYTlVg>
X-ME-Proxy-Cause: dmFkZTGz6D4YEbRdDrI6Swe/8q+Lu7kgrJ4joEx/DD4DhnNY9fOvRsdqoyg+mhwVBRG6wg
    ANR+o05wxYgYD0OE9AlLxIBBz+MyJp5OTVWpiY1EiLOW3Shz/hWnIdk2kSS0QkDhli39oN
    +6ZznalTze7BAokCKwPeM9gubUaHIjLuuDil0CZsLyLG34fFQiAUKYcp9j9NW0AegGdYwD
    UA2or6p9scc4e7xkswRC7oCGXib0KoFAcPdcw0/u/UCf/r6CqdDYbccUyBLSfeb0e35Y5O
    M9A+2vK75VDWfPtw23erXdwwYT0euNi7l5eUiSuShz40VSHywMTvBa1qJ8DeiIXQuocPnF
    hxkkMXwzyUcvu/6K3CotTPGOjRa7Du727qm2FHvfs+8FhnOZaZcKKaw5m+5VHaDVOTdJrh
    qcEoWVQvdy7se1Zqqrg1i32mK9e16DVVTe2N4z9Rs9lrk/OyKXLmsyhT7XLAbcT7ANCcST
    5sqBv2fMTjoU16SQKrI5WGiLBNo1gfTWry1xXRPRX3koNldQBDJPBWrIR5TToWPRNJp2JD
    ycInY71Gg7pzJunu3snpmBB8HSNKh7ov+4lBoUcIcjCYig5pJ68hpkkawfMah3zhR+AuIs
    yyJKNZzANQjbhZaIidgssqWXzZtw/6+MdKpHpJcKScNuoCAfuy2ah3jQhxyQ
X-ME-Proxy: <xmx:J5-aauRmH8d28oFjMYZJCrMD-amEEi0BrV_r0cnuog6yWFtH_OI5sg>
    <xmx:J5-aasskxnroCXKgcmQQLri0a__K1Nj3bvOwbsHRfcVnm-WNi_SzjA>
    <xmx:J5-aatz3J96ptKdrs6j5CItk4D2Vt-qO3VgQnJhy5iM1mHm21fLb_w>
    <xmx:J5-aam7jGKJ4TuP-jHZyNNwgc6RxbR8LgeL97FAMmBUHgoC59ACHUA>
    <xmx:J5-aakqt7kfxi3Eqr-lgJRyKY4pp-PVFsHTnlN3pJyACvlxG1WerbhRa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 06:36:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21ef8d33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 10:36:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Sep 2026 12:36:05 +0200
Subject: [PATCH 04/11] builtin/submodule: rename "--ref-format=" to
 "--ref-storage="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-pks-unify-ref-storage-format-v1-4-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename "--ref-format=" to
"--ref-storage=" and keep the old name as an alias.

Note that this commit is a bit more complex compared to the others as we
also need to adapt the submodule helper for consistency. But overall,
the changes are straight-forward and in the same spirit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-submodule.adoc       |  8 ++++----
 builtin/clone.c                        |  2 +-
 builtin/submodule--helper.c            | 24 +++++++++++++++---------
 git-submodule.sh                       | 20 ++++++++++----------
 t/t7424-submodule-mixed-ref-formats.sh |  6 +++---
 5 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index 722d827908..a3713709b1 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -34,7 +34,7 @@ COMMANDS
 With no arguments, shows the status of existing submodules.  Several
 subcommands are available to perform operations on the submodules.
 
-`add [-b <branch>] [-f | --force] [--name <name>] [--reference <repository>] [--ref-format <format>] [--depth <depth>] [--] <repository> [<path>]`::
+`add [-b <branch>] [-f | --force] [--name <name>] [--reference <repository>] [--ref-storage <format>] [--depth <depth>] [--] <repository> [<path>]`::
 	Add the given repository as a submodule at the given path
 	to the changeset to be committed next to the current
 	project: the current project is termed the "superproject".
@@ -72,7 +72,7 @@ location, and only the superproject's URL needs to be provided.
 git-submodule will correctly locate the submodule using the relative
 URL in `.gitmodules`.
 +
-If `--ref-format <format>`  is specified, the ref storage format of newly
+If `--ref-storage <format>`  is specified, the ref storage format of newly
 cloned submodules will be set accordingly.
 
 `status [--cached] [--recursive] [--] [<path>...]`::
@@ -139,7 +139,7 @@ If you really want to remove a submodule from the repository and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
 options.
 
-`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference=<repository>] [--ref-format=<format>] [--depth=<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter=<filter-spec>] [--] [<path>...]`::
+`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference=<repository>] [--ref-storage=<format>] [--depth=<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter=<filter-spec>] [--] [<path>...]`::
 +
 --
 Update the registered submodules to match what the superproject
@@ -188,7 +188,7 @@ submodule with the `--init` option.
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 
-If `--ref-format <format>`  is specified, the ref storage format of newly
+If `--ref-storage <format>`  is specified, the ref storage format of newly
 cloned submodules will be set accordingly.
 
 If `--filter <filter-spec>` is specified, the given partial clone filter will be
diff --git a/builtin/clone.c b/builtin/clone.c
index 63bd7b795d..c4f9dc7472 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -725,7 +725,7 @@ static int checkout(int submodule_progress,
 		}
 
 		if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
-			strvec_pushf(&cmd.args, "--ref-format=%s",
+			strvec_pushf(&cmd.args, "--ref-storage=%s",
 				     ref_storage_format_to_name(ref_storage_format));
 
 		if (filter_submodules && filter_options->choice)
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e7cd3225fa..50bc4aeb4d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1941,7 +1941,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 					     item->string, NULL);
 		}
 		if (clone_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
-			strvec_pushf(&cp.args, "--ref-format=%s",
+			strvec_pushf(&cp.args, "--ref-storage=%s",
 				     ref_storage_format_to_name(clone_data->ref_storage_format));
 		if (clone_data->dissociate)
 			strvec_push(&cp.args, "--dissociate");
@@ -2057,8 +2057,10 @@ static int module_clone(int argc, const char **argv, const char *prefix,
 		OPT_STRING_LIST(0, "reference", &reference,
 			   N_("repo"),
 			   N_("reference repository")),
-		OPT_STRING(0, "ref-format", &ref_storage_format, N_("format"),
-			   N_("specify the reference format to use")),
+		OPT_STRING(0, "ref-storage", &ref_storage_format, N_("format"),
+			   N_("specify the reference storage format to use")),
+		OPT_STRING_F(0, "ref-format", &ref_storage_format, N_("format"),
+			     N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
 		OPT_BOOL(0, "dissociate", &dissociate,
 			   N_("use --reference only while cloning")),
 		OPT_INTEGER(0, "depth", &clone_data.depth,
@@ -2357,7 +2359,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (suc->update_data->require_init)
 		strvec_push(&child->args, "--require-init");
 	if (suc->update_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
-		strvec_pushf(&child->args, "--ref-format=%s",
+		strvec_pushf(&child->args, "--ref-storage=%s",
 			     ref_storage_format_to_name(suc->update_data->ref_storage_format));
 	strvec_pushl(&child->args, "--path", sub->path, NULL);
 	strvec_pushl(&child->args, "--name", sub->name, NULL);
@@ -2801,7 +2803,7 @@ static void update_data_to_args(const struct update_data *update_data,
 			strvec_pushl(args, "--reference", item->string, NULL);
 	}
 	if (update_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
-		strvec_pushf(args, "--ref-format=%s",
+		strvec_pushf(args, "--ref-storage=%s",
 			     ref_storage_format_to_name(update_data->ref_storage_format));
 	if (update_data->filter_options && update_data->filter_options->choice)
 		strvec_pushf(args, "--filter=%s",
@@ -3010,8 +3012,10 @@ static int module_update(int argc, const char **argv, const char *prefix,
 			SM_UPDATE_REBASE),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
 			   N_("reference repository")),
-		OPT_STRING(0, "ref-format", &ref_storage_format, N_("format"),
-			   N_("specify the reference format to use")),
+		OPT_STRING(0, "ref-storage", &ref_storage_format, N_("format"),
+			   N_("specify the reference storage format to use")),
+		OPT_STRING_F(0, "ref-format", &ref_storage_format, N_("format"),
+			     N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
 		OPT_BOOL(0, "dissociate", &opt.dissociate,
 			   N_("use --reference only while cloning")),
 		OPT_INTEGER(0, "depth", &opt.depth,
@@ -3659,8 +3663,10 @@ static int module_add(int argc, const char **argv, const char *prefix,
 		OPT_BOOL(0, "progress", &progress, N_("force cloning progress")),
 		OPT_STRING(0, "reference", &add_data.reference_path, N_("repository"),
 			   N_("reference repository")),
-		OPT_STRING(0, "ref-format", &ref_storage_format, N_("format"),
-			   N_("specify the reference format to use")),
+		OPT_STRING(0, "ref-storage", &ref_storage_format, N_("format"),
+			   N_("specify the reference storage format to use")),
+		OPT_STRING_F(0, "ref-format", &ref_storage_format, N_("format"),
+			     N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
 		OPT_BOOL(0, "dissociate", &dissociate, N_("borrow the objects from reference repositories")),
 		OPT_STRING(0, "name", &add_data.sm_name, N_("name"),
 			   N_("sets the submodule's name to the given string "
diff --git a/git-submodule.sh b/git-submodule.sh
index 2999b31fad..3d16f28ad6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -95,13 +95,13 @@ cmd_add()
 		--reference=*)
 			reference="$1"
 			;;
-		--ref-format)
+		--ref-format|--ref-storage)
 			case "$2" in '') usage ;; esac
-			ref_format="--ref-format=$2"
+			ref_storage="--ref-storage=$2"
 			shift
 			;;
-		--ref-format=*)
-			ref_format="$1"
+		--ref-format=*|--ref-storage=*)
+			ref_storage="$1"
 			;;
 		--dissociate)
 			dissociate=$1
@@ -147,7 +147,7 @@ cmd_add()
 		$progress \
 		${branch:+"$branch"} \
 		${reference:+"$reference"} \
-		${ref_format:+"$ref_format"} \
+		${ref_storage:+"$ref_storage"} \
 		$dissociate \
 		${name:+"$name"} \
 		${depth:+"$depth"} \
@@ -302,13 +302,13 @@ cmd_update()
 		-r|--rebase)
 			rebase=$1
 			;;
-		--ref-format)
+		--ref-format|--ref-storage)
 			case "$2" in '') usage ;; esac
-			ref_format="--ref-format=$2"
+			ref_storage="--ref-storage=$2"
 			shift
 			;;
-		--ref-format=*)
-			ref_format="$1"
+		--ref-format=*|--ref-storage=*)
+			ref_storage="$1"
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
@@ -385,7 +385,7 @@ cmd_update()
 		$rebase \
 		$merge \
 		$checkout \
-		${ref_format:+"$ref_format"} \
+		${ref_storage:+"$ref_storage"} \
 		${reference:+"$reference"} \
 		$dissociate \
 		${depth:+"$depth"} \
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
index 5c26fc18be..c20d981ef2 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -44,7 +44,7 @@ test_expect_success 'add submodules with different ref storage format' '
 	test_commit -C submodule submodule-initial &&
 	git init upstream &&
 	test_ref_format upstream "$GIT_DEFAULT_REF_FORMAT" &&
-	git -C upstream submodule add --ref-format="$OTHER_FORMAT" "file://$(pwd)/submodule" &&
+	git -C upstream submodule add --ref-storage="$OTHER_FORMAT" "file://$(pwd)/submodule" &&
 	test_ref_format upstream/submodule "$OTHER_FORMAT"
 '
 
@@ -82,7 +82,7 @@ test_expect_success 'clone submodules with different ref storage format' '
 
 	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
 	test_ref_format downstream "$GIT_DEFAULT_REF_FORMAT" &&
-	git -C downstream submodule update --init --ref-format=$OTHER_FORMAT &&
+	git -C downstream submodule update --init --ref-storage=$OTHER_FORMAT &&
 	test_ref_format downstream/submodule "$OTHER_FORMAT"
 '
 
@@ -122,7 +122,7 @@ test_expect_success 'recursive pull with mixed formats' '
 	# Clone the upstream repository such that the main repo and its
 	# submodules have different formats.
 	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
-	git -C downstream submodule update --init --ref-format=$OTHER_FORMAT &&
+	git -C downstream submodule update --init --ref-storage=$OTHER_FORMAT &&
 	test_ref_format downstream "$GIT_DEFAULT_REF_FORMAT" &&
 	test_ref_format downstream/submodule "$OTHER_FORMAT" &&
 

-- 
2.55.0.1007.g17ff1f9808.dirty

