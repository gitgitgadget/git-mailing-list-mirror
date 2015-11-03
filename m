From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 08/25] refs: move dwim and friend functions to the common refs code
Date: Tue,  3 Nov 2015 08:39:52 +0100
Message-ID: <51d5134027518b62c3bdf82fe1ee2dce9708f62b.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:48:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWKD-0005ql-KX
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbbKCHsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:48:10 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44588 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751920AbbKCHsH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:48:07 -0500
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2015 02:48:07 EST
X-AuditID: 12074414-f794f6d000007852-97-563864e9b8aa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C8.2D.30802.9E468365; Tue,  3 Nov 2015 02:40:25 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDd5016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:24 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqPsyxSLMYM9+WYv5m04wWnRd6Way
	aOi9wmxxe8V8Zot/E2ocWD3+vv/A5LFgU6nHxUvKHgue32f3+LxJLoA1itsmKbGkLDgzPU/f
	LoE7o7H5HmtBX1zFg3ldbA2M9zy6GDk4JARMJBbstuti5AQyxSQu3FvP1sXIxSEkcJlR4vzm
	ySwQzjEmiRNbjjKBVLEJ6Eos6mkGs0UE1CQmth0CK2IWWMQo0fpmOhPIVGGBMIlHk1VAalgE
	VCU+7p8HVs8rECUx/dpvdohtchJT7reDxTkFLCQe3P0DFhcSMJfYdG8Z2wRG3gWMDKsY5RJz
	SnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJTSjcxQsJJZAfjkZNyhxgFOBiVeHgXLDEPE2JN
	LCuuzD3EKMnBpCTKuy7GIkyILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG9BIFCONyWxsiq1KB8m
	Jc3BoiTO+22xup+QQHpiSWp2ampBahFMVoaDQ0mC91IyUKNgUWp6akVaZk4JQpqJgxNkOJeU
	SHFqXkpqUWJpSUY8KDLii4GxAZLiAdqbkAKyt7ggMRcoCtF6ilFRSpz3IshcAZBERmke3FhY
	knjFKA70pTDvRJAqHmCCget+BTSYCWhw+DZTkMEliQgpqQZG9/lPJ0utvx2qVai5epJ4cE+Z
	zP2gH2tCHubdV19YF/3zhOM7MavJwflL1t08PEM7fs40tsQg/oWN20NuGT7vmDQvdb+5qrOS
	w57f92qNS9JcVz28KrAiYqW2WcnXHcZTira4TCh7sjvEdl6wP5/ctrT5fLkaFy6W 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280773>

From: Ronnie Sahlberg <sahlberg@google.com>

These functions do not contain any backend specific code so move them
to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 203 ---------------------------------------------------
 refs/refs.c          | 203 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 203 insertions(+), 203 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8f1e486..8809595 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2259,30 +2259,6 @@ const char *prettify_refname(const char *name)
 		0);
 }
 
-static const char *ref_rev_parse_rules[] = {
-	"%.*s",
-	"refs/%.*s",
-	"refs/tags/%.*s",
-	"refs/heads/%.*s",
-	"refs/remotes/%.*s",
-	"refs/remotes/%.*s/HEAD",
-	NULL
-};
-
-int refname_match(const char *abbrev_name, const char *full_name)
-{
-	const char **p;
-	const int abbrev_name_len = strlen(abbrev_name);
-
-	for (p = ref_rev_parse_rules; *p; p++) {
-		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
 static void unlock_ref(struct ref_lock *lock)
 {
 	/* Do not free lock->lk -- atexit() still looks at them */
@@ -2335,92 +2311,6 @@ static int remove_empty_directories(struct strbuf *path)
 }
 
 /*
- * *string and *len will only be substituted, and *string returned (for
- * later free()ing) if the string passed in is a magic short-hand form
- * to name a branch.
- */
-static char *substitute_branch_name(const char **string, int *len)
-{
-	struct strbuf buf = STRBUF_INIT;
-	int ret = interpret_branch_name(*string, *len, &buf);
-
-	if (ret == *len) {
-		size_t size;
-		*string = strbuf_detach(&buf, &size);
-		*len = size;
-		return (char *)*string;
-	}
-
-	return NULL;
-}
-
-int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
-{
-	char *last_branch = substitute_branch_name(&str, &len);
-	const char **p, *r;
-	int refs_found = 0;
-
-	*ref = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
-		char fullref[PATH_MAX];
-		unsigned char sha1_from_ref[20];
-		unsigned char *this_result;
-		int flag;
-
-		this_result = refs_found ? sha1_from_ref : sha1;
-		mksnpath(fullref, sizeof(fullref), *p, len, str);
-		r = resolve_ref_unsafe(fullref, RESOLVE_REF_READING,
-				       this_result, &flag);
-		if (r) {
-			if (!refs_found++)
-				*ref = xstrdup(r);
-			if (!warn_ambiguous_refs)
-				break;
-		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD")) {
-			warning("ignoring dangling symref %s.", fullref);
-		} else if ((flag & REF_ISBROKEN) && strchr(fullref, '/')) {
-			warning("ignoring broken ref %s.", fullref);
-		}
-	}
-	free(last_branch);
-	return refs_found;
-}
-
-int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
-{
-	char *last_branch = substitute_branch_name(&str, &len);
-	const char **p;
-	int logs_found = 0;
-
-	*log = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
-		unsigned char hash[20];
-		char path[PATH_MAX];
-		const char *ref, *it;
-
-		mksnpath(path, sizeof(path), *p, len, str);
-		ref = resolve_ref_unsafe(path, RESOLVE_REF_READING,
-					 hash, NULL);
-		if (!ref)
-			continue;
-		if (reflog_exists(path))
-			it = path;
-		else if (strcmp(ref, path) && reflog_exists(ref))
-			it = ref;
-		else
-			continue;
-		if (!logs_found++) {
-			*log = xstrdup(it);
-			hashcpy(sha1, hash);
-		}
-		if (!warn_ambiguous_refs)
-			break;
-	}
-	free(last_branch);
-	return logs_found;
-}
-
-/*
  * Locks a ref returning the lock on success and NULL on failure.
  * On failure errno is set to something meaningful.
  */
