Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A141520F2
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542924; cv=none; b=Jd8VzzVZ5Y5IV4tut6NDjzpQUBNwEGvDOJz36Kr9OUpNndId9/YEauids+i35GD6hHcLodDexg4WRnfEEsIPyi05U4/W2ebopHWZCxQ0xt1fb3SqWW3gLW05W/QKFHgost6hipP91o9J6m3IhADnUrHiojP7ThT5LmxEEPGVhAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542924; c=relaxed/simple;
	bh=JfySAa7oPhIzTXuiMrOrTPmTw/513hbgovl31YYPjx0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=OqxeCNAyzgr+I95I54aN0G0R8zCfKYnv6jIAI0DZZDGtOTzLnlsNzheQHRY0bp8v1kdxbrd27xyJVmMgsdu0UV2Kdrxi/0gMzxsFZQdeHoUH1RtgjEHaqSTc3WWM8joY/vQW/Kys7ooR9l0YLFcBFXMOT+AoQdjGmmcvV5cY5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8xLU5SU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8xLU5SU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e88012233so16176925e9.0
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 17:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542920; x=1706147720; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlAsabP0IPjiG1PAr8lLSFonkWn/AIz1LWo6x35csqM=;
        b=G8xLU5SUn2hFrL6ATTqQE/GYlQkQgYVUUYK8PeDZoE3Dm6poG96CzKfWaeg3EV5bY8
         WC6nc8OHtZgGw78aXx4DBNuiHHaJpkd+Bf8vaLFrA8mVWYBiOQ8nMoy8uuUHrxgp4pxf
         04QfkWJ0FbN3z5tSJlesCK06cVpEsEW+Z1L25puSGLqSmq1aDX9YSC1mjJew4ZolICJ6
         irefqnkRmD3j4UwZMkf6MZFrqLIxoLKkR+XjQvTpZR32pzwJXM1slYUzyeZJtJb3GyiU
         I4QSSZazVIrt5Mrl38HG5ycIq6eGlxggF67FC5Z5hzVLR6Zmu6fVtqkOwy9V1dqbh2M0
         UL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542920; x=1706147720;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlAsabP0IPjiG1PAr8lLSFonkWn/AIz1LWo6x35csqM=;
        b=LVRzf1QJ1QkbTjvKHMBFrYJJIilOpttyDxxph0yD+mHwfzHT63RBhmp0W5BLlngkMO
         62CfLynTE2jQ9NDO/6TWlvMQI4JL5ZepO8q/aY2JmcBMf8TcHhTvgm2tcxDSPfPWWAvk
         4kLHyfcqRnOMkwW1V4728NUxUwpmn21LsXX6aqY948+hiaJc46soZ0LGa8n6UsaJnskn
         tzaeStHcb3gNL9EzNN5E7a9TBz6exXWV/xBbWpmh/ZIhGyF3MVEI0zZscqpQ6W9vrFl1
         Mmv+6UZdL05/zvYf2ii1BrFtbXhakZtgXXUW/f0MxjsMM1F1r8LHrLACe0fUSjFaAA6Q
         tTeg==
X-Gm-Message-State: AOJu0Yybss4KPD8cuybW13aNv3bCklqEzdjQyaPGy9NdH9sD0oIS9bVC
	nSj4Z1ArTncUHdUrTedgk9g/RKRhit4EtImwK80AbuJVwN0kemJvsjNrVrNP
X-Google-Smtp-Source: AGHT+IEwYG1PdGQt2r65x9zV8SUmTmw7ZV0ieyfK/0C68vTYAdOCn52gCw3K4oPv/RiKwYXS6L0q8A==
X-Received: by 2002:a05:600c:4656:b0:40e:87fe:79d8 with SMTP id n22-20020a05600c465600b0040e87fe79d8mr59929wmo.59.1705542919772;
        Wed, 17 Jan 2024 17:55:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b0040e6b4925b8sm17264419wmb.20.2024.01.17.17.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:55:19 -0800 (PST)
Message-ID: <pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>
In-Reply-To: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 01:55:14 +0000
Subject: [PATCH v2 0/4] Strengthen fsck checks for submodule URLs
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Victoria Dye <vdye@github.com>

While testing 'git fsck' checks on .gitmodules URLs, I noticed that some
invalid URLs were passing the checks. Digging into it a bit more, the issue
turned out to be that 'credential_from_url_gently()' parses certain URLs
(like "http://example.com:something/deeper/path") incorrectly, in a way that
appeared to return a valid result.

