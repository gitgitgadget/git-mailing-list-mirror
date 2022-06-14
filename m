Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B187EC43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 15:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344390AbiFNPes (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 11:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbiFNPeq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 11:34:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50618120B9
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 08:34:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g7so12196809eda.3
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Vqx6kvYGE8WdO76LwBaP9OlAJ2wsssvvyL/OqhLwoS8=;
        b=qea61NF1NVkZrbLnD662qEK88Iq6N65wN22fYU9Y/Cxv+z/KVXxP9C+8fHU/mN/bIT
         BHE9/Kw2O0lO+DrTU5sXAqcZ4VWMK0mB9EMQzz8b/25SE/kYrnndRkN8+idrDEEhsZyv
         JkF8ZqL76hVXPxYaA5FvIMM0jbd3hQjnYgoxCdP4bFIHnHwAFsAhhjvY672Y1JX/+WiX
         jQ/meUIUOahUR9/jQGWqLePQmBdZCJ+YJ/5Viu4exGVmkYnLWuDqaGZuK+eC4JXxmd3/
         sG62b74dP3O6r9MerT1/6DvfpywXWlpGZ95KdoxHsRtxCtuVK5lu3OR7U28ILDTxDJmN
         411g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Vqx6kvYGE8WdO76LwBaP9OlAJ2wsssvvyL/OqhLwoS8=;
        b=q6xNoeaNItzsxfvN/Xg9Ah4PuQPZ6dkI3s+mggq3x4UiYPSI5PrK94af0AYIiVga1c
         fP8oyizRs9w0wM8FbBoGcKFvEMb+AuMWWs65hAgEE5huMddcXRYaG6yJzdjcLOahZ78Q
         pLc6t9U7shZEJRvmoqMhrvPDnfXxobexRkI+xooQtzESFo0dGUzeW1ozvFUMqbRVfT/w
         PjOijBkQ0WGgH2er06bePM9hQ3+JK7YGx7BHmG9PpVHTJ7ni8cls4AhP696nRD24Q38G
         8omvT/YTbIAYfeIiR4kgEuX9h6Jm3qUI3G5xAf9CdVJn5BrPBRUXROUnwV9rKqZYmfHs
         tzMw==
X-Gm-Message-State: AJIora/F8wtBJ5jORNvDniIZB9AO9t7m3saDwIZr3XYgAlHQeHx5wvQ9
        DZtvRrT5C4qLnE8mDc5q/Wc=
X-Google-Smtp-Source: AGRyM1vRPt5i3X9WNjNGyqsF9voO40/jTF28gE9RyYvdzdK7gZygapKxs+K7SqpM154M4K+os/9eeQ==
X-Received: by 2002:a05:6402:1e95:b0:42a:c466:52ad with SMTP id f21-20020a0564021e9500b0042ac46652admr6870159edf.340.1655220883655;
        Tue, 14 Jun 2022 08:34:43 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t3-20020a056402020300b0042617ba6389sm7277086edv.19.2022.06.14.08.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:34:43 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o18Z0-000WqY-Cv;
        Tue, 14 Jun 2022 17:34:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        me@ttaylorr.com, Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/4] branch: add branch_checked_out() helper
Date:   Tue, 14 Jun 2022 17:24:50 +0200
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
 <dbb7eae390c90d4b710f48d8875bd7db0409aea3.1654718942.git.gitgitgadget@gmail.com>
 <220614.86leu0yur8.gmgdl@evledraar.gmail.com>
 <4fc234ab-de06-9e96-daf6-7b3496132541@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <4fc234ab-de06-9e96-daf6-7b3496132541@github.com>
Message-ID: <220614.86zgifxnql.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 14 2022, Derrick Stolee wrote:

> On 6/13/2022 7:59 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Jun 08 2022, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> From: Derrick Stolee <derrickstolee@github.com>
>>> [...]
>>> +	path_in_set =3D strmap_get(&current_checked_out_branches, refname);
>>> +	if (path_in_set && path)
>>> +		*path =3D xstrdup(path_in_set);
>>=20
>> Looking at the end state of this series there is nothing that passes a
>> null "path" to this function, i.e. it's all &some_variable.
>>=20
>> So just dropping that && seems better from a code understanding &
>> analysis perspective.
>
> I don't see the value in making this method more prone to error in
> the future, or less flexible to a possible caller that doesn't want
> to give a 'path'.

