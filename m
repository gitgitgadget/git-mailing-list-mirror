Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CDA2FC00D
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787866570; cv=none; b=H7DfReG+ARIUCot3xsOWdIefU0wlT/s9+29obPmQFrXIwsipZkSfdoXbC7GFoZcbdaQ0UR0u2nX8qYAo5N+OgHnzUBU4r85JnPNNbvQit59zqikAHDSRGjBF1jwWKe5iiR9LsvEVmR5Jd6O1mvNvv2pqCZ2YvEUydMNiqkLI3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787866570; c=relaxed/simple;
	bh=NbanN/CBKrmbL2SsmlWMZPuVfFb3z77MHAxEgvvLb60=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h94GEJdU3IeLihY6J+c5/wEavvaCBcVtIj3hFWSTsYAlxuS94yrDSPttEOx+tOeH1Bkf/ZngEifTHkw3OJuKZWgUXADRCs5UZ6p8EHbsK3UEAzApa/Gnr4XuBihm++2yB9AdHjEdPTY+YjRVO5MbbR7+B83nZuM3SpPy/+uZNWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bYbnWgaw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LijDfDbP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bYbnWgaw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LijDfDbP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6902A14000FA;
	Thu, 27 Aug 2026 17:36:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 27 Aug 2026 17:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787866561; x=1787952961; bh=zkIu+IMACi
	dJHyc/+ZAqD2Sp8VqQ6ZygaYmtWn1pA/w=; b=bYbnWgawqG0jQ6UtGsgQNEdSlN
	AFbcN1UZJh/RkAAA7djSk5+0xGWKpTQKuLUem9F/+YKLlZM1mNApHsyRxzxJ31mB
	TLGaS5aSlYpb8Mtsttdft6wNfUAduIx+Rv/lM1Zoe05KT4Hu0ZTa4jm0Y6Euw97O
	C2UT4zeVgeR0f1uA+UOobnh7HzrBtbQ4RBQyRio6wsZCVdIS+7R4ig2CtJ7B/Ba9
	uFYs3ny0YAG+z2nbkQeNuOWEcfAZR7y3cnHlyvddi+gfWGJa3RnnOuF9RzqnN2eB
	E5+qZmWEoFEhrGhFhbQZ9WGpDrR666Jpt5waduQpHrHSVkeeJLpQiMGiQ/dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787866561; x=1787952961; bh=zkIu+IMACidJHyc/+ZAqD2Sp8VqQ6ZygaYm
	tWn1pA/w=; b=LijDfDbPeWeNGgUqW4jAVySgtxp8pmFoeDlQo9HU4p3srv7lBWu
	71QoSdZZNDvYGiERLeK+ZRd9gAOYaVR0fG3eP25f+cNGV1gcFU1NHZRr1kh7gj4q
	ZdUpcctZUYlX8UEgDZTeierzqwgBW8SxuLEYVi4pzIYR5LLrUtEIKiF3+R+rsvQs
	yTOwXQ5OkjmeMC13HzUXia41DdtCOGQaVrRus4QA50Ey3i1xQABUiQhLQPwD1fAI
	tPu+MieUKONmafAXpVugong6znVpCgSaz7NFbOYeQRnqsXvPh+i3LzPkliQzpCiM
	fshY8XmgLRg9Ua8V8eABeTtEi/FiWwcoAgQ==
X-ME-Sender: <xms:wa2Qaok1SfE_73LVZX2pQZKc59PbCh4kPvXRlpsZXF8wwNMZUbHGsQ>
    <xme:wa2Qat2AJIOaqYwS2xb2TWETuRDIgQGh4bbfMShPtxxknLLR-tXJhfCqjVg1Do7Yo
    8OIZvOlvlZQqLsEyHNB5SuFR67lssjDwuPj9ad8jLlgbmDd3oCd2rU>
X-ME-Received: <xmr:wa2QakRiVkgUdH-oXepo0wS8MoVlIVFadEMgrLSlo73eX-LaDXTdjqiIm6hAFopIHfZkcmsA3awgRn49dzTNW3oBHeZ8e8FbUA>
X-ME-Proxy-Cause: dmFkZTEDqSgqjeJtV2vkodK04oj22uo7A8PLKjMC0O0Xe2V1xkCDQTL7NEOsLM345pIMfz
    dGj0Moyuhn9XMjOtvP8IS2LcSSrSXkt0biS4kbtmpgD1nU2WsTka5P9DQsWts0pd4ijaVx
    qMWdVqwJo74hXGS+gvId+edY7Hm24mQihakMreeQYtLCNwNrMMG4EQjU0K6tQ6i8IPL07Z
    6RfI/S5hUyTdjt5Ul1WSu4R0JeOdJ53INkbpdx7CvCgmfnEgUJC/CKc5EKgqPnhCdMev27
    bu1UyDw7QBoXHh8VV1MK4vOdIKhKPCo5QbrfUdNW0PkDKEC97plwT/JhC5x9bvYDbblrU6
    /adRuxKqepYDeI01yleZTV2nSBlrJ6FmlCzqL0SOKFAqGVMqgtxvRl3/ZebOUT/iX7wZM0
    tmvPUFRtGYArAkhkD2Kl5nTfwKin74Bz0yllU3IVP0+cFOdvYE6b3aXRBPhV1Y60lNOox9
    7Aglj8SRfTum6VUDYN+d6BA8kgAJjVl10K1wf8jE0/Djz7ZcyX20neM8KmoWmncCVDNyZy
    I1Gq8RbyR5QssVV2HDKYhFc1StB8t6Cg2mT1u3TwxueuqXyUrDtKpJKAI0WRnID3KIBrJ+
    iqZ9JuhbiYvAvTvtZQSkEBAc5skLR1t3p81s57z3AXwZ6wYKqzCYymMGDdYy7UEyAxag6/
    e4IJB9RMUz9nA8ZQ2f8PwOzm11BXICnX3LN9OWhFJq273vJCkzVWWAlksX5rNPvywym4Mp
    6rzGO4GMFkJyiCwMVBWNjOHUu6ySC4OkMY/65EPWXLcZu9gzkxzctC2jqiBjIhhQ2Jb/29
    cBcgpYbL0lxvSn9AyveDA7/4ClUoaxnrjZ5hvgo3ePKuEFXNW+9dp8GY7Bpric31N+SG7F
    +8ukMqOb2tpe3RznZdITJWeIlYGCFj+lgX6MGfJBlQJVq2d+3Q4ziOOfjb08oBFAEDxeKt
    5geP8kSJmgj7PlwoLxngWiswJY9wvFDKKWsA9k2S28Ajp4VkvI8
X-ME-Proxy: <xmx:wa2Qavs3mx-PeaouM-JfQ969A-QQob4zQ8k9s3pyObcxfedmCeADEA>
    <xmx:wa2QapbVjBj2x3NjCtEUdp9wUUDnnS1Hi28-Y_lpY3pLHZSfMvCjRQ>
    <xmx:wa2Qakugu5NlJ_lbO4KXU3agdDOVPU0YovnOV08_kbjazqfpRlWhnQ>
    <xmx:wa2QarFUnyNe-9vEHNTvafhiroNnItF0TagBlCjvGscgUHb1NuHfLA>
    <xmx:wa2Qaj-8PJ6WDQFw0Yl5iHxG7OTIQhqqEEVtQ_U2CPcIDRmd3lpYc5v6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 17:36:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
Subject: [PATCH] do not pass "repo" to builtin commmand implementations
In-Reply-To: <xmqq7blb8g04.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	27 Aug 2026 13:28:43 -0700")
References: <20260827-env-is_bare_repo-v1-1-aa99600dc213@gmail.com>
	<xmqqo6en8jof.fsf@gitster.g> <xmqqh5kf8hqc.fsf@gitster.g>
	<DKZZYSTLY6TX.2TDQEBBOG5IAV@gmail.com> <xmqq7blb8g04.fsf@gitster.g>
Date: Thu, 27 Aug 2026 14:35:59 -0700
Message-ID: <xmqqmru76ybk.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I actually think a good medium size project is to fix the last
> parameter given to cmd_foo() built-in command implementations that
> is a pointer to "struct repository".  It was a misguided design.

Such a patch would look like this.  I am sending it out mostly for
illustration, but it applies cleanly to today's 'master' and the
result passes the test suite.

As it affects everything inside builtin/, it may be tricky to find
the time when it is appropriate to apply a patch like this one, but
in not so longer term it would be worth doing to avoid wasted work.

Opinions?

----- >8 -----

Earlier, commit 9b1cb5070f (builtin: add a repository parameter for
builtin functions, 2024-09-13) added a 'repo' parameter to built-in
command implementations, but this was largely a misguided design.

We claimed that this would help reduce direct use of 'the_repository'
and aid the libification effort.  However, it does not.  These
built-in implementations are not intended to be reusable library
routines to begin with.

Furthermore, when the 'repo' parameter given to them is non-NULL, it
is always 'the_repository'.  To safely use the passed-in 'repo'
instead of 'the_repository', an implementation must handle the case
where 'repo' is NULL (which happens when running outside a
repository) and rely on fallback logic such as defaulting back to
'the_repository'.

Quite honestly, it is wasteful makework.

Replace the 'repo' parameter given to cmd_foo() in builtin/ with a
boolean 'has_repo' flag.  This ensures that these builtin
implementations can still tell when they are invoked outside a
repository, and also ensures that developers do not waste time
modifying '.c' files under builtin/ to reduce uses of
'the_repository'.  That effort is better spent libifying code
outside the builtin/ directory where it truly matters.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/MyFirstContribution.adoc |   8 +-
 Documentation/MyFirstObjectWalk.adoc   |  16 +-
 builtin.h                              | 292 ++++++++++++++++-----------------
 builtin/add.c                          |  47 +++---
 builtin/am.c                           |   2 +-
 builtin/annotate.c                     |   4 +-
 builtin/apply.c                        |   8 +-
 builtin/archive.c                      |   5 +-
 builtin/backfill.c                     |   8 +-
 builtin/bisect.c                       |   4 +-
 builtin/blame.c                        |   2 +-
 builtin/branch.c                       |   2 +-
 builtin/bugreport.c                    |   2 +-
 builtin/bundle.c                       |   4 +-
 builtin/cat-file.c                     |   2 +-
 builtin/check-attr.c                   |   2 +-
 builtin/check-ignore.c                 |   2 +-
 builtin/check-mailmap.c                |   2 +-
 builtin/check-ref-format.c             |   2 +-
 builtin/checkout--worker.c             |   2 +-
 builtin/checkout-index.c               |  29 ++--
 builtin/checkout.c                     |   6 +-
 builtin/clean.c                        |   2 +-
 builtin/clone.c                        |   2 +-
 builtin/column.c                       |   2 +-
 builtin/commit-graph.c                 |   4 +-
 builtin/commit-tree.c                  |   2 +-
 builtin/commit.c                       |   4 +-
 builtin/config.c                       |   4 +-
 builtin/count-objects.c                |   2 +-
 builtin/credential-cache--daemon.c     |   4 +-
 builtin/credential-cache.c             |   4 +-
 builtin/credential-store.c             |   2 +-
 builtin/credential.c                   |   2 +-
 builtin/describe.c                     |   2 +-
 builtin/diagnose.c                     |   2 +-
 builtin/diff-files.c                   |   2 +-
 builtin/diff-index.c                   |   2 +-
 builtin/diff-pairs.c                   |  11 +-
 builtin/diff-tree.c                    |   2 +-
 builtin/diff.c                         |   2 +-
 builtin/difftool.c                     |  13 +-
 builtin/fast-export.c                  |   2 +-
 builtin/fast-import.c                  |   4 +-
 builtin/fetch-pack.c                   |   2 +-
 builtin/fetch.c                        |   2 +-
 builtin/fmt-merge-msg.c                |   5 +-
 builtin/for-each-ref.c                 |   5 +-
 builtin/for-each-repo.c                |   2 +-
 builtin/fsck.c                         |  61 +++----
 builtin/fsmonitor--daemon.c            |   4 +-
 builtin/gc.c                           |   6 +-
 builtin/get-tar-commit-id.c            |   2 +-
 builtin/grep.c                         |   2 +-
 builtin/hash-object.c                  |   2 +-
 builtin/help.c                         |   2 +-
 builtin/history.c                      |   4 +-
 builtin/hook.c                         |   4 +-
 builtin/index-pack.c                   |   2 +-
 builtin/init-db.c                      |   2 +-
 builtin/interpret-trailers.c           |   2 +-
 builtin/last-modified.c                |   7 +-
 builtin/log.c                          |  12 +-
 builtin/ls-files.c                     |  23 +--
 builtin/ls-remote.c                    |   2 +-
 builtin/ls-tree.c                      |   2 +-
 builtin/mailinfo.c                     |   2 +-
 builtin/mailsplit.c                    |   2 +-
 builtin/merge-base.c                   |   2 +-
 builtin/merge-file.c                   |   6 +-
 builtin/merge-index.c                  |   2 +-
 builtin/merge-ours.c                   |  13 +-
 builtin/merge-recursive.c              |   2 +-
 builtin/merge-tree.c                   |   2 +-
 builtin/merge.c                        |   2 +-
 builtin/mktag.c                        |   4 +-
 builtin/mktree.c                       |   7 +-
 builtin/multi-pack-index.c             |   4 +-
 builtin/mv.c                           |   2 +-
 builtin/name-rev.c                     |   4 +-
 builtin/notes.c                        |   4 +-
 builtin/pack-objects.c                 |   2 +-
 builtin/pack-redundant.c               |   2 +-
 builtin/pack-refs.c                    |   5 +-
 builtin/patch-id.c                     |   2 +-
 builtin/prune-packed.c                 |   2 +-
 builtin/prune.c                        |  19 ++-
 builtin/pull.c                         |   2 +-
 builtin/push.c                         |   2 +-
 builtin/range-diff.c                   |   2 +-
 builtin/read-tree.c                    |   2 +-
 builtin/rebase.c                       |   2 +-
 builtin/receive-pack.c                 |   2 +-
 builtin/reflog.c                       |   6 +-
 builtin/refs.c                         |   5 +-
 builtin/remote-ext.c                   |   2 +-
 builtin/remote-fd.c                    |   2 +-
 builtin/remote.c                       |   4 +-
 builtin/repack.c                       |  49 +++---
 builtin/replace.c                      |   2 +-
 builtin/replay.c                       |  11 +-
 builtin/repo.c                         |   4 +-
 builtin/rerere.c                       |   2 +-
 builtin/reset.c                        |   2 +-
 builtin/rev-list.c                     |   2 +-
 builtin/rev-parse.c                    |   2 +-
 builtin/revert.c                       |   8 +-
 builtin/rm.c                           |   2 +-
 builtin/send-pack.c                    |   9 +-
 builtin/shortlog.c                     |   2 +-
 builtin/show-branch.c                  |   2 +-
 builtin/show-index.c                   |   2 +-
 builtin/show-ref.c                     |   6 +-
 builtin/sparse-checkout.c              |   8 +-
 builtin/stash.c                        |   6 +-
 builtin/stripspace.c                   |   2 +-
 builtin/submodule--helper.c            |   4 +-
 builtin/symbolic-ref.c                 |   2 +-
 builtin/tag.c                          |   2 +-
 builtin/unpack-file.c                  |   2 +-
 builtin/unpack-objects.c               |   4 +-
 builtin/update-index.c                 |   2 +-
 builtin/update-ref.c                   |   2 +-
 builtin/update-server-info.c           |   7 +-
 builtin/upload-archive.c               |   8 +-
 builtin/upload-pack.c                  |   2 +-
 builtin/url-parse.c                    |   2 +-
 builtin/var.c                          |   2 +-
 builtin/verify-commit.c                |   7 +-
 builtin/verify-pack.c                  |   2 +-
 builtin/verify-tag.c                   |   9 +-
 builtin/worktree.c                     |   4 +-
 builtin/write-tree.c                   |   2 +-
 git.c                                  |   4 +-
 help.c                                 |   2 +-
 135 files changed, 507 insertions(+), 486 deletions(-)

diff --git c/Documentation/MyFirstContribution.adoc w/Documentation/MyFirstContribution.adoc
index 34bfa2e3a9..8dfcfd0b93 100644
--- c/Documentation/MyFirstContribution.adoc
+++ w/Documentation/MyFirstContribution.adoc
@@ -152,7 +152,7 @@ point for your command in a function matching the style and signature:
 
 ----
 int cmd_psuh(int argc UNUSED, const char **argv UNUSED,
-	     const char *prefix UNUSED, struct repository *repo UNUSED)
+	     const char *prefix UNUSED, bool has_repo UNUSED)
 ----
 
 A few things to note:
