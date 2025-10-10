Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8483E22A4FE
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760058858; cv=none; b=ahZVRk9+iMQwdUadnuKyI5WL91xUfEdRYRRsm5rpW4L6r+9c3weWDU6HDcJf5Elo37CaKRpRv7Ppvf7+JiDLpdmpfwr2o/kRZEsF13j9KYixpWFDWNt0BWgv1IRSu1z8BNlmghkzmhPMojIGnzi5ndZJyDbAk37fAOOFodvNbco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760058858; c=relaxed/simple;
	bh=hCIvZ1TokAjUyX3xEtOmGqDqu+4pqI6zQL4cw6amFTM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fP4E5CSIIyFrckG/oBDbXmZs3z4Th2F1NOzqUVKOfa1SMnQ5oEFLCYXBYilMi+U3Vo8pRIvqgudG7cKsGGlDbpZub170NamY/jIRPyf6q8T8608W8Sior4L2gFb+E+GtOrASxJbi441y9FShgQRB0Wg+pQhaC5AmW2t3uRmSMck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPVNzb43; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPVNzb43"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4e70609e042so3961771cf.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 18:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760058855; x=1760663655; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3cH1YGJYzMTUuf3mFOBxB5vdqQQ8woftlgvHsc3wZA=;
        b=MPVNzb437tf3i+64doPSaFbKxCxoYVO7HmwInxyzUNYPP1ceWY7SBqbgw8YTPZ9/yL
         tD7zCcK1rKaS+EfR4JMk3oniPA2If8fQQzlxa4L1ficLgXKLk3QhH+f31GikK+kBf8x9
         fjGpQ0uF3s+5NiIztZE/hgATbwLnG8F9XmJeADR4m3B7ey3VITM32gZhuFINONsEYORu
         QhNZtlCQIE/rRJbmPs1utApBWmpLNU1Oxsnv2rbcqgoqIEReLGxJD9BLF2a6tgEF+a1Y
         XykdcccZTSYXIOJXJCyladGRUVnRNMWkqs1ubGjLI/H8MVYeCkTczdXl2V2w8EkAoVyj
         qzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760058855; x=1760663655;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3cH1YGJYzMTUuf3mFOBxB5vdqQQ8woftlgvHsc3wZA=;
        b=NCo7iU9Zw6zmcR/O7k3LVVoUz/dTzxarMsFCWHW+Yix710y3wc5wZZjdsJNaaYq+Ux
         HrF6zNnyMbLCflaRps1KhGZojdQX/62RAQnqEkyyF15sbt9DWbSie2V5s16d5Na0q0lT
         mrFC73oVQW1Ckhepp7PfSLIWxETVHAKEDjQMJRdKiT1NDeEC6AA5VoNOAkqoy8ibsGOa
         V5oT7/G36WjS7tQ5vWVy0Z/gfjox9EP1WshDYDiCMPioOb/nJHx6BX2Ok708K/OdrK/z
         TFkEEMpM6PHmY1e+XS1gXyLXMsJ0gHrKxtO0Zul5rk8VK+e4Bu5h6B9TOyndXGc0+VGi
         6VEA==
X-Gm-Message-State: AOJu0YwCAcqL4Wq4q4PD8K+C9RF3kvHVUKFwhjmPxAQdzb6M5lyy3wuP
	LMCysItFhk/u/w4C1X63J+keNwfZHEdQsA/MqDEkfBNMgqWKsWi6cjUFjnIxgg==
X-Gm-Gg: ASbGncvzu+MqshOwwkjhYvDtFaev/xahfDilDoUVpLQGGARrhU6Fks6ZlCaVRyBWoK/
	p5U/m+W72qGqvVU5Kek1UV1C2hKSWzyf56ArPiIzCRpw/IqcLUbWgCLMDJhKJHQV1mKbA0v0c2w
	w8hx1m/6vD4wbAa6B0oVfYEvtXBLp/QP5KFPRUJeQ3XLH3YpENEHGXHmxRaY6cwGTXy0QZPA5ka
	bfbSCWqi6AltE9NvyaFg03vcNH8ok0HpGu1b8CnwlKyvTaYEKmHgi/XH1/j2g0GR209C8dm1br3
	o6yPJXo9rJ7LNyyHFuECsurONC2Hd0n8YTpurlNO0h3yfKHXbahoCRwY32zIUj/nO4IOVXZ+A3m
	VMyZmU1FmpzAomh4LgPsthVWruzeVDvzlgEGTma+ZGdkJWdg=
X-Google-Smtp-Source: AGHT+IE1dzXFKjn4cmxzMhWeqJdynCpfKPqaSVf6v2f68ljYZF/IfGazC7aiQOhitIQ5xgoVv8FUUA==
X-Received: by 2002:ac8:5e4d:0:b0:4e5:6c5e:430a with SMTP id d75a77b69052e-4e6ead671a1mr142174911cf.64.1760058855063;
        Thu, 09 Oct 2025 18:14:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.60.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e706d670e7sm8126201cf.23.2025.10.09.18.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 18:14:14 -0700 (PDT)
