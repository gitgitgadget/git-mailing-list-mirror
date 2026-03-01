Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88BC19F40A
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 02:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772333646; cv=none; b=G8BbDVvm3TxzsJbky3daowfJKfqBF15ZNhlQfX+bFn57WwWmJhR7PYmxv7EiQrbGu+qevVxd4PmAjx55C6c8OoHrLAHyPOrig1kLNDvaz4cjsSU4XPTvdkLVxIiyRxxxTWPXGsQm66733BdGs9p7LWwLXmQ8NSmFbbR9IbeQGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772333646; c=relaxed/simple;
	bh=Hx0zz7n/l1MfS/qESBPiPqw82bhtCbAm4zr0mtifNtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNE8+RzKSQ+NSraFGVdyS6gacZu3NBYJaSsxn+FgDhGM3wAUOCCpsiTwIRpeOgglxgFLsgDlAwRa2CgDrgPOOq+k7LW2IAElS6OoY+EvvWPLV6CWO+akVRycNkY9OZi+hYUHXEi/94rxoKUr0SZ21gw27WQ70Ha+2vPjLn3O9Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=peSsnLJX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TCa6OfbT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="peSsnLJX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TCa6OfbT"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61SNbiGK3748843
	for <git@vger.kernel.org>; Sun, 1 Mar 2026 02:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ktY0Y6pWkgd
	6YPvpYn9Au+7nwSYgYXRe+CbLc33NvHo=; b=peSsnLJXKe0ykSH069skjpTJrMS
	q4rJXwycjsdR2Fv0HyrmDKKmngAJomgXw16Q9qDdswKIOm8hD8mysF/Az8SCSHQY
	+MjXDosPnT2FaHJWwu6m4FLhnr2xHLofgInBQ9dEe5Bv4184r8nQVK2t2skxGRvy
	2ZT/EHT2hatnNAy8nMhUShaRM3Gk/Dn686fuaJnbeDea9R9pdxTy4UNkEtloOiCF
	fOYEhyyMGHiq/Xc7KUdRrLfpiiFYLL5X0aVCeDjfS0z/IZpEnkzS2ET1hYHR3a6Y
	aLXV9uIgo5FiGkpege5EVrGM5aGizC54oIdodIiszBx/4qsoWdESEjk3XYw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksg720fa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sun, 01 Mar 2026 02:53:56 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-676c2e00f3fso76087851eaf.0
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 18:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772333636; x=1772938436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktY0Y6pWkgd6YPvpYn9Au+7nwSYgYXRe+CbLc33NvHo=;
        b=TCa6OfbTX0l3pWerDSBhmnACNNKrbpkGkXlxJDSZgKjl6JB+vTnpyiaWZiRCgrJuYt
         CBVupzGn7jzC5OYnS+6+5uxdNi1aaXMsm8c5ViwF3WqwcGMJVzAOXN3UkO+WwyLuoVF4
         AyVHJYwxyveXlH2unqUqvRkaK3OWZFnOuAdDGxCAY9Gzc9hthzDsvWYFhkHOjCGawvCf
         /Ld8K6Aq+nf8pzWoJjMxFAnLBEFAVangvs4A0zaybQ/Wi7afpkE+Z68Q02jTiJNy7v5n
         xRmQJ3wZ91Kd/7PdSWKwbL0zllBiVKpF6aLqM/GkG8CQUdvpEtZY64gHrSaKx1dKzh7i
         AwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772333636; x=1772938436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ktY0Y6pWkgd6YPvpYn9Au+7nwSYgYXRe+CbLc33NvHo=;
        b=Cs8dnoGT2knaz2LC0CZmmPlbAERanr5OpQllINEEtsfUUrA4vumWles5TavsEgIDzx
         DzjdvNUO3tyduUaWencLnuhwYf+k++60Jf4IFpF2Yw/rxgio9v7Y/5by44mAsAVGXFEH
         1jR+RlXDm88l/RqE37o7Akbmkcvm09Tqav/KxjWsSOcqkdtJLpCHMtMxw7h0ss1QsBi3
         yXYfEnBe78yp8/VtfSaqFZXiQWS4aNE8M1oEtylPZdWjq8HlecxoUP/FEiqy2189nP7a
         afRI0whf8ry9kwpdQZeUnDXxrddwARFOjaLJdtu0VTJ9VP9mgoBVY4jpoS00AXxYiasc
         GRkA==