@@ -160,7 +160,7 @@ A few things to note:
 * A subcommand implementation takes its command line arguments
   in `int argc` + `const char **argv`, like `main()` would.
 
-* It also takes two extra parameters, `prefix` and `repo`. What
+* It also takes two extra parameters, `prefix` and `has_repo`. What
   they mean will not be discussed until much later.
 
 * Because this first example will not use any of the parameters,
@@ -175,7 +175,7 @@ declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
 in order to keep the declarations alphabetically sorted:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_psuh(int argc, const char **argv, const char *prefix, bool has_repo);
 ----
 
 Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
@@ -192,7 +192,7 @@ should also do so when writing your user-facing commands in the future.
 
 ----
 int cmd_psuh(int argc UNUSED, const char **argv UNUSED,
-	     const char *prefix UNUSED, struct repository *repo UNUSED)
+	     const char *prefix UNUSED, bool has_repo UNUSED)
 {
 	printf(_("Pony saying hello goes here.\n"));
 	return 0;
diff --git c/Documentation/MyFirstObjectWalk.adoc w/Documentation/MyFirstObjectWalk.adoc
index 413a9fdb05..8e40c685b8 100644
--- c/Documentation/MyFirstObjectWalk.adoc
+++ w/Documentation/MyFirstObjectWalk.adoc
@@ -43,7 +43,7 @@ Open up a new file `builtin/walken.c` and set up the command handler:
 #include "builtin.h"
 #include "trace.h"
 
-int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
+int cmd_walken(int argc, const char **argv, const char *prefix, bool has_repo UNUSED)
 {
 	trace_printf(_("cmd_walken incoming...\n"));
 	return 0;
@@ -67,7 +67,7 @@ We'll need to include the `parse-options.h` header.
 
 ...
 
-int cmd_walken(int argc, const char **argv, const char *prefix)
+int cmd_walken(int argc, const char **argv, const char *prefix, bool has_repo UNUSED)
 {
 	const char * const walken_usage[] = {
 		N_("git walken"),
@@ -86,7 +86,7 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 Also add the relevant line in `builtin.h` near `cmd_version()`:
 
 ----
-int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_walken(int argc, const char **argv, const char *prefix, bool has_repo);
 ----
 
 Include the command in `git.c` in `commands[]` near the entry for `version`,
@@ -237,11 +237,11 @@ static int git_walken_config(const char *var, const char *value,
 Make sure to invoke `repo_config()` with it in your `cmd_walken()`:
 
 ----
-int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
+int cmd_walken(int argc, const char **argv, const char *prefix, bool has_repo UNUSED)
 {
 	...
 
-	repo_config(repo, git_walken_config, NULL);
+	repo_config(the_repository, git_walken_config, NULL);
 
 	...
 }
@@ -263,14 +263,14 @@ We'll also need to include the `revision.h` header:
 
 ...
 
-int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
+int cmd_walken(int argc, const char **argv, const char *prefix, bool has_repo UNUSED)
 {
 	/* This can go wherever you like in your declarations.*/
 	struct rev_info rev;
 	...
 
 	/* This should go after the repo_config() call. */
-	repo_init_revisions(repo, &rev, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 
 	...
 }
@@ -318,7 +318,7 @@ Then let's invoke `final_rev_info_setup()` after the call to
 `repo_init_revisions()`:
 
 ----
-int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
+int cmd_walken(int argc, const char **argv, const char *prefix, bool has_repo UNUSED)
 {
 	...
 
diff --git c/builtin.h w/builtin.h
index 4e47a4ebd3..66d187e4cd 100644
--- c/builtin.h
+++ w/builtin.h
@@ -18,7 +18,7 @@
  *   signature:
  *
  *	int cmd_foo(int argc, const char **argv,
- *		    const char *prefix, struct repository *repo);
+ *		    const char *prefix, bool has_repo);
  *
  * . Add the external declaration for the function to `builtin.h`.
  *
@@ -139,150 +139,150 @@ int is_builtin(const char *s);
 		BUG("unexpected prefix in builtin: %s", (prefix)); \
 } while (0)
 
-int cmd_add(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_am(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_annotate(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_apply(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_archive(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_backfill(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_bisect(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_blame(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_branch(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_bugreport(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_bundle(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_cat_file(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_checkout(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_checkout__worker(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_checkout_index(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_check_attr(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_check_ignore(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_check_mailmap(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_check_ref_format(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_cherry(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_cherry_pick(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_clone(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_clean(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_column(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_commit(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_commit_graph(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_commit_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_config(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_count_objects(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_credential(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_credential_cache(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_credential_store(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_describe(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_diagnose(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_diff_files(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_diff_index(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_diff(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_diff_pairs(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_diff_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_difftool(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_env__helper(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_fast_export(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_fast_import(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_fetch(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_fetch_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_for_each_ref(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_for_each_repo(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_format_patch(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_format_rev(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_fsck(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_gc(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_grep(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_hash_object(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_help(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_history(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_hook(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_index_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_init_db(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_interpret_trailers(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_last_modified(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_log_reflog(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_log(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_ls_files(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_ls_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_ls_remote(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_mailinfo(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_mailsplit(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_maintenance(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_merge(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_merge_base(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_merge_index(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_merge_ours(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_merge_file(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_merge_recursive(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_merge_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_mktag(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_mktree(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_multi_pack_index(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_mv(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_name_rev(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_notes(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_pack_objects(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_pack_redundant(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_patch_id(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_prune(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_prune_packed(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_pull(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_push(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_range_diff(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_read_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_rebase(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_rebase__interactive(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_receive_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_reflog(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_refs(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_remote(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_remote_ext(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_remote_fd(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_repack(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_replay(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_repo(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_rerere(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_reset(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_restore(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_rev_list(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_rev_parse(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_revert(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_rm(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_send_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_shortlog(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_show(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_show_branch(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_show_index(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_sparse_checkout(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_status(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_stash(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_stripspace(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_submodule__helper(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_switch(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_symbolic_ref(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_tag(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_unpack_file(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_unpack_objects(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_update_index(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_update_ref(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_update_server_info(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_upload_archive(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_upload_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_url_parse(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_var(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_verify_commit(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_verify_tag(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_version(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_whatchanged(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_worktree(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_write_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_verify_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_show_ref(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_pack_refs(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_replace(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_add(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_am(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_annotate(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_apply(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_archive(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_backfill(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_bisect(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_blame(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_branch(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_bugreport(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_bundle(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_cat_file(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_checkout(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_checkout__worker(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_checkout_index(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_check_attr(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_check_ignore(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_check_mailmap(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_check_ref_format(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_cherry(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_cherry_pick(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_clone(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_clean(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_column(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_commit(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_commit_graph(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_commit_tree(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_config(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_count_objects(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_credential(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_credential_cache(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_credential_store(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_describe(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_diagnose(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_diff_files(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_diff_index(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_diff(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_diff_pairs(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_diff_tree(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_difftool(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_env__helper(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_fast_export(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_fast_import(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_fetch(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_fetch_pack(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_for_each_ref(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_for_each_repo(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_format_patch(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_format_rev(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_fsck(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_gc(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_grep(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_hash_object(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_help(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_history(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_hook(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_index_pack(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_init_db(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_interpret_trailers(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_last_modified(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_log_reflog(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_log(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_ls_files(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_ls_tree(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_ls_remote(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_mailinfo(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_mailsplit(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_maintenance(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_merge(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_merge_base(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_merge_index(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_merge_ours(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_merge_file(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_merge_recursive(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_merge_tree(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_mktag(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_mktree(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_multi_pack_index(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_mv(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_name_rev(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_notes(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_pack_objects(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_pack_redundant(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_patch_id(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_prune(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_prune_packed(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_pull(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_push(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_range_diff(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_read_tree(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_rebase(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_rebase__interactive(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_receive_pack(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_reflog(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_refs(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_remote(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_remote_ext(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_remote_fd(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_repack(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_replay(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_repo(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_rerere(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_reset(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_restore(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_rev_list(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_rev_parse(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_revert(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_rm(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_send_pack(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_shortlog(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_show(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_show_branch(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_show_index(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_sparse_checkout(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_status(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_stash(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_stripspace(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_submodule__helper(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_switch(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_symbolic_ref(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_tag(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_unpack_file(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_unpack_objects(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_update_index(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_update_ref(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_update_server_info(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_upload_archive(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_upload_pack(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_url_parse(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_var(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_verify_commit(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_verify_tag(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_version(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_whatchanged(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_worktree(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_write_tree(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_verify_pack(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_show_ref(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_pack_refs(int argc, const char **argv, const char *prefix, bool has_repo);
+int cmd_replace(int argc, const char **argv, const char *prefix, bool has_repo);
 
 #endif
diff --git c/builtin/add.c w/builtin/add.c
index eab8f03cad..dc0e862347 100644
--- c/builtin/add.c
+++ w/builtin/add.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2006 Linus Torvalds
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
@@ -455,7 +456,7 @@ static int add_resolved_files(struct repository *repo,
 int cmd_add(int argc,
 	    const char **argv,
 	    const char *prefix,
-	    struct repository *repo)
+	    bool has_repo UNUSED)
 {
 	int exit_status = 0;
 	struct pathspec pathspec;
@@ -468,13 +469,13 @@ int cmd_add(int argc,
 	struct lock_file lock_file = LOCK_INIT;
 	struct odb_transaction *transaction;
 
-	repo_config(repo, add_config, NULL);
+	repo_config(the_repository, add_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
 
-	prepare_repo_settings(repo);
-	repo->settings.command_requires_full_index = 0;
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
 
 	if (interactive_opts.context < -1)
 		die(_("'%s' cannot be negative"), "--unified");
@@ -488,7 +489,7 @@ int cmd_add(int argc,
 			die(_("options '%s' and '%s' cannot be used together"), "--dry-run", "--interactive/--patch");
 		if (pathspec_from_file)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--interactive/--patch");
-		exit(interactive_add(repo, argv + 1, prefix, patch_interactive, &interactive_opts));
+		exit(interactive_add(the_repository, argv + 1, prefix, patch_interactive, &interactive_opts));
 	} else {
 		if (interactive_opts.context != -1)
 			die(_("the option '%s' requires '%s'"), "--unified", "--interactive/--patch");
@@ -501,7 +502,7 @@ int cmd_add(int argc,
 	if (edit_interactive) {
 		if (pathspec_from_file)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--edit");
-		return(edit_patch(repo, argc, argv, prefix));
+		return(edit_patch(the_repository, argc, argv, prefix));
 	}
 	argc--;
 	argv++;
@@ -528,7 +529,7 @@ int cmd_add(int argc,
 			     (0 < addremove_explicit) ||
 			     add_resolved);
 
-	repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 
 	/*
 	 * Check the "pathspec '%s' did not match any files" block
@@ -570,11 +571,11 @@ int cmd_add(int argc,
 		 (!(addremove || take_worktree_changes)
 		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
 
-	if (repo_read_index_preload(repo, &pathspec, 0) < 0)
+	if (repo_read_index_preload(the_repository, &pathspec, 0) < 0)
 		die(_("index file corrupt"));
 
-	die_in_unpopulated_submodule(repo->index, prefix);
-	die_path_inside_submodule(repo->index, &pathspec);
+	die_in_unpopulated_submodule(the_repository->index, prefix);
+	die_path_inside_submodule(the_repository->index, &pathspec);
 
 	if (add_new_files) {
 		int baselen;
@@ -586,13 +587,13 @@ int cmd_add(int argc,
 		}
 
 		/* This picks up the paths that are not tracked */
-		baselen = fill_directory(&dir, repo->index, &pathspec);
+		baselen = fill_directory(&dir, the_repository->index, &pathspec);
 		if (pathspec.nr)
-			seen = prune_directory(repo, &dir, &pathspec, baselen);
+			seen = prune_directory(the_repository, &dir, &pathspec, baselen);
 	}
 
 	if (refresh_only) {
-		exit_status |= refresh(repo, verbose, &pathspec);
+		exit_status |= refresh(the_repository, verbose, &pathspec);
 		goto finish;
 	}
 
@@ -603,7 +604,7 @@ int cmd_add(int argc,
 
 		if (!seen)
 			seen = find_pathspecs_matching_against_index(&pathspec,
-					repo->index, PS_IGNORE_SKIP_WORKTREE);
+					the_repository->index, PS_IGNORE_SKIP_WORKTREE);
 
 		/*
 		 * file_exists() assumes exact match
@@ -639,8 +640,8 @@ int cmd_add(int argc,
 			    !file_exists(path)) {
 				if (ignore_missing) {
 					int dtype = DT_UNKNOWN;
-					if (is_excluded(&dir, repo->index, path, &dtype))
-						dir_add_ignored(&dir, repo->index,
+					if (is_excluded(&dir, the_repository->index, path, &dtype))
+						dir_add_ignored(&dir, the_repository->index,
 								path, pathspec.items[i].len);
 				} else
 					die(_("pathspec '%s' did not match any files"),
@@ -659,15 +660,15 @@ int cmd_add(int argc,
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
-	odb_transaction_begin_or_die(repo->objects, &transaction, 0);
+	odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
 
 	ps_matched = xcalloc(pathspec.nr, 1);
 	if (add_resolved)
-		exit_status |= add_resolved_files(repo, &pathspec, flags);
+		exit_status |= add_resolved_files(the_repository, &pathspec, flags);
 	else if (add_renormalize)
-		exit_status |= renormalize_tracked_files(repo, &pathspec, flags);
+		exit_status |= renormalize_tracked_files(the_repository, &pathspec, flags);
 	else
-		exit_status |= add_files_to_cache(repo, prefix,
+		exit_status |= add_files_to_cache(the_repository, prefix,
 						  &pathspec, ps_matched,
 						  include_sparse, flags, ignored_too);
 
@@ -676,14 +677,14 @@ int cmd_add(int argc,
 		exit(128);
 
 	if (add_new_files)
-		exit_status |= add_files(repo, &dir, flags);
+		exit_status |= add_files(the_repository, &dir, flags);
 
 	if (chmod_arg && pathspec.nr)
-		exit_status |= chmod_pathspec(repo, &pathspec, chmod_arg[0], show_only);
+		exit_status |= chmod_pathspec(the_repository, &pathspec, chmod_arg[0], show_only);
 	odb_transaction_commit(transaction);
 
 finish:
-	if (write_locked_index(repo->index, &lock_file,
+	if (write_locked_index(the_repository->index, &lock_file,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write new index file"));
 
diff --git c/builtin/am.c w/builtin/am.c
index e9623b8307..18a45c58ac 100644
--- c/builtin/am.c
+++ w/builtin/am.c
@@ -2312,7 +2312,7 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
 int cmd_am(int argc,
 	   const char **argv,
 	   const char *prefix,
-	   struct repository *repo UNUSED)
+	   bool has_repo UNUSED)
 {
 	struct am_state state;
 	int binary = -1;
diff --git c/builtin/annotate.c w/builtin/annotate.c
index 7f754f2309..de433f4823 100644
--- c/builtin/annotate.c
+++ w/builtin/annotate.c
@@ -11,7 +11,7 @@
 int cmd_annotate(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo)
+		 bool has_repo)
 {
 	struct strvec args = STRVEC_INIT;
 	const char **args_copy;
@@ -28,7 +28,7 @@ int cmd_annotate(int argc,
 	CALLOC_ARRAY(args_copy, args.nr + 1);
 	COPY_ARRAY(args_copy, args.v, args.nr);
 
-	ret = cmd_blame(args.nr, args_copy, prefix, repo);
+	ret = cmd_blame(args.nr, args_copy, prefix, has_repo);
 
 	strvec_clear(&args);
 	free(args_copy);
diff --git c/builtin/apply.c w/builtin/apply.c
index d642a40251..3094f4c22d 100644
--- c/builtin/apply.c
+++ w/builtin/apply.c
@@ -12,7 +12,7 @@ static const char * const apply_usage[] = {
 int cmd_apply(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo)
+	      bool has_repo)
 {
 	int force_apply = 0;
 	int options = 0;
@@ -35,9 +35,9 @@ int cmd_apply(int argc,
 				   &state, &force_apply, &options,
 				   apply_usage);
 
-	if (repo) {
-		prepare_repo_settings(repo);
-		repo->settings.command_requires_full_index = 0;
+	if (has_repo) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
 	}
 
 	if (check_apply_state(&state, force_apply))
diff --git c/builtin/archive.c w/builtin/archive.c
index 3c1288a123..26d7d23c80 100644
--- c/builtin/archive.c
+++ w/builtin/archive.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2006 Franck Bui-Huu
  * Copyright (c) 2006 Rene Scharfe
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "archive.h"
 #include "gettext.h"
@@ -78,7 +79,7 @@ static int run_remote_archiver(int argc, const char **argv,
 int cmd_archive(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo)
+		bool has_repo UNUSED)
 {
 	const char *exec = "git-upload-archive";
 	char *output = NULL;
@@ -109,7 +110,7 @@ int cmd_archive(int argc,
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-	ret = write_archive(argc, argv, prefix, repo, output, 0);
+	ret = write_archive(argc, argv, prefix, the_repository, output, 0);
 
 out:
 	free(output);
diff --git c/builtin/backfill.c w/builtin/backfill.c
index e71e0f4742..b584421250 100644
--- c/builtin/backfill.c
+++ w/builtin/backfill.c
@@ -139,11 +139,11 @@ static int do_backfill(struct backfill_context *ctx)
 	return ret;
 }
 
-int cmd_backfill(int argc, const char **argv, const char *prefix, struct repository *repo)
+int cmd_backfill(int argc, const char **argv, const char *prefix, bool has_repo UNUSED)
 {
 	int result;
 	struct backfill_context ctx = {
-		.repo = repo,
+		.repo = the_repository,
 		.current_batch = OID_ARRAY_INIT,
 		.min_batch_size = 50000,
 		.sparse = -1,
@@ -169,14 +169,14 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 			     PARSE_OPT_KEEP_ARGV0 |
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	repo_init_revisions(repo, &ctx.revs, prefix);
+	repo_init_revisions(the_repository, &ctx.revs, prefix);
 	argc = setup_revisions(argc, argv, &ctx.revs, NULL);
 
 	if (argc > 1)
 		die(_("unrecognized argument: %s"), argv[1]);
 	reject_unsupported_rev_list_options(&ctx.revs);
 
-	repo_config(repo, git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	if (ctx.sparse < 0)
 		ctx.sparse = cfg->apply_sparse_checkout;
diff --git c/builtin/bisect.c w/builtin/bisect.c
index 1cfb8a794b..045e44af9a 100644
--- c/builtin/bisect.c
+++ w/builtin/bisect.c
@@ -1598,7 +1598,7 @@ static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
 int cmd_bisect(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo)
+	       bool has_repo UNUSED)
 {
 	int res = 0;
 	parse_opt_subcommand_fn *fn = NULL;
@@ -1640,7 +1640,7 @@ int cmd_bisect(int argc,
 	} else {
 		argc--;
 		argv++;
-		res = fn(argc, argv, prefix, repo);
+		res = fn(argc, argv, prefix, the_repository);
 	}
 
 	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
diff --git c/builtin/blame.c w/builtin/blame.c
index 48d5251c6d..2df1dfaacf 100644
--- c/builtin/blame.c
+++ w/builtin/blame.c
@@ -957,7 +957,7 @@ static void build_ignorelist(struct blame_scoreboard *sb,
 int cmd_blame(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      bool has_repo UNUSED)
 {
 	struct rev_info revs;
 	char *path = NULL;
diff --git c/builtin/branch.c w/builtin/branch.c
index a613148fc7..f4258c9e32 100644
--- c/builtin/branch.c
+++ w/builtin/branch.c
@@ -969,7 +969,7 @@ static void die_if_upstream_looks_like_remote(const char *new_upstream, const ch
 int cmd_branch(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       bool has_repo UNUSED)
 {
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
diff --git c/builtin/bugreport.c w/builtin/bugreport.c
index f78c3f2aed..d4ab2cc1a9 100644
--- c/builtin/bugreport.c
+++ w/builtin/bugreport.c
@@ -93,7 +93,7 @@ static void get_header(struct strbuf *buf, const char *title)
 int cmd_bugreport(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  bool has_repo UNUSED)
 {
 	struct strbuf buffer = STRBUF_INIT;
 	struct strbuf report_path = STRBUF_INIT;
diff --git c/builtin/bundle.c w/builtin/bundle.c
index 1e170e9278..3df9a20b57 100644
--- c/builtin/bundle.c
+++ w/builtin/bundle.c
@@ -235,7 +235,7 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix,
 int cmd_bundle(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo)
+	       bool has_repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
@@ -251,5 +251,5 @@ int cmd_bundle(int argc,
 
 	packet_trace_identity("bundle");
 
-	return !!fn(argc, argv, prefix, repo);
+	return !!fn(argc, argv, prefix, the_repository);
 }
diff --git c/builtin/cat-file.c w/builtin/cat-file.c
index 8870a210ec..b61364231e 100644
--- c/builtin/cat-file.c
+++ w/builtin/cat-file.c
@@ -1182,7 +1182,7 @@ static int batch_option_callback(const struct option *opt,
 int cmd_cat_file(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 bool has_repo UNUSED)
 {
 	int opt = 0;
 	int opt_cw = 0;
diff --git c/builtin/check-attr.c w/builtin/check-attr.c
index 217d83ea7d..44dd21b13e 100644
--- c/builtin/check-attr.c
+++ w/builtin/check-attr.c
@@ -110,7 +110,7 @@ static NORETURN void error_with_usage(const char *msg)
 int cmd_check_attr(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	struct attr_check *check;
 	struct object_id initialized_oid;
diff --git c/builtin/check-ignore.c w/builtin/check-ignore.c
index 644c9a414f..bd26521cc6 100644
--- c/builtin/check-ignore.c
+++ w/builtin/check-ignore.c
@@ -155,7 +155,7 @@ static int check_ignore_stdin_paths(struct dir_struct *dir, const char *prefix)
 int cmd_check_ignore(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     bool has_repo UNUSED)
 {
 	int num_ignored;
 	struct dir_struct dir = DIR_INIT;
diff --git c/builtin/check-mailmap.c w/builtin/check-mailmap.c
index 3f2a39cae0..b45b4c4cae 100644
--- c/builtin/check-mailmap.c
+++ w/builtin/check-mailmap.c
@@ -52,7 +52,7 @@ static void check_mailmap(struct string_list *mailmap, const char *contact)
 int cmd_check_mailmap(int argc,
 		      const char **argv,
 		      const char *prefix,
-		      struct repository *repo UNUSED)
+		      bool has_repo UNUSED)
 {
 	int i;
 	struct string_list mailmap = STRING_LIST_INIT_NODUP;
diff --git c/builtin/check-ref-format.c w/builtin/check-ref-format.c
index fd1c9c0e0c..77df939550 100644
--- c/builtin/check-ref-format.c
+++ w/builtin/check-ref-format.c
@@ -56,7 +56,7 @@ static int check_ref_format_branch(const char *arg)
 int cmd_check_ref_format(int argc,
 			 const char **argv,
 			 const char *prefix,
-			 struct repository *repo UNUSED)
+			 bool has_repo UNUSED)
 {
 	int i;
 	int normalize = 0;
diff --git c/builtin/checkout--worker.c w/builtin/checkout--worker.c
index e0772b718b..6af94b0191 100644
--- c/builtin/checkout--worker.c
+++ w/builtin/checkout--worker.c
@@ -120,7 +120,7 @@ static const char * const checkout_worker_usage[] = {
 int cmd_checkout__worker(int argc,
 			 const char **argv,
 			 const char *prefix,
-			 struct repository *repo UNUSED)
+			 bool has_repo UNUSED)
 {
 	struct checkout state = CHECKOUT_INIT;
 	struct option checkout_worker_options[] = {
diff --git c/builtin/checkout-index.c w/builtin/checkout-index.c
index 311b94ff31..ed329cbf81 100644
--- c/builtin/checkout-index.c
+++ w/builtin/checkout-index.c
@@ -5,6 +5,7 @@
  *
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -213,7 +214,7 @@ static int option_parse_stage(const struct option *opt,
 int cmd_checkout_index(int argc,
 		       const char **argv,
 		       const char *prefix,
-		       struct repository *repo)
+		       bool has_repo UNUSED)
 {
 	int i;
 	struct lock_file lock_file = LOCK_INIT;
@@ -253,19 +254,19 @@ int cmd_checkout_index(int argc,
 	show_usage_with_options_if_asked(argc, argv,
 					 builtin_checkout_index_usage,
 					 builtin_checkout_index_options);
-	repo_config(repo, git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	prefix_length = prefix ? strlen(prefix) : 0;
 
-	prepare_repo_settings(repo);
-	repo->settings.command_requires_full_index = 0;
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
 
-	if (repo_read_index(repo) < 0) {
+	if (repo_read_index(the_repository) < 0) {
 		die("invalid cache");
 	}
 
 	argc = parse_options(argc, argv, prefix, builtin_checkout_index_options,
 			builtin_checkout_index_usage, 0);
-	state.istate = repo->index;
+	state.istate = the_repository->index;
 	state.force = force;
 	state.quiet = quiet;
 	state.not_new = not_new;
@@ -285,8 +286,8 @@ int cmd_checkout_index(int argc,
 	 */
 	if (index_opt && !state.base_dir_len && !to_tempfile) {
 		state.refresh_cache = 1;
-		state.istate = repo->index;
-		repo_hold_locked_index(repo, &lock_file,
+		state.istate = the_repository->index;
+		repo_hold_locked_index(the_repository, &lock_file,
 				       LOCK_DIE_ON_ERROR);
 	}
 
@@ -303,8 +304,8 @@ int cmd_checkout_index(int argc,
 			die("git checkout-index: don't mix '--all' and explicit filenames");
 		if (read_from_stdin)
 			die("git checkout-index: don't mix '--stdin' and explicit filenames");
-		p = prefix_path(repo, prefix, prefix_length, arg);
-		err |= checkout_file(repo->index, p, prefix);
+		p = prefix_path(the_repository, prefix, prefix_length, arg);
+		err |= checkout_file(the_repository->index, p, prefix);
 		free(p);
 	}
 
@@ -325,8 +326,8 @@ int cmd_checkout_index(int argc,
 					die("line is badly quoted");
 				strbuf_swap(&buf, &unquoted);
 			}
-			p = prefix_path(repo, prefix, prefix_length, buf.buf);
-			err |= checkout_file(repo->index, p, prefix);
+			p = prefix_path(the_repository, prefix, prefix_length, buf.buf);
+			err |= checkout_file(the_repository->index, p, prefix);
 			free(p);
 		}
 		strbuf_release(&unquoted);
@@ -334,7 +335,7 @@ int cmd_checkout_index(int argc,
 	}
 
 	if (all)
-		err |= checkout_all(repo->index, prefix, prefix_length);
+		err |= checkout_all(the_repository->index, prefix, prefix_length);
 
 	if (pc_workers > 1)
 		err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
@@ -344,7 +345,7 @@ int cmd_checkout_index(int argc,
 		return 1;
 
 	if (is_lock_file_locked(&lock_file) &&
-	    write_locked_index(repo->index, &lock_file, COMMIT_LOCK))
+	    write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		die("Unable to write new index file");
 	return 0;
 }
diff --git c/builtin/checkout.c w/builtin/checkout.c
index 55e3a89a85..2a9fa4dcd3 100644
--- c/builtin/checkout.c
+++ w/builtin/checkout.c
@@ -2092,7 +2092,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 int cmd_checkout(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 bool has_repo UNUSED)
 {
 	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
 	struct option *options;
@@ -2144,7 +2144,7 @@ int cmd_checkout(int argc,
 int cmd_switch(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       bool has_repo UNUSED)
 {
 	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
 	struct option *options = NULL;
@@ -2183,7 +2183,7 @@ int cmd_switch(int argc,
 int cmd_restore(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		bool has_repo UNUSED)
 {
 	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
 	struct option *options;
diff --git c/builtin/clean.c w/builtin/clean.c
index 1d5e7e5366..69df102fd0 100644
--- c/builtin/clean.c
+++ w/builtin/clean.c
@@ -919,7 +919,7 @@ static void correct_untracked_entries(struct dir_struct *dir)
 int cmd_clean(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      bool has_repo UNUSED)
 {
 	int i, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
diff --git c/builtin/clone.c w/builtin/clone.c
index 5b25cca510..ea1e85e2a8 100644
--- c/builtin/clone.c
+++ w/builtin/clone.c
@@ -869,7 +869,7 @@ static int path_exists(const char *path)
 int cmd_clone(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repository UNUSED)
+	      bool has_repo UNUSED)
 {
 	int is_bundle = 0, is_local;
 	int reject_shallow = 0;
diff --git c/builtin/column.c w/builtin/column.c
index 87dce3c6e5..d4262a08b0 100644
--- c/builtin/column.c
+++ w/builtin/column.c
@@ -22,7 +22,7 @@ static int column_config(const char *var, const char *value,
 int cmd_column(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       bool has_repo UNUSED)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
 	struct strbuf sb = STRBUF_INIT;
diff --git c/builtin/commit-graph.c w/builtin/commit-graph.c
index d62005edc0..a350a05291 100644
--- c/builtin/commit-graph.c
+++ w/builtin/commit-graph.c
@@ -341,7 +341,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 int cmd_commit_graph(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo)
+		     bool has_repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_commit_graph_options[] = {
@@ -360,5 +360,5 @@ int cmd_commit_graph(int argc,
 			     builtin_commit_graph_usage, 0);
 	FREE_AND_NULL(options);
 
-	return fn(argc, argv, prefix, repo);
+	return fn(argc, argv, prefix, the_repository);
 }
diff --git c/builtin/commit-tree.c w/builtin/commit-tree.c
index 30535db131..cbfe4fe3a0 100644
--- c/builtin/commit-tree.c
+++ w/builtin/commit-tree.c
@@ -95,7 +95,7 @@ static int parse_file_arg_callback(const struct option *opt,
 int cmd_commit_tree(int argc,
 		    const char **argv,
 		    const char *prefix,
-		    struct repository *repo UNUSED)
+		    bool has_repo UNUSED)
 {
 	static struct strbuf buffer = STRBUF_INIT;
 	struct commit_list *parents = NULL;
diff --git c/builtin/commit.c w/builtin/commit.c
index 28f6174503..92317ec2fc 100644
--- c/builtin/commit.c
+++ w/builtin/commit.c
@@ -1537,7 +1537,7 @@ static int git_status_config(const char *k, const char *v,
 int cmd_status(int argc,
 const char **argv,
 const char *prefix,
-struct repository *repo UNUSED)
+bool has_repo UNUSED)
 {
 	static int no_renames = -1;
 	static const char *rename_score_arg = (const char *)-1;
@@ -1698,7 +1698,7 @@ static int git_commit_config(const char *k, const char *v,
 int cmd_commit(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       bool has_repo UNUSED)
 {
 	static struct wt_status s;
 	static const char *cleanup_arg = NULL;
diff --git c/builtin/config.c w/builtin/config.c
index 2554322317..b5e2fd42f1 100644
--- c/builtin/config.c
+++ w/builtin/config.c
@@ -1627,7 +1627,7 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 int cmd_config(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo)
+	       bool has_repo UNUSED)
 {
 	parse_opt_subcommand_fn *subcommand = NULL;
 	struct option subcommand_opts[] = {
@@ -1654,7 +1654,7 @@ int cmd_config(int argc,
 	if (subcommand) {
 		argc = parse_options(argc, argv, prefix, subcommand_opts, builtin_config_usage,
 		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
-		return subcommand(argc, argv, prefix, repo);
+		return subcommand(argc, argv, prefix, the_repository);
 	}
 
 	return cmd_config_actions(argc, argv, prefix);
diff --git c/builtin/count-objects.c w/builtin/count-objects.c
index 18f6e33b6f..aabe93aaef 100644
--- c/builtin/count-objects.c
+++ w/builtin/count-objects.c
@@ -97,7 +97,7 @@ static char const * const count_objects_usage[] = {
 int cmd_count_objects(int argc,
 		      const char **argv,
 		      const char *prefix,
-		      struct repository *repo UNUSED)
+		      bool has_repo UNUSED)
 {
 	int human_readable = 0;
 	struct option opts[] = {
diff --git c/builtin/credential-cache--daemon.c w/builtin/credential-cache--daemon.c
index 65cc619bec..11bb8007b6 100644
--- c/builtin/credential-cache--daemon.c
+++ w/builtin/credential-cache--daemon.c
@@ -291,7 +291,7 @@ static void init_socket_directory(const char *path)
 int cmd_credential_cache_daemon(int argc,
 				const char **argv,
 				const char *prefix,
-				struct repository *repo UNUSED)
+				bool has_repo UNUSED)
 {
 	struct tempfile *socket_file;
 	const char *socket_path;
@@ -337,7 +337,7 @@ int cmd_credential_cache_daemon(int argc,
 int cmd_credential_cache_daemon(int argc,
 const char **argv,
 const char *prefix,
-struct repository *repo UNUSED)
+bool has_repo UNUSED)
 {
 	const char * const usage[] = {
 		"git credential-cache--daemon [--debug] <socket-path>",
diff --git c/builtin/credential-cache.c w/builtin/credential-cache.c
index 7f733cb756..97298070bf 100644
--- c/builtin/credential-cache.c
+++ w/builtin/credential-cache.c
@@ -140,7 +140,7 @@ static void announce_capabilities(void)
 int cmd_credential_cache(int argc,
 			 const char **argv,
 			 const char *prefix,
-			 struct repository *repo UNUSED)
+			 bool has_repo UNUSED)
 {
 	const char *socket_path_arg = NULL;
 	char *socket_path;
@@ -190,7 +190,7 @@ int cmd_credential_cache(int argc,
 #else
 
 int cmd_credential_cache(int argc, const char **argv, const char *prefix,
-			 struct repository *repo UNUSED)
+			 bool has_repo UNUSED)
 {
 	const char * const usage[] = {
 		"git credential-cache [options] <action>",
diff --git c/builtin/credential-store.c w/builtin/credential-store.c
index bc1453c6b2..9ccdd7aeb6 100644
--- c/builtin/credential-store.c
+++ w/builtin/credential-store.c
@@ -169,7 +169,7 @@ static void lookup_credential(const struct string_list *fns, struct credential *
 int cmd_credential_store(int argc,
 			 const char **argv,
 			 const char *prefix,
-			 struct repository *repo UNUSED)
+			 bool has_repo UNUSED)
 {
 	const char * const usage[] = {
 		"git credential-store [<options>] <action>",
diff --git c/builtin/credential.c w/builtin/credential.c
index a295c80b36..a1024a57f6 100644
--- c/builtin/credential.c
+++ w/builtin/credential.c
@@ -12,7 +12,7 @@ static const char usage_msg[] =
 int cmd_credential(int argc,
 		   const char **argv,
 		   const char *prefix UNUSED,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	const char *op;
 	struct credential c = CREDENTIAL_INIT;
diff --git c/builtin/describe.c w/builtin/describe.c
index c0abc931a5..84983debfe 100644
--- c/builtin/describe.c
+++ w/builtin/describe.c
@@ -601,7 +601,7 @@ static int option_parse_exact_match(const struct option *opt, const char *arg,
 int cmd_describe(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED )
+		 bool has_repo UNUSED)
 {
 	struct refs_for_each_ref_options for_each_ref_opts = {
 		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
diff --git c/builtin/diagnose.c w/builtin/diagnose.c
index ec86d66389..120121cc8f 100644
--- c/builtin/diagnose.c
+++ w/builtin/diagnose.c
@@ -16,7 +16,7 @@ static const char * const diagnose_usage[] = {
 int cmd_diagnose(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 bool has_repo UNUSED)
 {
 	struct strbuf zip_path = STRBUF_INIT;
 	time_t now = time(NULL);
diff --git c/builtin/diff-files.c w/builtin/diff-files.c
index ea91347ce2..4e6a662987 100644
--- c/builtin/diff-files.c
+++ w/builtin/diff-files.c
@@ -23,7 +23,7 @@ COMMON_DIFF_OPTIONS_HELP;
 int cmd_diff_files(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	struct rev_info rev;
 	int result;
diff --git c/builtin/diff-index.c w/builtin/diff-index.c
index 3db7cffede..9d217592d3 100644
--- c/builtin/diff-index.c
+++ w/builtin/diff-index.c
@@ -19,7 +19,7 @@ COMMON_DIFF_OPTIONS_HELP;
 int cmd_diff_index(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	struct rev_info rev;
 	unsigned int option = 0;
diff --git c/builtin/diff-pairs.c w/builtin/diff-pairs.c
index 71c045331a..ba40e2daca 100644
--- c/builtin/diff-pairs.c
+++ w/builtin/diff-pairs.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
@@ -28,7 +29,7 @@ static void parse_oid_or_die(const char *hex, struct object_id *oid,
 }
 
 int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
-		   struct repository *repo)
+		   bool has_repo UNUSED)
 {
 	struct strbuf path_dst = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
@@ -46,7 +47,7 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	repo_init_revisions(repo, &revs, prefix);
+	repo_init_revisions(the_repository, &revs, prefix);
 
 	/*
 	 * Diff options are usually parsed implicitly as part of
@@ -56,7 +57,7 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
 	parseopts = add_diff_options(builtin_diff_pairs_options, &revs.diffopt);
 	show_usage_with_options_if_asked(argc, argv, builtin_diff_pairs_usage, parseopts);
 
-	repo_config(repo, git_diff_basic_config, NULL);
+	repo_config(the_repository, git_diff_basic_config, NULL);
 	revs.diffopt.no_free = 1;
 	revs.disable_stdin = 1;
 	revs.abbrev = 0;
@@ -129,8 +130,8 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
 		if (S_ISDIR(mode_a) || S_ISDIR(mode_b))
 			die(_("tree objects not supported"));
 
-		parse_oid_or_die(p, &oid_a, &p, repo->hash_algo);
-		parse_oid_or_die(p, &oid_b, &p, repo->hash_algo);
+		parse_oid_or_die(p, &oid_a, &p, the_repository->hash_algo);
+		parse_oid_or_die(p, &oid_b, &p, the_repository->hash_algo);
 
 		status = *p++;
 
diff --git c/builtin/diff-tree.c w/builtin/diff-tree.c
index 8b8f8b54e4..4733798e5a 100644
--- c/builtin/diff-tree.c
+++ w/builtin/diff-tree.c
@@ -112,7 +112,7 @@ static void diff_tree_tweak_rev(struct rev_info *rev)
 int cmd_diff_tree(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  bool has_repo UNUSED)
 {
 	char line[1000];
 	struct object *tree1, *tree2;
diff --git c/builtin/diff.c w/builtin/diff.c
index 18b1083e98..75c4120b74 100644
--- c/builtin/diff.c
+++ w/builtin/diff.c
@@ -399,7 +399,7 @@ static void symdiff_release(struct symdiff *sdiff)
 int cmd_diff(int argc,
 	     const char **argv,
 	     const char *prefix,
-	     struct repository *repo UNUSED)
+	     bool has_repo UNUSED)
 {
 	int i;
 	struct rev_info rev;
diff --git c/builtin/difftool.c w/builtin/difftool.c
index bc7b2ea443..18ca0e313b 100644
--- c/builtin/difftool.c
+++ w/builtin/difftool.c
@@ -12,6 +12,7 @@
  * Copyright (C) 2016 Johannes Schindelin
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 
 #include "abspath.h"
@@ -717,7 +718,7 @@ static int run_file_diff(int prompt, const char *prefix,
 int cmd_difftool(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo)
+		 bool has_repo UNUSED)
 {
 	int use_gui_tool = -1, dir_diff = 0, prompt = -1, tool_help = 0, no_index = 0;
 	static char *difftool_cmd = NULL, *extcmd = NULL;
@@ -753,7 +754,7 @@ int cmd_difftool(int argc,
 	};
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	repo_config(repo, difftool_config, &dt_options);
+	repo_config(the_repository, difftool_config, &dt_options);
 	dt_options.symlinks = dt_options.has_symlinks;
 
 	argc = parse_options(argc, argv, prefix, builtin_difftool_options,
@@ -767,9 +768,9 @@ int cmd_difftool(int argc,
 		die(_("difftool requires worktree or --no-index"));
 
 	if (!no_index){
-		setup_work_tree(repo);
-		setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_dir(repo)), 1);
-		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_work_tree(repo)), 1);
+		setup_work_tree(the_repository);
+		setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_dir(the_repository)), 1);
+		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_work_tree(the_repository)), 1);
 	} else if (dir_diff)
 		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
 
@@ -818,6 +819,6 @@ int cmd_difftool(int argc,
 	strvec_pushv(&child.args, argv);
 
 	if (dir_diff)
-		return run_dir_diff(repo, &dt_options, extcmd, prefix, &child);
+		return run_dir_diff(the_repository, &dt_options, extcmd, prefix, &child);
 	return run_file_diff(prompt, prefix, &child);
 }
diff --git c/builtin/fast-export.c w/builtin/fast-export.c
index 50278bef7a..cd7f4e90d9 100644
--- c/builtin/fast-export.c
+++ w/builtin/fast-export.c
@@ -1310,7 +1310,7 @@ static int parse_opt_anonymize_map(const struct option *opt,
 int cmd_fast_export(int argc,
 		    const char **argv,
 		    const char *prefix,
-		    struct repository *repo UNUSED)
+		    bool has_repo UNUSED)
 {
 	struct rev_info revs;
 	struct commit *commit;
diff --git c/builtin/fast-import.c w/builtin/fast-import.c
index fbd919982c..c547bf7281 100644
--- c/builtin/fast-import.c
+++ w/builtin/fast-import.c
@@ -4123,7 +4123,7 @@ static int option_parse_quiet(const struct option *opt UNUSED,
 int cmd_fast_import(int argc,
 		    const char **argv,
 		    const char *prefix,
-		    struct repository *repo)
+		    bool has_repo UNUSED)
 {
 	struct fast_import_state state;
 
@@ -4320,7 +4320,7 @@ int cmd_fast_import(int argc,
 		fprintf(stderr, "       pools:    %10lu KiB\n", (unsigned long)((tree_entry_allocd + fi_mem_pool.pool_alloc) /1024));
 		fprintf(stderr, "     objects:    %10" PRIuMAX " KiB\n", (alloc_count*sizeof(struct object_entry))/1024);
 		fprintf(stderr, "---------------------------------------------------------------------\n");
-		pack_report(repo);
+		pack_report(the_repository);
 		fprintf(stderr, "---------------------------------------------------------------------\n");
 		fprintf(stderr, "\n");
 	}
diff --git c/builtin/fetch-pack.c w/builtin/fetch-pack.c
index 316badd969..16fcca7777 100644
--- c/builtin/fetch-pack.c
+++ w/builtin/fetch-pack.c
@@ -49,7 +49,7 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
 int cmd_fetch_pack(int argc,
 		   const char **argv,
 		   const char *prefix UNUSED,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	int i, ret;
 	struct ref *fetched_refs = NULL, *remote_refs = NULL;
diff --git c/builtin/fetch.c w/builtin/fetch.c
index ab7db2be06..15fea4ce09 100644
--- c/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -2505,7 +2505,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 int cmd_fetch(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      bool has_repo UNUSED)
 {
 	struct fetch_config config = {
 		.display_format = DISPLAY_FORMAT_FULL,
diff --git c/builtin/fmt-merge-msg.c w/builtin/fmt-merge-msg.c
index cf4273a52c..44db2133bc 100644
--- c/builtin/fmt-merge-msg.c
+++ w/builtin/fmt-merge-msg.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "fmt-merge-msg.h"
@@ -12,7 +13,7 @@ static const char * const fmt_merge_msg_usage[] = {
 int cmd_fmt_merge_msg(int argc,
 		      const char **argv,
 		      const char *prefix,
-		      struct repository *repo)
+		      bool has_repo UNUSED)
 {
 	char *inpath = NULL;
 	const char *message = NULL;
@@ -53,7 +54,7 @@ int cmd_fmt_merge_msg(int argc,
 	int ret;
 	struct fmt_merge_msg_opts opts;
 
-	repo_config(repo, fmt_merge_msg_config, &merge_log_config);
+	repo_config(the_repository, fmt_merge_msg_config, &merge_log_config);
 	argc = parse_options(argc, argv, prefix, options, fmt_merge_msg_usage,
 			     0);
 	if (argc > 0)
diff --git c/builtin/for-each-ref.c w/builtin/for-each-ref.c
index 4a2fc421db..25c84bca6b 100644
--- c/builtin/for-each-ref.c
+++ w/builtin/for-each-ref.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "commit.h"
 #include "config.h"
@@ -113,12 +114,12 @@ int for_each_ref_core(int argc, const char **argv, const char *prefix, struct re
 int cmd_for_each_ref(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo)
+		     bool has_repo UNUSED)
 {
 	static char const * const for_each_ref_usage[] = {
 		N_("git for-each-ref " COMMON_USAGE_FOR_EACH_REF),
 		NULL
 	};
 
-	return for_each_ref_core(argc, argv, prefix, repo, for_each_ref_usage);
+	return for_each_ref_core(argc, argv, prefix, the_repository, for_each_ref_usage);
 }
diff --git c/builtin/for-each-repo.c w/builtin/for-each-repo.c
index 927d3d92da..80b0cb0739 100644
--- c/builtin/for-each-repo.c
+++ w/builtin/for-each-repo.c
@@ -33,7 +33,7 @@ static int run_command_on_repo(const char *path, const char **argv)
 int cmd_for_each_repo(int argc,
 		      const char **argv,
 		      const char *prefix,
-		      struct repository *repo UNUSED)
+		      bool has_repo UNUSED)
 {
 	static const char *config_key = NULL;
 	int keep_going = 0;
diff --git c/builtin/fsck.c w/builtin/fsck.c
index a6c054e45b..f3083c0e7a 100644
--- c/builtin/fsck.c
+++ w/builtin/fsck.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
@@ -1008,7 +1009,7 @@ static struct option fsck_opts[] = {
 int cmd_fsck(int argc,
 	     const char **argv,
 	     const char *prefix,
-	     struct repository *repo)
+	     bool has_repo UNUSED)
 {
 	struct odb_source *source;
 	struct snapshot snap = {
@@ -1026,10 +1027,10 @@ int cmd_fsck(int argc,
 
 	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
 
-	fsck_options_init(&fsck_walk_options, repo, FSCK_OPTIONS_DEFAULT);
+	fsck_options_init(&fsck_walk_options, the_repository, FSCK_OPTIONS_DEFAULT);
 	fsck_walk_options.walk = mark_object;
 
-	fsck_options_init(&fsck_obj_options, repo, FSCK_OPTIONS_DEFAULT);
+	fsck_options_init(&fsck_obj_options, the_repository, FSCK_OPTIONS_DEFAULT);
 	fsck_obj_options.walk = mark_used;
 	fsck_obj_options.error_func = fsck_objects_error_func;
 	if (check_strict)
@@ -1048,11 +1049,11 @@ int cmd_fsck(int argc,
 	if (name_objects)
 		fsck_enable_object_names(&fsck_walk_options);
 
-	repo_config(repo, git_fsck_config, &fsck_obj_options);
-	prepare_repo_settings(repo);
+	repo_config(the_repository, git_fsck_config, &fsck_obj_options);
+	prepare_repo_settings(the_repository);
 
 	if (check_references)
-		fsck_refs(repo);
+		fsck_refs(the_repository);
 
 	/*
 	 * Take a snapshot of the refs before walking objects to avoid looking
@@ -1060,18 +1061,18 @@ int cmd_fsck(int argc,
 	 * objects. We can still walk over new objects that are added during the
 	 * execution of fsck but won't miss any objects that were reachable.
 	 */
-	snapshot_refs(repo, &snap, argc, argv);
+	snapshot_refs(the_repository, &snap, argc, argv);
 
 	/* Ensure we get a "fresh" view of the odb */
-	odb_reprepare(repo->objects);
+	odb_reprepare(the_repository->objects);
 
 	if (connectivity_only) {
-		odb_for_each_object(repo->objects, NULL,
-				    mark_object_for_connectivity, repo, 0);
+		odb_for_each_object(the_repository->objects, NULL,
+				    mark_object_for_connectivity, the_repository, 0);
 	} else {
-		odb_prepare_alternates(repo->objects);
-		for (source = repo->objects->sources; source; source = source->next)
-			fsck_source(repo, source);
+		odb_prepare_alternates(the_repository->objects);
+		for (source = the_repository->objects->sources; source; source = source->next)
+			fsck_source(the_repository, source);
 
 		if (check_full) {
 			struct packed_git *p;
@@ -1079,20 +1080,20 @@ int cmd_fsck(int argc,
 			struct progress *progress = NULL;
 
 			if (show_progress) {
-				repo_for_each_pack(repo, p) {
+				repo_for_each_pack(the_repository, p) {
 					if (open_pack_index(p))
 						continue;
 					total += p->num_objects;
 				}
 
-				progress = start_progress(repo,
+				progress = start_progress(the_repository,
 							  _("Checking objects"), total);
 			}
 
-			repo_for_each_pack(repo, p) {
+			repo_for_each_pack(the_repository, p) {
 				/* verify gives error messages itself */
-				if (verify_pack(repo,
-						p, fsck_obj_buffer, repo,
+				if (verify_pack(the_repository,
+						p, fsck_obj_buffer, the_repository,
 						progress, count))
 					errors_found |= ERROR_PACK;
 				count += p->num_objects;
@@ -1105,7 +1106,7 @@ int cmd_fsck(int argc,
 	}
 
 	/* Process the snapshotted refs and the reflogs. */
-	process_refs(repo, &snap);
+	process_refs(the_repository, &snap);
 
 	/* If not given any explicit objects, process index files too. */
 	if (!argc)
@@ -1121,11 +1122,11 @@ int cmd_fsck(int argc,
 		verify_index_checksum = 1;
 		verify_ce_order = 1;
 
-		worktrees = get_worktrees(repo);
+		worktrees = get_worktrees(the_repository);
 		for (p = worktrees; *p; p++) {
 			struct worktree *wt = *p;
 			struct index_state istate =
-				INDEX_STATE_INIT(repo);
+				INDEX_STATE_INIT(the_repository);
 			char *path, *wt_gitdir;
 
 			/*
@@ -1146,17 +1147,17 @@ int cmd_fsck(int argc,
 		free_worktrees(worktrees);
 	}
 
-	errors_found |= check_pack_rev_indexes(repo, show_progress);
-	if (verify_bitmap_files(repo))
+	errors_found |= check_pack_rev_indexes(the_repository, show_progress);
+	if (verify_bitmap_files(the_repository))
 		errors_found |= ERROR_BITMAP;
 
-	check_connectivity(repo);
+	check_connectivity(the_repository);
 
-	if (repo->settings.core_commit_graph) {
+	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
-		odb_prepare_alternates(repo->objects);
-		for (source = repo->objects->sources; source; source = source->next) {
+		odb_prepare_alternates(the_repository->objects);
+		for (source = the_repository->objects->sources; source; source = source->next) {
 			child_process_init(&commit_graph_verify);
 			commit_graph_verify.git_cmd = 1;
 			strvec_pushl(&commit_graph_verify.args, "commit-graph",
@@ -1170,11 +1171,11 @@ int cmd_fsck(int argc,
 		}
 	}
 
-	if (repo->settings.core_multi_pack_index) {
+	if (the_repository->settings.core_multi_pack_index) {
 		struct child_process midx_verify = CHILD_PROCESS_INIT;
 
-		odb_prepare_alternates(repo->objects);
-		for (source = repo->objects->sources; source; source = source->next) {
+		odb_prepare_alternates(the_repository->objects);
+		for (source = the_repository->objects->sources; source; source = source->next) {
 			child_process_init(&midx_verify);
 			midx_verify.git_cmd = 1;
 			strvec_pushl(&midx_verify.args, "multi-pack-index",
diff --git c/builtin/fsmonitor--daemon.c w/builtin/fsmonitor--daemon.c
index 4161dd8282..f1df9a7dd1 100644
--- c/builtin/fsmonitor--daemon.c
+++ w/builtin/fsmonitor--daemon.c
@@ -1568,7 +1568,7 @@ static int try_to_start_background_daemon(void)
 int cmd_fsmonitor__daemon(int argc,
 			  const char **argv,
 			  const char *prefix,
-			  struct repository *repo UNUSED)
+			  bool has_repo UNUSED)
 {
 	const char *subcmd;
 	enum fsmonitor_reason reason;
@@ -1631,7 +1631,7 @@ int cmd_fsmonitor__daemon(int argc,
 }
 
 #else
-int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED)
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix UNUSED, bool has_repo UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
diff --git c/builtin/gc.c w/builtin/gc.c
index de2f9e7fed..611cac5eb0 100644
--- c/builtin/gc.c
+++ w/builtin/gc.c
@@ -582,7 +582,7 @@ static int maintenance_task_odb(struct maintenance_run_opts *opts,
 int cmd_gc(int argc,
 	   const char **argv,
 	   const char *prefix,
-	   struct repository *repo UNUSED)
+	   bool has_repo UNUSED)
 {
 	int aggressive = 0;
 	int force = 0;
@@ -3141,7 +3141,7 @@ static const char *const builtin_maintenance_usage[] = {
 int cmd_maintenance(int argc,
 		    const char **argv,
 		    const char *prefix,
-		    struct repository *repo)
+		    bool has_repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_maintenance_options[] = {
@@ -3156,5 +3156,5 @@ int cmd_maintenance(int argc,
 
 	argc = parse_options(argc, argv, prefix, builtin_maintenance_options,
 			     builtin_maintenance_usage, 0);
-	return fn(argc, argv, prefix, repo);
+	return fn(argc, argv, prefix, the_repository);
 }
diff --git c/builtin/get-tar-commit-id.c w/builtin/get-tar-commit-id.c
index e4cd1627b4..9471dfa5f0 100644
--- c/builtin/get-tar-commit-id.c
+++ w/builtin/get-tar-commit-id.c
@@ -15,7 +15,7 @@ static const char builtin_get_tar_commit_id_usage[] =
 int cmd_get_tar_commit_id(int argc,
 			  const char **argv,
 			  const char *prefix,
-			  struct repository *repo UNUSED)
+			  bool has_repo UNUSED)
 {
 	char buffer[HEADERSIZE];
 	struct ustar_header *header = (struct ustar_header *)buffer;
diff --git c/builtin/grep.c w/builtin/grep.c
index d3d86abe01..2e93aa05fa 100644
--- c/builtin/grep.c
+++ w/builtin/grep.c
@@ -1035,7 +1035,7 @@ static int pattern_callback(const struct option *opt, const char *arg,
 int cmd_grep(int argc,
 	     const char **argv,
 	     const char *prefix,
-	     struct repository *repo UNUSED)
+	     bool has_repo UNUSED)
 {
 	int hit = 0;
 	int cached = 0, untracked = 0, opt_exclude = -1;
diff --git c/builtin/hash-object.c w/builtin/hash-object.c
index f306b0643f..547d635a79 100644
--- c/builtin/hash-object.c
+++ w/builtin/hash-object.c
@@ -64,7 +64,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags)
 int cmd_hash_object(int argc,
 		    const char **argv,
 		    const char *prefix,
-		    struct repository *repo UNUSED)
+		    bool has_repo UNUSED)
 {
 	static const char * const hash_object_usage[] = {
 		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters]\n"
diff --git c/builtin/help.c w/builtin/help.c
index a140339999..37dadea7a0 100644
--- c/builtin/help.c
+++ w/builtin/help.c
@@ -662,7 +662,7 @@ static void opt_mode_usage(int argc, const char *opt_mode,
 int cmd_help(int argc,
 	     const char **argv,
 	     const char *prefix,
-	     struct repository *repo UNUSED)
+	     bool has_repo UNUSED)
 {
 	int nongit;
 	enum help_format parsed_help_format;
diff --git c/builtin/history.c w/builtin/history.c
index 000155ad9c..33590b30bf 100644
--- c/builtin/history.c
+++ w/builtin/history.c
@@ -1187,7 +1187,7 @@ static int cmd_history_drop(int argc,
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo)
+		bool has_repo UNUSED)
 {
 	const char * const usage[] = {
 		GIT_HISTORY_DROP_USAGE,
@@ -1206,5 +1206,5 @@ int cmd_history(int argc,
 	};
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	return fn(argc, argv, prefix, repo);
+	return fn(argc, argv, prefix, the_repository);
 }
diff --git c/builtin/hook.c w/builtin/hook.c
index cceeb3586e..394801ccde 100644
--- c/builtin/hook.c
+++ w/builtin/hook.c
@@ -192,7 +192,7 @@ static int run(int argc, const char **argv, const char *prefix,
 int cmd_hook(int argc,
 	     const char **argv,
 	     const char *prefix,
-	     struct repository *repo)
+	     bool has_repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_hook_options[] = {
@@ -204,5 +204,5 @@ int cmd_hook(int argc,
 	argc = parse_options(argc, argv, NULL, builtin_hook_options,
 			     builtin_hook_usage, 0);
 
-	return fn(argc, argv, prefix, repo);
+	return fn(argc, argv, prefix, the_repository);
 }
diff --git c/builtin/index-pack.c w/builtin/index-pack.c
index d1761282db..7223a6c6a0 100644
--- c/builtin/index-pack.c
+++ w/builtin/index-pack.c
@@ -1886,7 +1886,7 @@ static void repack_local_links(void)
 int cmd_index_pack(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, rev_index;
 	const char *curr_index;
diff --git c/builtin/init-db.c w/builtin/init-db.c
index e96b1283b7..7da1ec263b 100644
--- c/builtin/init-db.c
+++ w/builtin/init-db.c
@@ -72,7 +72,7 @@ static const char *const init_db_usage[] = {
 int cmd_init_db(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		bool has_repo UNUSED)
 {
 	char *git_dir;
 	const char *real_git_dir = NULL;
diff --git c/builtin/interpret-trailers.c w/builtin/interpret-trailers.c
index e7e86e9523..7b5274d612 100644
--- c/builtin/interpret-trailers.c
+++ w/builtin/interpret-trailers.c
@@ -139,7 +139,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 int cmd_interpret_trailers(int argc,
 			   const char **argv,
 			   const char *prefix,
-			   struct repository *repo UNUSED)
+			   bool has_repo UNUSED)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 	LIST_HEAD(trailers);
diff --git c/builtin/last-modified.c w/builtin/last-modified.c
index 3846244dfc..72f7e7843e 100644
--- c/builtin/last-modified.c
+++ w/builtin/last-modified.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "git-compat-util.h"
 #include "bloom.h"
 #include "builtin.h"
@@ -518,7 +519,7 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 }
 
 int cmd_last_modified(int argc, const char **argv, const char *prefix,
-		      struct repository *repo)
+		      bool has_repo UNUSED)
 {
 	int ret;
 	struct last_modified lm = { 0 };
@@ -546,9 +547,9 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT |
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	repo_config(repo, git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
-	ret = last_modified_init(&lm, repo, prefix, argc, argv);
+	ret = last_modified_init(&lm, the_repository, prefix, argc, argv);
 	if (ret > 0)
 		usage_with_options(last_modified_usage,
 				   last_modified_options);
diff --git c/builtin/log.c w/builtin/log.c
index 350b35c556..d495a5088e 100644
--- c/builtin/log.c
+++ w/builtin/log.c
@@ -526,7 +526,7 @@ static int git_log_config(const char *var, const char *value,
 int cmd_whatchanged(int argc,
 		    const char **argv,
 		    const char *prefix,
-		    struct repository *repo UNUSED)
+		    bool has_repo UNUSED)
 {
 	struct log_config cfg;
 	struct rev_info rev;
@@ -661,7 +661,7 @@ static void show_setup_revisions_tweak(struct rev_info *rev)
 int cmd_show(int argc,
 	     const char **argv,
 	     const char *prefix,
-	     struct repository *repo UNUSED)
+	     bool has_repo UNUSED)
 {
 	struct log_config cfg;
 	struct rev_info rev;
@@ -780,7 +780,7 @@ int cmd_show(int argc,
 int cmd_log_reflog(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	struct log_config cfg;
 	struct rev_info rev;
@@ -825,7 +825,7 @@ static void log_setup_revisions_tweak(struct rev_info *rev)
 int cmd_log(int argc,
 	    const char **argv,
 	    const char *prefix,
-	    struct repository *repo UNUSED)
+	    bool has_repo UNUSED)
 {
 	struct log_config cfg;
 	struct rev_info rev;
@@ -1955,7 +1955,7 @@ static void infer_range_diff_ranges(struct strbuf *r1,
 int cmd_format_patch(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     bool has_repo UNUSED)
 {
 	struct format_config cfg;
 	struct commit *commit;
@@ -2735,7 +2735,7 @@ static void prefetch_cherry_blobs(struct repository *repo,
 int cmd_cherry(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       bool has_repo UNUSED)
 {
 	struct rev_info revs;
 	struct patch_ids ids;
diff --git c/builtin/ls-files.c w/builtin/ls-files.c
index b044520f9e..220f2a3ec2 100644
--- c/builtin/ls-files.c
+++ w/builtin/ls-files.c
@@ -6,6 +6,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -590,7 +591,7 @@ static int option_parse_exclude_standard(const struct option *opt,
 int cmd_ls_files(int argc,
 		 const char **argv,
 		 const char *cmd_prefix,
-		 struct repository *repo)
+		 bool has_repo UNUSED)
 {
 	int require_work_tree = 0, show_tag = 0, i;
 	char *max_prefix;
@@ -670,15 +671,15 @@ int cmd_ls_files(int argc,
 	show_usage_with_options_if_asked(argc, argv,
 					 ls_files_usage, builtin_ls_files_options);
 
-	prepare_repo_settings(repo);
-	repo->settings.command_requires_full_index = 0;
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
 
 	prefix = cmd_prefix;
 	if (prefix)
 		prefix_len = strlen(prefix);
-	repo_config(repo, git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
-	if (repo_read_index(repo) < 0)
+	if (repo_read_index(the_repository) < 0)
 		die("index file corrupt");
 
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
@@ -717,8 +718,8 @@ int cmd_ls_files(int argc,
 	if (dir.exclude_per_dir)
 		exc_given = 1;
 
-	if (require_work_tree && !is_inside_work_tree(repo))
-		setup_work_tree(repo);
+	if (require_work_tree && !is_inside_work_tree(the_repository))
+		setup_work_tree(the_repository);
 
 	if (recurse_submodules &&
 	    (show_deleted || show_others || show_unmerged ||
@@ -747,7 +748,7 @@ int cmd_ls_files(int argc,
 		max_prefix = common_prefix(&pathspec);
 	max_prefix_len = get_common_prefix_len(max_prefix);
 
-	prune_index(repo->index, max_prefix, max_prefix_len);
+	prune_index(the_repository->index, max_prefix, max_prefix_len);
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec.nr && error_unmatch)
@@ -771,13 +772,13 @@ int cmd_ls_files(int argc,
 		 */
 		if (show_stage || show_unmerged)
 			die(_("options '%s' and '%s' cannot be used together"), "ls-files --with-tree", "-s/-u");
-		overlay_tree_on_index(repo->index, with_tree, max_prefix);
+		overlay_tree_on_index(the_repository->index, with_tree, max_prefix);
 	}
 
-	show_files(repo, &dir);
+	show_files(the_repository, &dir);
 
 	if (show_resolve_undo)
-		show_ru_info(repo, repo->index);
+		show_ru_info(the_repository, the_repository->index);
 
 	if (ps_matched && report_path_error(ps_matched, &pathspec)) {
 		fprintf(stderr, "Did you forget to 'git add'?\n");
diff --git c/builtin/ls-remote.c w/builtin/ls-remote.c
index fe77829557..f04e9ded50 100644
--- c/builtin/ls-remote.c
+++ w/builtin/ls-remote.c
@@ -41,7 +41,7 @@ static int tail_match(const struct strvec *pattern, const char *path)
 int cmd_ls_remote(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  bool has_repo UNUSED)
 {
 	const char *dest = NULL;
 	unsigned flags = 0;
diff --git c/builtin/ls-tree.c w/builtin/ls-tree.c
index 46edaffc2e..a75b225e9a 100644
--- c/builtin/ls-tree.c
+++ w/builtin/ls-tree.c
@@ -338,7 +338,7 @@ static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
 int cmd_ls_tree(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		bool has_repo UNUSED)
 {
 	struct object_id oid;
 	struct tree *tree;
diff --git c/builtin/mailinfo.c w/builtin/mailinfo.c
index 8de7ba7de1..186e8a6907 100644
--- c/builtin/mailinfo.c
+++ w/builtin/mailinfo.c
@@ -52,7 +52,7 @@ static int parse_opt_quoted_cr(const struct option *opt, const char *arg, int un
 int cmd_mailinfo(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 bool has_repo UNUSED)
 {
 	struct metainfo_charset meta_charset;
 	struct mailinfo mi;
diff --git c/builtin/mailsplit.c w/builtin/mailsplit.c
index 0993418e63..177bb7f16b 100644
--- c/builtin/mailsplit.c
+++ w/builtin/mailsplit.c
@@ -274,7 +274,7 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 int cmd_mailsplit(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  bool has_repo UNUSED)
 {
 	int nr = 0, nr_prec = 4, num = 0;
 	int allow_bare = 0;
diff --git c/builtin/merge-base.c w/builtin/merge-base.c
index a87011c6cd..63b74c89bc 100644
--- c/builtin/merge-base.c
+++ w/builtin/merge-base.c
@@ -149,7 +149,7 @@ static int handle_fork_point(int argc, const char **argv)
 int cmd_merge_base(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	struct commit **rev;
 	size_t rev_nr = 0;
diff --git c/builtin/merge-file.c w/builtin/merge-file.c
index 8fa5765239..a84246c816 100644
--- c/builtin/merge-file.c
+++ w/builtin/merge-file.c
@@ -60,7 +60,7 @@ static int diff_algorithm_cb(const struct option *opt,
 int cmd_merge_file(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo)
+		   bool has_repo)
 {
 	const char *names[3] = { 0 };
 	mmfile_t mmfs[3] = { 0 };
@@ -96,7 +96,7 @@ int cmd_merge_file(int argc,
 	xmp.favor = 0;
 
 	/* Read the configuration file */
-	repo_config(repo, git_xmerge_config, NULL);
+	repo_config(the_repository, git_xmerge_config, NULL);
 	if (0 <= git_xmerge_style)
 		xmp.style = git_xmerge_style;
 
@@ -108,7 +108,7 @@ int cmd_merge_file(int argc,
 			return error_errno("failed to redirect stderr to /dev/null");
 	}
 
-	if (!repo && object_id)
+	if (!has_repo && object_id)
 		/* emit the correct "not a git repo" error in this case */
 		setup_git_directory(the_repository);
 
diff --git c/builtin/merge-index.c w/builtin/merge-index.c
index 3314fb1336..f68d28cb9c 100644
--- c/builtin/merge-index.c
+++ w/builtin/merge-index.c
@@ -81,7 +81,7 @@ static const char usage_string[] =
 int cmd_merge_index(int argc,
 		    const char **argv,
 		    const char *prefix UNUSED,
-		    struct repository *repo UNUSED)
+		    bool has_repo UNUSED)
 {
 	int i, force_file = 0;
 
diff --git c/builtin/merge-ours.c w/builtin/merge-ours.c
index 405b2989f7..f4447deac7 100644
--- c/builtin/merge-ours.c
+++ w/builtin/merge-ours.c
@@ -8,6 +8,7 @@
  * Pretend we resolved the heads, but declare our tree trumps everybody else.
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "config.h"
@@ -20,22 +21,22 @@ static const char builtin_merge_ours_usage[] =
 int cmd_merge_ours(int argc,
 		   const char **argv,
 		   const char *prefix UNUSED,
-		   struct repository *repo)
+		   bool has_repo UNUSED)
 {
 	show_usage_if_asked(argc, argv, builtin_merge_ours_usage);
 
-	repo_config(repo, git_default_config, NULL);
-	prepare_repo_settings(repo);
-	repo->settings.command_requires_full_index = 0;
+	repo_config(the_repository, git_default_config, NULL);
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
 
 	/*
 	 * The contents of the current index becomes the tree we
 	 * commit.  The index must match HEAD, or this merge cannot go
 	 * through.
 	 */
-	if (repo_read_index(repo) < 0)
+	if (repo_read_index(the_repository) < 0)
 		die_errno("read_cache failed");
-	if (index_differs_from(repo, "HEAD", NULL, 0))
+	if (index_differs_from(the_repository, "HEAD", NULL, 0))
 		return 2;
 	return 0;
 }
diff --git c/builtin/merge-recursive.c w/builtin/merge-recursive.c
index 17aa4db37a..76480eee1f 100644
--- c/builtin/merge-recursive.c
+++ w/builtin/merge-recursive.c
@@ -24,7 +24,7 @@ static char *better_branch_name(const char *branch)
 int cmd_merge_recursive(int argc,
 			const char **argv,
 			const char *prefix UNUSED,
-			struct repository *repo UNUSED)
+			bool has_repo UNUSED)
 {
 	struct object_id bases[21];
 	unsigned bases_count = 0;
diff --git c/builtin/merge-tree.c w/builtin/merge-tree.c
index 49f41e520f..3a82f5dd3d 100644
--- c/builtin/merge-tree.c
+++ w/builtin/merge-tree.c
@@ -539,7 +539,7 @@ static int real_merge(struct merge_tree_options *o,
 int cmd_merge_tree(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	struct merge_tree_options o = { .show_messages = -1 };
 	struct strvec xopts = STRVEC_INIT;
diff --git c/builtin/merge.c w/builtin/merge.c
index 5b4eb23a83..084c5c427a 100644
--- c/builtin/merge.c
+++ w/builtin/merge.c
@@ -1363,7 +1363,7 @@ static int merging_a_throwaway_tag(struct commit *commit)
 int cmd_merge(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      bool has_repo UNUSED)
 {
 	struct object_id result_tree, stash, head_oid;
 	struct commit *head_commit;
diff --git c/builtin/mktag.c w/builtin/mktag.c
index 37c17e6beb..3a3b246e87 100644
--- c/builtin/mktag.c
+++ w/builtin/mktag.c
@@ -75,7 +75,7 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 int cmd_mktag(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo)
+	      bool has_repo UNUSED)
 {
 	static struct option builtin_mktag_options[] = {
 		OPT_BOOL(0, "strict", &option_strict,
@@ -94,7 +94,7 @@ int cmd_mktag(int argc,
 	if (strbuf_read(&buf, 0, 0) < 0)
 		die_errno(_("could not read from stdin"));
 
-	fsck_options_init(&fsck_options, repo, FSCK_OPTIONS_STRICT);
+	fsck_options_init(&fsck_options, the_repository, FSCK_OPTIONS_STRICT);
 	fsck_options.error_func = mktag_fsck_error_func;
 	fsck_set_msg_type_from_ids(&fsck_options, FSCK_MSG_EXTRA_HEADER_ENTRY,
 				   FSCK_WARN);
diff --git c/builtin/mktree.c w/builtin/mktree.c
index 4084e32476..cc7c8a1071 100644
--- c/builtin/mktree.c
+++ w/builtin/mktree.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) Junio C Hamano, 2006, 2009
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
@@ -154,7 +155,7 @@ static void mktree_line(struct repository *repo, char *buf, int nul_term_line, i
 int cmd_mktree(int ac,
 	       const char **av,
 	       const char *prefix,
-	       struct repository *repo)
+	       bool has_repo UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct object_id oid;
@@ -186,7 +187,7 @@ int cmd_mktree(int ac,
 					break;
 				die("input format error: (blank line only valid in batch mode)");
 			}
-			mktree_line(repo, sb.buf, nul_term_line, allow_missing);
+			mktree_line(the_repository, sb.buf, nul_term_line, allow_missing);
 		}
 		if (is_batch_mode && got_eof && used < 1) {
 			/*
@@ -196,7 +197,7 @@ int cmd_mktree(int ac,
 			 */
 			; /* skip creating an empty tree */
 		} else {
-			write_tree(repo, &oid);
+			write_tree(the_repository, &oid);
 			puts(oid_to_hex(&oid));
 			fflush(stdout);
 		}
diff --git c/builtin/multi-pack-index.c w/builtin/multi-pack-index.c
index 6e73c85cde..73c8b9d7d5 100644
--- c/builtin/multi-pack-index.c
+++ w/builtin/multi-pack-index.c
@@ -405,7 +405,7 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 int cmd_multi_pack_index(int argc,
 			 const char **argv,
 			 const char *prefix,
-			 struct repository *repo)
+			 bool has_repo UNUSED)
 {
 	int res;
 	parse_opt_subcommand_fn *fn = NULL;
@@ -432,7 +432,7 @@ int cmd_multi_pack_index(int argc,
 			     builtin_multi_pack_index_usage, 0);
 	FREE_AND_NULL(options);
 
-	res = fn(argc, argv, prefix, repo);
+	res = fn(argc, argv, prefix, the_repository);
 
 	free(opts.object_dir);
 	return res;
diff --git c/builtin/mv.c w/builtin/mv.c
index 373d4aeba3..21e9bf5180 100644
--- c/builtin/mv.c
+++ w/builtin/mv.c
@@ -215,7 +215,7 @@ static int pathmap_cmp(const void *cmp_data UNUSED,
 int cmd_mv(int argc,
 	   const char **argv,
 	   const char *prefix,
-	   struct repository *repo UNUSED)
+	   bool has_repo UNUSED)
 {
 	int i, flags, gitmodules_modified = 0;
 	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0;
diff --git c/builtin/name-rev.c w/builtin/name-rev.c
index 60cbbfb4b7..94fc8c9dcd 100644
--- c/builtin/name-rev.c
+++ w/builtin/name-rev.c
@@ -636,7 +636,7 @@ static void name_rev_line(char *p, struct command *cmd)
 int cmd_name_rev(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 bool has_repo UNUSED)
 {
 	struct mem_pool string_pool;
 	struct object_array revs = OBJECT_ARRAY_INIT;
@@ -811,7 +811,7 @@ static char const *const format_rev_usage[] = {
 int cmd_format_rev(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	const char *format = NULL;
 	enum stdin_mode stdin_mode;
diff --git c/builtin/notes.c w/builtin/notes.c
index 9f1f0ec840..bc5cc6fc6d 100644
--- c/builtin/notes.c
+++ w/builtin/notes.c
@@ -1127,7 +1127,7 @@ static int get_ref(int argc, const char **argv, const char *prefix,
 int cmd_notes(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo)
+	      bool has_repo UNUSED)
 {
 	const char *override_notes_ref = NULL;
 	parse_opt_subcommand_fn *fn = NULL;
@@ -1166,5 +1166,5 @@ int cmd_notes(int argc,
 		strbuf_release(&sb);
 	}
 
-	return !!fn(argc, argv, prefix, repo);
+	return !!fn(argc, argv, prefix, the_repository);
 }
diff --git c/builtin/pack-objects.c w/builtin/pack-objects.c
index 1d9dc31454..31fb637c37 100644
--- c/builtin/pack-objects.c
+++ w/builtin/pack-objects.c
@@ -5118,7 +5118,7 @@ static int parse_stdin_packs_mode(const struct option *opt, const char *arg,
 int cmd_pack_objects(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     bool has_repo UNUSED)
 {
 	int use_internal_rev_list = 0;
 	int all_progress_implied = 0;
diff --git c/builtin/pack-redundant.c w/builtin/pack-redundant.c
index 86749bb7e7..bd433f120d 100644
--- c/builtin/pack-redundant.c
+++ w/builtin/pack-redundant.c
@@ -587,7 +587,7 @@ static void load_all(void)
 		add_pack(p);
 }
 
-int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED) {
+int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, bool has_repo UNUSED) {
 	int i; int i_still_use_this = 0; struct pack_list *min = NULL, *red, *pl;
 	struct llist *ignore;
 	struct strbuf idx_name = STRBUF_INIT;
diff --git c/builtin/pack-refs.c w/builtin/pack-refs.c
index 3446b84cda..4bfdf48546 100644
--- c/builtin/pack-refs.c
+++ w/builtin/pack-refs.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "pack-refs.h"
@@ -5,12 +6,12 @@
 int cmd_pack_refs(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo)
+		  bool has_repo UNUSED)
 {
 	static char const * const pack_refs_usage[] = {
 		N_("git pack-refs " PACK_REFS_OPTS),
 		NULL
 	};
 
-	return pack_refs_core(argc, argv, prefix, repo, pack_refs_usage);
+	return pack_refs_core(argc, argv, prefix, the_repository, pack_refs_usage);
 }
diff --git c/builtin/patch-id.c w/builtin/patch-id.c
index 22f36ecf80..0942ceb081 100644
--- c/builtin/patch-id.c
+++ w/builtin/patch-id.c
@@ -222,7 +222,7 @@ static int git_patch_id_config(const char *var, const char *value,
 int cmd_patch_id(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 bool has_repo UNUSED)
 {
 	/* if nothing is set, default to unstable */
 	struct patch_id_opts config = {0, 0};
diff --git c/builtin/prune-packed.c w/builtin/prune-packed.c
index 4d63f26b0a..d23f8640ef 100644
--- c/builtin/prune-packed.c
+++ w/builtin/prune-packed.c
@@ -11,7 +11,7 @@ static const char * const prune_packed_usage[] = {
 int cmd_prune_packed(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     bool has_repo UNUSED)
 {
 	int opts = isatty(2) ? PRUNE_PACKED_VERBOSE : 0;
 	const struct option prune_packed_options[] = {
diff --git c/builtin/prune.c w/builtin/prune.c
index 55635a891f..349c979f4f 100644
--- c/builtin/prune.c
+++ w/builtin/prune.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -153,7 +154,7 @@ static void remove_temporary_files(const char *path)
 int cmd_prune(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo)
+	      bool has_repo UNUSED)
 {
 	struct rev_info revs;
 	int exclude_promisor_objects = 0;
@@ -175,16 +176,16 @@ int cmd_prune(int argc,
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
 
-	repo_init_revisions(repo, &revs, prefix);
-	if (repo->repository_format_precious_objects)
+	repo_init_revisions(the_repository, &revs, prefix);
+	if (the_repository->repository_format_precious_objects)
 		die(_("cannot prune in a precious-objects repo"));
 
 	while (argc--) {
 		struct object_id oid;
 		const char *name = *argv++;
 
-		if (!repo_get_oid(repo, name, &oid)) {
-			struct object *object = parse_object_or_die(repo, &oid, name);
+		if (!repo_get_oid(the_repository, name, &oid)) {
+			struct object *object = parse_object_or_die(the_repository, &oid, name);
 			add_pending_object(&revs, object, "");
 		}
 		else
@@ -198,16 +199,16 @@ int cmd_prune(int argc,
 		revs.exclude_promisor_objects = 1;
 	}
 
-	for_each_loose_file_in_source(repo->objects->sources,
+	for_each_loose_file_in_source(the_repository->objects->sources,
 				      prune_object, prune_cruft, prune_subdir, &revs);
 
 	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
-	remove_temporary_files(repo_get_object_directory(repo));
-	s = mkpathdup("%s/pack", repo_get_object_directory(repo));
+	remove_temporary_files(repo_get_object_directory(the_repository));
+	s = mkpathdup("%s/pack", repo_get_object_directory(the_repository));
 	remove_temporary_files(s);
 	free(s);
 
-	if (is_repository_shallow(repo)) {
+	if (is_repository_shallow(the_repository)) {
 		perform_reachability_traversal(&revs);
 		prune_shallow(show_only ? PRUNE_SHOW_ONLY : 0);
 	}
diff --git c/builtin/pull.c w/builtin/pull.c
index db3ee0aab3..9d4412f4a3 100644
--- c/builtin/pull.c
+++ w/builtin/pull.c
@@ -856,7 +856,7 @@ static void show_advice_pull_non_ff(void)
 int cmd_pull(int argc,
 	     const char **argv,
 	     const char *prefix,
-	     struct repository *repository UNUSED)
+	     bool has_repo UNUSED)
 {
 	const char *repo, **refspecs;
 	struct oid_array merge_heads = OID_ARRAY_INIT;
diff --git c/builtin/push.c w/builtin/push.c
index 2377b5af55..d6d6c63ce3 100644
--- c/builtin/push.c
+++ w/builtin/push.c
@@ -691,7 +691,7 @@ static void die_if_repo_looks_like_ref(const char *repo)
 int cmd_push(int argc,
 	     const char **argv,
 	     const char *prefix,
-	     struct repository *repository UNUSED)
+	     bool has_repo UNUSED)
 {
 	int flags = 0;
 	int tags = 0;
diff --git c/builtin/range-diff.c w/builtin/range-diff.c
index e54c0f7fe1..312a36034d 100644
--- c/builtin/range-diff.c
+++ w/builtin/range-diff.c
@@ -35,7 +35,7 @@ static int parse_max_memory(const struct option *opt, const char *arg, int unset
 int cmd_range_diff(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	struct diff_options diffopt = { NULL };
 	struct strvec log_arg = STRVEC_INIT;
diff --git c/builtin/read-tree.c w/builtin/read-tree.c
index 999a82ecdf..6d7b1e1315 100644
--- c/builtin/read-tree.c
+++ w/builtin/read-tree.c
@@ -111,7 +111,7 @@ static int git_read_tree_config(const char *var, const char *value,
 int cmd_read_tree(int argc,
 		  const char **argv,
 		  const char *cmd_prefix,
-		  struct repository *repo UNUSED)
+		  bool has_repo UNUSED)
 {
 	int i, stage = 0;
 	struct object_id oid;
diff --git c/builtin/rebase.c w/builtin/rebase.c
index 10a306310c..3dfe959d78 100644
--- c/builtin/rebase.c
+++ w/builtin/rebase.c
@@ -1099,7 +1099,7 @@ static int check_exec_cmd(const char *cmd)
 int cmd_rebase(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       bool has_repo UNUSED)
 {
 	struct rebase_options options = REBASE_OPTIONS_INIT;
 	const char *branch_name;
diff --git c/builtin/receive-pack.c w/builtin/receive-pack.c
index 86933d8d7e..c751487867 100644
--- c/builtin/receive-pack.c
+++ w/builtin/receive-pack.c
@@ -2612,7 +2612,7 @@ static int delete_only(struct command *commands)
 int cmd_receive_pack(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     bool has_repo UNUSED)
 {
 	int advertise_refs = 0;
 	struct command *commands;
diff --git c/builtin/reflog.c w/builtin/reflog.c
index 1211c58fa4..f04e6701c2 100644
--- c/builtin/reflog.c
+++ w/builtin/reflog.c
@@ -467,7 +467,7 @@ static int cmd_reflog_write(int argc, const char **argv, const char *prefix,
 int cmd_reflog(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repository)
+	       bool has_repo)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
@@ -486,7 +486,7 @@ int cmd_reflog(int argc,
 			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
 			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 	if (fn)
-		return fn(argc - 1, argv + 1, prefix, repository);
+		return fn(argc - 1, argv + 1, prefix, the_repository);
 	else
-		return cmd_log_reflog(argc, argv, prefix, repository);
+		return cmd_log_reflog(argc, argv, prefix, has_repo);
 }
diff --git c/builtin/refs.c w/builtin/refs.c
index 5cd21c25fe..9abcc6586f 100644
--- c/builtin/refs.c
+++ w/builtin/refs.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "fsck.h"
@@ -377,7 +378,7 @@ static int cmd_refs_rename(int argc, const char **argv, const char *prefix,
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
-	     struct repository *repo)
+	     bool has_repo UNUSED)
 {
 	const char * const refs_usage[] = {
 		REFS_MIGRATE_USAGE,
@@ -406,5 +407,5 @@ int cmd_refs(int argc,
 	};
 
 	argc = parse_options(argc, argv, prefix, opts, refs_usage, 0);
-	return fn(argc, argv, prefix, repo);
+	return fn(argc, argv, prefix, the_repository);
 }
diff --git c/builtin/remote-ext.c w/builtin/remote-ext.c
index bd2037f27d..d14bc8424f 100644
--- c/builtin/remote-ext.c
+++ w/builtin/remote-ext.c
@@ -198,7 +198,7 @@ static int command_loop(const char *child)
 int cmd_remote_ext(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
diff --git c/builtin/remote-fd.c w/builtin/remote-fd.c
index 39908546ba..2d1d1e9130 100644
--- c/builtin/remote-fd.c
+++ w/builtin/remote-fd.c
@@ -56,7 +56,7 @@ static void command_loop(int input_fd, int output_fd)
 int cmd_remote_fd(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  bool has_repo UNUSED)
 {
 	int input_fd = -1;
 	int output_fd = -1;
diff --git c/builtin/remote.c w/builtin/remote.c
index de989ea3ba..f2c11ae3ec 100644
--- c/builtin/remote.c
+++ w/builtin/remote.c
@@ -1933,7 +1933,7 @@ static int set_url(int argc, const char **argv, const char *prefix,
 int cmd_remote(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo)
+	       bool has_repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
@@ -1956,7 +1956,7 @@ int cmd_remote(int argc,
 			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
 
 	if (fn) {
-		return !!fn(argc, argv, prefix, repo);
+		return !!fn(argc, argv, prefix, the_repository);
 	} else {
 		if (argc) {
 			error(_("unknown subcommand: `%s'"), argv[0]);
diff --git c/builtin/repack.c w/builtin/repack.c
index c4360382c1..96f6faddc3 100644
--- c/builtin/repack.c
+++ w/builtin/repack.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -158,7 +159,7 @@ static int option_parse_write_midx(const struct option *opt, const char *arg,
 int cmd_repack(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo)
+	       bool has_repo UNUSED)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
@@ -272,7 +273,7 @@ int cmd_repack(int argc,
 	config_ctx.midx_split_factor = DEFAULT_MIDX_SPLIT_FACTOR;
 	config_ctx.midx_new_layer_threshold = DEFAULT_MIDX_NEW_LAYER_THRESHOLD;
 
-	repo_config(repo, repack_config, &config_ctx);
+	repo_config(the_repository, repack_config, &config_ctx);
 
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
@@ -316,7 +317,7 @@ int cmd_repack(int argc,
 		 * dropped objects from, so dropping them would be permanent
 		 * data loss.
 		 */
-		if (!repo_has_promisor_remote(repo))
+		if (!repo_has_promisor_remote(the_repository))
 			die(_("--drop-filtered requires a promisor remote"));
 
 		/*
@@ -329,10 +330,10 @@ int cmd_repack(int argc,
 		 * safety measure. Bare repositories have no such state, so
 		 * the check is skipped there.
 		 */
-		if (!is_bare_repository(repo)) {
+		if (!is_bare_repository(the_repository)) {
 			struct wt_status_state state = { 0 };
 
-			wt_status_get_state(repo, &state, 0);
+			wt_status_get_state(the_repository, &state, 0);
 			if (state.merge_in_progress || state.revert_in_progress ||
 			    state.rebase_in_progress || state.bisect_in_progress ||
 			    state.cherry_pick_in_progress || state.am_in_progress ||
@@ -356,7 +357,7 @@ int cmd_repack(int argc,
 		if (!dry_run)
 			delete_redundant = 1;
 
-		ret = enumerate_promisor_blobs(repo, &po_args.filter_options, &drop_oids);
+		ret = enumerate_promisor_blobs(the_repository, &po_args.filter_options, &drop_oids);
 
 		if (ret)
 			goto cleanup;
@@ -368,11 +369,11 @@ int cmd_repack(int argc,
 		 * nothing. This guard just avoids that churn. Bare
 		 * repositories have no index, so the check is skipped there.
 		 */
-		if (!is_bare_repository(repo) && oidset_size(&drop_oids)) {
-			struct index_state *istate = repo->index;
+		if (!is_bare_repository(the_repository) && oidset_size(&drop_oids)) {
+			struct index_state *istate = the_repository->index;
 			unsigned int i;
 
-			if (repo_read_index(repo) < 0)
+			if (repo_read_index(the_repository) < 0)
 				die(_("could not read the index"));
 
 			for (i = 0; i < istate->cache_nr; i++) {
@@ -394,7 +395,7 @@ int cmd_repack(int argc,
 		}
 	}
 
-	if (delete_redundant && repo->repository_format_precious_objects)
+	if (delete_redundant && the_repository->repository_format_precious_objects)
 		die(_("cannot delete packs in a precious-objects repo"));
 
 	die_for_incompatible_opt3(unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE), "-A",
@@ -406,7 +407,7 @@ int cmd_repack(int argc,
 
 	if (write_bitmaps < 0) {
 		if (write_midx == REPACK_WRITE_MIDX_NONE &&
-		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository(repo)))
+		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository(the_repository)))
 			write_bitmaps = 0;
 	}
 	if (po_args.pack_kept_objects < 0)
@@ -418,7 +419,7 @@ int cmd_repack(int argc,
 		die(_(incremental_bitmap_conflict_error));
 
 	if (write_bitmaps && po_args.local &&
-	    odb_has_alternates(repo->objects)) {
+	    odb_has_alternates(the_repository->objects)) {
 		/*
 		 * When asked to do a local repack, but we have
 		 * packfiles that are inherited from an alternate, then
@@ -441,20 +442,20 @@ int cmd_repack(int argc,
 		struct strbuf path = STRBUF_INIT;
 
 		strbuf_addf(&path, "%s/%s_XXXXXX",
-			    repo_get_object_directory(repo),
+			    repo_get_object_directory(the_repository),
 			    "bitmap-ref-tips");
 
 		refs_snapshot = xmks_tempfile(path.buf);
-		midx_snapshot_refs(repo, refs_snapshot);
+		midx_snapshot_refs(the_repository, refs_snapshot);
 
 		strbuf_release(&path);
 	}
 
-	packdir = mkpathdup("%s/pack", repo_get_object_directory(repo));
+	packdir = mkpathdup("%s/pack", repo_get_object_directory(the_repository));
 	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
 	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
 
-	existing.repo = repo;
+	existing.repo = the_repository;
 	existing_packs_collect(&existing, &keep_pack_list);
 
 	if (geometry.split_factor) {
@@ -492,7 +493,7 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--reflog");
 		strvec_push(&cmd.args, "--indexed-objects");
 	}
-	if (repo_has_promisor_remote(repo))
+	if (repo_has_promisor_remote(the_repository))
 		strvec_push(&cmd.args, "--exclude-promisor-objects");
 	if (write_midx == REPACK_WRITE_MIDX_NONE) {
 		if (write_bitmaps > 0)
@@ -504,7 +505,7 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
-		repack_promisor_objects(repo, &po_args, &names, packtmp,
+		repack_promisor_objects(the_repository, &po_args, &names, packtmp,
 			(drop_filtered && !dry_run) ? &drop_oids : NULL);
 
 		if (existing_packs_has_non_kept(&existing) &&
@@ -530,7 +531,7 @@ int cmd_repack(int argc,
 		    !(pack_everything & PACK_CRUFT))
 			strvec_push(&cmd.args, "--pack-loose-unreachable");
 	} else if (geometry.split_factor) {
-		pack_geometry_repack_promisors(repo, &po_args, &geometry,
+		pack_geometry_repack_promisors(the_repository, &po_args, &geometry,
 					       &names, packtmp);
 
 		if (midx_must_contain_cruft)
@@ -593,7 +594,7 @@ int cmd_repack(int argc,
 			.destination = packdir,
 			.packtmp = packtmp,
 		};
-		ret = finish_pack_objects_cmd(repo->hash_algo, &opts, &cmd,
+		ret = finish_pack_objects_cmd(the_repository->hash_algo, &opts, &cmd,
 					      &names);
 		if (ret)
 			goto cleanup;
@@ -706,7 +707,7 @@ int cmd_repack(int argc,
 
 	string_list_sort(&names);
 
-	odb_close(repo->objects);
+	odb_close(the_repository->objects);
 
 	/*
 	 * Ok we have prepared all new packfiles.
@@ -742,7 +743,7 @@ int cmd_repack(int argc,
 			goto cleanup;
 	}
 
-	odb_reprepare(repo->objects);
+	odb_reprepare(the_repository->objects);
 
 	if (delete_redundant) {
 		int opts = 0;
@@ -762,12 +763,12 @@ int cmd_repack(int argc,
 		if (!keep_unreachable &&
 		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
 		     unpack_unreachable) &&
-		    is_repository_shallow(repo))
+		    is_repository_shallow(the_repository))
 			prune_shallow(PRUNE_QUICK);
 	}
 
 	if (run_update_server_info)
-		update_server_info(repo, 0);
+		update_server_info(the_repository, 0);
 
 	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0)) {
 		struct odb_source_files *files = odb_source_files_downcast(existing.source);
diff --git c/builtin/replace.c w/builtin/replace.c
index aed6b2c8de..fd4e1adaf1 100644
--- c/builtin/replace.c
+++ w/builtin/replace.c
@@ -545,7 +545,7 @@ static int convert_graft_file(int force)
 int cmd_replace(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		bool has_repo UNUSED)
 {
 	int force = 0;
 	int raw = 0;
diff --git c/builtin/replay.c w/builtin/replay.c
index 39e3a86f6c..3f5b9cc36b 100644
--- c/builtin/replay.c
+++ w/builtin/replay.c
@@ -2,6 +2,7 @@
  * "git replay" builtin command
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
 #include "git-compat-util.h"
 
 #include "builtin.h"
@@ -69,7 +70,7 @@ static int handle_ref_update(enum ref_action_mode mode,
 int cmd_replay(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo)
+	       bool has_repo UNUSED)
 {
 	struct replay_revisions_options opts = { 0 };
 	struct replay_result result = { 0 };
@@ -134,7 +135,7 @@ int cmd_replay(int argc,
 				  !!opts.contained, "--contained");
 
 	/* Parse ref action mode from command line or config */
-	ref_mode = get_ref_action_mode(repo, ref_action);
+	ref_mode = get_ref_action_mode(the_repository, ref_action);
 
 	/*
 	 * Cherry-pick/rebase need oldest-first ordering so that each
@@ -144,7 +145,7 @@ int cmd_replay(int argc,
 	 */
 	desired_reverse = !opts.revert;
 
-	repo_init_revisions(repo, &revs, prefix);
+	repo_init_revisions(the_repository, &revs, prefix);
 
 	/*
 	 * Set desired values for rev walking options here. If they
@@ -206,14 +207,14 @@ int cmd_replay(int argc,
 		strbuf_addf(&reflog_msg, "replay --advance %s", opts.advance);
 	} else {
 		struct object_id oid;
-		if (repo_get_oid_committish(repo, opts.onto, &oid))
+		if (repo_get_oid_committish(the_repository, opts.onto, &oid))
 			BUG("--onto commit should have been resolved beforehand already");
 		strbuf_addf(&reflog_msg, "replay --onto %s", oid_to_hex(&oid));
 	}
 
 	/* Initialize ref transaction if using update mode */
 	if (ref_mode == REF_ACTION_UPDATE) {
-		transaction = ref_store_transaction_begin(get_main_ref_store(repo),
+		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
 							  0, &transaction_err);
 		if (!transaction) {
 			ret = error(_("failed to begin ref transaction: %s"),
diff --git c/builtin/repo.c w/builtin/repo.c
index 84e012f83f..5b12501a7c 100644
--- c/builtin/repo.c
+++ w/builtin/repo.c
@@ -981,7 +981,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 }
 
 int cmd_repo(int argc, const char **argv, const char *prefix,
-	     struct repository *repo)
+	     bool has_repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
@@ -992,5 +992,5 @@ int cmd_repo(int argc, const char **argv, const char *prefix,
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
 
-	return fn(argc, argv, prefix, repo);
+	return fn(argc, argv, prefix, the_repository);
 }
diff --git c/builtin/rerere.c w/builtin/rerere.c
index a056cb791b..caa88130fc 100644
--- c/builtin/rerere.c
+++ w/builtin/rerere.c
@@ -53,7 +53,7 @@ static int diff_two(const char *file1, const char *label1,
 int cmd_rerere(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       bool has_repo UNUSED)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	int autoupdate = -1, flags = 0;
diff --git c/builtin/reset.c w/builtin/reset.c
index 78e69bd84b..80f201ed68 100644
--- c/builtin/reset.c
+++ w/builtin/reset.c
@@ -336,7 +336,7 @@ static int git_reset_config(const char *var, const char *value,
 int cmd_reset(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      bool has_repo UNUSED)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
 	int no_refresh = 0;
diff --git c/builtin/rev-list.c w/builtin/rev-list.c
index 02818b81c6..14898a0aeb 100644
--- c/builtin/rev-list.c
+++ w/builtin/rev-list.c
@@ -692,7 +692,7 @@ static void prepare_maximal_independent(struct rev_info *revs)
 int cmd_rev_list(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 bool has_repo UNUSED)
 {
 	struct rev_info revs;
 	struct rev_list_info info;
diff --git c/builtin/rev-parse.c w/builtin/rev-parse.c
index 43693454d5..b4435981ab 100644
--- c/builtin/rev-parse.c
+++ w/builtin/rev-parse.c
@@ -698,7 +698,7 @@ static void print_path(const char *path, const char *prefix,
 int cmd_rev_parse(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  bool has_repo UNUSED)
 {
 	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
 	const struct git_hash_algo *output_algo = NULL;
diff --git c/builtin/revert.c w/builtin/revert.c
index bedc40f368..42d0332847 100644
--- c/builtin/revert.c
+++ w/builtin/revert.c
@@ -281,7 +281,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 int cmd_revert(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       bool has_repo UNUSED)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
@@ -299,9 +299,9 @@ int cmd_revert(int argc,
 }
 
 int cmd_cherry_pick(int argc,
-const char **argv,
-const char *prefix,
-struct repository *repo UNUSED)
+		    const char **argv,
+		    const char *prefix,
+		    bool has_repo UNUSED)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
diff --git c/builtin/rm.c w/builtin/rm.c
index 081d0bc375..9e08fb1fc2 100644
--- c/builtin/rm.c
+++ w/builtin/rm.c
@@ -265,7 +265,7 @@ static struct option builtin_rm_options[] = {
 int cmd_rm(int argc,
 	   const char **argv,
 	   const char *prefix,
-	   struct repository *repo UNUSED)
+	   bool has_repo UNUSED)
 {
 	struct lock_file lock_file = LOCK_INIT;
 	int i, ret = 0;
diff --git c/builtin/send-pack.c w/builtin/send-pack.c
index d6cdbae472..24656f911c 100644
--- c/builtin/send-pack.c
+++ w/builtin/send-pack.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
@@ -151,7 +152,7 @@ static int send_pack_config(const char *k, const char *v,
 int cmd_send_pack(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo)
+		  bool has_repo UNUSED)
 {
 	struct refspec rs;
 	const char *remote_name = NULL;
@@ -212,10 +213,10 @@ int cmd_send_pack(int argc,
 		OPT_END()
 	};
 
-	repo_config(repo, send_pack_config, NULL);
+	repo_config(the_repository, send_pack_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, send_pack_usage, 0);
 
-	refspec_init_push(&rs, repo->hash_algo);
+	refspec_init_push(&rs, the_repository->hash_algo);
 
 	if (argc > 0) {
 		dest = argv[0];
@@ -322,7 +323,7 @@ int cmd_send_pack(int argc,
 	set_ref_status_for_push(remote_refs, args.send_mirror,
 		args.force_update);
 
-	ret = send_pack(repo, &args, fd, conn, remote_refs, &extra_have);
+	ret = send_pack(the_repository, &args, fd, conn, remote_refs, &extra_have);
 
 	if (helper_status)
 		print_helper_status(remote_refs);
diff --git c/builtin/shortlog.c w/builtin/shortlog.c
index 4c78d2e5ba..28d34a72fa 100644
--- c/builtin/shortlog.c
+++ w/builtin/shortlog.c
@@ -383,7 +383,7 @@ void shortlog_finish_setup(struct shortlog *log)
 int cmd_shortlog(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 bool has_repo UNUSED)
 {
 	struct shortlog log = { STRING_LIST_INIT_NODUP };
 	struct rev_info rev;
diff --git c/builtin/show-branch.c w/builtin/show-branch.c
index 2435e8aeda..9b6946e3bc 100644
--- c/builtin/show-branch.c
+++ w/builtin/show-branch.c
@@ -636,7 +636,7 @@ static int parse_reflog_param(const struct option *opt, const char *arg,
 int cmd_show_branch(int ac,
 		const char **av,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		bool has_repo UNUSED)
 {
 	struct commit *rev[MAX_REVS], *commit;
 	char *reflog_msg[MAX_REVS] = {0};
diff --git c/builtin/show-index.c w/builtin/show-index.c
index 24f0230967..ea9feab5b6 100644
--- c/builtin/show-index.c
+++ w/builtin/show-index.c
@@ -16,7 +16,7 @@ static const char *const show_index_usage[] = {
 int cmd_show_index(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	int i;
 	unsigned nr;
diff --git c/builtin/show-ref.c w/builtin/show-ref.c
index d508441632..0e725f36ca 100644
--- c/builtin/show-ref.c
+++ w/builtin/show-ref.c
@@ -298,9 +298,9 @@ static int exclude_existing_callback(const struct option *opt, const char *arg,
 }
 
 int cmd_show_ref(int argc,
-const char **argv,
-const char *prefix,
-struct repository *repo UNUSED)
+		 const char **argv,
+		 const char *prefix,
+		 bool has_repo UNUSED)
 {
 	struct exclude_existing_options exclude_existing_opts = {0};
 	struct patterns_options patterns_opts = {0};
diff --git c/builtin/sparse-checkout.c w/builtin/sparse-checkout.c
index cb4a037b77..1887b745e5 100644
--- c/builtin/sparse-checkout.c
+++ w/builtin/sparse-checkout.c
@@ -1183,7 +1183,7 @@ static int sparse_checkout_check_rules(int argc, const char **argv, const char *
 int cmd_sparse_checkout(int argc,
 			const char **argv,
 			const char *prefix,
-			struct repository *repo)
+			bool has_repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_sparse_checkout_options[] = {
@@ -1204,8 +1204,8 @@ int cmd_sparse_checkout(int argc,
 
 	repo_config(the_repository, git_default_config, NULL);
 
-	prepare_repo_settings(repo);
-	repo->settings.command_requires_full_index = 0;
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
 
-	return fn(argc, argv, prefix, repo);
+	return fn(argc, argv, prefix, the_repository);
 }
diff --git c/builtin/stash.c w/builtin/stash.c
index 72c52571f8..4bf8a68212 100644
--- c/builtin/stash.c
+++ w/builtin/stash.c
@@ -2453,7 +2453,7 @@ static int export_stash(int argc,
 int cmd_stash(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo)
+	      bool has_repo UNUSED)
 {
 	pid_t pid = getpid();
 	const char *index_file;
@@ -2493,9 +2493,9 @@ int cmd_stash(int argc,
 		    (uintmax_t)pid);
 
 	if (fn)
-		return !!fn(argc, argv, prefix, repo);
+		return !!fn(argc, argv, prefix, the_repository);
 	else if (!argc)
-		return !!push_stash_unassumed(0, NULL, prefix, repo);
+		return !!push_stash_unassumed(0, NULL, prefix, the_repository);
 
 	/* Assume 'stash push' */
 	strvec_push(&args, "push");
diff --git c/builtin/stripspace.c w/builtin/stripspace.c
index 18705f1a5b..b27e4bfb26 100644
--- c/builtin/stripspace.c
+++ w/builtin/stripspace.c
@@ -33,7 +33,7 @@ enum stripspace_mode {
 int cmd_stripspace(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	struct strbuf buf = STRBUF_INIT;
 	enum stripspace_mode mode = STRIP_DEFAULT;
diff --git c/builtin/submodule--helper.c w/builtin/submodule--helper.c
index e7cd3225fa..a86cec5798 100644
--- c/builtin/submodule--helper.c
+++ w/builtin/submodule--helper.c
@@ -3804,7 +3804,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
 int cmd_submodule__helper(int argc,
 			  const char **argv,
 			  const char *prefix,
-			  struct repository *repo)
+			  bool has_repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	const char *const usage[] = {
@@ -3833,5 +3833,5 @@ int cmd_submodule__helper(int argc,
 	};
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
-	return fn(argc, argv, prefix, repo);
+	return fn(argc, argv, prefix, the_repository);
 }
diff --git c/builtin/symbolic-ref.c w/builtin/symbolic-ref.c
index 231e41e715..8644548c9a 100644
--- c/builtin/symbolic-ref.c
+++ w/builtin/symbolic-ref.c
@@ -46,7 +46,7 @@ static int check_symref(const char *HEAD, int quiet, int shorten, int recurse, i
 int cmd_symbolic_ref(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     bool has_repo UNUSED)
 {
 	int quiet = 0, delete = 0, shorten = 0, recurse = 1, ret = 0;
 	const char *msg = NULL;
diff --git c/builtin/tag.c w/builtin/tag.c
index 06c125b53c..1fa660497e 100644
--- c/builtin/tag.c
+++ w/builtin/tag.c
@@ -454,7 +454,7 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 int cmd_tag(int argc,
 	    const char **argv,
 	    const char *prefix,
-	    struct repository *repo UNUSED)
+	    bool has_repo UNUSED)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf ref = STRBUF_INIT;
diff --git c/builtin/unpack-file.c w/builtin/unpack-file.c
index 387389ed49..7e660b18b1 100644
--- c/builtin/unpack-file.c
+++ w/builtin/unpack-file.c
@@ -34,7 +34,7 @@ static const char usage_msg[] =
 int cmd_unpack_file(int argc,
 		    const char **argv,
 		    const char *prefix UNUSED,
-		    struct repository *repo UNUSED)
+		    bool has_repo UNUSED)
 {
 	struct object_id oid;
 
diff --git c/builtin/unpack-objects.c w/builtin/unpack-objects.c
index 3392a3b87d..73e2e450c9 100644
--- c/builtin/unpack-objects.c
+++ w/builtin/unpack-objects.c
@@ -617,7 +617,7 @@ static void unpack_all(void)
 int cmd_unpack_objects(int argc,
 		       const char **argv,
 		       const char *prefix UNUSED,
-		       struct repository *repo)
+		       bool has_repo UNUSED)
 {
 	int i;
 	struct object_id oid;
@@ -631,7 +631,7 @@ int cmd_unpack_objects(int argc,
 
 	show_usage_if_asked(argc, argv, unpack_usage);
 
-	fsck_options_init(&fsck_options, repo, FSCK_OPTIONS_STRICT);
+	fsck_options_init(&fsck_options, the_repository, FSCK_OPTIONS_STRICT);
 
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
diff --git c/builtin/update-index.c w/builtin/update-index.c
index 241abd4332..d3398392b2 100644
--- c/builtin/update-index.c
+++ w/builtin/update-index.c
@@ -915,7 +915,7 @@ static enum parse_opt_result reupdate_callback(
 int cmd_update_index(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     bool has_repo UNUSED)
 {
 	int newfd, entries, has_errors = 0, nul_term_line = 0;
 	enum uc_mode untracked_cache = UC_UNSPECIFIED;
diff --git c/builtin/update-ref.c w/builtin/update-ref.c
index 6355c3dd3e..1511ce43bd 100644
--- c/builtin/update-ref.c
+++ w/builtin/update-ref.c
@@ -810,7 +810,7 @@ static void update_refs_stdin(unsigned int flags)
 int cmd_update_ref(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	const char *refname, *oldval;
 	struct object_id oid, oldoid;
diff --git c/builtin/update-server-info.c w/builtin/update-server-info.c
index 4c12968a83..2d13e710e1 100644
--- c/builtin/update-server-info.c
+++ w/builtin/update-server-info.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
@@ -13,7 +14,7 @@ static const char * const update_server_info_usage[] = {
 int cmd_update_server_info(int argc,
 			   const char **argv,
 			   const char *prefix,
-			   struct repository *repo)
+			   bool has_repo UNUSED)
 {
 	int force = 0;
 	struct option options[] = {
@@ -21,12 +22,12 @@ int cmd_update_server_info(int argc,
 		OPT_END()
 	};
 
-	repo_config(repo, git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     update_server_info_usage, 0);
 	if (argc > 0)
 		usage_with_options(update_server_info_usage, options);
 
-	return !!update_server_info(repo, force);
+	return !!update_server_info(the_repository, force);
 }
diff --git c/builtin/upload-archive.c w/builtin/upload-archive.c
index 718e74b3ac..510540dd78 100644
--- c/builtin/upload-archive.c
+++ w/builtin/upload-archive.c
@@ -21,7 +21,7 @@ static const char deadchild[] =
 int cmd_upload_archive_writer(int argc,
 			      const char **argv,
 			      const char *prefix,
-			      struct repository *repo UNUSED)
+			      bool has_repo UNUSED)
 {
 	struct strvec sent_argv = STRVEC_INIT;
 	const char *arg_cmd = "argument ";
@@ -85,9 +85,9 @@ static ssize_t process_input(int child_fd, int band)
 }
 
 int cmd_upload_archive(int argc,
-const char **argv,
-const char *prefix,
-struct repository *repo UNUSED)
+		       const char **argv,
+		       const char *prefix,
+		       bool has_repo UNUSED)
 {
 	struct child_process writer = CHILD_PROCESS_INIT;
 
diff --git c/builtin/upload-pack.c w/builtin/upload-pack.c
index 32831fb879..ffd5a4a70c 100644
--- c/builtin/upload-pack.c
+++ w/builtin/upload-pack.c
@@ -22,7 +22,7 @@ static const char * const upload_pack_usage[] = {
 int cmd_upload_pack(int argc,
 		    const char **argv,
 		    const char *prefix,
-		    struct repository *repo UNUSED)
+		    bool has_repo UNUSED)
 {
 	const char *dir;
 	int strict = 0;
diff --git c/builtin/url-parse.c w/builtin/url-parse.c
index 7e705538c0..87309bd58c 100644
--- c/builtin/url-parse.c
+++ w/builtin/url-parse.c
@@ -100,7 +100,7 @@ static char *extract_component(enum url_component component,
 int cmd_url_parse(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  bool has_repo UNUSED)
 {
 	struct url_info info;
 	enum url_component selected = URL_NONE;
diff --git c/builtin/var.c w/builtin/var.c
index cc3a43cde2..102e1ce58d 100644
--- c/builtin/var.c
+++ w/builtin/var.c
@@ -217,7 +217,7 @@ static int show_config(const char *var, const char *value,
 int cmd_var(int argc,
 	    const char **argv,
 	    const char *prefix UNUSED,
-	    struct repository *repo UNUSED)
+	    bool has_repo UNUSED)
 {
 	const struct git_var *git_var;
 	char *val;
diff --git c/builtin/verify-commit.c w/builtin/verify-commit.c
index 62398acd72..c10f4d31a2 100644
--- c/builtin/verify-commit.c
+++ w/builtin/verify-commit.c
@@ -5,6 +5,7 @@
  *
  * Based on git-verify-tag
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
@@ -54,7 +55,7 @@ static int verify_commit(struct repository *repo, const char *name, unsigned fla
 int cmd_verify_commit(int argc,
 		      const char **argv,
 		      const char *prefix,
-		      struct repository *repo)
+		      bool has_repo UNUSED)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
@@ -64,7 +65,7 @@ int cmd_verify_commit(int argc,
 		OPT_END()
 	};
 
-	repo_config(repo, git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_commit_options,
 			     verify_commit_usage, PARSE_OPT_KEEP_ARGV0);
@@ -78,7 +79,7 @@ int cmd_verify_commit(int argc,
 	 * was received in the process of writing the gpg input: */
 	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
-		if (verify_commit(repo, argv[i++], flags))
+		if (verify_commit(the_repository, argv[i++], flags))
 			had_error = 1;
 	return had_error;
 }
diff --git c/builtin/verify-pack.c w/builtin/verify-pack.c
index 65fd6629a0..04d40333c9 100644
--- c/builtin/verify-pack.c
+++ w/builtin/verify-pack.c
@@ -66,7 +66,7 @@ static const char * const verify_pack_usage[] = {
 int cmd_verify_pack(int argc,
 		    const char **argv,
 		    const char *prefix,
-		    struct repository *repo UNUSED)
+		    bool has_repo UNUSED)
 {
 	int err = 0;
 	unsigned int flags = 0;
diff --git c/builtin/verify-tag.c w/builtin/verify-tag.c
index 4a261b2369..ed019201de 100644
--- c/builtin/verify-tag.c
+++ w/builtin/verify-tag.c
@@ -5,6 +5,7 @@
  *
  * Based on git-verify-tag.sh
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
@@ -23,7 +24,7 @@ static const char * const verify_tag_usage[] = {
 int cmd_verify_tag(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo)
+		   bool has_repo UNUSED)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
@@ -35,7 +36,7 @@ int cmd_verify_tag(int argc,
 		OPT_END()
 	};
 
-	repo_config(repo, git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_tag_options,
 			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
@@ -56,12 +57,12 @@ int cmd_verify_tag(int argc,
 		struct object_id oid;
 		const char *name = argv[i++];
 
-		if (repo_get_oid(repo, name, &oid)) {
+		if (repo_get_oid(the_repository, name, &oid)) {
 			had_error = !!error("tag '%s' not found.", name);
 			continue;
 		}
 
-		if (gpg_verify_tag(repo, &oid, name, flags)) {
+		if (gpg_verify_tag(the_repository, &oid, name, flags)) {
 			had_error = 1;
 			continue;
 		}
diff --git c/builtin/worktree.c w/builtin/worktree.c
index 654d27c3e1..db29e28432 100644
--- c/builtin/worktree.c
+++ w/builtin/worktree.c
@@ -1469,7 +1469,7 @@ static int repair(int ac, const char **av, const char *prefix,
 int cmd_worktree(int ac,
 		 const char **av,
 		 const char *prefix,
-		 struct repository *repo)
+		 bool has_repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
@@ -1494,5 +1494,5 @@ int cmd_worktree(int ac,
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	return fn(ac, av, prefix, repo);
+	return fn(ac, av, prefix, the_repository);
 }
diff --git c/builtin/write-tree.c w/builtin/write-tree.c
index e3bd1a40db..5c906d4c06 100644
--- c/builtin/write-tree.c
+++ w/builtin/write-tree.c
@@ -21,7 +21,7 @@ static const char * const write_tree_usage[] = {
 int cmd_write_tree(int argc,
 		   const char **argv,
 		   const char *cmd_prefix,
-		   struct repository *repo UNUSED)
+		   bool has_repo UNUSED)
 {
 	int flags = 0, ret;
 	const char *tree_prefix = NULL;
diff --git c/git.c w/git.c
index 96df15b5cd..ff0b2720a2 100644
--- c/git.c
+++ w/git.c
@@ -32,7 +32,7 @@
 
 struct cmd_struct {
 	const char *cmd;
-	int (*fn)(int, const char **, const char *, struct repository *);
+	int (*fn)(int, const char **, const char *, bool);
 	unsigned int option;
 };
 
@@ -507,7 +507,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	trace2_cmd_name(p->cmd);
 
 	validate_cache_entries(repo->index);
-	status = p->fn(argc, argv, prefix, no_repo ? NULL : repo);
+	status = p->fn(argc, argv, prefix, !no_repo);
 	validate_cache_entries(repo->index);
 
 	if (status)
diff --git c/help.c w/help.c
index 46241492ce..df1dc3d398 100644
--- c/help.c
+++ w/help.c
@@ -830,7 +830,7 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 	}
 }
 
-int cmd_version(int argc, const char **argv, const char *prefix, struct repository *repository UNUSED)
+int cmd_version(int argc, const char **argv, const char *prefix, bool has_repo UNUSED)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int build_options = 0;
