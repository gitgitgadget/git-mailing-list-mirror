Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9F1C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 19:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjASTnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 14:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjASTm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 14:42:57 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7E51BF1
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 11:42:55 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id x24-20020a17090ab01800b00229f43b506fso1832891pjq.5
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 11:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2HWOJYMiDBJ2ZBEC1mfRmjRzfgnghagNM6SvJZ+KZc=;
        b=Jpo/gOVdDe6dhnXZ5Ggk7wKfpd11FoiFdyfq5Ico9u+WYOm4Vab01GY9TOfHT4NfAV
         vPHgVs0OeHGH42HhtQyJYbIxlIsgAAIbzbPa/hsqpz8Wpx6xwvI3TMojn/wvVy4cVDZZ
         MLzXG47C31+YyofjzTx71JE8k2CZbC5qPFE6jTw1Yqo99OIEzdhqQijLnjydNlPdmI8W
         KB3vNlvu3h+fqPnkA7C0ZIRdkNUn1Pir69zdS0egI7hBK77ku/M3i+0BkAGYYNggNd+U
         6ocw8n7ZeGj4vJiuc9pTpuuMr9gAL5fiD8c+qx5xj4/LKTwE6+ye7N9lN76FcXi8l90I
         H4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2HWOJYMiDBJ2ZBEC1mfRmjRzfgnghagNM6SvJZ+KZc=;
        b=bpavR90hdUMSDM0cY0v/e7cijgTyKI9IbqhZYZrcvHA/ZAdZGgl2Lt+yXsnELTJjrd
         kjJdT1SQaeebxY8Izwp1dKJYrT2GROobNVaHN1r8+S3pDeZWhtREMEanseNypdM87a/p
         978/+fHxNkOBHmFPmAD0+9pnty8jReghCGj8DyBAdvx516K/SEuz5iNKmM/OZ6V+QlE/
         If/Uk8u3p9CW3nf0a3gCvurkKncKq+I+YD3HQ+yRAEsl1YATO9nijXt36wBGie04aZPz
         CPXwH/+uw3MtJF7Voj9c+G3bsOeC5RlhJQuvk3V3CJb3qRUT9BAQTem5JNpU9L1Gi8I+
         hiNg==
X-Gm-Message-State: AFqh2kq0YyPeMbwugkWQvXnMKpXHN7/TGnWkSm8Ymo+1O9K8Q1aiXCwT
        r+v60bbipFFVx2y2aA5eWWcA
X-Google-Smtp-Source: AMrXdXv/hYYMKN/bddUXpHbQgrlXWkVe8Fic7RBDREyLt4cyivEmx2mgTDRyp++uzWfk54n6l+QHBg==
X-Received: by 2002:a17:902:ea0a:b0:191:24a:63e3 with SMTP id s10-20020a170902ea0a00b00191024a63e3mr15627501plg.50.1674157375359;
        Thu, 19 Jan 2023 11:42:55 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00194974a2b3asm7462170plr.151.2023.01.19.11.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 11:42:54 -0800 (PST)
Message-ID: <61a830f0-a8d8-5a8a-e952-db213d571352@github.com>
Date:   Thu, 19 Jan 2023 11:42:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 5/8] clone: set fetch.bundleURI if appropriate
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <d9c6f50e4f218267c1e8da060ce5b190dc8a709c.1673037405.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <d9c6f50e4f218267c1e8da060ce5b190dc8a709c.1673037405.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
> index cd65d236b43..4f796218aab 100644
> --- a/Documentation/config/fetch.txt
> +++ b/Documentation/config/fetch.txt
> @@ -96,3 +96,11 @@ fetch.writeCommitGraph::
>  	merge and the write may take longer. Having an updated commit-graph
>  	file helps performance of many Git commands, including `git merge-base`,
>  	`git push -f`, and `git log --graph`. Defaults to false.
> +
> +fetch.bundleURI::
> +	This value stores a URI for fetching Git object data from a bundle URI
> +	before performing an incremental fetch from the origin Git server. If
> +	the value is `<uri>` then running `git fetch <args>` is equivalent to
> +	first running `git fetch --bundle-uri=<uri>` immediately before
> +	`git fetch <args>`. See details of the `--bundle-uri` option in
> +	linkgit:git-fetch[1].

