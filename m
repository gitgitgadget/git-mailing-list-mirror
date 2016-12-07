Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C39920259
	for <e@80x24.org>; Wed,  7 Dec 2016 15:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbcLGPhB (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:37:01 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34821 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753107AbcLGPgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:51 -0500
Received: by mail-pg0-f67.google.com with SMTP id p66so23822295pga.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3ilEMOa5CYziINWJpBfi3YmX+uPqlSNWMNM8cF6DU7Y=;
        b=UpDe57BsQcX/fQ195PSImTr4kZo8ktzbdfIW6e7x2J4N8EdwSqph/uBUS07rNayDZK
         ScrgkqZTTEcYDhaGls0Nwg3BvUfIu7/ztugMaT2lTwtmGczLtWiYEgWrzjPId54KzumN
         USCAhwk25YVU0N0nBWMLh5a5D3+UXn9Su9ADoWoxbeB55IgTizqPlAa+lvoltZbT4yTN
         QJFkZhSb8yUtwK1Bq4K6hGT518r5pvDqZFaIoEWLaO4fPd2GdU8ewPH1Wj9Rj5wfwhoD
         x/51PxWDJV692JSzQDp3xDbD973rcj65ev2C6fMKFVx4QXvnZzySm4cFBg2Ruw+S12Tr
         9Kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3ilEMOa5CYziINWJpBfi3YmX+uPqlSNWMNM8cF6DU7Y=;
        b=A5zUj7vXlmjAahBVl6aXp9ulNajtbz0Bzbpzm8VItlPkz2WZU7zhlGlq1v4tj6N4oY
         OiWzyqRi3UyTph+Lc6noAN1wdjfoGocXBe5l2dIAbyCTYCOCuUFrNjLiDNCDna/JYEDh
         thQuXCWU7XLNlIcVfY5cGa1gjj2EFJY6ZviNiK3CMon4BrXKD9iaesdboAlYLBKNLjQl
         JgqG7Wl0+3u0VF/UWDElFu+R4gzpaz1q8VqdIkhmS2qIk6d5i2U429yYx9ToZ9IKD81l
         gZa0fDe0k3Nkq5i3sB68QB8MRsTvDyku7ezvKS0vSgpuhg5dmjtJuC0CQBl5LyguR/4b
         12Qw==
X-Gm-Message-State: AKaTC008hAODpyI94sT8dTbBBPmEW5CXFqamiM2/28tml6Cu3VtvwJ+ryNF3hG6sZzvfEA==
X-Received: by 10.98.29.205 with SMTP id d196mr69377967pfd.111.1481124998342;
        Wed, 07 Dec 2016 07:36:38 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:37 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v8 11/19] ref-filter: introduce refname_atom_parser()
Date:   Wed,  7 Dec 2016 21:06:19 +0530
Message-Id: <20161207153627.1468-12-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
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
index e1d250e..8224f37 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -167,6 +167,11 @@ if::
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
index 1a18c7d..9f5522d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -177,6 +177,11 @@ static void objectname_atom_parser(struct used_atom *atom, const char *arg)
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
@@ -247,7 +252,7 @@ static struct {
 	cmp_type cmp_type;
 	void (*parser)(struct used_atom *atom, const char *arg);
 } valid_atom[] = {
-	{ "refname" },
+	{ "refname" , FIELD_STR, refname_atom_parser },
 	{ "objecttype" },
 	{ "objectsize", FIELD_ULONG },
 	{ "objectname", FIELD_STR, objectname_atom_parser },
@@ -276,7 +281,7 @@ static struct {
 	{ "contents", FIELD_STR, contents_atom_parser },
 	{ "upstream", FIELD_STR, remote_ref_atom_parser },
 	{ "push", FIELD_STR, remote_ref_atom_parser },
-	{ "symref" },
+	{ "symref", FIELD_STR, refname_atom_parser },
 	{ "flag" },
 	{ "HEAD" },
 	{ "color", FIELD_STR, color_atom_parser },
@@ -1062,21 +1067,16 @@ static inline char *copy_advance(char *dst, const char *src)
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
@@ -1085,6 +1085,16 @@ static const char *strip_ref_components(const char *refname, const char *nr_arg)
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
@@ -1157,6 +1167,21 @@ char *get_head_description(void)
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
@@ -1185,7 +1210,6 @@ static void populate_value(struct ref_array_item *ref)
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
 		const char *refname;
-		const char *formatp;
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
@@ -1196,12 +1220,10 @@ static void populate_value(struct ref_array_item *ref)
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
@@ -1277,21 +1299,6 @@ static void populate_value(struct ref_array_item *ref)
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
index 1935583..b32ab79 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -599,4 +599,13 @@ test_expect_success 'Verify usage of %(symref:short) atom' '
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