@@ -4126,99 +4016,6 @@ cleanup:
 	return ret;
 }
 
-char *shorten_unambiguous_ref(const char *refname, int strict)
-{
-	int i;
-	static char **scanf_fmts;
-	static int nr_rules;
-	char *short_name;
-
-	if (!nr_rules) {
-		/*
-		 * Pre-generate scanf formats from ref_rev_parse_rules[].
-		 * Generate a format suitable for scanf from a
-		 * ref_rev_parse_rules rule by interpolating "%s" at the
-		 * location of the "%.*s".
-		 */
-		size_t total_len = 0;
-		size_t offset = 0;
-
-		/* the rule list is NULL terminated, count them first */
-		for (nr_rules = 0; ref_rev_parse_rules[nr_rules]; nr_rules++)
-			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
-			total_len += strlen(ref_rev_parse_rules[nr_rules]) - 2 + 1;
-
-		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
-
-		offset = 0;
-		for (i = 0; i < nr_rules; i++) {
-			assert(offset < total_len);
-			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules] + offset;
-			offset += snprintf(scanf_fmts[i], total_len - offset,
-					   ref_rev_parse_rules[i], 2, "%s") + 1;
-		}
-	}
-
-	/* bail out if there are no rules */
-	if (!nr_rules)
-		return xstrdup(refname);
-
-	/* buffer for scanf result, at most refname must fit */
-	short_name = xstrdup(refname);
-
-	/* skip first rule, it will always match */
-	for (i = nr_rules - 1; i > 0 ; --i) {
-		int j;
-		int rules_to_fail = i;
-		int short_name_len;
-
-		if (1 != sscanf(refname, scanf_fmts[i], short_name))
-			continue;
-
-		short_name_len = strlen(short_name);
-
-		/*
-		 * in strict mode, all (except the matched one) rules
-		 * must fail to resolve to a valid non-ambiguous ref
-		 */
-		if (strict)
-			rules_to_fail = nr_rules;
-
-		/*
-		 * check if the short name resolves to a valid ref,
-		 * but use only rules prior to the matched one
-		 */
-		for (j = 0; j < rules_to_fail; j++) {
-			const char *rule = ref_rev_parse_rules[j];
-			char refname[PATH_MAX];
-
-			/* skip matched rule */
-			if (i == j)
-				continue;
-
-			/*
-			 * the short name is ambiguous, if it resolves
-			 * (with this previous rule) to a valid ref
-			 * read_ref() returns 0 on success
-			 */
-			mksnpath(refname, sizeof(refname),
-				 rule, short_name_len, short_name);
-			if (ref_exists(refname))
-				break;
-		}
-
-		/*
-		 * short name is non-ambiguous if all previous rules
-		 * haven't resolved to a valid ref
-		 */
-		if (j == rules_to_fail)
-			return short_name;
-	}
-
-	free(short_name);
-	return xstrdup(refname);
-}
-
 struct expire_reflog_cb {
 	unsigned int flags;
 	reflog_expiry_should_prune_fn *should_prune_fn;
diff --git a/refs/refs.c b/refs/refs.c
index 0620ba3..40d7831 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -342,3 +342,206 @@ int ref_is_hidden(const char *refname)
 	}
 	return 0;
 }
