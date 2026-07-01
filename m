Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F42E480DEC
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908349; cv=none; b=lkPRzMHfV2yLhLUwEWwaCt9d8JTGwjtWjrvfCvyBTmH/PUsWQeV3ar3d7Pv9d7XUevHJSk/KMNncRqi3cSkdKpmn/ofDOZe0waQzNYXjH6z/VbblM3iRXhvneQlZfdw1lHZXX+7pFtkzFeGSVR6VYFNQHs7nsvgkIYn2N2Gv5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908349; c=relaxed/simple;
	bh=zY3vBr9Xi4tP9rPUaWqgt4/oKbWKVGIuqzXbbnlP6QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOiEpLCnhTsL9fcoDEsfqJGczGc13Ct/+tx6Td++m+qxZ4Y2690j0v5JUk1IvdYviffB3mK6EWM/jM50b1SeX3QZ5Yr+LuDwecGIFx7pH5GpVZEo1SCN/tz4Wf/GU5viaFpmVs8keEXeWOsSvwtYrsAoFuJQa4Gm7oUjBkI1NAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx3lp7Gm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx3lp7Gm"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-474560436c3so576561f8f.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908346; x=1783513146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg5iOORpXoGe4MrrhM9j6d2e9L0SkqbVGzBE89GVK3c=;
        b=Sx3lp7GmXGORlnX7zsM66NWxjkTLLQVlSKuaAKA6ZqPZsnB3GCtjl1sCIN9dcWnZZS
         +EKuTnTpjOppaj8HxkkCCZ5k1N36Mc/XoD1imIBW9/ZG10yE0M/09WM49J3u0tn5VtKW
         XlYcJ4uVzFfWy5MQ70Yo4hIN2Pqazm1dB7Th1/3HfHK9bECs7HVHDB46F1YjTSX8ptl2
         Zm0iYA9IQxgtTnADBcFrPwxJ+yMC9g/VpRP0QlWresyH4NVL/uIhHRoiwPrKPkOurieR
         /5YrFYzK83RoEPUVGRetR+HSifTvOLJLCHFP5HjkTcuF97nYVhKeZAVbGgPMbngSxh7i
         dFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908346; x=1783513146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rg5iOORpXoGe4MrrhM9j6d2e9L0SkqbVGzBE89GVK3c=;
        b=e2clUAktnQ75ygM6O+qeUn7++ke4PvGIB/0Oxr+PSEOcwLFqULuuQl48aeW79dN5c3
         54DLr1S3mmr8ZVEObcH1MSrhX60axa4s1KdyWoq4ABgpxlDDILIHGrQ0MyhrAHliOvWJ
         AXrERyK/nUp1ppB+VLNPbGh45j6GpLkeTQCvAK+zM0hH+MwrylZg6tvr6CUH7b19XPd0
         CLUDy6hLTXeAmcfsgdg5VHnSsXwyu7HbDuThV3NBdu7due9Ary/yI5zqFAxqu8umPyk/
         wcaTLW8g/8Gz+3PwJGfS7upMKqYN+LBtafsbfGFwvUsvlBhmoyzb1rLQJzSMvkjXrQ4L
         g7IQ==
X-Gm-Message-State: AOJu0Yzhi42n43ibPn8+kZzm9h8Bm+wZOVCaiBl3Q0ZYCkBA6C8tdvgZ
	kplCWfKE4lEIq8H2kgBiJRYGgczt2JF2HlFVY9aa0UNNENt1oobtZ1Gm23PrPcKB
X-Gm-Gg: AfdE7ckOBaSW6tJQWsMgfQJUEXT3Mmo99smQWwxMTulhaYw8xHRZJbhUzoa6snxnGXQ
	k9zRCbavNUHsORUXOkyAhsjkiM6ZFUrR8DwMpdZ1uhfqg+py7piHA5IjZtDejgmx4YKjxTf3JkZ
	+1Y8iH9h6P1igbp69dh5A78MSoc/0VbtgcyhwqQJwNYd5zyok9ekwYkp/HTzjRCGJj2DmENBSvy
	bekuCUUmolKWdoidVc0l/27B0osjIqVwZeVB5gPP3GsdO0HvYrEcqTOu615Squ14CRxXOGuEfZj
	hsiFEKELyNozMOrW45nJjwruyB8GRtLAV5UjDua68VeRVU7hDp3Xy9/wnIMZ8eTToTb1MO9QzpG
	7k8xH4LvPzWUWBzywLsioPzsmJIhcMok23+iCj38p36LfqYVL/6V1xIG6BMnRpseYM1u9sK3slM
	PIIQRXa87LJLYOP+QxocHm2bkVMGDWb2uDX9Hma+ujf6TBfbDUIE2N7eyaHnXfjUOq6oauT+MAA
	+TxNB1RwwOkq/635grZN1bcvYXTP06WQMxEFXtRL8rCk8ccTw1JtsL/LuVxhje2IhT6EQsIWbXY
	xCVEy9ZZxHSlkirrA60fjesHaAKXhMMrk+OS1BUqOtr3pwZW5oJyCQvmxyFUNWgWxrS2TN0AT5q
	Rc2MPUaJvrg==
