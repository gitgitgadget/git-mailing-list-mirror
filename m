From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bash_completion outside repo
Date: Fri, 11 Sep 2009 14:22:06 -0700
Message-ID: <7vvdjpuqgx.fsf@alter.siamese.dyndns.org>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
 <20090911133313.GF2582@inocybe.localdomain>
 <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
 <20090911141730.GA384@coredump.intra.peff.net>
 <20090911143651.GE1033@spearce.org>
 <20090911150934.GB977@coredump.intra.peff.net>
 <20090911164730.GA21536@coredump.intra.peff.net>
 <7viqfpw6tv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	james bardin <jbardin@bu.edu>, Todd Zullinger <tmz@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 11 23:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmDZm-0000r3-FM
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 23:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418AbZIKVW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 17:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755413AbZIKVW2
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 17:22:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbZIKVW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 17:22:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 708C62F726;
	Fri, 11 Sep 2009 17:22:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7bZNWIBdNUJGKrsu5VjVedfvK5A=; b=Su+DSc
	/6wl4+eqfJVu2A539M+u0xQcTiT0JMbZLBeb5XjxJqEJL6TWv6W52v6I+vXGAkQD
	E05vaPY2I/OwWDT3ShIABecNJXXpjQR96Bsg+xVsDzyWkXlI3+swQeE00M+nn1aw
	ypVBPz9Z5H/knvH/ML/P7J9w1RQXBqD1OxYUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=myRLAT1xwW2+dqVjxI7ZeiShcBdrt6w6
	AOomW+Yz6PssRuE9jOP2trbKN7UVIzh6vDRYSnjJdWhVnjKkdQ3zv8YCO0eDkpzk
	P3F6vREN3g32ztuzjBw+t57NpEkOZZWen9vN+nSVFF+0CjoAKrd7AX7znWT9LQqp
	NJE0KH4cbeo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D69F2F725;
	Fri, 11 Sep 2009 17:22:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7B612F717; Fri, 11 Sep
 2009 17:22:10 -0400 (EDT)
In-Reply-To: <7viqfpw6tv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 11 Sep 2009 13\:43\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 32143924-9F19-11DE-8A0E-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128221>

Junio C Hamano <gitster@pobox.com> writes:

> The last one is not the topic of this patch, but it is quite problematic.
> When you are interested in finding out what value gc.pruneExpire is set,
> you do not care (as long as the configuration file was syntactically
> correct and you did not have to skip any file you were supposed to read
> due to EACCESS) if "branch.autosetupmerge" has an invalid value.
>
> A possible longer term solution would be to:
>
>  - Change the signature of callbacks (e.g. git_default_branch_config()) so
>    that they return void.  They are not allowed to report any semantic
>    errors while parsing.
>
>  - Instead, they use special "INVALID" value and store that when they see
>    a semantically incorrect value.  They may also want to store what the
>    actual string the config file gave them for later reporting, together
>    with the name of and the line number in the config file for diagnostic
>    purposes.
>
>  - The user of the internalized value (i.e. "git grep git_branch_track"
>    shows there are only two, cmd_branch() and cmd_checkout()) must check
>    for the above INVALID value before they use the variable, and die at
>    the point of the use.
>
> I'll send an illustration patch separately.

So here is an illustration to handle _only_ a misspelled
branch.autosetupmerge.

If you have this in your .git/config file:

	[branch]
        	autosetupmerge = nevver

you cannot run "git diff" without this patch.  But with this patch, only
the commands that _care_ about this misconfiguration would notice and
report.

The new world order is:

 - The config parsing callback should detect semantic errors, but should
   not return non-zero, to let the parser continue.

   In the _real_ patch, their signatures should be changed to return void.
   I wanted to illustrate more important points in this patch so I didn't
   do that.

 - Instead, when they detect an error in configured values, they make a
   note that the value is bad (e.g. I introduced BRANCH_TRACK_CONFIG_ERROR
   for this), and also can ask record_bad_config() to record this fact for
   possible later reporting purposes.  You also _could_ issue error() to
   make it easier to detect unrelated but bad configuration for users, but
   that is secondary and I didn't do that in this illustration.

 - Then, when the values are actually _used_, the users should take notice
   of the situation (e.g. both cmd_checkout() and cmd_branch() codepaths
   are modified to do this) and ask die_with_bad_config() to report the
   error the parser detected earlier.

This way, commands that do not use the value of branch.autosetupmerge,
e.g. "git diff", won't have to abort.

 builtin-branch.c   |    5 +++-
 builtin-checkout.c |    5 +++-
 cache.h            |    7 ++++++
 config.c           |   57 ++++++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 9f57992..10010a7 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -635,9 +635,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))
 		rename_branch(argv[0], argv[1], rename > 1);
