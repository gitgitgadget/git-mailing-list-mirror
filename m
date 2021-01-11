Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B141C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E91822473
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbhAKLGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:06:05 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:50965 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727986AbhAKLGF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 06:06:05 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 04E502934;
        Mon, 11 Jan 2021 06:05:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 11 Jan 2021 06:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=RZec6KzWWuireTLH14zQdN5lvkF
        jhb7FuWyueGDafM8=; b=KcbSIjgF3jPBEAmHn2/e/uhSx+zkATu/zvE/KPTpWey
        JRVkQyKqXIHlIJzK35VKF5v+YnsRfLSDjIdJ9O7yr4hoSYnq4+OO1wV/1XWb/wa/
        QhpCRATEkFoPa8FznPirdeJR3b1ZqcEZWuNVYIhZnx5dyBXYTA8I+oQQDNKtsw01
        Ycih88sMKSGPQYV1wicZzt7uNZ/+SnfgOJ+vadu2mh5cmElhksfwxc/pgbivFf6Z
        XpDErqdWpCJ122qhWfzHWppv62EbVmfhO6KRZwE6hMOPbMf/dXs0dcdyfxX6b910
        dgfl95/xIg+ewwK+jD6A2k0M3GgY//bzte0ICbMO8pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=RZec6K
        zWWuireTLH14zQdN5lvkFjhb7FuWyueGDafM8=; b=PH6TtJcKr48Nno4aaJXbg1
        205LjObXLTR6nDcdS7nyAJ0J5othW2nt9yZBJERmmrwAHlMr9SnifXrOL22gmpzx
        ND2LANyZ7slNcgAehXtzyTO/G5umNw+LOwS/pvr8ryFUmse/YKObKstGeZH0L8dv
        2R/iLAlg9sPJnkfVSwbF0wvSSUFBb+H5xPwUpA6hH+pv6qXl3Z+f2of7tTuPXKe2
        pcxtQwwGEAcAVstGRLZo+VC/qZjeVJzL5RrPo29yJ1vFux6NJju+37mGmHQJXqHt
        LF7PmRij38p+SCKmzQ5yQGMmaYa/JZZppX7kk+5YPZrwnd+/QOTrpAPwsYO/sgag
        ==
X-ME-Sender: <xms:7jD8X1gOFNBMFDXio9_8ha2P9rTAFzANjozk0By-2BSgB33hD6pY6g>
    <xme:7jD8X8CWr6IIxG5-KMR8uEugL1rR8dXCdFGhRPBMWHxB1_h_Qo_TQoxKiDJ1KTlAG
    5hnRAoPZyOg8f7x3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehuddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrgeehrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7jD8X-cwqeec8vGbFt3xEWYsVCrCgteVeRmjYqxkKdu2EGoYr4Puww>
    <xmx:7jD8X8dREq3RKa2jOLibv3RZh11reG3pN8xkzCqTmTxY83u_pZW-sw>
    <xmx:7jD8X6iIZN37-eSAr5d44QzD_nGt2ySxTELh3oFWNh1LHsYBUOlobQ>
    <xmx:7jD8X5rkNl6FeT8iZx5VpkwmkalNFoznWyB3VWAKfJ6mQMzjc7tjqw>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1701C1080057;
        Mon, 11 Jan 2021 06:05:17 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d993f9a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 11:05:17 +0000 (UTC)
Date:   Mon, 11 Jan 2021 12:05:16 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 1/5] fetch: extract writing to FETCH_HEAD
Message-ID: <61dc19a1cab5b03d07c6635496761108d089eb23.1610362744.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610362744.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vhp5EARj7EH1pW/q"
Content-Disposition: inline
In-Reply-To: <cover.1610362744.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Vhp5EARj7EH1pW/q
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
index ecf8537605..50f0306a92 100644
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
+		case FETCH_HEAD_NOT_FOR_MERGE:
+			merge_status_marker =3D "not-for-merge";
+			break;
+		case FETCH_HEAD_MERGE:
+			merge_status_marker =3D "";
+			break;
+		default:
+			/* do not write anything to FETCH_HEAD */
+			return;
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


--Vhp5EARj7EH1pW/q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8MOsACgkQVbJhu7ck
PpQ3AA/+IFjgIuBHLYLznDu6YwEwncmSKOyTtBDNpttaIeJTJ6mFwlq+Wcs0gyBx
kEIKohf3zXohbo64sQWhPv65Z5rKezWolZeU2sNoCdZWGBpND7UKKtkb0r3b2LSB
e5qEyKheN5PBpHqewj4w1L8nEKi28eh/y+zFNdMAFTyvrpmafU+Vdw+u8n81oqQS
+YNma0Y0sDfqyjllb1ZalmOUrz8LAiY13wY3nSr4F3I3jh3Ej96DGxonBmkLNo37
p7fgxzC6kMegsWvYFjz6Xy8xVZti9BJtUGg9+L1NSiEp97f9V7mtwNb2wvzv5Isj
iBRNoiZsIz77jMtHkGfAB56GJ9t36ekByRvwPCvO5UIxe+iNf5MdmEYETWfqPufQ
vCt/2vkRfTjDU9wi3wUb/2CEfXAxtHUUXg4MV0Fx0UYqdxmOZ+BL/zN1eHCziLaO
DRAn82YJJjxgGGIhEVpyzxN36Ss+NJbXnEk3K2D1JMBmiCYYxV0oe0n6KuUgZEUD
XtGVsM8l034lbgUm9DYydco3lnaU8cJqLrfMV1PD7A4yf/GvtyO+WO0yLfwgGJvK
8gNniobbB91Y9IcN0cVetFGCbLVHBfBRCiPCR1chNfxPoBKICnta9pjAmkhGYh1b
XTL9n+vLlB9djnraiiIVMW73hLEceg0KZNtHcnAzaJDe6YDbtzA=
=340q
-----END PGP SIGNATURE-----

--Vhp5EARj7EH1pW/q--
