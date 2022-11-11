Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34566C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 06:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiKKGuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 01:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiKKGuE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 01:50:04 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE7472982
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 22:50:02 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1CA2432008C0;
        Fri, 11 Nov 2022 01:50:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 11 Nov 2022 01:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668149401; x=1668235801; bh=Jj/ydwjw7k
        QnY1ggaO7wOSbplvDEsgF7N3C4AoYwBH8=; b=qUIzj+mPyoPFHD6d60+IUEXZ59
        NIpeAzLgXh+RoVaXgOGRqlyvRZm0Nw17cYlOu7GRhOn3FiJ5ULb+mc1xoRnnmi/j
        0Ry5STWnE9kQkND9rNksxSsTSB97FDk8Op5hfgmTlh8YdiDmzJ4Qw7hAz4iZpvxH
        NWtPZ5YJtZpna4ULhZoPdG2uyq1qyC/hAHZr0VYGat3lxRzzwwDOLd2Fhf1Uudzd
        XmIWSCCBlqbBFSPpqxmYF/YclIZVRgr/nkuUmZJdgNvocmHij/yXtWZVcpASTDNs
        YQ4HNjIx6srirGwk6IzD4wd4oVWdlfV334anhfT6EwD+fLKWKWSuomBZ4gOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668149401; x=1668235801; bh=Jj/ydwjw7kQnY1ggaO7wOSbplvDE
        sgF7N3C4AoYwBH8=; b=FWIZ8qtx3kLXmkvKY4euLBig3ySnh+6zyNN2JpRDaRPC
        HlTy77y+Ict8YHBz4fzY1b3vaqsG6wTn1bOg9ApY9mUjso4RHBK1sKuSoRUSpBAM
        FriudloBBJ+ILikcBqSmeFGj0OyaF+delwialK6RLxaz/Blm7bQLOIFGYPAjhZMK
        MLOAolPvmDEYSX6DXP4Uu6nOEQJaj/9upOx/gFDfg5s48S0PfkPpiZp7NFamhC2O
        gGqQ0/u0tuTaO1sp5Gkvj6aAa9k7ZogMf/cqC7buGY+oAuGDzFDWGd994DIMDiwJ
        ZfzAZklr7f+fVQ/GcbKfjSZAHmEVZrd1RFBFMsEk4Q==
X-ME-Sender: <xms:mfBtY0SESz0dY_XiAI54XTg2Ife3mt4zex7Rbhuwk5gTK17VLMdxlQ>
    <xme:mfBtYxyFoiCzKmpy6wsCClqVRhJ_eUaRzuKRBG4pK3PaMH4WEyikOkDxdLJgJrUe_
    15-qx_f9BgJIzTQCQ>
X-ME-Received: <xmr:mfBtYx0t-t1BXpiyJ6WBQjxvvcNIqdPCCxo8vMiF7BjNLoGVLjM15W5Oj47j-uvsp9PXVGXDNjJrfoNC2C3Rp9XTj71CYFPLk_DLKBPe-eXEog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeehgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:mfBtY4CvrEkqHLDEpI1koyooCyAxRqlaF3fcGz7HGesCtRnDfVs7dQ>
    <xmx:mfBtY9h9d4rP798FnjhKAk0F8MyHHTMq0-73Rs92xBxcTfKqrBSqJw>
    <xmx:mfBtY0pB9yPIBGn8sqwUlzaFJ32_GG3AjniavywZErDgYDEzAmezVQ>
    <xmx:mfBtYyvGxn-mLgjMJNlUNVgJD10ROemmQ1nL8OozYbqFpho19Fkoiw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Nov 2022 01:50:00 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 84b8696b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Nov 2022 06:49:58 +0000 (UTC)
Date:   Fri, 11 Nov 2022 07:49:58 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 2/7] refs: get rid of global list of hidden refs
Message-ID: <d8118c6dd8a97f923e629490061d883557a92861.1668149149.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668149149.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5u5eTKo7VqhyMmfM"
Content-Disposition: inline
In-Reply-To: <cover.1668149149.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5u5eTKo7VqhyMmfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to add a new argument to git-rev-list(1) that allows it to
add all references that are visible when taking `transfer.hideRefs` et
al into account. This will require us to potentially parse multiple sets
of hidden refs, which is not easily possible right now as there is only
a single, global instance of the list of parsed hidden refs.

