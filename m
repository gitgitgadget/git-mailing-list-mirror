Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACA741C64
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746582642; cv=none; b=L3Nq2iv0GmxHQBho4UmG2oDSZngg1m/2D9Ng8dQp9wrARNUXbwEyWs3vyJfoIBCmFx56VKTuRl3bZHoJq/Zn/XS8lWDOD1oPXYGy0sZ7Jy1vU81pCYQlOQJrIJ/pPGIfJBNwrkPM3F8nC3H152jahNOteU5zkYGkAtW7uJXf++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746582642; c=relaxed/simple;
	bh=vc+WFNxtGBdlxlvrEzv0A70dKMObikFqggLbNsf+RiI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oy8fy0PL3iQ543gEHWGvy4RouCvwrAear70jkHvGb73+05sHjZhbO86Y6mYbt4PeuMa3vUlwr4dhzPqiLSarg+UGbBtWX28H9MjbxdKbaw9rYeayRCugI+AI5+RtzixuW+Hd53D3bxniKP+1QBucD12Lnw7o309z8z28YnGIwII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKK7e2J7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKK7e2J7"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so2899665e9.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746582638; x=1747187438; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVaVAXzq9zSl8D0tGjQvAZxTmsTz0pTmLxYMa3SJIo8=;
        b=ZKK7e2J7D8s4Fe6ENOfW30uyr0c6zGyqmw/CCtrRgwffF5BzxZ+XHYoBJvjXcGRQyv
         OYVQj+2nTai35vHvhGulkWYEtJ4uQ3BavX5yzwgtekQPDr3bSOXBLUrPvpH0CJ3l+zQE
         azLKyq42yjbnRzUuAqC58DerIRkTRC/UqOaCZtMTY7ITW71Hg+N3R7LTEbnBEM8n3zQJ
         OopP2ECjRPE5Wy7R3gPSMjjUjIc3uHrn+SVvwuhpPi6kCGNA61mXT0/vHzRZ/AcYkzBu
         crI9TdSPnv8h51X1bvVPg+3tiRjjvmbXV44f/xU5xC/1hI1DiB2hASoyzbiCgX515Q2F
         YIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746582638; x=1747187438;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVaVAXzq9zSl8D0tGjQvAZxTmsTz0pTmLxYMa3SJIo8=;
        b=et9sMPj0kYDuposU0ASCiaXXUr/68RXHKAE5X5opkkXgMjkWlMoMfYboWugD4kp2uZ
         jmphJYi18q1L3MObhr0IecD7tLxI4TeLf4PawJSJ6qBSTIlPNKacYi93b2OEtbkEyMOW
         3YPejKwMw8eo5GtRnLU/W+/eme89NbBF9zjEud/nRncRiMfBSYGpvqT5jo0q+dg6pbjI
         Z11DXsjf1v/xkSg2OWQ1eBNWh/iBt+Z2KKpPVziJmF+DSEf3vrgAT3hLbFT92/JAU7HG
         ZIYJSAG48Vbp9MNj6QaSvkrraU8J+Jo1rz4GZLTPoFumOnHEW7A5tlCkyQe9siGs5SRH
         zr5w==
X-Gm-Message-State: AOJu0YwDN9BsD4IcApaS8Y1vrheS9pQvAp06XiWHtkmecq/y76XNlh9j
	UbRwKVUikdsw6RZ2qmIwtFCZyGZJxYLGT5ySsb91w0LdjTO+FEykqXQdpQ==
X-Gm-Gg: ASbGnctqFNdsa5B/abj4XTFCOoFITsPHy0XEZ8TXOjzkN6EABojwpTwXYdn9lMyHxyq
	o5LW0NiGyBlMwiOQPd6JMOMVXlWrPRfuZlDaDBIOT5dodfryF/r85VXEXmI8HXM21OOXUJEN3fm
	RfWSrGTZ3APbtiuEWOP+AA5g+06nNIXOpBRs48tNl4fD3bYBZZFriOgE5tuq6BdYB4LG3aJQINj
	UMWDZ2nevdE0ej/Eu8jX5lo9XCG2FmmuVH3RBN4FX3mR7Lqmo52LNAqTJ4ZmPHWl4O0nlGBJCuK
	W5YleOYXFVJvHMFa5VMAxe/LwOSAihHSOj5sicjt0g==