X-Received: by 2002:a05:600c:a4b:b0:493:bef8:ba8 with SMTP id 5b1f17b1804b1-493c3dfc635mr4540505e9.39.1782908346389;
        Wed, 01 Jul 2026 05:19:06 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm68267235e9.9.2026.07.01.05.19.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:19:05 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v15 13/13] cat-file: make remote-object-info allow-list dynamic
Date: Wed,  1 Jul 2026 14:18:47 +0200
Message-ID: <20260701-ps-eric-work-rebase-v15-13-c88a43b63917@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
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
dynamic depending on what the server advertises.

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
 builtin/cat-file.c  | 97 +++++++++++++++++++++++++++++++++++------------------
 fetch-object-info.c | 20 +++++++++++
 2 files changed, 84 insertions(+), 33 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index eb7c5ba489..eee8cbb7c9 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -338,13 +338,11 @@ struct expand_data {
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
+#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD, \
+			    .remote_allowed_atoms = STRING_LIST_INIT_NODUP }
 
 static int is_atom(const char *atom, const char *s, int slen)
 {
@@ -356,17 +354,11 @@ static int expand_atom(struct strbuf *sb, const char *atom, int len,
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
 
@@ -680,12 +672,12 @@ static int get_remote_info(struct batch_options *opt,
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
 	struct transport *gtransport;
 
 	/*
@@ -733,15 +725,12 @@ static int get_remote_info(struct batch_options *opt,
 	CALLOC_ARRAY(*remote_object_info, object_info_oids->nr);
 	gtransport->smart_options->object_info_oids = object_info_oids;
 
-	string_list_append(&object_info_options, "size");
-
-	if (object_info_options.nr > 0) {
-		gtransport->smart_options->object_info_options = &object_info_options;
+	if (object_info_options->nr > 0) {
+		gtransport->smart_options->object_info_options = object_info_options;
 		gtransport->smart_options->object_info_data = *remote_object_info;
 		retval = transport_fetch_object_info(gtransport);
 	}
 cleanup:
-	string_list_clear(&object_info_options, 0);
 	transport_disconnect(gtransport);
 	return retval;
 }
@@ -827,6 +816,21 @@ static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
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
@@ -836,6 +840,7 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	char *line_to_split;
 	struct object_info *remote_object_info = NULL;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
+	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
 
 	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
 		die(_("remote-object-info command too long"));
@@ -848,32 +853,57 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
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
+		int found = 0;
 		data->oid = object_info_oids.oid[i];
+		/*
+		 * When reaching here, it means remote-object-info can retrieve
+		 * information from server without downloading them.
+		 */
 		if (remote_object_info[i].sizep) {
-			/*
-			 * When reaching here, it means remote-object-info can retrieve
-			 * information from server without downloading them.
-			 */
 			data->size = *remote_object_info[i].sizep;
-			opt->batch_mode = BATCH_MODE_INFO;
-			data->is_remote = 1;
-			batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
-			data->is_remote = 0;
-		} else {
-			report_object_status(opt, oid_to_hex(&data->oid), &data->oid, "missing");
+			found = 1;
 		}
+
+		if (remote_object_info[i].typep) {
+			data->type = *remote_object_info[i].typep;
+			found = 1;
+		}
+
+		if (!found && object_info_options.nr > 0) {
+			report_object_status(opt, oid_to_hex(&data->oid),
+					     &data->oid, "missing");
+			continue;
+		}
+
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
@@ -1189,6 +1219,7 @@ static int batch_objects(struct batch_options *opt)
  cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
+	string_list_clear(&data.remote_allowed_atoms, 0);
 	cfg->warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
diff --git a/fetch-object-info.c b/fetch-object-info.c
index 03cfb70338..e968341676 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -41,6 +41,26 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 	case protocol_v2:
 		if (!server_supports_v2("object-info"))
 			die(_("object-info capability is not enabled on the server"));
+		/*
+		 * When removing an element from the list it gets swapped by the
+		 * last element, iterate backwards to prevent elements skipping
+		 * evaluation.
+		 *
+		 * object_info_options->nr can be safely casted without overflow
+		 * beacuse the number of options is a small known number (the
+		 * supported placeholders which currently are size and type).
+		 */
+		for (int i = (int)args->object_info_options->nr - 1; i >= 0; i--)
+			if (!server_supports_feature("object-info",
+						     args->object_info_options->items[i].string, 0))
+				unsorted_string_list_delete_item(args->object_info_options, i, 0);
+		/*
+		 * If no options are left after the filtering, avoid unnecessary
+		 * request to the server.
+		 */
+		if (!args->object_info_options->nr)
+			return 0;
+
 		send_object_info_request(fd_out, args);
 		break;
 	case protocol_v1:

-- 
2.54.0
