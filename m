Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E40DC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 12:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D9DC239FE
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 12:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbhAHMMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 07:12:08 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45757 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbhAHMMI (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Jan 2021 07:12:08 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2A5D65C005F;
        Fri,  8 Jan 2021 07:11:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 08 Jan 2021 07:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=fMTVtPK2HPuBGA+gJDxTKpd1WEk
        pyivgaGgIwfBtfsQ=; b=EQZTVvZ/XtfJ//khJK/b4zDdcSUJJCvOzt3fIbAS/ml
        ddrdZA7nMtrSOuBqCQKzON3BHf2bRb4zJDgFLPjmhoyr39weEVPlXqwcUam8rW/O
        VlH9zaqNviNiaM8Y9b4JukrhZM1kGzQagCokVI/EiuHWbbxrxKUppFKipSdbC7ZR
        H2N+TuRNpZiODO1uUSzj/7JIMf0ixWTwX2Ao0Syp/mcDiXolQI+0kt6OavRFbxMT
        d4AcJRw9dGpinccW++hgaQgBKJWoJLzpyZ5SJo0wDJALbfhgHp/mUTB/VE/4xjjq
        M/0ogkrH7rpuq2XPiMjaqa5VBLZ7uHVMHcs+3alarOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fMTVtP
        K2HPuBGA+gJDxTKpd1WEkpyivgaGgIwfBtfsQ=; b=ChD9veCXT/zVzUpdQkFRBX
        9ghJc5AtlbGEq5pJAfYJKoaynCKm5+Oj+8gvELn+LCHG1BuPsN2k365D9TA63h3p
        qjat/iaGD7N+BeyR6nts+F/4C9McW6X15BMX3l3rQxGBiBsYHTsKpz6kfmUeRosu
        UjA2TCk43wBzISpQAfHJb5B0rw3ocjFIUMeEzwBB+ap7Bf+QMp8hs+gqd2ePc+P8
        8Ur/4apWDbup7GTCNw9FsnpnVL0v/d4qXmGQuCyiz+d2m3qT2LnLsiihjBwdCZKX
        OxR8jX6YWRpurgPTx6lWnJbbMnsXKgyow8T3DiQJiSq4UOw4FjvBh5m0t6UhU6qQ
        ==
X-ME-Sender: <xms:5Uv4X29th86Ety2h1nnoO0ZAjZxZY3F70HnVsoZpajKXeYPiUHQY5A>
    <xme:5Uv4X2tuRQi8HSUkLdXbte-pc8QhO7J8Y4y-gd02eNvmUSvZGMjbnh2ICxDz98cyF
    7_I8HyJRDbgod-CDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeggedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddukeefrdegrddvgeehnecuvehluhhsthgvrhfuihiivgepudenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:5Uv4X8B9yHKQr8gTuq7ZTJGnQZWDCT1LN9OPBpbZAc7Tfi1BMKyPDw>
    <xmx:5Uv4X-d2O7KfqBUGecu2Lr54r4e6oVt3GGur79BGozQi1WDvLMO3EQ>
    <xmx:5Uv4X7PuXHsb7rxCrMvsXIWj8BsuKAu-uqCW6MYFP_ijxfbeRPxd9w>
    <xmx:5Uv4X9WS_-ZsL_w2KDIdGJp0C_G8m3lYZPZGMdlDXqHnaUqtlzuGnQ>
Received: from vm-mail.pks.im (x4db704f5.dyn.telefonica.de [77.183.4.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7E0BC24005B;
        Fri,  8 Jan 2021 07:11:16 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3e4f2e48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 8 Jan 2021 12:11:15 +0000 (UTC)
Date:   Fri, 8 Jan 2021 13:11:14 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 1/4] fetch: extract writing to FETCH_HEAD
Message-ID: <d80dbc5a9c9520621651541e418ee5216d164053.1610107599.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610107599.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PO1tVMdEb9095eOo"
Content-Disposition: inline
In-Reply-To: <cover.1610107599.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PO1tVMdEb9095eOo
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
 builtin/fetch.c | 80 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ecf8537605..557ec130db 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -897,6 +897,56 @@ static int iterate_ref_map(void *cb_data, struct objec=
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
+	if (!write_fetch_head)
+		return 0;
+
+	fetch_head->fp =3D fopen(filename, "a");
+	if (!fetch_head->fp)
+		return error_errno(_("cannot open %s"), filename);
+
+	return 0;
+}
+
+static void append_fetch_head(struct fetch_head *fetch_head, const char *o=
ld_oid,
+			      const char *merge_status_marker, const char *note,
+			      const char *url, size_t url_len)
+{
+	size_t i;
+
+	if (!write_fetch_head)
+		return;
+
+	fprintf(fetch_head->fp, "%s\t%s\t%s",
+		old_oid, merge_status_marker, note);
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
+	if (!write_fetch_head)
+		return;
+
+	fclose(fetch_head->fp);
+}
+
 static const char warn_show_forced_updates[] =3D
 N_("Fetch normally indicates which branches had a forced update,\n"
    "but that check has been disabled. To re-enable, use '--show-forced-upd=
ates'\n"
@@ -909,22 +959,19 @@ N_("It took %.2f seconds to check forced updates. You=
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
@@ -1016,16 +1063,10 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 				merge_status_marker =3D "not-for-merge";
 				/* fall-through */
 			case FETCH_HEAD_MERGE:
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
+				append_fetch_head(&fetch_head,
+						  oid_to_hex(&rm->old_oid),
+						  merge_status_marker,
+						  note.buf, url, url_len);
 				break;
 			default:
 				/* do not write anything to FETCH_HEAD */
@@ -1060,6 +1101,9 @@ static int store_updated_refs(const char *raw_url, co=
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
@@ -1077,7 +1121,7 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
  abort:
 	strbuf_release(&note);
 	free(url);
-	fclose(fp);
+	close_fetch_head(&fetch_head);
 	return rc;
 }
=20
--=20
2.30.0


--PO1tVMdEb9095eOo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/4S+EACgkQVbJhu7ck
PpSESA/9EueOPdtWB7bHCfYjGEewqi0yguEKjXPCVnxcmNM8m9tHBNaGzo91ZXll
Hv3djrhAMkwNg/0s9XRi/ILJZBPusbiKYIyTb6Wk7xpToPQH6sDs/EtsjQdHlt8f
4FZ4fkqr8ha4qJq0XBQmQhsttwO9MWU1ItIxVSUTRkQxnBk9TqrFuuXFsMbnB2Qq
WQ0Hssqm5NLgIOZVp4U+j8N+2VIXmRH66NR9SNxrCI7/pqJEc7Swz816XIw9mP/R
WBv7bw9ERBdUPPj4g+Pu6V/J5Agocnda3ukFihLW582f9G6rffa95v64vViYWxQT
Zv+buBGeKvYph8Iq6Aymyuwi99VG88zGn53wCCj5dFw9KY6UUv35bZHuxETAs5F1
S2BSEEGercMKrva2KLcimidrwIYewRK3WPS9n8Uuas0wb+WsfU3ZApNcDj/SaBT+
FCwSSSK70aVlBPSkRVv7Fy/5ICGp+uIVgiHEgJXyB10rwbbRMZWbt7H1Zlemr10g
hny+0zxX5wWKqHul8yPlhlKTJPvtqKq9gdniLGPYBNY9YpxlaY3hAjwPRTaYlmEI
pEFrLpfoxO/dbOSvewV+Wix2KgSpQQGxW/3IPfHLV492c1oh9YHUkn7Wnl68KcHj
IoF8zoVZz2H3sbhWQr4rk74XRc24XWO/MUHTn8BK14ql6oP4bsw=
=X2hE
-----END PGP SIGNATURE-----

--PO1tVMdEb9095eOo--
