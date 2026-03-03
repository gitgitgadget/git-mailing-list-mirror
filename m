Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5BB389117
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568579; cv=none; b=ckuckqXeCfVb+g5HfDwFcWQ6NE/K4SrP7hzUEXOs5fkgQjq71TBmfvqfjkcp5N24TaJg8LW9Ajma4fkR5nj+IrD1uYBqy0z6R89z0r/Fq2ABNDIfO8illmlgq2dHjPG6ruc7t6x/VWSjG4tyKZ6Too5mYeWf/i/fxXtHiHvMf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568579; c=relaxed/simple;
	bh=PQTU89tyZB/i7ZQPPD9+J746CRbfnt5k84V0Y4DcrHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDkR/XpOwuN2Q74e8zrRca15YnsnuSgmeitBJm4ZbHnfn+p6Ma9dtpyELOrXtAIvii40L2AUPiOtIrstNSbTYivuBLaroBaWrG7ZQFjC+9PDS4Mil1rJq5B2E+dHbck+mLsCWdPwahhun/5P83Gt1HrTOzBL4ut4TEUWMsoECAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lQQGQdl8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bO843R0r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lQQGQdl8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bO843R0r"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H0BmO1256448
	for <git@vger.kernel.org>; Tue, 3 Mar 2026 20:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=26tTcUu2Kao
	Sf0HhjhnFgx+CFaVcpDBUC+FXJBtJhg0=; b=lQQGQdl8GkIvsditQs+B1dp0iCy
	n6mHaVFVLt9guYPYZTa3yGuZ8uuXurWKd0pzmA0vgRfavs71I6oVqOfWsjpx5Lze
	s4emUh5wYy/tNkhPXTSp7wA7RbcBMhIYBBnfh/3Cc6qp4RysWXC7O9BbzZSC6iQZ
	MEGcUYl64bUfcVO6Qx9HgTWCPFW3OmZxS3oNMLmBTaHHOobuPNN9cn4HIALnXTmm
	u5XJGPzqFAtyAzu6q5mJgoYxWBK5QUQD/8VIj/okVaBfWa1Ic2ClwHUNd79shcSP
	2HXWLu1RHyBJGpqtMR6OseqrZngmA/9RRv98b4QXMiiTzDl4nGfyVOC51Kw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp2c9h0bu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 03 Mar 2026 20:09:27 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d4beca8c53so66338755a34.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 12:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772568566; x=1773173366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26tTcUu2KaoSf0HhjhnFgx+CFaVcpDBUC+FXJBtJhg0=;
        b=bO843R0r19qZGCl94M7GNx5Wu00VdBcLdi8qOK7J4VbiqMqMa8gHuQG9TROPLmtZCm
         iTVTRrHc3sJc6wZmUfGw/8sAM8ckuDkQL41HlVXq2/grNP/W7gJaTSR4tQrVDpqJo+1f
         m8Ega2PVblBLzPpFuq0rfcnEU4f/u8ZQMULHQk4obwaaVZWmdnawTfzFGcGOchGTxMAN
         GODIM2b8kd+ITKiIPpDgSDFab51ycC/gpBYvHmEWHJyzN768+IfzGoqB/dW5xNToUeN0
         Yzhei1Kh+DpttjjEYwZqQA93KYMXhKRuaX4S5y1wgqp2JdS+it9RIt4I3LGgLKtxP6SQ
         e4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772568566; x=1773173366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=26tTcUu2KaoSf0HhjhnFgx+CFaVcpDBUC+FXJBtJhg0=;
        b=kPBJuKnBNBCVTOIBSuZgbfDqaWORQvMG1XEHejWN2F19WZbn1oW7zn35cHr7zxWbXx
         H2g+27K/4RXjrn1Yl6XpopVkUfhVeJAnynePggBx3OxW2SWGyZlZzr2We5Q85/hM3NAr
         Ss1fySaihhnKonK6XNc/3/kGS5YAlj0x+nyO30ttPDUa/EsUJS3dLgf0vF+vPRnsbzai
         U2Zvv+h6bgnoiioYHQkUksBTZe55LAjSLo/LTioWM1rcKiV2FhJ1FIC+K8cd0xuA1uwy
         C0STgvF/zfex6RoLlNRKGkTI6Xu3DxO6TPKmqeLHSWvzz0FyQrXvCYfjdO+WiL/ICnMZ
         22Tw==
