Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F92E414
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 23:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581260; cv=none; b=J7TBycyj991sqo3fpLtAyugAwyMU8DviIJ41C/3HBSU87foXZK47S4a4HdyglLeNfXLCa1bHVC2uXOkLcT9jYFKDjXCz3V6ztLtoDt2/uLDnG1CYch0kpfIjwbfrnJiyRYJ/moYvw3xHvw9pKRGE1q37K5pJxsI30r+VRThS/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581260; c=relaxed/simple;
	bh=325YOLysoxlKzDt52RbsDNrgjnyvNrS1tySDG0yLvTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkF8UQed9u2tOf7FHh5Tfd2UMIyHbAQ+kOJWDQLpYPsQXXAv4MHa1m/Er2QLUcOb65U2nNKEJwcYZedcu2d7TUala7y16EFTrEsRaOjMSeWGuiOyJH8n3r9Ecmw8hufShA7vP1V8uaXDLxEto2vlKwV9BVEdFkFIug3DdAmcDQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZV4XiDfp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TqGN1mPO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZV4XiDfp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TqGN1mPO"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H0XBq687008
	for <git@vger.kernel.org>; Tue, 3 Mar 2026 23:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=I0KiV0tAace
	UYoQKNVoC/qb2LjPlKyCA2csCkwa9iGU=; b=ZV4XiDfpcq8Sg+ZNZJgnY1kz8wq
	qX6XVr7QYc0LKft9vBaNobvkUIRowqyj7gzoKYMYCxUAOiBEV3y5S57GSd9l7Ljg
	dmVp4JZSS5ClNHzRWBCL5Ot3jbuxJDOeVbCKkTpCBDP+kZD9t/rINcNsTV3FLpqP
	iotpT2qjdAGfRFGXKgmzMeQ6f76Olll/Md3y31DV9wQScIIHyLk9rZy0M6OgkDV+
	+v9Whn26JGYOSW4SZbipJqA+GdtDKdn9LOBOOJdzvCBr8PLuZzYiixseNbYnPP8P
	QRk15y6jsbiDGm8yMw44wVnJqjOchnndmcvwHiDk6MuNG7JEwRCfgP7EC8w==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnu3nb6a7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 03 Mar 2026 23:40:57 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-40ee557ef0dso11920067fac.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 15:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772581257; x=1773186057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0KiV0tAaceUYoQKNVoC/qb2LjPlKyCA2csCkwa9iGU=;
        b=TqGN1mPOZGcbK0L7I9HcxvYjO75Vw1GYHSCvMVcxkku8qFEzAmL7I66HvlLdbM365i
         qXhjR/dx6a2xy3XCuJfMCB/JRAKegXpAssvDeZuc6XIbrJ4m+GzDzvf3QdOvQ5dVJQ5k
         q+fdA/ed91yakgNuo/22dkbSdbEJkb6+x1QBLuJRtMXgAzKrxCVgXC7ABbW7Zg4mGc1T
         yCjRQJZ/HbpVTlfhrfsHqzwAbgCCOdwwrpLdOb1v1Wsfm4j02KiqREshlJxv6o1dhv3O
         QG7jv8u9O3ktjPR/0Ct9bQtQimPljlsjVqrN09RVDPK1L15UuKlktMuQPF//jk3pMtm1
         KhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772581257; x=1773186057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I0KiV0tAaceUYoQKNVoC/qb2LjPlKyCA2csCkwa9iGU=;
        b=UxUXpGKMCDgdjdiEcwCOW6uDcpi+zDoAVcqz6nCL6ffZGs1eG2rStfGoKPv16UJ3j7
         0e+ppL57vggqfCfiImONpmbkC3KwgLXOg09a96a1cD9uNUx9U2MwFwLV9HczMgKP1oll
         sgE09GAgBmsvTE+LWkZkUd7hLpRS1s47kycezCuc6pvO1adgoRxQwcnwnIGOWPty0ivR
         1zl62D95gkmbj5KSAnPIQn/JUVryt1VwmiCrPA+I360N6JC4k7ZSPJXEmSjPRYwFDT9b
         x6E8FJgwZDM5SCAndIAVcp5RB+pGS2W8Gc6+Co7sF+6m96A71r7XHLaM4L9lDD2rEHKq
         cbbg==
X-Gm-Message-State: AOJu0YxLVngyuH3e6tCg9muvvFcNri+OYYe4bDaVHlwHAJal0uST3tJM
	3q/Taq7zDKe9EzZQzVp5SpiwfvXmqZKvNSuut+8VTE9/wvN+eZ10fs3RhN1/FZM/G5ji39QqdFD
	RdykErmNS6v5uX39bwsZuF2z3BRGwBYSHFn6enMeu1AUAQDfSREdcu7B+SW4IqpI=
