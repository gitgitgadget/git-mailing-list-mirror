From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 00/16] port branch.c to use ref-filter's printing options
Date: Sat, 23 Apr 2016 00:33:51 +0530
Message-ID: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:04:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atgNo-00088a-S6
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 21:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbcDVTEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 15:04:46 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34529 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbcDVTES (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 15:04:18 -0400
Received: by mail-pa0-f65.google.com with SMTP id yl2so6805418pac.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5KBxFyCM/u7YpSKfaViemZDqdTeGVNGsDRfyoS/X/uQ=;
        b=xSNTP5Oe27Cny1mO7WdYS74bhbyNtNqe2H9MaetAnDtKMMTwmOCIR+nBMVC9JPxT2m
         b59/0BNZ1lyp7Sxat+7UWV/oi3JBtl9lM3rHcIqaFIOSgjDLbYrmmuLyYnTpo40LtzCY
         J+1zXz1lqJ4Gm+ofQZEIJZNYQwCwbXfgx/RFXGchBdptPcogV6MWPlUNV9uF4gfMApov
         MQ99ixrLCl2ds38TRZtSyT+ONEVkHfnJX+9veNUkSo688VM/LORN34yu9ivioeWtpqPt
         9KoiawDVHFrlFMb+sCXilC9WLoELlzVCSCxBV9/v2u86da5abZ0vXCYe2Vv1CfMB7xU+
         7HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5KBxFyCM/u7YpSKfaViemZDqdTeGVNGsDRfyoS/X/uQ=;
        b=mBvBR4IdnI5XoDLwcRM4kXlv9KPDQQ7jlAeaJulnRHUtTY5SK26q3JZdqYFbMW80jf
         +dLI7nqLBwUXN9Uqt8bSyzNLwpG4+3Rbau2+8ZsyeW8S947bOKTzUHx9RGyyzl059QPg
         CIQhTXNsL/zO8D6mZzfIeK6faT/TG011OGqiU6WtYGcj9RnYAVJvGCpIQd5OyqQwWOUk
         nmV7GUgkYLYjvfjm0zza2vlEFM5zsCSjuxhWXeFuL8Esn69uysxu0tnoCyhANdl/I1qB
         y3sBceQHsVdOT+ABX6reZa9pFBl8KZ/o17zzBh096PizWGb5mIhZ8OVPQ2yYWf6AyB/Q
         yNXw==
X-Gm-Message-State: AOPr4FX8t1MhVDJKLvGRyHJlegRDxZDpp8G2Le8uvAklSC8yQGmPy0zaNMxP0vDEu6utow==
X-Received: by 10.66.74.138 with SMTP id t10mr30281285pav.22.1461351857940;
        Fri, 22 Apr 2016 12:04:17 -0700 (PDT)
Received: from ashley.localdomain ([106.216.186.206])
        by smtp.gmail.com with ESMTPSA id t1sm11266470paa.17.2016.04.22.12.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 12:04:16 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292252>

This is part of unification of the commands 'git tag -l, git branch -l
and git for-each-ref'. This ports over branch.c to use ref-filter's
printing options.

Initially posted here: $(gmane/279226). It was decided that this series
would follow up after refactoring ref-filter parsing mechanism, which
is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).

v1 can be found here: $(gmane/288342)
v2 can be found here: $(gmane/288863)
v3 can be found here: $(gmane/290299)
v4 can be found here: $(gmane/291106)

Changes in this version:
1. Rebased on top of jk/branch-shortening-funny-symrefs ($gmane/291295).
2. Introduced refname_atom_parser_internal() to act as a common ground
for ref-printing atoms. Written by Jeff ($gmane/291497).
3. Ensure that ':dir', 'base', 'strip' is available to all ref-printing
atoms. Written by Jeff.
4. Fix a memory leak which was reported by Stefan ($gmane/291703).

Thanks to Junio, Jeff and Stefan for suggestions on the previous version.

