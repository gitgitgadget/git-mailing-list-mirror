Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601AC1898FB
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746582646; cv=none; b=GfCA6NSUSeTVGv0cRRxJomxPg6TwsYtLyT0qFvpPOv/P/fsS/jZfPMM+JA8dxdl+nTVhdfOKqRC+0SkzyJihGL3Lj6hv2fnJYoXt/DmJFmx+xuyygrYDTryYr5QEbrhfIDsehvezL791JV01L4PiTanwyXCNzah9C0HdgHDUQcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746582646; c=relaxed/simple;
	bh=EdVRalaJ+v+kcisZTza59NdNgkDNWHhjjUfrXAgEda0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Nvu09fQ99HQuIA+Ta59ijemW7FodHi+kI7oiVSNQdrbDloaFKdU7JtKuvWvBLp5D/Oy7G0+0ndlLbgI/rZENn9xZuuCT75gzN+0+QpuZbrQCjgaQ8mZcu9MqxHSgOrmUCLzpBB3PPhOLcuvC+MUjQbEJzEL9Bl9Lx8/e40GpVJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQRFQKDU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQRFQKDU"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d0618746bso45142445e9.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746582642; x=1747187442; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37xfrH+Rc2uqeoDB+gYA4ywEcBr24PYip03smtUYDLQ=;
        b=hQRFQKDUCs8ajyQMQvmXRwmTk9GNlquWnctbnocgflq8R0NhFaMkJJRYRYRXwa9ET3
         0iHR0TToFpdvCn7gZW98phrY3pDCk78FNwO0i5ZRATmKP2BgNeIBhk+ZblM6Z3S5BQDn
         4EmvEhWq/Ea7NN0AJV1ykJ+uyrVOPPFf8BAwRAHPlKpOggnqTVR53c9SqRrD2bcimY6f
         +++N41U6IpSc4UGWUlGRh1PWeR8Q1VXNz/b9XKV78cGpE2HE34Kx9inVgNsER+R0OhuQ
         HQSuzDL4LVD+spMDL7pXOqak/mYXOo80IE9daqxYs+r74F7gaVFxsVl7lu+CALhKKZC+
         Ha0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746582642; x=1747187442;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37xfrH+Rc2uqeoDB+gYA4ywEcBr24PYip03smtUYDLQ=;
        b=FIIYPeex90613JUdZiAOuJU5pa3RGIalTFlb9mUmLuwFO/3rJEKpOCFkZ02snkbnyO
         hCKWmav7JVGORhU4dlRuQ0VQ0A1wmUi1rHgcn7jWf22VTgNJHeJEPj1+5OSaeTrJeOHC
         6egPlyyoPG0OYNPv5uLEGYZbqHEd1r1ccVuYDEl3JpTyCNnr0wQbk/Xp7Y1NRhHHkrO8
         zZvRI2wrutESFu6M0wKRYZQjvX491TOG9my8VSm0Ka9+rJE4t8G++MS0M/uuCnN5ZGDd
         ryjXN31qkDUnSMbKK09CvR343yBBZ1lMKsn4KYk5gWy9lsXU+pEbrGeVw0CBvDOAMFuC
         RYsA==
X-Gm-Message-State: AOJu0YxteCE9dZ0I1+OBOceQs7YUR2tIa/G8M0NqcsxKc2hG9ysBsBwk
	KinEtrc0T9dRPG8wudcMpjPhYakr+bC/TtgRbC/0qk1lxAWM/efrhvWorQ==
X-Gm-Gg: ASbGncuIRt8l6zREJnwr450gI7wi0BH6im8e/W9TIjM2lNnnUCFuyC44hyPY6gSfEmH
	aOhkaF0f7bRCzqvd5yz69w1pL/R0Y4dG5TFIG/vhq0ipYVpzRUzih1fXDnzrM3XXc0yjv9o9G3B
	walinpT2OVXSzvS5KVxyCfaB4ALgGz+gB/HMmW3K8a4sHAP3xDVRRqMSAm38xlOAk8xVipwOJeM
	la7nTfqiMwnlQ96vr05gyQBXpjdUsuIQE3mJcMonkPzpOzsJGL5w1ELnd3s9ppv7kQGpTNRyPNZ
	cUrSd3y/wfcKw1Xa9umKHhuDUlyG/YpjN1ewoQeQEQ==
X-Google-Smtp-Source: AGHT+IHD7UUY/0CAPqtv++hlqrrZTSAhy31/aYzWXhMTkLVdaJE51WmPrfRT8bBI215dAaNiiwNTGg==
X-Received: by 2002:a05:600c:3e84:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-441d44dd23dmr7192015e9.22.1746582641942;
        Tue, 06 May 2025 18:50:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae831esm15612863f8f.57.2025.05.06.18.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 18:50:41 -0700 (PDT)
Message-Id: <684f04aaf7e87f22ab0b00a4fd42d2943304ef04.1746582637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
References: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
	<pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 01:50:37 +0000
Subject: [PATCH v3 4/4] scalar reconfigure: add --maintenance=<mode> option
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
    johannes.schindelin@gmx.de,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When users want to enable the latest and greatest configuration options
recommended by Scalar after a Git upgrade, 'scalar reconfigure --all' is
a great option that iterates over all repos in the multi-valued
'scalar.repos' config key.

