Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBEF3CFF44
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913704; cv=none; b=LPNUY7TFsAGsQJhOt9x73bK9Xlxux2/whI0QBDm7C3p5hSXKgJq0KVpb4WmLCaTMV5k4DBY56i0ReaITWfPq0He1X6E5PVv3XmPW7tof550+/ctTP1gOP1N+T6PKRSfBvMD1avaTlZ0n++/hMx3Xgrap+LjF9s72bcoWopyxv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913704; c=relaxed/simple;
	bh=hwHKCzkopXkwBXiKcCEZhMaRKz1n027kIOVnajDkXHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWPMYTXyrzYIeyXeVgzFVFWaG7hUscYi/6bQTR9Q6g/x4784dtXHPTyTdq4MNCsA9QSVYT4GsynpIToMIrsZi9HPyYyAol8W4eA4cQyzvpFMveul/5lxj4dv1Wy0F8tTlyr5D1KXGBfjLcFcezU3EwOApM8kuBBq7nFQ0q/06dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUgUikaB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUgUikaB"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so2772782f8f.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 03:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780913702; x=1781518502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmVCfQ+h11GNh7kARyuzWGaUqCSuxC+AhetrFaWKIw0=;
        b=cUgUikaB3IRC+Q1B0/vvuQ1ZO4gk1uPklNNnj42ivmietjIm/KFL26X8Sope0evtNA
         tqDW+uFpcC8XPtaGlDsdGwyKjRbX2Fvp/oi8HKrpP2XpqJleT3M0O/I9HIeg8q5TVUgb
         9B/BuVTqH4v8+f8t68Myio9zOeCgGwKaN1yO/s1Ymc2UQj5amOeCSKQ+FOHTsIELnrbd
         KGpkJUdEDJyfJawAtBaGq1P04IO3Ru/TAahHWolE5VQ5P6+5swmmVuqFwZRK+p38gGD1
         GII+mBfU6f6iboNOx3Vzq0zGOOHY9REN8pV/16DSh5+T8w48sVik8n0FjOOK7bc0IrMj
         MFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913702; x=1781518502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tmVCfQ+h11GNh7kARyuzWGaUqCSuxC+AhetrFaWKIw0=;
        b=dGKGhuV4reHfM0nz4+UKuNiht5UfcMJYmKX/7Fs4b0d998Pv/vVgx9OLhhhrg6xpfy
         Qr2OZIWSV+PoSlxOq5vF7Dgq4ELXz2aiSYOc22u0r3aWDMdJWOZp5iOA8hMIQURoYJF+
         69GOHP66dLGq4MTwYW/WryAFWofKId15HeLi0rYcB+dzGVOPIuqpvLZj3GkbFMIYHzB5
         FIjsbY/ly9Xn72Cn5+UfUahMSenCx7+RAHR5UgM9Tq6OIVVL10lk/0dizc5xy1mQk4AV
         groOBqWbcAed5I8xNzKmJFEro/ImNdH/6pz3q+yaOrusa3mmBvkeAt7I2RBQNDQv683m
         bN/w==
X-Forwarded-Encrypted: i=1; AFNElJ8cZR7jwI9DkviJ1vy0VC9V73smPILrWp5q1bOnpdXVEnavU2zxp0pql8uMXKfhbRyEpiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweAKjrPwc1itOVjiJUKPhL3vwvAONtU4FN04mHevujyvwPk8vB
	3LcQz+8OFyXtaRC660W61v4tbxft28V/8lTt1z0TFiX1JiBZvL8nhr6Y
X-Gm-Gg: Acq92OGuPvXxD2Jh8re2Xb+geuK4roIBarEmWMzVdB9ufi8X3IHjyHypymE1aI0rW75
	mtR9gQZBXko2eAIsj+b0KOWAmzKxo9lIZBSGiCVuGI8YTOEI15MgbKwdATJODr9HUx7nc5GCn4h
	CH2TsZeHKSMOB1dTuhrmjcc1RtAIM64DOG68m0FAnOI3YkG+0UAVEBnSL1WitTG65PM3int/1WT
	CAa8ocKmsChp4XruvK/h22mTwAOQNzzNwxWn25+kD3ZzCleVJ9I/rRauj+/ZIQZRNKlQfOffE/4
	qclRKAJgZpX834yJUFrVE3RCl1yc80rbse7ZGrgLh/CYDErW2SRkovNldaz7T9y6/Ss3rhsDRDm
	cghY90mRfjGlhsj+hj89wn7inouq1p1QGCnw7mt3Da9iXF7yOOy5gLxBeebfyLjQ3GGSGDP0t7v
	EhynEEvkY/MyMZ2vs6ql+9a6rGfHRvdu8pjh7XEP+Y8bC462zVxKyz9uDQcsQeBuymsxtTIp82d
	IIiRWIKeJ6nPj0SDDCOcdFPWWDcf5HS/Z9r6vNnz2I5VzYB/wpzKTnmXNlbsqTlghaHmgobDbkf
	QD6SWYklKs6QFt+Jr6K9jnGMv6KUcjwavIhdy4FnCkSWih2ZYeU1hAPbzmoC33HF/A==