Karthik Nayak (16):
  ref-filter: include reference to 'used_atom' within 'atom_value'
  ref-filter: implement %(if:equals=<string>) and
    %(if:notequals=<string>)
  ref-filter: modify "%(objectname:short)" to take length
  ref-filter: move get_head_description() from branch.c
  ref-filter: introduce format_ref_array_item()
  ref-filter: make %(upstream:track) prints "[gone]" for invalid
    upstreams
  ref-filter: add support for %(upstream:track,nobracket)
  ref-filter: make "%(symref)" atom work with the ':short' modifier
  ref-filter: introduce refname_atom_parser_internal()
  ref-filter: introduce symref_atom_parser() and refname_atom_parser()
  ref-filter: make remote_ref_atom_parser() use
    refname_atom_parser_internal()
  ref-filter: add `:dir` and `:base` options for ref printing atoms
  ref-filter: allow porcelain to translate messages in the output
  branch, tag: use porcelain output
  branch: use ref-filter printing APIs
  branch: implement '--format' option

 Documentation/git-branch.txt       |   7 +-
 Documentation/git-for-each-ref.txt |  42 +++--
 builtin/branch.c                   | 275 +++++++++---------------------
 builtin/tag.c                      |   2 +
 ref-filter.c                       | 333 +++++++++++++++++++++++++++++--------
 ref-filter.h                       |   7 +
 t/t3203-branch-output.sh           |  16 +-
 t/t6040-tracking-info.sh           |   2 +-
 t/t6300-for-each-ref.sh            |  73 +++++++-
 t/t6302-for-each-ref-filter.sh     |  18 ++
 10 files changed, 488 insertions(+), 287 deletions(-)

