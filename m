Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659CCA41
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420130; cv=none; b=IwZz4eSgNXa6hPfUm27G9uqzChiH6XhQhhG07AbIh1FWDxMGurZqwsxU2R5Wvf/agIEl3lAReGARGUyL+EsR0XzqXWXFrpx1tl+818jCZpVoV5bXEQCF3uy3eaCfta9geEK87LaFq9hvWI/VcPEEDqYRg0waR3hT6woLE5uUqSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420130; c=relaxed/simple;
	bh=xBxGw+SQDstLq/tbo4jRKEXc0mHUQTOzUDELB8qQSaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1Ec3zDmMex3CUoUF7+CXXr38Um7Vsx8ByoNFm9zdwnxcpt/r0SACK2Zv4d9fwn0aJ0qMNUf9/aKtn+nVoeaEbvjHYIwr30jid0yMaBrNugwEZE9au3LbrjqGEMc7hA3l3E9vP9XPmzHo84HQiIB0VsCo3X8Z/qty/Ylx+5El3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n3mBrTIE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CY2fJsa6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n3mBrTIE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CY2fJsa6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EGmZbk3296284
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IW9VXmGV1bW
	G9MTYB3YsvmCtQuG++55fUbEt0yU9u+k=; b=n3mBrTIEqwCACkMSy2mI4wU5eUB
	fLF8EDoNPkV+yltGBRveqEi1JXBs/CTucqrSNFJwS//H3I/mujcd+KEJ3arxoj65
	lLNGNwaWjZEN1JkF+ofu4V2mUvv90ZYK04V4PM1wVDtH1nhYDgEojJtfUlgIPNaf
	/3HB6U96WNYoJR8H514IuQKtsVUG7/dpFOYG6xzugqIirGlH5eXamZVgRS2o2d5U
	Ptbb0F2b1ueORm7vmw5Rfk9rPu3GvzaaEBHeQS9BEYAbLOdx5Z+iSbpSfaXxfXCb
	VJUHeA+BivO81m5n7QIBTYzkjTCvHt90j0wl930b50syJtKG1H4uzD8iW3A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp8t2t40v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:48:46 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b050acf07dso719752eec.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768420126; x=1769024926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IW9VXmGV1bWG9MTYB3YsvmCtQuG++55fUbEt0yU9u+k=;
        b=CY2fJsa6690MGy0J8H/lRe78LC0ut/kja4LduJ1KrXIlkmNxsFF+2xRnZ9EIQsFcjR
         W/cljlAHuLXbnu6dt3yauVLtTOS6zfTvitgYcL6bwaWEllF93MWZLEcual7qLBoHbVEr
         FonOjkXW/7unqdOx7cjiwJOGrVmHalJ/06hfEykSsqGlnFQk6mk7ORsJk5BMXzg+Guby
         /jv3xmWfx6XshCzMfz0tRHQ4DKVE4zEV1AV2q2zqUz+I7KARpLIPP8bek3YP2Zq/eKW9
         oHCRHBqwoamRFKrluDASmJQHgEKdhzO34p39mARZf405iMs7h8jV1GKQ8lVixMRwPE5c
         WQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420126; x=1769024926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IW9VXmGV1bWG9MTYB3YsvmCtQuG++55fUbEt0yU9u+k=;
        b=G4DGHzpiFacOgoyYDd9I8cqcXgf/cS5gV3ORE8OlrT5x7Uwou7Bm30DYWGtX4E6Ug8
         J9sf+PjOei7YdnQidMflHPyC6BaZFTP2vk/T5vCzmlRVKqMdCh+ml+VNsAbnWV64R42m
         oNhDsIPhQgBxYAGzmubdnl3MVy521yZEi0Lw5ciAHvbzTP/BKO/xKd80n6+XUQYtisFF
         +K3ChjN6GAGhMNWjkWVjj8Q3UFerd4b8487vL/M3FjQ2T36WmTsmJdpToJh1fTrPG5eD
         pkarEHwPmnRoa0CjTHNqoPY+8QaQK0kNScUx9zDhvP2ZbfXEsHJ2N3DXHmDhV/F7H6Kx
         GUaQ==
X-Gm-Message-State: AOJu0Yx1XOiwsG8dlVtdw0b+tlCwEqqbKkPuxUTsfF9yrD8T36Pfnuk3
	F0R4itwYvgtmdBoxSIzXihunHTHSYj2BYelGqeKBnxpRvJ9845Z1nWRF5JrrfWd6p0o5x3ycwjL
	W/1X0T86G0GbPHOgDZ1O0RYV+OuZmWb7MP9iUBoIl6Ki80SEEbR4y5omwyzmX5eI=
X-Gm-Gg: AY/fxX4+IWlpTAScERVUtYMRGghPQFa+oLCHZQAL/mAwl9H42Fc07Y7MqKQln+ccI0y
	IMdxaeoVxRtxO46/uvsQsI8NrkhtEkFWtVDCVRsBzOuH6SohVbn9Quv6A+ioE6qITGJFoil4Awy
	3Cvj40YrqPPZlq8F4zAAs2f2QVLY1VPL2p+jrDDvNgnkEIhJsqRsVw4WoURXLu8BZ2Cea0kOrPr
	fzh20QXYxmDmIy+XmLw18pTYWwvG4SYhRD8uQX6jTgKTgnMjsdMyYk6IQvR42eMBKO9VtJGigw3
	rVNxsB6j3K7/bxGOmUd/E1c09rPM41AHu4KArkU8rYDposq/oQXuFIXxx1zc3Npte5JrCNVMbIz
	ZITerPX5zHHTsfZgtYySrgBy5S/jSRVj5wtVKxSrZojIb85COjXO9c0T2mCFi6/m9iiY=
