Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54704C4321E
	for <git@archiver.kernel.org>; Sat, 26 Nov 2022 14:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiKZOSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 09:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKZOSH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 09:18:07 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7415C2034D
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 06:18:00 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so8224060wma.1
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 06:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZ2WSdF8kPc7W679ZAjf55vrWCbpS1EqBGyIqko0bW0=;
        b=JImuT8/2X96h2qMuNudfsFLZ7MwqqA8F6zcgKJ3XidmngTzIR6kBcMEMml7TAVui6g
         88Vmvnnbf/+H774t+vOhPC1iPS9Hv7agibVmyKMdIqAvvX5z2NOMQSJOyUWu8hwUE1u9
         mYdaGmkoqMWGRrMGAOw2OLwR5QyPSUUrM3VEiWr8BGU6U6GUBjJeSpqcC/MlnCo1ZUBV
         8QpWD4BeCG1R4P+me5Jk0l+RZZQeH2NZHGSpceEnazZXEJpQdJWdPuMvQri6T34Hw1GS
         WS33gMWZBha5YIv/piVttBHdcmqULhGkRR8N9yAUkNIG900HExRSNwl1Tv7MfYyh46PE
         X33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZ2WSdF8kPc7W679ZAjf55vrWCbpS1EqBGyIqko0bW0=;
        b=wq0CKmcrhcc/so1oZKOzkhI/nNlLo+BmWZ5L1oI1ZxA8GNgWLZQAUUhLh/Kubt5AIH
         JUeGn5oEhNFxlSKOKkFfb+VFGfZgkVQpyf2Je9QWAfAgN296ZGhdzQBTdXO/V7CZlUsK
         6NqSEHmVz8naiyChSYp+6xr53ZHK468VpQR8BcK0E/A+eYAcA1uOfdC6fL3fEpJTtw0Z
         8JE/nDb1Y4WjczEPAU7Ts2ap0bBeCxh69fjW95ZhNYpqfwZ+4eAVNbqsdDzhmOY8pQJK
         8PVt3TtBEf+fPwClFHD69rWE0d4dchjv1xek9RkLqtRaCoO8BZrtb2raMequySCECkE6
         WAxg==
X-Gm-Message-State: ANoB5plyxjBWC1vkztW7O1OjwmmLTnDZd7suMtFIKEjI+OIFClMb1Q7C
        gpqUhAakgwH64xe3UTW7KcDTtWpqGvU=
X-Google-Smtp-Source: AA0mqf5utaOzlLCL4EFe4j27vH9lG97alt/bm5GN9Fd3GPDXVfsJ+z+k9bnnVqaWr2EHNkTVHUz9ug==
X-Received: by 2002:a05:600c:5409:b0:3d0:5028:e963 with SMTP id he9-20020a05600c540900b003d05028e963mr2168779wmb.51.1669472278663;
        Sat, 26 Nov 2022 06:17:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x2-20020adfffc2000000b002416f0f1e96sm6049366wrs.43.2022.11.26.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 06:17:58 -0800 (PST)
Message-Id: <pull.1434.v3.git.1669472277.gitgitgadget@gmail.com>
In-Reply-To: <pull.1434.v2.git.1669395151.gitgitgadget@gmail.com>
References: <pull.1434.v2.git.1669395151.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Nov 2022 14:17:55 +0000
Subject: [PATCH v3 0/2] Improve consistency of git-var
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Allred <code@seanallred.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series makes a few distinct improvements to git-var to support
the change to git_editor() prompted [here][1] and ultimately support that
patch to introduce GIT_SEQUENCE_EDITOR as a handled logical variable.

Changes since v2:

 * Nix premature assignment of git_var and val, preferring to let the
   compiler tell us when they're being used before init.
 * Factor out sane_unset_all_editors for tests to reduce duplication
 * Use more specific test_* helper functions

Sean Allred (2):
  var: do not print usage() with a correct invocation
  var: allow GIT_EDITOR to return null

 Documentation/git-var.txt |  3 +-
 builtin/var.c             | 29 +++++++++---------
 t/t0007-git-var.sh        | 62 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 16 deletions(-)


base-commit: c000d916380bb59db69c78546928eadd076b9c7d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1434%2Fvermiculus%2Fsa%2Fvar-improvements-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1434/vermiculus/sa/var-improvements-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1434

