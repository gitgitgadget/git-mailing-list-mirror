Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50CE41686B
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868989; cv=none; b=HiNxb1a8HmOE8tzSm3c0fY1bWdEADIYo/8q/FTk/TwgczHEaLwfTl7aWbR7fDlLNY2Pc5Mhn8gfU8wJRUv7NHEVppFR278ResytmPtrRvA+2m/IMFUtLM9ORJKA8RJxhhq7+AFT+rgxk1jLPGNTeqzUdmTZCXlz32ZVVHTolI9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868989; c=relaxed/simple;
	bh=Bl2DAYs9uTGr3hbpmGIXQYvFbAf/QAyMMqZ1c3Z2cNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kTd1LgO/fwpDy6fAu53P3ZsbeVPwPmM7/pmWiZofHL49QeY79skxvoq6PqVRXhsqvgqHvb7tqI//3GicWmuwim377YwMjfMhh/khUKtioiF99cDEfqaFEB0KPcHGciuNitu1tf+CPjUNcoR3XJyKlVedTmgVznoyUnGHLVhsHYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7/IHrOR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7/IHrOR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49553515a8bso1682775e9.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868985; x=1786473785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gu3Mc1j9cU6XQT3JTU5qm7gFs+TkVa4jNSUWAXHTwvg=;
        b=F7/IHrORZVls2o4vBll9QCGVfpOYVTyrTzo7yJgKX4krSzqn9/M4UQEhk7QxmqbYCN
         DkTkicjrWqKVjAbbpOegaI7wg/h8VZuE4I5/wEl1AqCf4BvTMEaag2DyCmOl66gJzdoX
         eN6oW1jr2+k/glenuJ0hyVKrDWjXw95WyPzqGIpBLlXJzYFVrQgVD4wym2cbyeVfUzUX
         6KBUwJdxt2y8CkVOnLhRH5NtjAyCPfHpYgwnOeFe+eYIGMwZ/pw2ScuSVK37WozhCh2o
         S4nc8CvF/75rldKhsWXSCRxF4fb3wr65So5HHWTlK7lNDqYXDVe6kc0S4LqNitqmnCd9
         H3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868985; x=1786473785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gu3Mc1j9cU6XQT3JTU5qm7gFs+TkVa4jNSUWAXHTwvg=;
        b=i2bdxktS8/uZ4HA7VfymnLw9B6Q8jEzh3GkYUJ9wd4Vmtw6lp56DcnCj71mubtkQ8i
         CNDFHdXeZtSX7Mhs3kLYGfwU+1PJqf83RUZHEnvNxHgsg5lGMdUPuxyR/UboEgWBA9zN
         uWciLCQReKBfvxTpzsEihXrWEimnYu6vgvleUEyLxe7YitwWwt9zhTKA20mhcjDMryYG
         lI5HGKqgT/8ohyNFXJPDZxT8mxP1RapTuvEC7azmCwD5UNrEDVRrXN3RERa5maaoWICi
         STjrGbgpQ/N+yTO3t7iHbJarPSg/5Hkv66jWFtohvFvdgx/vwAZ9BMkHK2xWjpqvKiSV
         /vSQ==
X-Gm-Message-State: AOJu0YySwGprlH0zpZwYv70jvdDS+Y20uKfH3QGAb2Y6moNm3StqufYe
	i7694I0P6EHy3wbmjgiyTqsq1ZrG8uGDKkEX/4NKybIu2oINvwU6DrYJ
