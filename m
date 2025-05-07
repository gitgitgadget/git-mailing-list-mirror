Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5FE157A5A
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746582644; cv=none; b=jna+yhbALAIJZuiVHx7PfnG8uH23I2PYelrtEbD+IGybwN7QkNuzmJVYVhmXNaLk43EE351/8e075WoABeIMmq/cZvjEfCuvGr594N+KMjsV2wJpJhHy0dBieADM/n9+rGm7z/+gTWq2HCuDGKt3JJrRX+2kCNHjLQUE5SWRznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746582644; c=relaxed/simple;
	bh=gcFlFioENP4wWNVRC/cilSB1DCncYGQbOhTdpI9r8vs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hutKPBX1+b730SFidybLy73W/5dNSHiiLsUkGuOeg4mLpOKM4W3ruXwLMzNwMj1frxXUhspeKd/yBCGXkbMjVKj1gFNZcluc4tCgXVhIs0oPAPkGH0TVh8X7hobfPBwkJxd8TK4S9UNzVJByiZ8v31gnr08SlSJjFb0kDgl0x0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtJdfK6A; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtJdfK6A"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39ee5a5bb66so4159420f8f.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746582640; x=1747187440; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQc+0xCkZpLpnLZ/VOSigoKCx6d8Wn5GtG1NDlUZW4U=;
        b=QtJdfK6A3xVZMz2V48Vpt44rQf9MZprdmyK8hyPNjUbaw243dsD5l/XIgGQ1pOHq8A
         kD7rFgruRtuIjcqWYZpB8Cx647naiq4YaeJTUXrYsEP20Rcl+8feKDPjrkH1eUUV5OEg
         ywibrxBLSBUHafWw/zvQHLGrOspbyl7K2Xr/7w9FTc15dETPSMfdqNLfFbWWcdfcBlsL
         brts2IJ4A59vdqoI8vWTrQOTcFz7GdWG52kEcg3e4K6QoLZwat1jph6hSt/AU0cxigrn
         u08W15JiE8vhuPEm+MaL8KP1QkU3bCMU6s5tN66JidKSYhRQUZFCTJlw2eueGHsiwWJa
         UGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746582640; x=1747187440;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQc+0xCkZpLpnLZ/VOSigoKCx6d8Wn5GtG1NDlUZW4U=;
        b=vcZK12+fOK0uTs/fH+q0Ya707X+3efpY1rrPoh403uOtWDLG8dgInkbPOn29spaFaD
         uG5Dz7lBApYqHEeNE9XWFvtCm5/N50gSA0gvGk0pOczVpR5nUhmhgFo68Vd7ej7R5hFM
         XL20TuW1tvBlLStVrjk1uLSHbJDh6U8zVVxm/66Sf/7lJKaUFCJTJzlmt5FMua//Bslx
         ECNHsWHum3dYimPbFBhrTa5TvNROdjkmR38dHDRHkPeBqbaT5ooCMGrcFUESZscx8tCt
         GIJdHK13qaaPe4KqKlPYDIVuaVtmc7x7ZcMQlkf4EP0PNI8r/PJ9pq0ZHipVL+CwwFnt
         XnhA==
X-Gm-Message-State: AOJu0YwFncb7/wXkNu/xt1G63+lQ0pNriDaXONg6E+eQ9/5rQpoZrs1h
	1uHRmVNw0/bjCCzbAX7+geKaAmyRYR9PQ3jD4HzNySU16tRXlkI9XhCZXg==
X-Gm-Gg: ASbGnctZGiqVBRL1yV95BlXKD7oMiNHD27A6Xm1Mtx4ymSDKDGmY+bypaRHaSvkhvyh
	R9dJkbshhBTYfdNZeTvVIw+q3cyUAxwVFUC4OQs+nZwg7oGXBwwcoJfQZxeY21S1i0AzjxWz48W
	U/Cgamoji1QhuXObV5syp6O6zukn+XH5U83mmhSPc61ernzP1wyUvkT8jaZsPmT9JmMJKLOvC4z
	DbxalYoppDqPX5wbHQxq1CY7FvXIVEeJLY0rNqcAEZADLyX8J3TAsYjx17o2tS4vpsa03mMPgFX
	TInqFIin03lDg+7NmPmKZ48B6YiI/0dgjwWkOjD6Rn46QNDMswVK