Interdiff:

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 0954269..4a5e9ea 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -116,21 +116,23 @@ objectname::
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
-	from the displayed ref. Respects `:short` in the same way as
-	`refname` above.  Additionally respects `:track` to show
-	"[ahead N, behind M]" and `:trackshort` to show the terse
-	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
-	or "=" (in sync). `:track` also prints "[gone]" whenever
-	unknown upstream ref is encountered. Append `:track,nobracket`
-	to show tracking information without brackets (i.e "ahead N,
-	behind M").  Has no effect if the ref does not have tracking
-	information associated with it.
+	from the displayed ref. Respects `:short`, `:strip`, `:base`
+	and `:dir` in the same way as `refname` above.  Additionally
+	respects `:track` to show "[ahead N, behind M]" and
+	`:trackshort` to show the terse version: ">" (ahead), "<"
+	(behind), "<>" (ahead and behind), or "=" (in sync). `:track`
+	also prints "[gone]" whenever unknown upstream ref is
+	encountered. Append `:track,nobracket` to show tracking
+	information without brackets (i.e "ahead N, behind M").  Has
+	no effect if the ref does not have tracking information
+	associated with it.
 
 push::
-	The name of a local ref which represents the `@{push}` location
-	for the displayed ref. Respects `:short`, `:track`, and
-	`:trackshort` options as `upstream` does. Produces an empty
-	string if no `@{push}` ref is configured.
+	The name of a local ref which represents the `@{push}`
+	location for the displayed ref. Respects `:short`, `:strip`,
+	`:track`, `:trackshort`, `:base` and `:dir` options as
+	`upstream` does. Produces an empty string if no `@{push}` ref
+	is configured.
 
 HEAD::
 	'*' if HEAD matches current ref (the checked out branch), ' '
@@ -165,6 +167,12 @@ if::
 	the value between the %(if:...) and %(then) atoms with the
 	given string.
 
+symref::
+	The ref which the given symbolic ref refers to. If not a
+	symbolic ref, nothing is printed. Respects the `:short`,
+	`:strip`, `:base` and `:dir` options in the same way as
+	`refname` above.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/builtin/branch.c b/builtin/branch.c
index c9a2e5b..6847ac3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -288,9 +288,11 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 
 		skip_prefix(it->refname, "refs/heads/", &desc);
 		skip_prefix(it->refname, "refs/remotes/", &desc);
-		if (it->kind == FILTER_REFS_DETACHED_HEAD)
-			w = strlen(get_head_description());
-		else
+		if (it->kind == FILTER_REFS_DETACHED_HEAD) {
+			char *head_desc = get_head_description();
+			w = strlen(head_desc);
+			free(head_desc);
+		} else
 			w = utf8_strwidth(desc);
 
 		if (it->kind == FILTER_REFS_REMOTES)
diff --git a/ref-filter.c b/ref-filter.c
index 3435df1..74c4869 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -50,6 +50,11 @@ struct if_then_else {
 		condition_satisfied : 1;
 };
 
+struct refname_atom {
+	enum { R_BASE, R_DIR, R_NORMAL, R_SHORT, R_STRIP } option;
+	unsigned int strip;
+};
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -67,7 +72,8 @@ static struct used_atom {
 		char color[COLOR_MAXLEN];
 		struct align align;
 		struct {
-			enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT } option;
+			enum { RR_REF, RR_TRACK, RR_TRACKSHORT } option;
+			struct refname_atom refname;
 			unsigned int nobracket: 1;
 		} remote_ref;
 		struct {
@@ -82,11 +88,7 @@ static struct used_atom {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} objectname;
-		enum { S_FULL, S_SHORT } symref;
-		struct {
-			enum { R_BASE, R_DIR, R_NORMAL, R_SHORT, R_STRIP } option;
-			unsigned int strip;
-		} refname;
+		struct refname_atom refname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -100,13 +102,34 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
 		die(_("unrecognized color: %%(color:%s)"), color_value);
 }
 
+static void refname_atom_parser_internal(struct refname_atom *atom,
+					 const char *arg, const char *name)
+{
+	if (!arg)
+		atom->option = R_NORMAL;
+	else if (!strcmp(arg, "short"))
+		atom->option = R_SHORT;
+	else if (skip_prefix(arg, "strip=", &arg)) {
+		atom->option = R_STRIP;
+		if (strtoul_ui(arg, 10, &atom->strip) || atom->strip <= 0)
+			die(_("positive value expected refname:strip=%s"), arg);
+	} else if (!strcmp(arg, "dir"))
+		atom->option = R_DIR;
+	else if (!strcmp(arg, "base"))
+		atom->option = R_BASE;
+	else
+		die(_("unrecognized %%(%s) argument: %s"), name, arg);
+}
+
 static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
 	int i;
 
 	if (!arg) {
-		atom->u.remote_ref.option = RR_NORMAL;
+		atom->u.remote_ref.option = RR_REF;
+		refname_atom_parser_internal(&atom->u.remote_ref.refname,
+					     arg, atom->name);
 		return;
 	}
 
@@ -116,16 +139,17 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 	for (i = 0; i < params.nr; i++) {
 		const char *s = params.items[i].string;
 
-		if (!strcmp(s, "short"))
-			atom->u.remote_ref.option = RR_SHORTEN;
-		else if (!strcmp(s, "track"))
+		if (!strcmp(s, "track"))
 			atom->u.remote_ref.option = RR_TRACK;
 		else if (!strcmp(s, "trackshort"))
 			atom->u.remote_ref.option = RR_TRACKSHORT;
 		else if (!strcmp(s, "nobracket"))
 			atom->u.remote_ref.nobracket = 1;
-		else
-			die(_("unrecognized format: %%(%s)"), atom->name);
+		else {
+			atom->u.remote_ref.option = RR_REF;
+			refname_atom_parser_internal(&atom->u.remote_ref.refname,
+						     arg, atom->name);
+		}
 	}
 
 	string_list_clear(&params, 0);
@@ -170,7 +194,7 @@ static void objectname_atom_parser(struct used_atom *atom, const char *arg)
 	else if (!strcmp(arg, "short"))
 		atom->u.objectname.option = O_SHORT;
 	else if (skip_prefix(arg, "short=", &arg)) {
-		atom->u.contents.option = O_LENGTH;
+		atom->u.objectname.option = O_LENGTH;
 		if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
 		    atom->u.objectname.length == 0)
 			die(_("positive value expected objectname:short=%s"), arg);
@@ -180,6 +204,16 @@ static void objectname_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized %%(objectname) argument: %s"), arg);
 }
 