X-Received: by 2002:a05:7301:3d12:b0:2a4:3593:646b with SMTP id 5a478bee46e88-2b48f5baa2cmr4518699eec.27.1768420125498;
        Wed, 14 Jan 2026 11:48:45 -0800 (PST)
X-Received: by 2002:a05:7301:3d12:b0:2a4:3593:646b with SMTP id 5a478bee46e88-2b48f5baa2cmr4518651eec.27.1768420124838;
        Wed, 14 Jan 2026 11:48:44 -0800 (PST)
Received: from hu-nasserg-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm31884474c88.12.2026.01.14.11.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:48:44 -0800 (PST)
From: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
To: git@vger.kernel.org
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] submodule: fetch missing objects from default remote
Date: Wed, 14 Jan 2026 11:48:15 -0800
Message-ID: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260112213612.2761854-1-nasser.grainawi@oss.qualcomm.com>
References: <20260112213612.2761854-1-nasser.grainawi@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YPaSCBGx c=1 sm=1 tr=0 ts=6967f31e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=OHbIMT-8wa4UWZAT2_AA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE2MyBTYWx0ZWRfX35YExKgmvEu3
 I1JeC3uDTSnJM31qmcvVI9pda7hgfYbAd8rh9/h/+smjUV13fpdKhyV4Jya7BeUF2M4V1uonMds
 H6BFtY5DULVGSuK+ZiHuGZVdNe+arwhVfZdm9ZamrhnQFTNXLjHI9ulYiS6I14byGtnB8rssy2D
 l6vAAhBRAZWe369ZmLC7VV0R7LrOC2q9VqJ8hLiSHnmV6j7vThEP3ehwu5cOxaDC1E7Sw2uMzuk
 RFlfoi1X5RgF7kLs2ygTRpZ1EOWbf22mPPRbupPxcIQ81WBJtPVrMV9xvryU4n1JOLxi1J1Ozpg
 oCFg9ivczFLlE3gHDEAtVO5nUtap2K7L+VsQW5SiZ4Pq6BmyHgGchIIyuLlALs7BARtmOe1/qWg
 J2B49dGgthdayJIrLzXqQDXNfL+PvgLh2DnbKc+GCzoJMM6RSBhmzwHtoIWlU8b7VXBPmRvj6iF
 Mk4rXlLtwlDuTOFwTyQ==
X-Proofpoint-GUID: U34vCA95UCKrCk4iy1LlA7lEERuIyB-7
X-Proofpoint-ORIG-GUID: U34vCA95UCKrCk4iy1LlA7lEERuIyB-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_06,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140163

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
---
Range-diff against v1:
1:  36ce158268 ! 1:  99c4792cff Fetch missing submodule objects from default remote
    @@ Metadata
     Author: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
     
      ## Commit message ##
    -    Fetch missing submodule objects from default remote
    +    submodule: fetch missing objects from default remote
     
    -    When be76c2128234d94b47f7087152ee55d08bb65d88 added support for fetching
    -    a missing submodule object by id, it hardcoded the remote name as
    -    "origin" and deferred anything more complicated for a later patch.
    -    Implement the NEEDSWORK item to remove the hardcoded assumption by
    -    adding and using a submodule helper subcmd 'get-default-remote'. Fixing
    -    this lets 'git fetch --recurse-submodules' succeed when the fetched
    -    commit(s) in the superproject trigger a submodule fetch, and that
    -    submodule's default remote name is not "origin".
    +    When be76c21282 (fetch: ensure submodule objects fetched, 2018-12-06)
    +    added support for fetching a missing submodule object by id, it
    +    hardcoded the remote name as "origin" and deferred anything more
    +    complicated for a later patch. Implement the NEEDSWORK item to remove
    +    the hardcoded assumption by adding and using a submodule helper subcmd
    +    'get-default-remote'. Fixing this lets 'git fetch --recurse-submodules'
    +    succeed when the fetched commit(s) in the superproject trigger a
    +    submodule fetch, and that submodule's default remote name is not
    +    "origin".
     
         Add non-"origin" remote tests to t5526-fetch-submodules.sh and
         t5572-pull-submodule.sh demonstrating this works as expected and add
    @@ submodule.c: static int get_next_submodule(struct child_process *cp, struct strb
     +			strbuf_trim_trailing_newline(&remote_name);
     +			strvec_push(&cp->args, remote_name.buf);
     +		} else {
    -+			// Fallback to "origin" if the helper fails
    ++			/* Fallback to "origin" if the helper fails */
     +			strvec_push(&cp->args, "origin");
     +		}
     +		strbuf_release(&remote_name);

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
index 45f384dd32..868dd6d130 100755
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
+	# Create commit that's unreachable from current master branch
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
2.51.2

