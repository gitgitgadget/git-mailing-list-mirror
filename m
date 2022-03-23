Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C6FC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 19:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344158AbiCWTXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbiCWTXp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 15:23:45 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF3A888F9
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 12:22:15 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-dacc470e03so2725892fac.5
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 12:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U4fUoRVZ8ozjA7HupH5ZiLUvDR5Xtz74aFgRJ84Ml10=;
        b=RHFrq4vaeOaHvccLAaB75ufPwALZPH0TlsStnHyqKOaxLSPg7b9CkmG23dt+CPk8/5
         GFgdVaGShD0P6oqaUV2qZYP02R4Sh5/BwlrJcSq1o2QufDmDxRC6YdO3ODVSKuZGwwf7
         j0m6ss2qNGKDv3RJ44Gy8VcoEIckzjuUM+4iFsmkecnak8XiMWG90lsx5xuuVv8MwVB1
         725p+Ev8suGBgeabNrQtGINqMAG86iQjcsYCWud3+PejZL7ue7wEp32OOv0I3DJUtGSo
         UwdrIJu8xH+WA3xjsqqIwoCZg3EBu9NFa2G3En0suZDwUkYOSnLex4av6QlkmppA2cEF
         7Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U4fUoRVZ8ozjA7HupH5ZiLUvDR5Xtz74aFgRJ84Ml10=;
        b=QvuXfZuPk+aRIrWahbN2X8+7pNtvPdiX2zpfzokPw961ku9SIGliKLAPKB6Nwgqaro
         hKEuGW0eVTfrKFryK2Piab1blRUZrnyXAGqIJBr6U5w63ZUhpHm9/Ma3At7NyY5oU+9R
         /V3ZS7aYzc3baj6PBiQtS87zSF9+RTnvGTyS2CkY568kTlqqjJDT66UI9feLSkhfQra0
         OAYoO8Wu88GJczZvNjZZadf1bnoJhcOrYMXNZMV+cqMt9hkumxOvpF4rNziwp0J7nfgn
         SoxVc3S6VluY9Fekx0YD1uSsRixA6t3dM15oQycxsSG65+3HxBv9OTvWbUmfgv2SvzXv
         HEzg==
X-Gm-Message-State: AOAM5307StQCbY+xDiOGIbQICE1rwU+hFbZ7B9DJH1+BUBIQ8BWEPgmQ
        Hy2VseRpRVXT25UzIk1xcleq
X-Google-Smtp-Source: ABdhPJwWdo0Y9hsPEyrCO6+CF4xKIe/YskOOGR08/0UbjIASi1dOnf7uJBPrNne1mgkCwnuKJ/FigA==
X-Received: by 2002:a05:6870:6309:b0:da:b3f:2b77 with SMTP id s9-20020a056870630900b000da0b3f2b77mr5033860oao.278.1648063334659;
        Wed, 23 Mar 2022 12:22:14 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y3-20020a056870e50300b000d9be6436f1sm348940oag.29.2022.03.23.12.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 12:22:14 -0700 (PDT)
Message-ID: <471ca70d-0da1-8c4f-16bc-3019706931bd@github.com>
Date:   Wed, 23 Mar 2022 15:22:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     lessleydennington@gmail.com, gitster@pobox.com
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2022 2:03 PM, Josh Steadmon wrote:
> prepare_repo_settings() initializes a `struct repository` with various
> default config options and settings read from a repository-local config
> file. In 44c7e62 (2021-12-06, repo-settings:prepare_repo_settings only
> in git repos), prepare_repo_settings was changed to issue a BUG() if it
> is called by a process whose CWD is not a Git repository. This approach
> was suggested in [1].
> 
> This breaks fuzz-commit-graph, which attempts to parse arbitrary
> fuzzing-engine-provided bytes as a commit graph file.
> commit-graph.c:parse_commit_graph() calls prepare_repo_settings(), but
> since we run the fuzz tests without a valid repository, we are hitting
> the BUG() from 44c7e62 for every test case.
> 
> Fix this by refactoring prepare_repo_settings() such that it sets
> default options unconditionally; if its process is in a Git repository,
> it will also load settings from the local config. This eliminates the
> need for a BUG() when not in a repository.

I think you have the right idea and this can work.
 
> -	/* Booleans config or default, cascades to other settings */
> -	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
> -	repo_cfg_bool(r, "feature.experimental", &experimental, 0);
> +	if (r->gitdir) {
> +		/* Booleans config or default, cascades to other settings */
> +		repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
> +		repo_cfg_bool(r, "feature.experimental", &experimental, 0);

However, this giant if block is going to be a bit unwieldy,
especially as we add settings in the future.

Ignoring whitespace, this is your diff:

diff --git a/repo-settings.c b/repo-settings.c
index b4fbd16cdc..d154b37007 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -17,9 +17,6 @@ void prepare_repo_settings(struct repository *r)
 	char *strval;
 	int manyfiles;
 
-	if (!r->gitdir)
-		BUG("Cannot add settings for uninitialized repository");
-
 	if (r->settings.initialized++)
 		return;
 
@@ -28,6 +25,7 @@ void prepare_repo_settings(struct repository *r)
 	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
 	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
 
+	if (r->gitdir) {
 		/* Booleans config or default, cascades to other settings */
 		repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
 		repo_cfg_bool(r, "feature.experimental", &experimental, 0);
@@ -50,16 +48,6 @@ void prepare_repo_settings(struct repository *r)
 		repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
 		repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);

(Adding the if)

-	/*
-	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
-	 * either it *or* the config sets
-	 * r->settings.core_multi_pack_index if true. We don't take
-	 * the environment variable if it exists (even if false) over
-	 * any config, as in most other cases.
-	 */
-	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
-		r->settings.core_multi_pack_index = 1;
-
 		/*
 		 * Non-boolean config
 		 */
@@ -93,6 +81,17 @@ void prepare_repo_settings(struct repository *r)
 			else
 				die("unknown fetch negotiation algorithm '%s'", strval);
 		}
+	}
+
+	/*
+	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
+	 * either it *or* the config sets
+	 * r->settings.core_multi_pack_index if true. We don't take
+	 * the environment variable if it exists (even if false) over
+	 * any config, as in most other cases.
+	 */
+	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
+		r->settings.core_multi_pack_index = 1;
 
(Moving this to group with other no-dir settings.)

I think what you're really trying to do is

	if (r->gitdir)
		(Load settings that require a repo)

	(Load settings that work without a repo.)

I think that you'd be better off extracting the two types of config
into helper methods (prepare_gitdir_settings()/prepare_nodir_settings()?)
across two patches, then in a third removing the BUG and inserting the
if (r->gitdir) above.

Does that seem reasonable?

Thanks,
-Stolee
