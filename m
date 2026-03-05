Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678FF35F5F2
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749982; cv=none; b=fNWXuzyGXcbCrgUwOBhvHyQmrEIYvZOwN+hMqVu3qaBmD1xQD+ySgQ8JZKY8tAmJI0qsXSJYCdew4xBQVAP4QtrpJW4PTT4EQhWfNv5uiTmLipRF2bYzlpiDpebOKFwG5KJxeRVANjUVqiA4J020JKKGZ+vNaeIeEeYOHml7YaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749982; c=relaxed/simple;
	bh=6MDfhoDGr2KrSgjqUEDbYNj7LIu0tJ5OsP2iTd0pteQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAxboDb9+/wtmQltq/vlmQA3Feu6rkJq/dh9jmDQJI2SwbIq6RGmBIcE4LtyYdllZNs5BoejEd3xbNNrwK3HREJhKVdUJ7Z73e+Ck+orxxBCzgaymWwNKYYYbUuYWQWisI8CmPZRyXFi3W/GJbHk3z6p0tTcpNV+MxN6jRt41zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoH7b5dp; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoH7b5dp"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824c9da9928so5100641b3a.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 14:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772749980; x=1773354780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caZpEceMid8LUMtsau5T4XX/dnKAcSyT2WpX9E54b/U=;
        b=IoH7b5dplIQzZtbZAfXb1nSs5PCW4rdCSkHGtxxGlZV8WqSqsLkxlIpwU+IsOJMHAq
         y+7zlXB/AuMItj+yxLO3tkjeqc2m30gTkGywqv7KC3NGGzOmE2J3XO4idEZwXgNwxCfK
         25MAqOul+T1bDFGA7OLDh48klDur3KMX8SrapF4GoIVXQvORcCGQXXbnfEr6OJZpI+ZQ
         /fPl4Mz4a+t/jisMtWB8Z5KiCXns1gaVPtTNYXVCI0n8cnq2VfPyIbknHpUGrdZNCBuP
         xbF1qVARHCKliKK/BKmHL3VaXCgszr0xrP/9xVngcqFUKRyag8ceWfNIk5Ke1btSLTH0
         9UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772749980; x=1773354780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=caZpEceMid8LUMtsau5T4XX/dnKAcSyT2WpX9E54b/U=;
        b=itxy/rA0oUB0AKSEaaNF4p4HrylXJuw8AkzgvJiaylEt9auXDYkMCC5IEOI+5TFdQ/
         QkXU2L56yoi+tzJSpCD2icIf+0USc+kN21ikCS51oysesrpLzZYIktcJsP91xTWMEw2Y
         H2b0zKPB70wyNDDL6KEk3G+xB4TTweBbVC7HG0VinTNtF/ChK1fpxRpw21K/o0V/NWTt
         walbn/QZjsvVmaH0LiSf3VxxqoOnv5wJOLePP1oPjpMgxsOBhZ/X15sJuDUgJ77AcJ/O
         vS9IK1ZxNyp40iHrBYuvgrurPjXW7tdbP88KcyR51xoq23ETCccFDudp/ZtyR64YFfgx
         +Qmw==
X-Gm-Message-State: AOJu0YzFOj0B8Uy8io55+IIRLX+z8NLKJ2gZrWfd1ooFb+rtr8xyg7jF
	rSuLrKN8n05gl8TRI5U/YLZxoI5d4fKRj5Iphe54t5Uhm6bz3eU4pNkMq54rxxBD
X-Gm-Gg: ATEYQzw57IT2M5Z5AE6PT1F7ZcseVEIYyaiwwARVHgaFGEDTG4VBBMzROXOx6b9iaqK
	iTsrbPZw2a1+SGNljpBjuIVF0B3e66lMhecNEBIi7enVN+J1C/lSBxuFfvbCB2FZWQJn0XUd92c
	WIH1WN3b9+o89Y/h1esI0furvyty6G/4PQkP98uq8PRY4ZvjKwTdc4d6NIjkPJ4AB9q65mf4Ao3
	zTI/6BOohBT9ZLrFQUuNsCKWcKlFHd0uO/p1pTWELH9WV3OihvM+B1UYh4LRlXWFLl05pNaX57k
	HFnwJNIsCRYrUoMdQrVkaLh9Zh/TZ332NdPV5jTBkugtcR+SdarRbmI/7o0WP1cvOlnbXzB5DqA
	ylkNsnOwj4uDuNQrB6bKZ1QuypC4Z5uiJ2YgDEQ87D5C7Pb425TtOSe9zReHTn9w4pBvO5ehM3L
	/aRL7gyGoXxINSPZlDQwFczvi7FZMxXVFx8/59krFNxgYlS4CcXxE5xLjlhMNitIKxsTYeIQ==
X-Received: by 2002:aa7:8895:0:b0:827:3976:3232 with SMTP id d2e1a72fcca58-82972b7f116mr7148270b3a.5.1772749980368;
        Thu, 05 Mar 2026 14:33:00 -0800 (PST)
Received: from archlinux ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8297ef26eb1sm3916721b3a.49.2026.03.05.14.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 14:33:00 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	gitster@pobox.com
Cc: christian.couder@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH 2/2] push: support pushing to a remote group
Date: Fri,  6 Mar 2026 04:02:48 +0530
Message-ID: <20260305223248.170785-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`git fetch` accepts a remote group name (configured via `remotes.<name>`
in config) and fetches from each member remote. `git push` has no
equivalent — it only accepts a single remote name.