Refactor `parse_hide_refs_config()` and `ref_is_hidden()` so that both
take the list of hidden references as input and adjust callers to keep a
local list, instead. This allows us to easily use multiple hidden-ref
lists. Furthermore, it allows us to properly free this list before we
exit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/receive-pack.c |  8 +++++---
 ls-refs.c              | 13 +++++++++----
 refs.c                 | 14 ++++----------
 refs.h                 |  5 +++--
 upload-pack.c          | 30 ++++++++++++++++++------------
 5 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 44bcea3a5b..1e24b31a0a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -80,6 +80,7 @@ static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
 static const char *push_cert_nonce;
 static const char *cert_nonce_seed;
+static struct string_list hidden_refs =3D STRING_LIST_INIT_DUP;
=20
 static const char *NONCE_UNSOLICITED =3D "UNSOLICITED";
 static const char *NONCE_BAD =3D "BAD";
@@ -130,7 +131,7 @@ static enum deny_action parse_deny_action(const char *v=
ar, const char *value)
=20
 static int receive_pack_config(const char *var, const char *value, void *c=
b)
 {
-	int status =3D parse_hide_refs_config(var, value, "receive");
+	int status =3D parse_hide_refs_config(var, value, "receive", &hidden_refs=
);
=20
 	if (status)
 		return status;
@@ -296,7 +297,7 @@ static int show_ref_cb(const char *path_full, const str=
uct object_id *oid,
 	struct oidset *seen =3D data;
 	const char *path =3D strip_namespace(path_full);
=20
-	if (ref_is_hidden(path, path_full))
+	if (ref_is_hidden(path, path_full, &hidden_refs))
 		return 0;
=20
 	/*
@@ -1794,7 +1795,7 @@ static void reject_updates_to_hidden(struct command *=
commands)
 		strbuf_setlen(&refname_full, prefix_len);
 		strbuf_addstr(&refname_full, cmd->ref_name);
=20
-		if (!ref_is_hidden(cmd->ref_name, refname_full.buf))
+		if (!ref_is_hidden(cmd->ref_name, refname_full.buf, &hidden_refs))
 			continue;
 		if (is_null_oid(&cmd->new_oid))
 			cmd->error_string =3D "deny deleting a hidden ref";
@@ -2591,6 +2592,7 @@ int cmd_receive_pack(int argc, const char **argv, con=
st char *prefix)
 		packet_flush(1);
 	oid_array_clear(&shallow);
 	oid_array_clear(&ref);
+	string_list_clear(&hidden_refs, 0);
 	free((void *)push_cert_nonce);
 	return 0;
 }
diff --git a/ls-refs.c b/ls-refs.c
index fa0d01b47c..fb6769742c 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -6,6 +6,7 @@
 #include "ls-refs.h"
 #include "pkt-line.h"
 #include "config.h"
+#include "string-list.h"
=20
 static int config_read;
 static int advertise_unborn;
@@ -73,6 +74,7 @@ struct ls_refs_data {
 	unsigned symrefs;
 	struct strvec prefixes;
 	struct strbuf buf;
+	struct string_list hidden_refs;
 	unsigned unborn : 1;
 };
=20
@@ -84,7 +86,7 @@ static int send_ref(const char *refname, const struct obj=
ect_id *oid,
=20
 	strbuf_reset(&data->buf);
=20
-	if (ref_is_hidden(refname_nons, refname))
+	if (ref_is_hidden(refname_nons, refname, &data->hidden_refs))
 		return 0;
=20
 	if (!ref_match(&data->prefixes, refname_nons))
@@ -137,14 +139,15 @@ static void send_possibly_unborn_head(struct ls_refs_=
data *data)
 }
=20
 static int ls_refs_config(const char *var, const char *value,
-			  void *data UNUSED)
+			  void *cb_data)
 {
+	struct ls_refs_data *data =3D cb_data;
 	/*
 	 * We only serve fetches over v2 for now, so respect only "uploadpack"
 	 * config. This may need to eventually be expanded to "receive", but we
 	 * don't yet know how that information will be passed to ls-refs.
 	 */
-	return parse_hide_refs_config(var, value, "uploadpack");
+	return parse_hide_refs_config(var, value, "uploadpack", &data->hidden_ref=
s);
 }
=20
 int ls_refs(struct repository *r, struct packet_reader *request)
@@ -154,9 +157,10 @@ int ls_refs(struct repository *r, struct packet_reader=
 *request)
 	memset(&data, 0, sizeof(data));
 	strvec_init(&data.prefixes);
 	strbuf_init(&data.buf, 0);
+	string_list_init_dup(&data.hidden_refs);
=20
 	ensure_config_read();
-	git_config(ls_refs_config, NULL);
+	git_config(ls_refs_config, &data);
=20
 	while (packet_reader_read(request) =3D=3D PACKET_READ_NORMAL) {
 		const char *arg =3D request->line;
@@ -195,6 +199,7 @@ int ls_refs(struct repository *r, struct packet_reader =
*request)
 	packet_fflush(stdout);
 	strvec_clear(&data.prefixes);
 	strbuf_release(&data.buf);
+	string_list_clear(&data.hidden_refs, 0);
 	return 0;
 }
=20
diff --git a/refs.c b/refs.c
index a4ab264d74..2c7e88b190 100644
--- a/refs.c
+++ b/refs.c
@@ -1414,9 +1414,8 @@ char *shorten_unambiguous_ref(const char *refname, in=
t strict)
 					    refname, strict);
 }
