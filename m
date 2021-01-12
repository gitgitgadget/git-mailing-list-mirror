Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E160BC433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CAA22BE9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbhALM2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:28:37 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:45739 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727025AbhALM2e (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:28:34 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8DBC71B5D;
        Tue, 12 Jan 2021 07:27:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=eLicp7aDSh8t30q7bDsolR+Ddg5
        E+0ZDFDY4CtRoaOQ=; b=kRJd0SeVGV3YwutkTAxl5wsKvfhhqQiCGqSPPUjHm0m
        4Fyw0fW/BEBl0RFlt+NESUoKTijKpIQt5UjswaZZBdMYHa3I1lBnKSiTVg7K+0x+
        CTqrfN7BhjoTkRV7RN1lk8Z3FpGEw8Sy6/jXNTlqWClw/XvuCWwEp3DJdN12PSjS
        0Zkw0iiUjHgIxGpKGHWJta8t+lOGPCZYYE09tJsdQyGzb2mIESFc+I/A1l0Eg3hm
        vSaEi4FqrxZt6k6Byx2tEav4PkwpR3YDDg7evCIMbroQFCnXJg5qHbVLUKHlUS+K
        fc3jCN2+MbTjhT42elFkc+WVNScEzhL/Ue4IaK8yNCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=eLicp7
        aDSh8t30q7bDsolR+Ddg5E+0ZDFDY4CtRoaOQ=; b=o7oVdJwEurw1YmOMolYUX/
        90x8MZdiEpi1ljtW2tM2OYgi3AyIS01TdhsIb2aoyybAtOpgSODbBKqAZUMFioDR
        8P6+zihw4BqWpGd77lOAyJAk1/42EQjN1YV13e8vM3ct19OkUMMgtfVedCD3OQBr
        0+ood0PFdQLhILovGx9ntJd82kU30SprDAEnyZ5ookfd5/xJ5F5ivBYeqLsU8eod
        kRn9LHOY1dkcg2j3t1RIl+G3v29iq/7yR/sTZl2Onw1jkP9PJYsxPM/+2mkwCauK
        ofsy6xzyHS/a2tPHAFZoTTqkdo8C+N680Vq6gN4rsBuGAhSllvnTASoKQ0HPyHLg
        ==
X-ME-Sender: <xms:upX9X8eT-X601M7JQnevEqx1pv_M9y-7gt1_HF1sBNc6XUatSAXPmQ>
    <xme:upX9X-PRcmA8ug-5Rnz7lNju9TbMYq4x7ipa-rf5UBu92q5BEdMAiPi8n_ADthzCk
    85UCADE1YJteNZ6WA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgepleenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:upX9X9inGYhLONTpILYo1vMaixMMdahqxElSNxn6c3_OSfvBtwPyWw>
    <xmx:upX9Xx_zu0-YqqMPekZLHyAUaRPYgi6EVGKtcYdCdkAyYL_I__c5mg>
    <xmx:upX9X4siTA5i_tJCiad5o2u-p21nQoKRkDMpsrp1cYTvE17sZvbtOQ>
    <xmx:upX9X-3nEg09hi7Hdct3q0TfHP2TRqPq6-CPh6N-AwG7NXhHP4g0Tw>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7530D24005D;
        Tue, 12 Jan 2021 07:27:37 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 4a278bb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:27:36 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:27:35 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 1/5] fetch: extract writing to FETCH_HEAD
Message-ID: <9fcc8b54dec06288581497666eaefac7ff0bb736.1610454262.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610454262.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ELUCFAZSLb8bSpy/"
Content-Disposition: inline
In-Reply-To: <cover.1610454262.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ELUCFAZSLb8bSpy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When performing a fetch with the default `--write-fetch-head` option, we
write all updated references to FETCH_HEAD while the updates are
performed. Given that updates are not performed atomically, it means
that we we write to FETCH_HEAD even if some or all of the reference
updates fail.

Given that we simply update FETCH_HEAD ad-hoc with each reference, the
logic is completely contained in `store_update_refs` and thus quite hard
to extend. This can already be seen by the way we skip writing to the
FETCH_HEAD: instead of having a conditional which simply skips writing,
we instead open "/dev/null" and needlessly write all updates there.

