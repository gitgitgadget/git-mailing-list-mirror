Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9922C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 23:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359135AbhLBXfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 18:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358920AbhLBXfF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 18:35:05 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DD7C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 15:31:42 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id e7-20020aa798c7000000b004a254db7946so682561pfm.17
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 15:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=izkDYHzSywyCli+HH8bl9sQ1cSYpiNPY4QKlRW2HEsU=;
        b=GJPU76nEUb04aRMu2sGlIb+mcr2Kl5YY1Wry4tnfEX6BDcextWF5+mKiUgcF38SzeE
         EKdDA1XbTevF4Oqni2O3xeVohgtCv/0nuuYsdL80UAOkfBQWmEmIz0esUOi4Fv4d9VJd
         eGG8vpC5NmhCUkWRHgmYMpdf7J9V/zgEJ/ngOYgCcu6I0sJlkdPZvbSpRoCeZFuBEksX
         NUcwFwUwxSvlsRxMqBz1NImiu5i+C9qzUK5Xi7xSR6KAwGOqJkMgNZ2iNbLs7BDeCam8
         P6sFZLvX17gjsS1lsyFxv9OhgISqUHD0jWh/Zt2UU/VzUNUHL60stPeLUn5npvCVDZ0a
         5dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=izkDYHzSywyCli+HH8bl9sQ1cSYpiNPY4QKlRW2HEsU=;
        b=KB54ojUylMG5ktB0AjCYgpxBSH9EQ2z6EX0P5bzYQDEbMAavs//1pwuHHzxEia8KWx
         8MIE1yn9ozaxuLFJbQUTvUXroM6XO0mw5ZXZ3/jnDcmxmEyOz2Vw0s0CDj15XYvQlcMh
         ARu38x/X2Dwlq6XWCSkPALKEqCePU1lUrIrxSz8XgfGZQu/cK4kwPignRIOqUFXlvfmZ
         B4XouaARmpg+CHvEBtmUnivjOIPn5R/cCVjEheUQhTlHm0dXOvX5BGugO3pD3OMPanBw
         szLwiU/uqySpxZxgJZBBfcuEkx3hZ+76VSWC5q47MFM8n13YORKx4H9Q8ET/OKDlBM6d
         WdUg==
X-Gm-Message-State: AOAM533nfmk8ClbjDU5KsHrMHZiZo/+cX6HxVDrv8rhuDKHSnw6oYTv5
        wADgvlTL3nkBefFhg/gF8apv3lObmDD7KO2vyOPf5IOaet9xTIwkKB921P//vJq+8m1VK6tgFKB
        y3+PH61aR4p+T3C9hszbcphwWmnQjxzXfxQ4B7Y+kce8gjT1k/sUtuwB8fqndHuMWzwY2Ilr67i
        LV
X-Google-Smtp-Source: ABdhPJxvDREIuK6T5uxYHrzHspYSKRDDA0QlVH+TuwK/+o1XdN9sWgy3gyb/SaC+1kZo4NMwZcyi3ExXCyjLu3X1QaLR
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:1293:: with SMTP id
 fw19mr9555555pjb.155.1638487901881; Thu, 02 Dec 2021 15:31:41 -0800 (PST)
Date:   Thu,  2 Dec 2021 15:31:36 -0800
In-Reply-To: <cover.1634077795.git.jonathantanmy@google.com>
Message-Id: <cover.1638487815.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v5 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chooglen@google.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Junio, for your comments. I think the code is more clearly laid                                  
out now.                                                                                                 
                                                                                                         
The main changes from v4 are that I've maintained the existing code
structure more, and changed the keyword used to something that hopefully
will be more forwards compatible. I've also updated the documentation to
explain the forwards compatibility idea.

Jonathan Tan (2):
  config: make git_config_include() static
  config: include file if remote URL matches a glob

 Documentation/config.txt |  16 +++++
 config.c                 | 134 +++++++++++++++++++++++++++++++++++----
 config.h                 |  46 ++++----------
 t/t1300-config.sh        | 118 ++++++++++++++++++++++++++++++++++
 4 files changed, 270 insertions(+), 44 deletions(-)