X-Gm-Gg: AR+sD122y1gJVQfre5KosXP8E4JDVkQWjtobC9x4oVN5z98ZH43JxzHpDNchSJbyG8z
	MOgDeWfzV6urrZU9XwjbpmkltqZVDYrWAhD0h9Xc/GKAylM0t1cI0LXepYgR4+y46mm6rRexPIP
	sAd42tyntG6z3H8Jq/vE55Mb3RX5Ggco8fgT1AIgOyvQvnVg600HHUXbhESlSgR59BRPLhnBNe5
	SjMKXumYLLd9rfoWiTABpkQLqwoLh8RJK3WIR4bFNnY7p4nHC8INPMpK2ozezn8fnP5100ogd7E
	pgVARsWiPcEETMHqz3x3XB2KShvIkgKo0ozi4LqXyp7bTrBAPTH5oDPyOeSa12Ifrp/vx/5Tkee
	MsxRwcGtsoWEJO0A7c3fQaB11YdsY3Eiu/OxeZ/N+6sh0+IlquoP7fsbXQGvwgcwCLVjVfY4HD+
	HYq1vnojjB6NdNGyAXa5JjFEQ4AdPnp7bUMwob8HxrjrAt8qzzwoamqoIHlp9dMNxmx6IHNI/3H
	lrFJgKVb0RSIRjCwyEP4n19PJ4qYdcs6eGmtLpYD8M0BaKWW1K8mXtVMcayAgQ4cSZGn5PuKtBE
	2Xnzxd0PsDonAvavN9Z6yd50BcIIyG0ovFAjrXIrQNjuIF05T96sP9/EvBjiOMIQYw070G9XbQu
	DzRFH+3XjXRkH6GtOjvvfzd38GWw=
X-Received: by 2002:a05:600c:840f:b0:495:7538:d4ea with SMTP id 5b1f17b1804b1-4994e6ffc90mr6071815e9.0.1785868984093;
        Tue, 04 Aug 2026 11:43:04 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7b73sm138877835e9.9.2026.08.04.11.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:43:03 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 04 Aug 2026 20:42:58 +0200
Subject: [PATCH GSoC v4 4/9] fetch-object-info: use dedicated struct for
 the results
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-objecttype-support-v4-4-31511b0231be@gmail.com>
References: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
In-Reply-To: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

fetch_object_info() collects information about N objects, but it stores
the results in an array of object_info. That struct holds the extended
parameters of read_object_info() (The optional outputs the caller wants
filled). Its pointers tell that function where to write the answers for
a single object. object_info is not meant to be the final storage, and
since fetch_object_info() does not call read_object_info(), there is no
reason to use it. Using it means allocating one scalar per object per
attribute just to have those pointers somewhere to point at.

Add struct fetch_object_info_results. The caller sets the wants_* flags
to say what it is interested in, and fetch_object_info() allocates one
array per attribute. A set wants_* flag means "asked for", while a
non-NULL array means "available". The caller releases the arrays with
free_fetch_object_info_results().

The object_info_options string list is no longer needed. Filtering
against the server's advertisement now sets local ask_* flags, and
send_object_info_request() turns those into the v2 protocol option
strings. remote_atom_map[] existed only to map those strings back into
atom names, so drop it and build remote_allowed_atoms from the result
arrays.

Currently for wants_* and ask_* there is only the 'size' variant but a
subsequent commit will add '*_type'.

free_object_info_contents() loses its only caller and is dropped.

Dropping the allow-list check makes the final else reachable from the
wire, so die() instead of BUG(): an unknown attribute is the server's
error, not ours.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c  | 59 +++++++++-----------------------------
 fetch-object-info.c | 81 ++++++++++++++++++++++++++---------------------------
 fetch-object-info.h | 27 +++++++++++++-----
 object-file.c       | 10 -------
 odb.h               |  3 --
 transport.c         |  3 +-
 transport.h         |  5 ++--
 7 files changed, 77 insertions(+), 111 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 884b6d5ad3..e1650b2921 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -31,6 +31,7 @@
 #include "alias.h"
 #include "remote.h"
 #include "transport.h"
+#include "fetch-object-info.h"
 
 /*
  * Maximum length for a remote URL. While no universal standard exists,
@@ -681,9 +682,8 @@ static void batch_one_object(const char *obj_name,
 
 static int get_remote_info(int argc,
 			   const char **argv,
-			   struct object_info **remote_object_info,
-			   struct oid_array *object_info_oids,
-			   struct string_list *object_info_options)
+			   struct fetch_object_info_results *results,
+			   struct oid_array *object_info_oids)
 {
 	int retval = 0;
 	struct remote *remote = NULL;
@@ -724,11 +724,9 @@ static int get_remote_info(int argc,
 		goto cleanup;
 	}
 
-	CALLOC_ARRAY(*remote_object_info, object_info_oids->nr);
 	gtransport->smart_options->object_info_oids = object_info_oids;
 
-	gtransport->smart_options->object_info_options = object_info_options;
-	gtransport->smart_options->object_info_data = *remote_object_info;
+	gtransport->smart_options->object_info_results = results;
 	retval = transport_fetch_object_info(gtransport);
 cleanup:
 	transport_disconnect(gtransport);
@@ -816,21 +814,6 @@ static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
 		load_mailmap();
 }
 
-struct protocol_placeholder_entry {
-	const char *option;
-	const char *atom;
-};
-
-static const struct protocol_placeholder_entry remote_atom_map[] = {
-	{"size", "objectsize"},
-	{"type", "objecttype"},
-	/*
-	 * Add new protocol options here. Even if the server doesn't support
-	 * them the allow_list will drop them if the server doesn't advertise
-	 * them.
-	 */
-};
-
 static void parse_cmd_remote_object_info(struct batch_options *opt,
 					 const char *line, struct strbuf *output,
 					 struct expand_data *data)
