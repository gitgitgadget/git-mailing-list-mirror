Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4651D200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755581AbcL0QXv (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:51 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34369 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755411AbcL0QXk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:40 -0500
Received: by mail-pg0-f65.google.com with SMTP id b1so12844285pgc.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ErVcf/l65nr/hLCzzL2eoksvt2rmLrpZy5No+iCIo38=;
        b=RMVLBOl8coPr6r8Ad0Z67IV+G0zAhTyREF5A9l4faBP1CXgykW3RAXyfTPCRTZrKL6
         l+gAzLKk0tDe/VnghVZsB4eHucVjafzDnuH1R/tMs/AaEVhp82CdCqRSv991SYyamJ4W
         SyKR2u24bfyRcwqzBpwguMZV5cuk9Nyj0F+nHlB+EvMRR+pwi8m77gKXlcu9fyhBohe2
         nTQC61NuiSq7GrHPN+ux0/Gxp5McDgC6D7j6asu6dGgHS66VqfnbxEINkuRIwLFwpPq5
         zOReuyOyvee0nhhYZWFLT4JwQe5oRNdBwNBr62Lk00G9pM9WibsOjXhEWg6aQoCZBO6f
         L2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ErVcf/l65nr/hLCzzL2eoksvt2rmLrpZy5No+iCIo38=;
        b=EZf7B5AZfq8YMN0bYYrxu5VGb4ytJFwZ1DB5p9zbVLbQ+u3lQ1ppX2KfwNuAwANpEv
         2nf8zPUCpq92SMw2ixH4gPn0M9ksLXT1xXR3MpTN+5Zk4PN7wJNNw7yN1lkqGMHsQEcj
         KnSEZ0KpDaOfUkkC15BvHce6g8q0xPqK+P/3jpvH9UvV7jwyixdqSbzPYNDU1K85I3lC
         3Tk9d2jyARxPM2s/Y/mjaJeSUwCA91PhTnizUU6vDuub+GClvY/R9bzJLBLv8AYK41pR
         ScELnf0Qiq37K/PiO0MYgXJa/i2MCr77XoQSwndAyqq6c7ajMGOoO12HYoe8CohnOc7o
         i85Q==
X-Gm-Message-State: AIkVDXLG7EBJdfQ7Uo7LAL4EGnifxFZj3zOxvh8uw33aXOdiEK4h51QMfmSDW0vcge9FdA==
X-Received: by 10.99.126.6 with SMTP id z6mr59525539pgc.182.1482855820032;
        Tue, 27 Dec 2016 08:23:40 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:39 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v9 11/20] ref-filter: introduce refname_atom_parser()
Date:   Tue, 27 Dec 2016 21:53:48 +0530
Message-Id: <20161227162357.28212-12-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Using refname_atom_parser_internal(), introduce refname_atom_parser()
which will parse the %(symref) and %(refname) atoms. Store the parsed
information into the 'used_atom' structure based on the modifiers used
along with the atoms.

Now the '%(symref)' atom supports the ':strip' atom modifier. Update the
Documentation and tests to reflect this.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  5 +++
 ref-filter.c                       | 73 +++++++++++++++++++++-----------------
 t/t6300-for-each-ref.sh            |  9 +++++
 3 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index b17273e..0fa5818 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -170,6 +170,11 @@ if::
 	the value between the %(if:...) and %(then) atoms with the
 	given string.
 
+symref::
+	The ref which the given symbolic ref refers to. If not a
+	symbolic ref, nothing is printed. Respects the `:short` and
+	`:strip` options in the same way as `refname` above.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index c1ebc40..7bfd656 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -187,6 +187,11 @@ static void objectname_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized %%(objectname) argument: %s"), arg);
 }
 