X-Gm-Message-State: AOJu0YyK2xv6S/tCY9WG5xVsi4/rz1/Lb+av89VloVF7NIjKqGk43A2i
	RxV36hnD2ZTozOfH9MUIIDntNqqTsa7b7W27+Jyw/q5kTyiQL0+NOSAKK8aW/fiSD7JMJrS+ORJ
	u7QfaEDLwErVvwQF/JWpL0fsC5wP/D5Mpuw4jjiYFbjBX4t1gkz5FnalqWXR74Ls=
X-Gm-Gg: ATEYQzyABBbSIbUGd+IKx1USxpn7r724zMB1G0dVGPhOazDDPKNWwOJcjjW2bbu0r2A
	SRhc/6SWT3JNnwVELOL/Z/sN3H9gsW5OZxcKjD2AUV0dkQaPMYpaxjyLd1rI+IwDljzLfl1nwr+
	byvUo8iHUSHLLMCx+2HrHHDY9q6r4GyP9di+O+/lHj3TPfY6YLBzLcmWpCPJYA8DS8peMH1zZd4
	g74mul5y0XMrV3D1YnlokIm2ZQLUWgiWEWa2ceYQWIMnULywlzK5PCnu20oRt0CcM1YeWHQIlet
	ruyhPX8LCB2oUztFzvZpB53VaCvJWw7JEVN7ncN3HH942ZfK2cjEworPOc4514Y04BXJ7Lruq/y
	JHLE3vPwCDtPIrOos6Ohchc/D/23KRewEWNkhIJs4eAclJOgLxjOs8KutiPR2a47wdHfEqo6h4V
	r1doQ=
X-Received: by 2002:a05:6820:488a:b0:661:14e0:4ab4 with SMTP id 006d021491bc7-679fb5600a2mr3402557eaf.27.1772333635853;
        Sat, 28 Feb 2026 18:53:55 -0800 (PST)
X-Received: by 2002:a05:6820:488a:b0:661:14e0:4ab4 with SMTP id 006d021491bc7-679fb5600a2mr3402550eaf.27.1772333635226;
        Sat, 28 Feb 2026 18:53:55 -0800 (PST)
Received: from hu-nasserg-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bec8a1sm7162025eaf.6.2026.02.28.18.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 18:53:54 -0800 (PST)
From: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
To: git@vger.kernel.org
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4] submodule: fetch missing objects from default remote
Date: Sat, 28 Feb 2026 18:53:27 -0800
Message-ID: <20260301025327.3845292-1-nasser.grainawi@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
References: <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 45vCJZ330JAT01tilVZAzitUsC-m0sNf
X-Proofpoint-GUID: 45vCJZ330JAT01tilVZAzitUsC-m0sNf
X-Authority-Analysis: v=2.4 cv=FaA6BZ+6 c=1 sm=1 tr=0 ts=69a3aa44 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=ZAA2u1jsyn5zvmGJCzEA:9 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDAyMyBTYWx0ZWRfX+/vh88CpuXAW
 AOksyFYOZF9LIIDomHYRq3jzbpCjTm/L4ymaxINdEu1sBMRkQ9udoZTfSNNEgfiyteboiDNOrdr
 fNGWr0rORYrsgAFdPicfZboyuMsj5DdCkAbqANTvxvu1LIqjzPqSKl4Qp5lklaCiTzfPcl7HPwl
 rLfCDKhF2vQZyps1DylTB1bZIu4IPK/BNAJNsN8uAsVfAg0sjIT6ORmTiuip7CkTCyX1HJkpzoG
 8naefjcLNTs/zlWz8U7wxpyUvzcnhLS4YMxhz3DxHFODV+vHl13K4Zt7BSUFVm3FRcBAnIH9D4l
 L+40AE0GtHInSrp2T90DYJPC15p1HbhtCUFDY1JRMg5RUB1vSm9x2Eb3LCXq4mbXZfzi7q7lq0Q
 tqpV1P1PEOagmtRylPIi5IXttjIozyo1Gs2AJqoQOSTve8FIbbE1LFyuxB8LrkDOSs/kTtHgmPK
 jQcfTcnwJ3HSKd4W/ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603010023

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
I removed Jacob Keller's Reviewed-By since there are more significant
edits to the tests in v4 that they haven't reviewed.

