Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA90C46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 20:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjASUeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 15:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjASUeR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 15:34:17 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C829D28B
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 12:34:15 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g23so3376684plq.12
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 12:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oEP3oFAoKUnqxfVf4BOxHmSk2fomZK9Xt7caBjx7Y5o=;
        b=cazheS46nsRKVs0/1fin6T1QkUMgxwoT5a+BGcRezV5748UFiZwnOqC2YNr8ikMLZ0
         EQbSj7Ee9MMeqmtU5i0VMJTH6Ue6Cs5GdyATvb8UEaqwx+ChBn2pvdbV896GExwBJ0dd
         ybZAcJriIf7l99BuQ4AYKl5jIG/tMiN0xi6cV6ujp18iGaCFbHEl8zpS1O5bJRqe7pDW
         QFMnkXyDm7V9UXgJ47TaFnhmMAyGiv3ZXjt87AypcUYetMwDMtRUNmIdVLmNWLQlj9gj
         11POJ9m2sravIXJ1OCM8VSQL0U+BNMpeonxsa3C0lcRa4p3D8KVUHSiIT8AoF6+Dz8GQ
         nc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEP3oFAoKUnqxfVf4BOxHmSk2fomZK9Xt7caBjx7Y5o=;
        b=y7UWrkV9rsPTG6+EY8opGY8Q4C6mUi4AmlsE5Ti9X2jcIcZWCbDrWlICdU+LbotsYN
         vYjtNg30yddx4y2O6hHsUd20hz9IguiL20kCPJZnAjnMv9VHoCT4+Q9KjHeL1umtYmdp
         atmweh2o8VV7juOIu7jZS2HTnqK3ei7i4GOXdS+Xl7OLbwHyEEmazXXtmbzF+bj1PLYm
         ZU1MgPRBAhD20HJnWy45sZq3CtfqNCF3nN1RRcrx+5UtOPJKd0Ni8zfWbh0rQ5OKOhzw
         ojIK+JjF1Urte+G+SPcuVG+l3qnX6lOnCdpzJ9lYK8dl9mH7azWLSZcoicpm5kLZyO8V
         FYJA==
X-Gm-Message-State: AFqh2krMGXnuWKCU9xsTEJB3Fx8SlcvQvAvcTAGizw6aSbeWbsLMHkAB
        FeJrPBj3pmsck/REDB2oKg4e
X-Google-Smtp-Source: AMrXdXuggfK4QroSoFwQqp0esMRThYYOrNoth48xNMnDs3YvwlscUOz7UtMOB1HRfWTaKnkb7De67Q==
X-Received: by 2002:a17:90b:3586:b0:229:772c:a00b with SMTP id mm6-20020a17090b358600b00229772ca00bmr12137153pjb.14.1674160455375;
        Thu, 19 Jan 2023 12:34:15 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id x8-20020a17090a0bc800b00229bc852468sm90381pjd.0.2023.01.19.12.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 12:34:14 -0800 (PST)
