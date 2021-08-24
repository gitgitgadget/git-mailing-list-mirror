Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D07C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC85661008
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbhHXKh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:37:58 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42583 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236262AbhHXKhv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Aug 2021 06:37:51 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8C9395C0079;
        Tue, 24 Aug 2021 06:37:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 24 Aug 2021 06:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=cY7FgXwppEBRjAqOvDLiX2PYvAb
        KZZWADqXAHCXSxMc=; b=QM3bmkt5kp+cObnC5PcN8iNgdPjkc8gfjvZPQBPm3zZ
        B+di+73NMNR02KPvpHHbaEzCo+0DYXnSucVA9ZmThwCltdToN2NUKp3qDti2er5q
        hvCVk/AqgCiyZMdoALqeiv2EEDFKHTixOw4Qp139oIH8jCdrIvbPXEhjz5Iw7fCE
        np3edPtMzgs5rJaSpr6KGOTyZclPEmPOednMtj2bulZ8LNCZ53qFgdpJV4quKpy2
        jn3YtM2dLnkNVm/k0vqL4BnN3JogcLg94WMK7yOgeEoG9qel4KgdovUPsk7BHdJz
        WEb7DpoLyAPUEggTOiboS3kxXFXzk4WINjI18CwQStw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cY7FgX
        wppEBRjAqOvDLiX2PYvAbKZZWADqXAHCXSxMc=; b=f/GHZAhLSHm9zE6E6ro5+y
        om3LqcFAuhz9pm4GcCQXBUnsKCF51k2uJAkTVLG+l4GHzZh3OF6GXLZTiVeJ9q9O
        jAA6buwZ0ydIIhxwR5uoDQP6bv6PuEnBvFfvuR5uQ/MtIDYqJBP8iVoTSzG4u0t0
        A43XTkqc3X+1iKNRNOLYDxs8MAH4JRF6sase5lU6Nhno8GiChPGQgyyTmkWOoVm6
        EZmJ5gwTCCGpDE0hxs/KGdQSBzRg9sqsBbImGUNcXMnz9IIE18wjA2bVRGnytHQx
        AG1Is0/tLvrztSNxoRbI5uj+LmaOsbA6usSgoTb9KlhwLfG+++f0NCFYBYbUaqKw
        ==
X-ME-Sender: <xms:08skYYkfIQ3YLq_v8SsLU0rKLHSWa9XlQVBjni_T-8jaJhKKvh0N-Q>
    <xme:08skYX2fsYE1cH5g6ESu6U7Q5zJ97kMYYfYCBmuIpJYCrZbCF9-tfDma2XyuXM6MO
    RslFdsblcPV9EuJWg>
X-ME-Received: <xmr:08skYWqOhzKQF1JXZcnX4f4DePm1jyKTPLokWZvmJzGfjKBvH6U6EFHzFJADqhlLKqiMPhPHaWtGXBir9MCha1wDCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:08skYUlLRshFkSwZhMCu8p-KHhLUr5VJ-PsXS7kc_zOfu4tbKyM1ow>
    <xmx:08skYW1oIV95A_0Gj6sj7S7s0eXXCdKsTRkdJDrx-EzuFbnSU7PYFA>
    <xmx:08skYbsAbtB6pz1BLsgMYV-I-NbpSR-2Bv4JDHcy2d9dNFHSDeoUSw>
    <xmx:08skYZTR2v7PZfTUD_ZhPQ6tX_LVjisnFQq0eVE4_jlqFClK_tZaWw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Aug 2021 06:37:06 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 72429783 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 24 Aug 2021 10:37:05 +0000 (UTC)
Date:   Tue, 24 Aug 2021 12:37:04 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 3/7] connected: refactor iterator to return next object ID
 directly
Message-ID: <98e981ced94b2e75ac043d0707ef025fbdc9542b.1629800774.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1629800774.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DFgOmh/EfN9hsnkY"
Content-Disposition: inline
In-Reply-To: <cover.1629800774.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DFgOmh/EfN9hsnkY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The object ID iterator used by the connectivity checks returns the next
object ID via an out-parameter and then uses a return code to indicate
whether an item was found. This is a bit roundabout: instead of a
separate error code, we can just return the next object ID directly and
use `NULL` pointers as indicator that the iterator got no items left.
Furthermore, this avoids a copy of the object ID.

Refactor the iterator and all its implementations to return object IDs
directly. This brings a tiny performance improvement when doing a mirror-fe=
tch of a repository with about 2.3M refs:

    Benchmark #1: 328dc58b49919c43897240f2eabfa30be2ce32a4~: git-fetch
      Time (mean =C2=B1 =CF=83):     30.110 s =C2=B1  0.148 s    [User: 27.=
161 s, System: 5.075 s]
      Range (min =E2=80=A6 max):   29.934 s =E2=80=A6 30.406 s    10 runs

    Benchmark #2: 328dc58b49919c43897240f2eabfa30be2ce32a4: git-fetch
      Time (mean =C2=B1 =CF=83):     29.899 s =C2=B1  0.109 s    [User: 26.=
916 s, System: 5.104 s]
      Range (min =E2=80=A6 max):   29.696 s =E2=80=A6 29.996 s    10 runs

    Summary
      '328dc58b49919c43897240f2eabfa30be2ce32a4: git-fetch' ran
        1.01 =C2=B1 0.01 times faster than '328dc58b49919c43897240f2eabfa30=
