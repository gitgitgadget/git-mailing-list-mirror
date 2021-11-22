Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC114C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhKVXCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhKVXCv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 18:02:51 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA58C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:59:44 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id a23-20020a62bd17000000b004a3f6892612so6446795pff.22
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=92su55vFS+cNwCaFRH+BtsVr2slo3LZJ44C3wiwzXLE=;
        b=R81eHAWbaUnVLUZ2tOk8jSwHigkyD3U1dCB/5vCZDIQ9ylRCe7+AtnLnOlkwFApquI
         k66ntP2l7UMV8OIFBVLt794UeIzX1ZfcOWrfSvafMLZShYtbjLcWhBfJyhN/XUM5rnwl
         fDwmEQLDfICp485o9WCMQ6qUTEuNLZzKegnwocb0EFRUuOWQcod08QgcQhzjOompCqc4
         K2as4kG6vNh0dxdv7qTpnJnUJyz/EbPpeFnZFZh9RoNgd0pGlvwrefjBCUbBmvCmlbBv
         7Sl3i3TsWTSY4Bvn/cqPE/YgHyo9GwdUSacTbCAOI//dTTw6+VVifVQV5elUfHowzWIE
         WqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=92su55vFS+cNwCaFRH+BtsVr2slo3LZJ44C3wiwzXLE=;
        b=L15VssH/tFXuyrWPv9FQ4vQlzZI7mGtZneCOjMMRhFevYGA5RYSjASks10X+qnVwyD
         7Q8vm6abfC9nNoBmd7PjkxmzxvEhIsHQcpqDVuSTIRjvb1Jf3LiJbI23UaGwDWHzbUuG
         nUCFlUoZSN6AZ5UG0uQaOcL13zhJRW1w2aD/GyRPP4G4kTouIdDN8dGiBsTWDVRtCQke
         mbacEIfrKQWVqJomtcU8xbljo6le3PHdFoE0ecJBhnwuka/sRaD9WrZQ3gEF7ASnJKJo
         YADqcqTmoV+ux4yiT6vj5LuHF6w0pUCrUY4QrGap52K6qyWyB7tdMY3MBpq5UylOoP4m
         zI6Q==
X-Gm-Message-State: AOAM532HiMHxzcsUbPIZLDumbxZivYs0Wb/LrrSCgksgIT8JSfRPM8q7
        lPKOhrUiEXkdWmNo8XqxVDIvVbc+yVH6qw==
X-Google-Smtp-Source: ABdhPJyVy2gsO7BbF6twVE6xdoAnkVGp96GvbpRddWjpqoyhZ+mHSfeTJA3GLrQENRy28E7cKXYU4WdP7lPhEg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:284f:: with SMTP id
 p15mr2391pjf.1.1637621983000; Mon, 22 Nov 2021 14:59:43 -0800 (PST)
Date:   Mon, 22 Nov 2021 14:59:41 -0800
In-Reply-To: <1c1a07a0b65d4bbbb0f2628a3ddf1980e37d5065.1637020610.git.jonathantanmy@google.com>
Message-Id: <kl6lilwjre3m.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
 <cover.1637020610.git.jonathantanmy@google.com> <1c1a07a0b65d4bbbb0f2628a3ddf1980e37d5065.1637020610.git.jonathantanmy@google.com>
Subject: Re: [PATCH v3 2/2] config: include file if remote URL matches a glob
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, emilyshaffer@google.com,
        peff@peff.net, avarab@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +`hasremoteurl`::
> +	The data that follows the keyword `hasremoteurl:` is taken to
> +	be a pattern with standard globbing wildcards and two
> +	additional ones, `**/` and `/**`, that can match multiple
> +	components. The rest of the config files will be scanned for
> +	remote URLs, and then if there at least one remote URL that

  if there {is,exists}* at least one remote URL that

> +	matches this pattern, the include condition is met.
> ++
> +Files included by this option (directly or indirectly) are not allowed
> +to contain remote URLs.

As Jeff mentioned earlier in this thread, this "last-config-wins" is a
pretty big exception to the existing semantics, as
Documentation/config.txt reads:

  The contents of the included file are inserted immediately, as if they
  had been found at the location of the include directive.

