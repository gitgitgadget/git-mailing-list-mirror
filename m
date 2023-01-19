Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017ECC46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 22:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjASWm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 17:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjASWm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 17:42:26 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E975BC88F
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 14:24:06 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z20so1691284plc.2
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 14:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ov/sTVjF+LSjjPicH9JjLCEFTrDVH1y4/QQm1v+xkdo=;
        b=jmWb+IQc1nsJKALknd6JU3Vo604shMlxrwejJYRAmO35MNkrjTJVO/sO3CIS+WX5yR
         Qp3e/k6MIh1P4sU7sPFhkyCXY4yPFZ8Nk6A5OOkiu8JeXQ8X4RE8hUulsXKTlz8/QcoO
         mz9asL5An6EryDBP2snf2EfTtkLGKGrnoICR7ooQDKAG2hA/mZvURSNQeOszLuTTjXTF
         HmyRNzNWT2oqkPsVMDpfxEDbYMBXJ5es93QWgeyhu1Ews7OwwjzV02jpShfo0rmPHCKZ
         KKQxjfo+5MXR77Pa8o+7Io5U134gGQk59kdoHecyQVMy4SBP6t/5GsHXydN+wyFzJFo8
         gLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ov/sTVjF+LSjjPicH9JjLCEFTrDVH1y4/QQm1v+xkdo=;
        b=VC7amSFW2dY7bSvLCuhlqqjebFi7b45UnZeDwoTnR72S4z8u9v4VUtWeW3xenuBqim
         2LBGqp7cWwAWNw8xsSTyZnOX3U9AbsT85IUwIfzoxCPghI+oRazaLVkvLyIm3gM3jZIJ
         xf/vOlS7dr1jNCA2F9KO9UMuSu1CKYfOXawiMPJVYQht/IU7IVWD1opwtOB9G9irwPfn
         NwBTXafXyfJbZVSxXVAlZmDB1FNJ1RWjg1lo7o3jZHn4yWhTfFx8JVlTGnj//kd1N3u0
         KtroKlgwQ9G7I+rh4vuweiB5GGgAH52cmCbOifnHglo3GLCpgOQ+Kgh28GxlZ6lqO2ZJ
         mrRw==
X-Gm-Message-State: AFqh2krt537vWQHAXpTKw0ceBabQlZG9+G8Pn1Mo5nhmHWz4sk/b2UMB
        Uobkus2iyNtCKQhG3PqMDoXQ
X-Google-Smtp-Source: AMrXdXvAV6nCqBZvQl82bk3LGEBCOieAkJxW4dwbHTyUaFILk99tv1AXglyRLnkxEqXDRCTd1X4V7Q==
X-Received: by 2002:a17:902:e88e:b0:192:b2d3:4fc8 with SMTP id w14-20020a170902e88e00b00192b2d34fc8mr16214761plg.1.1674167045205;
        Thu, 19 Jan 2023 14:24:05 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902a41100b0017a032d7ae4sm13110158plq.104.2023.01.19.14.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 14:24:04 -0800 (PST)
Message-ID: <f7a777f0-3f37-86a1-f520-1ab6853b9ed1@github.com>
Date:   Thu, 19 Jan 2023 14:24:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 8/8] bundle-uri: store fetch.bundleCreationToken
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <51f210ddeb46fb06e885dc384a486c4bb16ad8cd.1673037405.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <51f210ddeb46fb06e885dc384a486c4bb16ad8cd.1673037405.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> When a bundle list specifies the "creationToken" heuristic, the Git
> client downloads the list and then starts downloading bundles in
> descending creationToken order. This process stops as soon as all
> downloaded bundles can be applied to the repository (because all
> required commits are present in the repository or in the downloaded
> bundles).
> 
> When checking the same bundle list twice, this strategy requires
> downloading the bundle with the maximum creationToken again, which is
> wasteful. The creationToken heuristic promises that the client will not
> have a use for that bundle if its creationToken value is the at most the

s/is the at most/is at most(?)

