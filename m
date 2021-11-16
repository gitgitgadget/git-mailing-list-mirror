Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66807C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C2DD63212
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbhKPS2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 13:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239420AbhKPS2b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 13:28:31 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0866C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:25:33 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o4-20020a17090a3d4400b001a66f10df6cso66834pjf.0
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=qYbdz2yZToABLFCbIPyvA2dHI7PmpPgksYURhzKCAoU=;
        b=qMdIQGn4bZvR3gXaDERRQ5GJybn+tTQL5PaZ701427ak7MP0bXoH3RtI10ONK5FLI7
         fVQ+2yehaJEwt7IwF1n4DfVFQxDjLPIpVgYrfAMIJ3TwKmmAZd1BV/hyByA9tL2sK2Tt
         mvHr1g8rmtXGBoXHVRGfuXlmyLp0Pi3yDT/6TTOMG91DTarowHwKEaoIbOoB8izPZ0OT
         KRU526BlSryyR5fKnPlq9h/2yOP61cVN8Vk4H3HXzyymgLIY49Q/SRJK5E3A3TOZso7V
         Cc3Xtq9e0eCwD/DZoa3+XsZmVML0ZyewMahbkOI33HXAMR+qiB/1CxorFLEn0mXtFXFF
         Ygwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=qYbdz2yZToABLFCbIPyvA2dHI7PmpPgksYURhzKCAoU=;
        b=6Em2R354J4bHGnEbRDpehPTZSOPMfEEWauxtvEHVF0qw+hQ8Rt0scbG3TL5ESvjQZF
         TJWUV9VZ+x5XcTTvFqcjzzUUiOUyRg3fNuA2H8A97c1wn4XLfgUYk2L0e2MBP4XZFhDf
         H8U/nIzQRrpoVWo96d7qhSDMf3vQrKkP+9JeJ4r4fB1XddgsMHMBzTifiZK0e91ydwKP
         vdK+v5Wiz/9zeLvIbRLY1KKq6UbdrAWLg8QXvr04GFrYCvQlDGodriOnRNeMcBSUTaZv
         DgqNRZz/k+yhH4ZxAszMfTHood+J8uUpx6BejlavIIFLVZU33mcE+Ap8D+AsJILnuoRJ
         GK7w==
X-Gm-Message-State: AOAM533UFqxGdFhYZ2fAg+yL7vk3LLhLVOUP/L8R1YbTrynlSSPoovti
        A/b4vFcINrXAVuSv7yiM5O0RGYR5dZlLyP0LfY7HHSQoknFh8f7Hx4uLUG9EcRyL0OpC5P4b78g
        eXbL5v1CLrgG68BkLsH2VjGVxGCd9CgCIIZvRH9fvYBxu3jpP5s6CreTs4G8xl50=
X-Google-Smtp-Source: ABdhPJzeEWRdRltqKBDJV4Yz4VhknEqkg4RUiKmtEqfFeto6oXgL227k7DGXdlIKXc8qN56ty3bJxd5aLfYLtQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:9bb:b2ac:3919:1528])
 (user=steadmon job=sendgmr) by 2002:a63:6b42:: with SMTP id
 g63mr697777pgc.133.1637087133328; Tue, 16 Nov 2021 10:25:33 -0800 (PST)
Date:   Tue, 16 Nov 2021 10:25:31 -0800
In-Reply-To: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
Message-Id: <7ad7507f183332cb2b5fdf2eb76fbbc9dd7199ef.1637085915.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v4] branch: add flags and config to inherit tracking
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chooglen@google.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be helpful when creating a new branch to use the existing
tracking configuration from the branch point. However, there is
currently not a method to automatically do so.

Teach git-{branch,checkout,switch} an "inherit" argument to the
"--track" option. When this is set, creating a new branch will cause the
tracking configuration to default to the configuration of the branch
point, if set.

For example, if branch "main" tracks "origin/main", and we run
`git checkout --track=3Dinherit -b feature main`, then branch "feature"
will track "origin/main". Thus, `git status` will show us how far
ahead/behind we are from origin, and `git pull` will pull from origin.

