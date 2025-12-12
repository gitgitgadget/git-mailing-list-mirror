Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BB131196C
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552537; cv=none; b=eJrJPATEc9ugqX2TF809q4gsrW1Ff9CkDRVBTS55knPcMsKJgMQ0PbSCHuE/MXQdJ+CaYbApkjTl2SJtBTLNLKAR9Mm8axT1tDEMtjFvktgRwFEksC1OtLNMg33kNkeNkrZytHOCCmrly2iHQ21Zyq4UzUwOBkAxF5ryTozNQ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552537; c=relaxed/simple;
	bh=sY5SJYvEKwLeVgDWvpJeq4COIzsbe8FwgCJadTM7gBg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XgV1YfsTec+WBwBM5G6f6OEKUqVdzDTVRzgAZYl0b8XXk+EYVfpYocj4Sp1d+MFU7U37cFcQ5uCSL93E1SQIebWPFILXJVJ/LPIRI5YgLCG0HzZ47gEpJXvCOmupWZ5toTpbSBLhydqT0UyJ8zAuNCdVg+bubEaIvjJMuhFwX78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ndkk5ksH; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndkk5ksH"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c075ec1a58aso819709a12.0
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 07:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765552535; x=1766157335; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4xZAssUK8F+kILt+4v2FT2Dymec6QDCYbnn48++k+M=;
        b=Ndkk5ksHk8cjk2CBNR4pXgLMrgNZMSFc39l6jluvrpCmVHcOYo5jlULFS1xt4+VBCp
         ZaZIGNfqMgcQ+XdTR6nfhMuJGVW82tAv29QN2RJH/vyWXicQb6Kgd4rsqvkzuxgSt8Qf
         a63aOfYd85X1hcStjtuQgVnzZ2xi/rroO3Mc+nZaPC7qrAXtiORHMPnP+U30MsWkNiGt
         WtXrCmSYL63tgoCJ5xN4mf1wTXizFbYcsTfw3C76H83D/Njgw/MOIv8Yi5Bs5TprSJ1r
         J3hrQeS3mc81euLsOdfF66LZGVWEygTlC2Y1Nv8AYhYPEC6/k2nd43iB6jv2baki9dkn
         46Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765552535; x=1766157335;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L4xZAssUK8F+kILt+4v2FT2Dymec6QDCYbnn48++k+M=;
        b=CX/3xna2DnJbvcO1e7qjSXo/c+waKBVee0WHMxk1XoXhaSQH04mhrqMsQFH7vWAPNT
         +fxfAKlQcXa7tdy4qaUei0k7cTuUBQJdQdFNZP0OyzPY05pTQ5LYMW8lyKDy7p1HDtnd
         hE2O/ym7Wj1xFLXL9owH+8urOtvYMtiPDDBnpN9qfIAQvhVmEOHDB88AFmeRpgXU602o
         vkx9s5rSGAIapIhk9WDDlyCMfWMVhkkniIWTuCpOqTxXo60IZqUWxkzsSYSGpSJfSr5N
         uMqLvIJpxYfUOpxQN19M3byF6NE255CzFd9OJfKFgz0hR5JTwhDrcKf2iMfQXCidgP7f
         r5sg==
X-Gm-Message-State: AOJu0YxIHXM0oDDeQYgoH6qF/DhNXjiZg1VcsV2pyTwr4N8gNmfXtLRn
	Q8xFXAo9i+Z49aRjxtW7GmsotLU9lhPJLBUX1k8gzRHUo+CU/qICGXv84GcfVmT1
X-Gm-Gg: AY/fxX7uZuabIb0kg+zGCpJ81lgxxDBvU48x2R84Rc7CkrP7eJg6x4QBfpvYSuCngPW
	YqKGfZawnXBNkpD9h7YmX3zRV3LGR5c9prYNF/Jsn8nFE0SbW/jQmlq8Da51rgMyPJi3jOV9a5r
	nhxjrXd4IdQt5HqABHuZOdmu2gWwR7IDczMIr0kqo31/htiTKLtUrHzfIYmsP6eoPXEySgh02EF
	hHabUDHOQeYuBNhgKi0UmLkEYR/MHVtH2uY12VNMIgiOgLFR1uE2wEeHiW7DgZDbMXs6D2EpKut
	5mMscc6LROlzIKdJIqnvPywNQIjLXkF1d508ROfuDLDisckXD4dlw7vOeG2bJyDACiG4MO+yYQQ
	rrR+MluyWaQTkS9B6pNRn3kAPUhgMobLfbBWNfLlntBmYShRZWJGa+1dDi9ozTk4qOCoQDiRMPd
	j2yUa40YAyWudpyQ==
X-Google-Smtp-Source: AGHT+IHbmbHQYSq55sP4Q46RcJSoSlzp1o8RoyOu0oD4oea03e4+URbDVt3zcQU4PZ6srk3pFEIjDQ==
X-Received: by 2002:a05:7301:d192:b0:2a4:809d:9a8b with SMTP id 5a478bee46e88-2ac303a3b49mr1211693eec.20.1765552534508;
        Fri, 12 Dec 2025 07:15:34 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac190acd01sm16265708eec.1.2025.12.12.07.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:15:33 -0800 (PST)
Message-Id: <85b499a616d7595287499e14358bc76618881e44.1765552528.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
References: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
	<pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Dec 2025 15:15:26 +0000
Subject: [PATCH v3 3/5] scalar: remove stale config values
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
Cc: gitster@pobox.com,
    ps@pks.im,
    atthewhughes934@gmail.com,
    johannes.schindelin@gmx.de,
    Matthew Hughes <matthewhughes934@gmail.com>,
    Henrique Ferreiro <hferreiro@igalia.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