-	else if (argc <= 2)
+	else if (argc <= 2) {
+		if (track == BRANCH_TRACK_CONFIG_ERROR)
+			die_with_bad_config("branch.autosetupmerge");
 		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
 			      force_create, reflog, track);
+	}
 	else
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/builtin-checkout.c b/builtin-checkout.c
index d050c37..3bf57a5 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -630,8 +630,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		opts.new_branch = argv0 + 1;
 	}
 
-	if (opts.track == BRANCH_TRACK_UNSPECIFIED)
+	if (opts.track == BRANCH_TRACK_UNSPECIFIED) {
+		if (git_branch_track == BRANCH_TRACK_CONFIG_ERROR)
+			die_with_bad_config("branch.autosetupmerge");
 		opts.track = git_branch_track;
+	}
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
diff --git a/cache.h b/cache.h
index 5fad24c..f7ff502 100644
--- a/cache.h
+++ b/cache.h
@@ -533,6 +533,7 @@ enum safe_crlf {
 extern enum safe_crlf safe_crlf;
 
 enum branch_track {
+	BRANCH_TRACK_CONFIG_ERROR = -2,
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
 	BRANCH_TRACK_REMOTE,
@@ -890,6 +891,9 @@ extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigne
 /* Dumb servers support */
 extern int update_server_info(int);
 
+/*
+ * configuration file management
+ */
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
@@ -910,6 +914,9 @@ extern int git_config_global(void);
 extern int config_error_nonbool(const char *);
 extern const char *config_exclusive_filename;
 
+extern void record_bad_config(const char *name, const char *value);
+extern void die_with_bad_config(const char *name);
+
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
 extern char git_default_name[MAX_GITNAME];
diff --git a/config.c b/config.c
index e87edea..5b6a929 100644
--- a/config.c
+++ b/config.c
@@ -306,6 +306,41 @@ static void die_bad_config(const char *name)
 	die("bad config value for '%s'", name);
 }
 
+static struct bad_config_note {
+	struct bad_config_note *next;
+	const char *name;
+	const char *value;
+	int linenr;
+	const char *filename;
+} *bad_config_note;
+
+void record_bad_config(const char *name, const char *value)
+{
+	struct bad_config_note *note = xcalloc(1, sizeof(*note));
+	note->next = bad_config_note;
+	bad_config_note = note;
+	note->name = xstrdup(name);
+	note->value = xstrdup(value);
+	note->linenr = config_linenr;
+	note->filename = config_file_name ? xstrdup(config_file_name) : NULL;
+}
+
+void die_with_bad_config(const char *name)
+{
+	struct bad_config_note *note;
+	for (note = bad_config_note; note; note = note->next)
+		if (!strcmp(name, note->name)) {
+			char whence[PATH_MAX + 200];
+			if (note->filename)
+				sprintf(whence, " in %s", note->filename);
+			else
+				whence[0] = '\0';
+			die("bad config value '%s' for '%s'%s, line %d",
+			    note->value, note->name, whence, note->linenr);
+		}
+	die("program error: bad config value for %s not recorded", name);
+}
+
 int git_config_int(const char *name, const char *value)
 {
 	long ret = 0;
@@ -324,6 +359,8 @@ unsigned long git_config_ulong(const char *name, const char *value)
 
 int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
+	long ret;
+
 	*is_bool = 1;
 	if (!value)
 		return 1;
@@ -333,14 +370,24 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 		return 1;
 	if (!strcasecmp(value, "false") || !strcasecmp(value, "no") || !strcasecmp(value, "off"))
 		return 0;
+
 	*is_bool = 0;
-	return git_config_int(name, value);
+
+	ret = 0;
+	if (!git_parse_long(value, &ret)) {
+		record_bad_config(name, value);
+		*is_bool = -1;
+	}
+	return ret;
 }
 
 int git_config_bool(const char *name, const char *value)
 {
-	int discard;
-	return !!git_config_bool_or_int(name, value, &discard);
+	int is_bool, val;
+	val = git_config_bool_or_int(name, value, &is_bool);
+	if (is_bool < 0)
+		return is_bool;
+	return !!val;
 }
 
 int git_config_string(const char **dest, const char *var, const char *value)
@@ -546,11 +593,13 @@ static int git_default_i18n_config(const char *var, const char *value)
 static int git_default_branch_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "branch.autosetupmerge")) {
+		int val;
 		if (value && !strcasecmp(value, "always")) {
 			git_branch_track = BRANCH_TRACK_ALWAYS;
 			return 0;
 		}
-		git_branch_track = git_config_bool(var, value);
+		val = git_config_bool(var, value);
+		git_branch_track = (val < 0) ? BRANCH_TRACK_CONFIG_ERROR : val;
 		return 0;
 	}
 	if (!strcmp(var, "branch.autosetuprebase")) {
