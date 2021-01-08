Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D2BC433E9
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 12:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5179207D0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 12:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbhAHMMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 07:12:24 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44633 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726844AbhAHMMX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Jan 2021 07:12:23 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id BB7685C01BC;
        Fri,  8 Jan 2021 07:11:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 08 Jan 2021 07:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=LG3YMrmIwksmpLdJNxc1EwLNuuL
        jG9Fo/bv2KN3Wj00=; b=lUAAVmL1qckM+9o3U8Uq6aOm8Y27uf74G+5u9GsMIuA
        HaloHz8FIWU877N6A+r987tIboJSeS6SF5JJhHu3qmW4z4s99RfFBZO5RAJ7CPRk
        kAuhrJvja072/HR+jHWwXOnBAwZ2KS05b87htH05jeVgFVl15joWMkLMW4joQCOH
        rPmFXshYr51whRncm2WJ3fVf9UGFRWGrFN3a7rOcZUbvN3e262ujzrVDW/giArLu
        L76petRwnk+waVQ6HrZI31S44l2wVZdlNgh6mT4nzNOelhjIAHzJEHntoAtEaZyp
        i4ZxnV181Qq8s0fwEx3FEUQgQw8m4MJIT3/79ST3J3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=LG3YMr
        mIwksmpLdJNxc1EwLNuuLjG9Fo/bv2KN3Wj00=; b=Fmzwp95KeYEpa0V8nM3gVe
        13WKWHDzGdHI/RYLfRKA0xeha0u8woiGaBnY6MwOdOXQqtI1wMmY2e+6gIzUfnMl
        YW/ay/SgCK4BkKfl2QODyO8u4GbWBGqOQyZD/aDIQW12n9dGSl6VQ1pfAm6YN/Iy
        Hagl5izFlygSzoVwINCU+8+tF4qWfb/tX7eQqFKjTucU5ARDzbgrpGKHx7/jrnlJ
        6rAdc5y5ym4RlXAOcU6uBRTHRQqpGBKwu0lZ4gKy+1Nt+HcLTkANrnwTZrYVU59y
        m5uuT1+5mjT0DxciIsuwNIu8D4PZmqoSRO4IxdQckDcAONg4RioCV6Evxq1dnYvQ
        ==
X-ME-Sender: <xms:40v4Xx3VaOQOc1m_9bOSj7UV7MlhUzkGbAZgYm-0lNvkGTGZkPLqJg>
    <xme:40v4X4HnzFQFUfc69F9-ugmYGAR2ikuNQX6nIulxVIO7AS-PTNC7Ms-qhWjp_osS2
    7o9ypk5MgKoCIGqag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeggedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddukeefrdegrddvgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:40v4Xx7QiHOInfCyerC55ajKWwhxwYIqcOo8L5pJUeGV9YdUWFzwMQ>
    <xmx:40v4X-38xkAEF7PTc_LiLVK6Owdkx0i8KR4QS_voVSnEgwvOjg2g8g>
    <xmx:40v4X0FjtkgmqMUzOyZTiASWB_6VyC8todkDJG_Gyvuhgpj4mM9hKQ>
    <xmx:40v4X_OSiLwwSZ0vfFx6GlICuTfoaNuP6UUW2386gnkSv8DR_U8TfQ>
