Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B92E9EC6
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607855; cv=none; b=DYol7ARdsqGkkIbvjgwvSk7ua3mPvgAbQxr55563AwsDR4zVdSTuDC0xgjb9cOUydzEc5t7SmocxAZamH7vovokl+9H3KCZsUOmS8JSdE6u7i2vg26ZXGN/FRKRPcSPUDwmO2mzthZzfnmLsDY/5NJH4NeBC7pdodwh0bIk1XL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607855; c=relaxed/simple;
	bh=rJkDzU8ySM70l68LNVEZAca3aF6GAKIY3bU8TQ2YPy8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=II6UfyWPGDR3d5Wec0c165nKT3oSuK3D2z2byHOc0y5a+U1eR1nsSKIx79C+mv6HLwIoV7ZYDMN38/Pphh0SdsuB7l8xYCfFtdaxpjoHk6/1uXVg1yFF+e3hYz7CMJs9bwDIoZmFwuxuui3nEBeVt350jn7QXJ+xFt8b6glEMKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIQpAvqD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIQpAvqD"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2956d816c10so47156615ad.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 08:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764607851; x=1765212651; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVWqawbc8I7uCWEvpSL/vL6IDZ29Qu7KzEoqvgn2wu4=;
        b=DIQpAvqDpVfpr6FfZrD2NMHNiK6+Zu0KloJArkT5IVr1IhCv7JD8tY/RrqaljIhjIJ
         1A4jzm7GN1MxFqajcRwZrV+GS1NKlwkiDT+FJOjV+QH9UQcTl5gNvZdFLSJjhOgsrnI+
         QxwlWip/26+nbs2Pi5DfB6bjJK/EsKaiAjw5UZmu6ky/KgWChzRk507hgkimc6TA8K26
         B3UQI0HRNZv5amFqTk6GMghobIKs+i+yabbSxvV6Yq1rrX8L8LIE8dImgl61FqjbBh8/
         Z+mdQsX/tEyxl78CcMisc3k771BoSIf5XUPYFFliUpPerQB7LlEbjwMSRWMjX3nps8r5
         6zaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607851; x=1765212651;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVWqawbc8I7uCWEvpSL/vL6IDZ29Qu7KzEoqvgn2wu4=;
        b=MYH2Dlxor8D1aFD/A3Ky+yEdOCc0xGPtE1PraFi4a7YIpusOynn7P/v9X5ARsQfmD9
         wPq54lpwzOkcMTK6JlaQy2tVzXCc35z3DXvmYjvizR2esnQp6rjWdcp0Z0tJEwTj7sGU
         cFU7UbljuNdArr+Va0fRGMebh7LtT+X/3y+nzQhPas8661IpmzpqYmesqGVAfpOufOoC
         sTOCNO1RFf1Vwuh8Tm9SuUvICCNnvvU4Zu2S+MfkGvl0nJ1Jewy7rRGch9EsRMgpnx+R
         Fw/QlYZpBXUxqHO9CjL/2mhzcmjz1wGe82mbflxRZ0N2eCnW1WtM2zGCboBHYGI5zwi8
         pRNQ==
X-Gm-Message-State: AOJu0YyCwI/RnONUesn/vBS8jLp7vATUk++aQDOyNxnvdc0D/BWkR5fd
	m7ugorN6Cf1KVdWIQP7Rny7M1Wk1LWfLNfrqZKUV0f/IHL3OOxTmlT/oq09bSA==
X-Gm-Gg: ASbGncuCbwp++rTOS83rQvugX4kpsSAgtruW6w1D9fvj/i9ptTiC7PfCigSWDhopLzj
	MR6cWfCsY2ZK29mizmzjen+Ho59Mbd4NKWvsqwv1isJK4p2DtnkrnSOi4t63umGEBH1Qh/YlimO
	PLKwuKnH2SnuqZndxOWyGoFzAVI9t/4guEjnVFyGtnKHfxkHRFFjM/geuRWW2ST/1ldcaINF0eN
	duJpZZlVbTkkrke4xMtiuFkUGhCFJkYfpscHLnzDWotNJapoxJvGsPDAgcGNWyIYTyN6zUJkN8Z
	vCjIDHBN/jhFSpgqsoSHyVqIzucvTSoAwTFVM5HqAiGri6ssMwsrGlMjOX5CGFOVEh8mR6wp9l6
	yA2PfpWdCSOmj/B8YexNG4tpQ7oN5gZBZqM4BMcnuiadspV5aIy6fc7F7bNn4MtxXXlXXRKlvpH
	NXomTzTXNmOrXtaQ==
