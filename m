Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB225D8FB
	for <git@vger.kernel.org>; Mon,  5 May 2025 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458853; cv=none; b=gVSB7SfcGrIDEF/Grcds5lc/AHwPuqLlG9lO2drtNfSId2P7VSNcgLgYDj3JQHMzHcMXEKY6RRuueIw3as7OwnFHeo8Rib67zCWzd5yPhHDH0norSA7mSHbE6fZiJs/Pa3yWd6z+u/qyB/3BlgfT4zyfsjcGWUQgdUpqCoV8Nxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458853; c=relaxed/simple;
	bh=C4EekIRbTnbtA+wvC8NFIS2gP6U6ZsqR3/GdGkW8pXg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TaCUiWZw29isxFPNdT4y0nkg44+MR4JZX1XCaZhmyImtUrmzwGo1nD+AxmFPYd/jL0odvw+8KEA2mmcom5NxSeRhACF9rePQMQd9r3atDF3qtw+/GxHVgy0v23+IpV3ODtNtkPw8IK9p3fuKLVNs5AIvEfkX3oCBgfOlSlcV+/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ih0rVz2s; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih0rVz2s"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39ee682e0ddso3053652f8f.1
        for <git@vger.kernel.org>; Mon, 05 May 2025 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746458849; x=1747063649; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxH4ZqDJ/v47BJ/Fqd1RijKr+RXYOOZ44YuHjsehVzg=;
        b=Ih0rVz2sq+vbdQnAuNA31TwWlzQc+o5yPqOK1ZroQB3INXGIHUgmgHqYIHJigo97wv
         tJpCRseOnI5zvNAVrufGvO3+vWEmcMz+ElieNYTS3pyhyIobcayxyGvfqm9/OE+FLucv
         Miy6/jBGMrddPZ1RDKANHNpb5txe7WBeY5ZH+9bjP89Dns8i/hGRPOd8E1xKKIiwaALc
         sIJgZyCHblBTQevkdI/6dryEZi7OEcc+Tbt4+V/Rrg9IESsPZnDkJFQAU+Egp6CbfCcZ
         yxWg+xqKdsCOD1FBLux1RPRiLH2yYlDMfD0C42osKQtIk8bbAa42xkGNSwjxE/uqv50w
         QbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746458849; x=1747063649;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxH4ZqDJ/v47BJ/Fqd1RijKr+RXYOOZ44YuHjsehVzg=;
        b=ueqe1LHV5gElWr5eOhJhvVP7wxKQOTMv+VPATuX51uYvblEkiGcX+2bGnvzXyX2AI4
         3jv+zBXZXzV2bx3+YXx23sdh0bIN/Aq+6C7MbAKjR1gaqPrvDdPsDUjZSC57DA+VWijG
         FD2DhZpKBw59r06f+GWPghTQKEfo2mJ+pmWo/XXABDO2oDuqcK1pfbhmKIoaKzc8qtj2
         fr+KEW1yPC/VoaHQ01X33YhhqEVltXkPAgqU2m2EYu5234t2IVP7w/WeeDG5fQ5NMJxU
         DY+CJl37JWdD5vJHM25uwGTuIevRdnAmfitdrbEf8iGGU+ZUgqNWGPjpu25G3Y/zu2QF
         SEbg==
X-Gm-Message-State: AOJu0Yx5nNos7OeLOGtjMK5bNxao58e6qTJL0DTo7ApuCINMaJ5DLNIs
	qsDAS+40mcqsWPxdStT+qPxRToIhUkR8gRLv9nPDPqHG8BA8MrfI0sSjag==
X-Gm-Gg: ASbGncsi3YIJp4Ieo1sBFDs0KKCLVoZmHg6SuCorD6BGWTLRjKwAgCTYnpjd0WQDAum
	/VdAQQWFMNfTO7sbl47kDj3cITVPIIn4fz9z/kimm5w8+a6FtChrnwIXLMulYemIPzTVMQkrHT0
	ArLoffGK8AT4BAOZqVDUBq5Fhf4JfhvsdonVuf9KQ7pmnoy+2zpctXXqSbxsW3JaGnL0VCceG7I
	P2Fd3bpTMEdqGo9gHB4W9q4rQs4P3hh5uhhFq1IlrBEkbLSiZBiQrpQ8tUzDgeVxx+Oc+sqUT8b
	qT/xeBPB6Hduwxafpc3hdQLLtPqKO3OHgrhEE6TkUeOKiCzOlKWf