X-Gm-Message-State: AOJu0Ywu7mc0Yuy5ziBHQ3bhOPKM+O41FbuuWoqVaQXsCrNLWgCg6S+y
	fWC14GR1jlRNL+BFL1kwqRnyBjjDvJ3N0NnLLpMimWv8oCCsU3AEb5GRAWtY1AF2EDyfcOKz14A
	PFg0KcgCLyVsA/XRKvgqafp8m8AQFgFvV1aC2Pw3Vlb03KMl5HJBPX9iE0Ejybew=
X-Gm-Gg: ATEYQzyZv9DfAQ5d4CYJ3EPiPf532n1MhFyIi/TXkoxyE6hC3FubOaRtQdib1N6Re/4
	0HbJQBIpQ2ZtotNPXzX7DI2UgU7HDxk+CypDAcobe8DBx5ER8B+lo+KPCS5i1M/CIG98TmegRUd
	KRqjTAu0veIQLmDI3k5PlITgLWwhUfyzlS4AxVW7DcRIuA3FDYX1i4SQA0REEXt4v1nhAmwixwz
	GHsWB8l3MTSl94k4vYm4KCDLmpLa9Aa5qTqD4z+Y8J4s7vGWQvGO8aHJB26sdU1M8Octc/e4dIT
	QukZB4JSu6ATRSZsslckuLGlegMfNSJJy+c4A1DX5iPcpr0n4qekGNofqnVZjxqbtPDm/7SpwX+
	042B+xF9yFejnnakhtyn2KkF/7g+CaDYIhJWZBdVlik26gRPve3szidT+OsQhXsx5ll8kitB4Rv
	81wEA=
X-Received: by 2002:a05:6830:719c:b0:7c7:69d9:d8d3 with SMTP id 46e09a7af769-7d591b25a7dmr13211430a34.12.1772568566061;
        Tue, 03 Mar 2026 12:09:26 -0800 (PST)
X-Received: by 2002:a05:6830:719c:b0:7c7:69d9:d8d3 with SMTP id 46e09a7af769-7d591b25a7dmr13211405a34.12.1772568565516;
        Tue, 03 Mar 2026 12:09:25 -0800 (PST)
Received: from hu-nasserg-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644dd3asm13891167a34.4.2026.03.03.12.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:09:24 -0800 (PST)
From: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
To: git@vger.kernel.org
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5] submodule: fetch missing objects from default remote
Date: Tue,  3 Mar 2026 12:09:06 -0800
Message-ID: <20260303200906.4118348-1-nasser.grainawi@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260301025327.3845292-1-nasser.grainawi@oss.qualcomm.com>
References: <20260301025327.3845292-1-nasser.grainawi@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE2NCBTYWx0ZWRfX/lRDRiaY+LLm
 FEmFSilL36o1J+ht/BJTLL4uBxkIGIcb+W9wYgRpiCQa5HDal+z2qWTh9xVztuFtcIc4ET8R6ad
 sGVQANce2iuzvxrYH4dOJerkLYEBXDspsmczQsvMac61LznBJYyaGGyYrt0N8xgIQUQl2Zs8+Uk
 VMOllZBEBmMddSHj30ap+rUrrjFS8Kzb+vLMAti3tkMaCCQQ3NqYWIkjQ4LlwsqFs/GERkUpgIS
 NYd5t3J2VrYpg0O61Ra9t9TQT3cNi2d6TPkhAYU5j6SGfwy1LbAuSRzdnS5ZJ/NfiNlaKYdgcw5
 5yiLofxjUJZzW9W0OtXE5PeCmIcNaERj6EcVkGSMoj0bb735gUxq7ipbUs5QEaBirhwB+USWP/4
 WSAGxyAD3CiuxMZDxlP+KruHmHUU02h/ksj/oI+/cdfoYTsucMnO6n8KE2OiMyN8TfJqWmGiWH5
 zuwRP2bSLCLPYIRO2TQ==
