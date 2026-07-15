Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB52931C8
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109167; cv=none; b=KhZ4mL+6kcdsL9sXCY3uyyZGBext/trOlzVwFWBrgZsa0/xRs/ssUgoi6+JNx00sOUFN1kWEVv1sxt4YqJ8V1Neih77PR4nK6F9GF8BdlrXWPhnRg4BnPv7Xg0IfqX40MyyFFjZe10K83z7bW686NhNPcyZf/aleOOLQrxJqwkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109167; c=relaxed/simple;
	bh=xK8V6Xq4ExkQN+leSC3GqcmWQ3oSwueEqNFrXTS7Y+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvLWbSJOINZ37Jwgz4jrgbspybc8MB0yOH378sNXNRrzSeWlJyj5Rs0oNsMRtDrzPrG7lNpBsJmU+mvAV8r66tkQuxfTfEYXTI7wEwTKdapkk1c4F9z04fHlZhcDwl6nNptPfqLz0dREpjGTM1qVwYZVsMvGGTrEv1Z+ehQKs8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyUSO/W7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyUSO/W7"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f36a122fdso2063025f8f.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784109164; x=1784713964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X6KHlCfCma1xg6Wk/EIQI8lfwCDRHTGMgvClYMOmi1s=;
        b=cyUSO/W7jot7nFUjCDOT9Lw0mmeNmhjbPJ6P/E6oKL3KXk5IGne0SoTu65LqLrfFF/
         YvvWLwC9Vkhs+LFJs3orVk5eOJbrkXRqR9rk/tCYjBGumKrW+QbUc/l8JCqm2QFBmqLG
         iowPbEPkLYBfgQ0gwKw6FQQz2MkDiSW+uiIbZG0vk8CusWMLWbxrfdMUK4xxzrD10rVm
         1J9AYZ/syBcMn+pM1MCUTmFg1mDks2dBXzNX7nPZgTkfq+qm7EJ74l7I4whd1/akXmEs
         MNHWNhQtufMnAQNMHdMP3cuGa5BW864g5sr199oDrF20Pd+r/fKhuRQW0ZGWR9uh2vdM
         BGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109164; x=1784713964;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X6KHlCfCma1xg6Wk/EIQI8lfwCDRHTGMgvClYMOmi1s=;
        b=CEQZ54Vkp4nLrEudneK5UL9mMl9Hk0LLWmFzjrqFs37ZNLiI2x69+tqtMWotf0uGWp
         D+sfbpdHIKTMNS8VggEFdtyzSCLrkyYpDKQ58e3MJF1zBDuLbWdfCwip9J9wVlyDx5Rp
         k6M25bT9un9RvpC7BW/HlWsQJPD0FyLXS3oOYNZevoW8Abv6xWE/Zl/bGpW2MwtE7H5+
         r5GM2rR/VioCeBcwhdU6x84blxkiby4UEIQKH4p+Ye/GqelZple4m5DzYyN13wQ0IrVe
         aPIxhHak/WNSCye6GBESgHa46s0NX86+c5Utw23PFzvhnEvcTxyBUbcma5kFvEgUKoBv
         krHg==
X-Gm-Message-State: AOJu0YwxLY2xEp9VVFre+8U2ZFRfQY1SG1kY+j3qkOwQaXd1ZIqRBQ4p
	xZ9hIOeNvdkVYaVO+ig1vVMlHIprmkr560s8cu0KWoAUUMAjRgFZd25alv/GCKeK
X-Gm-Gg: AfdE7cke87eSeRSpG59XqfBGDgd1yPxQPxKWXGO07NLvjeptbPoH4WymC3XIw+BJxH5
	KL8fsLOTkLyptqm9SFERQ5Ua/szpumhFE3X45Jocg+HT1IJouoJRqrst90IaZudFeQzCzaQAY/x
	sz+UsLVx7b85at5JNdlKkpnYaNIRmz561FOeH21BC5z68P4S6yBi6d/r5Ouc4pmFsSyi5NSfI8b
	QZb+UL6IC4ohZYSCdx0JmieRnSYDJKUsMCAMYOxkhi49O40ODWpmHw5ACNiO53ENJ7ryMrNm8r7
	K1I4EJ+1ayqhPK6Jro1wTGbNMhVmtSYHnMF0FJMWaLjmnuuWS5eqrzQUY1tKKSxiKR6GEp1rsdD
	7Pa5oKuv7sxehM4Elc67NA3yxdFobeVcR8Y5Bzkt/HJjLUiKo8jfFA48SzOUKPxBWocEGn69CUi
	JKrqTFL9f8FOHR07PfIAanEIRN8MdbtUfy5t40KENTdoD1RrTG7HeFRRmh08m6di5UA7w7SvpaC
	9DJ+bzDObrxqhKFg7xpp4cT0Sv+nkg32nzovhU6HnQNHSmnaRavjOlC+M4XrlcpU6xUqL7HpBKC
	eLzvKszZ9N5TnOEJ43RX+pHZbpvWH0K9vX6hT2j+S6VH2WWWTIMH+U5PPVuYP4e9XFolx3oX6vh
	9nhctTZ5r0g==
X-Received: by 2002:a05:6000:719:b0:475:f100:35f4 with SMTP id ffacd0b85a97d-47f2dd37a6fmr19823892f8f.49.1784109163551;
        Wed, 15 Jul 2026 02:52:43 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm15630419f8f.35.2026.07.15.02.52.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 02:52:43 -0700 (PDT)
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
Subject: [PATCH GSoC v18 13/13] cat-file: make remote-object-info allow-list dynamic
Date: Wed, 15 Jul 2026 11:52:21 +0200
Message-ID: <20260715-ps-eric-work-rebase-v18-13-34d7adb051bb@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
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
index 5f98840c7c..160c29507a 100644
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