X-Google-Smtp-Source: AGHT+IHPsBaKLvk075/vmc0UCCjkDKN6vSayakMLmoF3jzTeh0m2dv6u5I6UnbLgw/mmZa4CfDkyfw==
X-Received: by 2002:a5d:5f43:0:b0:39e:cc10:3945 with SMTP id ffacd0b85a97d-3a09fd6b904mr6260522f8f.2.1746458848657;
        Mon, 05 May 2025 08:27:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3441sm10556806f8f.26.2025.05.05.08.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:27:28 -0700 (PDT)
Message-Id: <6fac9c4c394b9882a2f7af6209af389edf384e4d.1746458844.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
	<pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 May 2025 15:27:24 +0000
Subject: [PATCH v2 4/4] scalar reconfigure: add --no-maintenance option
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

Add a new --[no-]maintenance option to 'scalar reconfigure' that avoids
running 'git maintenance start' on these enlistments.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/scalar.adoc | 14 +++++++++++---
 scalar.c                  |  9 ++++++---
 t/t9210-scalar.sh         |  7 ++++++-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
index 7753df3b4352..2868b01988e4 100644
--- a/Documentation/scalar.adoc
+++ b/Documentation/scalar.adoc
@@ -14,7 +14,7 @@ scalar list
 scalar register [--[no-]maintenance] [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
-scalar reconfigure [ --all | <enlistment> ]
+scalar reconfigure [--[no-]maintenance] [ --all | <enlistment> ]
 scalar diagnose [<enlistment>]
 scalar delete <enlistment>
 
@@ -160,8 +160,16 @@ After a Scalar upgrade, or when the configuration of a Scalar enlistment
 was somehow corrupted or changed by mistake, this subcommand allows to
 reconfigure the enlistment.
 
-With the `--all` option, all enlistments currently registered with Scalar
-will be reconfigured. Use this option after each Scalar upgrade.
+--all::
+	When `--all` is specified, reconfigure all enlistments currently
+	registered with Scalar by the `scalar.repo` config key. Use this
+	option after each upgrade to get the latest features.
+
+--[no-]maintenance::
+	By default, Scalar configures the enlistment to use Git's
+	background maintenance feature. Use the `--no-maintenance` to skip
+	this configuration and leave the repositories in whatever state is
+	currently configured.
 
 Diagnose
 ~~~~~~~~
diff --git a/scalar.c b/scalar.c
index dd6e1447e086..0b8a63f6e5a6 100644
--- a/scalar.c
+++ b/scalar.c
@@ -667,14 +667,16 @@ static int remove_deleted_enlistment(struct strbuf *path)
 
 static int cmd_reconfigure(int argc, const char **argv)
 {
-	int all = 0;
+	int all = 0, maintenance = 1;
 	struct option options[] = {
 		OPT_BOOL('a', "all", &all,
 			 N_("reconfigure all registered enlistments")),
+		OPT_BOOL(0, "maintenance", &maintenance,
+			 N_("specify if background maintenance should be enabled")),
 		OPT_END(),
 	};
 	const char * const usage[] = {
-		N_("scalar reconfigure [--all | <enlistment>]"),
+		N_("scalar reconfigure [--[no-]maintenance] [--all | <enlistment>]"),
 		NULL
 	};
 	struct string_list scalar_repos = STRING_LIST_INIT_DUP;
@@ -758,7 +760,8 @@ static int cmd_reconfigure(int argc, const char **argv)
 		the_repository = old_repo;
 		repo_clear(&r);
 
-		if (toggle_maintenance(1) >= 0)
+		if (maintenance &&
+		    toggle_maintenance(1) >= 0)
 			succeeded = 1;
 
 loop_end:
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 89a6a2a24d8b..34765a49fd07 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -210,7 +210,12 @@ test_expect_success 'scalar reconfigure' '
 	GIT_TRACE2_EVENT="$(pwd)/reconfigure" scalar reconfigure -a &&
 	test_path_is_file one/src/cron.txt &&
 	test true = "$(git -C one/src config core.preloadIndex)" &&
-	test_subcommand git maintenance start <reconfigure
+	test_subcommand git maintenance start <reconfigure &&
+	test_subcommand ! git maintenance unregister --force <reconfigure &&
+
+	GIT_TRACE2_EVENT="$(pwd)/reconfigure-maint" scalar reconfigure --no-maintenance -a &&
+	test_subcommand ! git maintenance start <reconfigure-maint &&
+	test_subcommand ! git maintenance unregister --force <reconfigure-maint
 '
 
 test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
-- 
gitgitgadget