However, this feature previously forced users to enable background
maintenance. In some environments this is not preferred.

Add a new --maintenance=<mode> option to 'scalar reconfigure' that
provides options for enabling (default), disabling, or leaving
background maintenance config as-is.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/scalar.adoc | 17 ++++++++++++++---
 scalar.c                  | 23 +++++++++++++++++++++--
 t/t9210-scalar.sh         | 13 ++++++++++++-
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
index 7753df3b4352..387527be1ea5 100644
--- a/Documentation/scalar.adoc
+++ b/Documentation/scalar.adoc
@@ -14,7 +14,7 @@ scalar list
 scalar register [--[no-]maintenance] [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
-scalar reconfigure [ --all | <enlistment> ]
+scalar reconfigure [--maintenance=<mode>] [ --all | <enlistment> ]
 scalar diagnose [<enlistment>]
 scalar delete <enlistment>
 
@@ -160,8 +160,19 @@ After a Scalar upgrade, or when the configuration of a Scalar enlistment
 was somehow corrupted or changed by mistake, this subcommand allows to
 reconfigure the enlistment.
 
-With the `--all` option, all enlistments currently registered with Scalar
-will be reconfigured. Use this option after each Scalar upgrade.
+--all::
+	When `--all` is specified, reconfigure all enlistments currently
+	registered with Scalar by the `scalar.repo` config key. Use this
+	option after each upgrade to get the latest features.
+
+--maintenance=<mode>::
+	By default, Scalar configures the enlistment to use Git's
+	background maintenance feature; this is the same as using the
+	`--maintenance=enable` value for this option. Use the
+	`--maintenance=disable` to remove each considered enlistment
+	from background maintenance. Use `--maitnenance=keep' to leave
+	the background maintenance configuration untouched for These
+	repositories.
 
 Diagnose
 ~~~~~~~~
diff --git a/scalar.c b/scalar.c
index dd6e1447e086..847d2dd2f58a 100644
--- a/scalar.c
+++ b/scalar.c
@@ -668,13 +668,19 @@ static int remove_deleted_enlistment(struct strbuf *path)
 static int cmd_reconfigure(int argc, const char **argv)
 {
 	int all = 0;
+	const char *maintenance_str = NULL;
+	int maintenance = 1; /* Enable maintenance by default. */
+
 	struct option options[] = {
 		OPT_BOOL('a', "all", &all,
 			 N_("reconfigure all registered enlistments")),
+		OPT_STRING(0, "maintenance", &maintenance_str,
+			 N_("<mode>"),
+			 N_("signal how to adjust background maintenance")),
 		OPT_END(),
 	};
 	const char * const usage[] = {
-		N_("scalar reconfigure [--all | <enlistment>]"),
+		N_("scalar reconfigure [--maintenance=<mode>] [--all | <enlistment>]"),
 		NULL
 	};
 	struct string_list scalar_repos = STRING_LIST_INIT_DUP;
@@ -694,6 +700,18 @@ static int cmd_reconfigure(int argc, const char **argv)
 		usage_msg_opt(_("--all or <enlistment>, but not both"),
 			      usage, options);
 
+	if (maintenance_str) {
+		if (!strcmp(maintenance_str, "enable"))
+			maintenance = 1;
+		else if (!strcmp(maintenance_str, "disable"))
+			maintenance = 0;
+		else if (!strcmp(maintenance_str, "keep"))
+			maintenance = -1;
+		else
+			die(_("unknown mode for --maintenance option: %s"),
+			    maintenance_str);
+	}
+
 	git_config(get_scalar_repos, &scalar_repos);
 
 	for (size_t i = 0; i < scalar_repos.nr; i++) {
@@ -758,7 +776,8 @@ static int cmd_reconfigure(int argc, const char **argv)
 		the_repository = old_repo;
 		repo_clear(&r);
 
-		if (toggle_maintenance(1) >= 0)
+		if (maintenance >= 0 &&
+		    toggle_maintenance(maintenance) >= 0)
 			succeeded = 1;
 
 loop_end:
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 89a6a2a24d8b..bd6f0c40d229 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -210,7 +210,18 @@ test_expect_success 'scalar reconfigure' '
 	GIT_TRACE2_EVENT="$(pwd)/reconfigure" scalar reconfigure -a &&
 	test_path_is_file one/src/cron.txt &&
 	test true = "$(git -C one/src config core.preloadIndex)" &&
-	test_subcommand git maintenance start <reconfigure
+	test_subcommand git maintenance start <reconfigure &&
+	test_subcommand ! git maintenance unregister --force <reconfigure &&
+
+	GIT_TRACE2_EVENT="$(pwd)/reconfigure-maint-disable" \
+		scalar reconfigure -a --maintenance=disable &&
+	test_subcommand ! git maintenance start <reconfigure-maint-disable &&
+	test_subcommand git maintenance unregister --force <reconfigure-maint-disable &&
+
+	GIT_TRACE2_EVENT="$(pwd)/reconfigure-maint-keep" \
+		scalar reconfigure --maintenance=keep -a &&
+	test_subcommand ! git maintenance start <reconfigure-maint-keep &&
+	test_subcommand ! git maintenance unregister --force <reconfigure-maint-keep
 '
 
 test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
-- 
gitgitgadget