+static void refname_atom_parser(struct used_atom *atom, const char *arg)
+{
+	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
+}
+
 static align_type parse_align_position(const char *s)
 {
 	if (!strcmp(s, "right"))
@@ -257,7 +262,7 @@ static struct {
 	cmp_type cmp_type;
 	void (*parser)(struct used_atom *atom, const char *arg);
 } valid_atom[] = {
-	{ "refname" },
+	{ "refname" , FIELD_STR, refname_atom_parser },
 	{ "objecttype" },
 	{ "objectsize", FIELD_ULONG },
 	{ "objectname", FIELD_STR, objectname_atom_parser },
@@ -287,7 +292,7 @@ static struct {
 	{ "contents", FIELD_STR, contents_atom_parser },
 	{ "upstream", FIELD_STR, remote_ref_atom_parser },
 	{ "push", FIELD_STR, remote_ref_atom_parser },
-	{ "symref" },
+	{ "symref", FIELD_STR, refname_atom_parser },
 	{ "flag" },
 	{ "HEAD" },
 	{ "color", FIELD_STR, color_atom_parser },
@@ -1082,21 +1087,16 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
-static const char *strip_ref_components(const char *refname, const char *nr_arg)
+static const char *strip_ref_components(const char *refname, unsigned int len)
 {
-	char *end;
-	long nr = strtol(nr_arg, &end, 10);
-	long remaining = nr;
+	long remaining = len;
 	const char *start = refname;
 
-	if (nr < 1 || *end != '\0')
-		die(_(":strip= requires a positive integer argument"));
-
 	while (remaining) {
 		switch (*start++) {
 		case '\0':
-			die(_("ref '%s' does not have %ld components to :strip"),
-			    refname, nr);
+			die(_("ref '%s' does not have %ud components to :strip"),
+			    refname, len);
 		case '/':
 			remaining--;
 			break;
@@ -1105,6 +1105,16 @@ static const char *strip_ref_components(const char *refname, const char *nr_arg)
 	return start;
 }
 
+static const char *show_ref(struct refname_atom *atom, const char *refname)
+{
+	if (atom->option == R_SHORT)
+		return shorten_unambiguous_ref(refname, warn_ambiguous_refs);
+	else if (atom->option == R_STRIP)
+		return strip_ref_components(refname, atom->strip);
+	else
+		return refname;
+}
+
 static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 				    struct branch *branch, const char **s)
 {
@@ -1177,6 +1187,21 @@ char *get_head_description(void)
 	return strbuf_detach(&desc, NULL);
 }
 
+static const char *get_symref(struct used_atom *atom, struct ref_array_item *ref)
+{
+	if (!ref->symref)
+		return "";
+	else
+		return show_ref(&atom->u.refname, ref->symref);
+}
+
+static const char *get_refname(struct used_atom *atom, struct ref_array_item *ref)
+{
+	if (ref->kind & FILTER_REFS_DETACHED_HEAD)
+		return get_head_description();
+	return show_ref(&atom->u.refname, ref->refname);
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -1205,7 +1230,6 @@ static void populate_value(struct ref_array_item *ref)
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
 		const char *refname;
-		const char *formatp;
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
@@ -1216,12 +1240,10 @@ static void populate_value(struct ref_array_item *ref)
 			name++;
 		}
 
-		if (starts_with(name, "refname")) {
-			refname = ref->refname;
-			if (ref->kind & FILTER_REFS_DETACHED_HEAD)
-				refname = get_head_description();
-		} else if (starts_with(name, "symref"))
-			refname = ref->symref ? ref->symref : "";
+		if (starts_with(name, "refname"))
+			refname = get_refname(atom, ref);
+		else if (starts_with(name, "symref"))
+			refname = get_symref(atom, ref);
 		else if (starts_with(name, "upstream")) {
 			const char *branch_name;
 			/* only local branches may have an upstream */
@@ -1297,21 +1319,6 @@ static void populate_value(struct ref_array_item *ref)
 		} else
 			continue;
 
-		formatp = strchr(name, ':');
-		if (formatp) {
-			const char *arg;
-
-			formatp++;
-			if (!strcmp(formatp, "short"))
-				refname = shorten_unambiguous_ref(refname,
-						      warn_ambiguous_refs);
-			else if (skip_prefix(formatp, "strip=", &arg))
-				refname = strip_ref_components(refname, arg);
-			else
-				die(_("unknown %.*s format %s"),
-				    (int)(formatp - name), name, formatp);
-		}
-
 		if (!deref)
 			v->s = refname;
 		else
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7663a36..18a9e25 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -624,4 +624,13 @@ test_expect_success 'Verify usage of %(symref:short) atom' '
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
 test_done
-- 
2.10.2

