Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE4B21D3F3
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802881; cv=none; b=Cxep7TGNVVINC6hkV1vt5KZlsRVGwrsEz9qbHY/6my0JjqHl2cZKcxQ4lVKP2Ym2IfCXapcyoPiD4pz9oIepVJ7tvjJE+oCFh6wtH4icAj/b3v/V7uTHowhCoPcC0/rrhmvjEy+NwgWfy0Yi2dTFZEhT0naQOnOG+aeLnH2GLe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802881; c=relaxed/simple;
	bh=JG/j3BkR8PPIL54auul/F8CNdvtoK6LjPYLDTZ485Ig=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qgCfti/prc1rYcixClNnpcmOXxjSq3+08IFxHF/CEoIr/yjg9gRDLkxHZswx90yy01wWS9r9aWzCeqAHLKMWomY0ByWtRJ2pZg2bEh9hWzgNQHGd9YUqxpDEZLUyqbPe9uTbsJ8YD4gQg2yjUHPSwefCZfeA75SvlO5H+SNsmmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TavBrYu2; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TavBrYu2"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12713e56abdso5702224c88.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 05:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772802878; x=1773407678; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8LOrLJj5m0UjkWvfqZjSLNnhMVvWy7eMm6xSBxNUbc=;
        b=TavBrYu2NSQ5/wJXfo1OdpxIiblBM5Pr1kNjhshSShoqP8LAbmTwqfR6Q+8Ic+t7W0
         3Zuu1dutDxSh0BIzarT6i6f03h9SVGiszj7drXVExS6kWU8zdbVHevUOk4u+KM4iZM4u
         4vlZO7N8dauZ6gCcXYucNiaG1FCucDqe/Wc8JCvTTx/UbUzkIJ46CEaZjlSnsONN8J9E
         hajN88tDzFC0aZK7T8rOMcfXE9Kbw3BCA8BvVSQaL16huI6n34Zf10+Y6IjXo7SRvb82
         gYzqBdremHvYBokMzYuoV2Wy9EwZz6sHssYiNfohLTzGSYR7seHBCNICX0K6qAzXPdNX
         +naA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772802878; x=1773407678;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G8LOrLJj5m0UjkWvfqZjSLNnhMVvWy7eMm6xSBxNUbc=;
        b=H7ErRK1DisZkXstTzK/7xcjfuhmk82YSSi7XJfH+Jx8LJc8YD1XG1xaFf+hcr78kZT
         pk7UxvwLI8tKhHVg4KVBEMadFtH/zJ66rSNcz9PnwuG5Z3nmoNH4KUOznSADs9zHn+fC
         +dTemweat/bkpowHVTcMTIWSwkKM1EyKwhY4Halis9yVFY6sXsPzLXmhot5JbAusK5Af
         I6xpcDbcKDRWLmyMoq2nxStafMBSe3GUdF4pZXoW4AwDRq0lD+veP6BTd4DuX3UdJ1O6
         jSGqtjapRwuYgq2hPjrwp5bygIi/NBUaOHwrBqNQGPvMFctPnD5EnLMzUhGODwAt9DAJ
         gZhQ==
X-Gm-Message-State: AOJu0YwA9ma31ZYOimZ/ymcmvpfCVwZ+qi+oDtdUoqgp8ndLblMp+Hjy
	bgy1uCfzURZKduSRBpAp0fI8LOIgpQe4HMQh96EEFsPE6yvvYWpanMIi1m1y6A==
X-Gm-Gg: ATEYQzzp/PMoBarwLs6OgYCQZbAhXcsyQpnfCWycECTcfUu3d10XVgcYpXIfxOhkLyr
	WKcaCmFpintob85TfJ+Zo8pQY6BA/gi5f2r/gf9ghatQWKB376Xz3v4wD1NLo1/eSpul3Xx3QUc
	lDM3X/P8UaFJVD4n138hzIixVObDCYkgUeWlJrEbvajECq4CaH1S1zL7say3fd3ve/mNwkhvAUM
	/RZsY86lZFr/RPti5TBrpbljXeFnRdf/Umnsmbb6i3+YyqcCImdU520dnpUZmJZg8N+Jx2mDYKE
	HT+0G3fxH8UdR3T1ya8zt+uJdunOYepWCTRXEfnNwyGSmQZaCCe9OTmcZ+OB/foasO3MDtBv+2D
	FlKYGyWjthLf6udCnR18hWqg4Nrm77NJRFmkOPRi+mRkpxgJlri7GCNIkABKkAR1wTpvnf3gJT1
	e+4+1nG0ZyrTrSoznTszXMIiTT8NnagLfb2zUA
