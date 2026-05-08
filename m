Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D403A3E99
	for <git@vger.kernel.org>; Fri,  8 May 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280733; cv=none; b=UN9blWgsWSTOEs7yFHH32rP/UJMj45Ff4W+6/3stVnBRUWkkjoqDq9wkp/gycAywLIEUbZJFoNVIAuTyBKJ3R/ddfEUx40HQnnQzmkvQ42Y8WLsugm5ESFSTc2VzoDG3CoT47QAokpGmBt7lOYOGcOZGBDfNmc3xIl5GxZiHuko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280733; c=relaxed/simple;
	bh=TkTRNIHU/DRYPsxvpf5tm9IP+Jkb/GwBZ9bW7DY+hpI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FidJb89N9Uk+v1P65Ap/SATGTrRRH8ZJ4fTYXTVDT/pT+JiU2VkueEQ7Ck/Z7We9JR2C6DhZN9wjzmaH26w7+WKnFjsZw9Hp9oz+ocExx7vi7yoj1JP32rTuzcSiBdSqd7sm5aMQbHmSqME9b/lr2kqJhvXnINp88D65GQvyJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aubgiVW1; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aubgiVW1"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so26124306d6.1
        for <git@vger.kernel.org>; Fri, 08 May 2026 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778280729; x=1778885529; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DGZ9A6QyqUPM9ONQx8XRqHnac9Hh3PKFLe3bjP5uRI=;
        b=aubgiVW1iS+I6kOWXg8r7HiY9MvvHUE1wrjJVjSB61wQwgf2e5uQYvt8LQIpLE6Ytg
         Q11A4LR+c4LfMU1/ORVS+vjikDuo1cX8GS4C9bjrcsGw6wCmuof74v+GSmDB5nx+ACK2
         EGIEp6b6meu+8bXXm1chHY5V0eRnm+9ZKwC/5DSzdWzfrpVPdWmp+zVEfzDMSJmMg51u
         bYbRkKxugpR7bh1lRC42lA7ed1BhYwbMeOlu8TPTrjx1Y2k1/jTqf0YoCLx1GMEoZNur
         HAKGAB3Ydcv2X6h3AxnJvJZEO2E1fTCerBXn1hDvoHm8Tbmut3u1S8FqCvevTuW+b23+
         f7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778280729; x=1778885529;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2DGZ9A6QyqUPM9ONQx8XRqHnac9Hh3PKFLe3bjP5uRI=;
        b=G+O+e2cbUzBINs771i6Am6zxNX8iKABCHBr9dzzEo7ka1XoyxM2crJBX+t5G62DFxc
         R2AL1VcjC6hcllva68vISh4YeVbAixzCAwsc6pQkQqk48e2Td+05cRRAecbTj03SGOwh
         czv1YjANFBlwRTQm0gY925ektW0r/vh/c0oChwqrnuD4Qn6RTJRWjW4lVAg0bEzZvcIb
         Lcg6oqz9o+wHfkkwNpTY3UDPHZUtPKmGJy/HgiYVlLB0Fx1+iWKkUFbCpLsdnHRkqy+j
         8aoJd0xADXAqCQmjJ08Up7g7u522Z2MER0qTnJQdUIzLxdgGCOYzJogqfO3bdPbV+h1I
         9hdA==
X-Gm-Message-State: AOJu0YyjAm9C/zQnq7e0SzyEtw/3eqzDns3oL6+0iGw1XPRBBZboOcMq
	eXc6tb2Pmwmf8SuO28Z6s/v9TLB802YN4mrZA2mFYaPvlCxt060/pwwY3SURig==
X-Gm-Gg: Acq92OHeB58o2AYAbqC4m/BNPEOLK5lbU5PFCheXgpGTfPVPHw2iOu+TyBkHsbct3ZU
	lGlP56fCUFMxXQ99Do5CqFA4dv6WDVdmyD9r4gUjMvHi1Cs74VU+c7nchhK5CEGtT98SNjc5EAR
	HjUrbNZVMXvqf3QEvY2IvcTaKf0hN4N0d9LDZ2UhRZBvblIHc9ita2dXeQDKr2lV8SSz0CyUQuO
	SXL0N+mvLrMCDHY0GEtOQFgP98VI3ihv8bR9p90OjTYAkMs0VyGximxDdfmFPi62135yjOpQJpq
	8rv6SITFp3M0qFIJjBcqs8TmE2KE5r0vti2M1n8Hs6NhEle/jC+T2z85lUrgPAnmv0hy6JNx+E/
	urcTLlXpUmgi8s8pETK1SrRM6Hkzro4c3XOcellbiUJurFYq38VjpxjWgyxfyILthkIR5m6Bux7
	j/72QlY5mFcPDOjUFdwnW2qPzmDrw=
