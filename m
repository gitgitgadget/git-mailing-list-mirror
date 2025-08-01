Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEBE2253A9
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085872; cv=none; b=Vvv0XK2poUuA/ONVrw2VVsp6BLgqLw6oBQ19jjUaKKKwfE4gSXZMv7XTTGAmo8osUbf11AHYN0IzxenIizNbD9aa94d3Zk2YkQArIhaLpppIPWHoSqpPhK42XJiiQRQwkRXIbI97Hu7kR89asAxUJiW6zw9REqwx/KS9oqi1dBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085872; c=relaxed/simple;
	bh=vIAnaVvxerIVOgoNfADiDytrWIXgBCQO8gowRPV1tAE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6bZ4NMlXNF7ll6rCGpDk4vCH/+6eCrdgxwwxyf/Zggh/pHLxzNIn0CKrLAVNQzLR+zM0KGgYooQFl79nykDeJPJDrOS9Es+Ib4fkwg3cNnsdeSIJAEysll7Mhkwy5ZkUg89wETyNze/g3ogdhnFKGK4h+JHBsqTcZ+XqJiTNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KIGStE7x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BW+JmnBd; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KIGStE7x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BW+JmnBd"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E9ED0EC15F3;
	Fri,  1 Aug 2025 18:04:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 01 Aug 2025 18:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754085868; x=
	1754172268; bh=YWgpKJhThyq5VUhvOVCBY5VkkSbdFIVERv3APVUt5kQ=; b=K
	IGStE7xJ3kWzQPjguYBxVhRxPbF2/gclzG9Wid6SvnYmdfHyxf6C2vA1kpZfev07
	8PD9VHHqA+jts0uslCq/q3OFpJnnJPF9b6MncuUz9xDRYyL52OjGDM4J/gZn2wXi
	Mub25/Y4PJU/ZcGzAxO96c7TK1b/5dLXq2M0fQloCScSUGQRAf0yXvjiXiuXYKh0
	wWGovIoILhxoeBdOa7MEBQYCjEf4w2wIL/vw7zbE5L5UoKTyqjy9uq9AJMUI+BQI
	WQPBwsDcosLRv59nHXM8CGG92adJVjSikkNcXJgpmFHw5HsLYRzn96nWWoJiPWPg
	0hIhx7OPFJGEwjSLY1ftA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754085868; x=1754172268; bh=YWgpKJhThyq5VUhvOVCBY5VkkSbd
	FIVERv3APVUt5kQ=; b=BW+JmnBdaR3bRgd58c1v8vJQ78HkMiGGy2D6lt898odA
	p/6iwjpSG+RUbrGES956D2eKs5l9N29xir5APwV1Kwf4nLY8GzvJ4uDoOFIBF8nw
	RjnnvzzQN54uNzmIJyPzMi8tRtQoaMeMGaJrUp5TF5AtCMFycW0vaWdwO65Apytg
	SN9jw4FZ2rJwqw6Tu45h0XbDxOYYlzJGgnjGF4mWqwIlL/uPXLpFJV0rHhe3Hqo7
	ke65HLjt9/VkCs0GyRu5oHvLStyLr/vGNfw/HFgyKsUEJDJKytlbiQqPo+CL7JbJ
	WqIpPA6pGoUx2Zm7bMJ+FeUcXm3k64QCiRxVRCnDLg==
X-ME-Sender: <xms:7DmNaOwjxhKwyIhcPqfZFRvKa8RsIt_-2IrlSvDO40VAaxSRAOqteg>
    <xme:7DmNaKdJfPxAI1DkBllrzHHFdtNV_o4gjZy3U55SkRzVCXPihDL6V3N-cGbq45Rkb
    2mLvaF9mzA02XFMXg>
