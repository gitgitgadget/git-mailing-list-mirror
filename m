Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C23E958E
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040763; cv=none; b=Zdc+PY7+Eb9CbHkb0n+FXpwQQU8AKwD3iq51rxN1SODa5K3+GV5m5lX+NqVmI2ysxypVBY/BYen4a1Iw2dEcb8qXCu7A+cAmzk33vNC6uwCG4rO8sZ0HmYcR/b4THP8W5dh9UpSdu8pdPHoLh441r0LxzFUQjjJbIwp2tu8VfN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040763; c=relaxed/simple;
	bh=VVGXldeZDtai437rYiAdc3gzzFIBU3IB0+a0NMvCbc8=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=F7mGK3Fc+xeNyMNkeW1wAoR/Aea9Fuu+530DJxINH/CyZDkzQ1kz9tNhMN2QNLk9TyBkKaRUayGk1TCrWXhzoP5mGFX1lyPqG2SuvAx/mCIZe4poQlAfI8lc28mpO5au4blIT9UPCzZ4OqHCen6chP9hpvhBx9IVszmVZhkyT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM+fLRg/; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM+fLRg/"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-896f9397ecdso76276356d6.3
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772040760; x=1772645560; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ueqmV8kEJp5dWDyp6xUKsQc2jtcVvu4LZDaQR1J0k1I=;
        b=UM+fLRg/Cp+mwGhi0dlSp/lcZ9wrG2IB79YADEf2TYdg0Oq73+An1qQqOLul82lrmE
         YIiunhGV9S09Rnw1+MBDLS/CTgw89MNBdwitXGIA95K7kXJOny9rVAR2HQW41wn62k3p
         DTGDQpYqXnsDCopkRv/IuDNsvUjgl9Dy79k5NbjBCgV+6pNTpw6ybn2EbHK1eF+GUE4k
         4YEk4m/JriZUU21t0y/bvWmOnG7tGd9MPQWymCp/C9MEVJeGAMfNrL7TQyiYYp5oxyJg
         NMk5yMdGV/Gs4Vfvt0IoGLVSEb/vmkuXR5VhB35u7PWUJwQ7/dTl+YSWS/4V80VXEKDv
         8jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772040760; x=1772645560;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueqmV8kEJp5dWDyp6xUKsQc2jtcVvu4LZDaQR1J0k1I=;
        b=m1EHevALxpILb8SswYrZ/dd7OzIShJKzmRVXMOGmLWkkugobHPi8DHoLCpIc5Qx1G2
         vZfvyav7efRn0S6kkF6DtoYTwlbhCq/coo3kfsGMWQjpqVpEtfQeIpWL/9nEPfZsgPmS
         w7RO1mWG2HNKa8RaJCbQKKCWMoAZFAb49yVS+xKEhDLSgSPsyKkbAc2xKYLUsdg6SYyW
         AUt5l1CSziJMrAd5PX9eIg6WwfhHuGuuTU9A54zOIuM7t1L8gDhjMhU0Wmdw7aWrdTS+
         hE4mVBDo68xhdnYFYp88ohUXkEa93VYh8Up8CHS3nQwzxJ7+F6/tZd7zUrWkyYsMSSsm
         wBlQ==
X-Gm-Message-State: AOJu0Yzaa7HizdUP3ZcB6GMD36Bx8+OQI4v9zt158MJuqhdFQAp+BYhA
	/4vjRDUr/68oPmQ/ky4NoJZxsmIXA99IF406CQQlVPu6RjR7LH+vInKOtzfGJNf8
X-Gm-Gg: ATEYQzzzjc3phihvHaJUTxzPfODUBZGL5sYhgNEuakAU8MiyEbO/uIF6x12T+NO81TK
	bIIIvJnhtOWPjI0B3XgRPLVMi3NeJGyZG4jKcJX7MeKRQ88ySLlD2gCbP+gs70pKX/1uPD9c/D6
	YAgiRK0P0foBEohz3OZHK9Qg8bZIDAmrztpMfZbdiWBajhnDet0dXIvGkut9vwQVeW8GBq6cQxl
	aoPCDHeRCpIMNcYjlUXZKRpn3OxjvExoBkYvAUccqmYzkKn8irjKE6zRhOuNJHhgBGFQhD5pWVm
	K7FQNo9evY9i3wI/RPVwypnYJZhI480rtyO/6E9d51omqWRJET2LzZuXIn4Q92ltSP7LSpbYGRm
	A3E/lqxqjtZRnIZIXrGs7HhdDXOsO8KbjzyNlepeTWSNfs2UUS5xXxDGg0xD5cm+JTchKbBtO/B
	owM5vabw1GSnp97cXAIpxsIKx8
X-Received: by 2002:a05:6214:d65:b0:880:3ce2:65ad with SMTP id 6a1803df08f44-89979d362b3mr262525536d6.41.1772040760027;
        Wed, 25 Feb 2026 09:32:40 -0800 (PST)
