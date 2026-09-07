Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F347012A
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780023; cv=none; b=XEj56cOYzSE8hlsiwPk1tv8d70wSAXmDCQ/LeVHLpa4DMq1Yim55jrxFGmoohnLQ+mYCvatCS/24AS2z26S0JG4fGQiHhRLi/6+5ThpGQw7Av4N0vygtFE9AoQE8hzFt9WDYXXk3dqxfSk3sS3OnTIBM2sHHCXOjz0AqgrunG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780023; c=relaxed/simple;
	bh=KXYGnRejJK1mvp7H3DsfxfnNv8ykXPa1SDLIgELSaJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hmQsYRSP0ECnTWET3AJqB7X/bsyEOL7y4lpDmBDne79RqvRIKGOERf1Q9R4HFPtQX+Efek2nEMduK+24sYLcEiNxPex2u9lnCUf6jX71n+FZBpBfpzdrIUnY6RQrxYhPy/EnC7e9eH09GJSsngbPWCDb6DFFv7xqi41nZ2aYzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KR5mF4Pu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g7lbRXu/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KR5mF4Pu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g7lbRXu/"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D0C2414001CA;
	Mon,  7 Sep 2026 07:20:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 07 Sep 2026 07:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788780020;
	 x=1788866420; bh=L0MhAcmekCfRmsfFOuwNbgAzo0BAxNw++RABB7Egesg=; b=
	KR5mF4Puz3SQu1fAgPGPGzI1lDDawpGl0EMgM1g2QeLrR+pWIK8hICrEnB5pI6g7
	PLLlAJiySkyM7a5Wb/WdecCBZ21UXCnOzjNbvWRDWpWdGiBjUNLRF3tP7A7PHirc
	22qqdnqnbZ1yxud6CssDfe20cA9VzTuwUWESSrbPMJ46780M/hZ9lnGHyW92fPwW
	sIaoOnB6Y+a6c2zqImNokCu1WzNHFCbtW4pOrwUYoNxqASTYzTBTbnfSAOAJbPEX
	tbRpGQTbwuavoDPjsfbSq9tkvzMwxDBOG+XLj+OyrlDz32aY5vngvxipjgywS1Di
	IYJRPs25h+9R8e/PzxH0hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788780020; x=
	1788866420; bh=L0MhAcmekCfRmsfFOuwNbgAzo0BAxNw++RABB7Egesg=; b=g
	7lbRXu/kj9oueLD+MikZDYhZAo8dsiPXx2diLiTeraSJCwTBKPJXSnHQWDLHX9S+
	4dc8IJraHIVwhFvM+5xP+tD6Aitab6LoxhCig+tmP7K75vRKTi72/nky3CrT6zwC
	YO5xRfu1qbJk1/Pm5ggDNfVTYhQ7xitWRp5JeMU8bMXWHoxIeABqYCQxHlGZv6gd
	YKxeL7TeSWVNzAgZvwcA2FYugurlQnf3gRCFwT5owFCjASFcOf3JTWGb/yxLk/17
	syGnsYDe5Tj/77JSlpsyCMDk99yAKNEXUORzJi51FRx0i5esQaGhKw9c5b8dtAUD
	1tvIVuuIti10YyeBT1ANA==
X-ME-Sender: <xms:9J2eapxnKlSm8XHDhAIALj7UQ1kujD1klRv2wvr6WL68YjrHei2yBg>
    <xme:9J2eags9xmx6e7gWhZqMWM3PyCMAKY4rsuJbbL9pCvse4AFZL__EUR-R3rOAvy9uc
    kS_tc_RvOvR_7w0pU713f37_teyWald1yrvUNli6AtUB2VFyi2v4g>
X-ME-Received: <xmr:9J2eagvo4W8-KbioM_-m1iQSXbUNyMWzpuM4RyvyLT6VuAFKk6fNQg>
X-ME-Proxy-Cause: dmFkZTGh+ntQuPPRCjeOHi8eBWK5m+vsTdo4B135eNBn9xjB4a9zN4GRxrRt7ufClAIl3+
    7DTVnBB+chKMByq92+dilJ4J+ILxHOo9af3b8PgjbNehM6+mCpLBsjD3DQkDpjdeMGk5nY
    H9OqniAY0yEl8KfSnUeS3mQRawSxd1v+F+nankPtzxY0uHouSCiFQxjyazTc735sN+T2hS
    tLX+Lss1Br8/c+GWKysXtyMdZ6sVtBOUcm1gaRtzH0naLjwcySt0SPM/ivMPpz87mbX3F8
    7t45YSMSrFLlOVO2l5h6HEcV0S/0CjeD7oPCkYvLI6bXUqDTcrPC6ykW3ArnoyZBSMXnKH
    vWp0p+QpJ69q633HRllsVUevTAt6FI3GckRg7gBWuo2A9/j1DH2mzgbPjGVr74jWHPPrp5
    jlo1r1K+z35lrlW1V4Nlp9KGW8PC+PIQh7zrPBOGpHRcrV4zCCDFdR1dHyzCp3RjrRDiDP
    8EmtR7ALU9629Y1CkcxRlSXyCAf3F8n8wpUURkYTbNf36fMivid8s6YVl0e4zVXH98uuGI
    eN5/OHreqAnGiK2QX+SY4zWYlyPw7EsMOekStG2ihvUJHJd85GYy4M6zSsHI81+jgc6sQz
    zh30nPOvV8h670IUkJsdebFUxjWb2jalhZbx5KYoLZd7nUva3irqB2+swufg