X-ME-Received: <xmr:7DmNaCKv5QrWpnynHlTSnLt5mlAMngWLO3yDKKB63QDiTv_15CT6-wBNH37_QC89dt5CUZnxYXEX0LxnK8QddI4Ohd18o2qIQblrb0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:7DmNaDGbQtiv4B7Ku11YpLAY9t1X_ro8HFjDTbnIKk3T_HLYKpxl2A>
    <xmx:7DmNaEoFjhgAkD7fQBuSoRa8X1kC21nn55cdjtT9rAIGykr0l5mtTA>
    <xmx:7DmNaERvBfUgUL5-FvgYqoLXIVDUwF729mCYpzzzhLecEGjsaRHEHg>
    <xmx:7DmNaJNvyXGwh67PGB2X9Twgw6UedIDPsJ-HzLdL-t4zG10r9Z7T9Q>
    <xmx:7DmNaJWF03eVgcL_fmpjn1JBJA35xyKanSvmT3neBoE7dYbY4AijlPL1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 18:04:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 2/7] string-list: align string_list_split() with its _in_place() counterpart
Date: Fri,  1 Aug 2025 15:04:18 -0700
Message-ID: <20250801220423.1230969-3-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g85c5610de3
In-Reply-To: <20250801220423.1230969-1-gitster@pobox.com>
References: <20250731224607.3942417-1-gitster@pobox.com>
 <20250801220423.1230969-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some unknown reason, unlike string_list_split_in_place(),
string_list_split() took only a single character as a field
delimiter.  Before giving both functions more features in future
commits, allow string_list_split() to take more than one delimiter
characters to make them closer to each other.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/blame.c              |  2 +-
 builtin/merge.c              |  2 +-
 builtin/var.c                |  2 +-
 connect.c                    |  2 +-
 diff.c                       |  2 +-
 fetch-pack.c                 |  2 +-
 notes.c                      |  2 +-
 parse-options.c              |  2 +-
 pathspec.c                   |  2 +-
 protocol.c                   |  2 +-
 ref-filter.c                 |  4 ++--
 setup.c                      |  3 ++-
 string-list.c                |  4 ++--
 string-list.h                | 16 ++++++++--------
 t/helper/test-path-utils.c   |  3 ++-
 t/helper/test-ref-store.c    |  2 +-
 t/unit-tests/u-string-list.c | 16 ++++++++--------
 transport.c                  |  2 +-
 upload-pack.c                |  2 +-
 19 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 91586e6852..70a6460401 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -420,7 +420,7 @@ static void parse_color_fields(const char *s)
 	colorfield_nr = 0;
 
 	/* Ideally this would be stripped and split at the same time? */