X-Received: by 2002:a5d:6190:0:b0:45e:f5bf:6c25 with SMTP id ffacd0b85a97d-46030758ab7mr16651116f8f.32.1780913701609;
        Mon, 08 Jun 2026 03:15:01 -0700 (PDT)
Received: from localhost.localdomain ([188.87.4.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm51131949f8f.0.2026.06.08.03.15.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 03:15:01 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: eric.peijian@gmail.com
Cc: calvinwan@google.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	jonathantanmy@google.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v12 12/12] cat-file: make remote-object-info allow-list dynamic
Date: Mon,  8 Jun 2026 12:14:35 +0200
Message-ID: <20260608-ps-eric-work-rebase-v12-12-5338b766e658@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The static allow-list in expand_atom() is hardcoded to only allow
"objectname" and "objectsize" for remote queries. This works because
up to this point all servers will either support object-info with name
and size or they do not support them at all, but we cannot expect that
in a future different servers with different git versions to have the
same object-info capabilities. Therefore, the allow_list needs to be
dynamic depending on what does the server advertise.

The client will now:

1. Request the protocol option that the placeholder refers to (i.e.
   "size" when "%(objectsize)").

2. Filters the request in fetch_object_info() dropping any option that
   the server does not advertise.

3. After the fetching, the options that haven't been dropped are the ones
   fetched and supported by the server, these supported options are
   mapped and remote_allowed_atoms is populated with the placeholders.

4. expand_atom() checks remote_allowed_atoms with the same behaviour as
   the static allow_list had.

Move object_info_options out of get_remote_info so the caller which has
data can select what options will be requested instead of requesting
always size.
Move batch_object_write() out so there will always be an output even if
all the placeholders are not supported by the server (returns an empty
line).

Include "type" in the object_info_options so once the server supports
it, the clients know already how to request it.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c  | 85 ++++++++++++++++++++++++++++++++---------------------
 fetch-object-info.c |  6 ++++
 2 files changed, 58 insertions(+), 33 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1166a046b4..055991b5af 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -341,13 +341,10 @@ struct expand_data {
 	 * Flags about when an object info is being fetched from remote.
 	 */
 	unsigned is_remote:1;
-};
-#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD }
 
-static const char *remote_object_info_atoms[] = {
-	"objectname",
-	"objectsize",
+	struct string_list remote_allowed_atoms;
 };
+#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD, .remote_allowed_atoms = STRING_LIST_INIT_NODUP }
 
 static int is_atom(const char *atom, const char *s, int slen)
 {
@@ -359,17 +356,11 @@ static int expand_atom(struct strbuf *sb, const char *atom, int len,
 		       struct expand_data *data)
 {
 	if (data->is_remote) {
-		size_t i, allowed_nr = ARRAY_SIZE(remote_object_info_atoms);
-		for (i = 0; i < allowed_nr; i++)
-			if (is_atom(remote_object_info_atoms[i], atom, len))
+		size_t i;
+		for (i = 0; i < data->remote_allowed_atoms.nr; i++)
+			if (is_atom(data->remote_allowed_atoms.items[i].string, atom, len))
 				break;
-
-		/*
-		 * On remote, skip unsupported atoms returning an empty sb,
-		 * honoring how for-each-ref handles known but inapplicable
-		 * atoms (e.g. %(tagger)).
-		 */
-		if (i == allowed_nr)
+		if (i == data->remote_allowed_atoms.nr)
 			return 1;
 	}
 
@@ -686,12 +677,12 @@ static int get_remote_info(struct batch_options *opt,
 			   int argc,
 			   const char **argv,
 			   struct object_info **remote_object_info,
-			   struct oid_array *object_info_oids)
+			   struct oid_array *object_info_oids,
+			   struct string_list *object_info_options)
 {
 	int retval = 0;
 	struct remote *remote = NULL;
 	struct object_id oid;
-	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
 	static struct transport *gtransport;
 
 	/*
@@ -726,15 +717,12 @@ static int get_remote_info(struct batch_options *opt,
 	gtransport->smart_options->object_info = 1;
 	gtransport->smart_options->object_info_oids = object_info_oids;
 
-	string_list_append(&object_info_options, "size");
-
-	if (object_info_options.nr > 0) {
-		gtransport->smart_options->object_info_options = &object_info_options;
+	if (object_info_options->nr > 0) {
+		gtransport->smart_options->object_info_options = object_info_options;
 		gtransport->smart_options->object_info_data = *remote_object_info;
 		retval = transport_fetch_refs(gtransport, NULL);
 	}
 cleanup:
-	string_list_clear(&object_info_options, 0);
 	transport_disconnect(gtransport);
 	return retval;
 }
@@ -820,6 +808,21 @@ static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
 		load_mailmap();
 }
 
+struct protocol_placeholder_entry {
+	const char *option;
+	const char *atom;
+};
+
+static const struct protocol_placeholder_entry remote_atom_map[] = {
+	{"size", "objectsize"},
+	{"type", "objecttype"},
+	/*
+	 * Add new protocol options here. Even if the server doesn't support
+	 * them the allow_list will drop them if the server doesn't advertise
+	 * them.
+	 */
+};
+
 static void parse_cmd_remote_object_info(struct batch_options *opt,
 					 const char *line, struct strbuf *output,
 					 struct expand_data *data)
@@ -829,6 +832,7 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	char *line_to_split;
 	static struct object_info *remote_object_info;
 	static struct oid_array object_info_oids = OID_ARRAY_INIT;
+	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
 
 	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
 		die(_("remote-object-info command too long"));
@@ -841,30 +845,44 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		die(_("remote-object-info supports at most %d objects"),
 		    MAX_ALLOWED_OBJ_LIMIT);
 
+	if (data->info.sizep)
+		string_list_append(&object_info_options, "size");
+	if (data->info.typep)
+		string_list_append(&object_info_options, "type");
+
 	if (get_remote_info(opt, count, argv, &remote_object_info,
-			    &object_info_oids))
+			    &object_info_oids, &object_info_options))
 		goto cleanup;
 