X-Proofpoint-ORIG-GUID: wuL7sbxl9Q1S5RcAoTmHsqtp-WYBjtO9
X-Proofpoint-GUID: wuL7sbxl9Q1S5RcAoTmHsqtp-WYBjtO9
X-Authority-Analysis: v=2.4 cv=EefFgfmC c=1 sm=1 tr=0 ts=69a73ff7 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=QVNkUz62EXjYt2CqXm8A:9 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030164

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
Fixes for test_when_finished usage within a subshell.

Range-diff against v4:
1:  9c5a5df9a2 ! 1:  673ad0372a submodule: fetch missing objects from default remote
    @@ t/meson.build: integration_tests = [
     
      ## t/t5526-fetch-submodules.sh ##
     @@ t/t5526-fetch-submodules.sh: test_expect_success "fetch new submodule commits on-demand outside standard refs
    + 	git commit -m "updated submodules outside of refs/heads" &&
    + 	E=$(git rev-parse HEAD) &&
      	git update-ref refs/changes/3 $E &&
    ++	FETCH_TRACE="$(pwd)/trace.out" &&
    ++	test_when_finished "rm -f \"$FETCH_TRACE\"" &&
      	(
      		cd downstream &&
     -		git fetch --recurse-submodules origin refs/changes/3:refs/heads/my_branch &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "fetch new submodule commits on
     +		 * branch            $C -> FETCH_HEAD
     +		Fetching submodule submodule/subdir/deepsubmodule
     +		EOF
    -+		test_when_finished "rm -f $pwd/on-demand_submodule_fetch_trace" &&
    -+		GIT_TRACE="$pwd/on-demand_submodule_fetch_trace" \
    -+		git fetch --recurse-submodules origin refs/changes/3:refs/heads/my_branch 2>actual_fetch &&
    ++		GIT_TRACE="$FETCH_TRACE" git fetch --recurse-submodules origin \
    ++			refs/changes/3:refs/heads/my_branch 2>actual_fetch &&
     +		test_cmp expect_fetch actual_fetch &&
      		git -C submodule cat-file -t $C &&
      		git -C sub1 cat-file -t $D &&
     +		test_grep "trace: built-in: git submodule--helper get-default-remote sub1" \
    -+			"$pwd/on-demand_submodule_fetch_trace" &&
    ++			"$FETCH_TRACE" &&
     +		test_grep "trace: built-in: git fetch .* --submodule-prefix=sub1/ origin" \
    -+			"$pwd/on-demand_submodule_fetch_trace" &&
    ++			"$FETCH_TRACE" &&
      		git checkout --recurse-submodules FETCH_HEAD
      	)
      '
    @@ t/t5526-fetch-submodules.sh: test_expect_success 'fetch new submodule commit int
     +		-m "updated submodules outside of refs/heads for custom remote" &&
     +	E=$(git rev-parse HEAD) &&
     +	git update-ref refs/changes/custom3 $E &&
    ++	FETCH_TRACE="$(pwd)/trace.out" &&
    ++	test_when_finished "rm -f \"$FETCH_TRACE\"" &&
     +	(
     +		cd downstream &&
     +		DEEP_START=$(git -C submodule/subdir/deepsubmodule rev-parse --short \
    @@ t/t5526-fetch-submodules.sh: test_expect_success 'fetch new submodule commit int
     +		 * branch            $C -> FETCH_HEAD
     +		Fetching submodule submodule/subdir/deepsubmodule
     +		EOF
    -+		test_when_finished "rm -f $pwd/custom_on-demand_submodule_fetch_trace" &&
    -+		GIT_TRACE="$pwd/custom_on-demand_submodule_fetch_trace" \
    -+		git fetch --recurse-submodules origin \
    ++		GIT_TRACE="$FETCH_TRACE" git fetch --recurse-submodules origin \
     +			refs/changes/custom3:refs/heads/my_other_branch \
     +			2>actual_fetch_custom &&
     +		# the without .gitmodules test above causes warnings
    @@ t/t5526-fetch-submodules.sh: test_expect_success 'fetch new submodule commit int
     +		git -C submodule cat-file -t $C &&
     +		git -C sub1 cat-file -t $D &&
     +		test_grep "trace: built-in: git submodule--helper get-default-remote sub1" \
    -+			"$pwd/custom_on-demand_submodule_fetch_trace" &&
    ++			"$FETCH_TRACE" &&
     +		test_grep "trace: built-in: git fetch .* --submodule-prefix=sub1/ custom_remote $D" \
    -+			"$pwd/custom_on-demand_submodule_fetch_trace" &&
    ++			"$FETCH_TRACE" &&
     +		git checkout --recurse-submodules FETCH_HEAD
     +	)
     +'

 builtin/submodule--helper.c             |  38 +++++
 submodule.c                             |  17 ++-
 t/meson.build                           |   1 +
 t/t5526-fetch-submodules.sh             | 112 +++++++++++++-
 t/t5572-pull-submodule.sh               |  21 ++-
 t/t7426-submodule-get-default-remote.sh | 186 ++++++++++++++++++++++++
 6 files changed, 371 insertions(+), 4 deletions(-)
 create mode 100755 t/t7426-submodule-get-default-remote.sh

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b621d14275..0a4676f3ba 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -113,6 +113,43 @@ static int get_default_remote_submodule(const char *module_path, char **default_
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
@@ -3788,6 +3825,7 @@ int cmd_submodule__helper(int argc,
 		OPT_SUBCOMMAND("set-url", &fn, module_set_url),
 		OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
 		OPT_SUBCOMMAND("create-branch", &fn, module_create_branch),
+		OPT_SUBCOMMAND("get-default-remote", &fn, module_get_default_remote),
 		OPT_END()
 	};
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
diff --git a/submodule.c b/submodule.c
index 508938e4da..906febfa0e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1708,6 +1708,8 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 	if (spf->oid_fetch_tasks_nr) {
 		struct fetch_task *task =
 			spf->oid_fetch_tasks[spf->oid_fetch_tasks_nr - 1];
+		struct child_process cp_remote = CHILD_PROCESS_INIT;
+		struct strbuf remote_name = STRBUF_INIT;
 		spf->oid_fetch_tasks_nr--;
 
 		child_process_init(cp);
@@ -1721,8 +1723,19 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
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
index 6d91470ebc..cfa3de5962 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -894,6 +894,7 @@ integration_tests = [
   't7423-submodule-symlinks.sh',
   't7424-submodule-mixed-ref-formats.sh',
   't7425-submodule-gitdir-path-extension.sh',
+  't7426-submodule-get-default-remote.sh',
   't7450-bad-git-dotfiles.sh',
   't7500-commit-template-squash-signoff.sh',
   't7501-commit-basic-functionality.sh',
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 5e566205ba..cc8aec5b1c 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -834,11 +834,37 @@ test_expect_success "fetch new submodule commits on-demand outside standard refs
 	git commit -m "updated submodules outside of refs/heads" &&
 	E=$(git rev-parse HEAD) &&
 	git update-ref refs/changes/3 $E &&
+	FETCH_TRACE="$(pwd)/trace.out" &&
+	test_when_finished "rm -f \"$FETCH_TRACE\"" &&
 	(
 		cd downstream &&
-		git fetch --recurse-submodules origin refs/changes/3:refs/heads/my_branch &&
+		DEEP_START=$(git -C submodule/subdir/deepsubmodule rev-parse --short origin/deep) &&
+		DEEP_END=$(git -C "$pwd/deepsubmodule" rev-parse --short deep) &&
+		cat >"expect_fetch" <<-EOF &&
+		From $pwd/.
+		 * [new ref]         refs/changes/3 -> my_branch
+		Fetching submodule sub1
+		Fetching submodule sub1/subdir/deepsubmodule
+		Fetching submodule submodule
+		Fetching submodule submodule/subdir/deepsubmodule
+		From $pwd/deepsubmodule
+		   $DEEP_START..$DEEP_END  deep       -> origin/deep
+		From $pwd/./sub1
+		 * branch            $D -> FETCH_HEAD
+		Fetching submodule sub1/subdir/deepsubmodule
+		From $pwd/submodule
+		 * branch            $C -> FETCH_HEAD
+		Fetching submodule submodule/subdir/deepsubmodule
+		EOF
+		GIT_TRACE="$FETCH_TRACE" git fetch --recurse-submodules origin \
+			refs/changes/3:refs/heads/my_branch 2>actual_fetch &&
+		test_cmp expect_fetch actual_fetch &&
 		git -C submodule cat-file -t $C &&
 		git -C sub1 cat-file -t $D &&
+		test_grep "trace: built-in: git submodule--helper get-default-remote sub1" \
+			"$FETCH_TRACE" &&
+		test_grep "trace: built-in: git fetch .* --submodule-prefix=sub1/ origin" \
+			"$FETCH_TRACE" &&
 		git checkout --recurse-submodules FETCH_HEAD
 	)
 '
@@ -929,6 +955,90 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
 	)
 '
 
+test_expect_success 'fetch new submodule commits on-demand outside standard refspec with custom remote name' '
+	# depends on the previous test for setup
+
+	# Rename the remote in sub1 from "origin" to "custom_remote"
+	git -C downstream/sub1 remote rename origin custom_remote &&
+
+	# Create new commits in the original submodules
+	C=$(git -C submodule commit-tree \
+		-m "change outside refs/heads for custom remote" HEAD^{tree}) &&
+	git -C submodule update-ref refs/changes/custom1 $C &&
+	git update-index --cacheinfo 160000 $C submodule &&
+	test_tick &&
+
+	D=$(git -C sub1 commit-tree \
+		-m "change outside refs/heads for custom remote" HEAD^{tree}) &&
+	git -C sub1 update-ref refs/changes/custom2 $D &&
+	git update-index --cacheinfo 160000 $D sub1 &&
+
+	git commit \
+		-m "updated submodules outside of refs/heads for custom remote" &&
+	E=$(git rev-parse HEAD) &&
+	git update-ref refs/changes/custom3 $E &&
+	FETCH_TRACE="$(pwd)/trace.out" &&
+	test_when_finished "rm -f \"$FETCH_TRACE\"" &&
+	(
+		cd downstream &&
+		DEEP_START=$(git -C submodule/subdir/deepsubmodule rev-parse --short \
+			origin/deep) &&
+		DEEP_END=$(git -C "$pwd/deepsubmodule" rev-parse --short deep) &&
+		cat >"expect_fetch_custom" <<-EOF &&
+		From $pwd/.
+		 * [new ref]         refs/changes/custom3 -> my_other_branch
+		Fetching submodule sub1
+		Fetching submodule sub1/subdir/deepsubmodule
+		Fetching submodule submodule
+		Fetching submodule submodule/subdir/deepsubmodule
+		From $pwd/./sub1
+		 * branch            $D -> FETCH_HEAD
+		Fetching submodule sub1/subdir/deepsubmodule
+		From $pwd/submodule
+		 * branch            $C -> FETCH_HEAD
+		Fetching submodule submodule/subdir/deepsubmodule
+		EOF
+		GIT_TRACE="$FETCH_TRACE" git fetch --recurse-submodules origin \
+			refs/changes/custom3:refs/heads/my_other_branch \
+			2>actual_fetch_custom &&
+		# the without .gitmodules test above causes warnings
+		grep -v "^warning: " actual_fetch_custom >actual_fetch_warnings_removed &&
+		test_cmp expect_fetch_custom actual_fetch_warnings_removed &&
+
+		git -C submodule cat-file -t $C &&
+		git -C sub1 cat-file -t $D &&
+		test_grep "trace: built-in: git submodule--helper get-default-remote sub1" \
+			"$FETCH_TRACE" &&
+		test_grep "trace: built-in: git fetch .* --submodule-prefix=sub1/ custom_remote $D" \
+			"$FETCH_TRACE" &&
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
index 45f384dd32..42d14328b6 100755
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
+test_expect_success 'fetch non-origin submodule remote named different from superproject' '
+	git -C child/a-submodule remote rename origin o2 &&
+
+	# Create commit that is unreachable from current master branch
+	# newmain is already reset in the previous test
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
-- 
2.52.0