X-Received: by 2002:a05:6214:d48:b0:8a3:8f4c:3b6f with SMTP id 6a1803df08f44-8bf44bf8c35mr66400656d6.51.1778280729214;
        Fri, 08 May 2026 15:52:09 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3aed2cd2sm29535026d6.6.2026.05.08.15.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 15:52:08 -0700 (PDT)
Message-Id: <pull.2281.v7.git.git.1778280727849.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v6.git.git.1777847487823.gitgitgadget@gmail.com>
References: <pull.2281.v6.git.git.1777847487823.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 22:52:07 +0000
Subject: [PATCH v7] checkout: extend --track with a "fetch" mode to refresh
 start-point
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
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Marc Branchaud <marcnarc@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

If you want to fork your topic branch from the very latest of the
tip of a branch your remote has, you would do:

    git fetch origin some-branch
    git checkout -b new_branch --track origin/some-branch

Extend the "--track" option of "git checkout" and allow users to
write

    git checkout -b new_branch --track=fetch origin/some-branch

to (1) fetch 'some-branch' from the remote 'origin', updating the
remote-tracking branch 'origin/some-branch', (2) arrange subsequent
'git pull' on 'new_branch' to interact with 'origin/some-branch' and
(3) fork 'new_branch' from it.

In the value of the '--track' option, 'fetch' can be combined with
the existing 'direct' (default) and 'inherit' modes via a
comma-separated list. Examples:

    git checkout -b new_branch --track=fetch,inherit some_local_branch
    git switch -c new_branch --track=fetch origin/some-branch