X-ME-Proxy: <xmx:9J2ealMymPbiHARpWftmKfSOe3bzdKHZRvnL3X10hRbtQqyLBgUjSg>
    <xmx:9J2eau166YTlCdqE9u-nwYJ6zDjIWqlVPcJ5AGnc8NIZCIYNSxFRwA>
    <xmx:9J2eahPG5z6xVOhwCxMRhXAYHBjGdcFt0iDOkbv46hEF5dD9wJFghQ>
    <xmx:9J2eau1x-4VmepmpV0NUcs2EbhaTUgdPrj0h3sVTd62tgl_apDbXtg>
    <xmx:9J2ealW4GVIHEmwLYX2UIlkFY7puhRVI5nJslKg8Z8-kL2-w0GVD7W_G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 07:20:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e5e7b10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 11:20:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 13:18:38 +0200
Subject: [PATCH v2 04/11] builtin/submodule: rename "--ref-format=" to
 "--ref-storage-format="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-b4-pks-unify-ref-storage-format-v2-4-6733c90ca5b0@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename "--ref-format=" to
"--ref-storage-format=" and keep the old name as an alias.

Note that this commit is a bit more complex compared to the others as we
also need to adapt the submodule helper for consistency. But overall,
the changes are straight-forward and in the same spirit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-submodule.adoc       |  8 ++++----
 builtin/clone.c                        |  2 +-
 builtin/submodule--helper.c            | 24 +++++++++++++++---------
 git-submodule.sh                       | 20 ++++++++++----------
 t/t7424-submodule-mixed-ref-formats.sh |  8 ++++----
 5 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index 722d827908..d22fd4a5b0 100644
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
@@ -72,7 +72,7 @@ location, and only the superproject's URL needs to be provided.
 git-submodule will correctly locate the submodule using the relative
 URL in `.gitmodules`.
 +
-If `--ref-format <format>`  is specified, the ref storage format of newly
+If `--ref-storage-format <format>`  is specified, the ref storage format of newly
 cloned submodules will be set accordingly.
 
 `status [--cached] [--recursive] [--] [<path>...]`::
@@ -139,7 +139,7 @@ If you really want to remove a submodule from the repository and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
 options.
 
-`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference=<repository>] [--ref-format=<format>] [--depth=<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter=<filter-spec>] [--] [<path>...]`::
+`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference=<repository>] [--ref-storage-format=<format>] [--depth=<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter=<filter-spec>] [--] [<path>...]`::
 +
 --
 Update the registered submodules to match what the superproject
@@ -188,7 +188,7 @@ submodule with the `--init` option.
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 
-If `--ref-format <format>`  is specified, the ref storage format of newly
+If `--ref-storage-format <format>`  is specified, the ref storage format of newly
 cloned submodules will be set accordingly.
 
 If `--filter <filter-spec>` is specified, the given partial clone filter will be
diff --git a/builtin/clone.c b/builtin/clone.c
index 511fff9562..93be65efcd 100644
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
index e7cd3225fa..55eaaab38f 100644
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
@@ -2057,8 +2057,10 @@ static int module_clone(int argc, const char **argv, const char *prefix,
 		OPT_STRING_LIST(0, "reference", &reference,
 			   N_("repo"),
 			   N_("reference repository")),
-		OPT_STRING(0, "ref-format", &ref_storage_format, N_("format"),
-			   N_("specify the reference format to use")),
+		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
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
+		strvec_pushf(&child->args, "--ref-storage-format=%s",
 			     ref_storage_format_to_name(suc->update_data->ref_storage_format));
 	strvec_pushl(&child->args, "--path", sub->path, NULL);
 	strvec_pushl(&child->args, "--name", sub->name, NULL);
@@ -2801,7 +2803,7 @@ static void update_data_to_args(const struct update_data *update_data,
 			strvec_pushl(args, "--reference", item->string, NULL);
 	}
 	if (update_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
-		strvec_pushf(args, "--ref-format=%s",
+		strvec_pushf(args, "--ref-storage-format=%s",
 			     ref_storage_format_to_name(update_data->ref_storage_format));
 	if (update_data->filter_options && update_data->filter_options->choice)
 		strvec_pushf(args, "--filter=%s",
@@ -3010,8 +3012,10 @@ static int module_update(int argc, const char **argv, const char *prefix,
 			SM_UPDATE_REBASE),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
 			   N_("reference repository")),
-		OPT_STRING(0, "ref-format", &ref_storage_format, N_("format"),
-			   N_("specify the reference format to use")),
+		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
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
+		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
+			   N_("specify the reference storage format to use")),
+		OPT_STRING_F(0, "ref-format", &ref_storage_format, N_("format"),
+			     N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
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
index 9081401509..2ef85289b3 100755
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
 
@@ -63,7 +63,7 @@ test_expect_success 'recursive clone propagates ref storage format' '
 	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_FORMAT" &&
 
 	# The cloned repositories should use the other ref format that we have
-	# specified via `--ref-storage`. The option should propagate to cloned
+	# specified via `--ref-storage-format`. The option should propagate to cloned
 	# submodules.
 	git clone --ref-storage-format=$OTHER_FORMAT --recurse-submodules \
 		upstream downstream &&
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
2.55.0.1007.g17ff1f9808.dirty