Message-Id: <6119cee0c6557e67f3eb4e2f9d488e8684a63c99.1760058849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
From: "Delilah Ashley Wu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Oct 2025 01:14:09 +0000
Subject: [PATCH/RFC 4/4] config: keep bailing on unreadable global files
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
Cc: Delilah Ashley Wu <delilahwu@microsoft.com>,
    Derrick Stolee <stolee@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Patrick Steinhardt <ps@pks.im>,
    Delilah Ashley Wu <delilahwu@linux.microsoft.com>,
    Delilah Ashley Wu <delilahwu@microsoft.com>

From: Delilah Ashley Wu <delilahwu@microsoft.com>

The expected behaviour for `git config list` is:
  A. Without `--global`, it should not bail on unreadable/non-existent
     global config files.

  B. With `--global`, it should bail when both `$HOME/.gitconfig` and
     `$XDG_CONFIG_HOME/git/config` are unreadable. It should not bail
     when one or more of them is readable.

The previous patch, config: read global scope via config_sequence,
introduced a regression in scenario B. When both global config files are
unreadable, running `git config list --global` would not fail. For
example, `GIT_CONFIG_GLOBAL=does-not-exist git config list --global`
exits with status code 0.

Assuming that `config_source->scope == CONFIG_SCOPE_GLOBAL` iff the
`--global` argument is specified, use this to determine whether to bail.
When reading only the global scope and both config files are unreadable,
then adjust the return code to be non-zero.

Note: When bailing, the exit code is not determined by sum of the return
codes of the underlying operations. Instead, the exit code is modified
via a single decrement. If this is undesirable, we can change it to sum
the return codes of the underlying operations instead.

Lastly, modify the tests to remove the known breakage/regression. The
tests for scenario B will now pass.

Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Delilah Ashley Wu <delilahwu@microsoft.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c          | 40 +++++++++++++++++++++++++++++++---------
 t/t1300-config.sh |  4 ++--
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index 4b9f3831b1..3057c16f59 100644
--- a/config.c
+++ b/config.c
@@ -1500,8 +1500,8 @@ int git_config_system(void)
 }
 
 static int do_git_config_sequence(const struct config_options *opts,
-				  const struct repository *repo,
-				  config_fn_t fn, void *data)
+				  const struct repository *repo, config_fn_t fn,
+				  void *data, enum config_scope scope)
 {
 	int ret = 0;
 	char *system_config = git_system_config();
@@ -1534,15 +1534,34 @@ static int do_git_config_sequence(const struct config_options *opts,
 							 NULL);
 
 	if (!opts->ignore_global) {
+		int global_config_success_count = 0;
+		int nonzero_ret_on_global_config_error = scope == CONFIG_SCOPE_GLOBAL;
+
 		git_global_config_paths(&user_config, &xdg_config);
 
-		if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
-			ret += git_config_from_file_with_options(fn, xdg_config, data,
-						CONFIG_SCOPE_GLOBAL, NULL);
+		if (xdg_config &&
+		    !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK)) {
+			ret += git_config_from_file_with_options(fn, xdg_config,
+								 data,
+								 CONFIG_SCOPE_GLOBAL,
+								 NULL);
+			if (!ret)
+				global_config_success_count++;
+		}
+
+		if (user_config &&
+		    !access_or_die(user_config, R_OK, ACCESS_EACCES_OK)) {
+			ret += git_config_from_file_with_options(fn, user_config,
+								 data,
+								 CONFIG_SCOPE_GLOBAL,
+								 NULL);
+			if (!ret)
+				global_config_success_count++;
+		}
 
-		if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
-			ret += git_config_from_file_with_options(fn, user_config, data,
-						CONFIG_SCOPE_GLOBAL, NULL);
+		if (nonzero_ret_on_global_config_error &&
+		    !global_config_success_count)
+			--ret;
 
 		free(xdg_config);
 		free(user_config);
@@ -1603,7 +1622,10 @@ int config_with_options(config_fn_t fn, void *data,
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 					       data, config_source->scope);
 	} else {
-		ret = do_git_config_sequence(opts, repo, fn, data);
+		ret = do_git_config_sequence(opts, repo, fn, data,
+					     config_source ?
+						     config_source->scope :
+						     CONFIG_SCOPE_UNKNOWN);
 	}
 
 	if (inc.remote_urls) {
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 42f256e122..0c3911183c 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2372,7 +2372,7 @@ test_expect_success 'list with nonexistent global config' '
 	git config ${mode_prefix}list --show-scope
 '
 
-test_expect_failure 'list --global with nonexistent global config' '
+test_expect_success 'list --global with nonexistent global config' '
 	rm -rf "$HOME"/.gitconfig "$HOME"/.config/git/config &&
 	test_must_fail git config ${mode_prefix}list --global --show-scope
 '
@@ -2483,7 +2483,7 @@ test_expect_success 'override global and system config' '
 	test_cmp expect output
 '
 
-test_expect_failure 'override global and system config with missing file' '
+test_expect_success 'override global and system config with missing file' '
 	test_must_fail env GIT_CONFIG_GLOBAL=does-not-exist GIT_CONFIG_SYSTEM=/dev/null git config ${mode_prefix}list --global &&
 	test_must_fail env GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_SYSTEM=does-not-exist git config ${mode_prefix}list --system &&
 	GIT_CONFIG_GLOBAL=does-not-exist GIT_CONFIG_SYSTEM=does-not-exist git version
-- 
gitgitgadget