X-Gm-Gg: ATEYQzxhYgmY5+/AwAClaU4FE3WUt3usElR6wK3DaoZtnQQ2kN5D4CGo4VZFi5nG/VS
	kgKqoFPZFK++OOlxntOXakJ6CJN+qA/EtF08237+TC1x4ZPRvwm3UAeWExxnU15/W2tTPFZPdVU
	IYXCu4JmFYuPrkFqy93hXuIH/KFpmq6nTOqiQAtSSqb7WU/WMzvgiA+aHjHPj3nZ2TFC/aNAz/6
	HomeHXfaRi2xrnN0DQez/Tez70IHpxyPd3BZJpjTJkqklMu39LDREjLYPSqKp973uituMIAm+RH
	bJ1cMg0plHcOrCDKytXUmzoyOE13RL4gxe2Jv5hew4wNezasY704qrTRgL0rXYPtEN09do6SKPH
	Mklk0DPrt1MCB9yAYlv7YdcwM3al/m97QXPUDaFPa+IzYYs7vIs/v7o6DsrPzQTIg2RCkkpeRSR
	HSTpU=
X-Received: by 2002:a05:6871:441a:b0:3c1:68a1:6b10 with SMTP id 586e51a60fabf-416ab54adbdmr60521fac.6.1772581256888;
        Tue, 03 Mar 2026 15:40:56 -0800 (PST)
X-Received: by 2002:a05:6871:441a:b0:3c1:68a1:6b10 with SMTP id 586e51a60fabf-416ab54adbdmr60504fac.6.1772581256377;
        Tue, 03 Mar 2026 15:40:56 -0800 (PST)
Received: from hu-nasserg-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d21196csm15717164fac.12.2026.03.03.15.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:40:55 -0800 (PST)
From: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
To: git@vger.kernel.org
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6] submodule: fetch missing objects from default remote
Date: Tue,  3 Mar 2026 15:40:44 -0800
Message-ID: <20260303234044.105157-1-nasser.grainawi@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303200906.4118348-1-nasser.grainawi@oss.qualcomm.com>
References: <20260303200906.4118348-1-nasser.grainawi@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JaexbEKV c=1 sm=1 tr=0 ts=69a77189 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=iTFW6g9On9SeDCbzSW4A:9 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-ORIG-GUID: AJM92tHppgjRB2iLF5dGYG0bW5OMCQW8
X-Proofpoint-GUID: AJM92tHppgjRB2iLF5dGYG0bW5OMCQW8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE5NCBTYWx0ZWRfX8+MSTwAgS1RB
 KFQvQR/QKjRNsOf9Djaqgn1Piw11PQJUEp81u6IvH9x2QZuHvyTEH6X3pglDbwLHqNjGUVx1JZr
 ZUXztajXamWqBVLvOjTqhs0mchM18T87TC706Hi9jkUBJ6nOlAu5OFhVA3Bqg3P/GmWTGLlaCy+
 0g+bPaoD7gYBmQIvaPGxU/cnMqQ00M206pA7MPRiDcER1uX/XIIxBkND2RANg+XdyFbkUJmJPUa
 nXlUJzsiN+DCmgoVnkwXGCpw9JhrV/RooGAhkf+8FvD8pc50Qh/maniVmh86lyWqo5w2qbegB7A
 hsLsgW3lVDsYyNMpk7dhlcAzMsPUeMQuAtHgOf7F2389pNWMUOA7i0ztxVPIKmsAw9sLWrljBx3
 LlT5OJyHuhSVL5vqAvcP5q4etiVNbAfWf+K9WHFakdCmLFlbaiqjJ8yZCmS5oEwjaffZAoNit9E
 NuGZcrAAmZvo/E/eGdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030194

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
Removed the fetch progress output comparison from the tests as the
ordering is unpredictable.