=20
-static struct string_list *hide_refs;
-
-int parse_hide_refs_config(const char *var, const char *value, const char =
*section)
+int parse_hide_refs_config(const char *var, const char *value, const char =
*section,
+			   struct string_list *hide_refs)
 {
 	const char *key;
 	if (!strcmp("transfer.hiderefs", var) ||
@@ -1431,21 +1430,16 @@ int parse_hide_refs_config(const char *var, const c=
har *value, const char *secti
 		len =3D strlen(ref);
 		while (len && ref[len - 1] =3D=3D '/')
 			ref[--len] =3D '\0';
-		if (!hide_refs) {
-			CALLOC_ARRAY(hide_refs, 1);
-			hide_refs->strdup_strings =3D 1;
-		}
 		string_list_append_nodup(hide_refs, ref);
 	}
 	return 0;
 }
=20
-int ref_is_hidden(const char *refname, const char *refname_full)
+int ref_is_hidden(const char *refname, const char *refname_full,
+		  const struct string_list *hide_refs)
 {
 	int i;
=20
-	if (!hide_refs)
-		return 0;
 	for (i =3D hide_refs->nr - 1; i >=3D 0; i--) {
 		const char *match =3D hide_refs->items[i].string;
 		const char *subject;
diff --git a/refs.h b/refs.h
index 8958717a17..3266fd8f57 100644
--- a/refs.h
+++ b/refs.h
@@ -808,7 +808,8 @@ int update_ref(const char *msg, const char *refname,
 	       const struct object_id *new_oid, const struct object_id *old_oid,
 	       unsigned int flags, enum action_on_err onerr);
=20
-int parse_hide_refs_config(const char *var, const char *value, const char =
*);
+int parse_hide_refs_config(const char *var, const char *value, const char =
*,
+			   struct string_list *);
=20
 /*
  * Check whether a ref is hidden. If no namespace is set, both the first a=
nd
@@ -818,7 +819,7 @@ int parse_hide_refs_config(const char *var, const char =
*value, const char *);
  * the ref is outside that namespace, the first parameter is NULL. The sec=
ond
  * parameter always points to the full ref name.
  */
-int ref_is_hidden(const char *, const char *);
+int ref_is_hidden(const char *, const char *, const struct string_list *);
=20
 /* Is this a per-worktree ref living in the refs/ namespace? */
 int is_per_worktree_ref(const char *refname);
diff --git a/upload-pack.c b/upload-pack.c
index 0b8311bd68..551f22ffa5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -62,6 +62,7 @@ struct upload_pack_data {
 	struct object_array have_obj;
 	struct oid_array haves;					/* v2 only */
 	struct string_list wanted_refs;				/* v2 only */
+	struct string_list hidden_refs;
=20
 	struct object_array shallows;
 	struct string_list deepen_not;
@@ -118,6 +119,7 @@ static void upload_pack_data_init(struct upload_pack_da=
ta *data)
 {
 	struct string_list symref =3D STRING_LIST_INIT_DUP;
 	struct string_list wanted_refs =3D STRING_LIST_INIT_DUP;
+	struct string_list hidden_refs =3D STRING_LIST_INIT_DUP;
 	struct object_array want_obj =3D OBJECT_ARRAY_INIT;
 	struct object_array have_obj =3D OBJECT_ARRAY_INIT;
 	struct oid_array haves =3D OID_ARRAY_INIT;
@@ -130,6 +132,7 @@ static void upload_pack_data_init(struct upload_pack_da=
ta *data)
 	memset(data, 0, sizeof(*data));
 	data->symref =3D symref;
 	data->wanted_refs =3D wanted_refs;
+	data->hidden_refs =3D hidden_refs;
 	data->want_obj =3D want_obj;
 	data->have_obj =3D have_obj;
 	data->haves =3D haves;
@@ -151,6 +154,7 @@ static void upload_pack_data_clear(struct upload_pack_d=
ata *data)
 {
 	string_list_clear(&data->symref, 1);
 	string_list_clear(&data->wanted_refs, 1);
+	string_list_clear(&data->hidden_refs, 0);
 	object_array_clear(&data->want_obj);
 	object_array_clear(&data->have_obj);
 	oid_array_clear(&data->haves);
@@ -842,8 +846,8 @@ static void deepen(struct upload_pack_data *data, int d=
epth)
 		 * Checking for reachable shallows requires that our refs be
 		 * marked with OUR_REF.
 		 */
-		head_ref_namespaced(check_ref, NULL);
-		for_each_namespaced_ref(check_ref, NULL);
+		head_ref_namespaced(check_ref, data);
+		for_each_namespaced_ref(check_ref, data);
=20
 		get_reachable_list(data, &reachable_shallows);
 		result =3D get_shallow_commits(&reachable_shallows,
@@ -1158,11 +1162,11 @@ static void receive_needs(struct upload_pack_data *=
data,
=20
 /* return non-zero if the ref is hidden, otherwise 0 */
 static int mark_our_ref(const char *refname, const char *refname_full,
-			const struct object_id *oid)
+			const struct object_id *oid, const struct string_list *hidden_refs)
 {
 	struct object *o =3D lookup_unknown_object(the_repository, oid);
=20
-	if (ref_is_hidden(refname, refname_full)) {
+	if (ref_is_hidden(refname, refname_full, hidden_refs)) {
 		o->flags |=3D HIDDEN_REF;
 		return 1;
 	}
@@ -1171,11 +1175,12 @@ static int mark_our_ref(const char *refname, const =
char *refname_full,
 }
=20
 static int check_ref(const char *refname_full, const struct object_id *oid,
-		     int flag UNUSED, void *cb_data UNUSED)
+		     int flag UNUSED, void *cb_data)
 {
 	const char *refname =3D strip_namespace(refname_full);
+	struct upload_pack_data *data =3D cb_data;
=20
-	mark_our_ref(refname, refname_full, oid);
+	mark_our_ref(refname, refname_full, oid, &data->hidden_refs);
 	return 0;
 }
=20
@@ -1204,7 +1209,7 @@ static int send_ref(const char *refname, const struct=
 object_id *oid,
 	struct object_id peeled;
 	struct upload_pack_data *data =3D cb_data;
=20
-	if (mark_our_ref(refname_nons, refname, oid))
+	if (mark_our_ref(refname_nons, refname, oid, &data->hidden_refs))
 		return 0;
=20
 	if (capabilities) {
@@ -1327,7 +1332,7 @@ static int upload_pack_config(const char *var, const =
char *value, void *cb_data)
 	if (parse_object_filter_config(var, value, data) < 0)
 		return -1;
=20
-	return parse_hide_refs_config(var, value, "uploadpack");
+	return parse_hide_refs_config(var, value, "uploadpack", &data->hidden_ref=
s);
 }
=20
 static int upload_pack_protected_config(const char *var, const char *value=
, void *cb_data)
@@ -1375,8 +1380,8 @@ void upload_pack(const int advertise_refs, const int =
stateless_rpc,
 		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {
-		head_ref_namespaced(check_ref, NULL);
-		for_each_namespaced_ref(check_ref, NULL);
+		head_ref_namespaced(check_ref, &data);
+		for_each_namespaced_ref(check_ref, &data);
 	}
=20
 	if (!advertise_refs) {
@@ -1441,6 +1446,7 @@ static int parse_want(struct packet_writer *writer, c=
onst char *line,
=20
 static int parse_want_ref(struct packet_writer *writer, const char *line,
 			  struct string_list *wanted_refs,
+			  struct string_list *hidden_refs,
 			  struct object_array *want_obj)
 {
 	const char *refname_nons;
@@ -1451,7 +1457,7 @@ static int parse_want_ref(struct packet_writer *write=
r, const char *line,
 		struct strbuf refname =3D STRBUF_INIT;
=20
 		strbuf_addf(&refname, "%s%s", get_git_namespace(), refname_nons);
-		if (ref_is_hidden(refname_nons, refname.buf) ||
+		if (ref_is_hidden(refname_nons, refname.buf, hidden_refs) ||
 		    read_ref(refname.buf, &oid)) {
 			packet_writer_error(writer, "unknown ref %s", refname_nons);
 			die("unknown ref %s", refname_nons);
@@ -1508,7 +1514,7 @@ static void process_args(struct packet_reader *reques=
t,
 			continue;
 		if (data->allow_ref_in_want &&
 		    parse_want_ref(&data->writer, arg, &data->wanted_refs,
-				   &data->want_obj))
+				   &data->hidden_refs, &data->want_obj))
 			continue;
 		/* process have line */
 		if (parse_have(arg, &data->haves))
--=20
2.38.1


--5u5eTKo7VqhyMmfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNt8JUACgkQVbJhu7ck
PpR0Dg//ablWcA04rdlnO/hzNUcJd+0szrjxiXdlQTftpOQW5J9sc63+DWy+hpBD
jE21TvU9ePgjBCgsa4QAa4EQ2+eERmm0tIvZ/BiknzcXHasQHXBbLK0tfRnOUJIH
9lAxwrf3zJmbLUk4LTVXnitKWALCzQhQC2jx3D/lgIvYj7lrfSwr0Atla9SusMyU
wEkz9z9rF0vZvum6/6eQvMgUtjyaeLZ5owkMs6IYNq6OZR1Oepxkq+PYfFQ2/3pg
2DzRGqFQ9IKgNIT5SEHMmG6JhU+8Her+91cPklh2hJRErTfRJukXIDDR740m2rK5
twn77Kz2u8aXQQ3peSNI5pRugFAN7yMe0YoULSahRV2vvJxbZm+o88Zb1/RApdJN
R+5CGqV9x+UWp23vQU7BFKQSTFKT5IEa2F6mq4Bopz5SCXRixGHXsu+TuJ+bORKf
eod1IjYidKrXW9Kgl/MuD13BwJEJYFmDVR0QhCrblldWM+Y8Z78BlMxuRVaj0mdq
6lyDWIZddoSaFtimTxqOyHOLh+v7VtmYquL2hgFeqkPlIRNxZ++e/APjjXqVmg2d
Sr+T+wqJQKdX5ydrQWnI3FI2KLAGqVrK5tCPiLaphD4SWxASSPcw9WiYUPAI4sfX
Dn0AE8LRblN7uajxew8DbiaIeE3ekZWVFcd9Q+ST4+pRZgaBF34=
=rCco
-----END PGP SIGNATURE-----

--5u5eTKo7VqhyMmfM--
