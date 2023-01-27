Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F43C38142
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 19:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjA0T2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 14:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjA0T2e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 14:28:34 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4047D80151
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 11:28:30 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z31so3982663pfw.4
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 11:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qD1SDMGtBPGlICNDXirp/zrhSEhRADhDsignnFNMJFE=;
        b=J1Y8MvhgDsWRFjhjexGEX5ShrRhZsEfmjXz8tGEexoze0Yljm5oRdchu47L50Itten
         nPx1PN9vaAMyp9aNZgX8wwx6VnRRPHRiQJc32o8MF5aeUaLpOtvkmT1WPshZ+sZ5hA2t
         zo35h+tJCFkrLCb60u3ImWGVzZP6JBco8H82CT48cvzul8E8Q3TSHWUuVcsw15WxhiNh
         4D8iqkFu7LDWif8U9bo8yO6ab9K7ZMwsVt2ofH/mWSspjwJBEz7vKJLRq1rdYcjlcrbn
         PpcgNj2BnNegwAS1a9KN1s5Iqdyap8ussPjBl5+yoOpLJGH39p7FdGCSJYG11cM/RsMg
         hhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qD1SDMGtBPGlICNDXirp/zrhSEhRADhDsignnFNMJFE=;
        b=CQxGSoYSpgVT+RxmGDnCzZa6osG5FbX0qJFcl/l28yMBsssKp+2c9IDccIK1N34/nc
         ZdjvSPzAI6iLG+eH071CfCu0EMIC0PmvbY14QU/7FLkgR2ZJjw084/kGmvJ5/72BkEGX
         pXbyBF2g72nYF2KYqvYrVxDYW8usD9FL9Z2zwtw2TO/O3+nwPSgDdVfIQx4hIxT2K7+f
         sIK7Ssk73M63aljdL3bE7BKA0F5kaScTLCSfYwpq+ldJjp1VeaDpJSUhqPjEf9fyWZ3/
         rAfXU5V/UWfYSrtYYJzEM5aMlB2ojkjitNK+Eqa6N4q4aEdFw51g3o6i8QnIMAAnmx9s
         3e+g==
X-Gm-Message-State: AO0yUKXosiJid/XBFnb2stGE9NH9+61B9xQ5uv0UDy/cXUl1oObe5UzV
        P9YCKLNNsa835uhBLgjYA9rS
X-Google-Smtp-Source: AK7set+fDzjdugiMUFwB51IME7Kv8KEPA+cCEtWQGLxaiiSjlEBpmAcgfsb8fhMWeMLrbWjrXPsTjA==
X-Received: by 2002:aa7:904f:0:b0:590:6a57:9901 with SMTP id n15-20020aa7904f000000b005906a579901mr6910813pfo.18.1674847709225;
        Fri, 27 Jan 2023 11:28:29 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id h19-20020a056a00219300b0058e17922ad0sm2946607pfi.185.2023.01.27.11.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 11:28:28 -0800 (PST)
Message-ID: <d8624caa-3c16-6b4d-03be-27d5531c6582@github.com>
Date:   Fri, 27 Jan 2023 11:28:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 00/10] Bundle URIs V: creationToken heuristic for
 incremental fetches
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> Updates in v2
> =============

In patches 2-9, I only had a few minor nits I commented on in the respective
patches; everything else either addressed something directly noted in the
last set of reviews or otherwise was sufficiently explained by
comments/commit messages. 

As for patch 1, I think the approach to relaxing the unbundling checks you
settled on in [1] after discussing with Junio makes sense.

[1] https://lore.kernel.org/git/ecc6b167-f5c4-48ce-3973-461d1659ed40@github.com/