This is particularly useful when creating branches across many
submodules, such as with `git submodule foreach ...` (or if running with
a patch such as [1], which we use at $job), as it avoids having to
manually set tracking info for each submodule.

Since we've added an argument to "--track", also add "--track=3Ddirect" as
another way to explicitly get the original "--track" behavior ("--track"
without an argument still works as well).

Finally, teach branch.autoSetupMerge a new "inherit" option. When this
is set, "--track=3Dinherit" becomes the default behavior.

[1]: https://lore.kernel.org/git/20180927221603.148025-1-sbeller@google.com=
/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
I've addressed Glen's feedback from V3. However, this brings up a new
issue that was not obvious before: "branch.<name>.merge" can be
specified more than once. On the other hand, the existing tracking setup
code supports only a single merge entry. For now I'm defaulting to use
the first merge entry listed in the branch struct, but I'm curious what
people think the best solution would be. This may be another point in
favor of =C3=86var's suggestion to reuse the copy-branch-config machinery.

Changes since V3:
* Use branch_get() instead of git_config_get_string() to look up branch
  configuration.
* Remove unnecessary string formatting in new error message in
  parse-options-cb.c.

Range-diff against v3:
1:  b9356d9837 ! 1:  7ad7507f18 branch: add flags and config to inherit tra=
cking
    @@ branch.c: int install_branch_config(int flag, const char *local, con=
st char *ori
     =20
     +static int inherit_tracking(struct tracking *tracking, const char *or=
ig_ref)
     +{
    -+	struct strbuf key =3D STRBUF_INIT;
    -+	char *remote;
     +	const char *bare_ref;
    ++	struct branch *branch;
     +
     +	bare_ref =3D orig_ref;
     +	skip_prefix(orig_ref, "refs/heads/", &bare_ref);
     +
    -+	strbuf_addf(&key, "branch.%s.remote", bare_ref);
    -+	if (git_config_get_string(key.buf, &remote)) {
    -+		warning(_("asked to inherit tracking from %s, but could not find %s=
"),
    -+			bare_ref, key.buf);
    -+		strbuf_release(&key);
    ++	branch =3D branch_get(bare_ref);
    ++	if (!branch->remote_name) {
    ++		warning(_("asked to inherit tracking from %s, but no remote is set"=
),
    ++			bare_ref);
     +		return -1;
     +	}
     +
    -+	strbuf_reset(&key);
    -+	strbuf_addf(&key, "branch.%s.merge", bare_ref);
    -+	if (git_config_get_string(key.buf, &tracking->src)) {
    -+		warning(_("asked to inherit tracking from %s, but could not find %s=
"),
    -+			bare_ref, key.buf);
    -+		strbuf_release(&key);
    -+		free(remote);
    ++	if (branch->merge_nr < 1 || !branch->merge_name || !branch->merge_na=
me[0]) {
    ++		warning(_("asked to inherit tracking from %s, but no merge configur=
ation is set"),
    ++			bare_ref);
     +		return -1;
     +	}
     +
    -+	tracking->remote =3D remote;
    ++	tracking->remote =3D xstrdup(branch->remote_name);
    ++	tracking->src =3D xstrdup(branch->merge_name[0]);
     +	tracking->matches =3D 1;
    -+	strbuf_release(&key);
     +	return 0;
     +}
     +
    @@ parse-options-cb.c: int parse_opt_passthru_argv(const struct option =
*opt, const
     +	else if (!strcmp(arg, "inherit"))
     +		*(enum branch_track *)opt->value =3D BRANCH_TRACK_INHERIT;
     +	else
    -+		return error(_("option `%s' expects \"direct\" or \"inherit\""),
    -+			     opt->long_name);
    ++		return error(_("option `--track' expects \"direct\" or \"inherit\""=
));
     +
     +	return 0;
     +}

 Documentation/config/branch.txt |  3 ++-
 Documentation/git-branch.txt    | 21 ++++++++++++++-------
 Documentation/git-checkout.txt  |  2 +-
 Documentation/git-switch.txt    |  2 +-
 branch.c                        | 31 ++++++++++++++++++++++++++++++-
 branch.h                        |  3 ++-
 builtin/branch.c                |  6 ++++--
 builtin/checkout.c              |  6 ++++--
 config.c                        |  3 +++
 parse-options-cb.c              | 14 ++++++++++++++
 parse-options.h                 |  2 ++
 t/t2017-checkout-orphan.sh      |  7 +++++++
 t/t2027-checkout-track.sh       | 23 +++++++++++++++++++++++
 t/t2060-switch.sh               | 28 ++++++++++++++++++++++++++++
 t/t3200-branch.sh               | 33 +++++++++++++++++++++++++++++++++
 t/t7201-co.sh                   | 17 +++++++++++++++++
 16 files changed, 185 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.=
txt
index cc5f3249fc..55f7522e12 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -7,7 +7,8 @@ branch.autoSetupMerge::
 	automatic setup is done; `true` -- automatic setup is done when the
 	starting point is a remote-tracking branch; `always` --
 	automatic setup is done when the starting point is either a
-	local branch or remote-tracking
+	local branch or remote-tracking branch; `inherit` -- if the starting poin=
t
+	has a tracking configuration, it is copied to the new
 	branch. This option defaults to true.
=20
 branch.autoSetupRebase::
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 94dc9a54f2..e484a3803a 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	[--points-at <object>] [--format=3D<format>]
 	[(-r | --remotes) | (-a | --all)]
 	[--list] [<pattern>...]
-'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
+'git branch' [--track [direct|inherit] | --no-track] [-f] <branchname> [<s=
tart-point>]
 'git branch' (--set-upstream-to=3D<upstream> | -u <upstream>) [<branchname=
>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -205,24 +205,31 @@ This option is only applicable in non-verbose mode.
 	Display the full sha1s in the output listing rather than abbreviating the=
m.
=20
 -t::
---track::
+--track [inherit|direct]::
 	When creating a new branch, set up `branch.<name>.remote` and
-	`branch.<name>.merge` configuration entries to mark the
-	start-point branch as "upstream" from the new branch. This
+	`branch.<name>.merge` configuration entries to set "upstream" tracking
+	configuration for the new branch. This
 	configuration will tell git to show the relationship between the
 	two branches in `git status` and `git branch -v`. Furthermore,
 	it directs `git pull` without arguments to pull from the
 	upstream when the new branch is checked out.
 +
-This behavior is the default when the start point is a remote-tracking bra=
nch.
+The exact upstream branch is chosen depending on the optional argument:
+`--track` or `--track direct` means to use the start-point branch itself a=
s the
+upstream; `--track inherit` means to copy the upstream configuration of th=
e
+start-point branch.
++
+`--track direct` is the default when the start point is a remote-tracking =
branch.
 Set the branch.autoSetupMerge configuration variable to `false` if you
 want `git switch`, `git checkout` and `git branch` to always behave as if =
`--no-track`
 were given. Set it to `always` if you want this behavior when the
-start-point is either a local or remote-tracking branch.
+start-point is either a local or remote-tracking branch. Set it to
+`inherit` if you want to copy the tracking configuration from the
+branch point.
=20
 --no-track::
 	Do not set up "upstream" configuration, even if the
-	branch.autoSetupMerge configuration variable is true.
+	branch.autoSetupMerge configuration variable is set.
=20
 --set-upstream::
 	As this option had confusing syntax, it is no longer supported.
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.tx=
t
index b1a6fe4499..a48e1ab62f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -155,7 +155,7 @@ of it").
 	linkgit:git-branch[1] for details.
=20
 -t::
---track::
+--track [direct|inherit]::
 	When creating a new branch, set up "upstream" configuration. See
 	"--track" in linkgit:git-branch[1] for details.
 +
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 5c438cd505..96dc036ea5 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -152,7 +152,7 @@ should result in deletion of the path).
 	attached to a terminal, regardless of `--quiet`.
=20
 -t::
---track::
+--track [direct|inherit]::
 	When creating a new branch, set up "upstream" configuration.
 	`-c` is implied. See `--track` in linkgit:git-branch[1] for
 	details.
diff --git a/branch.c b/branch.c
index 7a88a4861e..f018e440a6 100644
--- a/branch.c
+++ b/branch.c
@@ -126,6 +126,33 @@ int install_branch_config(int flag, const char *local,=
 const char *origin, const
 	return -1;
 }
=20
+static int inherit_tracking(struct tracking *tracking, const char *orig_re=
f)
+{
+	const char *bare_ref;
+	struct branch *branch;
+
+	bare_ref =3D orig_ref;
+	skip_prefix(orig_ref, "refs/heads/", &bare_ref);
+
+	branch =3D branch_get(bare_ref);
+	if (!branch->remote_name) {
+		warning(_("asked to inherit tracking from %s, but no remote is set"),
+			bare_ref);
+		return -1;
+	}
+
+	if (branch->merge_nr < 1 || !branch->merge_name || !branch->merge_name[0]=
) {
+		warning(_("asked to inherit tracking from %s, but no merge configuration=
 is set"),
+			bare_ref);
+		return -1;
+	}
+
+	tracking->remote =3D xstrdup(branch->remote_name);
+	tracking->src =3D xstrdup(branch->merge_name[0]);
+	tracking->matches =3D 1;
+	return 0;
+}
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
@@ -139,7 +166,9 @@ static void setup_tracking(const char *new_ref, const c=
har *orig_ref,
=20
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst =3D (char *)orig_ref;
-	if (for_each_remote(find_tracked_branch, &tracking))
+	if (track !=3D BRANCH_TRACK_INHERIT) {
+		for_each_remote(find_tracked_branch, &tracking);
+	} else if (inherit_tracking(&tracking, orig_ref))
 		return;
=20
 	if (!tracking.matches)
diff --git a/branch.h b/branch.h
index df0be61506..6484bda8a2 100644
--- a/branch.h
+++ b/branch.h
@@ -10,7 +10,8 @@ enum branch_track {
 	BRANCH_TRACK_REMOTE,
 	BRANCH_TRACK_ALWAYS,
 	BRANCH_TRACK_EXPLICIT,
-	BRANCH_TRACK_OVERRIDE
+	BRANCH_TRACK_OVERRIDE,
+	BRANCH_TRACK_INHERIT
 };
=20
 extern enum branch_track git_branch_track;
diff --git a/builtin/branch.c b/builtin/branch.c
index b23b1d1752..15f70fe3fa 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -632,8 +632,10 @@ int cmd_branch(int argc, const char **argv, const char=
 *prefix)
 		OPT__VERBOSE(&filter.verbose,
 			N_("show hash and subject, give twice for upstream branch")),
 		OPT__QUIET(&quiet, N_("suppress informational messages")),
-		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pul=
l(1))"),
-			BRANCH_TRACK_EXPLICIT),
+		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
+			N_("set up tracking mode (see git-pull(1))"),
+			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+			parse_opt_tracking_mode),
 		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
 			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("ch=
ange the upstream info")),
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5d477919a..45dab414ea 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1532,8 +1532,10 @@ static struct option *add_common_switch_branch_optio=
ns(
 {
 	struct option options[] =3D {
 		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named co=
mmit")),
-		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new b=
ranch"),
-			BRANCH_TRACK_EXPLICIT),
+		OPT_CALLBACK_F('t', "track",  &opts->track, "direct|inherit",
+			N_("set up tracking mode (see git-pull(1))"),
+			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+			parse_opt_tracking_mode),
 		OPT__FORCE(&opts->force, N_("force checkout (throw away local modificati=
ons)"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("=
new unparented branch")),
diff --git a/config.c b/config.c
index cb4a8058bf..4bd5a18faf 100644
--- a/config.c
+++ b/config.c
@@ -1580,6 +1580,9 @@ static int git_default_branch_config(const char *var,=
 const char *value)
 		if (value && !strcasecmp(value, "always")) {
 			git_branch_track =3D BRANCH_TRACK_ALWAYS;
 			return 0;
+		} else if (value && !strcasecmp(value, "inherit")) {
+			git_branch_track =3D BRANCH_TRACK_INHERIT;
+			return 0;
 		}
 		git_branch_track =3D git_config_bool(var, value);
 		return 0;
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 3c811e1e4a..91261d8c41 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
+#include "branch.h"
 #include "cache.h"
 #include "commit.h"
 #include "color.h"
@@ -293,3 +294,16 @@ int parse_opt_passthru_argv(const struct option *opt, =
const char *arg, int unset
=20
 	return 0;
 }
+
+int parse_opt_tracking_mode(const struct option *opt, const char *arg, int=
 unset) {
+	if (unset)
+		*(enum branch_track *)opt->value =3D BRANCH_TRACK_NEVER;
+	else if (!arg || !strcmp(arg, "direct"))
+		*(enum branch_track *)opt->value =3D BRANCH_TRACK_EXPLICIT;
+	else if (!strcmp(arg, "inherit"))
+		*(enum branch_track *)opt->value =3D BRANCH_TRACK_INHERIT;
+	else
+		return error(_("option `--track' expects \"direct\" or \"inherit\""));
+
+	return 0;
+}
diff --git a/parse-options.h b/parse-options.h
index a845a9d952..f35dbfdd5a 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -303,6 +303,8 @@ enum parse_opt_result parse_opt_unknown_cb(struct parse=
_opt_ctx_t *ctx,
 					   const char *, int);
 int parse_opt_passthru(const struct option *, const char *, int);
 int parse_opt_passthru_argv(const struct option *, const char *, int);
+/* value is enum branch_track* */
+int parse_opt_tracking_mode(const struct option *, const char *, int);
=20
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index 88d6992a5e..31fb64c5be 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -64,6 +64,13 @@ test_expect_success '--orphan ignores branch.autosetupme=
rge' '
 	git checkout --orphan gamma &&
 	test -z "$(git config branch.gamma.merge)" &&
 	test refs/heads/gamma =3D "$(git symbolic-ref HEAD)" &&
+	test_must_fail git rev-parse --verify HEAD^ &&
+	git checkout main &&
+	git config branch.autosetupmerge inherit &&
+	git checkout --orphan eta &&
+	test -z "$(git config branch.eta.merge)" &&
+	test -z "$(git config branch.eta.remote)" &&
+	test refs/heads/eta =3D "$(git symbolic-ref HEAD)" &&
 	test_must_fail git rev-parse --verify HEAD^
 '
=20
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
index 4453741b96..e87d77f629 100755
--- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -24,4 +24,27 @@ test_expect_success 'checkout --track -b rejects an extr=
a path argument' '
 	test_i18ngrep "cannot be used with updating paths" err
 '
=20
+test_expect_success 'checkout --track -b overrides autoSetupMerge=3Dinheri=
t' '
+	# Set up tracking config on main
+	git config branch.main.remote origin &&
+	git config branch.main.merge refs/heads/main &&
+	test_config branch.autoSetupMerge inherit &&
+	# With --track=3Dinherit, we copy the tracking config from main
+	git checkout --track=3Dinherit -b b1 main &&
+	test_cmp_config origin branch.b1.remote &&
+	test_cmp_config refs/heads/main branch.b1.merge &&
+	# With branch.autoSetupMerge=3Dinherit, we do the same
+	git checkout -b b2 main &&
+	test_cmp_config origin branch.b2.remote &&
+	test_cmp_config refs/heads/main branch.b2.merge &&
+	# But --track overrides this
+	git checkout --track -b b3 main &&
+	test_cmp_config . branch.b3.remote &&
+	test_cmp_config refs/heads/main branch.b3.merge &&
+	# And --track=3Ddirect does as well
+	git checkout --track=3Ddirect -b b4 main &&
+	test_cmp_config . branch.b4.remote &&
+	test_cmp_config refs/heads/main branch.b4.merge
+'
+
 test_done
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index 9bc6a3aa5c..76e9d12e36 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -107,4 +107,32 @@ test_expect_success 'not switching when something is i=
n progress' '
 	test_must_fail git switch -d @^
 '
=20
+test_expect_success 'tracking info copied with autoSetupMerge=3Dinherit' '
+	# default config does not copy tracking info
+	git switch -c foo-no-inherit foo &&
+	test -z "$(git config branch.foo-no-inherit.remote)" &&
+	test -z "$(git config branch.foo-no-inherit.merge)" &&
+	# with --track=3Dinherit, we copy tracking info from foo
+	git switch --track=3Dinherit -c foo2 foo &&
+	test_cmp_config origin branch.foo2.remote &&
+	test_cmp_config refs/heads/foo branch.foo2.merge &&
+	# with autoSetupMerge=3Dinherit, we do the same
+	test_config branch.autoSetupMerge inherit &&
+	git switch -c foo3 foo &&
+	test_cmp_config origin branch.foo3.remote &&
+	test_cmp_config refs/heads/foo branch.foo3.merge &&
+	# with --track, we override autoSetupMerge
+	git switch --track -c foo4 foo &&
+	test_cmp_config . branch.foo4.remote &&
+	test_cmp_config refs/heads/foo branch.foo4.merge &&
+	# and --track=3Ddirect does as well
+	git switch --track=3Ddirect -c foo5 foo &&
+	test_cmp_config . branch.foo5.remote &&
+	test_cmp_config refs/heads/foo branch.foo5.merge &&
+	# no tracking info to inherit from main
+	git switch -c main2 main &&
+	test -z "$(git config branch.main2.remote)" &&
+	test -z "$(git config branch.main2.merge)"
+'
+
 test_done
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cc4b10236e..bc547b08e1 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1409,4 +1409,37 @@ test_expect_success 'invalid sort parameter in confi=
guration' '
 	)
 '
=20
+test_expect_success 'tracking info copied with --track=3Dinherit' '
+	git branch --track=3Dinherit foo2 my1 &&
+	test_cmp_config local branch.foo2.remote &&
+	test_cmp_config refs/heads/main branch.foo2.merge
+'
+
+test_expect_success 'tracking info copied with autoSetupMerge=3Dinherit' '
+	test_unconfig branch.autoSetupMerge &&
+	# default config does not copy tracking info
+	git branch foo-no-inherit my1 &&
+	test -z "$(git config branch.foo-no-inherit.remote)" &&
+	test -z "$(git config branch.foo-no-inherit.merge)" &&
+	# with autoSetupMerge=3Dinherit, we copy tracking info from my1
+	test_config branch.autoSetupMerge inherit &&
+	git branch foo3 my1 &&
+	test_cmp_config local branch.foo3.remote &&
+	test_cmp_config refs/heads/main branch.foo3.merge &&
+	# no tracking info to inherit from main
+	git branch main2 main &&
+	test -z "$(git config branch.main2.remote)" &&
+	test -z "$(git config branch.main2.merge)"
+'
+
+test_expect_success '--track overrides branch.autoSetupMerge' '
+	test_config branch.autoSetupMerge inherit &&
+	git branch --track=3Ddirect foo4 my1 &&
+	test_cmp_config . branch.foo4.remote &&
+	test_cmp_config refs/heads/my1 branch.foo4.merge &&
+	git branch --no-track foo5 my1 &&
+	test -z "$(git config branch.foo5.remote)" &&
+	test -z "$(git config branch.foo5.merge)"
+'
+
 test_done
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 7f6e23a4bb..ae9f8d02c2 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -657,4 +657,21 @@ test_expect_success 'custom merge driver with checkout=
 -m' '
 	test_cmp expect arm
 '
=20
+test_expect_success 'tracking info copied with autoSetupMerge=3Dinherit' '
+	git reset --hard main &&
+	# default config does not copy tracking info
+	git checkout -b foo-no-inherit koala/bear &&
+	test -z "$(git config branch.foo-no-inherit.remote)" &&
+	test -z "$(git config branch.foo-no-inherit.merge)" &&
+	# with autoSetupMerge=3Dinherit, we copy tracking info from koala/bear
+	test_config branch.autoSetupMerge inherit &&
+	git checkout -b foo koala/bear &&
+	test_cmp_config origin branch.foo.remote &&
+	test_cmp_config refs/heads/koala/bear branch.foo.merge &&
+	# no tracking info to inherit from main
+	git checkout -b main2 main &&
+	test -z "$(git config branch.main2.remote)" &&
+	test -z "$(git config branch.main2.merge)"
+'
+
 test_done

base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
--=20
2.34.0.rc1.387.gb447b232ab-goog