Fortunately, these URLs are rejected in fetches/clones/pushes anyway because
'url_normalize()' (called in 'validate_remote_url()') correctly identifies
them as invalid. So, to bring 'git fsck' in line with other (stronger)
validation done on remote URLs, this series replaces the
'credential_from_url_gently()' check with one that uses 'url_normalize()'.

 * Patch 1 moves 'check_submodule_url()' to a public location so that it can
   be used outside of 'fsck.c'.
 * Patch 2 removes the obsolete/never-used code in 'test-tool submodule
   check-name' handling names provided on the command line.
 * Patch 3 adds a 'check-url' mode to 'test-tool submodule', calling the
   now-public 'check_submodule_url()' method on a given URL, and adds new
   tests checking valid and invalid submodule URLs.
 * Patch 4 replaces the 'credential_from_url_gently()' check with
   'url_normalize()' followed by 'url_decode()' and an explicit check for
   newlines (to preserve the newline handling added in 07259e74ec1 (fsck:
   detect gitmodules URLs with embedded newlines, 2020-03-11)).


Changes since V1
================

 * Added 'TEST_TOOL_CHECK_URL_USAGE' to 'submodule_usage'.
 * Removed unused/unreachable code related to command line inputs in
   'test-tool submodule check-name' and 'test-tool submodule check-url'.
 * Split the new t7450 test case into two tests (the first contains URLs
   that are validated successfully, the second demonstrates a URL
   incorrectly marked valid) to clearly show which pattern is handled
   improperly. The tests are merged in the final patch once the validation
   is corrected.

Thanks!

 * Victoria

Victoria Dye (4):
  submodule-config.h: move check_submodule_url
  test-submodule: remove command line handling for check-name
  t7450: test submodule urls
  submodule-config.c: strengthen URL fsck check

 fsck.c                      | 133 ----------------------------------
 submodule-config.c          | 140 ++++++++++++++++++++++++++++++++++++
 submodule-config.h          |   3 +
 t/helper/test-submodule.c   |  52 +++++++++-----
 t/t7450-bad-git-dotfiles.sh |  26 +++++++
 5 files changed, 203 insertions(+), 151 deletions(-)


base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1635%2Fvdye%2Fvdye%2Fstrengthen-fsck-url-checks-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1635/vdye/vdye/strengthen-fsck-url-checks-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1635