-	string_list_split(&l, s, ',', -1);
+	string_list_split(&l, s, ",", -1);
 	ALLOC_GROW(colorfield, colorfield_nr + 1, colorfield_alloc);
 
 	for_each_string_list_item(item, &l) {
diff --git a/builtin/merge.c b/builtin/merge.c
index 18b22c0a26..893f8950bf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -875,7 +875,7 @@ static void add_strategies(const char *string, unsigned attr)
 	if (string) {
 		struct string_list list = STRING_LIST_INIT_DUP;
 		struct string_list_item *item;
-		string_list_split(&list, string, ' ', -1);
+		string_list_split(&list, string, " ", -1);
 		for_each_string_list_item(item, &list)
 			append_strategy(get_strategy(item->string));
 		string_list_clear(&list, 0);
diff --git a/builtin/var.c b/builtin/var.c
index ada642a9fe..4ae7af0eff 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -181,7 +181,7 @@ static void list_vars(void)
 			if (ptr->multivalued && *val) {
 				struct string_list list = STRING_LIST_INIT_DUP;
 
-				string_list_split(&list, val, '\n', -1);
+				string_list_split(&list, val, "\n", -1);
 				for (size_t i = 0; i < list.nr; i++)
 					printf("%s=%s\n", ptr->name, list.items[i].string);
 				string_list_clear(&list, 0);
diff --git a/connect.c b/connect.c
index e77287f426..867b12bde5 100644
--- a/connect.c
+++ b/connect.c
@@ -407,7 +407,7 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
 	 * name.  Subsequent fields (symref-target and peeled) are optional and
 	 * don't have a particular order.
 	 */
-	if (string_list_split(&line_sections, line, ' ', -1) < 2) {
+	if (string_list_split(&line_sections, line, " ", -1) < 2) {
 		ret = 0;
 		goto out;
 	}
diff --git a/diff.c b/diff.c
index dca87e164f..a81949a422 100644
--- a/diff.c
+++ b/diff.c
@@ -327,7 +327,7 @@ static unsigned parse_color_moved_ws(const char *arg)
 	struct string_list l = STRING_LIST_INIT_DUP;
 	struct string_list_item *i;
 
-	string_list_split(&l, arg, ',', -1);
+	string_list_split(&l, arg, ",", -1);
 
 	for_each_string_list_item(i, &l) {
 		struct strbuf sb = STRBUF_INIT;
diff --git a/fetch-pack.c b/fetch-pack.c
index c1be9b76eb..9866270696 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1914,7 +1914,7 @@ static void fetch_pack_config(void)
 		char *str;
 
 		if (!git_config_get_string("fetch.uriprotocols", &str) && str) {
-			string_list_split(&uri_protocols, str, ',', -1);
+			string_list_split(&uri_protocols, str, ",", -1);
 			free(str);
 		}
 	}
diff --git a/notes.c b/notes.c
index 97b995f3f2..6afcf088b9 100644
--- a/notes.c
+++ b/notes.c
@@ -892,7 +892,7 @@ static int string_list_add_note_lines(struct string_list *list,
 	 * later, along with any empty strings that came from empty
 	 * lines within the file.
 	 */
-	string_list_split(list, data, '\n', -1);
+	string_list_split(list, data, "\n", -1);
 	free(data);
 	return 0;
 }
diff --git a/parse-options.c b/parse-options.c
index 5224203ffe..9e7cb75192 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1338,7 +1338,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 		if (!saw_empty_line && !*str)
 			saw_empty_line = 1;
 
-		string_list_split(&list, str, '\n', -1);
+		string_list_split(&list, str, "\n", -1);
 		for (j = 0; j < list.nr; j++) {
 			const char *line = list.items[j].string;
 
diff --git a/pathspec.c b/pathspec.c
index a3ddd701c7..de325f7ef9 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -201,7 +201,7 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
 	if (!value || !*value)
 		die(_("attr spec must not be empty"));
 
-	string_list_split(&list, value, ' ', -1);
+	string_list_split(&list, value, " ", -1);
 	string_list_remove_empty_items(&list, 0);
 
 	item->attr_check = attr_check_alloc();
diff --git a/protocol.c b/protocol.c
index bae7226ff4..54b9f49c01 100644
--- a/protocol.c
+++ b/protocol.c
@@ -61,7 +61,7 @@ enum protocol_version determine_protocol_version_server(void)
 	if (git_protocol) {
 		struct string_list list = STRING_LIST_INIT_DUP;
 		const struct string_list_item *item;
-		string_list_split(&list, git_protocol, ':', -1);
+		string_list_split(&list, git_protocol, ":", -1);
 
 		for_each_string_list_item(item, &list) {
 			const char *value;
diff --git a/ref-filter.c b/ref-filter.c
index f9f2c512a8..4edfb9c83b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -435,7 +435,7 @@ static int remote_ref_atom_parser(struct ref_format *format UNUSED,
 	}
 
 	atom->u.remote_ref.nobracket = 0;
-	string_list_split(&params, arg, ',', -1);
+	string_list_split(&params, arg, ",", -1);
 
 	for (i = 0; i < params.nr; i++) {
 		const char *s = params.items[i].string;
@@ -831,7 +831,7 @@ static int align_atom_parser(struct ref_format *format UNUSED,
 
 	align->position = ALIGN_LEFT;
 
-	string_list_split(&params, arg, ',', -1);
+	string_list_split(&params, arg, ",", -1);
 	for (i = 0; i < params.nr; i++) {
 		const char *s = params.items[i].string;
 		int position;
diff --git a/setup.c b/setup.c
index 6f52dab64c..b9f5eb8b51 100644
--- a/setup.c
+++ b/setup.c
@@ -1460,8 +1460,9 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 
 	if (env_ceiling_dirs) {
 		int empty_entry_found = 0;
+		static const char path_sep[] = { PATH_SEP, '\0' };
 
-		string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP, -1);
+		string_list_split(&ceiling_dirs, env_ceiling_dirs, path_sep, -1);
 		filter_string_list(&ceiling_dirs, 0,
 				   canonicalize_ceiling_entry, &empty_entry_found);
 		ceil_offset = longest_ancestor_length(dir->buf, &ceiling_dirs);
diff --git a/string-list.c b/string-list.c
index 0cb920e9b0..2284a009cb 100644
--- a/string-list.c
+++ b/string-list.c
@@ -277,7 +277,7 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
 }
 
 int string_list_split(struct string_list *list, const char *string,
-		      int delim, int maxsplit)
+		      const char *delim, int maxsplit)
 {
 	int count = 0;
 	const char *p = string, *end;
@@ -291,7 +291,7 @@ int string_list_split(struct string_list *list, const char *string,
 			string_list_append(list, p);
 			return count;
 		}
-		end = strchr(p, delim);
+		end = strpbrk(p, delim);
 		if (end) {
 			string_list_append_nodup(list, xmemdupz(p, end - p));
 			p = end + 1;
diff --git a/string-list.h b/string-list.h
index 122b318641..6c8650efde 100644
--- a/string-list.h
+++ b/string-list.h
@@ -254,7 +254,7 @@ struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
 
 /**
- * Split string into substrings on character `delim` and append the
+ * Split string into substrings on characters in `delim` and append the
  * substrings to `list`.  The input string is not modified.
  * list->strdup_strings must be set, as new memory needs to be
  * allocated to hold the substrings.  If maxsplit is non-negative,
@@ -262,15 +262,15 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
  * appended to list.
  *
  * Examples:
- *   string_list_split(l, "foo:bar:baz", ':', -1) -> ["foo", "bar", "baz"]
- *   string_list_split(l, "foo:bar:baz", ':', 0) -> ["foo:bar:baz"]
- *   string_list_split(l, "foo:bar:baz", ':', 1) -> ["foo", "bar:baz"]
- *   string_list_split(l, "foo:bar:", ':', -1) -> ["foo", "bar", ""]
- *   string_list_split(l, "", ':', -1) -> [""]
- *   string_list_split(l, ":", ':', -1) -> ["", ""]
+ *   string_list_split(l, "foo:bar:baz", ":", -1) -> ["foo", "bar", "baz"]
+ *   string_list_split(l, "foo:bar:baz", ":", 0) -> ["foo:bar:baz"]
+ *   string_list_split(l, "foo:bar:baz", ":", 1) -> ["foo", "bar:baz"]
+ *   string_list_split(l, "foo:bar:", ":", -1) -> ["foo", "bar", ""]
+ *   string_list_split(l, "", ":", -1) -> [""]
+ *   string_list_split(l, ":", ":", -1) -> ["", ""]
  */
 int string_list_split(struct string_list *list, const char *string,
-		      int delim, int maxsplit);
+		      const char *delim, int maxsplit);
 
 /*
  * Like string_list_split(), except that string is split in-place: the
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 086238c826..f5f33751da 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -348,6 +348,7 @@ int cmd__path_utils(int argc, const char **argv)
 	if (argc == 4 && !strcmp(argv[1], "longest_ancestor_length")) {
 		int len;
 		struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
+		const char path_sep[] = { PATH_SEP, '\0' };
 		char *path = xstrdup(argv[2]);
 
 		/*
@@ -362,7 +363,7 @@ int cmd__path_utils(int argc, const char **argv)
 		 */
 		if (normalize_path_copy(path, path))
 			die("Path \"%s\" could not be normalized", argv[2]);
-		string_list_split(&ceiling_dirs, argv[3], PATH_SEP, -1);
+		string_list_split(&ceiling_dirs, argv[3], path_sep, -1);
 		filter_string_list(&ceiling_dirs, 0,
 				   normalize_ceiling_entry, NULL);
 		len = longest_ancestor_length(path, &ceiling_dirs);
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 8d9a271845..aa1cb9b4ac 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -29,7 +29,7 @@ static unsigned int parse_flags(const char *str, struct flag_definition *defs)
 	if (!strcmp(str, "0"))
 		return 0;
 
-	string_list_split(&masks, str, ',', 64);
+	string_list_split(&masks, str, ",", 64);
 	for (size_t i = 0; i < masks.nr; i++) {
 		const char *name = masks.items[i].string;
 		struct flag_definition *def = defs;
diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index d4ba5f9fa5..150a5f505f 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -43,7 +43,7 @@ static void t_string_list_equal(struct string_list *list,
 				  expected_strings->items[i].string);
 }
 
-static void t_string_list_split(const char *data, int delim, int maxsplit, ...)
+static void t_string_list_split(const char *data, const char *delim, int maxsplit, ...)
 {
 	struct string_list expected_strings = STRING_LIST_INIT_DUP;
 	struct string_list list = STRING_LIST_INIT_DUP;
@@ -65,13 +65,13 @@ static void t_string_list_split(const char *data, int delim, int maxsplit, ...)
 
 void test_string_list__split(void)
 {
-	t_string_list_split("foo:bar:baz", ':', -1, "foo", "bar", "baz", NULL);
-	t_string_list_split("foo:bar:baz", ':', 0, "foo:bar:baz", NULL);
-	t_string_list_split("foo:bar:baz", ':', 1, "foo", "bar:baz", NULL);
-	t_string_list_split("foo:bar:baz", ':', 2, "foo", "bar", "baz", NULL);
-	t_string_list_split("foo:bar:", ':', -1, "foo", "bar", "", NULL);
-	t_string_list_split("", ':', -1, "", NULL);
-	t_string_list_split(":", ':', -1, "", "", NULL);
+	t_string_list_split("foo:bar:baz", ":", -1, "foo", "bar", "baz", NULL);
+	t_string_list_split("foo:bar:baz", ":", 0, "foo:bar:baz", NULL);
+	t_string_list_split("foo:bar:baz", ":", 1, "foo", "bar:baz", NULL);
+	t_string_list_split("foo:bar:baz", ":", 2, "foo", "bar", "baz", NULL);
+	t_string_list_split("foo:bar:", ":", -1, "foo", "bar", "", NULL);
+	t_string_list_split("", ":", -1, "", NULL);
+	t_string_list_split(":", ":", -1, "", "", NULL);
 }
 
 static void t_string_list_split_in_place(const char *data, const char *delim,
diff --git a/transport.c b/transport.c
index c123ac1e38..76487b5453 100644
--- a/transport.c
+++ b/transport.c
@@ -1042,7 +1042,7 @@ static const struct string_list *protocol_allow_list(void)
 	if (enabled < 0) {
 		const char *v = getenv("GIT_ALLOW_PROTOCOL");
 		if (v) {
-			string_list_split(&allowed, v, ':', -1);
+			string_list_split(&allowed, v, ":", -1);
 			string_list_sort(&allowed);
 			enabled = 1;
 		} else {
diff --git a/upload-pack.c b/upload-pack.c
index 4f26f6afc7..91fcdcad9b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1685,7 +1685,7 @@ static void process_args(struct packet_reader *request,
 			if (data->uri_protocols.nr)
 				send_err_and_die(data,
 						 "multiple packfile-uris lines forbidden");
-			string_list_split(&data->uri_protocols, p, ',', -1);
+			string_list_split(&data->uri_protocols, p, ",", -1);
 			continue;
 		}
 
-- 
2.50.1-633-g85c5610de3

