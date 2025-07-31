Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA551D86C6
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973832; cv=none; b=lSzQOvRonVu85S4oZBQwpbi+j1sitbWDpmfZVt8cl4sPZPllzRzPYVjLgyuJvrKhvGuAIBND69RnTMVS/mJTsMKuCZcYuwXguEZx3PTarHQ4hhieeDx2VucZ1UbqU3JwB02AKhaRCT51kaByid6BMi/Vmutl0twv4PeD1cIcRu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973832; c=relaxed/simple;
	bh=JcAVuhw6FCtplsaL9vQBr37EiqMdNsDQxX8IWUMBmw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sO6CoJ2LgjqurdAjrlpuSY89Ro8L6bs1UD0965VALqJX5HjqNIcjZ8iLEoIThNfhT8m8RQBhzikUZC4YXi5qFkm8hkRDX94JnLfUm+PBh0CExgh0o2OPEAk5nUoC3SPYrciSzAlFtcjjpVeEkdahRr+5Oou/Xdd3+nRLk5D2Ido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q1IC9kXE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Avklg7OZ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q1IC9kXE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Avklg7OZ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 80DFB14002E4;
	Thu, 31 Jul 2025 10:57:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 31 Jul 2025 10:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753973829;
	 x=1754060229; bh=TRSFv0aSPXtF9n+fVJ9dzVXC2lLJVysb7Z8jT/3bLnE=; b=
	Q1IC9kXEbbdvW3SNaZQ/k4tLcrS3A8fNkC8rchfFAaWs3Qyvf92UDKmCJ8qMuVLe
	xlguFiBb6dREbS8/Z6N99hCOP7YtRsPxoD+Tx46v7fJB/UrNPLJdmVF+a08QUrCP
	pgxusDG/EJRaNZ9oR19QkMUHevy+lQeBXsRX1yEsWHIzzxwsWDk1dzfXvsn66NVC
	r9GOzoEZKt/K22hS5gY7ISv771WviioJ4eTaE8GEumB9PYSpJvB7TE9aC03+dOq4
	kMV0IMjqMRzHk6w+SNUF1W7y9ZkyAKkrprghl7hIsPOGtVThRVQEfMjkm+jpAp+P
	6GMLX4kjSaG8Wm4+PtPLxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753973829; x=
	1754060229; bh=TRSFv0aSPXtF9n+fVJ9dzVXC2lLJVysb7Z8jT/3bLnE=; b=A
	vklg7OZ5+UGF9R+UVP/pMaexRvDA1Tt6i+DrLKUxBmP1qwpqTPGIskm3/G5Ud/UL
	+70vgeo4S4KNsa44mo9I7Xq9KoY/9JS2YiCi/ekGzj/6tdzD/oNgkssZF1clazb4
	sWnAOE+Gyhs693bwkJaD3omaEn5+RBKNyQO/PJJfrleUkzksKsuf6AZ2XEqaxYTT
	5m40NYQFns9jEICfMgXLbYr3c/AbJSeQgDSq0ESnhN3Vipp2GR8ZPo9VkgZmX+MP
	dIfdGJkwNOJRuE/PwNcFgjPM535R2DCJyYZ8znEjOeGKcabmU5NjnJJxYOn1/x6u
	lv6T+ZVA+7edtMGH1R4SA==
X-ME-Sender: <xms:RYSLaEoyntI_AuFDkUZVaInQhhn43Kn0yhcFmlJ9JhxpPvKHflrrLg>
    <xme:RYSLaDFAhZ8lF3nxQ2QnG2CdPz_QGMD6NOe0M-BumUZ-t0PbyagNPmJ_tkMe_qDcF
    ZMftko0siiZyeCNyQ>