+static void symref_atom_parser(struct used_atom *atom, const char *arg)
+{
+	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
+}
+
+static void refname_atom_parser(struct used_atom *atom, const char *arg)
+{
+	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
+}
+
 static align_type parse_align_position(const char *s)
 {
 	if (!strcmp(s, "right"))
@@ -242,41 +276,12 @@ static void if_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized %%(if) argument: %s"), arg);
 }
 
-static void symref_atom_parser(struct used_atom *atom, const char *arg)
-{
-	if (!arg)
-		atom->u.symref = S_FULL;
-	else if (!strcmp(arg, "short"))
-		atom->u.symref = S_SHORT;
-	else
-		die(_("unrecognized %%(symref) argument: %s"), arg);
-}
-
-static void refname_atom_parser(struct used_atom *atom, const char *arg)
-{
-	if (!arg)
-		atom->u.refname.option = R_NORMAL;
-	else if (!strcmp(arg, "short"))
-		atom->u.refname.option = R_SHORT;
-	else if (skip_prefix(arg, "strip=", &arg)) {
-		atom->u.contents.option = R_STRIP;
-		if (strtoul_ui(arg, 10, &atom->u.refname.strip) ||
-			atom->u.refname.strip <= 0)
-			die(_("positive value expected refname:strip=%s"), arg);
-	} else if (!strcmp(arg, "dir"))
-		atom->u.contents.option = R_DIR;
-	else if (!strcmp(arg, "base"))
-		atom->u.contents.option = R_BASE;
-	else
-		die(_("unrecognized %%(refname) argument: %s"), arg);
-}
-
 static struct {
 	const char *name;
 	cmp_type cmp_type;
 	void (*parser)(struct used_atom *atom, const char *arg);
 } valid_atom[] = {
-	{ "refname", FIELD_STR, refname_atom_parser },
+	{ "refname" , FIELD_STR, refname_atom_parser },
 	{ "objecttype" },
 	{ "objectsize", FIELD_ULONG },
 	{ "objectname", FIELD_STR, objectname_atom_parser },
@@ -1098,7 +1103,7 @@ static const char *strip_ref_components(const char *refname, unsigned int len)
 	while (remaining) {
 		switch (*start++) {
 		case '\0':
-			die("ref '%s' does not have %ud components to :strip",
+			die(_("ref '%s' does not have %ud components to :strip"),
 			    refname, len);
 		case '/':
 			remaining--;
@@ -1108,12 +1113,40 @@ static const char *strip_ref_components(const char *refname, unsigned int len)
 	return start;
 }
 
+static const char *show_ref(struct refname_atom *atom, const char *refname)
+{
+	if (atom->option == R_SHORT)
+		return shorten_unambiguous_ref(refname, warn_ambiguous_refs);
+	else if (atom->option == R_STRIP)
+		return strip_ref_components(refname, atom->strip);
+	else if (atom->option == R_BASE) {
+		const char *sp, *ep;
+
pp+		if (skip_prefix(refname, "refs/", &sp)) {
+			ep = strchr(sp, '/');
+			if (!ep)
+				return "";
+			return xstrndup(sp, ep - sp);
+		}
+		return "";
+	} else if (atom->option == R_DIR) {
+		const char *sp, *ep;
+
+		sp = refname;
+		ep = strrchr(sp, '/');
+		if (!ep)
+			return "";
+		return xstrndup(sp, ep - sp);
+	} else
+		return refname;
+}
+
 static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 				    struct branch *branch, const char **s)
 {
 	int num_ours, num_theirs;
-	if (atom->u.remote_ref.option == RR_SHORTEN)
-		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
+	if (atom->u.remote_ref.option == RR_REF)
+		*s = show_ref(&atom->u.remote_ref.refname, refname);
 	else if (atom->u.remote_ref.option == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
 				       &num_theirs, NULL)) {
@@ -1145,8 +1178,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			*s = ">";
 		else
 			*s = "<>";
-	} else /* RR_NORMAL */
-		*s = refname;
+	} else
+		die("BUG: unhandled RR_* enum");
 }
 
 char *get_head_description(void)
