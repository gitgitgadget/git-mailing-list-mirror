Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8524BD7A4
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778066; cv=none; b=MT4oWisQjjH6zJs6snOsY+tSSc7zXYOljL0k5mSbW02ptdC+A+g3XcAXmIniA3jf/i+GyISsd0jsRibXUM2oOwp6DyFJ3NPqoRf1rhh9+gvGgzUGGHivxYY9ER3nMODXo1IvfE48ybb5OqmYIc2XiCtj3D7MrxqNkth7ZmkYKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778066; c=relaxed/simple;
	bh=l3QEggL+9bOppfvVidjmmJzVGB2dvyWXeaxpGrPfLd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thAW96txAwGkMKyLp3pOPoyamv07L8ISQiERem/SxoPaxWx6QyAWFwsKw4iWmNkAT3QgkG9se9FCNhkg/sO1T0RRPez/ndzvKuV2WdsYuu/3chgU593ImB6GDosAYDPvTlf0U9iDSOmvKG0tg6jAtQib2ft5bRS0mTWZBtjKH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw6OcLCZ; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw6OcLCZ"
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-93c65d5e6f8so233686185a.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790778054; x=1791382854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OybN6aAZ5IaJ2vFBlbEEcyLsLNKx/nWPvjdtWaa99C0=;
        b=Bw6OcLCZuNhhA8wXTjXiM7oj35mZ53wDr5/YBV02yUDSRdTn4Cv76tdMnzWq4CP8iJ
         J40EKkLQE6LgYrioAI7w4qo+Mus/aFCbiehMakrSPMeM4fjVhKzMyO6LHdphcUZAWVhm
         aXmxcbUlsMXVksHyCvIF2G/NWEUms5wirNTADPz8vNQP3rq6ltzPR6XOSOvXfgN354VD
         PGbRUQD6cwxaMZSbqmMVx0mZ4hMK3JE/ap3cEMluAdK/g0RPY64YnqXhjy6fu/27kzog
         5NvP6LSrjLvMWOU/v2ipgpCsVCsatb8fWT13rSGOjfgq2auR//+YEUDobviua4bFLJOB
         vKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790778054; x=1791382854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OybN6aAZ5IaJ2vFBlbEEcyLsLNKx/nWPvjdtWaa99C0=;
        b=SR8ixsrN/wkJu4I+bT/zx4ruEahZvJbmos4X4qNL7RPXpNvJ/m3ZzfzcEy3mjYNqs7
         0z7GWNNdM80PvaWwnoh6CPWVshPSBbq2IHmj/Aa9NtjSYFxlXKD8fHJ5i1XzlAIXFeSr
         6JrLENhmnz7t3lO1Mt3SSi2kg3XuklUztDzsfdw5ww4GNv3hAXe6FhQIeOC+GNUgyPat
         XSnuD4FhsqJG6r7Zm7UxwaVQAuFb+gVUOl62kTXpBOIHdpQoiqp4LiQv3lBhyYNkxw62
         sdiQdVgbOSZ1Bdh2x4AtwzmccxHLi0kqAZ5NLk7dmh62iX71eQbY0EcAJoJ+nmvrbc/x
         lY4w==
X-Gm-Message-State: AFuF++l4sIWi4bbfW58YWKZtukpHQLyZmr2TYsa9NmqsXJFRJrO/ahYC
	5D/2vGjE0GAqWksUiKI388+XSn+b93kqlQqrNmEJpW2FwvEWK09Q6B2RZHVx196V
X-Gm-Gg: AYBFou2BS4DTwzKiP+yZfiagLYX14/+EzApXssCn/SstEr0QiSGRuDYBN0GiZWbPm8a
	KTCe4UMO8z2GHQ2KlEbwTba9pwRo1dBwKglHQ71Yg6Sc30vzN5RH/VEt7+iavGWpDBqQeIkAlCx
	Ff+rLit/ITkWRX6rBYj3AknbDvBbNUuaeG+OomJ8VW9qxnX7daM8w9u9tZCKutATVQu1UG8jAIl
	fc/vKTmSh3VIHNnnmbu5+cBlpYTcnVEjtIizyZBdffusaJk1q16vNIzKRC04LDHO0dqpftsWgxX
	cVk4xQncJOHIiGvC2FzDdB2QnJPwMSMpDIuIDqcqYRDrfbsXhj/oeFOndVcpVoJ/i+zH2hEA5v/
	5ddYnL7yehQhUtjyx9j6/f/FowrIZMfTy3FbmF+q+qaGPWRPV2deksAIMe+ggzud01eUuJvSXFA
	0J+B+PtyN8z/BNPo+4vFtl8vDcKo1VJw4hFPagsQwADNJ+WxTvTsfjT54wI7dG5r0vgtI02WqtS
	vEeeb7yOq248+/b6kw4M3kEUbU1zuAkRtKA+GQ+++5Wq0kzRkLPGnIkgNAbw+pNy/h3vUap18Jd
	ceCJUEyYhL3AyVVDCc22RAu3iyRDSjtXqJ+mUIDOjh8Fb8QhbFvn1h1uHedbhHTxjKnQf/IkwVD
	GgZD8caoN+CObSA9dysyIFZOGIpENlw5khlllrw7qMy29Rb7GzJ0YEw4=