@@ -838,9 +821,8 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	int count;
 	const char **argv;
 	char *line_to_split;
-	struct object_info *remote_object_info = NULL;
+	struct fetch_object_info_results results = FETCH_OBJECT_INFO_RESULTS_INIT;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
-	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
 	const char *saved_format = opt->format;
 
 	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
@@ -861,26 +843,21 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		    MAX_ALLOWED_OBJ_LIMIT);
 
 	if (data->info.sizep)
-		string_list_append(&object_info_options, "size");
-	if (data->info.typep)
-		string_list_append(&object_info_options, "type");
+		results.wants_size = 1;
 
-	if (get_remote_info(count, argv, &remote_object_info,
-			    &object_info_oids, &object_info_options))
+	if (get_remote_info(count, argv, &results, &object_info_oids))
 		die(_("failed to get object info from the remote: %s"), argv[0]);
 
 	string_list_clear(&data->remote_allowed_atoms, 0);
 	string_list_append(&data->remote_allowed_atoms, "objectname");
-	for (size_t i = 0; i < ARRAY_SIZE(remote_atom_map); i++)
-		if (unsorted_string_list_has_string(&object_info_options, remote_atom_map[i].option))
-			string_list_append(&data->remote_allowed_atoms,
-					   remote_atom_map[i].atom);
+	if (results.sizes)
+		string_list_append(&data->remote_allowed_atoms, "objectsize");
 
 	data->skip_object_info = 1;