I think creating wrappers for exsiting APIs when they're not really
needed is what's more error prone. I.e. you need to learn to use the new
thing, whereas if it returns an existing type like "struct strmap",
"struct strbuf" etc. there's no learning curve.

It doesn't matter *that much* in this case, but I think it really adds
up.

>> More generally, can't we just expose an API that gives us the strmap
>> itself, so that callers don't need to keep any special-behavior in mind?
>> I.e. just "make me a strmap of checked out branches".
>>=20
>> Then you can just use strmap_get(), or xstrdup(strmap_get()), and if the
>> pattern of "get me the item but duped" is found elsewhere maybe we
>> should eventually have a strmap_get_dup() or whatever.
>>=20
>> I.e. just making it: xstrdup(strmap_get(checked_out_branches_strmap(), r=
efname)).
>
> This seems unnecessarily complicated. It also risks someone inserting
> key-value pairs in an improper place instead of being contained to
> prepare_checked_out_branches().

I really don't think the internal APIs in git need to be this paranoid,
just document it as "don't touch this".

I think in practice we have (and can expect) pretty mmuch zero bugs due
to misuse of APIs that are clearly meant to be global singletons,
whereas as this series & the fix-up shows it's more likely that we'll
need to deal with subtle memory leaks etc. due to over-wrapping in new
APIS :)

Or, if it does need paranoia simply structure the API to have each
caller get its own copy, here all the callers are one-shot built-ins, so
isn't this a premature optimization?

And speaking of risking things, probably overly fragile as an underlying
"general" API, if that's what you're aiming for.

I.e. you're making the hard assumption that the set of checked out
branches aren't changing during the lifetime of the process. So
e.g. builtin/checkout.c couldn't call this at the end of its run if
something in it had needed to get the map earlier (before we switched
branches)...

> If your concern is about creating the static current_checked_out_branches,
> keep in mind that the callers that call branch_checked_out() in a loop
> would need to keep track of that strmap across several other methods.
> That additional complexity is much worse than asking for a simple answer
> through the black box of branch_checked_out().

...that being said I was not suggesting to do away with the static
pattern, but to keep it, and to just return the map.

As far as hypothetical hot loops are concerned that would be marginally
cheaper, as you could move the "get map" outside a loop in such a
caller.

I tried this fix-up on top of "seen", which passes your test, and as
noted allocates less memory:

diff --git a/branch.c b/branch.c
index c7896f69a7c..efe1f6ce865 100644
--- a/branch.c
+++ b/branch.c
@@ -373,14 +373,13 @@ int validate_branchname(const char *name, struct strb=
uf *ref)
 static int initialized_checked_out_branches;
 static struct strmap current_checked_out_branches =3D STRMAP_INIT;
=20
-static void prepare_checked_out_branches(void)
+struct strmap *checked_out_branches_map(void)
 {
 	int i =3D 0;
 	struct worktree **worktrees;
=20
 	if (initialized_checked_out_branches)
-		return;
-	initialized_checked_out_branches =3D 1;
+		goto done;
=20
 	worktrees =3D get_worktrees();
=20
@@ -426,18 +425,10 @@ static void prepare_checked_out_branches(void)
 	}
=20
 	free_worktrees(worktrees);
-}
=20
-int branch_checked_out(const char *refname, char **path)
-{
-	const char *path_in_set;
-	prepare_checked_out_branches();
-
-	path_in_set =3D strmap_get(&current_checked_out_branches, refname);
-	if (path_in_set && path)
-		*path =3D xstrdup(path_in_set);
-
-	return !!path_in_set;
+done:
+	initialized_checked_out_branches =3D 1;
+	return &current_checked_out_branches;
 }
