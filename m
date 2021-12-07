Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325EDC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 14:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbhLGO2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 09:28:35 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60469 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233302AbhLGO2e (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Dec 2021 09:28:34 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 26E195C025D;
        Tue,  7 Dec 2021 09:25:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 07 Dec 2021 09:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm2;
         bh=lgc7q/go1lWhGWEjClXSa+hAhr/+3PHj4gA3PTEX8vQ=; b=mi+rRUUEDPt5
        Q92n96KcvqCeVXYmjBXAKHtcAbETBLjEuVXP0V2Ih895hLEvgg9IHOlIg5ExvuEN
        cgkbc9KR859P1ab/9ERmH0bvdnjKaDQrTg93MGKnofpXFKJJ54FYv4qOMkpFp8hQ
        2F+E505B4MW/mI5Po47pWPnNnfAInBatTdrJkKXRp7nmOXC85TZmULqxgYaJEDbY
        RGwfwbyfLfikV2yFwizE8DWBKH9SjKLBgSBekzJkPDZoRPYh7OTsBwxB3yI8mQgl
        V3ErlIDijlZWFIYawYdQ2jyK+qH0W2gnljvPlD+I5e3taZKhB8yP2eNBa+s84P3L
        y4+wy3GjyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=lgc7q/go1lWhGWEjClXSa+hAhr/+3
        PHj4gA3PTEX8vQ=; b=HWsQKqBKCygMPMvldK9DXB4MmLtK6/JH8VSAiUtl1epjI
        jOOo8HzwW9hsUqXyxssoBMWXqtLPMSWwTCAEXwNjCe1l/X+GRFUEHdWYNIxaA3SM
        dtuscHd4IgDyDRYdtw69SFCz7y+OY9GyaiInuuKF8kynbe2ot46cCOuW5dG0OwgH
        7trmKfleD48clt/OA2Us/koFnIQMRGvxEEGMdwCcxIT4eTpi2h/nLL4e7Gb/p2Ro
        oiQrBnGtggdSfxb1Q/n+gv6tsOjKmpqPpX8QjXILfDYvG9RGSU2yn6IIRSh5l4Z/
        +DzgInIMPHyrX80PlkuGd9BC5N9G2KOVEMSbwNBzA==
X-ME-Sender: <xms:v26vYbsniFC3jE1yZdw-keX4E8ZP6RzHZ1bFu6FKQwexDCqyMwRjvw>
    <xme:v26vYccIBbAa34teHoFBsTBmWl72EQyeMZgkPym0hZ3qJOB4b9DMDJQ8cte09G__u
    1DMM1TSD-G83QQoTA>
X-ME-Received: <xmr:v26vYeze2xiSy77bWdtCX1KHVO_tCD6GYn0stqiOwTHqRnfHXCAPY4OQM1jrvUwyzyi6VBsk8ewSwBTESeSp9b9XCX79BtT0gj1wRzbE2qjNj2xUO9w-liKO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ehudffudettefgvdffgeeileejleeftefgtddvudeuudettefgiedvheduleegnecuffho
    mhgrihhnpehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:v26vYaNeWY7vSCXXSuBvmOaBn7zxg8RRlZmNRdTgYQqRiupmjeIb8Q>
    <xmx:v26vYb-Bm7t29HTh6O32qgSxumacsTqOKExIGN4DLXcGDdS6G6Pguw>
    <xmx:v26vYaV0wlYT8NEodOl421x0zeUoGvbJMNlwfNvNHaKO_OeYuAk5aQ>
    <xmx:wG6vYVl7MuE30zdEgoDgpf3S8eNxfcbI-CKzi2BQ5Mm6u6RBsIiIUQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 09:25:03 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6f259eba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 7 Dec 2021 15:54:37 +0000 (UTC)
Date:   Tue, 7 Dec 2021 15:24:21 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>
Subject: [RFC] fetch: update refs in a single transaction
Message-ID: <259de62b26302c10f429d52bec42a8a954bc5ba3.1638886972.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="90hYiai9DEmA+TrB"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--90hYiai9DEmA+TrB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When git-fetch(1) isn't called with the `--atomic` flag, then each
reference will be updated in a separate transaction. As a result, even
if we failed to update a subset of transactions, the remaining refs will
be modified after the command has finished. While this pattern is
reasonably efficient with the files backend where we'd lock and write
each file separately anyway, the upcoming reftable backend could handle
such an update a lot more efficiently if it was batched into a single
transaction given that it could then create a single new reftable slice
instead of creating one slice per updated ref. While this inefficiency
can be easily mitigated by using the `--atomic` flag, this flag cannot
be used in contexts where we want partial-update semantics.

Convert git-fetch(1) to always use a single reference transaction,
regardless of whether it is called with `--atomic` or not. The only
remaining difference between both modes is that with `--atomic` set,
we'd abort the transaciton in case at least one reference cannot be
updated.

Note that this slightly changes semantics of git-fetch(1): if we hit any
unexpected errors like the reference update racing with another process,
then we'll now fail to update any references, too.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 78 ++++++++++++++++---------------------------------
 1 file changed, 25 insertions(+), 53 deletions(-)

Hi,

until now, we have been quite lenient with creating lots of reference
transactions even though they could've been bundled together into a
single transaction. After all, it didn't have much of a downside in most
contexts with the files backend: we'd have to lock each loose ref
separately anyway. I'd like to get some feedback on changing our stance
here, due to multiple reasons:

    - The upcoming reftable backend will be more efficient if we use a
      single transaction to bundle together multiple ref updates given
      that it only needs to write one new slice instead of one per
      update.

    - Syncing refs to disk can be batched more efficiently if we bundle
      ref updates. See my initial patch series to implement fsync-ing
      refs [1] and Peff's benchmarks [2] demonstrating that fetches may
      become a lot slower.

    - The reference-transaction hook can be used more efficiently given
      that it would only need to execute twice, instead of twice per
      updated ref. It also has a more global view of what's happening.
      While this is a concern of mine, it's a non-reason in the context
      of the Git project given that we really ought not to change
      semantics only to appease this hook.

With these reasons in mind, I'm wondering whether we want to accept
refactorings which convert existing code to use batched reference
transactions. While the potential performance improvements are a rather
obvious upside, the downside is that it would definitely change the
failure mode in many cases.

The example I have here with git-fetch(1) would mean that if we were to
race with any other process or if any other unexpected error occurs
which leads us to die, then we'll not commit any change to disk. This
can be seen as an improvement in consistency, but it can also be seen as
a change which breaks current semantics of trying to do as much work as
possible.

I'd thus love to hear about any opinions on this topic.

Patrick

[1]: <cover.1636544377.git.ps@pks.im>
[2]: <YYwvVy6AWDjkWazn@coredump.intra.peff.net>

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f7abbc31ff..c4cfd55452 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -641,9 +641,6 @@ static struct ref *get_ref_map(struct remote *remote,
 	return ref_map;
 }
=20
-#define STORE_REF_ERROR_OTHER 1
-#define STORE_REF_ERROR_DF_CONFLICT 2
-
 static int s_update_ref(const char *action,
 			struct ref *ref,
 			struct ref_transaction *transaction,
@@ -651,7 +648,6 @@ static int s_update_ref(const char *action,
 {
 	char *msg;
 	char *rla =3D getenv("GIT_REFLOG_ACTION");
-	struct ref_transaction *our_transaction =3D NULL;
 	struct strbuf err =3D STRBUF_INIT;
 	int ret;
=20
@@ -661,44 +657,12 @@ static int s_update_ref(const char *action,
 		rla =3D default_rla.buf;
 	msg =3D xstrfmt("%s: %s", rla, action);
=20
-	/*
-	 * If no transaction was passed to us, we manage the transaction
-	 * ourselves. Otherwise, we trust the caller to handle the transaction
-	 * lifecycle.
-	 */
-	if (!transaction) {
-		transaction =3D our_transaction =3D ref_transaction_begin(&err);
-		if (!transaction) {
-			ret =3D STORE_REF_ERROR_OTHER;
-			goto out;
-		}
-	}
-
 	ret =3D ref_transaction_update(transaction, ref->name, &ref->new_oid,
 				     check_old ? &ref->old_oid : NULL,
 				     0, msg, &err);
-	if (ret) {
-		ret =3D STORE_REF_ERROR_OTHER;
-		goto out;
-	}
-
-	if (our_transaction) {
-		switch (ref_transaction_commit(our_transaction, &err)) {
-		case 0:
-			break;
-		case TRANSACTION_NAME_CONFLICT:
-			ret =3D STORE_REF_ERROR_DF_CONFLICT;
-			goto out;
-		default:
-			ret =3D STORE_REF_ERROR_OTHER;
-			goto out;
-		}
-	}
-
-out:
-	ref_transaction_free(our_transaction);
 	if (ret)
 		error("%s", err.buf);
+
 	strbuf_release(&err);
 	free(msg);
 	return ret;
@@ -1107,12 +1071,10 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 		}
 	}
=20
-	if (atomic_fetch) {
-		transaction =3D ref_transaction_begin(&err);
-		if (!transaction) {
-			error("%s", err.buf);
-			goto abort;
-		}
+	transaction =3D ref_transaction_begin(&err);
+	if (!transaction) {
+		error("%s", err.buf);
+		goto abort;
 	}
=20
 	prepare_format_display(ref_map);
@@ -1229,21 +1191,31 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 		}
 	}
=20
-	if (!rc && transaction) {
-		rc =3D ref_transaction_commit(transaction, &err);
-		if (rc) {
-			error("%s", err.buf);
-			goto abort;
-		}
+	if (rc && atomic_fetch) {
+		error(_("aborting reference updates because of atomic fetch"));
+		goto abort;
 	}
=20
-	if (!rc)
-		commit_fetch_head(&fetch_head);
-
-	if (rc & STORE_REF_ERROR_DF_CONFLICT)
+	switch (ref_transaction_commit(transaction, &err)) {
+	case 0:
+		break;
+	case TRANSACTION_NAME_CONFLICT:
 		error(_("some local refs could not be updated; try running\n"
 		      " 'git remote prune %s' to remove any old, conflicting "
 		      "branches"), remote_name);
+		rc =3D -1;
+		break;
+	default:
+		error("%s", err.buf);
+		rc =3D -1;
+		break;
+	}
+
+	if (rc && atomic_fetch)
+		goto abort;
+
+	if (!rc)
+		commit_fetch_head(&fetch_head);
=20
 	if (advice_enabled(ADVICE_FETCH_SHOW_FORCED_UPDATES)) {
 		if (!fetch_show_forced_updates) {
--=20
2.34.1


--90hYiai9DEmA+TrB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGvbpQACgkQVbJhu7ck
PpRQfw/+Opr5vAJ4IZweg/5eKPmwSfNS99aUDG6Iioa5qAOeMaJ9S81IcwZG7JAS
xAGKiTP+cdq6StdwyIM6YTiCY1uma9qhbJhJpKREzxqNe4SM3ie8rhyNhK/kIBnP
Cw/1fRz94oIyIPWQNHIlX+FAEM+xFCWRHdGkOahqCkmwydazh+V/ne1qV3yONpM9
RMqxqwT8+/TNLSRdlX6rvy8bncAsgoc9gse/yZo/gHJ8v+gXFNfmZml5R1cD0ga2
nozs6htmh6T/j7PIsIYp0AiRWZDaCb9+AMEMri6VPHrGcu8JXK7PP6GmxGZ8Bpw+
dOCmdtLaSiMisQiZxUDmsVS9ntoEUpaCJMQbm8z8wytdTb/7iRWBa9tcz1LADTFH
lPxLjHai7SKPNa9X1EJe5r2YbX/TzKOYDYg33ok5SsRtiF+EgwJUVbEQx3mWCTdW
5D1lpxYiz0WzP5oSXVyot08PEp1BMUl5sptEXHewtDqlA+XpBJYAJPZ92gLUYRDm
IrLeMqzHKXGTmYuP40UczJxIxxH5CQYVYM2Uz6KTMBz/xoRnnB2PbjjNHKAG7t0q
HG39RTnp0nv6zsT3INOPF8R+1zQVRfaoj9XbijXnNFZUvJV7rp563N/7ZRjuPu0Q
mhik4DhDy8WUAOvTA9F+WOgapQZsZ+WidfTy2iN0w/78/07w5j4=
=6LkL
-----END PGP SIGNATURE-----

--90hYiai9DEmA+TrB--