v4 includes fixes for the issues Junio patched in seen and I confirmed
it merges cleanly to seen (with v3 reverted) as well as next and passes
tests.

Range-diff against v3:
1:  1dd17e9f75 ! 1:  9c5a5df9a2 submodule: fetch missing objects from default remote
    @@ submodule.c: static int get_next_submodule(struct child_process *cp, struct strb
     
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
    -   't7422-submodule-output.sh',
        't7423-submodule-symlinks.sh',
        't7424-submodule-mixed-ref-formats.sh',
    -+  't7425-submodule-get-default-remote.sh',
    +   't7425-submodule-gitdir-path-extension.sh',
    ++  't7426-submodule-get-default-remote.sh',
        't7450-bad-git-dotfiles.sh',
        't7500-commit-template-squash-signoff.sh',
        't7501-commit-basic-functionality.sh',
     
      ## t/t5526-fetch-submodules.sh ##
    +@@ t/t5526-fetch-submodules.sh: test_expect_success "fetch new submodule commits on-demand outside standard refs
    + 	git update-ref refs/changes/3 $E &&
    + 	(
    + 		cd downstream &&
    +-		git fetch --recurse-submodules origin refs/changes/3:refs/heads/my_branch &&
    ++		DEEP_START=$(git -C submodule/subdir/deepsubmodule rev-parse --short origin/deep) &&
    ++		DEEP_END=$(git -C "$pwd/deepsubmodule" rev-parse --short deep) &&
    ++		cat >"expect_fetch" <<-EOF &&
    ++		From $pwd/.
    ++		 * [new ref]         refs/changes/3 -> my_branch
    ++		Fetching submodule sub1
    ++		Fetching submodule sub1/subdir/deepsubmodule
    ++		Fetching submodule submodule
    ++		Fetching submodule submodule/subdir/deepsubmodule
    ++		From $pwd/deepsubmodule
    ++		   $DEEP_START..$DEEP_END  deep       -> origin/deep
    ++		From $pwd/./sub1
    ++		 * branch            $D -> FETCH_HEAD
    ++		Fetching submodule sub1/subdir/deepsubmodule
    ++		From $pwd/submodule
    ++		 * branch            $C -> FETCH_HEAD
    ++		Fetching submodule submodule/subdir/deepsubmodule
    ++		EOF
    ++		test_when_finished "rm -f $pwd/on-demand_submodule_fetch_trace" &&
    ++		GIT_TRACE="$pwd/on-demand_submodule_fetch_trace" \
    ++		git fetch --recurse-submodules origin refs/changes/3:refs/heads/my_branch 2>actual_fetch &&
    ++		test_cmp expect_fetch actual_fetch &&
    + 		git -C submodule cat-file -t $C &&
    + 		git -C sub1 cat-file -t $D &&
    ++		test_grep "trace: built-in: git submodule--helper get-default-remote sub1" \
    ++			"$pwd/on-demand_submodule_fetch_trace" &&
    ++		test_grep "trace: built-in: git fetch .* --submodule-prefix=sub1/ origin" \
    ++			"$pwd/on-demand_submodule_fetch_trace" &&
    + 		git checkout --recurse-submodules FETCH_HEAD
    + 	)
    + '
     @@ t/t5526-fetch-submodules.sh: test_expect_success 'fetch new submodule commit intermittently referenced by sup
      	)
      '
      
    -+test_expect_success 'fetch --recurse-submodules works with custom remote names' '
    ++test_expect_success 'fetch new submodule commits on-demand outside standard refspec with custom remote name' '
     +	# depends on the previous test for setup
     +
     +	# Rename the remote in sub1 from "origin" to "custom_remote"
     +	git -C downstream/sub1 remote rename origin custom_remote &&
     +
     +	# Create new commits in the original submodules
    -+	C=$(git -C submodule commit-tree -m "change outside refs/heads for custom remote" HEAD^{tree}) &&
    ++	C=$(git -C submodule commit-tree \
    ++		-m "change outside refs/heads for custom remote" HEAD^{tree}) &&
     +	git -C submodule update-ref refs/changes/custom1 $C &&
     +	git update-index --cacheinfo 160000 $C submodule &&
     +	test_tick &&
     +
    -+	D=$(git -C sub1 commit-tree -m "change outside refs/heads for custom remote" HEAD^{tree}) &&
    ++	D=$(git -C sub1 commit-tree \
    ++		-m "change outside refs/heads for custom remote" HEAD^{tree}) &&
     +	git -C sub1 update-ref refs/changes/custom2 $D &&
     +	git update-index --cacheinfo 160000 $D sub1 &&
     +
    -+	git commit -m "updated submodules outside of refs/heads for custom remote" &&
    ++	git commit \
    ++		-m "updated submodules outside of refs/heads for custom remote" &&
     +	E=$(git rev-parse HEAD) &&
     +	git update-ref refs/changes/custom3 $E &&
     +	(
     +		cd downstream &&
    -+		git fetch --recurse-submodules origin refs/changes/custom3:refs/heads/my_other_branch &&
    ++		DEEP_START=$(git -C submodule/subdir/deepsubmodule rev-parse --short \
    ++			origin/deep) &&
    ++		DEEP_END=$(git -C "$pwd/deepsubmodule" rev-parse --short deep) &&
    ++		cat >"expect_fetch_custom" <<-EOF &&
    ++		From $pwd/.
    ++		 * [new ref]         refs/changes/custom3 -> my_other_branch
    ++		Fetching submodule sub1
    ++		Fetching submodule sub1/subdir/deepsubmodule
    ++		Fetching submodule submodule
    ++		Fetching submodule submodule/subdir/deepsubmodule
    ++		From $pwd/./sub1
    ++		 * branch            $D -> FETCH_HEAD
    ++		Fetching submodule sub1/subdir/deepsubmodule
    ++		From $pwd/submodule
    ++		 * branch            $C -> FETCH_HEAD
    ++		Fetching submodule submodule/subdir/deepsubmodule
    ++		EOF
    ++		test_when_finished "rm -f $pwd/custom_on-demand_submodule_fetch_trace" &&
    ++		GIT_TRACE="$pwd/custom_on-demand_submodule_fetch_trace" \
    ++		git fetch --recurse-submodules origin \
    ++			refs/changes/custom3:refs/heads/my_other_branch \
    ++			2>actual_fetch_custom &&
    ++		# the without .gitmodules test above causes warnings
    ++		grep -v "^warning: " actual_fetch_custom >actual_fetch_warnings_removed &&
    ++		test_cmp expect_fetch_custom actual_fetch_warnings_removed &&
    ++
     +		git -C submodule cat-file -t $C &&
     +		git -C sub1 cat-file -t $D &&
    ++		test_grep "trace: built-in: git submodule--helper get-default-remote sub1" \
    ++			"$pwd/custom_on-demand_submodule_fetch_trace" &&
    ++		test_grep "trace: built-in: git fetch .* --submodule-prefix=sub1/ custom_remote $D" \
    ++			"$pwd/custom_on-demand_submodule_fetch_trace" &&
     +		git checkout --recurse-submodules FETCH_HEAD
     +	)
     +'
    @@ t/t5572-pull-submodule.sh: test_expect_success 'fetch submodule remote of differ
     +	test_path_is_file child/a-submodule/moreecho.t
     +'
     +
    -+test_expect_success 'fetch submodule remote of different non-origin name from superproject' '
    ++test_expect_success 'fetch non-origin submodule remote named different from superproject' '
     +	git -C child/a-submodule remote rename origin o2 &&
     +
     +	# Create commit that is unreachable from current master branch
    -+	git -C a-submodule checkout -b newmain2 master^ &&
    ++	# newmain is already reset in the previous test
     +	test_commit -C a-submodule echo_o2 &&
     +	test_commit -C a-submodule moreecho_o2 &&
     +	subc=$(git -C a-submodule rev-parse --short HEAD) &&
    @@ t/t5572-pull-submodule.sh: test_expect_success 'fetch submodule remote of differ
      
      test_done
     
    - ## t/t7425-submodule-get-default-remote.sh (new) ##
    + ## t/t7426-submodule-get-default-remote.sh (new) ##
     @@
     +#!/bin/sh
     +

 builtin/submodule--helper.c             |  38 +++++
 submodule.c                             |  17 ++-
 t/meson.build                           |   1 +
 t/t5526-fetch-submodules.sh             | 111 +++++++++++++-
 t/t5572-pull-submodule.sh               |  21 ++-
 t/t7426-submodule-get-default-remote.sh | 186 ++++++++++++++++++++++++
 6 files changed, 370 insertions(+), 4 deletions(-)
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
index e5174ee575..bf241a7a1e 100644
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
index 5e566205ba..19c0f05144 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -836,9 +836,34 @@ test_expect_success "fetch new submodule commits on-demand outside standard refs
 	git update-ref refs/changes/3 $E &&
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
+		test_when_finished "rm -f $pwd/on-demand_submodule_fetch_trace" &&
+		GIT_TRACE="$pwd/on-demand_submodule_fetch_trace" \
+		git fetch --recurse-submodules origin refs/changes/3:refs/heads/my_branch 2>actual_fetch &&
+		test_cmp expect_fetch actual_fetch &&
 		git -C submodule cat-file -t $C &&
 		git -C sub1 cat-file -t $D &&