These config values were added in the original Scalar contribution,
d0feac4e8c (scalar: 'register' sets recommended config and starts
maintenance, 2021-12-03), but were never fully checked for validity in
the upstream Git project. At the time, Scalar was only intended for the
contrib/ directory so did not have as rigorous of an investigation.

Each config option has its own justification for removal:

* core.preloadIndex: This value is true by default, now. Removing this
  causes some changes required to the tests that checked this config
  value. Use gui.gcwarning=false instead.

* core.fscache: This config does not exist in the core Git project, but
  is instead a config option for a Git for Windows feature.

* core.multiPackIndex: This config value is now enabled by default, so
  does not need to be called out specifically. It was originally
  included to make sure the background maintenance that created
  multi-pack-indexes would result in the expected performance
  improvements.

* credential.validate: This option is not something specific to Git but
  instead an older version of Git Credential Manager for Windows. That
  software was replaced several years ago by the cross-platform Git
  Credential Manger so this option is no longer needed to help users who
  were on that older software.

* pack.useSparse=true: This value is now Git's default as of de3a864114
  (config: set pack.useSparse=true by default, 2020-03-20) so we don't
  need it set by Scalar.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c          |  5 -----
 t/t9210-scalar.sh | 20 ++++++++++----------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/scalar.c b/scalar.c
index 55b8542770..aeebea41fa 100644
--- a/scalar.c
+++ b/scalar.c
@@ -135,9 +135,6 @@ static int set_recommended_config(int reconfigure)
 	struct scalar_config config[] = {
 		/* Required */
 		{ "am.keepCR", "true", 1 },
-		{ "core.FSCache", "true", 1 },
-		{ "core.multiPackIndex", "true", 1 },
-		{ "core.preloadIndex", "true", 1 },
 #ifndef WIN32
 		{ "core.untrackedCache", "true", 1 },
 #else
@@ -157,7 +154,6 @@ static int set_recommended_config(int reconfigure)
 #endif
 		{ "core.logAllRefUpdates", "true", 1 },
 		{ "credential.https://dev.azure.com.useHttpPath", "true", 1 },
-		{ "credential.validate", "false", 1 }, /* GCM4W-only */
 		{ "gc.auto", "0", 1 },
 		{ "gui.GCWarning", "false", 1 },
 		{ "index.skipHash", "true", 1 },
@@ -166,7 +162,6 @@ static int set_recommended_config(int reconfigure)
 		{ "merge.stat", "false", 1 },
 		{ "merge.renames", "true", 1 },
 		{ "pack.useBitmaps", "false", 1 },
-		{ "pack.useSparse", "true", 1 },
 		{ "receive.autoGC", "false", 1 },
 		{ "feature.manyFiles", "false", 1 },
 		{ "feature.experimental", "false", 1 },
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 923c243c13..009437a5f3 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -202,15 +202,15 @@ test_expect_success 'scalar clone --no-... opts' '
 test_expect_success 'scalar reconfigure' '
 	git init one/src &&
 	scalar register one &&
-	git -C one/src config core.preloadIndex false &&
+	git -C one/src config unset gui.gcwarning &&
 	scalar reconfigure one &&
-	test true = "$(git -C one/src config core.preloadIndex)" &&
-	git -C one/src config core.preloadIndex false &&
+	test false = "$(git -C one/src config gui.gcwarning)" &&
+	git -C one/src config unset gui.gcwarning &&
 	rm one/src/cron.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/reconfigure" scalar reconfigure -a &&
 	test_path_is_file one/src/cron.txt &&
-	test true = "$(git -C one/src config core.preloadIndex)" &&
-	test_grep "preloadIndex = true # set by scalar" one/src/.git/config &&
+	test false = "$(git -C one/src config gui.gcwarning)" &&
+	test_grep "GCWarning = false # set by scalar" one/src/.git/config &&
 	test_grep "excludeDecoration = refs/prefetch/\* # set by scalar" one/src/.git/config &&
 
 	test_subcommand git maintenance start <reconfigure &&
@@ -234,14 +234,14 @@ test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
 		git init $num/src &&
 		scalar register $num/src &&
 		git -C $num/src config includeif."onbranch:foo".path something &&
-		git -C $num/src config core.preloadIndex false || return 1
+		git -C $num/src config unset gui.gcwarning || return 1
 	done &&
 
 	scalar reconfigure --all &&
 
 	for num in $repos
 	do
-		test true = "$(git -C $num/src config core.preloadIndex)" || return 1
+		test false = "$(git -C $num/src config gui.gcwarning)" || return 1
 	done
 '
 
@@ -256,7 +256,7 @@ test_expect_success 'scalar reconfigure --all with detached HEADs' '
 		rm -rf $num/src &&
 		git init $num/src &&
 		scalar register $num/src &&
-		git -C $num/src config core.preloadIndex false &&
+		git -C $num/src config unset gui.gcwarning &&
 		test_commit -C $num/src initial &&
 		git -C $num/src switch --detach HEAD || return 1
 	done &&
@@ -265,7 +265,7 @@ test_expect_success 'scalar reconfigure --all with detached HEADs' '
 
 	for num in $repos
 	do
-		test true = "$(git -C $num/src config core.preloadIndex)" || return 1
+		test false = "$(git -C $num/src config gui.gcwarning)" || return 1
 	done
 '
 
@@ -297,7 +297,7 @@ test_expect_success 'scalar supports -c/-C' '
 	git init sub &&
 	scalar -C sub -c status.aheadBehind=bogus register &&
 	test -z "$(git -C sub config --local status.aheadBehind)" &&
-	test true = "$(git -C sub config core.preloadIndex)"
+	test false = "$(git -C sub config gui.gcwarning)"
 '
 
 test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
-- 
gitgitgadget

