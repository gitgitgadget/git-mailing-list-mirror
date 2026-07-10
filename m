Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD3D43B3FA
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701712; cv=none; b=VUmpHI6mZm5ksfgOijwrdxEx+AADxmncd/llCIJsQjBRzCpavKDpxuePdeIRh7nzHYImLrTCq69fIaRBDQudREm3XzL28WY8ccbgwwvmIbzjQus8678/klFLNiXFEiRevM4fbk9Z8UKmTIxp3vad59VXatzabQaSvyLY+oOb0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701712; c=relaxed/simple;
	bh=JvaQj1uFRaTZl+6UvqZshcs+mgQm//sRsolSGxDnDJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twRXGEjFqs4/PPLmxIpRkmdM2Om8C+Kk7O/r+Tg0Qmj5rYQTwfjDoM1l3I6y0BfChxxHLUyw44un8jwSyheDoaxSAK1rdvmAhnn/W//gYMBcGaIYyeZaLolmjbYoAsG3UiiaZ3GKA8ZKhTINs6zDDhSXnJW+CUfY4JUwyL7moik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNNqX+8N; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNNqX+8N"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso1103109f8f.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701699; x=1784306499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rHVeM1sG5T4MS+soGxSzkjdEun3Cf6DS9NBE0mKywYc=;
        b=eNNqX+8NtV7le6NMOqQ8iFwm15Gr4l2K693dBRnXedMbRhafldAlUr7bcgoUKQR+mI
         gTSqjgB53QN8x9GoeNxViBQF4CfWsDwTTK4hKGVWyIzOYzEOvmJIs1LpMGsGR6DkaHBN
         w8S5YHu4+v0we0uBvCO19q6a58tjNsygjEzC5BqpkVCoel244/I5ex63z3jSaqczBJsk
         w7teOEPTReHwwY++mJwQ8oDlWzhrUxDqcdXTjI8x/jTnCsLJ+xFi7s4iy6tWQUzKhPv6
         Wx7NE+kEuhzIuPzTUkcY8HiFubrfZof+fvQiTrJPzC48oJgcsB5WlpFVPPAUwZbd64rZ
         Npdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701699; x=1784306499;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rHVeM1sG5T4MS+soGxSzkjdEun3Cf6DS9NBE0mKywYc=;
        b=ArUnAyb7LMRF3Po/Mr3w2J5I1aFFM53dZkBo+PcHMCTUgjR9ydIwdo1fSmoc/+RnII
         UBpfYZYHCIoJSG4wgXZZvJ/QLSqE43fgyD2sh7npOgw44lRLmbvEf/AA9PmVUZFYpXXo
         G50BFuJrjD9X633FcDHEmfe1vmBwXYVOTG7RiCY4c1S/JwUPPseat6HjpnKr4mjDU3Cl
         WIJ4YEgssud4svzLraltg4RNfZ5ey0ARJVhum0XMi4tQ+DDbhbhLc5ZjvhRYT9U9Vk0m
         gsPrEQi6Y96XDEj+StywMIog2M7qZ/GxbplMDkST7iP/3HlOr/lerL0Wms5Yv9Gew5KG
         SxGg==
X-Gm-Message-State: AOJu0YykHrc6wzrHyT3B4mpZmjdf9CGGvDngHaiZLzXSZ0YFoDj+e7zm
	AWAbvN56djlEh3YdzL4Sk5F45RmFTRLmwySMWdgSX9gODyDPqcfo0feB8glrLyai
X-Gm-Gg: AfdE7cnhp0dH3TU/E5vsJtL9FokPRUslvOT9G4xARjwqvPB5pZexSsYqBqMTtL3ZrFQ
	vTxGLfjkebXx7ZtAIQbKBvK7LFGUVs4+1eS/9Dh/hLsUAae7jFzSQbl+XexIBgYQZxirQwV8z71
	E4zIn3PS+doSYMDFP5mQ36YEbcYCRLgEP9AdLKYAW/csLmbLhTyiuT+1wzpVrF/mHjo3Nq/TcWh
	0mophnLD7QGFOy/MjH4uflQrhbRkDW7B0tL/eKlAacKCFMGq8os6/36NPiyNl0lQrcWsFYVP1I9
	WjI8SrDv/a8+Yi96I6Kkvd2uOh/UajddMkk2Jkb7c0QruiboN5hWASCn9PV5/HeutrJJSMrpq3B
	1oYU6Ij2CvszST29jEbzRQji3cprzmp+PnsXJxQGD7Z1T1AQA+tkaBxXbzAgKcFMx1tjfhubd56
	0L2iC4plOLgRu62wKxflA4JvlroHiEyHqkYzW1WiFuB3SM2DYBASacDfmjs5ykJf5oI7zcJevnz
	ckbBHFGajvCN4TnGHFz35CfBtK16LSdxUtXJK8el1rlqb9LX30gBVr0CXj60vb394TvepDrAgf+
	bqspg+WvzXj7aCgBrjxVoA5cGJus/jizWOnKafUwk6G8t0TMflJfnyKiR7J/6ieW4phkgDgHgdx
	izHISSFKZt3G6Yuti4HDF
X-Received: by 2002:a05:6000:2508:b0:47d:e00a:c2c with SMTP id ffacd0b85a97d-47df07554d2mr13625382f8f.23.1783701698401;
        Fri, 10 Jul 2026 09:41:38 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm63643639f8f.2.2026.07.10.09.41.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 09:41:37 -0700 (PDT)
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
Subject: [PATCH GSoC v16 13/13] cat-file: make remote-object-info allow-list dynamic
Date: Fri, 10 Jul 2026 18:41:19 +0200
Message-ID: <20260710-ps-eric-work-rebase-v16-13-66e07b58a8fe@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
References: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
 <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
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
index af388b6238..20d9705a7f 100644
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
 
@@ -683,12 +675,12 @@ static int get_remote_info(struct batch_options *opt,
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
@@ -736,15 +728,12 @@ static int get_remote_info(struct batch_options *opt,
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
@@ -830,6 +819,21 @@ static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
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
@@ -839,6 +843,7 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	char *line_to_split;
 	struct object_info *remote_object_info = NULL;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
+	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
 
 	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
 		die(_("remote-object-info command too long"));
@@ -851,32 +856,57 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
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
@@ -1192,6 +1222,7 @@ static int batch_objects(struct batch_options *opt)
  cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
+	string_list_clear(&data.remote_allowed_atoms, 0);
 	cfg->warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
diff --git a/fetch-object-info.c b/fetch-object-info.c
index 91685cb355..e9b1011d07 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -55,6 +55,26 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
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