+		test_grep "trace: built-in: git submodule--helper get-default-remote sub1" \
+			"$pwd/on-demand_submodule_fetch_trace" &&
+		test_grep "trace: built-in: git fetch .* --submodule-prefix=sub1/ origin" \
+			"$pwd/on-demand_submodule_fetch_trace" &&
 		git checkout --recurse-submodules FETCH_HEAD
 	)
 '
@@ -929,6 +954,90 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
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
+		test_when_finished "rm -f $pwd/custom_on-demand_submodule_fetch_trace" &&
+		GIT_TRACE="$pwd/custom_on-demand_submodule_fetch_trace" \
+		git fetch --recurse-submodules origin \
+			refs/changes/custom3:refs/heads/my_other_branch \
+			2>actual_fetch_custom &&
+		# the without .gitmodules test above causes warnings
+		grep -v "^warning: " actual_fetch_custom >actual_fetch_warnings_removed &&
+		test_cmp expect_fetch_custom actual_fetch_warnings_removed &&
+
+		git -C submodule cat-file -t $C &&
+		git -C sub1 cat-file -t $D &&
+		test_grep "trace: built-in: git submodule--helper get-default-remote sub1" \
+			"$pwd/custom_on-demand_submodule_fetch_trace" &&
+		test_grep "trace: built-in: git fetch .* --submodule-prefix=sub1/ custom_remote $D" \
+			"$pwd/custom_on-demand_submodule_fetch_trace" &&
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