We are about to extend git-fetch(1) to accept an `--atomic` flag which
will make the fetch an all-or-nothing operation with regards to the
reference updates. This will also require us to make the updates to
FETCH_HEAD an all-or-nothing operation, but as explained doing so is not
easy with the current layout. This commit thus refactors the wa we write
to FETCH_HEAD and pulls out the logic to open, append to, commit and
close the file. While this may seem rather over-the top at first,
pulling out this logic will make it a lot easier to update the code in a
subsequent commit. It also allows us to easily skip writing completely
in case `--no-write-fetch-head` was passed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 108 +++++++++++++++++++++++++++++++++++-------------
 remote.h        |   2 +-
 2 files changed, 80 insertions(+), 30 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ecf8537605..2dd5fcb652 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -897,6 +897,73 @@ static int iterate_ref_map(void *cb_data, struct objec=
t_id *oid)
 	return 0;
 }
=20
+struct fetch_head {
+	FILE *fp;
+};
+
+static int open_fetch_head(struct fetch_head *fetch_head)
+{
+	const char *filename =3D git_path_fetch_head(the_repository);
+
+	if (write_fetch_head) {
+		fetch_head->fp =3D fopen(filename, "a");
+		if (!fetch_head->fp)
+			return error_errno(_("cannot open %s"), filename);
+	} else {
+		fetch_head->fp =3D NULL;
+	}
+
+	return 0;
+}
+
+static void append_fetch_head(struct fetch_head *fetch_head,
+			      const struct object_id *old_oid,
+			      enum fetch_head_status fetch_head_status,
+			      const char *note,
+			      const char *url, size_t url_len)
+{
+	char old_oid_hex[GIT_MAX_HEXSZ + 1];
+	const char *merge_status_marker;
+	size_t i;
+
+	if (!fetch_head->fp)
+		return;
+
+	switch (fetch_head_status) {
+	case FETCH_HEAD_NOT_FOR_MERGE:
+		merge_status_marker =3D "not-for-merge";
+		break;
+	case FETCH_HEAD_MERGE:
+		merge_status_marker =3D "";
+		break;
+	default:
+		/* do not write anything to FETCH_HEAD */
+		return;
+	}
+
+	fprintf(fetch_head->fp, "%s\t%s\t%s",
+		oid_to_hex_r(old_oid_hex, old_oid), merge_status_marker, note);
+	for (i =3D 0; i < url_len; ++i)
+		if ('\n' =3D=3D url[i])
+			fputs("\\n", fetch_head->fp);
+		else
+			fputc(url[i], fetch_head->fp);
+	fputc('\n', fetch_head->fp);
+}
+
+static void commit_fetch_head(struct fetch_head *fetch_head)
+{
+	/* Nothing to commit yet. */
+}
+
+static void close_fetch_head(struct fetch_head *fetch_head)
+{
+	if (!fetch_head->fp)
+		return;
+
+	fclose(fetch_head->fp);
+}
+
 static const char warn_show_forced_updates[] =3D
 N_("Fetch normally indicates which branches had a forced update,\n"
    "but that check has been disabled. To re-enable, use '--show-forced-upd=
ates'\n"
@@ -909,22 +976,19 @@ N_("It took %.2f seconds to check forced updates. You=
 can use\n"
 static int store_updated_refs(const char *raw_url, const char *remote_name,
 			      int connectivity_checked, struct ref *ref_map)
 {
-	FILE *fp;
+	struct fetch_head fetch_head;
 	struct commit *commit;
 	int url_len, i, rc =3D 0;
 	struct strbuf note =3D STRBUF_INIT;
 	const char *what, *kind;
 	struct ref *rm;
 	char *url;
-	const char *filename =3D (!write_fetch_head
-				? "/dev/null"
-				: git_path_fetch_head(the_repository));
 	int want_status;
 	int summary_width =3D transport_summary_width(ref_map);
=20
-	fp =3D fopen(filename, "a");
-	if (!fp)
-		return error_errno(_("cannot open %s"), filename);
+	rc =3D open_fetch_head(&fetch_head);
+	if (rc)
+		return -1;
=20
 	if (raw_url)
 		url =3D transport_anonymize_url(raw_url);
@@ -953,7 +1017,6 @@ static int store_updated_refs(const char *raw_url, con=
st char *remote_name,
 	     want_status++) {
 		for (rm =3D ref_map; rm; rm =3D rm->next) {
 			struct ref *ref =3D NULL;
-			const char *merge_status_marker =3D "";
=20
 			if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW) {
 				if (want_status =3D=3D FETCH_HEAD_MERGE)
@@ -1011,26 +1074,10 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 					strbuf_addf(&note, "%s ", kind);
 				strbuf_addf(&note, "'%s' of ", what);
 			}
-			switch (rm->fetch_head_status) {
-			case FETCH_HEAD_NOT_FOR_MERGE:
-				merge_status_marker =3D "not-for-merge";
-				/* fall-through */
-			case FETCH_HEAD_MERGE:
-				fprintf(fp, "%s\t%s\t%s",
-					oid_to_hex(&rm->old_oid),
-					merge_status_marker,
-					note.buf);
-				for (i =3D 0; i < url_len; ++i)
-					if ('\n' =3D=3D url[i])
-						fputs("\\n", fp);
-					else
-						fputc(url[i], fp);
-				fputc('\n', fp);
-				break;
-			default:
-				/* do not write anything to FETCH_HEAD */
-				break;
-			}
+
+			append_fetch_head(&fetch_head, &rm->old_oid,
+					  rm->fetch_head_status,
+					  note.buf, url, url_len);
=20
 			strbuf_reset(&note);
 			if (ref) {
@@ -1060,6 +1107,9 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
 		}
 	}
=20
+	if (!rc)
+		commit_fetch_head(&fetch_head);
+
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
 		      " 'git remote prune %s' to remove any old, conflicting "
@@ -1077,7 +1127,7 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
  abort:
 	strbuf_release(&note);
 	free(url);
-	fclose(fp);
+	close_fetch_head(&fetch_head);
 	return rc;
 }
=20
diff --git a/remote.h b/remote.h
index 3211abdf05..aad1a0f080 100644
--- a/remote.h
+++ b/remote.h
@@ -134,7 +134,7 @@ struct ref {
 	 * should be 0, so that xcalloc'd structures get it
 	 * by default.
 	 */
-	enum {
+	enum fetch_head_status {
 		FETCH_HEAD_MERGE =3D -1,
 		FETCH_HEAD_NOT_FOR_MERGE =3D 0,
 		FETCH_HEAD_IGNORE =3D 1
--=20
2.30.0


--ELUCFAZSLb8bSpy/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lbYACgkQVbJhu7ck
PpQxRw/+LgBXVTfmBKoJLcQb9pXJoiDtkK5bV2YSKD0iDGo6Ckio0n6Y4PTn3s0G
UC2YAC+sBaj1+S2JjrF3DslSlWeg1bjw6DDuzFpqk1Ik9nlDDXESWMt1GBbo0ucK
YPG5D1h9J+FH/5ChTQ8f+rN/a64R3XFw7PhV4emetGKUZoPFlmWu7b8bSl/9Lt/h
R1zWn1UN+ixDLJ27xalrjWvbMqqu8BdK7Knmw4hCNfzabVeSnNFe6+IaUd6AIihO
KhjjxLXfixHTNH5cbzeeDPM6J4H6kgW0GhM6NSzcEyhGStc6PVFFce+2cjFjmsyB
9eIrFDxQu+Po89Jws3FuosFEs6CjXXq1cOmzaaG+nKt9r91dnScHknFsQ8nlNUwr
v/GNkbt4Yca54JKHXahjyNh7MM/0OsMu4ANqH4Kjg6JtuocnCc8Q6WC5HAFCdVCS
RGQfYq6lIlc0jBGh5N5Afm0n4VM1i0eSt6nNC+y6YvwcUvfU1yK+Ym1M2Tq8HhCc
TPHS7krENuH8iGvJbaaqTuRZ/eB6qjaDbEyxWPRX+Mp2BJIN5Z9OvqhH3ML0y4OW
5onFJKu1jlWoQwxKr4kNW+39lf5jFlMt3k0gEcPTuI7EC+Tf0HHJI2P8sMRgUnns
2eM1+bCeTwdT0/IkuH5fH7XNwdw/PLj7d93apWWJDZMOpYHUnnE=
=oi/1
-----END PGP SIGNATURE-----

--ELUCFAZSLb8bSpy/--
