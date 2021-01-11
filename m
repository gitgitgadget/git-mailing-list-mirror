Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE6CC433E6
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7842250F
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbhAKLGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:06:24 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:34379 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728413AbhAKLGY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 06:06:24 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0FD7E290A;
        Mon, 11 Jan 2021 06:05:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Jan 2021 06:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=TdirxcV1wcdigcumbFj3bx6RCZA
        EhizEsGjFLLGEawo=; b=o2tBQipvTduVSjRFMJp0o1EunBgu16TyTAa7ROjJWpt
        amxGQwdN1zUPnAakwZ9V2GQgcKN2AjSv383lP4oPzwM2gNyHEMvwds2D7RiiS93a
        6o+jWHpTEvZ9JNk/QrGfm6SmuxmJcD97fhFu3OK7muer1WXSOMgVcJ0MD6ZtPRhy
        dvjB1HgYV+Kjmw5Eo6lJTZCmW6YhTEwWP1K1IM9u792bOx0XTdGtdfuNoekfk4CB
        c7Jzd4UUIdzCOPMcHtljsW9C1wtlx6lUj63PyzC96UVKM8TlNWZOC43ztDea3XSN
        sJxBVv8O4b/21rqBATlyMZJeFLlHRebeCTrnt6RKhXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Tdirxc
        V1wcdigcumbFj3bx6RCZAEhizEsGjFLLGEawo=; b=rhdySS4TOmFC/w44j0Zz/o
        QtVTEMS1zPkAa3/xahiRkSYwVl69V5F/fdQGZxkjCY31lG/AwAqx8+QGjxUQ6r1K
        HetD4WCqVPcHfo8Vs6L/PXUdy1XKACpt1EINnAmgnxK/dPsDS+Tl2DLDd28Ypjax
        WS0gnTjMEzGgjrqvFQ02oOmEtWDvH/oeja338Yolk/brYNavXY4JFFNZH7WlG5eh
        7Ld1/sg25e8XTpwDiMcXbU/ObNguzPEUNpWtRyvD38VHkM/mr410A3UQofFds6zL
        LTLtg2Qq55nqagIWZ3p77O8SiftPQc9zXQ+GIhCdv1XQXcsZxqzPbxDV4exKtg+g
        ==
X-ME-Sender: <xms:7DD8XzuLeTKJlJVJ4WKbBB9k4J0nJNi_w3W6EAcDrwADdgVkyKYw4g>
    <xme:7DD8X4s_YNbyO6teCfvPqrZCBJEWjdmV9rSPYnjAQ_xP3D-wL3TpscnSuJrIs2s_O
    i8wCaoHVa3rPZ4vZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehuddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrgeehrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7DD8Xxzd4J8Klqe6n0SyOdPRFgpiQRgjb3to9-5BGaeRHAIj6G_OXA>
    <xmx:7DD8X2hWNEZkdFmvpUpapAfpNU9tmb6kpM-Q1QdSnbKgYiu3KMaoxQ>
    <xmx:7DD8X9DZXZqhAARilWZEreYw3kU92FzwBHc9sDTUy3vCW-0B_db1vw>
    <xmx:7TD8X1cWBSZldShx2rqE3mERfrtHiQmBqrG99cG0q9-F0xpIK7buBg>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5BD86108005C;
        Mon, 11 Jan 2021 06:05:16 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 88eabf28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 11:05:12 +0000 (UTC)