@@ -1184,41 +1217,15 @@ static const char *get_symref(struct used_atom *atom, struct ref_array_item *ref
 {
 	if (!ref->symref)
 		return "";
-	else if (atom->u.symref == S_SHORT)
-		return shorten_unambiguous_ref(ref->symref,
-					       warn_ambiguous_refs);
 	else
-		return ref->symref;
+		return show_ref(&atom->u.refname, ref->symref);
 }
 
 static const char *get_refname(struct used_atom *atom, struct ref_array_item *ref)
 {
 	if (ref->kind & FILTER_REFS_DETACHED_HEAD)
 		return get_head_description();
-	if (atom->u.refname.option == R_SHORT)
-		return shorten_unambiguous_ref(ref->refname, warn_ambiguous_refs);
-	else if (atom->u.refname.option == R_STRIP)
-		return strip_ref_components(ref->refname, atom->u.refname.strip);
-	else if (atom->u.refname.option == R_BASE) {
-		const char *sp, *ep;
-
-		if (skip_prefix(ref->refname, "refs/", &sp)) {
-			ep = strchr(sp, '/');
-			if (!ep)
-				return "";
-			return xstrndup(sp, ep - sp);
-		}
-		return "";
-	} else if (atom->u.refname.option == R_DIR) {
-		const char *sp, *ep;
-
-		sp = ref->refname;
-		ep = strrchr(sp, '/');
-		if (!ep)
-			return "";
-		return xstrndup(sp, ep - sp);
-	} else
-		return ref->refname;
+	return show_ref(&atom->u.refname, ref->refname);
 }
 
 /*
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 0bd6368..d8edaf2 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -189,7 +189,7 @@ test_expect_success 'local-branch symrefs shortened properly' '
 	git symbolic-ref refs/heads/ref-to-remote refs/remotes/origin/branch-one &&
 	cat >expect <<-\EOF &&
 	  ref-to-branch -> branch-one
-	  ref-to-remote -> refs/remotes/origin/branch-one
+	  ref-to-remote -> origin/branch-one
 	EOF
 	git branch >actual.raw &&
 	grep ref-to <actual.raw >actual &&
@@ -203,6 +203,8 @@ test_expect_success 'git branch --format option' '
 	Refname is refs/heads/branch-one
 	Refname is refs/heads/branch-two
 	Refname is refs/heads/master
+	Refname is refs/heads/ref-to-branch
+	Refname is refs/heads/ref-to-remote
 	EOF
 	git branch --format="Refname is %(refname)" >actual &&
 	test_cmp expect actual
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 36d32d7..8ff6568 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -57,8 +57,14 @@ test_atom head refname:dir refs/heads
 test_atom head refname:base heads
 test_atom head upstream refs/remotes/origin/master
 test_atom head upstream:short origin/master
+test_atom head upstream:strip=2 origin/master
+test_atom head upstream:dir refs/remotes/origin
+test_atom head upstream:base remotes
 test_atom head push refs/remotes/myfork/master
 test_atom head push:short myfork/master
+test_atom head push:strip=1 remotes/myfork/master
+test_atom head push:dir refs/remotes/myfork
+test_atom head push:base remotes
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
@@ -591,4 +597,31 @@ test_expect_success 'Verify usage of %(symref:short) atom' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+master
+EOF
+
+test_expect_success 'Verify usage of %(symref:strip) atom' '
+	git for-each-ref --format="%(symref:strip=2)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+refs/heads
+EOF
+
+test_expect_success 'Verify usage of %(symref:dir) atom' '
+	git for-each-ref --format="%(symref:dir)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+heads
+EOF
+
+test_expect_success 'Verify usage of %(symref:base) atom' '
+	git for-each-ref --format="%(symref:base)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
 test_done


-- 
2.8.0