X-ME-Received: <xmr:RYSLaJrKgTIxTEp9BNdJm7znt_3myV54jJVKb_YM0NNRzB4i8CsxUrn510XrUKTKfiDHmxpQveu31PzGMnNt5jusM3_XX66iu345RYO0Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetjeeklefhvdehkefgveetveevvdehhedvueegkeeiudekuefgffettdevfeegieen
    ucffohhmrghinhephhgvrggushdrnhhrnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:RYSLaMZut9VrcyC02bT9tZqMoxPsqkb0ZLwVaHhfAHF9wl5W5exBOg>
    <xmx:RYSLaCUtWC6hgEG62XzaSNX-0iQgyFsDFy2eoGIYzV3XFeZ-JTSgqw>
    <xmx:RYSLaF_tPrbt6-WIy_HBnJN3IBblRDjS58InMVdP_Vdzr2iP1Cr1bA>
    <xmx:RYSLaL9vcFZffdPea6wz4EFuPB4vSHh-Z7PsFkbGpg1NuoaDPe354g>
    <xmx:RYSLaFEY-Ziwj5z1_EZXobzF7cU51Y0C1-gtr_-DBBSpUMFOn6LIWJ9K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 10:57:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5c7b159c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 31 Jul 2025 14:57:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 31 Jul 2025 16:56:51 +0200
