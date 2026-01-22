Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FAB2E8B64
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095691; cv=none; b=KPQmmfmfdQ/1lZDQ11Ybqy0Fioj2HnQxoNpReCfvEvoF61FIMIyJ7ujfgx4vYAVaw3sMukgQZoNfbijVgFo4gX/QmyEbz4msb6e8MOMK2AdT0TtN+W1NdveMBXh3QH34yL3214BRYbXaUZcdUpKz7e0p5MTzBmfrH4BzjoVNtWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095691; c=relaxed/simple;
	bh=3QOHLpWDHZxzdQ75y4nVuo5/RiCq6CVTArAOR6yeSPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCsRJ4Z1n/ByaIr6M2h1F+mP5rDdDRme9oVmD8/98HgG77YVqz3k9XdqcFH5sUALZABWArErWN9PyOOaEwq5QB+QJ097s0pi1e4Oxtuyr2UCwnld9wHqNseBLsTz8F0qiTiKi6ZiC4plm6hemfe64ndtyTZczdt5rHIlAn5JZbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hZd/vjH4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z4Jp1PCr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hZd/vjH4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z4Jp1PCr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M8buWU645944
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GU5G7HW6Wc8
	btQf0Fna/Sb9PQAvAB9tKjOHNOAGLbfA=; b=hZd/vjH4v0n07dhjXEnRUTA1ck2
	esD8ULl5QPay98P3yc3dDpLPbr0+2v/wuRQAZB0/m4nvdtnkFQTgeooAlCMTiaon
	0KyxLtA4iTo1N66E/oYNMWqCkTdYTmSZzCscDacEm5xqSReeB6rXWczi037wmT6f
	j+VpY/IuvBF+kx2ucT7/+Yw97vsnrlst7aW2s5vVjni4UVhoIUvn9KAYB59MGaNj
	uieSO7VYwhakUe8hsVBXUlWCJX/arpIzz8EqaMEeMK2Y9kT4NmTgbMYQlnETmVVW
	Q4ipWavSVcWWWaivTbircE/xQ9v4Cn7YQKXp101NigcmClrbwQS9QIhhEPQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu8j9tn5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:28:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b70c92f404so1511730eec.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 07:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769095687; x=1769700487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU5G7HW6Wc8btQf0Fna/Sb9PQAvAB9tKjOHNOAGLbfA=;
        b=Z4Jp1PCr1EIXshxbL2Lh2c6rpexmzmNKTiBnTJkvWWU/H+FIBZNExrhC5m5bu1P5YX
         B9jPsiXDpzFHx9hozGafcjvAyAL/owOAb3o21vW0Npqd76Na51i69rT0Jdu8mAcADALt
         QYaQBBjb84fCpPYuB8+PlZ7tTBSuj4ho6Bjo0v5BVTKRH/NbaN5aEGpMp0+TM6T+tiMp
         df6iqfSJhgJrkjVgHglql1vC5+rzllH3GOVyZ0ZWxj2aXn655vgu7ysd1mHFKn9l0RFM
         j5y8AThfYj3kkI9HMHP+Ppsml35UEuIh21vvw6Qr0+P3GT8xezbqAh1PDLu9apc8KOrj
         3MaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769095687; x=1769700487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GU5G7HW6Wc8btQf0Fna/Sb9PQAvAB9tKjOHNOAGLbfA=;
        b=aPgzfioU9ft4bBxbU0joAWC873d6yvPmeIQk9zHd4KhXGvSOOV1XxHW0BIFKgoI6wt
         Du2p5N1pimsKC/ZhmxZNRI37rrC/pjWi4RApNLUhElAHy2bi+HkHoJncEoTaIfixiDS3
         ZKfL5guZtkC88yTI1WZibLBHEn4ICoWo5B+jiKc05fI5QO/ZnOQWyl3dhyLRrwRzGw20
         Ux5x8gIn3G1+loOgq5e8H+kKOXOJx1HNonwPEYC0d7j7leiASmVhlPSJAJDm8Q2GflEF
         3sS+ki+Jz+EFCakDuJF8jnlfa8eq/l6UVsCdWKwlPhr9HRMIdf0jrS6VuJERDGFviGQ7
         rUfA==
X-Gm-Message-State: AOJu0YxQeUQzR3KA379a7lkwise/hjN7c0z5hcoPoTJHEiDf9IFvbZB4
	9BfkyqcGHOh4ZpJDKedUaClFpc9EO/ohGmBrhLzs/FTOdmES1V5p8p2g8EOaWhf1wmXtoTEZqDo
	qKD/+Zlfe+0bcVSFzXhzVd0DZhfEWYuJEWvu/bDJEdri36LhPVDMZ+PSXsAcict4=
X-Gm-Gg: AZuq6aJrpwFp6Teb7a9tkBQkRFWLfZ4ZuqGgbsxMwOVpsLyneSIeQrIQgyDeVa5ysIY
	oT0j6EZDpssqymAIqrxudJplXdEGt6v/FlTUvo7e+SlIMO7OFtOX+IH0AQriNPmgzWdGlJI55OG
	5m4HU47XJ6X44FRrQ6E7oznlX8HzPm4NijfhWyaTlHAHGS9n8BvKdXf+sGzt1XbKxahCTTqBzWu
	GvJRW1gxG8iZWWGNJt+bkn3KogscGhR4OB960qgccPILIXH58sdZJhVeTLYeorPdcwcTDBUMEje
	AS72+imXC1f3fFLXkARBfjgmgvrWxcLJ2sH4XJrZ1WHNmJ4qvHrSsu2vJIx32z7Z39fRsE7Q9GW
	X4FVF98xlDkWpOQ2hi2SkmSPHIW0J+Nx8OvNKkGheCiyjDaEN/P6R8eXfk3vtWJdgRjA=