At minimum, I think we should call out this exception in
Documentation/config.txt and the commit message, but calling out *just*
hasremoteurl makes this exception seem like a strange anomaly at first
glance, even though we actually have a good idea of when and why we are
doing this (which is that it simplifies includes that rely on config
values).

I was a big fan of your includeIfDeferred proposal, and I still think
that it's easier for users to understand if we explicitly require
"includeIfDeferred" instead of counting on them to remember when
"includeIf" behaves as it always did vs this new 'deferred' behavior.
That said, I doubt most users actually rely on the inclusion order, and 
I am ok with this approach as long as we document the different
inclusion order.


> +static void populate_remote_urls(struct config_include_data *inc)
> +{
> +	struct config_options opts;
> +
> +	struct config_source *store_cf = cf;
> +	struct key_value_info *store_kvi = current_config_kvi;
> +	enum config_scope store_scope = current_parsing_scope;
> +
> +	opts = *inc->opts;
> +	opts.unconditional_remote_url = 1;
> +
> +	cf = NULL;
> +	current_config_kvi = NULL;
> +	current_parsing_scope = 0;
> +
> +	inc->remote_urls = xmalloc(sizeof(*inc->remote_urls));
> +	string_list_init_dup(inc->remote_urls);
> +	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
> +
> +	cf = store_cf;
> +	current_config_kvi = store_kvi;
> +	current_parsing_scope = store_scope;
> +}

The algorithm is easy to understand and reuses config_with_options(),
which is great.