Date:   Mon, 11 Jan 2021 12:05:11 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 0/5] fetch: implement support for atomic reference updates
Message-ID: <cover.1610362744.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="17myVdbnQptzUJSG"
Content-Disposition: inline
In-Reply-To: <cover.1610027375.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--17myVdbnQptzUJSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series to implement support for
atomic reference updates for git-fetch(1). It's similar to `git push
--atomic`, only that it applies to the local side. That is the fetch
will either succeed and update all remote references or it will fail and
update none.

Changes compared to v2:

    - `append_fetch_head` now takes a `struct object_id *old_oid`
      instead of a `char *old_oid`.

    - Handling of the merge status marker was moved into
      `append_fetch_head`.

    - I've unified code paths to format the line we're about to write to
      FETCH_HEAD in atomic and non-atomic cases, which is the new 2/5
      patch.

    - We now always initialize `fetch_head->fp` and use it to derive
      whether anything should be written at all instead of using the
      global `write_fetch_head` variable.

I think this should address all of Junio's feedback. Thanks for your
input!

Patrick

Patrick Steinhardt (5):
  fetch: extract writing to FETCH_HEAD
  fetch: use strbuf to format FETCH_HEAD updates
  fetch: refactor `s_update_ref` to use common exit path
  fetch: allow passing a transaction to `s_update_ref()`
  fetch: implement support for atomic reference updates

 Documentation/fetch-options.txt |   4 +
 builtin/fetch.c                 | 228 +++++++++++++++++++++++---------
 remote.h                        |   2 +-
 t/t5510-fetch.sh                | 168 +++++++++++++++++++++++
 4 files changed, 342 insertions(+), 60 deletions(-)

Range-diff against v2:
1:  d80dbc5a9c ! 1:  61dc19a1ca fetch: extract writing to FETCH_HEAD
    @@ builtin/fetch.c: static int iterate_ref_map(void *cb_data, struct ob=
ject_id *oid
     +{
     +	const char *filename =3D git_path_fetch_head(the_repository);
     +
    -+	if (!write_fetch_head)
    -+		return 0;
    -+
    -+	fetch_head->fp =3D fopen(filename, "a");
    -+	if (!fetch_head->fp)
    -+		return error_errno(_("cannot open %s"), filename);
    ++	if (write_fetch_head) {
    ++		fetch_head->fp =3D fopen(filename, "a");
    ++		if (!fetch_head->fp)
    ++			return error_errno(_("cannot open %s"), filename);
    ++	} else {
    ++		fetch_head->fp =3D NULL;
    ++	}
     +
     +	return 0;
     +}
     +
    -+static void append_fetch_head(struct fetch_head *fetch_head, const ch=
ar *old_oid,
    -+			      const char *merge_status_marker, const char *note,
    ++static void append_fetch_head(struct fetch_head *fetch_head,
    ++			      const struct object_id *old_oid,
    ++			      enum fetch_head_status fetch_head_status,
    ++			      const char *note,
     +			      const char *url, size_t url_len)
     +{
    ++	char old_oid_hex[GIT_MAX_HEXSZ + 1];
    ++	const char *merge_status_marker;
     +	size_t i;
     +
    -+	if (!write_fetch_head)
    ++	if (!fetch_head->fp)
     +		return;
     +
    ++	switch (fetch_head_status) {
    ++		case FETCH_HEAD_NOT_FOR_MERGE:
    ++			merge_status_marker =3D "not-for-merge";
    ++			break;
    ++		case FETCH_HEAD_MERGE:
    ++			merge_status_marker =3D "";
    ++			break;
    ++		default:
    ++			/* do not write anything to FETCH_HEAD */
    ++			return;
    ++	}
    ++
     +	fprintf(fetch_head->fp, "%s\t%s\t%s",
    -+		old_oid, merge_status_marker, note);
    ++		oid_to_hex_r(old_oid_hex, old_oid), merge_status_marker, note);
     +	for (i =3D 0; i < url_len; ++i)
     +		if ('\n' =3D=3D url[i])
     +			fputs("\\n", fetch_head->fp);
    @@ builtin/fetch.c: static int iterate_ref_map(void *cb_data, struct ob=
ject_id *oid
     +
     +static void close_fetch_head(struct fetch_head *fetch_head)
     +{
    -+	if (!write_fetch_head)
    ++	if (!fetch_head->fp)
     +		return;
     +
     +	fclose(fetch_head->fp);
    @@ builtin/fetch.c: N_("It took %.2f seconds to check forced updates. Y=
ou can use\n
      	if (raw_url)
      		url =3D transport_anonymize_url(raw_url);
     @@ builtin/fetch.c: static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
    - 				merge_status_marker =3D "not-for-merge";
    - 				/* fall-through */
    - 			case FETCH_HEAD_MERGE:
    + 	     want_status++) {
    + 		for (rm =3D ref_map; rm; rm =3D rm->next) {
    + 			struct ref *ref =3D NULL;
    +-			const char *merge_status_marker =3D "";
    +=20
    + 			if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW) {
    + 				if (want_status =3D=3D FETCH_HEAD_MERGE)
    +@@ builtin/fetch.c: static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
    + 					strbuf_addf(&note, "%s ", kind);
    + 				strbuf_addf(&note, "'%s' of ", what);
    + 			}
    +-			switch (rm->fetch_head_status) {
    +-			case FETCH_HEAD_NOT_FOR_MERGE:
    +-				merge_status_marker =3D "not-for-merge";
    +-				/* fall-through */
    +-			case FETCH_HEAD_MERGE:
     -				fprintf(fp, "%s\t%s\t%s",
     -					oid_to_hex(&rm->old_oid),
     -					merge_status_marker,
    @@ builtin/fetch.c: static int store_updated_refs(const char *raw_url, =
const char *
     -					else
     -						fputc(url[i], fp);
     -				fputc('\n', fp);
    -+				append_fetch_head(&fetch_head,
    -+						  oid_to_hex(&rm->old_oid),
    -+						  merge_status_marker,
    -+						  note.buf, url, url_len);
    - 				break;
    - 			default:
    - 				/* do not write anything to FETCH_HEAD */
    +-				break;
    +-			default:
    +-				/* do not write anything to FETCH_HEAD */
    +-				break;
    +-			}
    ++
    ++			append_fetch_head(&fetch_head, &rm->old_oid,
    ++					  rm->fetch_head_status,
    ++					  note.buf, url, url_len);
    +=20
    + 			strbuf_reset(&note);
    + 			if (ref) {
     @@ builtin/fetch.c: static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
      		}
      	}
    @@ builtin/fetch.c: static int store_updated_refs(const char *raw_url, =
const char *
      	return rc;
      }
     =20
    +
    + ## remote.h ##
    +@@ remote.h: struct ref {
    + 	 * should be 0, so that xcalloc'd structures get it
    + 	 * by default.
    + 	 */
    +-	enum {
    ++	enum fetch_head_status {
    + 		FETCH_HEAD_MERGE =3D -1,
    + 		FETCH_HEAD_NOT_FOR_MERGE =3D 0,
    + 		FETCH_HEAD_IGNORE =3D 1
-:  ---------- > 2:  a19762690e fetch: use strbuf to format FETCH_HEAD upda=
tes
2:  718a8bf5d7 ! 3:  c411f30e09 fetch: refactor `s_update_ref` to use commo=
n exit path
    @@ builtin/fetch.c: static int s_update_ref(const char *action,
     -				   check_old ? &ref->old_oid : NULL,
     -				   0, msg, &err))
     -		goto fail;
    +-
    +-	ret =3D ref_transaction_commit(transaction, &err);
    +-	if (ret) {
    +-		df_conflict =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT);
    +-		goto fail;
     +	if (!transaction) {
     +		ret =3D STORE_REF_ERROR_OTHER;
     +		goto out;
    -+	}
    -+
    + 	}
    +=20
     +	ret =3D ref_transaction_update(transaction, ref->name, &ref->new_oid,
     +				     check_old ? &ref->old_oid : NULL,
     +				     0, msg, &err);
    @@ builtin/fetch.c: static int s_update_ref(const char *action,
     +		ret =3D STORE_REF_ERROR_OTHER;
     +		goto out;
     +	}
    -=20
    - 	ret =3D ref_transaction_commit(transaction, &err);
    - 	if (ret) {
    --		df_conflict =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT);
    --		goto fail;
    -+		ret =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT) ? STORE_REF_ERROR_DF=
_CONFLICT
    -+							 : STORE_REF_ERROR_OTHER;
    ++
    ++	switch (ref_transaction_commit(transaction, &err)) {
    ++	case 0:
    ++		break;
    ++	case TRANSACTION_NAME_CONFLICT:
    ++		ret =3D STORE_REF_ERROR_DF_CONFLICT;
     +		goto out;
    - 	}
    -=20
    ++	default:
    ++		ret =3D STORE_REF_ERROR_OTHER;
    ++		goto out;
    ++	}
    ++
     +out:
      	ref_transaction_free(transaction);
     +	if (ret)
3:  4162d10fcb ! 4:  865d357ba7 fetch: allow passing a transaction to `s_up=
date_ref()`
    @@ builtin/fetch.c: static int s_update_ref(const char *action,
      		goto out;
      	}
     =20
    --	ret =3D ref_transaction_commit(transaction, &err);
    --	if (ret) {
    --		ret =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT) ? STORE_REF_ERROR_DF=
_CONFLICT
    --							 : STORE_REF_ERROR_OTHER;
    +-	switch (ref_transaction_commit(transaction, &err)) {
    +-	case 0:
    +-		break;
    +-	case TRANSACTION_NAME_CONFLICT:
    +-		ret =3D STORE_REF_ERROR_DF_CONFLICT;
    +-		goto out;
    +-	default:
    +-		ret =3D STORE_REF_ERROR_OTHER;
     -		goto out;
     +	if (our_transaction) {
    -+		ret =3D ref_transaction_commit(our_transaction, &err);
    -+		if (ret) {
    -+			ret =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT) ? STORE_REF_ERROR_D=
F_CONFLICT
    -+								 : STORE_REF_ERROR_OTHER;
    ++		switch (ref_transaction_commit(our_transaction, &err)) {
    ++		case 0:
    ++			break;
    ++		case TRANSACTION_NAME_CONFLICT:
    ++			ret =3D STORE_REF_ERROR_DF_CONFLICT;
    ++			goto out;
    ++		default:
    ++			ret =3D STORE_REF_ERROR_OTHER;
     +			goto out;
     +		}
      	}
4:  53705281b6 ! 5:  6a79e7adcc fetch: implement support for atomic referen=
ce updates
    @@ builtin/fetch.c: static struct option builtin_fetch_options[] =3D {
      	OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
      		   N_("path to upload pack on remote end")),
      	OPT__FORCE(&force, N_("force overwrite of local reference"), 0),
    -@@ builtin/fetch.c: static int iterate_ref_map(void *cb_data, struct o=
bject_id *oid)
    +@@ builtin/fetch.c: static void append_fetch_head(struct fetch_head *f=
etch_head,
    + 			strbuf_addch(&fetch_head->buf, url[i]);
    + 	strbuf_addch(&fetch_head->buf, '\n');
     =20
    - struct fetch_head {
    - 	FILE *fp;
    -+	struct strbuf buf;
    - };
    -=20
    - static int open_fetch_head(struct fetch_head *fetch_head)
    -@@ builtin/fetch.c: static int open_fetch_head(struct fetch_head *fetc=
h_head)
    - 	if (!write_fetch_head)
    - 		return 0;
    -=20
    -+	strbuf_init(&fetch_head->buf, 0);
    - 	fetch_head->fp =3D fopen(filename, "a");
    - 	if (!fetch_head->fp)
    - 		return error_errno(_("cannot open %s"), filename);
    -@@ builtin/fetch.c: static void append_fetch_head(struct fetch_head *f=
etch_head, const char *old_oid
    - 	if (!write_fetch_head)
    - 		return;
    -=20
    --	fprintf(fetch_head->fp, "%s\t%s\t%s",
    --		old_oid, merge_status_marker, note);
    --	for (i =3D 0; i < url_len; ++i)
    --		if ('\n' =3D=3D url[i])
    --			fputs("\\n", fetch_head->fp);
    --		else
    --			fputc(url[i], fetch_head->fp);
    --	fputc('\n', fetch_head->fp);
    +-	strbuf_write(&fetch_head->buf, fetch_head->fp);
    +-	strbuf_reset(&fetch_head->buf);
     +	/*
     +	 * When using an atomic fetch, we do not want to update FETCH_HEAD if
     +	 * any of the reference updates fails. We thus have to write all
     +	 * updates to a buffer first and only commit it as soon as all
     +	 * references have been successfully updated.
     +	 */
    -+	if (atomic_fetch) {
    -+		strbuf_addf(&fetch_head->buf, "%s\t%s\t%s",
    -+			    old_oid, merge_status_marker, note);
    -+		strbuf_add(&fetch_head->buf, url, url_len);
    -+		strbuf_addch(&fetch_head->buf, '\n');
    -+	} else {
    -+		fprintf(fetch_head->fp, "%s\t%s\t%s",
    -+			old_oid, merge_status_marker, note);
    -+		for (i =3D 0; i < url_len; ++i)
    -+			if ('\n' =3D=3D url[i])
    -+				fputs("\\n", fetch_head->fp);
    -+			else
    -+				fputc(url[i], fetch_head->fp);
    -+		fputc('\n', fetch_head->fp);
    ++	if (!atomic_fetch) {
    ++		strbuf_write(&fetch_head->buf, fetch_head->fp);
    ++		strbuf_reset(&fetch_head->buf);
     +	}
      }
     =20
      static void commit_fetch_head(struct fetch_head *fetch_head)
      {
     -	/* Nothing to commit yet. */
    -+	if (!write_fetch_head || !atomic_fetch)
    ++	if (!fetch_head->fp || !atomic_fetch)
     +		return;
     +	strbuf_write(&fetch_head->buf, fetch_head->fp);
      }
     =20
      static void close_fetch_head(struct fetch_head *fetch_head)
    -@@ builtin/fetch.c: static void close_fetch_head(struct fetch_head *fe=
tch_head)
    - 		return;
    -=20
    - 	fclose(fetch_head->fp);
    -+	strbuf_release(&fetch_head->buf);
    - }
    -=20
    - static const char warn_show_forced_updates[] =3D
     @@ builtin/fetch.c: static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
      	struct fetch_head fetch_head;
      	struct commit *commit;
--=20
2.30.0


--17myVdbnQptzUJSG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8MOYACgkQVbJhu7ck
PpTMhg/1HCsghzCIyqakEVX+kouKEaqWOIrAPQEzRDWSOrxewpaBmfbrWLlrMCfw
Zis3PVy9fek5xR5IHpNzTMqomEVNrsf0wtVEttrm37Kb4sFtGiuKsBMAVZB9LRWU
kcKfzZsk+7gaGOdXlyZsiDnf1z6dc2vCoVdxp4AtzZsWCf+omp9uAybTwXPP4ASw
iRYcZEsLaRnwwRoKmuzMcdtngLwGcFzk89dXszYEjb4XMZSn5aN7MWQ3ftoJsk6G
uCCYZaVM5aljWvy2yK/8bLj/4ktVUVNc1PXcHWp6A9ymmxtcnfmDV4If8C18/mDk
y87j06U175Sy1AdBext1cdsFGmaGnUbsrvtZOvwb79TKsRbb08cTEEar14IlKIUx
Pp9ueHg9rfrntx9qY5uiYtma0qBslVKLclKjI0pJVvk1shd7syXfj1xzowbDFCpv
nBg3EPJ9lLl1qRMXDMLuwzcL4dFu5EJkWCRauNmcw2bIxBmiZV/Lnj5zIePx47Mw
3RUNOsMkiBcYu+dCI7K4MnRhWh7N7J/dcns9HairKH8N03qCuC0gVe/LRoFzsaxf
m4eye/iPdEfLixU8DyMl58Lbq/ZkPEBo4QxbJOfg1xKjnc3YRQZCg2oRbF9LA5MC
FnB9SHjmiUbMZkux1GGGBlD8hDzE3W5OkTXG0SoHEl0HHpuzpg==
=g8WF
-----END PGP SIGNATURE-----

--17myVdbnQptzUJSG--