X-Google-Smtp-Source: AGHT+IFuo5jySjesyJmYxsSuZRRuBOhSasbK5rUxdglpKa+UUENeu/UUI9qgiGO92ODX2dOIFvWK6A==
X-Received: by 2002:a05:600c:2e52:b0:43c:ec72:3daf with SMTP id 5b1f17b1804b1-441d3a78febmr11758405e9.14.1746582638464;
        Tue, 06 May 2025 18:50:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d440fff6sm11883535e9.25.2025.05.06.18.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 18:50:38 -0700 (PDT)
Message-Id: <pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
In-Reply-To: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
References: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 01:50:33 +0000
Subject: [PATCH v3 0/4] scalar: add --no-maintenance option
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
    Derrick Stolee <stolee@gmail.com>

These patches add a new --no-maintenance option to the scalar register and
scalar clone commands. My motivation is based on setting up Scalar clones in
automated environments that set up a repo onto a disk image for use later.
If background maintenance runs during later setup steps, then this
introduces a variable that is unexpected at minimum and disruptive at worst.
The disruption comes in if the automation has steps to run git maintenance
run --task=<X> commands but those commands are blocked due to the
maintenance.lock file.

Functionally, these leave the default behavior as-is but allow disabling the
git maintenance start step when users opt-in to this difference. The idea of
Scalar is to recommend the best practices for a typical user, but allowing
customization for expert users.


Updates in v2
=============

 * The previous use of toggle_maintenance() in register_dir() would run the
   'git maintenance unregister --force' command. There is a new patch 1 that
   is explicit about whether this should or should not happen and new tests
   are added to verify this behavior in the later patches.
 * A new patch 4 adds the --[no-]maintenance option to scalar reconfigure.


Updates in v3
=============

 * Patch 4 converts the --[no-]maintenance option of scalar reconfigure to
   --maintenance=<mode> to keep the default behavior the same (enable
   maintenance) but also allow two other modes: disable maintenance and
   leave maintenance as configured.

Thanks, -Stolee

Derrick Stolee (4):
  scalar: customize register_dir()'s behavior
  scalar register: add --no-maintenance option
  scalar clone: add --no-maintenance option
  scalar reconfigure: add --maintenance=<mode> option

 Documentation/scalar.adoc | 32 ++++++++++++++++---
 scalar.c                  | 65 +++++++++++++++++++++++++++++++--------
 t/t9210-scalar.sh         | 26 ++++++++++++++--
 t/t9211-scalar-clone.sh   | 11 ++++++-
 4 files changed, 114 insertions(+), 20 deletions(-)


base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1913%2Fderrickstolee%2Fscalar-no-maintenance-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1913/derrickstolee/scalar-no-maintenance-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1913

