Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3731F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 22:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbeJMGBt (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 02:01:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39818 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeJMGBt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 02:01:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so6853842pfe.6
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OvF0YyIbENXa0TAGXALIv7meNIY8EwNF1QDAAiIMf/Y=;
        b=CnX4XLeQckDGZJG6SPu7pbVXmHMyjUTU0r8PX5ghqQLp12OFvcm2UfB+AyGEtlVg9q
         i3b8tcF4u2ireoAAjDa0ALHMpq55ivypg/I4mnNVjO5Y0lNpo6jKQToaliidOubJZOZJ
         jl7XDTTVB1RGsB99K8xAaCpcaT1ozxeEPFBUObjMuQJA4+tRt+KlrCxQmMVqoyAzYKLT
         Qx8Au6Yg6f/HBAfRauSJD9b9/Ns7VPNn1vMoDwyjs0+jOT0cwQvq+5AXaL18r9S9INVK
         ihZaKTZDxAueODrNoY0M6T7J67OQ67Fmhk13Oh/t3ZoxNMoC6WVXmwWsUeDy0XZBzgcP
         qdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OvF0YyIbENXa0TAGXALIv7meNIY8EwNF1QDAAiIMf/Y=;
        b=hOPDMMgaXTB1eNO0aFJMjjAmoQkbGmMlrSepYWjbPyhrmGt3HEl98BgdQ5QJA4jxDe
         OhloGoG/Kl7C7B6+cAWliqzR6of38oJaWG/SnKKQzyM1qjczGfibKgCaZmYt7pGRFOV/
         +GISK8wG0Nn7t+yubA7C+78jH+YnyOV7Z0A9Na8NVLiQfeAWYAneKjDEt4f+nxqFvUM8
         6DJWyylY4w1TUECyKbnpv2UzwT39aQXyxook66OvQCRYMvwgMhENDAESs9SluSwwOtix
         VMuwB+wm3OgNq68OlYcMhlnzRZRsUJT1q9jldkNMU/sgUajFdPFpanK3tsznRovtRffB
         TEmA==
X-Gm-Message-State: ABuFfojkhu3l8cUX3QUyczoubYRz6LmfV/lvqGcoZugNwbsQIZioK+DS
        5iUSejw6JciMMqUrJn5AePs=
X-Google-Smtp-Source: ACcGV61jc7TrqZqmN3olE+SiSSwRxkv74dmrYA2Bg9bCa62F/L3HYatDSr9Pk6bkemeH9KfSyQl03g==
X-Received: by 2002:a63:5e01:: with SMTP id s1-v6mr7010236pgb.92.1539383235359;
        Fri, 12 Oct 2018 15:27:15 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id k86-v6sm3389023pfb.167.2018.10.12.15.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 15:27:14 -0700 (PDT)
Date:   Fri, 12 Oct 2018 15:27:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Jaewoong Jung <jungjw@google.com>
Subject: Re: [PATCH] submodule helper: convert relative URL to absolute URL
 if needed
Message-ID: <20181012222712.GC52080@aiede.svl.corp.google.com>
References: <20181012215314.44266-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012215314.44266-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> The submodule helper update_clone called by "git submodule update",
> clones submodules if needed. As submodules used to have the URL indicating
> if they were active, the step to resolve relative URLs was done in the
> "submodule init" step. Nowadays submodules can be configured active without
> calling an explicit init, e.g. via configuring submodule.active.
>
> Then we'll fallback to the URL found in the .gitmodules, which may be
> relative to the superproject, but we do not resolve it, yet.

Oh!  Good catch.

> To do so, factor out the function that resolves the relative URLs in
> "git submodule init" (in the submodule helper in the init_submodule
> function) and cal it at the appropriate place in the update_clone helper.

s/cal/call/

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 48 ++++++++++++++++++++++++-------------
>  t/t7400-submodule-basic.sh  | 24 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 17 deletions(-)

What is the symptom when this fails?

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f6fb8991f3..a9a3ac38be 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -584,6 +584,27 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +
> +char *compute_submodule_clone_url(const char *rel_url)

Should be static.

Is the caller responsible for freeing the returned buffer?

> +{
> +	char *remoteurl, *relurl;
> +	char *remote = get_default_remote();
> +	struct strbuf remotesb = STRBUF_INIT;

optional: could rename, something like

	struct strbuf key = STRBUF_INIT;

	remote = get_default_remote();
	strbuf_addf(&key, "remote.%s.url", remote);

 [...]
	strbuf_release(&key);
	free(remote);
	return result;


> +
> +	strbuf_addf(&remotesb, "remote.%s.url", remote);
> +	free(remote);
> +
> +	if (git_config_get_string(remotesb.buf, &remoteurl)) {
> +		warning(_("could not lookup configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);

nit: lookup is the noun, "look up" is the verb

> +		remoteurl = xgetcwd();
> +	}
> +	relurl = relative_url(remoteurl, rel_url, NULL);
> +	strbuf_release(&remotesb);
> +	free(remoteurl);
> +
> +	return relurl;
> +}
> +
>  struct init_cb {
>  	const char *prefix;
>  	unsigned int flags;
> @@ -634,21 +655,9 @@ static void init_submodule(const char *path, const char *prefix,
>  		/* Possibly a url relative to parent */
>  		if (starts_with_dot_dot_slash(url) ||
>  		    starts_with_dot_slash(url)) {
> -			char *remoteurl, *relurl;
> -			char *remote = get_default_remote();
> -			struct strbuf remotesb = STRBUF_INIT;
> -			strbuf_addf(&remotesb, "remote.%s.url", remote);
> -			free(remote);
> -
> -			if (git_config_get_string(remotesb.buf, &remoteurl)) {
> -				warning(_("could not lookup configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
> -				remoteurl = xgetcwd();
> -			}
> -			relurl = relative_url(remoteurl, url, NULL);
> -			strbuf_release(&remotesb);
> -			free(remoteurl);
> -			free(url);
> -			url = relurl;

Ah, this is moved code. I should have used --color-moved. ;-)

> +			char *to_free = url;
> +			url = compute_submodule_clone_url(url);
> +			free(to_free);

Maybe:

			char *old_url = url;
			url = ...(old_url);
			free(old_url);

>  		}
>  
>  		if (git_config_set_gently(sb.buf, url))
> @@ -1562,8 +1571,13 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>  
>  	strbuf_reset(&sb);
>  	strbuf_addf(&sb, "submodule.%s.url", sub->name);
> -	if (repo_config_get_string_const(the_repository, sb.buf, &url))
> -		url = sub->url;
> +	if (repo_config_get_string_const(the_repository, sb.buf, &url)) {
> +		if (starts_with_dot_slash(sub->url) ||
> +		    starts_with_dot_dot_slash(sub->url))
> +			url = compute_submodule_clone_url(sub->url);
> +		else
> +			url = sub->url;
> +	}

Nice.

>  
>  	strbuf_reset(&sb);
>  	strbuf_addf(&sb, "%s/.git", ce->name);
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index c0ffc1022a..3f5dd5e4ef 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1224,6 +1224,30 @@ test_expect_success 'submodule update and setting submodule.<name>.active' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'clone active submodule without submodule url set' '

Thanks for the test \o/.

> +	test_when_finished "rm -rf test/test" &&
> +	mkdir test &&
> +	# another dir breaks accidental relative paths still being correct
> +	git clone file://"$pwd"/multisuper test/test &&
> +	(
> +		cd test/test &&
> +		git config submodule.active "." &&
> +
> +		# do not pass --init flag, as it is already active:

What does "it" refer to here?

> +		git submodule update &&
> +		git submodule status >actual_raw &&
> +
> +		cut -c 1,43- actual_raw >actual &&
> +		cat >expect <<-\EOF &&
> +		 sub0 (test2)
> +		 sub1 (test2)
> +		 sub2 (test2)
> +		 sub3 (test2)
> +		EOF
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success 'clone --recurse-submodules with a pathspec works' '
>  	test_when_finished "rm -rf multisuper_clone" &&
>  	cat >expected <<-\EOF &&

Thanks for the quick fix.

Jonathan