> previous creationToken value.
> 
> To prevent these wasteful downloads, create a fetch.bundleCreationToken
> config setting that the Git client sets after downloading bundles. This
> value allows skipping that maximum bundle download when this config
> value is the same value (or larger).
> 
> To test that this works correctly, we can insert some "duplicate"
> fetches into existing tests and demonstrate that only the bundle list is
> downloaded.
> 
> The previous logic for downloading bundles by creationToken worked even
> if the bundle list was empty, but now we have logic that depends on the
> first entry of the list. Terminate early in the (non-sensical) case of
> an empty bundle list.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/config/fetch.txt |  8 ++++++++
>  bundle-uri.c                   | 35 ++++++++++++++++++++++++++++++++--
>  t/t5558-clone-bundle-uri.sh    | 25 +++++++++++++++++++++++-
>  3 files changed, 65 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
> index 4f796218aab..96755ba148b 100644
> --- a/Documentation/config/fetch.txt
> +++ b/Documentation/config/fetch.txt
> @@ -104,3 +104,11 @@ fetch.bundleURI::
>  	first running `git fetch --bundle-uri=<uri>` immediately before
>  	`git fetch <args>`. See details of the `--bundle-uri` option in
>  	linkgit:git-fetch[1].
> +
> +fetch.bundleCreationToken::
> +	When using `fetch.bundleURI` to fetch incrementally from a bundle
> +	list that uses the "creationToken" heuristic, this config value
> +	stores the maximum `creationToken` value of the downloaded bundles.
> +	This value is used to prevent downloading bundles in the future
> +	if the advertised `creationToken` is not strictly larger than this
> +	value.
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 1dbbbb980eb..98655bd6721 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -464,6 +464,8 @@ static int fetch_bundles_by_token(struct repository *r,
>  {
>  	int cur;
>  	int pop_or_push = 0;
> +	const char *creationTokenStr;
> +	uint64_t maxCreationToken;
>  	struct bundle_list_context ctx = {
>  		.r = r,
>  		.list = list,
> @@ -477,8 +479,27 @@ static int fetch_bundles_by_token(struct repository *r,
>  
>  	for_all_bundles_in_list(list, insert_bundle, &sorted);
>  
> +	if (!sorted.nr) {
> +		free(sorted.items);
> +		return 0;
> +	}

This check is added here because we're only now at risk for an invalid
access to 'sorted' (checking 'sorted.items[0]' below).

> +
>  	QSORT(sorted.items, sorted.nr, compare_creation_token);
>  
> +	/*
> +	 * If fetch.bundleCreationToken exists, parses to a uint64t, and
> +	 * is not strictly smaller than the maximum creation token in the
> +	 * bundle list, then do not download any bundles.
> +	 */
> +	if (!repo_config_get_value(r,
> +				   "fetch.bundlecreationtoken",
> +				   &creationTokenStr) &&
> +	    sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) == 1 &&
> +	    sorted.items[0]->creationToken <= maxCreationToken) {
> +		free(sorted.items);
> +		return 0;
> +	}

And here, we exit if the cached creation token is greater than or equal to
the highest advertised token. Overall, this seems pretty safe:

- If the value is (somehow) manually updated to something larger than it
  should be, objects will be fetched from the server that could have
  otherwise come from a bundle. Not ideal, but no worse than a regular
  fetch.
- If the value is too small or invalid (i.e., not an unsigned integer),
  we'll download the first bundle, unbundle it, then overwrite the invalid
  'fetch.bundlecreationtoken' with a new valid one.

The latter is self-correcting, but should the former be documented
somewhere? For example, if someone changes which bundle server they're using
with a repo, the creation token numbering scheme might be completely
different. In that case, a user would probably want to "reset" the
'fetch.bundlecreationtoken' and start fresh with a new bundle list (even if
the recommended method is "manually delete the config key from your repo").

> +
>  	/*
>  	 * Use a stack-based approach to download the bundles and attempt
>  	 * to unbundle them in decreasing order by creation token. If we
> @@ -541,14 +562,24 @@ stack_operation:
>  		cur += pop_or_push;
>  	}
>  
> -	free(sorted.items);
> -
>  	/*
>  	 * We succeed if the loop terminates because 'cur' drops below
>  	 * zero. The other case is that we terminate because 'cur'
>  	 * reaches the end of the list, so we have a failure no matter
>  	 * which bundles we apply from the list.
>  	 */
> +	if (cur < 0) {
> +		struct strbuf value = STRBUF_INIT;
> +		strbuf_addf(&value, "%"PRIu64"", sorted.items[0]->creationToken);
> +		if (repo_config_set_multivar_gently(ctx.r,
> +						    "fetch.bundleCreationToken",
> +						    value.buf, NULL, 0))

Set the new max bundle creation token if the value has been updated (if the
'fetch.bundleCreationToken' was >= the first bundle's token, 'cur' is 0) in
the repository scope (like the cached bundle URI in patch 5 [1]). Looks
good.

[1] https://lore.kernel.org/git/d9c6f50e4f218267c1e8da060ce5b190dc8a709c.1673037405.git.gitgitgadget@gmail.com/

> +			warning(_("failed to store maximum creation token"));
> +
> +		strbuf_release(&value);
> +	}
> +
> +	free(sorted.items);
>  	return cur >= 0;
>  }
>  
> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index 3f4d61a915c..0604d721f1b 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh

It isn't exactly related to this patch, but it looks like the second "clone
bundle list (http, creationToken)" never received any updates to
differentiate it from the first test with that name (I noted the duplicate
name in patch 4 [2]). Is it just a leftover duplicate?

[1] https://lore.kernel.org/git/ede340d1-bce4-0c1d-7afb-4874a67d1803@github.com/

> @@ -455,6 +455,7 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>  		"$HTTPD_URL/smart/fetch.git" fetch-http-4 &&
>  
>  	test_cmp_config -C fetch-http-4 "$HTTPD_URL/bundle-list" fetch.bundleuri &&
> +	test_cmp_config -C fetch-http-4 1 fetch.bundlecreationtoken &&
>  
>  	# The clone should copy two files: the list and bundle-1.
>  	test_bundle_downloaded bundle-list trace-clone.txt &&
> @@ -479,6 +480,8 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>  		refs/heads/left:refs/heads/left \
>  		refs/heads/right:refs/heads/right &&
>  
> +	test_cmp_config -C fetch-http-4 2 fetch.bundlecreationtoken &&
> +
>  	# This fetch should copy two files: the list and bundle-2.
>  	test_bundle_downloaded bundle-list trace1.txt &&
>  	test_bundle_downloaded bundle-2.bundle trace1.txt &&

Verifying the max creation token that's saved - nice!

> @@ -492,6 +495,15 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>  	EOF
>  	test_cmp expect refs &&
>  
> +	# No-op fetch
> +	GIT_TRACE2_EVENT="$(pwd)/trace1b.txt" \
> +		git -C fetch-http-4 fetch origin --no-tags \
> +		refs/heads/left:refs/heads/left \
> +		refs/heads/right:refs/heads/right &&
> +	test_bundle_downloaded bundle-list trace1b.txt &&
> +	! test_bundle_downloaded bundle-1.bundle trace1b.txt &&
> +	! test_bundle_downloaded bundle-2.bundle trace1b.txt &&

Now we make sure we're not downloading that first bundle if it's already
been unbundled.

> +
>  	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
>  	[bundle "bundle-3"]
>  		uri = bundle-3.bundle
> @@ -508,6 +520,8 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>  		git -C fetch-http-4 fetch origin --no-tags \
>  		refs/heads/merge:refs/heads/merge &&
>  
> +	test_cmp_config -C fetch-http-4 4 fetch.bundlecreationtoken &&
> +
>  	# This fetch should copy three files: the list, bundle-3, and bundle-4.
>  	test_bundle_downloaded bundle-list trace2.txt &&
>  	test_bundle_downloaded bundle-4.bundle trace2.txt &&
> @@ -524,7 +538,16 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>  	refs/bundles/left
>  	refs/bundles/merge
>  	EOF
> -	test_cmp expect refs
> +	test_cmp expect refs &&
> +
> +	# No-op fetch
> +	GIT_TRACE2_EVENT="$(pwd)/trace2b.txt" \
> +		git -C fetch-http-4 fetch origin &&
> +	test_bundle_downloaded bundle-list trace2b.txt &&
> +	! test_bundle_downloaded bundle-1.bundle trace2b.txt &&
> +	! test_bundle_downloaded bundle-2.bundle trace2b.txt &&
> +	! test_bundle_downloaded bundle-3.bundle trace2b.txt &&
> +	! test_bundle_downloaded bundle-4.bundle trace2b.txt

And add another no-op fetch - this time, specifically making sure the
downloaded bundles have covered all objects fetched from 'origin'. As with
previous patches, these test updates are quite thorough; nice work!

>  '
>  
>  # Do not add tests here unless they use the HTTP server, as they will

