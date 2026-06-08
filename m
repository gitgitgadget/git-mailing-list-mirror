Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960F3C1F29
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927034; cv=none; b=qpIFSM+6EzhO24oPdKq44xlFczneu9efeLCtYTU8Alths7AHBodFkLCa4roMx5arzxsJuk6l0csTZMTUi5n9laAbBYKihKdxM58TnzOT3ngv7VZ0jRMISpnrl6mxynPBCZVQK9GY2lU5gmobwplZgiDyVEF0Mj26tvNBz75R+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927034; c=relaxed/simple;
	bh=Kgjr/CAolK769GcIBal5xGTsXPtVkiJaBM4wV97N0pI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SKpLX14kvwffDxih96oFQ6P+/o/CIdugOA8dABPwCxFK6Vd05JqPhEaHG4ZhJqldXO2TBGvMb05+HcxKuZ4veaHhTgjDkI4fPpP+Q/DoOux6M9UuvWAgjT0qEmgGFWwvgBkzYjoKYlRr8EXpiONCIdSXKrWBMf0TTyIKYcM9NRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu21EVPF; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu21EVPF"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9156b74006aso312267385a.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 06:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780927031; x=1781531831; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YvpWV6IJquySdKSodlNUH/qiDTurwPuSoBI3JCCHIQ=;
        b=cu21EVPF8ZaNGcg/ptrKdZXR4s3eF79/ipD8YAmsdInB5mVb7RgU42YrMHit0dx1B5
         QRYukDI/mvFbLKKv4AU4Mrw9Qib8NjneQWK3OIolvl60DYVjSFwtcwlLtBRioQJ/gLok
         73FCGnImL4/LnOp/+ipom0QIfOLHMwH6X82yQQ+mcO/cRYEjd/EWZfLdxQeP3lPefxG/
         UFNo/AYuOXijBkEGdEYWttaVjJKSxlZV8r8FOPHtCzErFbE1Yrx799T4HUCvaygBT93G
         goq4swqBKPlcmc3gU05RV2YvJ2kMGVvX4W80F7pwPBDQBiRa+WaKPyVxM/QuqyrYDNwi
         d8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927031; x=1781531831;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6YvpWV6IJquySdKSodlNUH/qiDTurwPuSoBI3JCCHIQ=;
        b=W1gimKdmI627GD3ZkVyPxpxDaiYR5ajrphLfbq4Z5UWpkmyjtNhtowJp0CDQyljFZ8
         JJl/gAw+iACJY/Hu0YSvlm2k12hi1uUzsmPE5AMxBr7DQQXamg/NigJjUHSc5OqTeef1
         9mdQnDSuvDTd6MduaLMjdNYV080PtgmsfEhC2Zb5woQRRYhP12HB0d6zbHOE4tiF8Xbz
         ZEDDq/zU9bArw4q4M8Kp1Fxs0OqWTAESg0OU/TU5AYRnYpsPOGKowBVeafcjzQG0edjN
         vM6F8m5QppzBA3TyArtfAtKQnSFtpQ3QHGT/SZXgOd5FZV01ClCY9VrWZCVhRuNEwXdn
         RVNg==
X-Gm-Message-State: AOJu0YyvAx55irVfkS3NjmyCvA8J/0d3RrZ7WAGzjBCFRCetnfaD2pEH
	VzkZN38v04ZxHP+ZJK6C9FVXswx9spJE+YyMk0Tw7JnCCJwysbFopPElqvCPhg==
X-Gm-Gg: Acq92OEweenbls0LD2HOIk10tbQse6gbaw9WOTjLvsUxoBYeZS9/XYeXvVPiGfPcD7W
	2cTK+JXailGe69COmiBALFqO/yI3MtTbbr9WqR7DTlwPsuTzw705sKx2hDHCClwF/96U1nmvXCa
	p4ofhZyDqNreIM4CLyMwVKIATvUo2O+GHEItYUTlK65Bif/+otBmN75mVu+IEUzsogAOXW5NKpL
	zh140AkEDvkZxKTESQoropg3wn7Ywjln1b7l92JcctuRNWhGwlEXKPFxBCR/eJtMPJmgmxPOnn6
	Xop0y/WurlMtQSC5HKY4FKyegtg4wgsemylamV2yCeWwwoDVpcStO0q7Fh5YzJL8e3DZbxMtCTK
	meGpj89eSulO291pDRw99FvhFPmZtJGaQjL6h81+587jFG3z6n8FDBP4+IHHqH+IkuTsFsL9IOd
	MF3yJz1kde9XGDq640cdu7IwcP+iBjgIG7Ot5WPg==