Range-diff vs v2:

 1:  a7ff842a3e8 ! 1:  889fdf877a1 var: do not print usage() with a correct invocation
     @@ builtin/var.c: static int show_config(const char *var, const char *value, void *
       
       int cmd_var(int argc, const char **argv, const char *prefix)
       {
     -+	const struct git_var *git_var = NULL;
     - 	const char *val = NULL;
     +-	const char *val = NULL;
     ++	const struct git_var *git_var;
     ++	const char *val;
     ++
       	if (argc != 2)
       		usage(var_usage);
     + 
      @@ builtin/var.c: int cmd_var(int argc, const char **argv, const char *prefix)
       		return 0;
       	}
 2:  427cb7b55ac ! 2:  3d8bf3662fe var: allow GIT_EDITOR to return null
     @@ builtin/var.c: static const char var_usage[] = "git var (-l | <variable>)";
       static const char *pager(int flag)
      
       ## t/t0007-git-var.sh ##
     +@@ t/t0007-git-var.sh: test_description='basic sanity checks for git var'
     + TEST_PASSES_SANITIZE_LEAK=true
     + . ./test-lib.sh
     + 
     ++sane_unset_all_editors () {
     ++	sane_unset GIT_EDITOR &&
     ++	sane_unset VISUAL &&
     ++	sane_unset EDITOR
     ++}
     ++
     + test_expect_success 'get GIT_AUTHOR_IDENT' '
     + 	test_tick &&
     + 	echo "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" >expect &&
      @@ t/t0007-git-var.sh: test_expect_success 'get GIT_DEFAULT_BRANCH with configuration' '
       	)
       '
       
      +test_expect_success 'get GIT_EDITOR without configuration' '
      +	(
     -+		sane_unset GIT_EDITOR &&
     -+		sane_unset VISUAL &&
     -+		sane_unset EDITOR &&
     -+		>expect &&
     -+		! git var GIT_EDITOR >actual &&
     -+		test_cmp expect actual
     ++		sane_unset_all_editors &&
     ++		test_expect_code 1 git var GIT_EDITOR >out &&
     ++		test_must_be_empty out
      +	)
      +'
      +
      +test_expect_success 'get GIT_EDITOR with configuration' '
      +	test_config core.editor foo &&
      +	(
     -+		sane_unset GIT_EDITOR &&
     -+		sane_unset VISUAL &&
     -+		sane_unset EDITOR &&
     ++		sane_unset_all_editors &&
      +		echo foo >expect &&
      +		git var GIT_EDITOR >actual &&
      +		test_cmp expect actual
     @@ t/t0007-git-var.sh: test_expect_success 'get GIT_DEFAULT_BRANCH with configurati
      +
      +test_expect_success 'get GIT_EDITOR with environment variable GIT_EDITOR' '
      +	(
     -+		sane_unset GIT_EDITOR &&
     -+		sane_unset VISUAL &&
     -+		sane_unset EDITOR &&
     ++		sane_unset_all_editors &&
      +		echo bar >expect &&
      +		GIT_EDITOR=bar git var GIT_EDITOR >actual &&
      +		test_cmp expect actual
     @@ t/t0007-git-var.sh: test_expect_success 'get GIT_DEFAULT_BRANCH with configurati
      +
      +test_expect_success 'get GIT_EDITOR with environment variable EDITOR' '
      +	(
     -+		sane_unset GIT_EDITOR &&
     -+		sane_unset VISUAL &&
     -+		sane_unset EDITOR &&
     ++		sane_unset_all_editors &&
      +		echo bar >expect &&
      +		EDITOR=bar git var GIT_EDITOR >actual &&
      +		test_cmp expect actual
     @@ t/t0007-git-var.sh: test_expect_success 'get GIT_DEFAULT_BRANCH with configurati
      +test_expect_success 'get GIT_EDITOR with configuration and environment variable GIT_EDITOR' '
      +	test_config core.editor foo &&
      +	(
     -+		sane_unset GIT_EDITOR &&
     -+		sane_unset VISUAL &&
     -+		sane_unset EDITOR &&
     ++		sane_unset_all_editors &&
      +		echo bar >expect &&
      +		GIT_EDITOR=bar git var GIT_EDITOR >actual &&
      +		test_cmp expect actual
     @@ t/t0007-git-var.sh: test_expect_success 'get GIT_DEFAULT_BRANCH with configurati
      +test_expect_success 'get GIT_EDITOR with configuration and environment variable EDITOR' '
      +	test_config core.editor foo &&
      +	(
     -+		sane_unset GIT_EDITOR &&
     -+		sane_unset VISUAL &&
     -+		sane_unset EDITOR &&
     ++		sane_unset_all_editors &&
      +		echo foo >expect &&
      +		EDITOR=bar git var GIT_EDITOR >actual &&
      +		test_cmp expect actual

-- 
gitgitgadget