Teach `git push` to resolve its repository argument through
`add_remote_or_group()`, which was made public in the previous patch,
so that a user can push to all remotes in a group with:

    git push <group>

When the argument resolves to a single remote the behaviour is
identical to before. When it resolves to a group, each member remote
is pushed in sequence.

The group push path rebuilds the refspec list (`rs`) from scratch for
each member remote so that per-remote push mappings configured via
`remote.<name>.push` are resolved correctly against each specific
remote. Without this, refspec entries would accumulate across iterations
and each subsequent remote would receive a growing list of duplicated
entries.

Mirror detection (`remote->mirror`) is also evaluated per remote using
a copy of the flags, so that a mirror remote in the group cannot set
TRANSPORT_PUSH_FORCE on subsequent non-mirror remotes in the same group.

A known interaction: push.default = simple will die when the current
branch has no upstream configured, because setup_default_push_refspecs()
requires an upstream for that mode. Users pushing to a group should set
push.default = current or supply explicit refspecs. This is consistent
with how fetch handles default refspec resolution per remote.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/push.c | 89 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 19 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 5b6cebbb85..a98fb4c934 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -551,12 +551,13 @@ int cmd_push(int argc,
 	int flags = 0;
 	int tags = 0;
 	int push_cert = -1;
-	int rc;
+	int rc = 0;
 	const char *repo = NULL;	/* default repository */
 	struct string_list push_options_cmdline = STRING_LIST_INIT_DUP;
+	struct string_list remote_group = STRING_LIST_INIT_DUP; /* represent remote or remote group */
 	struct string_list *push_options;
 	const struct string_list_item *item;
-	struct remote *remote;
+	struct remote *remote = NULL;
 
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
@@ -625,25 +626,35 @@ int cmd_push(int argc,
 	if (argc > 0)
 		repo = argv[0];
 
-	remote = pushremote_get(repo);
-	if (!remote) {
-		if (repo)
-			die(_("bad repository '%s'"), repo);
-		die(_("No configured push destination.\n"
-		    "Either specify the URL from the command-line or configure a remote repository using\n"
-		    "\n"
-		    "    git remote add <name> <url>\n"
-		    "\n"
-		    "and then push using the remote name\n"
-		    "\n"
-		    "    git push <name>\n"));
+	if (repo) {
+		if (!add_remote_or_group(repo, &remote_group))
+			die(_("no such remote or remote group: %s"), repo);
+	} else {
+		remote = pushremote_get(NULL);
+		if (!remote)
+			die(_("No configured push destination.\n"
+			    "Either specify the URL from the command-line or configure a remote repository using\n"
+			    "\n"
+			    "    git remote add <name> <url>\n"
+			    "\n"
+			    "and then push using the remote name\n"
+			    "\n"
+			    "    git push <name>\n"));
 	}
 
-	if (argc > 0)
-		set_refspecs(argv + 1, argc - 1, remote);
+	/*
+	 * set_refspecs and mirror detection must not use `remote`
+	 * when it may be NULL (group path). For the single-remote case,
+	 * handle them here. For the group case they are handled
+	 * per-remote inside the loop below.
+	 */
+	if (remote) {
+		if (argc > 0)
+			set_refspecs(argv + 1, argc - 1, remote);
 
-	if (remote->mirror)
-		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
+		if (remote->mirror)
+			flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
+	}
 
 	if (flags & TRANSPORT_PUSH_ALL) {
 		if (argc >= 2)
@@ -661,10 +672,50 @@ int cmd_push(int argc,
 		if (strchr(item->string, '\n'))
 			die(_("push options must not have new line characters"));
 
-	rc = do_push(flags, push_options, remote);
+	if (remote) {
+		rc = do_push(flags, push_options, remote);
+	} else {
+		int base_flags = flags;
+		for (int i = 0; i < remote_group.nr; i++) {
+			int iter_flags = base_flags;
+			struct remote *r = pushremote_get(remote_group.items[i].string);
+			if (!r)
+				die(_("no such remote or remote group: %s"),
+				    remote_group.items[i].string);
+
+			/*
+			 * Rebuild rs from scratch for each remote so that
+			 * push mappings (remote.NAME.push config) are resolved
+			 * against this specific remote. Without this, mappings
+			 * from a previous iteration would accumulate in rs and
+			 * each remote would be pushed an ever-growing refspec list.
+			 */
+			refspec_clear(&rs);
+			rs = (struct refspec) REFSPEC_INIT_PUSH;
+
+			if (tags)
+				refspec_append(&rs, "refs/tags/*");
+			if (argc > 0)
+				set_refspecs(argv + 1, argc - 1, r);
+
+			/*
+			 * Compute mirror flag from a fresh base each iteration
+			 * so that a mirror remote does not bleed TRANSPORT_PUSH_FORCE
+			 * into subsequent non-mirror remotes in the same group.
+			 */
+			if (r->mirror)
+				iter_flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
+
+			rc |= do_push(iter_flags, push_options, r);
+		}
+	}
+
+
 	string_list_clear(&push_options_cmdline, 0);
 	string_list_clear(&push_options_config, 0);
+	string_list_clear(&remote_group, 0);
 	clear_cas_option(&cas);
+
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
-- 
2.53.0