Range-diff against v4:
1:  b2dcae03ed = 1:  b2dcae03ed config: make git_config_include() static
2:  3b3af0da98 ! 2:  d3b8e00717 config: include file if remote URL matches a glob
    @@ Documentation/config.txt: all branches that begin with `foo/`. This is useful if
      organized hierarchically and you would like to apply a configuration to
      all the branches in that hierarchy.
      
    -+`hasremoteurl`::
    -+	The data that follows the keyword `hasremoteurl:` is taken to
    ++`hasconfig:remote.*.url:`::
    ++	The data that follows this keyword is taken to
     +	be a pattern with standard globbing wildcards and two
     +	additional ones, `**/` and `/**`, that can match multiple
     +	components. The first time this keyword is seen, the rest of
    @@ Documentation/config.txt: all branches that begin with `foo/`. This is useful if
     ++
     +Files included by this option (directly or indirectly) are not allowed
     +to contain remote URLs.
    +++
    ++This keyword is designed to be forwards compatible with a naming
    ++scheme that supports more variable-based include conditions, but
    ++currently Git only supports the exact keyword described above.
     +
      A few more notes on matching via `gitdir` and `gitdir/i`:
      
    @@ config.c: struct config_include_data {
      };
      #define CONFIG_INCLUDE_INIT { 0 }
      
    -@@ config.c: static int include_condition_is_true(const struct config_options *opts,
    - 	return 0;
    +@@ config.c: static int include_by_branch(const char *cond, size_t cond_len)
    + 	return ret;
      }
      
    +-static int include_condition_is_true(const struct config_options *opts,
     +static int add_remote_url(const char *var, const char *value, void *data)
     +{
     +	struct string_list *remote_urls = data;
    @@ config.c: static int include_condition_is_true(const struct config_options *opts
     +			      &key) &&
     +	    remote_name &&
     +	    !strcmp(key, "url"))
    -+		die(_("remote URLs cannot be configured in file directly or indirectly included by includeIf.hasremoteurl"));
    ++		die(_("remote URLs cannot be configured in file directly or indirectly included by includeIf.hasconfig:remote.*.url"));
     +	return 0;
     +}
     +
    @@ config.c: static int include_condition_is_true(const struct config_options *opts
     +	return found;
     +}
     +
    - static int git_config_include(const char *var, const char *value, void *data)
    ++static int include_condition_is_true(struct config_include_data *inc,
    + 				     const char *cond, size_t cond_len)
      {
    - 	struct config_include_data *inc = data;
    - 	const char *cond, *key;
    - 	size_t cond_len;
    --	int ret;
    -+	int ret = 0;
    ++	const struct config_options *opts = inc->opts;
    + 
    +-	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
    ++	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len)) {
    + 		return include_by_gitdir(opts, cond, cond_len, 0);
    +-	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
    ++	} else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len)) {
    + 		return include_by_gitdir(opts, cond, cond_len, 1);
    +-	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
    ++	} else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len)) {
    + 		return include_by_branch(cond, cond_len);
    ++	} else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
    ++				   &cond_len)) {
    ++		if (inc->opts->unconditional_remote_url)
    ++			return 1;
    ++		if (!inc->remote_urls)
    ++			populate_remote_urls(inc);
    ++		return at_least_one_url_matches_glob(cond, cond_len,
    ++						     inc->remote_urls);
    ++	}
      
    - 	/*
    - 	 * Pass along all values, including "include" directives; this makes it
    + 	/* unknown conditionals are always false */
    + 	return 0;
     @@ config.c: static int git_config_include(const char *var, const char *value, void *data)
      		ret = handle_path_include(value, inc);
      
      	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
     -	    (cond && include_condition_is_true(inc->opts, cond, cond_len)) &&
     -	    !strcmp(key, "path"))
    --		ret = handle_path_include(value, inc);
    -+	    cond && !strcmp(key, "path")) {
    -+		const char *url;
    -+		size_t url_len;
    -+
    -+		if (skip_prefix_mem(cond, cond_len, "hasremoteurl:", &url,
    -+				    &url_len)) {
    -+			if (inc->opts->unconditional_remote_url) {
    -+				config_fn_t old_fn = inc->fn;
    -+
    -+				inc->fn = forbid_remote_url;
    -+				ret = handle_path_include(value, inc);
    -+				inc->fn = old_fn;
    -+			} else {
    -+				if (!inc->remote_urls)
    -+					populate_remote_urls(inc);
    -+				if (at_least_one_url_matches_glob(
    -+						url, url_len, inc->remote_urls))
    -+					ret = handle_path_include(value, inc);
    -+			}
    -+		} else if (include_condition_is_true(inc->opts, cond, cond_len)) {
    -+			ret = handle_path_include(value, inc);
    -+		}
    ++	    cond && include_condition_is_true(inc, cond, cond_len) &&
    ++	    !strcmp(key, "path")) {
    ++		config_fn_t old_fn = inc->fn;
    ++
    ++		if (inc->opts->unconditional_remote_url)
    ++			inc->fn = forbid_remote_url;
    + 		ret = handle_path_include(value, inc);
    ++		if (inc->opts->unconditional_remote_url)
    ++			inc->fn = old_fn;
     +	}
      
      	return ret;
    @@ config.h: struct config_options {
     +
     +	/*
     +	 * For internal use. Include all includeif.hasremoteurl paths without
    -+	 * checking if the repo has that remote URL.
    ++	 * checking if the repo has that remote URL, and when doing so, verify
    ++	 * that files included in this way do not configure any remote URLs
    ++	 * themselves.
     +	 */
     +	unsigned int unconditional_remote_url : 1;
     +
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
      	test_must_fail git config --file=config --get-regexp --fixed-value fixed+ non-existent
      '
      
    -+test_expect_success 'includeIf.hasremoteurl' '
    ++test_expect_success 'includeIf.hasconfig:remote.*.url' '
     +	git init hasremoteurlTest &&
     +	test_when_finished "rm -rf hasremoteurlTest" &&
     +
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
     +		that = that-is-not-included
     +	EOF
     +	cat >>hasremoteurlTest/.git/config <<-EOF &&
    -+	[includeIf "hasremoteurl:foo"]
    ++	[includeIf "hasconfig:remote.*.url:foo"]
     +		path = "$(pwd)/include-this"
    -+	[includeIf "hasremoteurl:bar"]
    ++	[includeIf "hasconfig:remote.*.url:bar"]
     +		path = "$(pwd)/dont-include-that"
     +	[remote "foo"]
     +		url = foo
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
     +	test_must_fail git -C hasremoteurlTest config --get user.that
     +'
     +
    -+test_expect_success 'includeIf.hasremoteurl respects last-config-wins' '
    ++test_expect_success 'includeIf.hasconfig:remote.*.url respects last-config-wins' '
     +	git init hasremoteurlTest &&
     +	test_when_finished "rm -rf hasremoteurlTest" &&
     +
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
     +	[user]
     +		one = main-config
     +		two = main-config
    -+	[includeIf "hasremoteurl:foo"]
    ++	[includeIf "hasconfig:remote.*.url:foo"]
     +		path = "$(pwd)/include-two-three"
     +	[user]
     +		three = main-config
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
     +	test_cmp expect-main-config actual
     +'
     +
    -+test_expect_success 'includeIf.hasremoteurl globs' '
    ++test_expect_success 'includeIf.hasconfig:remote.*.url globs' '
     +	git init hasremoteurlTest &&
     +	test_when_finished "rm -rf hasremoteurlTest" &&
     +
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
     +	cat >>hasremoteurlTest/.git/config <<-EOF &&
     +	[remote "foo"]
     +		url = https://foo/bar/baz
    -+	[includeIf "hasremoteurl:**/baz"]
    ++	[includeIf "hasconfig:remote.*.url:**/baz"]
     +		path = "$(pwd)/double-star-start"
    -+	[includeIf "hasremoteurl:**/nomatch"]
    ++	[includeIf "hasconfig:remote.*.url:**/nomatch"]
     +		path = "$(pwd)/no"
    -+	[includeIf "hasremoteurl:https:/**"]
    ++	[includeIf "hasconfig:remote.*.url:https:/**"]
     +		path = "$(pwd)/double-star-end"
    -+	[includeIf "hasremoteurl:nomatch:/**"]
    ++	[includeIf "hasconfig:remote.*.url:nomatch:/**"]
     +		path = "$(pwd)/no"
    -+	[includeIf "hasremoteurl:https:/**/baz"]
    ++	[includeIf "hasconfig:remote.*.url:https:/**/baz"]
     +		path = "$(pwd)/double-star-middle"
    -+	[includeIf "hasremoteurl:https:/**/nomatch"]
    ++	[includeIf "hasconfig:remote.*.url:https:/**/nomatch"]
     +		path = "$(pwd)/no"
    -+	[includeIf "hasremoteurl:https://*/bar/baz"]
    ++	[includeIf "hasconfig:remote.*.url:https://*/bar/baz"]
     +		path = "$(pwd)/single-star-middle"
    -+	[includeIf "hasremoteurl:https://*/baz"]
    ++	[includeIf "hasconfig:remote.*.url:https://*/baz"]
     +		path = "$(pwd)/no"
     +	EOF
     +
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
     +	test_must_fail git -C hasremoteurlTest config --get user.no
     +'
     +
    -+test_expect_success 'includeIf.hasremoteurl forbids remote url in such included files' '
    ++test_expect_success 'includeIf.hasconfig:remote.*.url forbids remote url in such included files' '
     +	git init hasremoteurlTest &&
     +	test_when_finished "rm -rf hasremoteurlTest" &&
     +
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
     +		url = bar
     +	EOF
     +	cat >>hasremoteurlTest/.git/config <<-EOF &&
    -+	[includeIf "hasremoteurl:foo"]
    ++	[includeIf "hasconfig:remote.*.url:foo"]
     +		path = "$(pwd)/include-with-url"
     +	EOF
     +
     +	# test with any Git command
     +	test_must_fail git -C hasremoteurlTest status 2>err &&
    -+	grep "fatal: remote URLs cannot be configured in file directly or indirectly included by includeIf.hasremoteurl" err
    ++	grep "fatal: remote URLs cannot be configured in file directly or indirectly included by includeIf.hasconfig:remote.*.url" err
     +'
     +
      test_done
-- 
2.34.1.400.ga245620fadb-goog