When "fetch" is requested and <start-point> is in <remote>/<branch>
form, run "git fetch <remote> <branch>" before resolving the ref, so
that other remote-tracking branches are left untouched. If
<start-point> is a bare remote name like "origin" (which resolves to
that remote's default branch), "git fetch <remote>" is run instead,
since the target branch is not known up front. Abort the checkout if
the fetch fails.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    checkout: add --fetch to fetch remote before resolving start-point
    
     * Reject --track=inherit,direct as mutually exclusive modes.
     * Make repeated --track= last-one-wins: --track=fetch --track=direct
       behaves like --track=direct.
     * On fetch failure, warn and proceed from the existing remote-tracking
       ref instead of aborting (friendlier when offline); only abort when
       there is no existing ref.
     * For --track=fetch <remote>/<branch>, resolve the source ref through
       the configured remote.<name>.fetch refspec so custom refspecs fetch
       the correct ref.
     * For --track=fetch <remote>, read <remote>/HEAD and fetch only that
       branch instead of the whole remote.
     * Tests and docs updated accordingly.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v7
Pull-Request: https://github.com/git/git/pull/2281

Range-diff vs v6:

 1:  1b42c648b9 ! 1:  de375d55f1 checkout: extend --track with a "fetch" mode to refresh start-point
     @@ Documentation/git-checkout.adoc: of it").
       	--track without -b implies branch creation.
       +
      +The argument is a comma-separated list. `direct` (the default) and
     -+`inherit` select the tracking mode. Adding `fetch` requests that the
     -+remote be fetched before _<start-point>_ is resolved, so the new branch
     -+starts from a fresh tip: when _<start-point>_ is in
     -+_<remote>/<branch>_ form, only that branch is updated; when it is a
     -+bare remote name (e.g. `origin`), the whole remote is fetched. If the
     -+fetch fails, the checkout is aborted.
     ++`inherit` select the tracking mode and are mutually exclusive. Adding
     ++`fetch` requests that the remote be fetched before _<start-point>_ is
     ++resolved, so the new branch starts from a fresh tip: when
     ++_<start-point>_ is in _<remote>/<branch>_ form, only that branch is
     ++updated; when _<start-point>_ is a bare remote name (e.g. `origin`),
     ++only the remote's default branch is updated. If the fetch fails and the
     ++corresponding remote-tracking ref already exists, a warning is printed
     ++and the checkout proceeds from the existing tip; otherwise the checkout
     ++is aborted.
      ++
       If no `-b` option is given, the name of the new branch will be
       derived from the remote-tracking branch, by looking at the local part of
     @@ Documentation/git-switch.adoc: should result in deletion of the path).
       	details.
       +
      +The argument is a comma-separated list. `direct` (the default) and
     -+`inherit` select the tracking mode. Adding `fetch` requests that the
     -+remote be fetched before _<start-point>_ is resolved, so the new branch
     -+starts from a fresh tip: when _<start-point>_ is in
     -+_<remote>/<branch>_ form, only that branch is updated; when it is a
     -+bare remote name (e.g. `origin`), the whole remote is fetched. If the
     -+fetch fails, the switch is aborted.
     ++`inherit` select the tracking mode and are mutually exclusive. Adding
     ++`fetch` requests that the remote be fetched before _<start-point>_ is
     ++resolved, so the new branch starts from a fresh tip: when
     ++_<start-point>_ is in _<remote>/<branch>_ form, only that branch is
     ++updated; when _<start-point>_ is a bare remote name (e.g. `origin`),
     ++only the remote's default branch is updated. If the fetch fails and the
     ++corresponding remote-tracking ref already exists, a warning is printed
     ++and the switch proceeds from the existing tip; otherwise the switch is
     ++aborted.
      ++
       If no `-c` option is given, the name of the new branch will be derived
       from the remote-tracking branch, by looking at the local part of the
     @@ Documentation/git-switch.adoc: should result in deletion of the path).
      
       ## builtin/checkout.c ##
      @@
     + #include "preload-index.h"
     + #include "read-cache.h"
     + #include "refs.h"
     ++#include "refspec.h"
     + #include "remote.h"
       #include "repo-settings.h"
       #include "resolve-undo.h"
       #include "revision.h"
     @@ builtin/checkout.c: struct branch_info {
       	char *checkout;
       };
       
     -+static void fetch_remote_for_start_point(const char *arg)
     ++static int resolve_fetch_target(const char *arg, char **remote_out,
     ++				char **src_ref_out)
      +{
      +	const char *slash;
      +	char *remote_name;
      +	struct remote *remote;
     -+	struct child_process cmd = CHILD_PROCESS_INIT;
     ++	struct refspec_item query = { 0 };
     ++	struct strbuf dst = STRBUF_INIT;
     ++	const char *rest;
     ++
     ++	*remote_out = NULL;
     ++	*src_ref_out = NULL;
      +
      +	if (!arg || !*arg)
     -+		return;
     ++		return -1;
      +
      +	slash = strchr(arg, '/');
      +	if (slash == arg)
     -+		return;
     ++		return -1;
      +	remote_name = slash ? xstrndup(arg, slash - arg) : xstrdup(arg);
      +
      +	remote = remote_get(remote_name);
      +	if (!remote || !remote_is_configured(remote, 1)) {
      +		free(remote_name);
     ++		return -1;
     ++	}
     ++
     ++	rest = (slash && slash[1]) ? slash + 1 : NULL;
     ++	if (!rest) {
     ++		struct object_id oid;
     ++		const char *head_target;
     ++		const char *short_target;
     ++
     ++		strbuf_addf(&dst, "refs/remotes/%s/HEAD", remote_name);
     ++		head_target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
     ++						      dst.buf,
     ++						      RESOLVE_REF_READING |
     ++						      RESOLVE_REF_NO_RECURSE,
     ++						      &oid, NULL);
     ++		strbuf_reset(&dst);
     ++		if (head_target &&
     ++		    skip_prefix(head_target, "refs/remotes/", &short_target) &&
     ++		    skip_prefix(short_target, remote_name, &short_target) &&
     ++		    *short_target == '/')
     ++			rest = short_target + 1;
     ++	}
     ++
     ++	if (rest) {
     ++		strbuf_addf(&dst, "refs/remotes/%s/%s", remote_name, rest);
     ++		query.dst = dst.buf;
     ++		if (!remote_find_tracking(remote, &query) && query.src) {
     ++			*src_ref_out = xstrdup(query.src);
     ++			free(query.src);
     ++		} else {
     ++			*src_ref_out = xstrdup(rest);
     ++		}
     ++	}
     ++
     ++	strbuf_release(&dst);
     ++	*remote_out = remote_name;
     ++	return 0;
     ++}
     ++
     ++static void fetch_remote_for_start_point(const char *arg)
     ++{
     ++	char *remote_name = NULL;
     ++	char *src_ref = NULL;
     ++	struct child_process cmd = CHILD_PROCESS_INIT;
     ++	struct strbuf dst_ref = STRBUF_INIT;
     ++	int have_existing_ref = 0;
     ++
     ++	if (resolve_fetch_target(arg, &remote_name, &src_ref))
      +		return;
     ++
     ++	if (src_ref) {
     ++		const char *short_src = src_ref;
     ++		struct object_id oid;
     ++
     ++		skip_prefix(short_src, "refs/heads/", &short_src);
     ++		strbuf_addf(&dst_ref, "refs/remotes/%s/%s", remote_name, short_src);
     ++		if (!refs_read_ref(get_main_ref_store(the_repository),
     ++				   dst_ref.buf, &oid))
     ++			have_existing_ref = 1;
      +	}
      +
      +	strvec_pushl(&cmd.args, "fetch", remote_name, NULL);
     -+	if (slash && slash[1])
     -+		strvec_push(&cmd.args, slash + 1);
     ++	if (src_ref)
     ++		strvec_push(&cmd.args, src_ref);
      +	cmd.git_cmd = 1;
     ++	if (run_command(&cmd)) {
     ++		if (have_existing_ref)
     ++			warning(_("failed to fetch start-point '%s'; "
     ++				  "using existing '%s'"),
     ++				arg, dst_ref.buf);
     ++		else
     ++			die(_("failed to fetch start-point '%s'"), arg);
     ++	}
     ++
      +	free(remote_name);
     -+	if (run_command(&cmd))
     -+		die(_("failed to fetch start-point '%s'"), arg);
     ++	free(src_ref);
     ++	strbuf_release(&dst_ref);
      +}
      +
      +static int parse_opt_checkout_track(const struct option *opt,
     @@ builtin/checkout.c: struct branch_info {
      +	struct checkout_opts *opts = opt->value;
      +	struct string_list tokens = STRING_LIST_INIT_DUP;
      +	struct string_list_item *item;
     ++	int saw_direct = 0, saw_inherit = 0;
      +	int ret = 0;
      +
     ++	opts->fetch = 0;
     ++
      +	if (unset) {
      +		opts->track = BRANCH_TRACK_NEVER;
     -+		opts->fetch = 0;
      +		return 0;
      +	}
      +
     @@ builtin/checkout.c: struct branch_info {
      +		if (!strcmp(item->string, "fetch")) {
      +			opts->fetch = 1;
      +		} else if (!strcmp(item->string, "direct")) {
     ++			saw_direct = 1;
      +			opts->track = BRANCH_TRACK_EXPLICIT;
      +		} else if (!strcmp(item->string, "inherit")) {
     ++			saw_inherit = 1;
      +			opts->track = BRANCH_TRACK_INHERIT;
      +		} else {
      +			ret = error(_("option `%s' expects \"%s\", \"%s\", "
      +				      "or \"%s\""),
      +				    "--track", "direct", "inherit", "fetch");
     -+			break;
     ++			goto out;
      +		}
      +	}
      +
     ++	if (saw_direct && saw_inherit)
     ++		ret = error(_("option `%s' cannot combine \"%s\" and \"%s\""),
     ++			    "--track", "direct", "inherit");
     ++
     ++out:
      +	string_list_clear(&tokens, 0);
      +	return ret;
      +}
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_other)" = "$other_before"
      +'
      +
     -+test_expect_success 'checkout --track=fetch with bare remote name fetches the remote' '
     ++test_expect_success 'checkout --track=fetch with bare remote name fetches only <remote>/HEAD target' '
      +	git checkout main &&
     -+	git -C fetch_upstream checkout -b fetch_new2 &&
     -+	test_commit -C fetch_upstream u_new2 &&
     -+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new2 &&
     ++	git -C fetch_upstream checkout main &&
     ++	git remote set-head fetch_upstream main &&
     ++	git -C fetch_upstream checkout -b fetch_unrelated &&
     ++	test_commit -C fetch_upstream u_unrelated_pre &&
     ++	git fetch fetch_upstream fetch_unrelated &&
     ++	unrelated_before=$(git rev-parse refs/remotes/fetch_upstream/fetch_unrelated) &&
     ++	git -C fetch_upstream checkout main &&
     ++	test_commit -C fetch_upstream u_main_post &&
     ++	git -C fetch_upstream checkout fetch_unrelated &&
     ++	test_commit -C fetch_upstream u_unrelated_post &&
      +	git checkout --track=fetch -b local_from_remote fetch_upstream &&
     -+	git rev-parse --verify refs/remotes/fetch_upstream/fetch_new2
     ++	test_cmp_rev refs/remotes/fetch_upstream/main HEAD &&
     ++	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_unrelated)" = "$unrelated_before"
      +'
      +
     -+test_expect_success 'checkout --track=fetch aborts and does not create branch on fetch failure' '
     ++test_expect_success 'checkout --track=fetch aborts and does not create branch when no existing ref' '
      +	git checkout main &&
      +	test_might_fail git branch -D bogus &&
      +	test_must_fail git checkout --track=fetch -b bogus fetch_upstream/does_not_exist &&
      +	test_must_fail git rev-parse --verify refs/heads/bogus
      +'
      +
     ++test_expect_success 'checkout --track=fetch warns and proceeds when fetch fails but ref exists' '
     ++	git checkout main &&
     ++	git -C fetch_upstream checkout -b fetch_offline &&
     ++	test_commit -C fetch_upstream u_offline &&
     ++	git fetch fetch_upstream fetch_offline &&
     ++	saved_url=$(git config remote.fetch_upstream.url) &&
     ++	test_when_finished "git config remote.fetch_upstream.url \"$saved_url\"" &&
     ++	git config remote.fetch_upstream.url ./does-not-exist &&
     ++	git checkout --track=fetch -b local_offline fetch_upstream/fetch_offline 2>err &&
     ++	test_grep "failed to fetch" err &&
     ++	test_cmp_rev refs/remotes/fetch_upstream/fetch_offline HEAD
     ++'
     ++
     ++test_expect_success 'checkout --track=fetch resolves through configured fetch refspec' '
     ++	git checkout main &&
     ++	git -C fetch_upstream checkout -b fetch_refspec &&
     ++	test_commit -C fetch_upstream u_refspec &&
     ++	git fetch fetch_upstream fetch_refspec &&
     ++	git remote add fetch_custom ./fetch_upstream &&
     ++	test_when_finished "git remote remove fetch_custom" &&
     ++	git config --replace-all remote.fetch_custom.fetch \
     ++		"+refs/heads/*:refs/remotes/custom-ns/*" &&
     ++	git fetch fetch_custom &&
     ++	test_commit -C fetch_upstream u_refspec_post &&
     ++	git checkout --track=fetch -b local_refspec custom-ns/fetch_refspec &&
     ++	test_cmp_rev refs/remotes/custom-ns/fetch_refspec HEAD
     ++'
     ++
     ++test_expect_success 'checkout --track=inherit,direct is rejected' '
     ++	test_must_fail git checkout --track=inherit,direct -b bad fetch_upstream/fetch_new 2>err &&
     ++	test_grep "cannot combine" err
     ++'
     ++
     ++test_expect_success 'checkout --track=fetch then --track=direct drops fetch (last-one-wins)' '
     ++	git checkout main &&
     ++	git -C fetch_upstream checkout -b fetch_lastwin &&
     ++	test_commit -C fetch_upstream u_lastwin &&
     ++	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_lastwin &&
     ++	test_must_fail git checkout --track=fetch --track=direct \
     ++		-b local_lastwin fetch_upstream/fetch_lastwin &&
     ++	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_lastwin
     ++'
     ++
      +test_expect_success 'checkout --track=fetch,inherit fetches and inherits' '
      +	git checkout main &&
      +	git -C fetch_upstream checkout -b fetch_inherit &&


 Documentation/git-checkout.adoc |  13 ++-
 Documentation/git-switch.adoc   |  13 ++-
 builtin/checkout.c              | 168 +++++++++++++++++++++++++++++++-
 t/t7201-co.sh                   | 132 +++++++++++++++++++++++++
 4 files changed, 319 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 43ccf47cf6..28f17f427e 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -158,11 +158,22 @@ of it").
 	resets _<branch>_ to the start point instead of failing.
 
 `-t`::