=20
 /*
@@ -456,7 +447,8 @@ int validate_new_branchname(const char *name, struct st=
rbuf *ref, int force)
 		die(_("a branch named '%s' already exists"),
 		    ref->buf + strlen("refs/heads/"));
=20
-	if (branch_checked_out(ref->buf, &path))
+	path =3D strmap_get(checked_out_branches_map() , ref->buf);
+	if (path)
 		die(_("cannot force update the branch '%s' "
 		      "checked out at '%s'"),
 		    ref->buf + strlen("refs/heads/"), path);
diff --git a/branch.h b/branch.h
index 5ea93d217b1..63cb0f7adc4 100644
--- a/branch.h
+++ b/branch.h
@@ -103,11 +103,12 @@ void create_branches_recursively(struct repository *r=
, const char *name,
 				 int dry_run);
=20
 /*
- * Returns true if the branch at 'refname' is checked out at any
- * non-bare worktree. The path of the worktree is stored in the
- * given 'path', if provided.
+ * Lazily returns a "struct strmap" of checked out branches. The
+ * returned value is a global that'll be populated on the first
+ * call. You should only call read-only strmap API functions on this,
+ * such as strmap_get(), strmap_contains() etc.
  */
-int branch_checked_out(const char *refname, char **path);
+struct strmap *checked_out_branches_map(void);
=20
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
diff --git a/builtin/branch.c b/builtin/branch.c
index 8e11e433840..2913b2e75e4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -24,6 +24,7 @@
 #include "worktree.h"
 #include "help.h"
 #include "commit-reach.h"
+#include "strmap.h"
=20
 static const char * const builtin_branch_usage[] =3D {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
@@ -253,12 +254,12 @@ static int delete_branches(int argc, const char **arg=
v, int force, int kinds,
 		name =3D mkpathdup(fmt, bname.buf);
=20
 		if (kinds =3D=3D FILTER_REFS_BRANCHES) {
-			char *path;
-			if (branch_checked_out(name, &path)) {
+			const char *path =3D strmap_get(checked_out_branches_map(),
+						      name);
+			if (path) {
 				error(_("Cannot delete branch '%s' "
 					"checked out at '%s'"),
 				      bname.buf, path);
-				free(path);
 				ret =3D 1;
 				continue;
 			}
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9ee7f2241ad..a57506a4003 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -30,6 +30,7 @@
 #include "shallow.h"
 #include "worktree.h"
 #include "bundle-uri.h"
+#include "strmap.h"
=20
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
=20
@@ -890,7 +891,6 @@ static int update_local_ref(struct ref *ref,
 			    struct worktree **worktrees)
 {
 	struct commit *current =3D NULL, *updated;
-	char *path =3D NULL;
 	const char *pretty_ref =3D prettify_refname(ref->name);
 	int fast_forward =3D 0;
=20
@@ -905,17 +905,17 @@ static int update_local_ref(struct ref *ref,
 	}
=20
 	if (!update_head_ok &&
-	    !is_null_oid(&ref->old_oid) &&
-	    branch_checked_out(ref->name, &path)) {
+	    !is_null_oid(&ref->old_oid)) {
+		int in_set =3D strmap_contains(checked_out_branches_map(),
+					     ref->name);
 		/*
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
 		format_display(display, '!', _("[rejected]"),
-			       path ? _("can't fetch in current branch") :
+			       in_set ? _("can't fetch in current branch") :
 				      _("checked out in another worktree"),
 			       remote, pretty_ref, summary_width);
-		free(path);
 		return 1;
 	}
=20
@@ -1445,7 +1445,8 @@ static void check_not_current_branch(struct ref *ref_=
map)
 	for (; ref_map; ref_map =3D ref_map->next)
 		if (ref_map->peer_ref &&
 		    starts_with(ref_map->peer_ref->name, "refs/heads/") &&
-		    branch_checked_out(ref_map->peer_ref->name, &path))
+		    (path =3D strmap_get(checked_out_branches_map(),
+				       ref_map->peer_ref->name)))
 			die(_("refusing to fetch into branch '%s' "
 			      "checked out at '%s'"),
 			    ref_map->peer_ref->name, path);