Range-diff against v5:
1:  673ad0372a ! 1:  ff3034f05f submodule: fetch missing objects from default remote
    @@ t/t5526-fetch-submodules.sh: test_expect_success "fetch new submodule commits on
      	(
      		cd downstream &&
     -		git fetch --recurse-submodules origin refs/changes/3:refs/heads/my_branch &&
    -+		DEEP_START=$(git -C submodule/subdir/deepsubmodule rev-parse --short origin/deep) &&
    -+		DEEP_END=$(git -C "$pwd/deepsubmodule" rev-parse --short deep) &&
    -+		cat >"expect_fetch" <<-EOF &&
    -+		From $pwd/.
    -+		 * [new ref]         refs/changes/3 -> my_branch
    -+		Fetching submodule sub1
    -+		Fetching submodule sub1/subdir/deepsubmodule
    -+		Fetching submodule submodule
    -+		Fetching submodule submodule/subdir/deepsubmodule
    -+		From $pwd/deepsubmodule
    -+		   $DEEP_START..$DEEP_END  deep       -> origin/deep
    -+		From $pwd/./sub1
    -+		 * branch            $D -> FETCH_HEAD
    -+		Fetching submodule sub1/subdir/deepsubmodule
    -+		From $pwd/submodule
    -+		 * branch            $C -> FETCH_HEAD
    -+		Fetching submodule submodule/subdir/deepsubmodule
    -+		EOF
     +		GIT_TRACE="$FETCH_TRACE" git fetch --recurse-submodules origin \
    -+			refs/changes/3:refs/heads/my_branch 2>actual_fetch &&
    -+		test_cmp expect_fetch actual_fetch &&
    ++			refs/changes/3:refs/heads/my_branch &&
      		git -C submodule cat-file -t $C &&
      		git -C sub1 cat-file -t $D &&
     +		test_grep "trace: built-in: git submodule--helper get-default-remote sub1" \
    @@ t/t5526-fetch-submodules.sh: test_expect_success 'fetch new submodule commit int
     +	test_when_finished "rm -f \"$FETCH_TRACE\"" &&
     +	(
     +		cd downstream &&
    -+		DEEP_START=$(git -C submodule/subdir/deepsubmodule rev-parse --short \
    -+			origin/deep) &&
    -+		DEEP_END=$(git -C "$pwd/deepsubmodule" rev-parse --short deep) &&
    -+		cat >"expect_fetch_custom" <<-EOF &&
    -+		From $pwd/.
    -+		 * [new ref]         refs/changes/custom3 -> my_other_branch
    -+		Fetching submodule sub1
    -+		Fetching submodule sub1/subdir/deepsubmodule
    -+		Fetching submodule submodule
    -+		Fetching submodule submodule/subdir/deepsubmodule
    -+		From $pwd/./sub1
    -+		 * branch            $D -> FETCH_HEAD
    -+		Fetching submodule sub1/subdir/deepsubmodule
    -+		From $pwd/submodule
    -+		 * branch            $C -> FETCH_HEAD
    -+		Fetching submodule submodule/subdir/deepsubmodule
    -+		EOF
     +		GIT_TRACE="$FETCH_TRACE" git fetch --recurse-submodules origin \
    -+			refs/changes/custom3:refs/heads/my_other_branch \
    -+			2>actual_fetch_custom &&
    -+		# the without .gitmodules test above causes warnings
    -+		grep -v "^warning: " actual_fetch_custom >actual_fetch_warnings_removed &&
    -+		test_cmp expect_fetch_custom actual_fetch_warnings_removed &&
    -+
    ++			refs/changes/custom3:refs/heads/my_other_branch &&
     +		git -C submodule cat-file -t $C &&
     +		git -C sub1 cat-file -t $D &&
     +		test_grep "trace: built-in: git submodule--helper get-default-remote sub1" \

 builtin/submodule--helper.c             |  38 +++++
 submodule.c                             |  17 ++-
 t/meson.build                           |   1 +
 t/t5526-fetch-submodules.sh             |  71 ++++++++-
 t/t5572-pull-submodule.sh               |  21 ++-
 t/t7426-submodule-get-default-remote.sh | 186 ++++++++++++++++++++++++
 6 files changed, 330 insertions(+), 4 deletions(-)
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
index 5e566205ba..1242ee9185 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -834,11 +834,18 @@ test_expect_success "fetch new submodule commits on-demand outside standard refs
 	git commit -m "updated submodules outside of refs/heads" &&
 	E=$(git rev-parse HEAD) &&
 	git update-ref refs/changes/3 $E &&
+	FETCH_TRACE="$(pwd)/trace.out" &&
+	test_when_finished "rm -f \"$FETCH_TRACE\"" &&
 	(
 		cd downstream &&
-		git fetch --recurse-submodules origin refs/changes/3:refs/heads/my_branch &&
+		GIT_TRACE="$FETCH_TRACE" git fetch --recurse-submodules origin \
+			refs/changes/3:refs/heads/my_branch &&
 		git -C submodule cat-file -t $C &&
 		git -C sub1 cat-file -t $D &&
+		test_grep "trace: built-in: git submodule--helper get-default-remote sub1" \
+			"$FETCH_TRACE" &&
+		test_grep "trace: built-in: git fetch .* --submodule-prefix=sub1/ origin" \
+			"$FETCH_TRACE" &&
 		git checkout --recurse-submodules FETCH_HEAD
 	)
 '
@@ -929,6 +936,68 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
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
+		GIT_TRACE="$FETCH_TRACE" git fetch --recurse-submodules origin \
+			refs/changes/custom3:refs/heads/my_other_branch &&
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

