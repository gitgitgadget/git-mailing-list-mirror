Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1053D093E
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029534; cv=none; b=hxp03vhFTXggMlhm5NPUY5oSSQaeTiMPumRgJ2zWfAjMBkkYdu7WeYxM/OFbuGkZGgv/G5CdAiWXEgdL62e9WMMNAHms5PGmHRi7du3nAH9jGo3HRhO5I1JKnItZQpJ/Wz/uC+wTafflBYByDhjy8VwExuqBJtu6Ol9L9bpE/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029534; c=relaxed/simple;
	bh=JvaQj1uFRaTZl+6UvqZshcs+mgQm//sRsolSGxDnDJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvE9adVQCVD6018hOrO5G84Z3CiXoJZ9gqg5gEcDRYSLz2S2ytT8WPNSI0mYVlC/XMnQ8QRsol5ozr7rjHMfSn0mRAADHjcNLn7gf4jjnG7cAo5TGj67I3oogbnYmOYIqI29UGnUXA9qgb03I1mTU1PFNfcdCsHCL5sWwis/MdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3BKjyw2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3BKjyw2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493e4ccccc2so26979645e9.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029529; x=1784634329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rHVeM1sG5T4MS+soGxSzkjdEun3Cf6DS9NBE0mKywYc=;
        b=G3BKjyw2DXUI26oW8hu2f2rDl2GGPg52lLEl/wheLGPxKazQjVz0ps8jQxxszxC6BV
         3WAdTTzuh4lhNr5EoV5EpRLuNl6d174M00WMdyT/mQU6T/tdpytOpHMjASus+scJl2XX
         2vyCS3rTaXPl5V40uZMvmL6cAI4A+IrVb+IXJ5oYpG7mYhKZYwQaPypKXGap7HdWhzWb
         FiM2NcWwo4H2FF824B+e6R0iASkNf/jvduYl1E0gZc0I1wf4Cl70NyNqPez+wjEzisXo
         NwuHoidvEsIGYxl7jEGZkoJh2cXFPf0ikOTbsz3MbFCnTQgDKZifqgmrYIEYXmrBAY0S
         QKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029529; x=1784634329;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rHVeM1sG5T4MS+soGxSzkjdEun3Cf6DS9NBE0mKywYc=;
        b=F4Ts13Rac9A/nQTOkzEM3QMlxejZLjaE+saHsQLjZDBpTFgfdZTJS2EwdTD+o4n0hu
         ChwpUcPwIT+d8PtJ/OIpsyt5Mz4SClCn7j9+tucTP6qaI+/A/biZkshGN6VyXDnVB+PJ
         nP+rdbV8NWI+oT/7Aa5RDPMXmavaIyo7YidIfuLAKyyWTCuueI06f9YKhJWAxL6+SQsn
         IStE7bkxrTLm6c/QgUWgAbsNTZ6zME7HVQr7jKWDgs1p9Cv6PavId06y4oIdJmgow5Ql
         oBb71bPd0d+pIt9TAVqYdxzaackq25/w+hMtw1/mzEBhTHIx5sdMb47Q4v5q9tLZo2Al
         3Xww==
X-Forwarded-Encrypted: i=1; AHgh+Rr7I/cJgJTZl2SzxLhJ5xr/mjrQvYe2IayY/RtyJs4xA/wVseAt1JSV2+j9bktwLSZ8MJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzchKDi4sq8qxsc9hW2Rcx2Il3x7EIKcjyz4vKwgv0Vkt5dxmXX
	b59dWvv0BE3YihpAk/r80DM5/tuP45fo5U1QtzwXzGRArAOwogAwbKtX
X-Gm-Gg: AfdE7cl4GMAABm7lmIgN3T2wBoFvJVnuyPnDpqhT06Y2bh/5xYwZElwerZzYtotgf/a
	+mHGPvY7peQPyAweZtjuk2KXO1fPghMHEH5rZJs3vwbAZX1Arl+1t6ktbMIxVutH+ACg76I/s6P
	ZpiWOq99N0DJzXR82RyrD66XH734wwN7Tt7bM5pw52OpZM0AENwMOJ3F/AtPo1+j2APWyxzT79w
	z+AndMZkTIy/gwHg3HEyUnMvLqQhyv0UGOQ8JnHsgN0XJsQ2a6kpbGGEzqsgc/UEdTHhcJHFPtn
	5k9ePn2xti8xMOvb8zk+R81aSDx5D7Mz0EAYRI0A8yn7zJ2bfanPf6x2py/oJJD0z9G184+sUBf
	S/BueC+6ju00XUsbyr621gZEJgnhjg+7Kg9r3ypWsKe7pItFvRjTWl3+bO7JDEepWrEqbRuCuUv
	5gWiyKCWVr8CjkmeNSMAcL3Vu4wt3dec5wsiizHNXg2go5yf9N83yTDBP6j4k0L1xnTtxpfQOQb
	aHe6oxVw+QkKtM3NBodDKCtfh0liJiSk17g8EraPawS+Zlg2B096rR7FJWOWBmNOiiI+EsHAQIR
	AqlTSnUQLVXOfn9L8RrACBzXrp0MwkDY60T4Q8UFA7Y/rcnFLuowvWVJ4z2Kw9osc2GZb5LXfKV
	ek/Wi/K2pAQ==
X-Received: by 2002:a05:600c:3f07:b0:493:c453:600f with SMTP id 5b1f17b1804b1-495389929cdmr21578045e9.6.1784029529193;
        Tue, 14 Jul 2026 04:45:29 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm179791355e9.2.2026.07.14.04.45.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 04:45:28 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v17 13/13] cat-file: make remote-object-info allow-list dynamic
Date: Tue, 14 Jul 2026 13:45:09 +0200
Message-ID: <20260714-ps-eric-work-rebase-v17-13-afabfc83260e@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
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