-`--track[=(direct|inherit)]`::
+`--track[=(direct|inherit|fetch)[,...]]`::
 	When creating a new branch, set up "upstream" configuration. See
 	`--track` in linkgit:git-branch[1] for details. As a convenience,
 	--track without -b implies branch creation.
 +
+The argument is a comma-separated list. `direct` (the default) and
+`inherit` select the tracking mode and are mutually exclusive. Adding
+`fetch` requests that the remote be fetched before _<start-point>_ is
+resolved, so the new branch starts from a fresh tip: when
+_<start-point>_ is in _<remote>/<branch>_ form, only that branch is
+updated; when _<start-point>_ is a bare remote name (e.g. `origin`),
+only the remote's default branch is updated. If the fetch fails and the
+corresponding remote-tracking ref already exists, a warning is printed
+and the checkout proceeds from the existing tip; otherwise the checkout
+is aborted.
++
 If no `-b` option is given, the name of the new branch will be
 derived from the remote-tracking branch, by looking at the local part of
 the refspec configured for the corresponding remote, and then stripping
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index 87707e9265..3f54cf39e9 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -154,11 +154,22 @@ should result in deletion of the path).
 	attached to a terminal, regardless of `--quiet`.
 
 `-t`::
-`--track[ (direct|inherit)]`::
+`--track[=(direct|inherit|fetch)[,...]]`::
 	When creating a new branch, set up "upstream" configuration.
 	`-c` is implied. See `--track` in linkgit:git-branch[1] for
 	details.
 +