X-Google-Smtp-Source: AGHT+IFVjnI+uYY+8xpfDbTbQN2IcuNUd7DhsZD+8Voa0PCVvaUZxT80T/j9VVGA/ll+Uel/W2pWrQ==
X-Received: by 2002:a17:903:1967:b0:288:e46d:b32b with SMTP id d9443c01a7336-29b6beba2dfmr485536735ad.17.1764607850760;
        Mon, 01 Dec 2025 08:50:50 -0800 (PST)
Received: from [127.0.0.1] ([20.168.106.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40a5ffsm130081285ad.18.2025.12.01.08.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:50:50 -0800 (PST)
Message-Id: <639ff98c44c45bb570fdde5123127aa099c299f8.1764607847.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
	<pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 01 Dec 2025 16:50:43 +0000
Subject: [PATCH v2 1/5] scalar: annotate config file with "set by scalar"
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

A repo may have config options set by 'scalar clone' or 'scalar
register' and then updated by 'scalar reconfigure'. It can be helpful to
point out which of those options were set by the latest scalar
recommendations.

Add "# set by scalar" to the end of each config option to assist users
in identifying why these config options were set in their repo. Use a new
helper method to simplify the two callsites.

Co-authored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c          | 18 ++++++++++++++----
 t/t9210-scalar.sh |  3 +++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/scalar.c b/scalar.c
index f754311627..be3878948d 100644
--- a/scalar.c
+++ b/scalar.c
@@ -19,6 +19,7 @@
 #include "help.h"
 #include "setup.h"
 #include "trace2.h"
+#include "path.h"
 
 static void setup_enlistment_directory(int argc, const char **argv,
 				       const char * const *usagestr,
@@ -95,6 +96,16 @@ struct scalar_config {
 	int overwrite_on_reconfigure;
 };
 
+static int set_config_with_comment(const char *key, const char *value)
+{
+	char *file = repo_git_path(the_repository, "config");
+	int res = repo_config_set_multivar_in_file_gently(the_repository, file,
+							  key, value, NULL,
+							  " # set by scalar", 0);
+	free(file);
+	return res;
+}
+
 static int set_scalar_config(const struct scalar_config *config, int reconfigure)
 {
 	char *value = NULL;
@@ -103,7 +114,7 @@ static int set_scalar_config(const struct scalar_config *config, int reconfigure
 	if ((reconfigure && config->overwrite_on_reconfigure) ||
 	    repo_config_get_string(the_repository, config->key, &value)) {
 		trace2_data_string("scalar", the_repository, config->key, "created");
-		res = repo_config_set_gently(the_repository, config->key, config->value);
+		res = set_config_with_comment(config->key, config->value);
 	} else {
 		trace2_data_string("scalar", the_repository, config->key, "exists");
 		res = 0;
@@ -197,9 +208,8 @@ static int set_recommended_config(int reconfigure)
 	if (repo_config_get_string(the_repository, "log.excludeDecoration", &value)) {
 		trace2_data_string("scalar", the_repository,
 				   "log.excludeDecoration", "created");
-		if (repo_config_set_multivar_gently(the_repository, "log.excludeDecoration",
-						    "refs/prefetch/*",
-						    CONFIG_REGEX_NONE, 0))
+		if (set_config_with_comment("log.excludeDecoration",
+					    "refs/prefetch/*"))
 			return error(_("could not configure "
 				       "log.excludeDecoration"));
 	} else {
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index bd6f0c40d2..43c210a23d 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -210,6 +210,9 @@ test_expect_success 'scalar reconfigure' '
 	GIT_TRACE2_EVENT="$(pwd)/reconfigure" scalar reconfigure -a &&
 	test_path_is_file one/src/cron.txt &&
 	test true = "$(git -C one/src config core.preloadIndex)" &&
+	test_grep "preloadIndex = true # set by scalar" one/src/.git/config &&
+	test_grep "excludeDecoration = refs/prefetch/\* # set by scalar" one/src/.git/config &&
+
 	test_subcommand git maintenance start <reconfigure &&
 	test_subcommand ! git maintenance unregister --force <reconfigure &&
 
-- 
gitgitgadget