> +static int forbid_remote_url(const char *var, const char *value, void *data)
> +{
> +	const char *remote_name;
> +	size_t remote_name_len;
> +	const char *key;
> +
> +	if (!parse_config_key(var, "remote", &remote_name, &remote_name_len,
> +			      &key) &&
> +	    remote_name &&
> +	    !strcmp(key, "url"))
> +		die(_("remote URLs cannot be configured in file directly or indirectly included by includeIf.hasremoteurl"));
> +	return 0;
> +}
> +
> +static int at_least_one_url_matches_glob(const char *glob, int glob_len,
> +					 struct string_list *remote_urls)
> +{
> +	struct strbuf pattern = STRBUF_INIT;
> +	struct string_list_item *url_item;
> +	int found = 0;
> +
> +	strbuf_add(&pattern, glob, glob_len);
> +	for_each_string_list_item(url_item, remote_urls) {
> +		if (!wildmatch(pattern.buf, url_item->string, WM_PATHNAME)) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +	strbuf_release(&pattern);
> +	return found;
> +}
> +
>  static int git_config_include(const char *var, const char *value, void *data)
>  {
>  	struct config_include_data *inc = data;
>  	const char *cond, *key;
>  	size_t cond_len;
> -	int ret;
> +	int ret = 0;
>  
>  	/*
>  	 * Pass along all values, including "include" directives; this makes it
> @@ -335,9 +412,29 @@ static int git_config_include(const char *var, const char *value, void *data)
>  		ret = handle_path_include(value, inc);
>  
>  	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
> -	    (cond && include_condition_is_true(inc->opts, cond, cond_len)) &&
> -	    !strcmp(key, "path"))
> -		ret = handle_path_include(value, inc);
> +	    cond && !strcmp(key, "path")) {
> +		const char *url;
> +		size_t url_len;
> +
> +		if (skip_prefix_mem(cond, cond_len, "hasremoteurl:", &url,
> +				    &url_len)) {
> +			if (inc->opts->unconditional_remote_url) {
> +				config_fn_t old_fn = inc->fn;
> +
> +				inc->fn = forbid_remote_url;

When unconditional_remote_url is true, we forbid remote urls in the
included files as expected, but...

> +				ret = handle_path_include(value, inc);
> +				inc->fn = old_fn;
> +			} else {
> +				if (!inc->remote_urls)
> +					populate_remote_urls(inc);
> +				if (at_least_one_url_matches_glob(
> +						url, url_len, inc->remote_urls))
> +					ret = handle_path_include(value, inc);
> +			}
> +		} else if (include_condition_is_true(inc->opts, cond, cond_len)) {
> +			ret = handle_path_include(value, inc);
> +		}
> +	}
>  
>  	return ret;
>  }

It's not clear to me whether we are forbidding the remote urls correctly
when uncondition_remote_url is false. I would be convinced if we had
tests that convered this behavior, but I did not find any such test
cases.

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 9ff46f3b04..9daab4c6da 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -2387,4 +2387,104 @@ test_expect_success '--get and --get-all with --fixed-value' '
>  	test_must_fail git config --file=config --get-regexp --fixed-value fixed+ non-existent
>  '
>  
> +test_expect_success 'includeIf.hasremoteurl' '
> +	git init hasremoteurlTest &&
> +	test_when_finished "rm -rf hasremoteurlTest" &&
> +
> +	cat >"$(pwd)"/include-this <<-\EOF &&
> +	[user]
> +		this = this-is-included
> +	EOF
> +	cat >"$(pwd)"/dont-include-that <<-\EOF &&
> +	[user]
> +		that = that-is-not-included
> +	EOF
> +	cat >>hasremoteurlTest/.git/config <<-EOF &&
> +	[includeIf "hasremoteurl:foo"]
> +		path = "$(pwd)/include-this"
> +	[includeIf "hasremoteurl:bar"]
> +		path = "$(pwd)/dont-include-that"
> +	[remote "foo"]
> +		url = foo
> +	EOF
> +
> +	echo this-is-included >expect-this &&
> +	git -C hasremoteurlTest config --get user.this >actual-this &&
> +	test_cmp expect-this actual-this &&
> +
> +	test_must_fail git -C hasremoteurlTest config --get user.that
> +'
> +
> +test_expect_success 'includeIf.hasremoteurl respects last-config-wins' '
> +	git init hasremoteurlTest &&
> +	test_when_finished "rm -rf hasremoteurlTest" &&
> +
> +	cat >"$(pwd)"/include-two-three <<-\EOF &&
> +	[user]
> +		two = included-config
> +		three = included-config
> +	EOF
> +	cat >>hasremoteurlTest/.git/config <<-EOF &&
> +	[remote "foo"]
> +		url = foo
> +	[user]
> +		one = main-config
> +		two = main-config
> +	[includeIf "hasremoteurl:foo"]
> +		path = "$(pwd)/include-two-three"
> +	[user]
> +		three = main-config
> +	EOF
> +
> +	echo main-config >expect-main-config &&
> +	echo included-config >expect-included-config &&
> +
> +	git -C hasremoteurlTest config --get user.one >actual &&
> +	test_cmp expect-main-config actual &&
> +
> +	git -C hasremoteurlTest config --get user.two >actual &&
> +	test_cmp expect-included-config actual &&
> +
> +	git -C hasremoteurlTest config --get user.three >actual &&
> +	test_cmp expect-main-config actual
> +'
> +
> +test_expect_success 'includeIf.hasremoteurl globs' '
> +	git init hasremoteurlTest &&
> +	test_when_finished "rm -rf hasremoteurlTest" &&
> +
> +	printf "[user]\ndss = yes\n" >"$(pwd)/double-star-start" &&
> +	printf "[user]\ndse = yes\n" >"$(pwd)/double-star-end" &&
> +	printf "[user]\ndsm = yes\n" >"$(pwd)/double-star-middle" &&
> +	printf "[user]\nssm = yes\n" >"$(pwd)/single-star-middle" &&
> +	printf "[user]\nno = no\n" >"$(pwd)/no" &&
> +
> +	cat >>hasremoteurlTest/.git/config <<-EOF &&
> +	[remote "foo"]
> +		url = https://foo/bar/baz
> +	[includeIf "hasremoteurl:**/baz"]
> +		path = "$(pwd)/double-star-start"
> +	[includeIf "hasremoteurl:**/nomatch"]
> +		path = "$(pwd)/no"
> +	[includeIf "hasremoteurl:https:/**"]
> +		path = "$(pwd)/double-star-end"
> +	[includeIf "hasremoteurl:nomatch:/**"]
> +		path = "$(pwd)/no"

As mentioned above, I would have expected to find test cases that test
whether or not we forbid the remote urls correctly, but the tests are
pretty clear.