+
+static const char *ref_rev_parse_rules[] = {
+	"%.*s",
+	"refs/%.*s",
+	"refs/tags/%.*s",
+	"refs/heads/%.*s",
+	"refs/remotes/%.*s",
+	"refs/remotes/%.*s/HEAD",
+	NULL
+};
+
+int refname_match(const char *abbrev_name, const char *full_name)
+{
+	const char **p;
+	const int abbrev_name_len = strlen(abbrev_name);
+
+	for (p = ref_rev_parse_rules; *p; p++) {
+		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * *string and *len will only be substituted, and *string returned (for
+ * later free()ing) if the string passed in is a magic short-hand form
+ * to name a branch.
+ */
+static char *substitute_branch_name(const char **string, int *len)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret = interpret_branch_name(*string, *len, &buf);
+
+	if (ret == *len) {
+		size_t size;
+		*string = strbuf_detach(&buf, &size);
+		*len = size;
+		return (char *)*string;
+	}
+
+	return NULL;
+}
+
+int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
+{
+	char *last_branch = substitute_branch_name(&str, &len);
+	const char **p, *r;
+	int refs_found = 0;
+
+	*ref = NULL;
+	for (p = ref_rev_parse_rules; *p; p++) {
+		char fullref[PATH_MAX];
+		unsigned char sha1_from_ref[20];
+		unsigned char *this_result;
+		int flag;
+
+		this_result = refs_found ? sha1_from_ref : sha1;
+		mksnpath(fullref, sizeof(fullref), *p, len, str);
+		r = resolve_ref_unsafe(fullref, RESOLVE_REF_READING,
+				       this_result, &flag);
+		if (r) {
+			if (!refs_found++)
+				*ref = xstrdup(r);
+			if (!warn_ambiguous_refs)
+				break;
+		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD")) {
+			warning("ignoring dangling symref %s.", fullref);
+		} else if ((flag & REF_ISBROKEN) && strchr(fullref, '/')) {
+			warning("ignoring broken ref %s.", fullref);
+		}
+	}
+	free(last_branch);
+	return refs_found;
+}
+
+int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
+{
+	char *last_branch = substitute_branch_name(&str, &len);
+	const char **p;
+	int logs_found = 0;
+
+	*log = NULL;
+	for (p = ref_rev_parse_rules; *p; p++) {
+		unsigned char hash[20];
+		char path[PATH_MAX];
+		const char *ref, *it;
+
+		mksnpath(path, sizeof(path), *p, len, str);
+		ref = resolve_ref_unsafe(path, RESOLVE_REF_READING,
+					 hash, NULL);
+		if (!ref)
+			continue;
+		if (reflog_exists(path))
+			it = path;
+		else if (strcmp(ref, path) && reflog_exists(ref))
+			it = ref;
+		else
+			continue;
+		if (!logs_found++) {
+			*log = xstrdup(it);
+			hashcpy(sha1, hash);
+		}
+		if (!warn_ambiguous_refs)
+			break;
+	}
+	free(last_branch);
+	return logs_found;
+}
+
+char *shorten_unambiguous_ref(const char *refname, int strict)
+{
+	int i;
+	static char **scanf_fmts;
+	static int nr_rules;
+	char *short_name;
+
+	if (!nr_rules) {
+		/*
+		 * Pre-generate scanf formats from ref_rev_parse_rules[].
+		 * Generate a format suitable for scanf from a
+		 * ref_rev_parse_rules rule by interpolating "%s" at the
+		 * location of the "%.*s".
+		 */
+		size_t total_len = 0;
+		size_t offset = 0;
+
+		/* the rule list is NULL terminated, count them first */
+		for (nr_rules = 0; ref_rev_parse_rules[nr_rules]; nr_rules++)
+			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
+			total_len += strlen(ref_rev_parse_rules[nr_rules]) - 2 + 1;
+
+		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
+
+		offset = 0;
+		for (i = 0; i < nr_rules; i++) {
+			assert(offset < total_len);
+			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules] + offset;
+			offset += snprintf(scanf_fmts[i], total_len - offset,
+					   ref_rev_parse_rules[i], 2, "%s") + 1;
+		}
+	}
+
+	/* bail out if there are no rules */
+	if (!nr_rules)
+		return xstrdup(refname);
+
+	/* buffer for scanf result, at most refname must fit */
+	short_name = xstrdup(refname);
+
+	/* skip first rule, it will always match */
+	for (i = nr_rules - 1; i > 0 ; --i) {
+		int j;
+		int rules_to_fail = i;
+		int short_name_len;
+
+		if (1 != sscanf(refname, scanf_fmts[i], short_name))
+			continue;
+
+		short_name_len = strlen(short_name);
+
+		/*
+		 * in strict mode, all (except the matched one) rules
+		 * must fail to resolve to a valid non-ambiguous ref
+		 */
+		if (strict)
+			rules_to_fail = nr_rules;
+
+		/*
+		 * check if the short name resolves to a valid ref,
+		 * but use only rules prior to the matched one
+		 */
+		for (j = 0; j < rules_to_fail; j++) {
+			const char *rule = ref_rev_parse_rules[j];
+			char refname[PATH_MAX];
+
+			/* skip matched rule */
+			if (i == j)
+				continue;
+
+			/*
+			 * the short name is ambiguous, if it resolves
+			 * (with this previous rule) to a valid ref
+			 * read_ref() returns 0 on success
+			 */
+			mksnpath(refname, sizeof(refname),
+				 rule, short_name_len, short_name);
+			if (ref_exists(refname))
+				break;
+		}
+
+		/*
+		 * short name is non-ambiguous if all previous rules
+		 * haven't resolved to a valid ref
+		 */
+		if (j == rules_to_fail)
+			return short_name;
+	}
+
+	free(short_name);
+	return xstrdup(refname);
+}
-- 
2.6.2