X-Received: by 2002:a05:693c:4095:b0:2b7:2e78:9d0 with SMTP id 5a478bee46e88-2b72e7826dcmr679927eec.16.1769095686253;
        Thu, 22 Jan 2026 07:28:06 -0800 (PST)
X-Received: by 2002:a05:693c:4095:b0:2b7:2e78:9d0 with SMTP id 5a478bee46e88-2b72e7826dcmr679905eec.16.1769095685529;
        Thu, 22 Jan 2026 07:28:05 -0800 (PST)
Received: from hu-nasserg-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6ff4f6488sm10627985eec.19.2026.01.22.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:28:05 -0800 (PST)
From: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
To: git@vger.kernel.org
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] submodule: fetch missing objects from default remote
Date: Thu, 22 Jan 2026 07:27:22 -0800
Message-ID: <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
References: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6lhyRmJRjrD3JnNCHJCJ-h5KFpTRbpbH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDExOCBTYWx0ZWRfX3o7mcTyQcUlr
 1zTGgP251joarvvjlPkY9GleTXERQsq1TlNRlRq3lqIo0YxMt9f/pulGuzenF/uJyDVNvSNt67v
 hnHbeaP2Z1UG4dcd+3myoLTVYe0yEBu7EqwNXVGqa2EU5UdaLxeq8V9FEJIAc/Ub8zsIyP97eXe
 hize3z90wB2eQ8xz0noZ8IXmtZOZU5l0ZQ9+hKxPUrmVL+nB6FQRorouZMMwKpqqDSGX3n1ZXia
 OM0OqA0jgk+E9NOPenA88PsabUlmTfGlo0emu/Iwm/op29AwE3T+JSVmZ9Js8jZq6d2ws5ohwUq
 3gXNxIELgdFiiziwq2x3KNMHbhNyEkrrOl3dP8+mnVMRVgv9rbVT9Y8NX+OUHN968YFtNwz+gym
 +Lh5eWdr5BBMRAF3xWLk3r9VuX/hrSApaFqkq9WpLyu6wwrbAyMoj/eIDKoUCMTw4Mn7FORsW3y
 xd7NeD559IfMhJIIdSg==
X-Authority-Analysis: v=2.4 cv=U4CfzOru c=1 sm=1 tr=0 ts=69724207 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=24VaFxuiyONUqTJ376EA:9
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 6lhyRmJRjrD3JnNCHJCJ-h5KFpTRbpbH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220118

When be76c21282 (fetch: ensure submodule objects fetched, 2018-12-06)
added support for fetching a missing submodule object by id, it
hardcoded the remote name as "origin" and deferred anything more
complicated for a later patch. Implement the NEEDSWORK item to remove
the hardcoded assumption by adding and using a submodule helper subcmd
'get-default-remote'. Fixing this lets 'git fetch --recurse-submodules'
succeed when the fetched commit(s) in the superproject trigger a
submodule fetch, and that submodule's default remote name is not
"origin".

Add non-"origin" remote tests to t5526-fetch-submodules.sh and
t5572-pull-submodule.sh demonstrating this works as expected and add
dedicated tests for get-default-remote.

Signed-off-by: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
---
Range-diff against v2:
1:  99c4792cff ! 1:  1dd17e9f75 submodule: fetch missing objects from default remote
    @@ Commit message
     
         Change-Id: I0fec01b161aa13ed4c1c5e53477dad6912d1b5e6
         Signed-off-by: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
    +    Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int get_default_remote_submodule(const char *module_path, char **default_
    @@ t/t5572-pull-submodule.sh: test_expect_success 'fetch submodule remote of differ
     +test_expect_success 'fetch submodule remote of different non-origin name from superproject' '
     +	git -C child/a-submodule remote rename origin o2 &&
     +
    -+	# Create commit that's unreachable from current master branch
    ++	# Create commit that is unreachable from current master branch
     +	git -C a-submodule checkout -b newmain2 master^ &&
     +	test_commit -C a-submodule echo_o2 &&
     +	test_commit -C a-submodule moreecho_o2 &&

 builtin/submodule--helper.c             |  38 +++++
 submodule.c                             |  17 ++-
 t/meson.build                           |   1 +
 t/t5526-fetch-submodules.sh             |  52 +++++++
 t/t5572-pull-submodule.sh               |  21 ++-
 t/t7425-submodule-get-default-remote.sh | 186 ++++++++++++++++++++++++
 6 files changed, 312 insertions(+), 3 deletions(-)
 create mode 100755 t/t7425-submodule-get-default-remote.sh

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
index 459c52a489..ef6cdab165 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -887,6 +887,7 @@ integration_tests = [
   't7422-submodule-output.sh',
   't7423-submodule-symlinks.sh',
   't7424-submodule-mixed-ref-formats.sh',
+  't7425-submodule-get-default-remote.sh',
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
index 45f384dd32..faafe31409 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -257,7 +257,26 @@ test_expect_success 'fetch submodule remote of different name from superproject'
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
+	git -C a-submodule checkout -b newmain2 master^ &&
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
diff --git a/t/t7425-submodule-get-default-remote.sh b/t/t7425-submodule-get-default-remote.sh
new file mode 100755
index 0000000000..b842af9a2d
--- /dev/null
+++ b/t/t7425-submodule-get-default-remote.sh
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
-- 
2.52.0