X-Received: by 2002:a05:620a:448e:b0:912:c0b3:7d9b with SMTP id af79cd13be357-915a9cbe938mr2486143485a.24.1780927030695;
        Mon, 08 Jun 2026 06:57:10 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.210])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b9d5sm180382426d6.44.2026.06.08.06.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:57:10 -0700 (PDT)
Message-Id: <b48fe9f7abe794864ac4470c2620048c2e5e6b53.1780927027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
References: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Jun 2026 13:57:05 +0000
Subject: [PATCH 2/3] config: add GIT_CONFIG_INCLUDES
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The config keys 'include.path' and 'includeIf.*' allow users to specify
config stored in a location outside of the typical list of config files
(system, global, local, etc.). For example, users who accept the risk
can specify helpful aliases via a file checked into the repo by pointing
'include.path' to the position of that file in the working directory.
This is dangerous, but people do it.

What becomes tricky is that this modifies all Git behavior, including
operations that are intended to be limited in activity or sandboxed in
some way. These include directives can provide surprising changes to
behavior, especially when expecting a specific list of allowed file
accesses. This could lead to failed builds, for instance.

To allow for these user-desired features when they are running commands,
add a new GIT_CONFIG_INCLUDES environment variable that disables these
redirections of config when set to zero. This variable can be set by
automation, such as build tooling, to avoid these strange behaviors.
This could be considered a recommended option for tools executing Git
commands, the same as GIT_ADVICE=0.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-config.adoc |  5 +++++
 config.c                      |  7 ++++++-
 environment.h                 |  6 ++++++
 t/t1305-config-include.sh     | 31 +++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 044d776613..c9b5159501 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -502,6 +502,11 @@ GIT_CONFIG::
 	historical compatibility; there is generally no reason to use it
 	instead of the `--file` option.
 
+GIT_CONFIG_INCLUDES::
+	If GIT_CONFIG_INCLUDES is set to 0, then Git will not follow
+	`include.path` or `includeIf.*.path` directives when reading
+	configuration files.
+
 [[EXAMPLES]]
 EXAMPLES
 --------
diff --git a/config.c b/config.c
index a1b92fe083..85edd05672 100644
--- a/config.c
+++ b/config.c
@@ -1595,9 +1595,14 @@ int config_with_options(config_fn_t fn, void *data,
 			const struct config_options *opts)
 {
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
+	int respect_includes = opts->respect_includes;
 	int ret;
 
-	if (opts->respect_includes) {
+	if (respect_includes &&
+	    !git_env_bool(CONFIG_INCLUDES_ENVIRONMENT, 1))
+		respect_includes = 0;
+
+	if (respect_includes) {
 		inc.fn = fn;
 		inc.data = data;
 		inc.opts = opts;
diff --git a/environment.h b/environment.h
index 9eb97b3869..2c57ae2533 100644
--- a/environment.h
+++ b/environment.h
@@ -52,6 +52,12 @@
  */
 #define GIT_ADVICE_ENVIRONMENT "GIT_ADVICE"
 
+/*
+ * Environment variable used to prevent following include.path or includeIf.*
+ * config directives.
+ */
+#define CONFIG_INCLUDES_ENVIRONMENT "GIT_CONFIG_INCLUDES"
+
 /*
  * Environment variable used in handshaking the wire protocol.
  * Contains a colon ':' separated list of keys with optional values
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index f3892578e4..270e4b89ab 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -396,4 +396,35 @@ test_expect_success 'onbranch without repository but explicit nonexistent Git di
 	test_must_fail nongit git --git-dir=nonexistent config get foo.bar
 '
 
+test_expect_success 'GIT_CONFIG_INCLUDES=0 disables include.path and includeIf' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set include.path config.inc &&
+		git config set "includeIf.gitdir:*.path" config2.inc &&
+		git config set -f .git/config.inc foo.bar from-include &&
+		git config set -f .git/config2.inc foo.baz from-includeif &&
+		git config get foo.bar &&
+		git config get foo.baz &&
+		test_must_fail env GIT_CONFIG_INCLUDES=0 git config get foo.bar &&
+		test_must_fail env GIT_CONFIG_INCLUDES=0 git config get foo.baz &&
+		git config get --includes foo.bar &&
+		test_must_fail env GIT_CONFIG_INCLUDES=0 git config get --includes foo.bar
+	)
+'
+
+test_expect_success 'GIT_CONFIG_INCLUDES=0 blocks included alias override' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set alias.test false &&
+		git config set include.path config.inc &&
+		git config set -f .git/config.inc alias.test status &&
+		git test &&
+		test_must_fail env GIT_CONFIG_INCLUDES=0 git test
+	)
+'
+
 test_done
-- 
gitgitgadget

