Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D782B16A395
	for <git@vger.kernel.org>; Tue, 19 May 2026 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177514; cv=none; b=ZT1F5MQg+ABnK7ctZaYSJcsbJeZttA5yI/rgeOc9a8eIrRlZXygHGTjuis6Om/Dm/JJq4dGFs1lRDI8XLnAigkoKXrMata9hQwpFgfV7LCe1ah8/QClm0vjLR0OD46PdMcdUuAhL6OTILouTTHP99F5ic7cvI1qK970eqXfUyLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177514; c=relaxed/simple;
	bh=wnKnfKxzwuyoAYeyjOSrY2sIqhgOwWKTbsKK+g7qlmw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WjhiVfYR3dsJCgJ0wywDZEN1s89u1swn0HHOBJ/YuBhe9w4WJIzDmpBJIWTUCLiqUYc/C0rAfiHqXSPLZTg9xPkMy+AMGmNjJtKGnZi6pW6TcEeB73GFkjNlZ/SH2PNcrO2RBQ/ogaV0Aj1ip5YEPh+1bKMM8GqOEy2zlIWwLeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjJYwhb8; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjJYwhb8"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1332772f6b3so3763203c88.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 00:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177511; x=1779782311; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKdGGW/CTGH7eB/T4K3alxlIIxa0M9+evH/dVL0DtRk=;
        b=bjJYwhb8cPUO23QNhnlqkP9lverysRqScl3Ae9tmVcaWf158cag5tVl5j67POMUv8R
         qYKsIchE/lGzdXduTMYmyycTvDuTym9iZ1O+R5WzFm2A2hDz9E6YvgWB7Sq/Tj8YDA10
         gH56Ipm4YvabJgBfMKTypCW//PV7QH4BlvO4vJZTTyz8ozknHVamxPFfHhelApHqRL4E
         5uKsq2Hd8QQktAVCkZzK2ZHtXZewZSigbV34yIUKCjH2GhP32VqOwq5odFgyy+xAU9oJ
         Gc61qHNEyW6LMmVa9ahP8kVpxJXVYveAwAO7ZCTiC2HyfRK8Jxqi0wBR6x9V16/0Jcss
         YIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177511; x=1779782311;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZKdGGW/CTGH7eB/T4K3alxlIIxa0M9+evH/dVL0DtRk=;
        b=S+3/B7XsSsngjkYM9np87ZiTgzrcNca/cp53C2IC1dxqtSwC7tlZGHe9hefWBq4TEo
         83J6036IoaVD+hJEpNfSzelMHnTqAPvX3ojWWjyJL+VXBoAANjXkgyaGikcUe5F11GO+
         M0ZDU0i7jQduB5f7l3JccTp35esSzF94ixJ5Mh8vFThAgHwfG/hA4YPT9PS14QTZTdbt
         aT7aklEgFPp7Ak5BOVErgzSzGwZB9cxnKr9+5SjOsNBGhx1duiSbkqq7CjoYanwxxqPj
         /osjvrtwCjsKL96pxapVPeYi88Mj3QjbBAAlqDDmiX/jiKW1ekcyUazd2ljlAstLqOi0
         LYgg==
X-Gm-Message-State: AOJu0YyR2+K+WRU0mDy1UOodPvGGjhKC74jHlOtlCh76dlIqMJ1rqOmI
	uU7MH7YDblC95jNQdZ2Ki3MFAReKb2gdIrMZ+2Gtj3mC4cIUOx4rGtT150qyMA==
X-Gm-Gg: Acq92OE+TcgX4HgtX+YnjWG5ujzKozgE2YqmyAxm1kPRE6Wa9wUl95M3Ij6Lod32gfF
	yNyvnHqzaMcLKgAMCiMdYLPIlLKYpMBu9I6b17iSMKfS6hjTUfivPjMeIMNIv2DwXoX+JSurVsk
	G33ypptZwI6xwx0w+4ZkJbdZ7X8UyTZshwcDU1uazEIknnNihzy9bAAi7JHQEtgGTrEfVS5Kl9D
	CNY67vE2RT8UGq1dU47VUROUXPFMAGmnSpEyMJXrtMisy6FjxMGeXGry61Oru5FeB7OL34kcn/B
	zT9BV8uKk2kJThqK1pdNa+m1lI5ojORzgPjZJgy0tRxSqfjypN8FRlw1U7FAl5sVe3kfLpx2iUV
	1qnZTmprqQ2V+PSaj8N79pLG8t3rUIW4W5mfvGHxg+nlEeC7aPHZlFuZkmwfMkOuvZpD7j+qCCS
	v+euVBQShESIsYifCb8sZKEmA=