X-Received: by 2002:a05:620a:2847:b0:93c:7948:6e84 with SMTP id af79cd13be357-93ca9844cc7mr282665885a.52.1790778053594;
        Wed, 30 Sep 2026 07:20:53 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-eastus-03.tradc-corp.com. [40.76.104.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ca808106csm124645685a.9.2026.09.30.07.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:20:52 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 30 Sep 2026 10:20:35 -0400
Subject: [PATCH v3 2/2] ci: use twice the CPU count on both providers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ci-large-test-resources-v3-2-d65ac7c21b5f@gmail.com>
References: <20260930-ci-large-test-resources-v3-0-d65ac7c21b5f@gmail.com>
In-Reply-To: <20260930-ci-large-test-resources-v3-0-d65ac7c21b5f@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1790778039; l=2633;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=l3QEggL+9bOppfvVidjmmJzVGB2dvyWXeaxpGrPfLd0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH3BG5AaS9kfgLyabWWysrZz65nIC+5ktAudnkrdX2Mjuirmruarb5jv9qGwWVdv3+fRHGwXMwn
 RVBR4M4UIWgk=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

GitHub Actions sets JOBS to ten regardless of runner size, while
GitLab CI uses the detected CPU count. Use twice the CPU count for
Make and prove on both providers, doubling GitLab's job count.

Five GitHub Actions attempts per policy, with the long tests enabled,
gave these sums of per-job median successful build/test-step times
(minutes; four or five samples per job) [1-3]:

                      Fixed 10   CPU count   2x CPU count
  Linux Make             278.9       273.9          259.9
  macOS Make              94.5       119.1           99.8
  Windows Make           102.2       103.8          100.8

Workflow overhead is excluded; Windows runner images varied.

Use twice the CPU count to scale concurrency with runner size while
avoiding the larger macOS slowdown observed with one job per CPU.
Compared with ten jobs, this trades a lower Linux total for a higher
macOS total.

Keep GitLab's Linux and Windows CPU queries. On macOS, use the native
sysctl command on both providers so CPU detection does not depend on
GNU coreutils.

Link: https://github.com/tamird/git/actions/runs/36070869894/attempts/1 [1]
Link: https://github.com/tamird/git/actions/runs/36070867524/attempts/1 [2]
Link: https://github.com/tamird/git/actions/runs/36070867647/attempts/1 [3]

Assisted-by: LLM
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 ci/lib.sh | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index c6ccbf8c17..f0b7f35850 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -227,7 +227,6 @@ then
 	cache_dir="$HOME/none"
 
 	GIT_TEST_OPTS="--github-workflow-markup"
-	JOBS=10
 
 	distro=$(echo "$CI_JOB_IMAGE" | tr : -)
 elif test true = "$GITLAB_CI"
@@ -250,7 +249,6 @@ then
 	case "$OS,$CI_JOB_IMAGE" in
 	Windows_NT,*)
 		CI_OS_NAME=windows
-		JOBS=$NUMBER_OF_PROCESSORS
 		;;
 	*,macos-*)
 		# GitLab CI has Python installed via multiple package managers,
@@ -260,11 +258,9 @@ then
 		export PATH="$(brew --prefix)/bin:$PATH"
 
 		CI_OS_NAME=osx
-		JOBS=$(nproc)
 		;;
 	*,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
 		CI_OS_NAME=linux
-		JOBS=$(nproc)
 		;;
 	*)
 		echo "Could not identify OS image" >&2
@@ -291,6 +287,19 @@ else
 	exit 1
 fi
 
+case "$CI_OS_NAME" in
+windows|windows_nt)
+	JOBS=$NUMBER_OF_PROCESSORS
+	;;
+osx)
+	JOBS=$(sysctl -n hw.logicalcpu)
+	;;
+*)
+	JOBS=$(nproc)
+	;;
+esac
+JOBS=$((2 * JOBS))
+
 MAKEFLAGS="$MAKEFLAGS --jobs=$JOBS"
 GIT_PROVE_OPTS="--timer --jobs $JOBS"
 

-- 
2.56.0.rc2.851.g50a151a6e9.frankengit