-	for (size_t i = 0; i < object_info_oids.nr; i++) {
+	for (size_t i = 0; i < results.nr; i++) {
 		data->oid = object_info_oids.oid[i];
 
-		if (remote_object_info[i].unrecognized) {
+		if (results.unrecognized[i]) {
 			report_object_status(opt, oid_to_hex(&data->oid),
 					     &data->oid, "missing");
 			continue;
@@ -890,13 +867,8 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		 * When reaching here, it means remote-object-info can retrieve
 		 * information from server without downloading them.
 		 */
-		if (remote_object_info[i].sizep) {
-			data->size = *remote_object_info[i].sizep;
-		}
-
-		if (remote_object_info[i].typep) {
-			data->type = *remote_object_info[i].typep;
-		}
+		if (results.sizes)
+			data->size = results.sizes[i];
 
 		opt->batch_mode = BATCH_MODE_INFO;
 		data->is_remote = 1;
@@ -906,12 +878,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	data->skip_object_info = 0;
 	opt->format = saved_format;
 
-	for (size_t i = 0; i < object_info_oids.nr; i++)
-		free_object_info_contents(&remote_object_info[i]);
-	string_list_clear(&object_info_options, 0);
+	free_fetch_object_info_results(&results);
 	free(line_to_split);
 	free(argv);
-	free(remote_object_info);
 	oid_array_clear(&object_info_oids);
 }
 
diff --git a/fetch-object-info.c b/fetch-object-info.c
index 531610e6f4..46a1289ff3 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -12,16 +12,14 @@
 static void send_object_info_request(const int fd_out,
 				     const struct string_list *server_options,
 				     struct oid_array *oids,
-				     struct string_list *object_info_options)
+				     unsigned ask_size)
 {
 	struct strbuf req_buf = STRBUF_INIT;
 
 	write_command_and_capabilities(&req_buf, "object-info", server_options);
 
-	if (unsorted_string_list_has_string(object_info_options, "size"))
+	if (ask_size)
 		packet_buf_write(&req_buf, "size");
-	else if (object_info_options->nr)
-		BUG("only size should be in object_info_options");
 
 	if (oids)
 		for (size_t i = 0; i < oids->nr; i++)
@@ -52,37 +50,32 @@ static int parse_object_size(const char *s, size_t *res)
 int fetch_object_info(const enum protocol_version version,
 		      const struct string_list *server_options,
 		      struct oid_array *oids,
-		      struct string_list *object_info_options,
 		      struct packet_reader *reader,
-		      struct object_info *object_info_data,
-		      const int stateless_rpc, const int fd_out)
+		      struct fetch_object_info_results *results,
+		      const int stateless_rpc,
+		      const int fd_out)
 {
+	unsigned ask_size = 0;
 	int size_index = -1;
+	size_t wanted;
+
+	results->nr = oids->nr;
+	CALLOC_ARRAY(results->unrecognized, results->nr);
 
 	switch (version) {
 	case protocol_v2:
 		if (!server_supports_v2("object-info"))
 			die(_("object-info capability is not enabled on the server"));
-		/*
-		 * When removing an element from the list it gets swapped by the
-		 * last element, iterate backwards to prevent elements skipping
-		 * evaluation.
-		 *
-		 * object_info_options->nr can be safely casted without overflow
-		 * because the number of options is a small known number (the
-		 * supported placeholders which currently are size and type).
-		 */
-		for (int i = (int)object_info_options->nr - 1; i >= 0; i--)
-			if (!server_supports_feature("object-info",
-						     object_info_options->items[i].string, 0))
-				unsorted_string_list_delete_item(object_info_options, i, 0);
+
+		if (results->wants_size &&
+		    server_supports_feature("object-info", "size", 0))
+			ask_size = 1;
 
 		/*
 		 * Even if no options are left, we still send the oid so we get
 		 * at least an existence check.
 		 */
-		send_object_info_request(fd_out, server_options, oids,
-					 object_info_options);
+		send_object_info_request(fd_out, server_options, oids, ask_size);
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -90,28 +83,25 @@ int fetch_object_info(const enum protocol_version version,
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
 	}
+	wanted = ask_size;
 
-	for (size_t i = 0; i < object_info_options->nr; i++) {
+	for (size_t i = 0; i < wanted; i++) {
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
 			check_stateless_delimiter(stateless_rpc, reader,
 						  "stateless delimiter expected");
 			return -1;
 		}
 
-		if (!unsorted_string_list_has_string(object_info_options, reader->line))
-			return -1;
-
 		if (!strcmp(reader->line, "size")) {
-			/*
-			 * i is the number of supported options which currently
-			 * is only size. No risk of overflow.
-			 */
+			if (!ask_size)
+				die(_("object-info: unrequested 'size' attribute"));
+			if (results->sizes)
+				die(_("object-info: duplicate 'size' attribute"));
 			size_index = (int)i;
-			for (size_t j = 0; j < oids->nr; j++)
-				object_info_data[j].sizep =
-					xcalloc(1, sizeof(*object_info_data[j].sizep));
+			CALLOC_ARRAY(results->sizes, results->nr);
 		} else {
-			BUG("only size is supported");
+			die(_("object-info: unknown attribute '%s'"),
+			    reader->line);
 		}
 	}
 
@@ -137,24 +127,24 @@ int fetch_object_info(const enum protocol_version version,
 		 */
 		if (object_info_values.nr >= 2 &&
 		    !strcmp(object_info_values.items[1].string, "")) {
-			object_info_data[i].unrecognized = 1;
+			results->unrecognized[i] = 1;
 			string_list_clear(&object_info_values, 0);
 			continue;
 		}
 
 		/*
-		 * Because we filter the options to be only the supported by
-		 * the server we expect the server to answer with the same
-		 * number of attributes requested.
+		 * Because we only ask for attributes the server said it
+		 * supports, we expect the answer to have one value per
+		 * requested attribute, plus the OID.
 		 */
-		if (object_info_options->nr + 1 != object_info_values.nr)
+		if (wanted + 1 != object_info_values.nr)
 			die("object-info: unexpected number of attributes: %s",
 			    reader->line);
 
-		if (size_index >= 0 &&
+		if (results->sizes &&
 		    parse_object_size(object_info_values.items[size_index + 1].string,
-				      object_info_data[i].sizep))
-			die("object-info: ref %s has invalid size %s",
+				      &results->sizes[i]))
+			die("object-info: object %s has invalid size %s",
 			    object_info_values.items[0].string,
 			    object_info_values.items[size_index + 1].string);
 
@@ -169,3 +159,10 @@ int fetch_object_info(const enum protocol_version version,
 
 	return 0;
 }
+
+void free_fetch_object_info_results(struct fetch_object_info_results *results)
+{
+	free(results->sizes);
+	free(results->unrecognized);
+	memset(results, 0, sizeof(*results));
+}
diff --git a/fetch-object-info.h b/fetch-object-info.h
index 316bf917ce..9f72e91155 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -4,21 +4,34 @@
 #include "pkt-line.h"
 #include "protocol.h"
 
-struct object_info;
+struct fetch_object_info_results {
+	size_t *sizes;
+	uint8_t *unrecognized;
+	size_t nr;
+	unsigned wants_size:1;
+};
+
+#define FETCH_OBJECT_INFO_RESULTS_INIT { 0 }
+
 struct oid_array;
 /*
- * Sends git-cat-file object-info command into the request buf and read the
+ * Sends git-cat-file object-info command into the request buf and reads the
  * results from packets.
  *
- * Modifies object_info_options, on return it contains only the supported
- * options by the server.
+ * The caller sets the wants_* flags in "results" to indicate which attributes
+ * it is interested in. On return, "results" holds one array per attribute that
+ * the server both advertised and answered with. An array left NULL means the
+ * attribute is not available.
+ * Release them with free_fetch_object_info_results().
  */
 int fetch_object_info(enum protocol_version version,
 		      const struct string_list *server_options,
 		      struct oid_array *oids,
-		      struct string_list *object_info_options,
 		      struct packet_reader *reader,
-		      struct object_info *object_info_data,
-		      int stateless_rpc, int fd_out);
+		      struct fetch_object_info_results *results,
+		      int stateless_rpc,
+		      int fd_out);
+
+void free_fetch_object_info_results(struct fetch_object_info_results *results);
 
 #endif /* FETCH_OBJECT_INFO_H */
diff --git a/object-file.c b/object-file.c
index ec35c318bc..66f6c81373 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1340,13 +1340,3 @@ int odb_transaction_files_begin(struct odb_source *source,
 
 	return 0;
 }
-
-void free_object_info_contents(struct object_info *object_info)
-{
-	if (!object_info)
-		return;
-	free(object_info->typep);
-	free(object_info->sizep);
-	free(object_info->disk_sizep);
-	free(object_info->delta_base_oid);
-}
diff --git a/odb.h b/odb.h
index cbc2f9ced4..f4e6c26a0e 100644
--- a/odb.h
+++ b/odb.h
@@ -637,7 +637,4 @@ void parse_alternates(const char *string,
 		      const char *relative_base,
 		      struct strvec *out);
 
-/* Free pointers inside of object_info, but not object_info itself */
-void free_object_info_contents(struct object_info *object_info);
-
 #endif /* ODB_H */
diff --git a/transport.c b/transport.c
index 2bb5eedc32..b0e29124d1 100644
--- a/transport.c
+++ b/transport.c
@@ -451,9 +451,8 @@ static int fetch_object_info_via_pack(struct transport *transport)
 	ret = fetch_object_info(data->version,
 				transport->server_options,
 				transport->smart_options->object_info_oids,
-				transport->smart_options->object_info_options,
 				&reader,
-				data->options.object_info_data,
+				data->options.object_info_results,
 				transport->stateless_rpc, data->fd[1]);
 
 	close(data->fd[0]);
diff --git a/transport.h b/transport.h
index a7869d18e0..6948b65db9 100644
--- a/transport.h
+++ b/transport.h
@@ -7,6 +7,8 @@
 #include "string-list.h"
 #include "connect.h"
 
+struct fetch_object_info_results;
+
 struct git_transport_options {
 	unsigned thin : 1;
 	unsigned keep : 1;
@@ -57,8 +59,7 @@ struct git_transport_options {
 	struct oidset *acked_commits;
 
 	struct oid_array *object_info_oids;
-	struct object_info *object_info_data;
-	struct string_list *object_info_options;
+	struct fetch_object_info_results *object_info_results;
 };
 
 enum transport_family {

-- 
2.54.0