+	string_list_clear(&data->remote_allowed_atoms, 0);
+	string_list_append(&data->remote_allowed_atoms, "objectname");
+	for (size_t i = 0; i < ARRAY_SIZE(remote_atom_map); i++)
+		if (unsorted_string_list_has_string(&object_info_options, remote_atom_map[i].option))
+			string_list_append(&data->remote_allowed_atoms,
+					   remote_atom_map[i].atom);
+
 	data->skip_object_info = 1;
 	for (size_t i = 0; i < object_info_oids.nr; i++) {
 		data->oid = object_info_oids.oid[i];
-		if (remote_object_info[i].sizep) {
-			/*
-			 * When reaching here, it means remote-object-info can retrieve
-			 * information from server without downloading them.
-			 */
+		/*
+		 * When reaching here, it means remote-object-info can retrieve
+		 * information from server without downloading them.
+		 */
+		if (remote_object_info[i].sizep)
 			data->size = *remote_object_info[i].sizep;
-			opt->batch_mode = BATCH_MODE_INFO;
-			data->is_remote = 1;
-			batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
-			data->is_remote = 0;
-		}
+		if (remote_object_info[i].typep)
+			data->type = *remote_object_info[i].typep;
+		opt->batch_mode = BATCH_MODE_INFO;
+		data->is_remote = 1;
+		batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
+		data->is_remote = 0;
 	}
 	data->skip_object_info = 0;
 
 cleanup:
 	for (size_t i = 0; i < object_info_oids.nr; i++)
 		free_object_info_contents(&remote_object_info[i]);
+	string_list_clear(&object_info_options, 0);
 	free(line_to_split);
 	free(argv);
 	free(remote_object_info);
@@ -1177,6 +1195,7 @@ static int batch_objects(struct batch_options *opt)
  cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
+	string_list_clear(&data.remote_allowed_atoms, 0);
 	warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
diff --git a/fetch-object-info.c b/fetch-object-info.c
index 51a898430d..425929a269 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -39,6 +39,12 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 	case protocol_v2:
 		if (!server_supports_v2("object-info"))
 			die(_("object-info capability is not enabled on the server"));
+
+		for (int i = args->object_info_options->nr - 1; i >= 0; i--)
+			if (!server_supports_feature("object-info",
+						     args->object_info_options->items[i].string, 0))
+				unsorted_string_list_delete_item(args->object_info_options, i, 0);
+
 		send_object_info_request(fd_out, args);
 		break;
 	case protocol_v1:

-- 
2.54.0