Since it's not mentioned from this or any other user-facing documentation
(AFAICT), could you note that this value is set automatically by 'git clone'
iff '--bundle-uri' is specified *and* 'bundle.heuristic' is set for the
initially downloaded bundle list?

It would also be nice to make note of that behavior in the documentation of
the '--bundle-uri' option in 'Documentation/git-clone.txt', since command
documentation in general seems to be more popular/visible to users than
config docs.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 5453ba5277f..5370617664d 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1248,12 +1248,16 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	 * data from the --bundle-uri option.
>  	 */
>  	if (bundle_uri) {
> +		int has_heuristic = 0;
> +
>  		/* At this point, we need the_repository to match the cloned repo. */
>  		if (repo_init(the_repository, git_dir, work_tree))
>  			warning(_("failed to initialize the repo, skipping bundle URI"));
> -		else if (fetch_bundle_uri(the_repository, bundle_uri))
> +		else if (fetch_bundle_uri(the_repository, bundle_uri, &has_heuristic))
>  			warning(_("failed to fetch objects from bundle URI '%s'"),
>  				bundle_uri);
> +		else if (has_heuristic)
> +			git_config_set_gently("fetch.bundleuri", bundle_uri);

If the heuristic is anything other than "none", this config value is set in
the repository-scoped config file. Makes sense!

>  	}
>  
>  	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
> diff --git a/bundle-uri.c b/bundle-uri.c
> index b30c85ba6f2..1dbbbb980eb 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -594,9 +594,10 @@ static int fetch_bundle_list_in_config_format(struct repository *r,
>  	 * it advertises are expected to be bundles, not nested lists.
>  	 * We can drop 'global_list' and 'depth'.
>  	 */
> -	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN)
> +	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN) {
>  		result = fetch_bundles_by_token(r, &list_from_bundle);
> -	else if ((result = download_bundle_list(r, &list_from_bundle,
> +		global_list->heuristic = BUNDLE_HEURISTIC_CREATIONTOKEN;

If the 'heuristic' field already existed and was being used to apply
bundles, why wasn't 'global_list->heuristic' already being set? Before this
patch, was the 'global_list->heuristic' field not accurately reflecting the
heuristic type of a given bundle list? 

If so, I think it'd make sense to move this section to patch 4 [1], since
that's when the heuristic is first applied to the bundle list.

[1] https://lore.kernel.org/git/57c0174d3752fb61a05e0653de9d3057616ed16a.1673037405.git.gitgitgadget@gmail.com/

> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index d7461ec907e..8ff560425ee 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -435,6 +435,39 @@ test_expect_success 'clone bundle list (http, creationToken)' '
>  	test_bundle_downloaded bundle-2.bundle trace-clone.txt
>  '
>  
> +test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
> +	test_when_finished rm -rf fetch-http-4 trace*.txt &&
> +
> +	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
> +	[bundle]
> +		version = 1
> +		mode = all
> +		heuristic = creationToken
> +
> +	[bundle "bundle-1"]
> +		uri = bundle-1.bundle
> +		creationToken = 1
> +	EOF
> +
> +	GIT_TRACE2_EVENT="$(pwd)/trace-clone.txt" \
> +	git clone --single-branch --branch=base \
> +		--bundle-uri="$HTTPD_URL/bundle-list" \
> +		"$HTTPD_URL/smart/fetch.git" fetch-http-4 &&
> +
> +	test_cmp_config -C fetch-http-4 "$HTTPD_URL/bundle-list" fetch.bundleuri &&
> +
> +	# The clone should copy two files: the list and bundle-1.
> +	test_bundle_downloaded bundle-list trace-clone.txt &&
> +	test_bundle_downloaded bundle-1.bundle trace-clone.txt &&
> +
> +	# only received base ref from bundle-1
> +	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	cat >expect <<-\EOF &&
> +	refs/bundles/base
> +	EOF
> +	test_cmp expect refs
> +'

This test looks good - it verifies the config update, bundle download, and
unbundle all work as intended.

> +
>  # Do not add tests here unless they use the HTTP server, as they will
>  # not run unless the HTTP dependencies exist.
>  