X-Received: by 2002:a05:7022:2227:b0:123:36f3:2d2f with SMTP id a92af1059eb24-128bc031fc8mr2698565c88.26.1772802878358;
        Fri, 06 Mar 2026 05:14:38 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f670062sm1170101eec.0.2026.03.06.05.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 05:14:37 -0800 (PST)
Message-Id: <8f45374007fddfa4cc81e536ae6e095b0d67d5e6.1772802872.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
References: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
	<pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
From: "VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Mar 2026 13:14:32 +0000
Subject: [PATCH v3 3/3] branch: add '--no-name-prefix' option
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Yoann Valeri <yoann.valeri@cea.fr>,
    Yoann Valeri <yoann.valeri@cea.fr>,
    VALERI Yoann <yoann.valeri@cea.fr>

From: VALERI Yoann <yoann.valeri@cea.fr>

This patch adds the '--no-name-prefix' option to prevent adding any
prefix to the branch being created, whether through the '--name-prefix'
option or the 'branch.namePrefix' configuration parameter.
Signed-off-by: VALERI Yoann <yoann.valeri@cea.fr>
---
 builtin/branch.c  | 9 ++++++---
 t/t3200-branch.sh | 8 ++++++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 58631913c7..204d7865d1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -713,7 +713,8 @@ int cmd_branch(int argc,
 {
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
-	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	    unset_upstream = 0, show_current = 0, edit_description = 0,
+		no_name_prefix = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -777,7 +778,8 @@ int cmd_branch(int argc,
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_BOOL(0, "recurse-submodules", &recurse_submodules_explicit, N_("recurse through submodules")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
-		OPT_STRING(0, "name-prefix", &name_prefix, N_("name"), N_("prefix for the branch to create")),
+		OPT_STRING_F(0, "name-prefix", &name_prefix, N_("name"), N_("prefix for the branch to create"), PARSE_OPT_NONEG),
+		OPT_BOOL(0, "no-name-prefix", &no_name_prefix, N_("do not use any prefix for the branch to create")),
 		OPT_END(),
 	};
 
@@ -1006,7 +1008,8 @@ int cmd_branch(int argc,
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead"));
 
-		add_branch_prefix(name_prefix, start_name, &new_branch_name);
+		if (!no_name_prefix)
+			add_branch_prefix(name_prefix, start_name, &new_branch_name);
 		strbuf_addstr(&new_branch_name, branch_name);
 
 		if (recurse_submodules)
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 847a8355cf..cbaa45330f 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1725,13 +1725,15 @@ test_expect_success 'create branch with --name-prefix' '
 	git switch blob-with-prefix &&
 	git branch --name-prefix "@{current}" -- -with-prefix &&
 	test_must_fail git branch --name-prefix "@{current}" -- -with-prefix &&
+	git branch --name-prefix "blob" --no-name-prefix branch-with-no-prefix &&
 	test_ref_exists refs/heads/branch-with-prefix &&
 	test_ref_exists refs/heads/main-with-prefix &&
 	test_ref_exists refs/heads/blob-with-prefix &&
 	test_ref_exists refs/heads/blob-with-prefix-with-prefix &&
+	test_ref_exists refs/heads/branch-with-no-prefix &&
 	git checkout main &&
 	git branch -D branch-with-prefix main-with-prefix blob-with-prefix &&
-	git branch -D blob-with-prefix-with-prefix
+	git branch -D blob-with-prefix-with-prefix branch-with-no-prefix
 '
 
 test_expect_success 'create branch with config prefix' '
@@ -1741,9 +1743,11 @@ test_expect_success 'create branch with config prefix' '
 	test_config branch.namePrefix "@{current}" &&
 	git checkout main &&
 	git branch -- -with-prefix &&
+	git branch --no-name-prefix branch-with-no-prefix &&
 	test_ref_exists refs/heads/blob-with-prefix &&
 	test_ref_exists refs/heads/main-with-prefix &&
-	git branch -D blob-with-prefix main-with-prefix
+	test_ref_exists refs/heads/branch-with-no-prefix &&
+	git branch -D blob-with-prefix main-with-prefix branch-with-no-prefix
 '
 
 test_done
-- 
gitgitgadget