X-Google-Smtp-Source: AGHT+IEBnmgQZDTmfi+uCSziPzhAkYgu1tKaeRmJmXnCKbxUuUeeJ4ugagnJp/5NJHFgxGzvdo9VtA==
X-Received: by 2002:a05:6000:2403:b0:391:4743:6dc2 with SMTP id ffacd0b85a97d-3a0b49b9e12mr1027682f8f.25.1746582640218;
        Tue, 06 May 2025 18:50:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0ff8esm15380236f8f.79.2025.05.06.18.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 18:50:39 -0700 (PDT)
Message-Id: <1b99a559520a8bfed143c6fe8265f76b1ac4283c.1746582637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
References: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
	<pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 01:50:35 +0000
Subject: [PATCH v3 2/4] scalar register: add --no-maintenance option
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

When registering a repository with Scalar to get the latest opinionated
configuration, the 'scalar register' command will also set up background
maintenance. This is a recommended feature for most user scenarios.

However, this is not always recommended in some scenarios where
background modifications may interfere with foreground activities.
Specifically, setting up a clone for use in automation may require doing
certain maintenance steps in the foreground that could become blocked by
concurrent background maintenance operations.

Allow the user to specify --no-maintenance to 'scalar register'. This
requires updating the method prototype for register_dir(), so use the
default of enabling this value when otherwise specified.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/scalar.adoc |  8 +++++++-
 scalar.c                  |  8 ++++++--
 t/t9210-scalar.sh         | 13 ++++++++++++-
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
index 7e4259c6743f..b2b244a86499 100644
--- a/Documentation/scalar.adoc
+++ b/Documentation/scalar.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]
 	[--[no-]src] <url> [<enlistment>]
 scalar list
-scalar register [<enlistment>]
+scalar register [--[no-]maintenance] [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 scalar reconfigure [ --all | <enlistment> ]
@@ -117,6 +117,12 @@ Note: when this subcommand is called in a worktree that is called `src/`, its
 parent directory is considered to be the Scalar enlistment. If the worktree is
 _not_ called `src/`, it itself will be considered to be the Scalar enlistment.
 
+--[no-]maintenance::
+	By default, `scalar register` configures the enlistment to use Git's
+	background maintenance feature. Use the `--no-maintenance` to skip
+	this configuration. This does not disable any maintenance that may
+	already be enabled in other ways.
+
 Unregister
 ~~~~~~~~~~
 
diff --git a/scalar.c b/scalar.c
index b20b063471a6..da0c46bc96cc 100644
--- a/scalar.c
+++ b/scalar.c
@@ -612,11 +612,14 @@ static int cmd_list(int argc, const char **argv UNUSED)
 
 static int cmd_register(int argc, const char **argv)
 {
+	int maintenance = 1;
 	struct option options[] = {
+		OPT_BOOL(0, "maintenance", &maintenance,
+			 N_("specify if background maintenance should be enabled")),
 		OPT_END(),
 	};
 	const char * const usage[] = {
-		N_("scalar register [<enlistment>]"),
+		N_("scalar register [--[no-]maintenance] [<enlistment>]"),
 		NULL
 	};
 
@@ -625,7 +628,8 @@ static int cmd_register(int argc, const char **argv)
 
 	setup_enlistment_directory(argc, argv, usage, options, NULL);
 
-	return register_dir(1);
+	/* If --no-maintenance, then leave maintenance as-is. */
+	return register_dir(maintenance);
 }
 
 static int get_scalar_repos(const char *key, const char *value,
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index a81662713eb8..89a6a2a24d8b 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -108,7 +108,7 @@ test_expect_success 'scalar register warns when background maintenance fails' '
 	git init register-repo &&
 	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
 		scalar register register-repo 2>err &&
-	grep "could not turn on maintenance" err
+	grep "could not toggle maintenance" err
 '
 
 test_expect_success 'scalar unregister' '
@@ -129,6 +129,17 @@ test_expect_success 'scalar unregister' '
 	scalar unregister vanish
 '
 
+test_expect_success 'scalar register --no-maintenance' '
+	git init register-no-maint &&
+	event_log="$(pwd)/no-maint.event" &&
+	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
+	GIT_TRACE2_EVENT="$event_log" \
+	GIT_TRACE2_EVENT_DEPTH=100 \
+		scalar register --no-maintenance register-no-maint 2>err &&
+	test_must_be_empty err &&
+	test_subcommand ! git maintenance unregister --force <no-maint.event
+'
+
 test_expect_success 'set up repository to clone' '
 	test_commit first &&
 	test_commit second &&
-- 
gitgitgadget