Subject: [PATCH v2 3/6] builtin/remote: fix sign comparison warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-pks-remote-rename-improvements-v2-3-dda6f083674d@pks.im>
References: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
In-Reply-To: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Han Jiang <jhcarl0814@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Fix -Wsign-comparison warnings. All of the warnings we have are about
mismatches in signedness for loop counters. These are trivially fixable
by using the correct integer type.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c | 54 +++++++++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 5dd6cbbaee..f63c5eb888 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
@@ -182,7 +181,6 @@ static int add(int argc, const char **argv, const char *prefix,
 	struct remote *remote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
 	const char *name, *url;
-	int i;
 	int result = 0;
 
 	struct option options[] = {
@@ -233,7 +231,7 @@ static int add(int argc, const char **argv, const char *prefix,
 		strbuf_addf(&buf, "remote.%s.fetch", name);
 		if (track.nr == 0)
 			string_list_append(&track, "*");
-		for (i = 0; i < track.nr; i++) {
+		for (size_t i = 0; i < track.nr; i++) {
 			add_branch(buf.buf, track.items[i].string,
 				   name, mirror, &buf2);
 		}
@@ -647,18 +645,17 @@ static int read_remote_branches(const char *refname, const char *referent UNUSED
 static int migrate_file(struct remote *remote)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int i;
 
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
-	for (i = 0; i < remote->url.nr; i++)
+	for (size_t i = 0; i < remote->url.nr; i++)
 		git_config_set_multivar(buf.buf, remote->url.v[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
-	for (i = 0; i < remote->push.nr; i++)
+	for (int i = 0; i < remote->push.nr; i++)
 		git_config_set_multivar(buf.buf, remote->push.items[i].raw, "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
-	for (i = 0; i < remote->fetch.nr; i++)
+	for (int i = 0; i < remote->fetch.nr; i++)
 		git_config_set_multivar(buf.buf, remote->fetch.items[i].raw, "^$", 0);
 #ifndef WITH_BREAKING_CHANGES
 	if (remote->origin == REMOTE_REMOTES)
@@ -744,7 +741,7 @@ static int mv(int argc, const char **argv, const char *prefix,
 		old_remote_context = STRBUF_INIT;
 	struct string_list remote_branches = STRING_LIST_INIT_DUP;
 	struct rename_info rename;
-	int i, refs_renamed_nr = 0, refspec_updated = 0;
+	int refs_renamed_nr = 0, refspec_updated = 0;
 	struct progress *progress = NULL;
 	int result = 0;
 
@@ -790,7 +787,7 @@ static int mv(int argc, const char **argv, const char *prefix,
 		strbuf_addf(&buf, "remote.%s.fetch", rename.new_name);
 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old_name);
-		for (i = 0; i < oldremote->fetch.nr; i++) {
+		for (int i = 0; i < oldremote->fetch.nr; i++) {
 			char *ptr;
 
 			strbuf_reset(&buf2);
@@ -813,7 +810,7 @@ static int mv(int argc, const char **argv, const char *prefix,
 	}
 
 	read_branches();
-	for (i = 0; i < branch_list.nr; i++) {
+	for (size_t i = 0; i < branch_list.nr; i++) {
 		struct string_list_item *item = branch_list.items + i;
 		struct branch_info *info = item->util;
 		if (info->remote_name && !strcmp(info->remote_name, rename.old_name)) {
@@ -846,7 +843,7 @@ static int mv(int argc, const char **argv, const char *prefix,
 					  _("Renaming remote references"),
 					  rename.remote_branches->nr + rename.symrefs_nr);
 	}
-	for (i = 0; i < remote_branches.nr; i++) {
+	for (size_t i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
 		struct strbuf referent = STRBUF_INIT;
 
@@ -859,7 +856,7 @@ static int mv(int argc, const char **argv, const char *prefix,
 		strbuf_release(&referent);
 		display_progress(progress, ++refs_renamed_nr);
 	}
-	for (i = 0; i < remote_branches.nr; i++) {
+	for (size_t i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
 
 		if (item->util)
@@ -875,7 +872,7 @@ static int mv(int argc, const char **argv, const char *prefix,
 			die(_("renaming '%s' failed"), item->string);
 		display_progress(progress, ++refs_renamed_nr);
 	}
-	for (i = 0; i < remote_branches.nr; i++) {
+	for (size_t i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
 
 		if (!item->util)
@@ -920,7 +917,7 @@ static int rm(int argc, const char **argv, const char *prefix,
 	struct string_list branches = STRING_LIST_INIT_DUP;
 	struct string_list skipped = STRING_LIST_INIT_DUP;
 	struct branches_for_remote cb_data;
-	int i, result;
+	int result;
 
 	memset(&cb_data, 0, sizeof(cb_data));
 	cb_data.branches = &branches;
@@ -942,7 +939,7 @@ static int rm(int argc, const char **argv, const char *prefix,
 	for_each_remote(add_known_remote, &known_remotes);
 
 	read_branches();
-	for (i = 0; i < branch_list.nr; i++) {
+	for (size_t i = 0; i < branch_list.nr; i++) {
 		struct string_list_item *item = branch_list.items + i;
 		struct branch_info *info = item->util;
 		if (info->remote_name && !strcmp(info->remote_name, remote->name)) {
@@ -988,7 +985,7 @@ static int rm(int argc, const char **argv, const char *prefix,
 			      "Note: Some branches outside the refs/remotes/ hierarchy were not removed;\n"
 			      "to delete them, use:",
 			      skipped.nr));
-		for (i = 0; i < skipped.nr; i++)
+		for (size_t i = 0; i < skipped.nr; i++)
 			fprintf(stderr, "  git branch -d %s\n",
 				skipped.items[i].string);
 	}
@@ -1166,7 +1163,6 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 	struct branch_info *branch_info = item->util;
 	struct string_list *merge = &branch_info->merge;
 	int width = show_info->width + 4;
-	int i;
 
 	if (branch_info->rebase >= REBASE_TRUE && branch_info->merge.nr > 1) {
 		error(_("invalid branch.%s.merge; cannot rebase onto > 1 branch"),
@@ -1192,7 +1188,7 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 	} else {
 		printf_ln(_("merges with remote %s"), merge->items[0].string);
 	}
-	for (i = 1; i < merge->nr; i++)
+	for (size_t i = 1; i < merge->nr; i++)
 		printf(_("%-*s    and with remote %s\n"), width, "",
 		       merge->items[i].string);
 
@@ -1277,7 +1273,6 @@ static int get_one_entry(struct remote *remote, void *priv)
 	struct string_list *list = priv;
 	struct strbuf remote_info_buf = STRBUF_INIT;
 	struct strvec *url;
-	int i;
 
 	if (remote->url.nr > 0) {
 		struct strbuf promisor_config = STRBUF_INIT;
@@ -1294,8 +1289,7 @@ static int get_one_entry(struct remote *remote, void *priv)
 	} else
 		string_list_append(list, remote->name)->util = NULL;
 	url = push_url_of_remote(remote);
-	for (i = 0; i < url->nr; i++)
-	{
+	for (size_t i = 0; i < url->nr; i++) {
 		strbuf_addf(&remote_info_buf, "%s (push)", url->v[i]);
 		string_list_append(list, remote->name)->util =
 				strbuf_detach(&remote_info_buf, NULL);
@@ -1312,10 +1306,8 @@ static int show_all(void)
 	result = for_each_remote(get_one_entry, &list);
 
 	if (!result) {
-		int i;
-
 		string_list_sort(&list);
-		for (i = 0; i < list.nr; i++) {
+		for (size_t i = 0; i < list.nr; i++) {
 			struct string_list_item *item = list.items + i;
 			if (verbose)
 				printf("%s\t%s\n", item->string,
@@ -1352,7 +1344,7 @@ static int show(int argc, const char **argv, const char *prefix,
 		query_flag = (GET_REF_STATES | GET_HEAD_NAMES | GET_PUSH_REF_STATES);
 
 	for (; argc; argc--, argv++) {
-		int i;
+		size_t i;
 		struct strvec *url;
 
 		get_remote_ref_states(*argv, &info.states, query_flag);
@@ -1458,7 +1450,7 @@ static void report_set_head_auto(const char *remote, const char *head_name,
 static int set_head(int argc, const char **argv, const char *prefix,
 		    struct repository *repo UNUSED)
 {
-	int i, opt_a = 0, opt_d = 0, result = 0, was_detached;
+	int opt_a = 0, opt_d = 0, result = 0, was_detached;
 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
 		b_local_head = STRBUF_INIT;
 	char *head_name = NULL;
@@ -1489,7 +1481,7 @@ static int set_head(int argc, const char **argv, const char *prefix,
 		else if (states.heads.nr > 1) {
 			result |= error(_("Multiple remote HEAD branches. "
 					  "Please choose one explicitly with:"));
-			for (i = 0; i < states.heads.nr; i++)
+			for (size_t i = 0; i < states.heads.nr; i++)
 				fprintf(stderr, "  git remote set-head %s %s\n",
 					argv[0], states.heads.items[i].string);
 		} else
@@ -1714,7 +1706,7 @@ static int set_branches(int argc, const char **argv, const char *prefix,
 static int get_url(int argc, const char **argv, const char *prefix,
 		   struct repository *repo UNUSED)
 {
-	int i, push_mode = 0, all_mode = 0;
+	int push_mode = 0, all_mode = 0;
 	const char *remotename = NULL;
 	struct remote *remote;
 	struct strvec *url;
@@ -1742,7 +1734,7 @@ static int get_url(int argc, const char **argv, const char *prefix,
 	url = push_mode ? push_url_of_remote(remote) : &remote->url;
 
 	if (all_mode) {
-		for (i = 0; i < url->nr; i++)
+		for (size_t i = 0; i < url->nr; i++)
 			printf_ln("%s", url->v[i]);
 	} else {
 		printf_ln("%s", url->v[0]);
@@ -1754,7 +1746,7 @@ static int get_url(int argc, const char **argv, const char *prefix,
 static int set_url(int argc, const char **argv, const char *prefix,
 		   struct repository *repo UNUSED)
 {
-	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
+	int push_mode = 0, add_mode = 0, delete_mode = 0;
 	int matches = 0, negative_matches = 0;
 	const char *remotename = NULL;
 	const char *newurl = NULL;
@@ -1818,7 +1810,7 @@ static int set_url(int argc, const char **argv, const char *prefix,
 	if (regcomp(&old_regex, oldurl, REG_EXTENDED))
 		die(_("Invalid old URL pattern: %s"), oldurl);
 
-	for (i = 0; i < urlset->nr; i++)
+	for (size_t i = 0; i < urlset->nr; i++)
 		if (!regexec(&old_regex, urlset->v[i], 0, NULL, 0))
 			matches++;
 		else

-- 
2.50.1.619.g074bbf1d35.dirty

