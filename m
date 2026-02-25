Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EEF2E3B15
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056520; cv=none; b=CQyeYXzPHoKeoACedSw3mThgJ5pGofmUV8lCDIieA9xf5Vt3hKxQsk3akmbhPCg7SDfzkZlPGn3i6LYYZmAzXbw08HUdQkGiBXcl+ubptxw4FoNfLlEIcG1sjHE8MRPB3IlPQ2W7Ra30NOjO2GJYwa337/CpVfz7QaTh0JMneJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056520; c=relaxed/simple;
	bh=xshmAZIagUL6tCGCPK0beOYOJE6JbaxeZevIr0JI5Y4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UHh961ezU0kAKhYDPonEAJVK6QbaYoO8yu3oOwcI2zTzscyMf4CRMkEvdHMDShvUOljLd3JTYriJQlKYR5jOOPiISHYh6o2GwVXfyQUSaS13d1EXJXuRul9sTL7PBkUOBWAmWhVZO8tUIaIJESAa+ef3t+SQM2X6POyRBtOsiGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O+NOSVEV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bgVmEw5v; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O+NOSVEV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bgVmEw5v"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 05BD8EC0628;
	Wed, 25 Feb 2026 16:55:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 25 Feb 2026 16:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772056518;
	 x=1772142918; bh=zui2LyUpEY4CJX37vP934pl1TWkyCBzxgWvGlA1CWps=; b=
	O+NOSVEV9v9yiugM6tTJG99DRh5m7hI86dTyjE+Q8QNt8xWSnieHpCbgbBOXD5D1
	3noZ8kTYgKJ2Xp08/R9Yf9mjQTbx4objyW27JPYvAjHCe7Mg5zTzIhdHfyeBAtiY
	8/eLkyqCOtcIha1PSEgfxa2XRUTUao0hH5u2z/oCoFpu1mqcfRcXtEhiPfusMVkH
	wH0s2783/Wqq+d1V8g27i/eHvRJE4PJmF2EhYJoGOa2HrAk5FYGUWMK5Guov/fWv
	M4gcOnrVEAwvGUQVu56wxHbCgXnr0cFe5dC+rUan4wwlzGyVxsxf1U7bIeUiaUVi
	uVS+4M/poMSsKtb+dFrMvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772056518; x=
	1772142918; bh=zui2LyUpEY4CJX37vP934pl1TWkyCBzxgWvGlA1CWps=; b=b
	gVmEw5v7odKo5EadjxMv3AbYaAgOXSWv7bqKGUFcGwxm9qdABcPxuc8ctC5vdA5m
	CSuAQRaZoaWUKWjhN9X3JfmPdKdpABHa7FeiSdOzZ8qjsL7xaJf7XJmvoPn/vQ3f
	uWdGaAxgCkn1A5avhJ0HcJXv8yEGTRPcrNl7UhqssA5NZn3hjUeb5iVbYIJAsT6E
	7cDfbXqvyLkiyiNbuttekpCIWscLlu1wgXd7dFR9fcIOlKDk1Sjij6F5tmXpmvDa
	vxvowhWftOkZRI9BCGycvsTTSe+IHlN2cENJrv9FSJ9/qUltu8UPb1jeT/8yw99r
	2LVtJrA+6axsj60mxsapg==
X-ME-Sender: <xms:xW-faQqaEaC9v2pz-IlYALrB4JktKbACWVBd5i4mqFCXXBtqGWb7YA>
    <xme:xW-faf8BCYkRWk3nujzgdM_xLhglnol4fznXsckMs2rShG4z0p1lI1u7DPzXukBmv
    kHwxZGqKFPyN0l4vySzVD6EVgDPYlFls8K1gSwzpp8O36JLj5FkYQ>