Range-diff vs v1:

 1:  588de3022d7 = 1:  ce1de0406ef submodule-config.h: move check_submodule_url
 -:  ----------- > 2:  14e8834c38b test-submodule: remove command line handling for check-name
 2:  cf7848edffc ! 3:  b6843a58389 t7450: test submodule urls
     @@ Metadata
       ## Commit message ##
          t7450: test submodule urls
      
     -    Add a test to 't7450-bad-git-dotfiles.sh' to check the validity of different
     -    submodule URLs. To test this directly (without setting up test repositories
     -    & submodules), add a 'check-url' subcommand to 'test-tool submodule' that
     -    calls 'check_submodule_url' in the same way that 'check-name' calls
     -    'check_submodule_name'.
     +    Add tests to 't7450-bad-git-dotfiles.sh' to check the validity of different
     +    submodule URLs. To verify this directly (without setting up test
     +    repositories & submodules), add a 'check-url' subcommand to 'test-tool
     +    submodule' that calls 'check_submodule_url' in the same way that
     +    'check-name' calls 'check_submodule_name'.
      
     -    Mark the test with 'test_expect_failure' because, as it stands,
     -    'check_submodule_url' marks certain invalid URLs valid. Specifically, the
     -    invalid URL "http://example.com:test/foo.git" is incorrectly marked valid in
     -    the test.
     +    Add two tests to separately address cases where the URL check correctly
     +    filters out invalid URLs and cases where the check misses invalid URLs. Mark
     +    the latter ("url check misses invalid cases") with 'test_expect_failure' to
     +    indicate that this not the undesired behavior.
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     @@ t/helper/test-submodule.c: static const char *submodule_check_name_usage[] = {
       };
       
      +#define TEST_TOOL_CHECK_URL_USAGE \
     -+	"test-tool submodule check-url <url>"
     ++	"test-tool submodule check-url"
      +static const char *submodule_check_url_usage[] = {
      +	TEST_TOOL_CHECK_URL_USAGE,
      +	NULL
     @@ t/helper/test-submodule.c: static const char *submodule_check_name_usage[] = {
       #define TEST_TOOL_IS_ACTIVE_USAGE \
       	"test-tool submodule is-active <name>"
       static const char *submodule_is_active_usage[] = {
     -@@ t/helper/test-submodule.c: static const char *submodule_usage[] = {
     +@@ t/helper/test-submodule.c: static const char *submodule_resolve_relative_url_usage[] = {
     + 
     + static const char *submodule_usage[] = {
     + 	TEST_TOOL_CHECK_NAME_USAGE,
     ++	TEST_TOOL_CHECK_URL_USAGE,
     + 	TEST_TOOL_IS_ACTIVE_USAGE,
     + 	TEST_TOOL_RESOLVE_RELATIVE_URL_USAGE,
       	NULL
       };
       
     +-/* Filter stdin to print only valid names. */
     +-static int check_name(void)
      +typedef int (*check_fn_t)(const char *);
      +
     - /*
     -  * Exit non-zero if any of the submodule names given on the command line is
     -  * invalid. If no names are given, filter stdin to print only valid names
     -  * (which is primarily intended for testing).
     -  */
     --static int check_name(int argc, const char **argv)
     -+static int check_submodule(int argc, const char **argv, check_fn_t check_fn)
     ++/*
     ++ * Apply 'check_fn' to each line of stdin, printing values that pass the check
     ++ * to stdout.
     ++ */
     ++static int check_submodule(check_fn_t check_fn)
       {
     - 	if (argc > 1) {
     - 		while (*++argv) {
     --			if (check_submodule_name(*argv) < 0)
     -+			if (check_fn(*argv) < 0)
     - 				return 1;
     - 		}
     - 	} else {
     - 		struct strbuf buf = STRBUF_INIT;
     - 		while (strbuf_getline(&buf, stdin) != EOF) {
     --			if (!check_submodule_name(buf.buf))
     -+			if (!check_fn(buf.buf))
     - 				printf("%s\n", buf.buf);
     - 		}
     - 		strbuf_release(&buf);
     + 	struct strbuf buf = STRBUF_INIT;
     + 	while (strbuf_getline(&buf, stdin) != EOF) {
     +-		if (!check_submodule_name(buf.buf))
     ++		if (!check_fn(buf.buf))
     + 			printf("%s\n", buf.buf);
     + 	}
     + 	strbuf_release(&buf);
      @@ t/helper/test-submodule.c: static int cmd__submodule_check_name(int argc, const char **argv)
       	if (argc)
       		usage_with_options(submodule_check_name_usage, options);
       
     --	return check_name(argc, argv);
     -+	return check_submodule(argc, argv, check_submodule_name);
     +-	return check_name();
     ++	return check_submodule(check_submodule_name);
      +}
      +
      +static int cmd__submodule_check_url(int argc, const char **argv)
     @@ t/helper/test-submodule.c: static int cmd__submodule_check_name(int argc, const
      +	if (argc)
      +		usage_with_options(submodule_check_url_usage, options);
      +
     -+	return check_submodule(argc, argv, check_submodule_url);
     ++	return check_submodule(check_submodule_url);
       }
       
       static int cmd__submodule_is_active(int argc, const char **argv)
     @@ t/t7450-bad-git-dotfiles.sh: test_expect_success 'check names' '
       	test_cmp expect actual
       '
       
     -+test_expect_failure 'check urls' '
     ++test_expect_success 'check urls' '
      +	cat >expect <<-\EOF &&
      +	./bar/baz/foo.git
      +	https://example.com/foo.git
     @@ t/t7450-bad-git-dotfiles.sh: test_expect_success 'check names' '
      +	./%0ahost=example.com/foo.git
      +	https://one.example.com/evil?%0ahost=two.example.com
      +	https:///example.com/foo.git
     -+	http://example.com:test/foo.git
      +	https::example.com/foo.git
      +	http:::example.com/foo.git
      +	EOF
      +
      +	test_cmp expect actual
      +'
     ++
     ++# NEEDSWORK: the URL checked here is not valid (and will not work as a remote if
     ++# a user attempts to clone it), but the fsck check passes.
     ++test_expect_failure 'url check misses invalid cases' '
     ++	test-tool submodule check-url >actual <<-\EOF &&
     ++	http://example.com:test/foo.git
     ++	EOF
     ++
     ++	test_must_be_empty actual
     ++'
      +
       test_expect_success 'create innocent subrepo' '
       	git init innocent &&
 3:  893071530d3 ! 4:  b79b1a71780 submodule-config.c: strengthen URL fsck check
     @@ submodule-config.c: int check_submodule_url(const char *url)
       
      
       ## t/t7450-bad-git-dotfiles.sh ##
     -@@ t/t7450-bad-git-dotfiles.sh: test_expect_success 'check names' '
     +@@ t/t7450-bad-git-dotfiles.sh: test_expect_success 'check urls' '
     + 	./%0ahost=example.com/foo.git
     + 	https://one.example.com/evil?%0ahost=two.example.com
     + 	https:///example.com/foo.git
     ++	http://example.com:test/foo.git
     + 	https::example.com/foo.git
     + 	http:::example.com/foo.git
     + 	EOF
     +@@ t/t7450-bad-git-dotfiles.sh: test_expect_success 'check urls' '
       	test_cmp expect actual
       '
       
     --test_expect_failure 'check urls' '
     -+test_expect_success 'check urls' '
     - 	cat >expect <<-\EOF &&
     - 	./bar/baz/foo.git
     - 	https://example.com/foo.git
     +-# NEEDSWORK: the URL checked here is not valid (and will not work as a remote if
     +-# a user attempts to clone it), but the fsck check passes.
     +-test_expect_failure 'url check misses invalid cases' '
     +-	test-tool submodule check-url >actual <<-\EOF &&
     +-	http://example.com:test/foo.git
     +-	EOF
     +-
     +-	test_must_be_empty actual
     +-'
     +-
     + test_expect_success 'create innocent subrepo' '
     + 	git init innocent &&
     + 	git -C innocent commit --allow-empty -m foo

-- 
gitgitgadget