Received: from vm-mail.pks.im (x4db704f5.dyn.telefonica.de [77.183.4.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id C2F9324005A;
        Fri,  8 Jan 2021 07:11:14 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b9eeb0ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 8 Jan 2021 12:11:11 +0000 (UTC)
Date:   Fri, 8 Jan 2021 13:11:10 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/4] fetch: implement support for atomic reference updates
Message-ID: <cover.1610107599.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bYYwRfO/iwr/Azjl"
Content-Disposition: inline
In-Reply-To: <cover.1610027375.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bYYwRfO/iwr/Azjl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series to implement support for
atomic reference updates for git-fetch(1). It's similar to `git push
--atomic`, only that it applies to the local side. That is the fetch
will either succeed and update all remote references or it will fail and
update none.

Changes compared to v1:

    - In v1, we still wrote to FETCH_HEAD even if the fetch failed. I've
      fixed this now by pulling out logic to write to FETCH_HEAD in 1/4
      so that we can now easily buffer updates and commit them only if
      the reference transaction succeeds. There's some additional tests
      in 4/4 to test it works as expected.

    - As suggested by Christian, I've unified the exit path in
      `s_update_ref()` in 2/4.

    - I've dropped the `commit` variable and renamed
      `transaction_to_free` to `our_transaction` as suggested by Junio.

Patrick

Patrick Steinhardt (4):
  fetch: extract writing to FETCH_HEAD
  fetch: refactor `s_update_ref` to use common exit path
  fetch: allow passing a transaction to `s_update_ref()`
  fetch: implement support for atomic reference updates

 Documentation/fetch-options.txt |   4 +
 builtin/fetch.c                 | 198 ++++++++++++++++++++++++--------
 t/t5510-fetch.sh                | 168 +++++++++++++++++++++++++++
 3 files changed, 322 insertions(+), 48 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  d80dbc5a9c fetch: extract writing to FETCH_HEAD
-:  ---------- > 2:  718a8bf5d7 fetch: refactor `s_update_ref` to use commo=
n exit path
1:  e627e729e5 ! 3:  4162d10fcb fetch: allow passing a transaction to `s_up=
date_ref()`
    @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remot=
e,
      	char *msg;
      	char *rla =3D getenv("GIT_REFLOG_ACTION");
     -	struct ref_transaction *transaction;
    -+	struct ref_transaction *transaction_to_free =3D NULL;
    ++	struct ref_transaction *our_transaction =3D NULL;
      	struct strbuf err =3D STRBUF_INIT;
    --	int ret, df_conflict =3D 0;
    -+	int ret, df_conflict =3D 0, commit =3D 0;
    + 	int ret;
     =20
    - 	if (dry_run)
    - 		return 0;
     @@ builtin/fetch.c: static int s_update_ref(const char *action,
      		rla =3D default_rla.buf;
      	msg =3D xstrfmt("%s: %s", rla, action);
     =20
     -	transaction =3D ref_transaction_begin(&err);
    --	if (!transaction ||
    --	    ref_transaction_update(transaction, ref->name,
     +	/*
     +	 * If no transaction was passed to us, we manage the transaction
     +	 * ourselves. Otherwise, we trust the caller to handle the transacti=
on
     +	 * lifecycle.
     +	 */
    -+	if (!transaction) {
    -+		transaction =3D transaction_to_free =3D ref_transaction_begin(&err);
    -+		if (!transaction)
    -+			goto fail;
    -+		commit =3D 1;
    -+	}
    -+
    -+	if (ref_transaction_update(transaction, ref->name,
    - 				   &ref->new_oid,
    - 				   check_old ? &ref->old_oid : NULL,
    - 				   0, msg, &err))
    - 		goto fail;
    -=20
    --	ret =3D ref_transaction_commit(transaction, &err);
    --	if (ret) {
    --		df_conflict =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT);
    --		goto fail;
    -+	if (commit) {
    -+		ret =3D ref_transaction_commit(transaction, &err);
    -+		if (ret) {
    -+			df_conflict =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT);
    -+			goto fail;
    + 	if (!transaction) {
    +-		ret =3D STORE_REF_ERROR_OTHER;
    +-		goto out;
    ++		transaction =3D our_transaction =3D ref_transaction_begin(&err);
    ++		if (!transaction) {
    ++			ret =3D STORE_REF_ERROR_OTHER;
    ++			goto out;
     +		}
      	}
     =20
    + 	ret =3D ref_transaction_update(transaction, ref->name, &ref->new_oid,
    +@@ builtin/fetch.c: static int s_update_ref(const char *action,
    + 		goto out;
    + 	}
    +=20
    +-	ret =3D ref_transaction_commit(transaction, &err);
    +-	if (ret) {
    +-		ret =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT) ? STORE_REF_ERROR_DF=
_CONFLICT
    +-							 : STORE_REF_ERROR_OTHER;
    +-		goto out;
    ++	if (our_transaction) {
    ++		ret =3D ref_transaction_commit(our_transaction, &err);
    ++		if (ret) {
    ++			ret =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT) ? STORE_REF_ERROR_D=
F_CONFLICT
    ++								 : STORE_REF_ERROR_OTHER;
    ++			goto out;
    ++		}
    + 	}
    +=20
    + out:
     -	ref_transaction_free(transaction);
    -+	ref_transaction_free(transaction_to_free);
    ++	ref_transaction_free(our_transaction);
    + 	if (ret)
    + 		error("%s", err.buf);
      	strbuf_release(&err);
    - 	free(msg);
    - 	return 0;
    - fail:
    --	ref_transaction_free(transaction);
    -+	ref_transaction_free(transaction_to_free);
    - 	error("%s", err.buf);
    - 	strbuf_release(&err);
    - 	free(msg);
     @@ builtin/fetch.c: static void format_display(struct strbuf *display,=
 char code,
      }
     =20
2:  4807344e92 ! 4:  53705281b6 fetch: implement support for atomic referen=
ce updates
    @@ Commit message
         inconsistent view the server has. This is a separate problem thoug=
h and,
         if it actually exists, can be fixed at a later point.
    =20
    +    This commit also changes the way we write FETCH_HEAD in case `--at=
omic`
    +    is passed. Instead of writing changes as we go, we need to accumul=
ate
    +    all changes first and only commit them at the end when we know tha=
t all
    +    reference updates succeeded. Ideally, we'd just do so via a tempor=
ary
    +    file so that we don't need to carry all updates in-memory. This is=
n't
    +    trivially doable though considering the `--append` mode, where we =
do not
    +    truncate the file but simply append to it. And given that we suppo=
rt
    +    concurrent processes appending to FETCH_HEAD at the same time with=
out
    +    any loss of data, seeding the temporary file with current contents=
 of
    +    FETCH_HEAD initially and then doing a rename wouldn't work either.=
 So
    +    this commit implements the simple strategy of buffering all change=
s and
    +    appending them to the file on commit.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## Documentation/fetch-options.txt ##
    @@ builtin/fetch.c: static struct option builtin_fetch_options[] =3D {
      	OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
      		   N_("path to upload pack on remote end")),
      	OPT__FORCE(&force, N_("force overwrite of local reference"), 0),
    -@@ builtin/fetch.c: static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
    +@@ builtin/fetch.c: static int iterate_ref_map(void *cb_data, struct o=
bject_id *oid)
    +=20
    + struct fetch_head {
      	FILE *fp;
    ++	struct strbuf buf;
    + };
    +=20
    + static int open_fetch_head(struct fetch_head *fetch_head)
    +@@ builtin/fetch.c: static int open_fetch_head(struct fetch_head *fetc=
h_head)
    + 	if (!write_fetch_head)
    + 		return 0;
    +=20
    ++	strbuf_init(&fetch_head->buf, 0);
    + 	fetch_head->fp =3D fopen(filename, "a");
    + 	if (!fetch_head->fp)
    + 		return error_errno(_("cannot open %s"), filename);
    +@@ builtin/fetch.c: static void append_fetch_head(struct fetch_head *f=
etch_head, const char *old_oid
    + 	if (!write_fetch_head)
    + 		return;
    +=20
    +-	fprintf(fetch_head->fp, "%s\t%s\t%s",
    +-		old_oid, merge_status_marker, note);
    +-	for (i =3D 0; i < url_len; ++i)
    +-		if ('\n' =3D=3D url[i])
    +-			fputs("\\n", fetch_head->fp);
    +-		else
    +-			fputc(url[i], fetch_head->fp);
    +-	fputc('\n', fetch_head->fp);
    ++	/*
    ++	 * When using an atomic fetch, we do not want to update FETCH_HEAD if
    ++	 * any of the reference updates fails. We thus have to write all
    ++	 * updates to a buffer first and only commit it as soon as all
    ++	 * references have been successfully updated.
    ++	 */
    ++	if (atomic_fetch) {
    ++		strbuf_addf(&fetch_head->buf, "%s\t%s\t%s",
    ++			    old_oid, merge_status_marker, note);
    ++		strbuf_add(&fetch_head->buf, url, url_len);
    ++		strbuf_addch(&fetch_head->buf, '\n');
    ++	} else {
    ++		fprintf(fetch_head->fp, "%s\t%s\t%s",
    ++			old_oid, merge_status_marker, note);
    ++		for (i =3D 0; i < url_len; ++i)
    ++			if ('\n' =3D=3D url[i])
    ++				fputs("\\n", fetch_head->fp);
    ++			else
    ++				fputc(url[i], fetch_head->fp);
    ++		fputc('\n', fetch_head->fp);
    ++	}
    + }
    +=20
    + static void commit_fetch_head(struct fetch_head *fetch_head)
    + {
    +-	/* Nothing to commit yet. */
    ++	if (!write_fetch_head || !atomic_fetch)
    ++		return;
    ++	strbuf_write(&fetch_head->buf, fetch_head->fp);
    + }
    +=20
    + static void close_fetch_head(struct fetch_head *fetch_head)
    +@@ builtin/fetch.c: static void close_fetch_head(struct fetch_head *fe=
tch_head)
    + 		return;
    +=20
    + 	fclose(fetch_head->fp);
    ++	strbuf_release(&fetch_head->buf);
    + }
    +=20
    + static const char warn_show_forced_updates[] =3D
    +@@ builtin/fetch.c: static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
    + 	struct fetch_head fetch_head;
      	struct commit *commit;
      	int url_len, i, rc =3D 0;
     -	struct strbuf note =3D STRBUF_INIT;
    @@ builtin/fetch.c: static int store_updated_refs(const char *raw_url, =
const char *
     +		}
     +	}
     +
    - 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
    - 		error(_("some local refs could not be updated; try running\n"
    - 		      " 'git remote prune %s' to remove any old, conflicting "
    + 	if (!rc)
    + 		commit_fetch_head(&fetch_head);
    +=20
     @@ builtin/fetch.c: static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
     =20
       abort:
    @@ builtin/fetch.c: static int store_updated_refs(const char *raw_url, =
const char *
     +	strbuf_release(&err);
     +	ref_transaction_free(transaction);
      	free(url);
    - 	fclose(fp);
    + 	close_fetch_head(&fetch_head);
      	return rc;
    +@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
    + 			die(_("--filter can only be used with the remote "
    + 			      "configured in extensions.partialclone"));
    +=20
    ++		if (atomic_fetch)
    ++			die(_("--atomic can only be used when fetching "
    ++			      "from one remote"));
    ++
    + 		if (stdin_refspecs)
    + 			die(_("--stdin can only be used when fetching "
    + 			      "from one remote"));
    =20
      ## t/t5510-fetch.sh ##
     @@ t/t5510-fetch.sh: test_expect_success 'fetch --prune --tags with re=
fspec prunes based on refspec'
    @@ t/t5510-fetch.sh: test_expect_success 'fetch --prune --tags with ref=
spec prunes
     +	cd "$D" &&
     +	git clone . atomic &&
     +	git branch atomic-branch &&
    -+	git rev-parse atomic-branch >expected &&
    ++	oid=3D$(git rev-parse atomic-branch) &&
    ++	echo "$oid" >expected &&
     +
     +	git -C atomic fetch --atomic origin &&
     +	git -C atomic rev-parse origin/atomic-branch >actual &&
    -+	test_cmp expected actual
    ++	test_cmp expected actual &&
    ++	test $oid =3D "$(git -C atomic rev-parse --verify FETCH_HEAD)"
     +'
     +
     +test_expect_success 'fetch --atomic works with multiple branches' '
    @@ t/t5510-fetch.sh: test_expect_success 'fetch --prune --tags with ref=
spec prunes
     +	test_must_fail git -C atomic fetch --atomic origin refs/heads/*:refs=
/remotes/origin/* &&
     +	test_must_fail git -C atomic rev-parse refs/remotes/origin/atomic-ne=
w-branch &&
     +	git -C atomic rev-parse refs/remotes/origin/atomic-non-ff >expected =
&&
    -+	test_cmp expected actual
    ++	test_cmp expected actual &&
    ++	test_must_be_empty atomic/.git/FETCH_HEAD
     +'
     +
     +test_expect_success 'fetch --atomic executes a single reference trans=
action only' '
    @@ t/t5510-fetch.sh: test_expect_success 'fetch --prune --tags with ref=
spec prunes
     +	git -C atomic for-each-ref >expected-refs &&
     +	test_must_fail git -C atomic fetch --tags --atomic origin &&
     +	git -C atomic for-each-ref >actual-refs &&
    -+	test_cmp expected-refs actual-refs
    ++	test_cmp expected-refs actual-refs &&
    ++	test_must_be_empty atomic/.git/FETCH_HEAD
    ++'
    ++
    ++test_expect_success 'fetch --atomic --append appends to FETCH_HEAD' '
    ++	test_when_finished "rm -rf \"$D\"/atomic" &&
    ++
    ++	cd "$D" &&
    ++	git clone . atomic &&
    ++	oid=3D$(git rev-parse HEAD) &&
    ++
    ++	git branch atomic-fetch-head-1 &&
    ++	git -C atomic fetch --atomic origin atomic-fetch-head-1 &&
    ++	test_line_count =3D 1 atomic/.git/FETCH_HEAD &&
    ++
    ++	git branch atomic-fetch-head-2 &&
    ++	git -C atomic fetch --atomic --append origin atomic-fetch-head-2 &&
    ++	test_line_count =3D 2 atomic/.git/FETCH_HEAD &&
    ++	cp atomic/.git/FETCH_HEAD expected &&
    ++
    ++	write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
    ++		exit 1
    ++	EOF
    ++
    ++	git branch atomic-fetch-head-3 &&
    ++	test_must_fail git -C atomic fetch --atomic --append origin atomic-f=
etch-head-3 &&
    ++	test_cmp expected atomic/.git/FETCH_HEAD
     +'
     +
      test_expect_success '--refmap=3D"" ignores configured refspec' '
--=20
2.30.0


--bYYwRfO/iwr/Azjl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/4S90ACgkQVbJhu7ck
PpT2VhAAkNm2RhmG2dIeldTfXV3+ZJvoHGxUYeIcw5+KQSZwAm4bAma8Fs0Iq5/t
s1URT2dxOQLym7lyp+ohPcE4whi00Wx/8yppgu8ouvq07pezc2+jSBHfBKwJoJVD
HhraaIMRPH7nwvkthPcjS2EUYJcTSO8l4z6EMc8rNzKePzSwIhzF8Wyi/boBXmao
fh/L2C6TB/jH11JfiTi1+gRO9pNdI5SvIUlp4mrgQFTeZxegvjyROF9hypAOg5br
1G3s8KijDkHcdczeMpJaVdkPxWvoHKE+LUAzfcdd7e1aK9x8e7kCoj2i+9AdpLm0
fyMIlCMzGvIZ9Z1Yt2axPaIYulqvEJ4v9WSjGw8uDU2WxN/mBFjOgnPm/0MIPZWG
0ZWAlMfZ4dr90hvOJjCxxaqkgRxGHkAtZEFIiThisMo36LUfwNOSpIvyhnPPpVRH
IQ4yEIG1eLE3fM2sDTs68IlXq7UAzHZrUvRxE77GBoDl4P55uv9Q5MBS7pVDAsbc
Hl8f4GWyp/mYgIAMXPJrafPbUd/Ed4Ac8UvSjhOMOu0POnkX7IjLQ8QgWa7ADiTK
JeKgdf/41IqjooGhxYR91GU0Gdt4rjH6X1x2GIMVZbG1W2nHd8YQTvAkdEOoBOhd
I6NtEKIOeHq8m1LEWUq2k8MtcxTMzPkoHsvYRsE2333hgXZSCns=
=SMFD
-----END PGP SIGNATURE-----

--bYYwRfO/iwr/Azjl--