X-ME-Received: <xmr:xW-facfCKtDsPPj1SSSMDUeEaZDS8B8pCPf6W0h4Oy6bWpMGhBXtG1VWNeSK-VmeB-c00IHctf-3toyEY6hVEUQqEB8OTwrA9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehnrghsshgvrhdrghhrrghinhgrfihisehoshhsrdhquhgrlhgt
    ohhmmhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xW-faZLX171zS-lRulYecynqJGSmvC6BQqKKuzKodDNbGxoX5hRFnw>
    <xmx:xW-fachrNCUpzb0Z_XJlrTIUPdn_Loxbwim66yMfgcNNOkEtuY7qJw>
    <xmx:xW-faXSYVbsmuj59k0zt5Xy5ANi-KvbABmmoF6yaSowLWlCCLbkBgQ>
    <xmx:xW-faWX9nbhy4PCmAEroiszXyCyKx9il_bMsogZkl53k960-8YiCyw>
    <xmx:xm-faTvbEgJquSXrBYa1zhSwef1Cb63S1qpHOd5Q9sUxGJl1R-1HMrl1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 16:55:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3] submodule: fetch missing objects from default remote
In-Reply-To: <CA+P7+xoYA6zhwVeCV6d5yW4ZxOKNLam3r-ayEDHpYpFqWyLduw@mail.gmail.com>
	(Jacob Keller's message of "Thu, 22 Jan 2026 12:16:53 -0800")
References: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
	<20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
	<xmqq5x8to53y.fsf@gitster.g>
	<CA+P7+xoYA6zhwVeCV6d5yW4ZxOKNLam3r-ayEDHpYpFqWyLduw@mail.gmail.com>
Date: Wed, 25 Feb 2026 13:55:16 -0800
Message-ID: <xmqq7bs08p4r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jacob Keller <jacob.keller@gmail.com> writes:

> On Thu, Jan 22, 2026 at 10:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Nasser Grainawi <nasser.grainawi@oss.qualcomm.com> writes:
>> ...
>> Thanks.  Jacob, this v3 is not exactly the same as v1 that you
>> reviewed (and range-diff relative to v2 does not capture what got
>> changed between the version you saw and this version), but I just
>> checked that they are "essentially identical" except for the
>> proposed log message.  Are you happy with having your Reviewed-by on
>> this version?
>>
>
> I re-reviewed the patch and everything looks fine to me:
>
> Reviewed-by: Jacob Keller <jacob.keller@gmail.com>

We actually needed a pair of small fixups on top, but I presume that
even with them your reviewed-by still stands?

The following is with these fixes squashed in.

 builtin/submodule--helper.c             |  38 +++++++
 submodule.c                             |  17 ++-
 t/meson.build                           |   1 +
 t/t5526-fetch-submodules.sh             |  52 +++++++++
 t/t5572-pull-submodule.sh               |  24 ++++-
 t/t7426-submodule-get-default-remote.sh | 186 ++++++++++++++++++++++++++++++++
 6 files changed, 314 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d537ab087a..b180a24091 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -112,6 +112,43 @@ static int get_default_remote_submodule(const char *module_path, char **default_
 	return 0;
 }
 
+static int module_get_default_remote(int argc, const char **argv, const char *prefix,
+				     struct repository *repo UNUSED)
+{
+	const char *path;
+	char *resolved_path = NULL;
+	char *default_remote = NULL;
+	int code;
+	struct option options[] = {
+		OPT_END()
+	};
+	const char *const usage[] = {
+		N_("git submodule--helper get-default-remote <path>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc != 1)
+		usage_with_options(usage, options);
+
+	path = argv[0];
+	if (prefix && *prefix && !is_absolute_path(path)) {
+		resolved_path = xstrfmt("%s%s", prefix, path);
+		path = resolved_path;
+	}
+
+	code = get_default_remote_submodule(path, &default_remote);
+	if (code) {
+		free(resolved_path);
+		return code;
+	}
+
+	printf("%s\n", default_remote);
+	free(default_remote);
+	free(resolved_path);
+	return 0;
+}
+
 /* the result should be freed by the caller. */
 static char *get_submodule_displaypath(const char *path, const char *prefix,
 				       const char *super_prefix)
@@ -3608,6 +3645,7 @@ int cmd_submodule__helper(int argc,
 		OPT_SUBCOMMAND("set-url", &fn, module_set_url),
 		OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
 		OPT_SUBCOMMAND("create-branch", &fn, module_create_branch),
+		OPT_SUBCOMMAND("get-default-remote", &fn, module_get_default_remote),
 		OPT_END()
 	};
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
diff --git a/submodule.c b/submodule.c
index 40a5c6fb9d..6599657f34 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1706,6 +1706,8 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 	if (spf->oid_fetch_tasks_nr) {
 		struct fetch_task *task =
 			spf->oid_fetch_tasks[spf->oid_fetch_tasks_nr - 1];
+		struct child_process cp_remote = CHILD_PROCESS_INIT;
+		struct strbuf remote_name = STRBUF_INIT;
 		spf->oid_fetch_tasks_nr--;
 
 		child_process_init(cp);
@@ -1719,8 +1721,19 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 		strvec_pushf(&cp->args, "--submodule-prefix=%s%s/",
 			     spf->prefix, task->sub->path);
 
-		/* NEEDSWORK: have get_default_remote from submodule--helper */
-		strvec_push(&cp->args, "origin");
+		cp_remote.git_cmd = 1;
+		strvec_pushl(&cp_remote.args, "submodule--helper",
+			     "get-default-remote", task->sub->path, NULL);
+
+		if (!capture_command(&cp_remote, &remote_name, 0)) {
+			strbuf_trim_trailing_newline(&remote_name);
+			strvec_push(&cp->args, remote_name.buf);
+		} else {
+			/* Fallback to "origin" if the helper fails */
+			strvec_push(&cp->args, "origin");
+		}
+		strbuf_release(&remote_name);
+
 		oid_array_for_each_unique(task->commits,
 					  append_oid_to_argv, &cp->args);
 
diff --git a/t/meson.build b/t/meson.build
index 459c52a489..6ff54cf276 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -887,6 +887,7 @@ integration_tests = [
   't7422-submodule-output.sh',
   't7423-submodule-symlinks.sh',
   't7424-submodule-mixed-ref-formats.sh',
+  't7426-submodule-get-default-remote.sh',
   't7450-bad-git-dotfiles.sh',
   't7500-commit-template-squash-signoff.sh',
   't7501-commit-basic-functionality.sh',
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 5e566205ba..a5a273b392 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -929,6 +929,58 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
 	)
 '
 
+test_expect_success 'fetch --recurse-submodules works with custom remote names' '
+	# depends on the previous test for setup
+
+	# Rename the remote in sub1 from "origin" to "custom_remote"
+	git -C downstream/sub1 remote rename origin custom_remote &&
+
+	# Create new commits in the original submodules
+	C=$(git -C submodule commit-tree -m "change outside refs/heads for custom remote" HEAD^{tree}) &&
+	git -C submodule update-ref refs/changes/custom1 $C &&
+	git update-index --cacheinfo 160000 $C submodule &&
+	test_tick &&
+
+	D=$(git -C sub1 commit-tree -m "change outside refs/heads for custom remote" HEAD^{tree}) &&
+	git -C sub1 update-ref refs/changes/custom2 $D &&
+	git update-index --cacheinfo 160000 $D sub1 &&
+
+	git commit -m "updated submodules outside of refs/heads for custom remote" &&
+	E=$(git rev-parse HEAD) &&
+	git update-ref refs/changes/custom3 $E &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules origin refs/changes/custom3:refs/heads/my_other_branch &&
+		git -C submodule cat-file -t $C &&
+		git -C sub1 cat-file -t $D &&
+		git checkout --recurse-submodules FETCH_HEAD
+	)
+'
+
+test_expect_success 'fetch new submodule commit on-demand in FETCH_HEAD from custom remote' '
+	# depends on the previous test for setup
+
+	C=$(git -C submodule commit-tree -m "another change outside refs/heads for custom remote" HEAD^{tree}) &&
+	git -C submodule update-ref refs/changes/custom4 $C &&
+	git update-index --cacheinfo 160000 $C submodule &&
+	test_tick &&
+
+	D=$(git -C sub1 commit-tree -m "another change outside refs/heads for custom remote" HEAD^{tree}) &&
+	git -C sub1 update-ref refs/changes/custom5 $D &&
+	git update-index --cacheinfo 160000 $D sub1 &&
+
+	git commit -m "updated submodules outside of refs/heads" &&
+	E=$(git rev-parse HEAD) &&
+	git update-ref refs/changes/custom6 $E &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules origin refs/changes/custom6 &&
+		git -C submodule cat-file -t $C &&
+		git -C sub1 cat-file -t $D &&
+		git checkout --recurse-submodules FETCH_HEAD
+	)
+'
+
 add_commit_push () {
 	dir="$1" &&
 	msg="$2" &&
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 45f384dd32..dfc07d050b 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -246,7 +246,8 @@ test_expect_success 'fetch submodule remote of different name from superproject'
 	git -C child submodule update --init &&
 
 	# Needs to create unreachable commit from current master branch.
-	git -C a-submodule checkout -b newmain HEAD^ &&
+	git -C a-submodule tag anchorpoint HEAD &&
+	git -C a-submodule checkout -b newmain anchorpoint^ &&
 	test_commit -C a-submodule echo &&
 	test_commit -C a-submodule moreecho &&
 	subc=$(git -C a-submodule rev-parse --short HEAD) &&
@@ -257,7 +258,26 @@ test_expect_success 'fetch submodule remote of different name from superproject'
 	git -C a-submodule reset --hard HEAD^^ &&
 
 	git -C child pull --no-recurse-submodules &&
-	git -C child submodule update
+	git -C child submodule update &&
+	test_path_is_file child/a-submodule/moreecho.t
+'
+
+test_expect_success 'fetch submodule remote of different non-origin name from superproject' '
+	git -C child/a-submodule remote rename origin o2 &&
+
+	# Create commit that is unreachable from current master branch
+	git -C a-submodule checkout -b newmain2 anchorpoint^ &&
+	test_commit -C a-submodule echo_o2 &&
+	test_commit -C a-submodule moreecho_o2 &&
+	subc=$(git -C a-submodule rev-parse --short HEAD) &&
+
+	git -C parent/a-submodule fetch &&
+	git -C parent/a-submodule checkout "$subc" &&
+	git -C parent commit -m "update submodule o2" a-submodule &&
+	git -C a-submodule reset --hard HEAD^^ &&
+
+	git -C child pull --recurse-submodules &&
+	test_path_is_file child/a-submodule/moreecho_o2.t
 '
 
 test_done
diff --git a/t/t7426-submodule-get-default-remote.sh b/t/t7426-submodule-get-default-remote.sh
new file mode 100755
index 0000000000..b842af9a2d
--- /dev/null
+++ b/t/t7426-submodule-get-default-remote.sh
@@ -0,0 +1,186 @@
+#!/bin/sh
+
+test_description='git submodule--helper get-default-remote'
+
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git config --global protocol.file.allow always
+'
+
+test_expect_success 'setup repositories' '
+	# Create a repository to be used as submodule
+	git init sub &&
+	test_commit --no-tag -C sub "initial commit in sub" file.txt "sub content" &&
+
+	# Create main repository
+	git init super &&
+	(
+		cd super &&
+		mkdir subdir &&
+		test_commit --no-tag -C subdir "initial commit in super" main.txt "super content" &&
+		git submodule add ../sub subpath &&
+		git commit -m "add submodule 'sub' at subpath"
+	)
+'
+
+test_expect_success 'get-default-remote returns origin for initialized submodule' '
+	(
+		cd super &&
+		git submodule update --init &&
+		echo "origin" >expect &&
+		git submodule--helper get-default-remote subpath >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get-default-remote works from subdirectory' '
+	(
+		cd super/subdir &&
+		echo "origin" >expect &&
+		git submodule--helper get-default-remote ../subpath >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get-default-remote fails with non-existent path' '
+	(
+		cd super &&
+		test_must_fail git submodule--helper get-default-remote nonexistent 2>err &&
+		test_grep "could not get a repository handle" err
+	)
+'
+
+test_expect_success 'get-default-remote fails with non-submodule path' '
+	(
+		cd super &&
+		test_must_fail git submodule--helper get-default-remote subdir 2>err &&
+		test_grep "could not get a repository handle" err
+	)
+'
+
+test_expect_success 'get-default-remote fails without path argument' '
+	(
+		cd super &&
+		test_must_fail git submodule--helper get-default-remote 2>err &&
+		test_grep "usage:" err
+	)
+'
+
+test_expect_success 'get-default-remote fails with too many arguments' '
+	(
+		cd super &&
+		test_must_fail git submodule--helper get-default-remote subpath subdir 2>err &&
+		test_grep "usage:" err
+	)
+'
+
+test_expect_success 'setup submodule with non-origin default remote name' '
+	# Create another submodule path with a different remote name
+	(
+		cd super &&
+		git submodule add ../sub upstream-subpath &&
+		git commit -m "add second submodule in upstream-subpath" &&
+		git submodule update --init upstream-subpath &&
+
+		# Change the remote name in the submodule
+		cd upstream-subpath &&
+		git remote rename origin upstream
+	)
+'
+
+test_expect_success 'get-default-remote returns non-origin remote name' '
+	(
+		cd super &&
+		echo "upstream" >expect &&
+		git submodule--helper get-default-remote upstream-subpath >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get-default-remote handles submodule with multiple remotes' '
+	(
+		cd super/subpath &&
+		git remote add other-upstream ../../sub &&
+		git remote add myfork ../../sub
+	) &&
+
+	(
+		cd super &&
+		echo "origin" >expect &&
+		git submodule--helper get-default-remote subpath >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get-default-remote handles submodule with multiple remotes and none are origin' '
+	(
+		cd super/upstream-subpath &&
+		git remote add yet-another-upstream ../../sub &&
+		git remote add yourfork ../../sub
+	) &&
+
+	(
+		cd super &&
+		echo "upstream" >expect &&
+		git submodule--helper get-default-remote upstream-subpath >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'setup nested submodule with non-origin remote' '
+	git init innersub &&
+	test_commit --no-tag -C innersub "initial commit in innersub" inner.txt "innersub content" &&
+
+	(
+		cd sub &&
+		git submodule add ../innersub innersubpath &&
+		git commit -m "add nested submodule at innersubpath"
+	) &&
+
+	(
+		cd super/upstream-subpath &&
+		git pull upstream &&
+		git submodule update --init --recursive . &&
+		(
+			cd innersubpath &&
+			git remote rename origin another_upstream
+		)
+	)
+'
+
+test_expect_success 'get-default-remote works with nested submodule' '
+	(
+		cd super &&
+		echo "another_upstream" >expect &&
+		git submodule--helper get-default-remote upstream-subpath/innersubpath >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get-default-remote works with submodule that has no remotes' '
+	# Create a submodule directory manually without remotes
+	(
+		cd super &&
+		git init no-remote-sub &&
+		test_commit --no-tag -C no-remote-sub "local commit" local.txt "local content"
+	) &&
+
+	# Add it as a submodule
+	(
+		cd super &&
+		git submodule add ./no-remote-sub &&
+		git commit -m "add local submodule 'no-remote-sub'"
+	) &&
+
+	(
+		cd super &&
+		# Should fall back to "origin" remote name when no remotes exist
+		echo "origin" >expect &&
+		git submodule--helper get-default-remote no-remote-sub >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done