be2ce32a4~: git-fetch'

While this 1% speedup could be labelled as statistically insignificant,
the speedup is consistent on my machine. Furthermore, this is an end to
end test, so it is expected that the improvement in the connectivity
check itself is more significant.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c        |  8 +++-----
 builtin/fetch.c        |  7 +++----
 builtin/receive-pack.c | 17 +++++++----------
 connected.c            | 15 ++++++++-------
 connected.h            |  2 +-
 fetch-pack.c           |  7 +++----
 6 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c..4a1056fcc2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -657,7 +657,7 @@ static void write_followtags(const struct ref *refs, co=
nst char *msg)
 	}
 }
=20
-static int iterate_ref_map(void *cb_data, struct object_id *oid)
+static const struct object_id *iterate_ref_map(void *cb_data)
 {
 	struct ref **rm =3D cb_data;
 	struct ref *ref =3D *rm;
@@ -668,13 +668,11 @@ static int iterate_ref_map(void *cb_data, struct obje=
ct_id *oid)
 	 */
 	while (ref && !ref->peer_ref)
 		ref =3D ref->next;
-	/* Returning -1 notes "end of list" to the caller. */
 	if (!ref)
-		return -1;
+		return NULL;
=20
-	oidcpy(oid, &ref->old_oid);
 	*rm =3D ref->next;
-	return 0;
+	return &ref->old_oid;
 }
=20
 static void update_remote_refs(const struct ref *refs,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 01513e6aea..cdf0d0d671 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -962,7 +962,7 @@ static int update_local_ref(struct ref *ref,
 	}
 }
=20
-static int iterate_ref_map(void *cb_data, struct object_id *oid)
+static const struct object_id *iterate_ref_map(void *cb_data)
 {
 	struct ref **rm =3D cb_data;
 	struct ref *ref =3D *rm;
@@ -970,10 +970,9 @@ static int iterate_ref_map(void *cb_data, struct objec=
t_id *oid)
 	while (ref && ref->status =3D=3D REF_STATUS_REJECT_SHALLOW)
 		ref =3D ref->next;
 	if (!ref)
-		return -1; /* end of the list */
+		return NULL;
 	*rm =3D ref->next;
-	oidcpy(oid, &ref->old_oid);
-	return 0;
+	return &ref->old_oid;
 }
=20
 struct fetch_head {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2d1f97e1ca..041e915454 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1306,7 +1306,7 @@ static void refuse_unconfigured_deny_delete_current(v=
oid)
 	rp_error("%s", _(refuse_unconfigured_deny_delete_current_msg));
 }
=20
-static int command_singleton_iterator(void *cb_data, struct object_id *oid=
);
+static const struct object_id *command_singleton_iterator(void *cb_data);
 static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 {
 	struct shallow_lock shallow_lock =3D SHALLOW_LOCK_INIT;
@@ -1731,16 +1731,15 @@ static void check_aliased_updates(struct command *c=
ommands)
 	string_list_clear(&ref_list, 0);
 }
=20
-static int command_singleton_iterator(void *cb_data, struct object_id *oid)
+static const struct object_id *command_singleton_iterator(void *cb_data)
 {
 	struct command **cmd_list =3D cb_data;
 	struct command *cmd =3D *cmd_list;
=20
 	if (!cmd || is_null_oid(&cmd->new_oid))
-		return -1; /* end of list */
+		return NULL;
 	*cmd_list =3D NULL; /* this returns only one */
-	oidcpy(oid, &cmd->new_oid);
-	return 0;
+	return &cmd->new_oid;
 }
=20
 static void set_connectivity_errors(struct command *commands,
@@ -1770,7 +1769,7 @@ struct iterate_data {
 	struct shallow_info *si;
 };
=20
-static int iterate_receive_command_list(void *cb_data, struct object_id *o=
id)
+static const struct object_id *iterate_receive_command_list(void *cb_data)
 {
 	struct iterate_data *data =3D cb_data;
 	struct command **cmd_list =3D &data->cmds;
@@ -1781,13 +1780,11 @@ static int iterate_receive_command_list(void *cb_da=
ta, struct object_id *oid)
 			/* to be checked in update_shallow_ref() */
 			continue;
 		if (!is_null_oid(&cmd->new_oid) && !cmd->skip_update) {
-			oidcpy(oid, &cmd->new_oid);
 			*cmd_list =3D cmd->next;
-			return 0;
+			return &cmd->new_oid;
 		}
 	}
-	*cmd_list =3D NULL;
-	return -1; /* end of list */
+	return NULL;
 }
=20
 static void reject_updates_to_hidden(struct command *commands)
diff --git a/connected.c b/connected.c
index b5f9523a5f..cf68e37a97 100644
--- a/connected.c
+++ b/connected.c
@@ -24,7 +24,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	struct child_process rev_list =3D CHILD_PROCESS_INIT;
 	FILE *rev_list_in;
 	struct check_connected_options defaults =3D CHECK_CONNECTED_INIT;