+The argument is a comma-separated list. `direct` (the default) and
+`inherit` select the tracking mode and are mutually exclusive. Adding
+`fetch` requests that the remote be fetched before _<start-point>_ is
+resolved, so the new branch starts from a fresh tip: when
+_<start-point>_ is in _<remote>/<branch>_ form, only that branch is
+updated; when _<start-point>_ is a bare remote name (e.g. `origin`),
+only the remote's default branch is updated. If the fetch fails and the
+corresponding remote-tracking ref already exists, a warning is printed
+and the switch proceeds from the existing tip; otherwise the switch is
+aborted.
++
 If no `-c` option is given, the name of the new branch will be derived
 from the remote-tracking branch, by looking at the local part of the
 refspec configured for the corresponding remote, and then stripping
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e61886..8f8d1ecffe 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -26,11 +26,14 @@
 #include "preload-index.h"
 #include "read-cache.h"
 #include "refs.h"
+#include "refspec.h"
 #include "remote.h"
 #include "repo-settings.h"
 #include "resolve-undo.h"
 #include "revision.h"
+#include "run-command.h"
 #include "setup.h"
+#include "strvec.h"
 #include "submodule.h"
 #include "symlinks.h"
 #include "trace2.h"
@@ -61,6 +64,7 @@ struct checkout_opts {
 	int count_checkout_paths;
 	int overlay_mode;
 	int dwim_new_local_branch;
+	int fetch;
 	int discard_changes;
 	int accept_ref;
 	int accept_pathspec;
@@ -112,6 +116,156 @@ struct branch_info {
 	char *checkout;
 };
 
+static int resolve_fetch_target(const char *arg, char **remote_out,
+				char **src_ref_out)
+{
+	const char *slash;
+	char *remote_name;
+	struct remote *remote;
+	struct refspec_item query = { 0 };
+	struct strbuf dst = STRBUF_INIT;
+	const char *rest;
+
+	*remote_out = NULL;
+	*src_ref_out = NULL;
+
+	if (!arg || !*arg)
+		return -1;
+
+	slash = strchr(arg, '/');
+	if (slash == arg)
+		return -1;
+	remote_name = slash ? xstrndup(arg, slash - arg) : xstrdup(arg);
+
+	remote = remote_get(remote_name);
+	if (!remote || !remote_is_configured(remote, 1)) {
+		free(remote_name);
+		return -1;
+	}
+
+	rest = (slash && slash[1]) ? slash + 1 : NULL;
+	if (!rest) {
+		struct object_id oid;
+		const char *head_target;
+		const char *short_target;
+
+		strbuf_addf(&dst, "refs/remotes/%s/HEAD", remote_name);
+		head_target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+						      dst.buf,
+						      RESOLVE_REF_READING |
+						      RESOLVE_REF_NO_RECURSE,
+						      &oid, NULL);
+		strbuf_reset(&dst);
+		if (head_target &&
+		    skip_prefix(head_target, "refs/remotes/", &short_target) &&
+		    skip_prefix(short_target, remote_name, &short_target) &&
+		    *short_target == '/')
+			rest = short_target + 1;
+	}
+
+	if (rest) {
+		strbuf_addf(&dst, "refs/remotes/%s/%s", remote_name, rest);
+		query.dst = dst.buf;
+		if (!remote_find_tracking(remote, &query) && query.src) {
+			*src_ref_out = xstrdup(query.src);
+			free(query.src);
+		} else {
+			*src_ref_out = xstrdup(rest);
+		}
+	}
+
+	strbuf_release(&dst);
+	*remote_out = remote_name;
+	return 0;
+}
+
+static void fetch_remote_for_start_point(const char *arg)
+{
+	char *remote_name = NULL;
+	char *src_ref = NULL;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf dst_ref = STRBUF_INIT;
+	int have_existing_ref = 0;
+
+	if (resolve_fetch_target(arg, &remote_name, &src_ref))
+		return;
+
+	if (src_ref) {
+		const char *short_src = src_ref;
+		struct object_id oid;
+
+		skip_prefix(short_src, "refs/heads/", &short_src);
+		strbuf_addf(&dst_ref, "refs/remotes/%s/%s", remote_name, short_src);
+		if (!refs_read_ref(get_main_ref_store(the_repository),
+				   dst_ref.buf, &oid))
+			have_existing_ref = 1;
+	}
+
+	strvec_pushl(&cmd.args, "fetch", remote_name, NULL);
+	if (src_ref)
+		strvec_push(&cmd.args, src_ref);
+	cmd.git_cmd = 1;
+	if (run_command(&cmd)) {
+		if (have_existing_ref)
+			warning(_("failed to fetch start-point '%s'; "
+				  "using existing '%s'"),
+				arg, dst_ref.buf);
+		else
+			die(_("failed to fetch start-point '%s'"), arg);
+	}
+
+	free(remote_name);
+	free(src_ref);
+	strbuf_release(&dst_ref);
+}
+
+static int parse_opt_checkout_track(const struct option *opt,
+				    const char *arg, int unset)
+{
+	struct checkout_opts *opts = opt->value;
+	struct string_list tokens = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	int saw_direct = 0, saw_inherit = 0;
+	int ret = 0;
+
+	opts->fetch = 0;
+
+	if (unset) {
+		opts->track = BRANCH_TRACK_NEVER;
+		return 0;
+	}
+
+	opts->track = BRANCH_TRACK_EXPLICIT;
+	if (!arg)
+		return 0;
+
+	string_list_split(&tokens, arg, ",", -1);
+	for_each_string_list_item(item, &tokens) {
+		if (!strcmp(item->string, "fetch")) {
+			opts->fetch = 1;
+		} else if (!strcmp(item->string, "direct")) {
+			saw_direct = 1;
+			opts->track = BRANCH_TRACK_EXPLICIT;
+		} else if (!strcmp(item->string, "inherit")) {
+			saw_inherit = 1;
+			opts->track = BRANCH_TRACK_INHERIT;
+		} else {
+			ret = error(_("option `%s' expects \"%s\", \"%s\", "
+				      "or \"%s\""),
+				    "--track", "direct", "inherit", "fetch");
+			goto out;
+		}
+	}
+
+	if (saw_direct && saw_inherit)
+		ret = error(_("option `%s' cannot combine \"%s\" and \"%s\""),
+			    "--track", "direct", "inherit");
+
+out:
+	string_list_clear(&tokens, 0);
+	return ret;
+}
+
 static void branch_info_release(struct branch_info *info)
 {
 	free(info->name);
@@ -1237,7 +1391,6 @@ static int git_checkout_config(const char *var, const char *value,
 		opts->dwim_new_local_branch = git_config_bool(var, value);
 		return 0;
 	}
-
 	if (starts_with(var, "submodule."))
 		return git_default_submodule_config(var, value, NULL);
 
@@ -1734,10 +1887,10 @@ static struct option *add_common_switch_branch_options(
 {
 	struct option options[] = {
 		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
-		OPT_CALLBACK_F('t', "track",  &opts->track, "(direct|inherit)",
+		OPT_CALLBACK_F('t', "track",  opts, "(direct|inherit|fetch)[,...]",
 			N_("set branch tracking configuration"),
 			PARSE_OPT_OPTARG,
-			parse_opt_tracking_mode),
+			parse_opt_checkout_track),
 		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unborn branch")),
@@ -1942,8 +2095,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->dwim_new_local_branch &&
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
-		int n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
-					     &new_branch_info, opts, &rev);
+		int n;
+
+		if (opts->fetch)
+			fetch_remote_for_start_point(argv[0]);
+
+		n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
+					 &new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
 	} else if (!opts->accept_ref && opts->from_treeish) {
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 9bcf7c0b40..19ac6a1a2e 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -801,4 +801,136 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
 	test_cmp_config "" --default "" branch.main2.merge
 '
 
+test_expect_success 'setup upstream for --track=fetch tests' '
+	git checkout main &&
+	git init fetch_upstream &&
+	test_commit -C fetch_upstream u_main &&
+	git remote add fetch_upstream fetch_upstream &&
+	git fetch fetch_upstream &&
+	git -C fetch_upstream checkout -b fetch_new &&
+	test_commit -C fetch_upstream u_new
+'
+
+test_expect_success 'checkout --track=fetch -b picks up branch created upstream after clone' '
+	git checkout main &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new &&
+	git checkout --track=fetch -b local_new fetch_upstream/fetch_new &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_new HEAD &&
+	test_cmp_config fetch_upstream branch.local_new.remote &&
+	test_cmp_config refs/heads/fetch_new branch.local_new.merge
+'
+
+test_expect_success 'checkout --track=fetch <remote>/<branch> leaves other tracking branches untouched' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_target &&
+	test_commit -C fetch_upstream u_target_pre &&
+	git -C fetch_upstream checkout -b fetch_other &&
+	test_commit -C fetch_upstream u_other_pre &&
+	git fetch fetch_upstream &&
+	other_before=$(git rev-parse refs/remotes/fetch_upstream/fetch_other) &&
+	git -C fetch_upstream checkout fetch_target &&
+	test_commit -C fetch_upstream u_target_post &&
+	git -C fetch_upstream checkout fetch_other &&
+	test_commit -C fetch_upstream u_other_post &&
+	git checkout --track=fetch -b local_target fetch_upstream/fetch_target &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_target HEAD &&
+	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_other)" = "$other_before"
+'
+
+test_expect_success 'checkout --track=fetch with bare remote name fetches only <remote>/HEAD target' '
+	git checkout main &&
+	git -C fetch_upstream checkout main &&
+	git remote set-head fetch_upstream main &&
+	git -C fetch_upstream checkout -b fetch_unrelated &&
+	test_commit -C fetch_upstream u_unrelated_pre &&
+	git fetch fetch_upstream fetch_unrelated &&
+	unrelated_before=$(git rev-parse refs/remotes/fetch_upstream/fetch_unrelated) &&
+	git -C fetch_upstream checkout main &&
+	test_commit -C fetch_upstream u_main_post &&
+	git -C fetch_upstream checkout fetch_unrelated &&
+	test_commit -C fetch_upstream u_unrelated_post &&
+	git checkout --track=fetch -b local_from_remote fetch_upstream &&
+	test_cmp_rev refs/remotes/fetch_upstream/main HEAD &&
+	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_unrelated)" = "$unrelated_before"
+'
+
+test_expect_success 'checkout --track=fetch aborts and does not create branch when no existing ref' '
+	git checkout main &&
+	test_might_fail git branch -D bogus &&
+	test_must_fail git checkout --track=fetch -b bogus fetch_upstream/does_not_exist &&
+	test_must_fail git rev-parse --verify refs/heads/bogus
+'
+
+test_expect_success 'checkout --track=fetch warns and proceeds when fetch fails but ref exists' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_offline &&
+	test_commit -C fetch_upstream u_offline &&
+	git fetch fetch_upstream fetch_offline &&
+	saved_url=$(git config remote.fetch_upstream.url) &&
+	test_when_finished "git config remote.fetch_upstream.url \"$saved_url\"" &&
+	git config remote.fetch_upstream.url ./does-not-exist &&
+	git checkout --track=fetch -b local_offline fetch_upstream/fetch_offline 2>err &&
+	test_grep "failed to fetch" err &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_offline HEAD
+'
+
+test_expect_success 'checkout --track=fetch resolves through configured fetch refspec' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_refspec &&
+	test_commit -C fetch_upstream u_refspec &&
+	git fetch fetch_upstream fetch_refspec &&
+	git remote add fetch_custom ./fetch_upstream &&
+	test_when_finished "git remote remove fetch_custom" &&
+	git config --replace-all remote.fetch_custom.fetch \
+		"+refs/heads/*:refs/remotes/custom-ns/*" &&
+	git fetch fetch_custom &&
+	test_commit -C fetch_upstream u_refspec_post &&
+	git checkout --track=fetch -b local_refspec custom-ns/fetch_refspec &&
+	test_cmp_rev refs/remotes/custom-ns/fetch_refspec HEAD
+'
+
+test_expect_success 'checkout --track=inherit,direct is rejected' '
+	test_must_fail git checkout --track=inherit,direct -b bad fetch_upstream/fetch_new 2>err &&
+	test_grep "cannot combine" err
+'
+
+test_expect_success 'checkout --track=fetch then --track=direct drops fetch (last-one-wins)' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_lastwin &&
+	test_commit -C fetch_upstream u_lastwin &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_lastwin &&
+	test_must_fail git checkout --track=fetch --track=direct \
+		-b local_lastwin fetch_upstream/fetch_lastwin &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_lastwin
+'
+
+test_expect_success 'checkout --track=fetch,inherit fetches and inherits' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_inherit &&
+	test_commit -C fetch_upstream u_inherit &&
+	git fetch fetch_upstream fetch_inherit &&
+	git checkout -b base_inherit fetch_upstream/fetch_inherit &&
+	test_commit -C fetch_upstream u_inherit2 &&
+	git checkout main &&
+	git checkout --track=fetch,inherit -b local_inherit base_inherit &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_inherit HEAD &&
+	test_cmp_config fetch_upstream branch.local_inherit.remote &&
+	test_cmp_config refs/heads/fetch_inherit branch.local_inherit.merge
+'
+
+test_expect_success 'checkout --track=bogus reports an error' '
+	git checkout main &&
+	test_must_fail git checkout --track=bogus -b bogus_branch fetch_upstream/fetch_new 2>err &&
+	test_grep "expects" err
+'
+
+test_expect_success 'switch --track=fetch -c picks up branch created upstream after clone' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_switch &&
+	test_commit -C fetch_upstream u_switch &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_switch &&
+	git switch --track=fetch -c local_switch fetch_upstream/fetch_switch &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_switch HEAD
+'
+
 test_done

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