Message-ID: <58269fe6-ebe1-7b12-4cd9-2110a94543e5@github.com>
Date:   Thu, 19 Jan 2023 12:34:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 7/8] fetch: fetch from an external bundle URI
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <1627fc158b1e301a1663e24f9f21268b4f1caa55.1673037405.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <1627fc158b1e301a1663e24f9f21268b4f1caa55.1673037405.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> When a user specifies a URI via 'git clone --bundle-uri', that URI may
> be a bundle list that advertises a 'bundle.heuristic' value. In that
> case, the Git client stores a 'fetch.bundleURI' config value storing
> that URI.
> 
> Teach 'git fetch' to check for this config value and download bundles
> from that URI before fetching from the Git remote(s). Likely, the bundle
> provider has configured a heuristic (such as "creationToken") that will
> allow the Git client to download only a portion of the bundles before
> continuing the fetch.
> 
> Since this URI is completely independent of the remote server, we want
> to be sure that we connect to the bundle URI before creating a
> connection to the Git remote. We do not want to hold a stateful
> connection for too long if we can avoid it.
> 
> To test that this works correctly, extend the previous tests that set
> 'fetch.bundleURI' to do follow-up fetches. The bundle list is updated
> incrementally at each phase to demonstrate that the heuristic avoids
> downloading older bundles. This includes the middle fetch downloading
> the objects in bundle-3.bundle from the Git remote, and therefore not
> needing that bundle in the third fetch.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/fetch.c             |  8 +++++
>  t/t5558-clone-bundle-uri.sh | 59 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 7378cafeec9..fbb1d470c38 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -29,6 +29,7 @@
>  #include "commit-graph.h"
>  #include "shallow.h"
>  #include "worktree.h"
> +#include "bundle-uri.h"
>  
>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>  
> @@ -2109,6 +2110,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
>  int cmd_fetch(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
> +	const char *bundle_uri;
>  	struct string_list list = STRING_LIST_INIT_DUP;
>  	struct remote *remote = NULL;
>  	int result = 0;
> @@ -2194,6 +2196,12 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	if (dry_run)
>  		write_fetch_head = 0;
>  
> +	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri) &&
> +	    !starts_with(bundle_uri, "remote:")) {

Maybe a silly question, by why would the bundle URI start with 'remote:'
(and why do we silently skip fetching from the URI in that case)?

> +		if (fetch_bundle_uri(the_repository, bundle_uri, NULL))
> +			warning(_("failed to fetch bundles from '%s'"), bundle_uri);
> +	}
> +
>  	if (all) {
>  		if (argc == 1)
>  			die(_("fetch --all does not take a repository argument"));
> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index 8ff560425ee..3f4d61a915c 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -465,6 +465,65 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>  	cat >expect <<-\EOF &&
>  	refs/bundles/base
>  	EOF
> +	test_cmp expect refs &&

At this point in the test, only 'base' is in the cloned repo (equivalent to
the contents of 'bundle-1').

> +
> +	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
> +	[bundle "bundle-2"]
> +		uri = bundle-2.bundle
> +		creationToken = 2
> +	EOF
> +
> +	# Fetch the objects for bundle-2 _and_ bundle-3.
> +	GIT_TRACE2_EVENT="$(pwd)/trace1.txt" \
> +		git -C fetch-http-4 fetch origin --no-tags \
> +		refs/heads/left:refs/heads/left \
> +		refs/heads/right:refs/heads/right &&
> +
> +	# This fetch should copy two files: the list and bundle-2.
> +	test_bundle_downloaded bundle-list trace1.txt &&
> +	test_bundle_downloaded bundle-2.bundle trace1.txt &&
> +	! test_bundle_downloaded bundle-1.bundle trace1.txt &&

Now, with 'bundle-2' in the list, fetch 'left' and 'right'. 'bundle-1' is
not fetched because we already have its contents (in 'base'), 'bundle-2' is
downloaded to get 'left', and 'right' is fetched directly from the repo.

> +
> +	# received left from bundle-2
> +	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	cat >expect <<-\EOF &&
> +	refs/bundles/base
> +	refs/bundles/left
> +	EOF
> +	test_cmp expect refs &&
> +
> +	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
> +	[bundle "bundle-3"]
> +		uri = bundle-3.bundle
> +		creationToken = 3
> +
> +	[bundle "bundle-4"]
> +		uri = bundle-4.bundle
> +		creationToken = 4
> +	EOF
> +
> +	# This fetch should skip bundle-3.bundle, since its objets are

s/objets/objects

> +	# already local (we have the requisite commits for bundle-4.bundle).
> +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
> +		git -C fetch-http-4 fetch origin --no-tags \
> +		refs/heads/merge:refs/heads/merge &&
> +
> +	# This fetch should copy three files: the list, bundle-3, and bundle-4.
> +	test_bundle_downloaded bundle-list trace2.txt &&
> +	test_bundle_downloaded bundle-4.bundle trace2.txt &&
> +	! test_bundle_downloaded bundle-1.bundle trace2.txt &&
> +	! test_bundle_downloaded bundle-2.bundle trace2.txt &&
> +	! test_bundle_downloaded bundle-3.bundle trace2.txt &&

'bundle-3' and 'bundle-4' are then added to the list and we fetch 'merge'.
The repository already has 'base', 'left', and 'right' so we don't need to
download 'bundle-1', 'bundle-2', and 'bundle-3' respectively; 'bundle-4' is
downloaded to get 'merge'.

> +
> +	# received merge ref from bundle-4, but right is missing
> +	# because we did not download bundle-3.
> +	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +
> +	cat >expect <<-\EOF &&
> +	refs/bundles/base
> +	refs/bundles/left
> +	refs/bundles/merge

And this confirms that 'base', 'left', and 'merge' all came from bundles
(and 'right' did not), and everything is working as expected. This is test
is both easy to understand (the comments clearly explain each step without
being overly verbose) and thorough. Looks good!

> +	EOF
>  	test_cmp expect refs
>  '
>  