-	struct object_id oid;
+	const struct object_id *oid;
 	int err =3D 0;
 	struct packed_git *new_pack =3D NULL;
 	struct transport *transport;
@@ -34,7 +34,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		opt =3D &defaults;
 	transport =3D opt->transport;
=20
-	if (fn(cb_data, &oid)) {
+	oid =3D fn(cb_data);
+	if (!oid) {
 		if (opt->err_fd)
 			close(opt->err_fd);
 		return err;
@@ -73,7 +74,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 			for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 				if (!p->pack_promisor)
 					continue;
-				if (find_pack_entry_one(oid.hash, p))
+				if (find_pack_entry_one(oid->hash, p))
 					goto promisor_pack_found;
 			}
 			/*
@@ -83,7 +84,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 			goto no_promisor_pack_found;
 promisor_pack_found:
 			;
-		} while (!fn(cb_data, &oid));
+		} while ((oid =3D fn(cb_data)) !=3D NULL);
 		return 0;
 	}
=20
@@ -133,12 +134,12 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		 * are sure the ref is good and not sending it to
 		 * rev-list for verification.
 		 */
-		if (new_pack && find_pack_entry_one(oid.hash, new_pack))
+		if (new_pack && find_pack_entry_one(oid->hash, new_pack))
 			continue;
=20
-		if (fprintf(rev_list_in, "%s\n", oid_to_hex(&oid)) < 0)
+		if (fprintf(rev_list_in, "%s\n", oid_to_hex(oid)) < 0)
 			break;
-	} while (!fn(cb_data, &oid));
+	} while ((oid =3D fn(cb_data)) !=3D NULL);
=20
 	if (ferror(rev_list_in) || fflush(rev_list_in)) {
 		if (errno !=3D EPIPE && errno !=3D EINVAL)
diff --git a/connected.h b/connected.h
index 8d5a6b3ad6..6e59c92aa3 100644
--- a/connected.h
+++ b/connected.h
@@ -9,7 +9,7 @@ struct transport;
  * When called after returning the name for the last object, return -1
  * to signal EOF, otherwise return 0.
  */
-typedef int (*oid_iterate_fn)(void *, struct object_id *oid);
+typedef const struct object_id *(*oid_iterate_fn)(void *);
=20
 /*
  * Named-arguments struct for check_connected. All arguments are
diff --git a/fetch-pack.c b/fetch-pack.c
index 0bf7ed7e47..e6ec79f81a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1912,16 +1912,15 @@ static void update_shallow(struct fetch_pack_args *=
args,
 	oid_array_clear(&ref);
 }
=20
-static int iterate_ref_map(void *cb_data, struct object_id *oid)
+static const struct object_id *iterate_ref_map(void *cb_data)
 {
 	struct ref **rm =3D cb_data;
 	struct ref *ref =3D *rm;
=20
 	if (!ref)
-		return -1; /* end of the list */
+		return NULL;
 	*rm =3D ref->next;
-	oidcpy(oid, &ref->old_oid);
-	return 0;
+	return &ref->old_oid;
 }
=20
 struct ref *fetch_pack(struct fetch_pack_args *args,
--=20
2.33.0


--DFgOmh/EfN9hsnkY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEky88ACgkQVbJhu7ck
PpTjmxAAl8ofVd9de2EiRWAqUgoto78APKtiqrPgz+SrD86Q4FEyG5u/IRrc61yb
zaJHi6BOhNZr5y0Y3PXae7G4yGG0Nd3WMXR3L6/sNOIGZX2wu6E6nXzgPk7LuMmC
BpN0QZRXhKej7HW8/t+ZDB0g7q1fES4/zE//iB/dLnVs3JnuPM/4OqKycvHkixMO
YLYuCU/ynT6GC/w2R9ldihB1PVzYe4Tx2McQ87QJ3tCvWwj56a9IOSRhFfnvSfwB
qjVh5/M4wLYRNouB+HW0ZrTjF9/pxH3cfhD5ejuJ3TXJQAiVpP7k/5gS7Veyh/Xf
UkpwU/eVo+SqwQxq64DM37Wzi3YZlfAxDPXMcm671pXao6CEAuNAWWKDxpx+sicA
BXvVk4+IB2kFsN/oI59gHN1G359KcVLIcpe0s1H5GJCY5DiURCf2tgJGLSOXR0XL
qQ2lAId7ZqTT2wML+MUNArhpcJtkshoI/QSw14VZ6lrMv4hgOnXtIV0RjHQMTqGw
qeL3eELPPYcvzZancmxOm1R7CBVJsyYX0ph7aSd4J9SOebpXr3eaXOOcjlqxj2zp
SgwYGW6ZZNynoq9z85doK2V0WXilpRa7C1w6qzbH/dAm98OEgDzpdAtVoDfXuBta
iA+aFvQoT5M2tahg62oTIQKAnZ9oFlBAuTAqXzHgqnSgSM4UPRQ=
=ictJ
-----END PGP SIGNATURE-----

--DFgOmh/EfN9hsnkY--