> 
> Thanks,
> 
>  * Stolee
> 
> Derrick Stolee (10):
>   bundle: optionally skip reachability walk
>   t5558: add tests for creationToken heuristic
>   bundle-uri: parse bundle.heuristic=creationToken
>   bundle-uri: parse bundle.<id>.creationToken values
>   bundle-uri: download in creationToken order
>   clone: set fetch.bundleURI if appropriate
>   bundle-uri: drop bundle.flag from design doc
>   fetch: fetch from an external bundle URI
>   bundle-uri: store fetch.bundleCreationToken
>   bundle-uri: test missing bundles with heuristic
> 
>  Documentation/config/bundle.txt        |   7 +
>  Documentation/config/fetch.txt         |  24 +
>  Documentation/technical/bundle-uri.txt |   8 +-
>  builtin/clone.c                        |   6 +-
>  builtin/fetch.c                        |   7 +
>  bundle-uri.c                           | 257 +++++++++-
>  bundle-uri.h                           |  28 +-
>  bundle.c                               |   3 +-
>  bundle.h                               |   1 +
>  t/t5558-clone-bundle-uri.sh            | 672 ++++++++++++++++++++++++-
>  t/t5601-clone.sh                       |  46 ++
>  t/t5750-bundle-uri-parse.sh            |  37 ++
>  t/test-lib-functions.sh                |   8 +
>  13 files changed, 1091 insertions(+), 13 deletions(-)
> 
> 
> base-commit: 4dbebc36b0893f5094668ddea077d0e235560b16
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1454%2Fderrickstolee%2Fbundle-redo%2FcreationToken-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1454/derrickstolee/bundle-redo/creationToken-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1454
> 
> Range-diff vs v1:
> 
>   -:  ----------- >  1:  b3828725bc8 bundle: optionally skip reachability walk
>   1:  39eed914878 !  2:  427aff4d5e5 t5558: add tests for creationToken heuristic
>      @@ Commit message
>           meantime, create tests that add creation tokens to the bundle list. For
>           now, the Git client correctly ignores these unknown keys.
>       
>      +    Create a new test helper function, test_remote_https_urls, which filters
>      +    GIT_TRACE2_EVENT output to extract a list of URLs passed to
>      +    git-remote-https child processes. This can be used to verify the order
>      +    of these requests as we implement the creationToken heuristic. For now,
>      +    we need to sort the actual output since the current client does not have
>      +    a well-defined order that it applies to the bundles.
>      +
>           Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>       
>        ## t/t5558-clone-bundle-uri.sh ##
>       @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone HTTP bundle' '
>      - 	test_config -C clone-http log.excludedecoration refs/bundle/
>        '
>        
>      -+# usage: test_bundle_downloaded <bundle-name> <trace-file>
>      -+test_bundle_downloaded () {
>      -+	cat >pattern <<-EOF &&
>      -+	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/$1"\]
>      -+	EOF
>      -+	grep -f pattern "$2"
>      -+}
>      -+
>        test_expect_success 'clone bundle list (HTTP, no heuristic)' '
>       +	test_when_finished rm -f trace*.txt &&
>       +
>      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (HTTP, no he
>       -	git -C clone-list-http cat-file --batch-check <oids
>       +	git -C clone-list-http cat-file --batch-check <oids &&
>       +
>      -+	for b in 1 2 3 4
>      -+	do
>      -+		test_bundle_downloaded bundle-$b.bundle trace-clone.txt ||
>      -+			return 1
>      -+	done
>      ++	cat >expect <<-EOF &&
>      ++	$HTTPD_URL/bundle-1.bundle
>      ++	$HTTPD_URL/bundle-2.bundle
>      ++	$HTTPD_URL/bundle-3.bundle
>      ++	$HTTPD_URL/bundle-4.bundle
>      ++	$HTTPD_URL/bundle-list
>      ++	EOF
>      ++
>      ++	# Sort the list, since the order is not well-defined
>      ++	# without a heuristic.
>      ++	test_remote_https_urls <trace-clone.txt | sort >actual &&
>      ++	test_cmp expect actual
>        '
>        
>        test_expect_success 'clone bundle list (HTTP, any mode)' '
>      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (HTTP, any m
>        '
>        
>       +test_expect_success 'clone bundle list (http, creationToken)' '
>      ++	test_when_finished rm -f trace*.txt &&
>      ++
>       +	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
>       +	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
>       +	[bundle]
>      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (HTTP, any m
>       +		creationToken = 4
>       +	EOF
>       +
>      -+	git clone --bundle-uri="$HTTPD_URL/bundle-list" . clone-list-http-2 &&
>      ++	GIT_TRACE2_EVENT="$(pwd)/trace-clone.txt" git \
>      ++		clone --bundle-uri="$HTTPD_URL/bundle-list" \
>      ++		"$HTTPD_URL/smart/fetch.git" clone-list-http-2 &&
>       +
>       +	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
>      -+	git -C clone-list-http-2 cat-file --batch-check <oids
>      ++	git -C clone-list-http-2 cat-file --batch-check <oids &&
>      ++
>      ++	cat >expect <<-EOF &&
>      ++	$HTTPD_URL/bundle-1.bundle
>      ++	$HTTPD_URL/bundle-2.bundle
>      ++	$HTTPD_URL/bundle-3.bundle
>      ++	$HTTPD_URL/bundle-4.bundle
>      ++	$HTTPD_URL/bundle-list
>      ++	EOF
>      ++
>      ++	# Since the creationToken heuristic is not yet understood by the
>      ++	# client, the order cannot be verified at this moment. Sort the
>      ++	# list for consistent results.
>      ++	test_remote_https_urls <trace-clone.txt | sort >actual &&
>      ++	test_cmp expect actual
>       +'
>       +
>        # Do not add tests here unless they use the HTTP server, as they will
>        # not run unless the HTTP dependencies exist.
>        
>      +
>      + ## t/test-lib-functions.sh ##
>      +@@ t/test-lib-functions.sh: test_region () {
>      + 	return 0
>      + }
>      + 
>      ++# Given a GIT_TRACE2_EVENT log over stdin, writes to stdout a list of URLs
>      ++# sent to git-remote-https child processes.
>      ++test_remote_https_urls() {
>      ++	grep -e '"event":"child_start".*"argv":\["git-remote-https",".*"\]' |
>      ++		sed -e 's/{"event":"child_start".*"argv":\["git-remote-https","//g' \
>      ++		    -e 's/"\]}//g'
>      ++}
>      ++
>      + # Print the destination of symlink(s) provided as arguments. Basically
>      + # the same as the readlink command, but it's not available everywhere.
>      + test_readlink () {
>   2:  9007249b948 !  3:  f6f8197c9cc bundle-uri: parse bundle.heuristic=creationToken
>      @@ Commit message
>           bundle-uri' to print the heuristic value and verify that the parsing
>           works correctly.
>       
>      +    As an extra precaution, create the internal 'heuristics' array to be a
>      +    list of (enum, string) pairs so we can iterate through the array entries
>      +    carefully, regardless of the enum values.
>      +
>           Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>       
>        ## Documentation/config/bundle.txt ##
>      @@ bundle-uri.c
>        #include "config.h"
>        #include "remote.h"
>        
>      -+static const char *heuristics[] = {
>      -+	[BUNDLE_HEURISTIC_NONE] = "",
>      -+	[BUNDLE_HEURISTIC_CREATIONTOKEN] = "creationToken",
>      ++static struct {
>      ++	enum bundle_list_heuristic heuristic;
>      ++	const char *name;
>      ++} heuristics[BUNDLE_HEURISTIC__COUNT] = {
>      ++	{ BUNDLE_HEURISTIC_NONE, ""},
>      ++	{ BUNDLE_HEURISTIC_CREATIONTOKEN, "creationToken" },
>       +};
>       +
>        static int compare_bundles(const void *hashmap_cmp_fn_data,
>      @@ bundle-uri.c: void print_bundle_list(FILE *fp, struct bundle_list *list)
>        	fprintf(fp, "\tversion = %d\n", list->version);
>        	fprintf(fp, "\tmode = %s\n", mode);
>        
>      -+	if (list->heuristic)
>      -+		printf("\theuristic = %s\n", heuristics[list->heuristic]);
>      ++	if (list->heuristic) {
>      ++		int i;
>      ++		for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
>      ++			if (heuristics[i].heuristic == list->heuristic) {
>      ++				printf("\theuristic = %s\n",
>      ++				       heuristics[list->heuristic].name);
>      ++				break;
>      ++			}
>      ++		}
>      ++	}
>       +
>        	for_all_bundles_in_list(list, summarize_bundle, fp);
>        }
>      @@ bundle-uri.c: static int bundle_list_update(const char *key, const char *value,
>       +		if (!strcmp(subkey, "heuristic")) {
>       +			int i;
>       +			for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
>      -+				if (!strcmp(value, heuristics[i])) {
>      -+					list->heuristic = i;
>      ++				if (heuristics[i].heuristic &&
>      ++				    heuristics[i].name &&
>      ++				    !strcmp(value, heuristics[i].name)) {
>      ++					list->heuristic = heuristics[i].heuristic;
>       +					return 0;
>       +				}
>       +			}
>      @@ bundle-uri.h: enum bundle_list_mode {
>       +	BUNDLE_HEURISTIC_CREATIONTOKEN,
>       +
>       +	/* Must be last. */
>      -+	BUNDLE_HEURISTIC__COUNT,
>      ++	BUNDLE_HEURISTIC__COUNT
>       +};
>       +
>        /**
>   3:  a1808f0b10c =  4:  12efa228d04 bundle-uri: parse bundle.<id>.creationToken values
>   4:  57c0174d375 !  5:  7cfaa3c518c bundle-uri: download in creationToken order
>      @@ Commit message
>           strategy implemented here provides that short-circuit where the client
>           downloads a minimal set of bundles.
>       
>      +    However, we are not satisfied by the naive approach of downloading
>      +    bundles until one successfully unbundles, expecting the earlier bundles
>      +    to successfully unbundle now. The example repository in t5558
>      +    demonstrates this well:
>      +
>      +     ---------------- bundle-4
>      +
>      +           4
>      +          / \
>      +     ----|---|------- bundle-3
>      +         |   |
>      +         |   3
>      +         |   |
>      +     ----|---|------- bundle-2
>      +         |   |
>      +         2   |
>      +         |   |
>      +     ----|---|------- bundle-1
>      +          \ /
>      +           1
>      +           |
>      +     (previous commits)
>      +
>      +    In this repository, if we already have the objects for bundle-1 and then
>      +    try to fetch from this list, the naive approach will fail. bundle-4
>      +    requires both bundle-3 and bundle-2, though bundle-3 will successfully
>      +    unbundle without bundle-2. Thus, the algorithm needs to keep this in
>      +    mind.
>      +
>           A later implementation detail will store the maximum creationToken seen
>           during such a bundle download, and the client will avoid downloading a
>           bundle unless its creationToken is strictly greater than that stored
>      @@ bundle-uri.c: static int download_bundle_to_file(struct remote_bundle_info *bund
>        	return 0;
>        }
>        
>      -+struct sorted_bundle_list {
>      ++struct bundles_for_sorting {
>       +	struct remote_bundle_info **items;
>       +	size_t alloc;
>       +	size_t nr;
>       +};
>       +
>      -+static int insert_bundle(struct remote_bundle_info *bundle, void *data)
>      ++static int append_bundle(struct remote_bundle_info *bundle, void *data)
>       +{
>      -+	struct sorted_bundle_list *list = data;
>      ++	struct bundles_for_sorting *list = data;
>       +	list->items[list->nr++] = bundle;
>       +	return 0;
>       +}
>       +
>      -+static int compare_creation_token(const void *va, const void *vb)
>      ++/**
>      ++ * For use in QSORT() to get a list sorted by creationToken
>      ++ * in decreasing order.
>      ++ */
>      ++static int compare_creation_token_decreasing(const void *va, const void *vb)
>       +{
>       +	const struct remote_bundle_info * const *a = va;
>       +	const struct remote_bundle_info * const *b = vb;
>      @@ bundle-uri.c: static int download_bundle_to_file(struct remote_bundle_info *bund
>       +				  struct bundle_list *list)
>       +{
>       +	int cur;
>      -+	int pop_or_push = 0;
>      ++	int move_direction = 0;
>       +	struct bundle_list_context ctx = {
>       +		.r = r,
>       +		.list = list,
>       +		.mode = list->mode,
>       +	};
>      -+	struct sorted_bundle_list sorted = {
>      ++	struct bundles_for_sorting bundles = {
>       +		.alloc = hashmap_get_size(&list->bundles),
>       +	};
>       +
>      -+	ALLOC_ARRAY(sorted.items, sorted.alloc);
>      ++	ALLOC_ARRAY(bundles.items, bundles.alloc);
>       +
>      -+	for_all_bundles_in_list(list, insert_bundle, &sorted);
>      ++	for_all_bundles_in_list(list, append_bundle, &bundles);
>       +
>      -+	QSORT(sorted.items, sorted.nr, compare_creation_token);
>      ++	QSORT(bundles.items, bundles.nr, compare_creation_token_decreasing);
>       +
>       +	/*
>      -+	 * Use a stack-based approach to download the bundles and attempt
>      -+	 * to unbundle them in decreasing order by creation token. If we
>      -+	 * fail to unbundle (after a successful download) then move to the
>      -+	 * next non-downloaded bundle (push to the stack) and attempt
>      -+	 * downloading. Once we succeed in applying a bundle, move to the
>      -+	 * previous unapplied bundle (pop the stack) and attempt to unbundle
>      -+	 * it again.
>      ++	 * Attempt to download and unbundle the minimum number of bundles by
>      ++	 * creationToken in decreasing order. If we fail to unbundle (after
>      ++	 * a successful download) then move to the next non-downloaded bundle
>      ++	 * and attempt downloading. Once we succeed in applying a bundle,
>      ++	 * move to the previous unapplied bundle and attempt to unbundle it
>      ++	 * again.
>       +	 *
>       +	 * In the case of a fresh clone, we will likely download all of the
>       +	 * bundles before successfully unbundling the oldest one, then the
>      @@ bundle-uri.c: static int download_bundle_to_file(struct remote_bundle_info *bund
>       +	 * repo's object store.
>       +	 */
>       +	cur = 0;
>      -+	while (cur >= 0 && cur < sorted.nr) {
>      -+		struct remote_bundle_info *bundle = sorted.items[cur];
>      ++	while (cur >= 0 && cur < bundles.nr) {
>      ++		struct remote_bundle_info *bundle = bundles.items[cur];
>       +		if (!bundle->file) {
>      -+			/* Not downloaded yet. Try downloading. */
>      -+			if (download_bundle_to_file(bundle, &ctx)) {
>      -+				/* Failure. Push to the stack. */
>      -+				pop_or_push = 1;
>      ++			/*
>      ++			 * Not downloaded yet. Try downloading.
>      ++			 *
>      ++			 * Note that bundle->file is non-NULL if a download
>      ++			 * was attempted, even if it failed to download.
>      ++			 */
>      ++			if (fetch_bundle_uri_internal(ctx.r, bundle, ctx.depth + 1, ctx.list)) {
>      ++				/* Mark as unbundled so we do not retry. */
>      ++				bundle->unbundled = 1;
>      ++
>      ++				/* Try looking deeper in the list. */
>      ++				move_direction = 1;
>       +				goto stack_operation;
>       +			}
>       +
>      @@ bundle-uri.c: static int download_bundle_to_file(struct remote_bundle_info *bund
>       +			 * unbundled. Try unbundling again.
>       +			 */
>       +			if (unbundle_from_file(ctx.r, bundle->file)) {
>      -+				/* Failed to unbundle. Push to stack. */
>      -+				pop_or_push = 1;
>      ++				/* Try looking deeper in the list. */
>      ++				move_direction = 1;
>       +			} else {
>      -+				/* Succeeded in unbundle. Pop stack. */
>      -+				pop_or_push = -1;
>      ++				/*
>      ++				 * Succeeded in unbundle. Retry bundles
>      ++				 * that previously failed to unbundle.
>      ++				 */
>      ++				move_direction = -1;
>      ++				bundle->unbundled = 1;
>       +			}
>       +		}
>       +
>      @@ bundle-uri.c: static int download_bundle_to_file(struct remote_bundle_info *bund
>       +
>       +stack_operation:
>       +		/* Move in the specified direction and repeat. */
>      -+		cur += pop_or_push;
>      ++		cur += move_direction;
>       +	}
>       +
>      -+	free(sorted.items);
>      ++	free(bundles.items);
>       +
>       +	/*
>       +	 * We succeed if the loop terminates because 'cur' drops below
>      @@ bundle-uri.c: static int fetch_bundle_list_in_config_format(struct repository *r
>       +	 * it advertises are expected to be bundles, not nested lists.
>       +	 * We can drop 'global_list' and 'depth'.
>       +	 */
>      -+	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN)
>      ++	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN) {
>       +		result = fetch_bundles_by_token(r, &list_from_bundle);
>      -+	else if ((result = download_bundle_list(r, &list_from_bundle,
>      ++		global_list->heuristic = BUNDLE_HEURISTIC_CREATIONTOKEN;
>      ++	} else if ((result = download_bundle_list(r, &list_from_bundle,
>        					   global_list, depth)))
>        		goto cleanup;
>        
>      @@ bundle-uri.c: int fetch_bundle_list(struct repository *r, struct bundle_list *li
>        	for_all_bundles_in_list(&global_list, unlink_bundle, NULL);
>       
>        ## t/t5558-clone-bundle-uri.sh ##
>      -@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (HTTP, any mode)' '
>      - '
>      - 
>      - test_expect_success 'clone bundle list (http, creationToken)' '
>      -+	test_when_finished rm -f trace*.txt &&
>      -+
>      - 	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
>      - 	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
>      - 	[bundle]
>       @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (http, creationToken)' '
>      - 		creationToken = 4
>      - 	EOF
>      + 	git -C clone-list-http-2 cat-file --batch-check <oids &&
>        
>      --	git clone --bundle-uri="$HTTPD_URL/bundle-list" . clone-list-http-2 &&
>      -+	GIT_TRACE2_EVENT=$(pwd)/trace-clone.txt \
>      -+	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
>      -+		clone-from clone-list-http-2 &&
>      - 
>      - 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
>      --	git -C clone-list-http-2 cat-file --batch-check <oids
>      -+	git -C clone-list-http-2 cat-file --batch-check <oids &&
>      -+
>      -+	for b in 1 2 3 4
>      -+	do
>      -+		test_bundle_downloaded bundle-$b.bundle trace-clone.txt ||
>      -+			return 1
>      -+	done
>      + 	cat >expect <<-EOF &&
>      +-	$HTTPD_URL/bundle-1.bundle
>      +-	$HTTPD_URL/bundle-2.bundle
>      +-	$HTTPD_URL/bundle-3.bundle
>      ++	$HTTPD_URL/bundle-list
>      + 	$HTTPD_URL/bundle-4.bundle
>      ++	$HTTPD_URL/bundle-3.bundle
>      ++	$HTTPD_URL/bundle-2.bundle
>      ++	$HTTPD_URL/bundle-1.bundle
>      ++	EOF
>      ++
>      ++	test_remote_https_urls <trace-clone.txt >actual &&
>      ++	test_cmp expect actual
>       +'
>       +
>      -+test_expect_success 'clone bundle list (http, creationToken)' '
>      ++test_expect_success 'clone incomplete bundle list (http, creationToken)' '
>       +	test_when_finished rm -f trace*.txt &&
>       +
>       +	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
>      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (http, creat
>       +	[bundle "bundle-1"]
>       +		uri = bundle-1.bundle
>       +		creationToken = 1
>      -+
>      -+	[bundle "bundle-2"]
>      -+		uri = bundle-2.bundle
>      -+		creationToken = 2
>       +	EOF
>       +
>       +	GIT_TRACE2_EVENT=$(pwd)/trace-clone.txt \
>       +	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
>      -+		clone-from clone-token-http &&
>      ++		--single-branch --branch=base --no-tags \
>      ++		"$HTTPD_URL/smart/fetch.git" clone-token-http &&
>       +
>      -+	test_bundle_downloaded bundle-1.bundle trace-clone.txt &&
>      -+	test_bundle_downloaded bundle-2.bundle trace-clone.txt
>      ++	cat >expect <<-EOF &&
>      + 	$HTTPD_URL/bundle-list
>      ++	$HTTPD_URL/bundle-1.bundle
>      + 	EOF
>      + 
>      +-	# Since the creationToken heuristic is not yet understood by the
>      +-	# client, the order cannot be verified at this moment. Sort the
>      +-	# list for consistent results.
>      +-	test_remote_https_urls <trace-clone.txt | sort >actual &&
>      ++	test_remote_https_urls <trace-clone.txt >actual &&
>      + 	test_cmp expect actual
>        '
>        
>      - # Do not add tests here unless they use the HTTP server, as they will
>       
>        ## t/t5601-clone.sh ##
>       @@ t/t5601-clone.sh: test_expect_success 'auto-discover multiple bundles from HTTP clone' '
>        	grep -f pattern trace.txt
>        '
>        
>      -+# Usage: test_bundle_downloaded <bundle-id> <trace-filename>
>      -+test_bundle_downloaded () {
>      -+	cat >pattern <<-EOF &&
>      -+	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/$1.bundle"\]
>      -+	EOF
>      -+	grep -f pattern "$2"
>      -+}
>      -+
>       +test_expect_success 'auto-discover multiple bundles from HTTP clone: creationToken heuristic' '
>       +	test_when_finished rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/repo4.git" &&
>       +	test_when_finished rm -rf clone-heuristic trace*.txt &&
>      @@ t/t5601-clone.sh: test_expect_success 'auto-discover multiple bundles from HTTP
>       +		    -c transfer.bundleURI=true clone \
>       +		"$HTTPD_URL/smart/repo4.git" clone-heuristic &&
>       +
>      -+	# We should fetch all bundles
>      -+	for b in everything new newest
>      -+	do
>      -+		test_bundle_downloaded $b trace-clone.txt || return 1
>      -+	done
>      ++	cat >expect <<-EOF &&
>      ++	$HTTPD_URL/newest.bundle
>      ++	$HTTPD_URL/new.bundle
>      ++	$HTTPD_URL/everything.bundle
>      ++	EOF
>      ++
>      ++	# We should fetch all bundles in the expected order.
>      ++	test_remote_https_urls <trace-clone.txt >actual &&
>      ++	test_cmp expect actual
>       +'
>       +
>        # DO NOT add non-httpd-specific tests here, because the last part of this
>   5:  d9c6f50e4f2 !  6:  17c404c1b83 clone: set fetch.bundleURI if appropriate
>      @@ Documentation/config/fetch.txt: fetch.writeCommitGraph::
>        	`git push -f`, and `git log --graph`. Defaults to false.
>       +
>       +fetch.bundleURI::
>      -+	This value stores a URI for fetching Git object data from a bundle URI
>      -+	before performing an incremental fetch from the origin Git server. If
>      -+	the value is `<uri>` then running `git fetch <args>` is equivalent to
>      -+	first running `git fetch --bundle-uri=<uri>` immediately before
>      -+	`git fetch <args>`. See details of the `--bundle-uri` option in
>      -+	linkgit:git-fetch[1].
>      ++	This value stores a URI for downloading Git object data from a bundle
>      ++	URI before performing an incremental fetch from the origin Git server.
>      ++	This is similar to how the `--bundle-uri` option behaves in
>      ++	linkgit:git-clone[1]. `git clone --bundle-uri` will set the
>      ++	`fetch.bundleURI` value if the supplied bundle URI contains a bundle
>      ++	list that is organized for incremental fetches.
>       
>        ## builtin/clone.c ##
>       @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
>      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
>        	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
>       
>        ## bundle-uri.c ##
>      -@@ bundle-uri.c: static int fetch_bundle_list_in_config_format(struct repository *r,
>      - 	 * it advertises are expected to be bundles, not nested lists.
>      - 	 * We can drop 'global_list' and 'depth'.
>      - 	 */
>      --	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN)
>      -+	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN) {
>      - 		result = fetch_bundles_by_token(r, &list_from_bundle);
>      --	else if ((result = download_bundle_list(r, &list_from_bundle,
>      -+		global_list->heuristic = BUNDLE_HEURISTIC_CREATIONTOKEN;
>      -+	} else if ((result = download_bundle_list(r, &list_from_bundle,
>      - 					   global_list, depth)))
>      - 		goto cleanup;
>      - 
>       @@ bundle-uri.c: static int unlink_bundle(struct remote_bundle_info *info, void *data)
>        	return 0;
>        }
>      @@ bundle-uri.h: int bundle_uri_parse_config_format(const char *uri,
>         * Given a bundle list that was already advertised (likely by the
>       
>        ## t/t5558-clone-bundle-uri.sh ##
>      -@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (http, creationToken)' '
>      - 	test_bundle_downloaded bundle-2.bundle trace-clone.txt
>      +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone incomplete bundle list (http, creationToken)' '
>      + 		--single-branch --branch=base --no-tags \
>      + 		"$HTTPD_URL/smart/fetch.git" clone-token-http &&
>      + 
>      ++	test_cmp_config -C clone-token-http "$HTTPD_URL/bundle-list" fetch.bundleuri &&
>      ++
>      + 	cat >expect <<-EOF &&
>      + 	$HTTPD_URL/bundle-list
>      + 	$HTTPD_URL/bundle-1.bundle
>      +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone incomplete bundle list (http, creationToken)' '
>      + 	test_cmp expect actual
>        '
>        
>       +test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (http, creat
>       +
>       +	test_cmp_config -C fetch-http-4 "$HTTPD_URL/bundle-list" fetch.bundleuri &&
>       +
>      -+	# The clone should copy two files: the list and bundle-1.
>      -+	test_bundle_downloaded bundle-list trace-clone.txt &&
>      -+	test_bundle_downloaded bundle-1.bundle trace-clone.txt &&
>      ++	cat >expect <<-EOF &&
>      ++	$HTTPD_URL/bundle-list
>      ++	$HTTPD_URL/bundle-1.bundle
>      ++	EOF
>      ++
>      ++	test_remote_https_urls <trace-clone.txt >actual &&
>      ++	test_cmp expect actual &&
>       +
>       +	# only received base ref from bundle-1
>       +	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
>   6:  afcfd27a883 =  7:  d491070efed bundle-uri: drop bundle.flag from design doc
>   7:  1627fc158b1 !  8:  59e57e04968 fetch: fetch from an external bundle URI
>      @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
>        	if (dry_run)
>        		write_fetch_head = 0;
>        
>      -+	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri) &&
>      -+	    !starts_with(bundle_uri, "remote:")) {
>      ++	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri)) {
>       +		if (fetch_bundle_uri(the_repository, bundle_uri, NULL))
>       +			warning(_("failed to fetch bundles from '%s'"), bundle_uri);
>       +	}
>      @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
>        			die(_("fetch --all does not take a repository argument"));
>       
>        ## t/t5558-clone-bundle-uri.sh ##
>      +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone incomplete bundle list (http, creationToken)' '
>      + 	EOF
>      + 
>      + 	test_remote_https_urls <trace-clone.txt >actual &&
>      +-	test_cmp expect actual
>      ++	test_cmp expect actual &&
>      ++
>      ++	# We now have only one bundle ref.
>      ++	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
>      ++	cat >expect <<-\EOF &&
>      ++	refs/bundles/base
>      ++	EOF
>      ++	test_cmp expect refs &&
>      ++
>      ++	# Add remaining bundles, exercising the "deepening" strategy
>      ++	# for downloading via the creationToken heurisitc.
>      ++	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
>      ++	[bundle "bundle-2"]
>      ++		uri = bundle-2.bundle
>      ++		creationToken = 2
>      ++
>      ++	[bundle "bundle-3"]
>      ++		uri = bundle-3.bundle
>      ++		creationToken = 3
>      ++
>      ++	[bundle "bundle-4"]
>      ++		uri = bundle-4.bundle
>      ++		creationToken = 4
>      ++	EOF
>      ++
>      ++	GIT_TRACE2_EVENT="$(pwd)/trace1.txt" \
>      ++		git -C clone-token-http fetch origin --no-tags \
>      ++		refs/heads/merge:refs/heads/merge &&
>      ++
>      ++	cat >expect <<-EOF &&
>      ++	$HTTPD_URL/bundle-list
>      ++	$HTTPD_URL/bundle-4.bundle
>      ++	$HTTPD_URL/bundle-3.bundle
>      ++	$HTTPD_URL/bundle-2.bundle
>      ++	EOF
>      ++
>      ++	test_remote_https_urls <trace1.txt >actual &&
>      ++	test_cmp expect actual &&
>      ++
>      ++	# We now have all bundle refs.
>      ++	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
>      ++
>      ++	cat >expect <<-\EOF &&
>      ++	refs/bundles/base
>      ++	refs/bundles/left
>      ++	refs/bundles/merge
>      ++	refs/bundles/right
>      ++	EOF
>      ++	test_cmp expect refs
>      + '
>      + 
>      + test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>       @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>        	cat >expect <<-\EOF &&
>        	refs/bundles/base
>      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heurist
>       +		refs/heads/left:refs/heads/left \
>       +		refs/heads/right:refs/heads/right &&
>       +
>      -+	# This fetch should copy two files: the list and bundle-2.
>      -+	test_bundle_downloaded bundle-list trace1.txt &&
>      -+	test_bundle_downloaded bundle-2.bundle trace1.txt &&
>      -+	! test_bundle_downloaded bundle-1.bundle trace1.txt &&
>      ++	cat >expect <<-EOF &&
>      ++	$HTTPD_URL/bundle-list
>      ++	$HTTPD_URL/bundle-2.bundle
>      ++	EOF
>      ++
>      ++	test_remote_https_urls <trace1.txt >actual &&
>      ++	test_cmp expect actual &&
>       +
>       +	# received left from bundle-2
>       +	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
>      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heurist
>       +		creationToken = 4
>       +	EOF
>       +
>      -+	# This fetch should skip bundle-3.bundle, since its objets are
>      ++	# This fetch should skip bundle-3.bundle, since its objects are
>       +	# already local (we have the requisite commits for bundle-4.bundle).
>       +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
>       +		git -C fetch-http-4 fetch origin --no-tags \
>       +		refs/heads/merge:refs/heads/merge &&
>       +
>      -+	# This fetch should copy three files: the list, bundle-3, and bundle-4.
>      -+	test_bundle_downloaded bundle-list trace2.txt &&
>      -+	test_bundle_downloaded bundle-4.bundle trace2.txt &&
>      -+	! test_bundle_downloaded bundle-1.bundle trace2.txt &&
>      -+	! test_bundle_downloaded bundle-2.bundle trace2.txt &&
>      -+	! test_bundle_downloaded bundle-3.bundle trace2.txt &&
>      ++	cat >expect <<-EOF &&
>      ++	$HTTPD_URL/bundle-list
>      ++	$HTTPD_URL/bundle-4.bundle
>      ++	EOF
>      ++
>      ++	test_remote_https_urls <trace2.txt >actual &&
>      ++	test_cmp expect actual &&
>       +
>       +	# received merge ref from bundle-4, but right is missing
>       +	# because we did not download bundle-3.
>   8:  51f210ddeb4 !  9:  6a1504b1c3a bundle-uri: store fetch.bundleCreationToken
>      @@ Commit message
>           When checking the same bundle list twice, this strategy requires
>           downloading the bundle with the maximum creationToken again, which is
>           wasteful. The creationToken heuristic promises that the client will not
>      -    have a use for that bundle if its creationToken value is the at most the
>      +    have a use for that bundle if its creationToken value is at most the
>           previous creationToken value.
>       
>           To prevent these wasteful downloads, create a fetch.bundleCreationToken
>      @@ Commit message
>       
>        ## Documentation/config/fetch.txt ##
>       @@ Documentation/config/fetch.txt: fetch.bundleURI::
>      - 	first running `git fetch --bundle-uri=<uri>` immediately before
>      - 	`git fetch <args>`. See details of the `--bundle-uri` option in
>      - 	linkgit:git-fetch[1].
>      + 	linkgit:git-clone[1]. `git clone --bundle-uri` will set the
>      + 	`fetch.bundleURI` value if the supplied bundle URI contains a bundle
>      + 	list that is organized for incremental fetches.
>      +++
>      ++If you modify this value and your repository has a `fetch.bundleCreationToken`
>      ++value, then remove that `fetch.bundleCreationToken` value before fetching from
>      ++the new bundle URI.
>       +
>       +fetch.bundleCreationToken::
>       +	When using `fetch.bundleURI` to fetch incrementally from a bundle
>      @@ Documentation/config/fetch.txt: fetch.bundleURI::
>       +	This value is used to prevent downloading bundles in the future
>       +	if the advertised `creationToken` is not strictly larger than this
>       +	value.
>      +++
>      ++The creation token values are chosen by the provider serving the specific
>      ++bundle URI. If you modify the URI at `fetch.bundleURI`, then be sure to
>      ++remove the value for the `fetch.bundleCreationToken` value before fetching.
>       
>        ## bundle-uri.c ##
>       @@ bundle-uri.c: static int fetch_bundles_by_token(struct repository *r,
>        {
>        	int cur;
>      - 	int pop_or_push = 0;
>      + 	int move_direction = 0;
>       +	const char *creationTokenStr;
>      -+	uint64_t maxCreationToken;
>      ++	uint64_t maxCreationToken = 0, newMaxCreationToken = 0;
>        	struct bundle_list_context ctx = {
>        		.r = r,
>        		.list = list,
>       @@ bundle-uri.c: static int fetch_bundles_by_token(struct repository *r,
>        
>      - 	for_all_bundles_in_list(list, insert_bundle, &sorted);
>      + 	for_all_bundles_in_list(list, append_bundle, &bundles);
>        
>      -+	if (!sorted.nr) {
>      -+		free(sorted.items);
>      ++	if (!bundles.nr) {
>      ++		free(bundles.items);
>       +		return 0;
>       +	}
>       +
>      - 	QSORT(sorted.items, sorted.nr, compare_creation_token);
>      + 	QSORT(bundles.items, bundles.nr, compare_creation_token_decreasing);
>        
>       +	/*
>       +	 * If fetch.bundleCreationToken exists, parses to a uint64t, and
>      @@ bundle-uri.c: static int fetch_bundles_by_token(struct repository *r,
>       +				   "fetch.bundlecreationtoken",
>       +				   &creationTokenStr) &&
>       +	    sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) == 1 &&
>      -+	    sorted.items[0]->creationToken <= maxCreationToken) {
>      -+		free(sorted.items);
>      ++	    bundles.items[0]->creationToken <= maxCreationToken) {
>      ++		free(bundles.items);
>       +		return 0;
>       +	}
>       +
>        	/*
>      - 	 * Use a stack-based approach to download the bundles and attempt
>      - 	 * to unbundle them in decreasing order by creation token. If we
>      + 	 * Attempt to download and unbundle the minimum number of bundles by
>      + 	 * creationToken in decreasing order. If we fail to unbundle (after
>      +@@ bundle-uri.c: static int fetch_bundles_by_token(struct repository *r,
>      + 	cur = 0;
>      + 	while (cur >= 0 && cur < bundles.nr) {
>      + 		struct remote_bundle_info *bundle = bundles.items[cur];
>      ++
>      ++		/*
>      ++		 * If we need to dig into bundles below the previous
>      ++		 * creation token value, then likely we are in an erroneous
>      ++		 * state due to missing or invalid bundles. Halt the process
>      ++		 * instead of continuing to download extra data.
>      ++		 */
>      ++		if (bundle->creationToken <= maxCreationToken)
>      ++			break;
>      ++
>      + 		if (!bundle->file) {
>      + 			/*
>      + 			 * Not downloaded yet. Try downloading.
>      +@@ bundle-uri.c: static int fetch_bundles_by_token(struct repository *r,
>      + 				 */
>      + 				move_direction = -1;
>      + 				bundle->unbundled = 1;
>      ++
>      ++				if (bundle->creationToken > newMaxCreationToken)
>      ++					newMaxCreationToken = bundle->creationToken;
>      + 			}
>      + 		}
>      + 
>       @@ bundle-uri.c: stack_operation:
>      - 		cur += pop_or_push;
>      + 		cur += move_direction;
>        	}
>        
>      --	free(sorted.items);
>      +-	free(bundles.items);
>       -
>        	/*
>        	 * We succeed if the loop terminates because 'cur' drops below
>      @@ bundle-uri.c: stack_operation:
>        	 */
>       +	if (cur < 0) {
>       +		struct strbuf value = STRBUF_INIT;
>      -+		strbuf_addf(&value, "%"PRIu64"", sorted.items[0]->creationToken);
>      ++		strbuf_addf(&value, "%"PRIu64"", newMaxCreationToken);
>       +		if (repo_config_set_multivar_gently(ctx.r,
>       +						    "fetch.bundleCreationToken",
>       +						    value.buf, NULL, 0))
>      @@ bundle-uri.c: stack_operation:
>       +		strbuf_release(&value);
>       +	}
>       +
>      -+	free(sorted.items);
>      ++	free(bundles.items);
>        	return cur >= 0;
>        }
>        
>       
>        ## t/t5558-clone-bundle-uri.sh ##
>      +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone incomplete bundle list (http, creationToken)' '
>      + 		"$HTTPD_URL/smart/fetch.git" clone-token-http &&
>      + 
>      + 	test_cmp_config -C clone-token-http "$HTTPD_URL/bundle-list" fetch.bundleuri &&
>      ++	test_cmp_config -C clone-token-http 1 fetch.bundlecreationtoken &&
>      + 
>      + 	cat >expect <<-EOF &&
>      + 	$HTTPD_URL/bundle-list
>      +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone incomplete bundle list (http, creationToken)' '
>      + 	GIT_TRACE2_EVENT="$(pwd)/trace1.txt" \
>      + 		git -C clone-token-http fetch origin --no-tags \
>      + 		refs/heads/merge:refs/heads/merge &&
>      ++	test_cmp_config -C clone-token-http 4 fetch.bundlecreationtoken &&
>      + 
>      + 	cat >expect <<-EOF &&
>      + 	$HTTPD_URL/bundle-list
>       @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>        		"$HTTPD_URL/smart/fetch.git" fetch-http-4 &&
>        
>        	test_cmp_config -C fetch-http-4 "$HTTPD_URL/bundle-list" fetch.bundleuri &&
>       +	test_cmp_config -C fetch-http-4 1 fetch.bundlecreationtoken &&
>        
>      - 	# The clone should copy two files: the list and bundle-1.
>      - 	test_bundle_downloaded bundle-list trace-clone.txt &&
>      + 	cat >expect <<-EOF &&
>      + 	$HTTPD_URL/bundle-list
>       @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>      + 		git -C fetch-http-4 fetch origin --no-tags \
>        		refs/heads/left:refs/heads/left \
>        		refs/heads/right:refs/heads/right &&
>      - 
>       +	test_cmp_config -C fetch-http-4 2 fetch.bundlecreationtoken &&
>      -+
>      - 	# This fetch should copy two files: the list and bundle-2.
>      - 	test_bundle_downloaded bundle-list trace1.txt &&
>      - 	test_bundle_downloaded bundle-2.bundle trace1.txt &&
>      + 
>      + 	cat >expect <<-EOF &&
>      + 	$HTTPD_URL/bundle-list
>       @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>        	EOF
>        	test_cmp expect refs &&
>      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heurist
>       +		git -C fetch-http-4 fetch origin --no-tags \
>       +		refs/heads/left:refs/heads/left \
>       +		refs/heads/right:refs/heads/right &&
>      -+	test_bundle_downloaded bundle-list trace1b.txt &&
>      -+	! test_bundle_downloaded bundle-1.bundle trace1b.txt &&
>      -+	! test_bundle_downloaded bundle-2.bundle trace1b.txt &&
>      ++
>      ++	cat >expect <<-EOF &&
>      ++	$HTTPD_URL/bundle-list
>      ++	EOF
>      ++	test_remote_https_urls <trace1b.txt >actual &&
>      ++	test_cmp expect actual &&
>       +
>        	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
>        	[bundle "bundle-3"]
>        		uri = bundle-3.bundle
>       @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>      + 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
>        		git -C fetch-http-4 fetch origin --no-tags \
>        		refs/heads/merge:refs/heads/merge &&
>      - 
>       +	test_cmp_config -C fetch-http-4 4 fetch.bundlecreationtoken &&
>      -+
>      - 	# This fetch should copy three files: the list, bundle-3, and bundle-4.
>      - 	test_bundle_downloaded bundle-list trace2.txt &&
>      - 	test_bundle_downloaded bundle-4.bundle trace2.txt &&
>      + 
>      + 	cat >expect <<-EOF &&
>      + 	$HTTPD_URL/bundle-list
>       @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>        	refs/bundles/left
>        	refs/bundles/merge
>      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heurist
>       +	# No-op fetch
>       +	GIT_TRACE2_EVENT="$(pwd)/trace2b.txt" \
>       +		git -C fetch-http-4 fetch origin &&
>      -+	test_bundle_downloaded bundle-list trace2b.txt &&
>      -+	! test_bundle_downloaded bundle-1.bundle trace2b.txt &&
>      -+	! test_bundle_downloaded bundle-2.bundle trace2b.txt &&
>      -+	! test_bundle_downloaded bundle-3.bundle trace2b.txt &&
>      -+	! test_bundle_downloaded bundle-4.bundle trace2b.txt
>      ++
>      ++	cat >expect <<-EOF &&
>      ++	$HTTPD_URL/bundle-list
>      ++	EOF
>      ++	test_remote_https_urls <trace2b.txt >actual &&
>      ++	test_cmp expect actual
>        '
>        
>        # Do not add tests here unless they use the HTTP server, as they will
>   -:  ----------- > 10:  676522615ad bundle-uri: test missing bundles with heuristic
> 