X-Received: by 2002:a05:7022:6720:b0:12d:b329:987d with SMTP id a92af1059eb24-1350473884fmr7787002c88.24.1779177510375;
        Tue, 19 May 2026 00:58:30 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.59.6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdce9fasm18808044c88.4.2026.05.19.00.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:58:29 -0700 (PDT)
Message-Id: <pull.2281.v11.git.git.1779177508772.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
References: <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 May 2026 07:58:28 +0000
Subject: [PATCH v11] checkout: extend --track with a "fetch" mode to refresh
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
    checkout: --track=fetch
    
     * Find the right remote by checking which remote's fetch refspec maps
       to the user's start-point, instead of assuming the start-point begins
       with the remote's name. This fixes cases where the user has a custom
       refspec mapping into a namespace whose name differs from the remote
       (e.g. fetching from origin into refs/remotes/upstream/*).
     * For a bare namespace name, follow <namespace>/HEAD first to figure
       out which branch to fetch.
     * Strengthen the custom-refspec test so it actually exercises the fetch
       (no prior git fetch).
     * New test for the bare-namespace case.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v11
Pull-Request: https://github.com/git/git/pull/2281

Range-diff vs v10:

 1:  a773fb6bdf ! 1:  d0c9e3e879 checkout: extend --track with a "fetch" mode to refresh start-point
     @@ builtin/checkout.c: struct branch_info {
       	char *checkout;
       };
       
     ++struct fetch_target_cb {
     ++	struct refspec_item query;
     ++	const char *remote_name;
     ++	int matches;
     ++};
     ++
     ++static int match_fetch_target(struct remote *remote, void *priv)
     ++{
     ++	struct fetch_target_cb *cb = priv;
     ++	struct refspec_item q = { .dst = cb->query.dst };
     ++
     ++	if (!remote_find_tracking(remote, &q) && q.src) {
     ++		if (++cb->matches == 1) {
     ++			cb->remote_name = remote->name;
     ++			free(cb->query.src);
     ++			cb->query.src = q.src;
     ++		} else {
     ++			free(q.src);
     ++		}
     ++	}
     ++	return 0;
     ++}
     ++
      +static int resolve_fetch_target(const char *arg, char **remote_out,
      +				char **src_ref_out, char **existing_ref_out)
      +{
     -+	const char *slash;
     -+	char *remote_name = NULL;
     -+	struct remote *remote = NULL;
     -+	struct refspec_item query = { 0 };
      +	struct strbuf dst = STRBUF_INIT;
     ++	struct strbuf head_path = STRBUF_INIT;
     ++	struct fetch_target_cb cb = { 0 };
      +	struct object_id oid;
     -+	const char *rest = NULL;
     -+	const char *head_target = NULL;
     -+	const char *short_target;
     ++	const char *head_target;
      +
      +	*remote_out = NULL;
      +	*src_ref_out = NULL;
      +	*existing_ref_out = NULL;
      +
     -+	if (!arg || !*arg || *arg == '/')
     ++	if (!arg || !*arg)
      +		return -1;
      +
     -+	slash = arg + strlen(arg);
     -+	while (1) {
     -+		free(remote_name);
     -+		remote_name = xstrndup(arg, slash - arg);
     -+		remote = remote_get(remote_name);
     -+		if (remote && remote_is_configured(remote, 1))
     -+			break;
     -+		while (slash > arg && *--slash != '/')
     -+			;
     -+		if (slash == arg) {
     -+			free(remote_name);
     -+			return -1;
     -+		}
     -+	}
     -+
     -+	if (*slash == '/' && slash[1])
     -+		rest = slash + 1;
     -+	if (!rest) {
     -+		strbuf_addf(&dst, "refs/remotes/%s/HEAD", remote_name);
     -+		head_target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
     -+						      dst.buf,
     -+						      RESOLVE_REF_READING |
     -+						      RESOLVE_REF_NO_RECURSE,
     -+						      &oid, NULL);
     -+		if (head_target) {
     -+			*existing_ref_out = xstrdup(dst.buf);
     -+			if (skip_prefix(head_target, "refs/remotes/", &short_target) &&
     -+			    skip_prefix(short_target, remote_name, &short_target) &&
     -+			    *short_target == '/')
     -+				rest = short_target + 1;
     -+		}
     -+		strbuf_reset(&dst);
     ++	strbuf_addf(&head_path, "refs/remotes/%s/HEAD", arg);
     ++	head_target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
     ++					      head_path.buf,
     ++					      RESOLVE_REF_READING |
     ++					      RESOLVE_REF_NO_RECURSE,
     ++					      &oid, NULL);
     ++	if (head_target)
     ++		strbuf_addstr(&dst, head_target);
     ++	else
     ++		strbuf_addf(&dst, "refs/remotes/%s", arg);
     ++
     ++	cb.query.dst = dst.buf;
     ++	for_each_remote(match_fetch_target, &cb);
     ++
     ++	if (cb.matches != 1) {
     ++		free(cb.query.src);
     ++		strbuf_release(&dst);
     ++		strbuf_release(&head_path);
     ++		return -1;
      +	}
      +
     -+	if (rest) {
     -+		strbuf_addf(&dst, "refs/remotes/%s/%s", remote_name, rest);
     -+		query.dst = dst.buf;
     -+		if (!remote_find_tracking(remote, &query) && query.src) {
     -+			*src_ref_out = xstrdup(query.src);
     -+			free(query.src);
     -+		} else {
     -+			*src_ref_out = xstrdup(rest);
     -+		}
     -+		if (!*existing_ref_out) {
     -+			strbuf_reset(&dst);
     -+			strbuf_addf(&dst, "refs/remotes/%s", arg);
     -+			if (!refs_read_ref(get_main_ref_store(the_repository),
     -+					   dst.buf, &oid))
     -+				*existing_ref_out = xstrdup(dst.buf);
     -+		}
     -+	}
     ++	*remote_out = xstrdup(cb.remote_name);
     ++	*src_ref_out = cb.query.src;
     ++	if (head_target)
     ++		*existing_ref_out = strbuf_detach(&head_path, NULL);
     ++	else if (!refs_read_ref(get_main_ref_store(the_repository),
     ++				dst.buf, &oid))
     ++		*existing_ref_out = strbuf_detach(&dst, NULL);
      +
      +	strbuf_release(&dst);
     -+	*remote_out = remote_name;
     ++	strbuf_release(&head_path);
      +	return 0;
      +}
      +
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +
      +test_expect_success 'checkout --track=fetch resolves through configured fetch refspec' '
      +	git checkout main &&
     -+	git -C fetch_upstream checkout -b fetch_refspec &&
     -+	test_commit -C fetch_upstream u_refspec &&
     -+	git fetch fetch_upstream fetch_refspec &&
      +	git remote add fetch_custom ./fetch_upstream &&
      +	test_when_finished "git remote remove fetch_custom" &&
      +	git config --replace-all remote.fetch_custom.fetch \
      +		"+refs/heads/*:refs/remotes/custom-ns/*" &&
     -+	git fetch fetch_custom &&
     -+	test_commit -C fetch_upstream u_refspec_post &&
     ++	git -C fetch_upstream checkout -b fetch_refspec &&
     ++	test_commit -C fetch_upstream u_refspec &&
     ++	test_must_fail git rev-parse --verify refs/remotes/custom-ns/fetch_refspec &&
      +	git checkout --track=fetch -b local_refspec custom-ns/fetch_refspec &&
      +	test_cmp_rev refs/remotes/custom-ns/fetch_refspec HEAD
      +'
      +
     ++test_expect_success 'checkout --track=fetch on namespace bare name follows <ns>/HEAD' '
     ++	git checkout main &&
     ++	git remote add fetch_ns ./fetch_upstream &&
     ++	test_when_finished "git remote remove fetch_ns" &&
     ++	git config --replace-all remote.fetch_ns.fetch \
     ++		"+refs/heads/*:refs/remotes/ns_alias/*" &&
     ++	git fetch fetch_ns &&
     ++	git symbolic-ref refs/remotes/ns_alias/HEAD refs/remotes/ns_alias/main &&
     ++	git -C fetch_upstream checkout main &&
     ++	test_commit -C fetch_upstream u_ns_post &&
     ++	git checkout --track=fetch -b local_ns ns_alias &&
     ++	test_cmp_rev refs/remotes/ns_alias/main HEAD &&
     ++	test_cmp_config fetch_ns branch.local_ns.remote &&
     ++	test_cmp_config refs/heads/main branch.local_ns.merge
     ++'
     ++
      +test_expect_success 'checkout --track=fetch handles hierarchical remote name' '
      +	git checkout main &&
      +	git -C fetch_upstream checkout -b fetch_hier &&


 Documentation/git-checkout.adoc |  13 ++-
 Documentation/git-switch.adoc   |  13 ++-
 builtin/checkout.c              | 164 +++++++++++++++++++++++++++++++-
 t/t7201-co.sh                   | 158 ++++++++++++++++++++++++++++++
 4 files changed, 342 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index a8b3b8c2e2..ec63434159 100644
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
index d6c4f229a5..b5e79435cd 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -155,11 +155,22 @@ variable.
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
index 1345e8574a..5b3a06c0cd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -25,10 +25,12 @@
 #include "preload-index.h"
 #include "read-cache.h"
 #include "refs.h"
+#include "refspec.h"
 #include "remote.h"
 #include "repo-settings.h"
 #include "resolve-undo.h"
 #include "revision.h"
+#include "run-command.h"
 #include "sequencer.h"
 #include "setup.h"
 #include "strvec.h"
@@ -62,6 +64,7 @@ struct checkout_opts {
 	int count_checkout_paths;
 	int overlay_mode;
 	int dwim_new_local_branch;
+	int fetch;
 	int discard_changes;
 	int accept_ref;
 	int accept_pathspec;
@@ -115,6 +118,154 @@ struct branch_info {
 	char *checkout;
 };
 
+struct fetch_target_cb {
+	struct refspec_item query;
+	const char *remote_name;
+	int matches;
+};
+
+static int match_fetch_target(struct remote *remote, void *priv)
+{
+	struct fetch_target_cb *cb = priv;
+	struct refspec_item q = { .dst = cb->query.dst };
+
+	if (!remote_find_tracking(remote, &q) && q.src) {
+		if (++cb->matches == 1) {
+			cb->remote_name = remote->name;
+			free(cb->query.src);
+			cb->query.src = q.src;
+		} else {
+			free(q.src);
+		}
+	}
+	return 0;
+}
+
+static int resolve_fetch_target(const char *arg, char **remote_out,
+				char **src_ref_out, char **existing_ref_out)
+{
+	struct strbuf dst = STRBUF_INIT;
+	struct strbuf head_path = STRBUF_INIT;
+	struct fetch_target_cb cb = { 0 };
+	struct object_id oid;
+	const char *head_target;
+
+	*remote_out = NULL;
+	*src_ref_out = NULL;
+	*existing_ref_out = NULL;
+
+	if (!arg || !*arg)
+		return -1;
+
+	strbuf_addf(&head_path, "refs/remotes/%s/HEAD", arg);
+	head_target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+					      head_path.buf,
+					      RESOLVE_REF_READING |
+					      RESOLVE_REF_NO_RECURSE,
+					      &oid, NULL);
+	if (head_target)
+		strbuf_addstr(&dst, head_target);
+	else
+		strbuf_addf(&dst, "refs/remotes/%s", arg);
+
+	cb.query.dst = dst.buf;
+	for_each_remote(match_fetch_target, &cb);
+
+	if (cb.matches != 1) {
+		free(cb.query.src);
+		strbuf_release(&dst);
+		strbuf_release(&head_path);
+		return -1;
+	}
+
+	*remote_out = xstrdup(cb.remote_name);
+	*src_ref_out = cb.query.src;
+	if (head_target)
+		*existing_ref_out = strbuf_detach(&head_path, NULL);
+	else if (!refs_read_ref(get_main_ref_store(the_repository),
+				dst.buf, &oid))
+		*existing_ref_out = strbuf_detach(&dst, NULL);
+
+	strbuf_release(&dst);
+	strbuf_release(&head_path);
+	return 0;
+}
+
+static void fetch_remote_for_start_point(const char *arg)
+{
+	char *remote_name = NULL;
+	char *src_ref = NULL;
+	char *existing_ref = NULL;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	if (resolve_fetch_target(arg, &remote_name, &src_ref, &existing_ref))
+		return;
+
+	strvec_pushl(&cmd.args, "fetch", remote_name, NULL);
+	if (src_ref)
+		strvec_push(&cmd.args, src_ref);
+	cmd.git_cmd = 1;
+	if (run_command(&cmd)) {
+		if (existing_ref)
+			warning(_("failed to fetch start-point '%s'; "
+				  "using existing '%s'"),
+				arg, existing_ref);
+		else
+			die(_("failed to fetch start-point '%s'"), arg);
+	}
+
+	free(remote_name);
+	free(src_ref);
+	free(existing_ref);
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
@@ -1733,10 +1884,10 @@ static struct option *add_common_switch_branch_options(
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
@@ -1941,8 +2092,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
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
index 7613b1d2a4..d4f5467903 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -870,4 +870,162 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
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
+	git remote add fetch_custom ./fetch_upstream &&
+	test_when_finished "git remote remove fetch_custom" &&
+	git config --replace-all remote.fetch_custom.fetch \
+		"+refs/heads/*:refs/remotes/custom-ns/*" &&
+	git -C fetch_upstream checkout -b fetch_refspec &&
+	test_commit -C fetch_upstream u_refspec &&
+	test_must_fail git rev-parse --verify refs/remotes/custom-ns/fetch_refspec &&
+	git checkout --track=fetch -b local_refspec custom-ns/fetch_refspec &&
+	test_cmp_rev refs/remotes/custom-ns/fetch_refspec HEAD
+'
+
+test_expect_success 'checkout --track=fetch on namespace bare name follows <ns>/HEAD' '
+	git checkout main &&
+	git remote add fetch_ns ./fetch_upstream &&
+	test_when_finished "git remote remove fetch_ns" &&
+	git config --replace-all remote.fetch_ns.fetch \
+		"+refs/heads/*:refs/remotes/ns_alias/*" &&
+	git fetch fetch_ns &&
+	git symbolic-ref refs/remotes/ns_alias/HEAD refs/remotes/ns_alias/main &&
+	git -C fetch_upstream checkout main &&
+	test_commit -C fetch_upstream u_ns_post &&
+	git checkout --track=fetch -b local_ns ns_alias &&
+	test_cmp_rev refs/remotes/ns_alias/main HEAD &&
+	test_cmp_config fetch_ns branch.local_ns.remote &&
+	test_cmp_config refs/heads/main branch.local_ns.merge
+'
+
+test_expect_success 'checkout --track=fetch handles hierarchical remote name' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_hier &&
+	test_commit -C fetch_upstream u_hier &&
+	git remote add nested/remote ./fetch_upstream &&
+	test_when_finished "git remote remove nested/remote" &&
+	git fetch nested/remote fetch_hier &&
+	test_commit -C fetch_upstream u_hier_post &&
+	git checkout --track=fetch -b local_hier nested/remote/fetch_hier &&
+	test_cmp_rev refs/remotes/nested/remote/fetch_hier HEAD
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

base-commit: 7bcaabddcf68bd0702697da5904c3b68c52f94cf
-- 
gitgitgadget