Range-diff vs v2:

 1:  f3a3cfe3ef1 = 1:  f3a3cfe3ef1 scalar: customize register_dir()'s behavior
 2:  1b99a559520 = 2:  1b99a559520 scalar register: add --no-maintenance option
 3:  e52b1282d93 = 3:  e52b1282d93 scalar clone: add --no-maintenance option
 4:  6fac9c4c394 ! 4:  684f04aaf7e scalar reconfigure: add --no-maintenance option
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    scalar reconfigure: add --no-maintenance option
     +    scalar reconfigure: add --maintenance=<mode> option
      
          When users want to enable the latest and greatest configuration options
          recommended by Scalar after a Git upgrade, 'scalar reconfigure --all' is
     @@ Commit message
          However, this feature previously forced users to enable background
          maintenance. In some environments this is not preferred.
      
     -    Add a new --[no-]maintenance option to 'scalar reconfigure' that avoids
     -    running 'git maintenance start' on these enlistments.
     +    Add a new --maintenance=<mode> option to 'scalar reconfigure' that
     +    provides options for enabling (default), disabling, or leaving
     +    background maintenance config as-is.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/scalar.adoc ##
     @@ Documentation/scalar.adoc: scalar list
       scalar unregister [<enlistment>]
       scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
      -scalar reconfigure [ --all | <enlistment> ]
     -+scalar reconfigure [--[no-]maintenance] [ --all | <enlistment> ]
     ++scalar reconfigure [--maintenance=<mode>] [ --all | <enlistment> ]
       scalar diagnose [<enlistment>]
       scalar delete <enlistment>
       
     @@ Documentation/scalar.adoc: After a Scalar upgrade, or when the configuration of
      +	registered with Scalar by the `scalar.repo` config key. Use this
      +	option after each upgrade to get the latest features.
      +
     -+--[no-]maintenance::
     ++--maintenance=<mode>::
      +	By default, Scalar configures the enlistment to use Git's
     -+	background maintenance feature. Use the `--no-maintenance` to skip
     -+	this configuration and leave the repositories in whatever state is
     -+	currently configured.
     ++	background maintenance feature; this is the same as using the
     ++	`--maintenance=enable` value for this option. Use the
     ++	`--maintenance=disable` to remove each considered enlistment
     ++	from background maintenance. Use `--maitnenance=keep' to leave
     ++	the background maintenance configuration untouched for These
     ++	repositories.
       
       Diagnose
       ~~~~~~~~
      
       ## scalar.c ##
      @@ scalar.c: static int remove_deleted_enlistment(struct strbuf *path)
     - 
       static int cmd_reconfigure(int argc, const char **argv)
       {
     --	int all = 0;
     -+	int all = 0, maintenance = 1;
     + 	int all = 0;
     ++	const char *maintenance_str = NULL;
     ++	int maintenance = 1; /* Enable maintenance by default. */
     ++
       	struct option options[] = {
       		OPT_BOOL('a', "all", &all,
       			 N_("reconfigure all registered enlistments")),
     -+		OPT_BOOL(0, "maintenance", &maintenance,
     -+			 N_("specify if background maintenance should be enabled")),
     ++		OPT_STRING(0, "maintenance", &maintenance_str,
     ++			 N_("<mode>"),
     ++			 N_("signal how to adjust background maintenance")),
       		OPT_END(),
       	};
       	const char * const usage[] = {
      -		N_("scalar reconfigure [--all | <enlistment>]"),
     -+		N_("scalar reconfigure [--[no-]maintenance] [--all | <enlistment>]"),
     ++		N_("scalar reconfigure [--maintenance=<mode>] [--all | <enlistment>]"),
       		NULL
       	};
       	struct string_list scalar_repos = STRING_LIST_INIT_DUP;
     +@@ scalar.c: static int cmd_reconfigure(int argc, const char **argv)
     + 		usage_msg_opt(_("--all or <enlistment>, but not both"),
     + 			      usage, options);
     + 
     ++	if (maintenance_str) {
     ++		if (!strcmp(maintenance_str, "enable"))
     ++			maintenance = 1;
     ++		else if (!strcmp(maintenance_str, "disable"))
     ++			maintenance = 0;
     ++		else if (!strcmp(maintenance_str, "keep"))
     ++			maintenance = -1;
     ++		else
     ++			die(_("unknown mode for --maintenance option: %s"),
     ++			    maintenance_str);
     ++	}
     ++
     + 	git_config(get_scalar_repos, &scalar_repos);
     + 
     + 	for (size_t i = 0; i < scalar_repos.nr; i++) {
      @@ scalar.c: static int cmd_reconfigure(int argc, const char **argv)
       		the_repository = old_repo;
       		repo_clear(&r);
       
      -		if (toggle_maintenance(1) >= 0)
     -+		if (maintenance &&
     -+		    toggle_maintenance(1) >= 0)
     ++		if (maintenance >= 0 &&
     ++		    toggle_maintenance(maintenance) >= 0)
       			succeeded = 1;
       
       loop_end:
     @@ t/t9210-scalar.sh: test_expect_success 'scalar reconfigure' '
      +	test_subcommand git maintenance start <reconfigure &&
      +	test_subcommand ! git maintenance unregister --force <reconfigure &&
      +
     -+	GIT_TRACE2_EVENT="$(pwd)/reconfigure-maint" scalar reconfigure --no-maintenance -a &&
     -+	test_subcommand ! git maintenance start <reconfigure-maint &&
     -+	test_subcommand ! git maintenance unregister --force <reconfigure-maint
     ++	GIT_TRACE2_EVENT="$(pwd)/reconfigure-maint-disable" \
     ++		scalar reconfigure -a --maintenance=disable &&
     ++	test_subcommand ! git maintenance start <reconfigure-maint-disable &&
     ++	test_subcommand git maintenance unregister --force <reconfigure-maint-disable &&
     ++
     ++	GIT_TRACE2_EVENT="$(pwd)/reconfigure-maint-keep" \
     ++		scalar reconfigure --maintenance=keep -a &&
     ++	test_subcommand ! git maintenance start <reconfigure-maint-keep &&
     ++	test_subcommand ! git maintenance unregister --force <reconfigure-maint-keep
       '
       
       test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '

-- 
gitgitgadget