Received: from [127.0.0.1] ([52.237.143.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e762966sm126351366d6.47.2026.02.25.09.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 09:32:39 -0800 (PST)
Message-Id: <pull.2201.git.git.1772040758787.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?R=C3=A9my_L=C3=A9one?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 17:32:38 +0000
Subject: [PATCH] gc: add git maintenance list command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?R=C3=A9my_L=C3=A9one?= <rleone@scaleway.com>,
    =?UTF-8?q?R=C3=A9my=20L=C3=A9one?= <rleone@scaleway.com>

From: =?UTF-8?q?R=C3=A9my=20L=C3=A9one?= <rleone@scaleway.com>

List all repositories registered for background maintenance.

This displays the paths of all repositories that are configured in the
maintenance.repo config variable. By default, it reads from the global
config, but you can specify a different config file with the
--config-file option.

Signed-off-by: Rémy Léone <rleone@scaleway.com>
---
    gc: add git maintenance list command
    
    List all repositories registered for background maintenance. This
    displays the paths of all repositories that are configured in the
    maintenance.repo config variable. By default, it reads from the global
    config, but you can specify a different config file with the
    --config-file option.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2201%2Fremyleone%2Fmaintenance_list-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2201/remyleone/maintenance_list-v1
Pull-Request: https://github.com/git/git/pull/2201

 Documentation/git-maintenance.adoc |  9 ++++-
 builtin/gc.c                       | 59 ++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh             | 33 +++++++++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
index bda616f14c..17cb52ea2d 100644
--- a/Documentation/git-maintenance.adoc
+++ b/Documentation/git-maintenance.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git maintenance' run [<options>]
 'git maintenance' start [--scheduler=<scheduler>]
-'git maintenance' (stop|register|unregister) [<options>]
+'git maintenance' (stop|register|unregister|list) [<options>]
 'git maintenance' is-needed [<options>]
 
 
@@ -85,6 +85,13 @@ The `unregister` subcommand will report an error if the current repository
 is not already registered. Use the `--force` option to return success even
 when the current repository is not registered.
 
+list::
+	List all repositories registered for background maintenance. This
+	displays the paths of all repositories that are configured in the
+	`maintenance.repo` config variable. By default, it reads from the
+	global config, but you can specify a different config file with
+	the `--config-file` option.
+
 is-needed::
     Check whether maintenance needs to be run without actually running it.
     Exits with a 0 status code if maintenance needs to be run, 1 otherwise.
diff --git a/builtin/gc.c b/builtin/gc.c
index 4390eee6ec..9b15e236b4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2239,6 +2239,64 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 	return 0;
 }
 
+static const char * const builtin_maintenance_list_usage[] = {
+	"git maintenance list [--config-file <path>]",
+	NULL
+};
+
+static int maintenance_list(int argc, const char **argv, const char *prefix,
+		    struct repository *repo UNUSED)
+{
+	char *config_file = NULL;
+	struct option options[] = {
+		OPT_STRING(0, "config-file", &config_file, N_("file"), N_("use given config file")),
+		OPT_END(),
+	};
+	const char *key = "maintenance.repo";
+	const struct string_list *list;
+	struct config_set cs = { { 0 } };
+	char *global_config_file = NULL;
+
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_maintenance_list_usage, 0);
+	if (argc)
+		usage_with_options(builtin_maintenance_list_usage,
+				   options);
+
+	if (config_file) {
+		git_configset_init(&cs);
+		git_configset_add_file(&cs, config_file);
+		if (git_configset_get_string_multi(&cs, key, &list)) {
+			/* No repositories registered in custom config */
+			git_configset_clear(&cs);
+			return 0;
+		}
+	} else {
+		global_config_file = git_global_config();
+		if (!global_config_file)
+			die(_("$HOME not set"));
+		git_configset_init(&cs);
+		git_configset_add_file(&cs, global_config_file);
+		if (git_configset_get_string_multi(&cs, key, &list)) {
+			/* No repositories registered in global config */
+			free(global_config_file);
+			git_configset_clear(&cs);
+			return 0;
+		}
+	}
+
+	{
+		struct string_list_item *item;
+		for_each_string_list_item(item, list) {
+			printf("%s\n", item->string);
+		}
+	}
+
+	free(global_config_file);
+	git_configset_clear(&cs);
+	return 0;
+}
+
 static const char *get_frequency(enum schedule_priority schedule)
 {
 	switch (schedule) {
@@ -3535,6 +3593,7 @@ int cmd_maintenance(int argc,
 		OPT_SUBCOMMAND("stop", &fn, maintenance_stop),
 		OPT_SUBCOMMAND("register", &fn, maintenance_register),
 		OPT_SUBCOMMAND("unregister", &fn, maintenance_unregister),
+		OPT_SUBCOMMAND("list", &fn, maintenance_list),
 		OPT_SUBCOMMAND("is-needed", &fn, maintenance_is_needed),
 		OPT_END(),
 	};
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 7cc0ce57f8..9dc16e154e 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -1482,4 +1482,37 @@ test_expect_success 'maintenance aborts with existing lock file' '
 	test_grep "Another scheduled git-maintenance(1) process seems to be running" err
 '
 
+test_expect_success 'maintenance list shows registered repositories' '
+	test_when_finished "rm -rf repo1 repo2" &&
+	test_when_finished git config --global --unset-all maintenance.repo &&
+	git init repo1 &&
+	git init repo2 &&
+	(
+		cd repo1 &&
+		git maintenance register &&
+		cd ../repo2 &&
+		git maintenance register
+	) &&
+	git config --global --get-all maintenance.repo >expect &&
+	git maintenance list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'maintenance list with --config-file' '
+	CUSTOM_CONFIG="./custom-maintenance-config" &&
+	test_when_finished "rm -rf repo3 repo4" &&
+	test_when_finished rm -f "$CUSTOM_CONFIG" &&
+	git init repo3 &&
+	git init repo4 &&
+	(
+		cd repo3 &&
+		git maintenance register --config-file "../$CUSTOM_CONFIG" &&
+		cd ../repo4 &&
+		git maintenance register --config-file "../$CUSTOM_CONFIG"
+	) &&
+	git config --file="$CUSTOM_CONFIG" --get-all maintenance.repo >expect &&
+	git maintenance list --config-file "$CUSTOM_CONFIG" >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 852829b3dd2fe4e7c7fc4d8badde644cf1b66c74
-- 
gitgitgadget
