Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1437C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F8F610F9
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbhHTKJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:09:21 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57065 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237943AbhHTKJR (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Aug 2021 06:09:17 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 06ED05C008E;
        Fri, 20 Aug 2021 06:08:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 20 Aug 2021 06:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=LZEdixNdjsqGnzyLCbI1+ntGcH0
        xGuRDwcSdmxuUfl4=; b=vPVBWL5LSpsp8/JOe2BvZ+Y9F/oC3uk/3I7pEsi/xzC
        t9egr3KBMrIQLG3KjLLxowtUA6ooTLPAbkWPLB2rUaAuMPddGjp0XANfjIATbaKG
        sFku5afoa6RzKxe7JtB3ikh9QjOH4e/37ttNHko6Zpe6b6YhUv37DdJZpiDe1QDE
        twJlO3xsagiELGZW1DJPT7UQWiLvtJYqY82UEO65TsFsDiQBLU2vsEZkwI4LnMRC
        Ns7TwWkmar6qOC8zMTQvZs40Sr42HCgqVklDi10XbONJz20uwdsIJWgGFIQTjA5p
        UsHsKVWeADLSyelaOIeF1QpAcJ3G1mljmrnWwiGCzbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=LZEdix
        NdjsqGnzyLCbI1+ntGcH0xGuRDwcSdmxuUfl4=; b=IM+71MQ5oN6ijgfp2a+S9Q
        vKUka0ghK4yjYMi1Rbs38Pww4eOfGRAQkTb/upF3jkKB0ezK1YqbA7J+Zmir9zZg
        aJlzht6ABJ4+qdfMw6iAg1DdP5+YNvPQF1Y0TevsMDNDz4f6TYzVMRRHMoCXca19
        ftl12a3PsvXk6BUWiVm8PVEOhk16Xjoc1sSh9HQNK2rHaE/PCSEKeRAdSGMqXtze
        sMQ3mgX+WJxu5CFMUvtEBtDMwSG/TDtVse+CqtmeRvCwrdQKqFEaP7x+tCdSj6wx
        3XOdpAXcvTQNKDeb7p55wCabu1hkyZSkPjprzgU3qSU9kNw8NIsIvBffuoW/5spQ
        ==
X-ME-Sender: <xms:J38fYfj2WpVcyiRG6M_EC6yoccE-tDKCeCmK1jKao7uVcsUtUYP5rw>
    <xme:J38fYcATNFbrXUulgYHqEr7ClwoschWhK-Ne7CAMK-3kOHlsPOUfIUxxU6fM08Rst
    bK-NQmOQrGLupSuQQ>
X-ME-Received: <xmr:J38fYfFASyorsLDVR7-iveCZxV7y7JsEGdcsd4ybSwtw2fTOC7-aACpIWevKb8HcKFU4v0JRjub7X1iwbT8TqGyOCrZMD-1rs4EjH2-bS2UX-qJsLK2JwJ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleelgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:J38fYcSYcr8dShN1ZdBEK4oCvIRO6zViOKOVhizwHPw9kNcijC00CQ>
    <xmx:J38fYczn_oFHOX3zFAsgxHG7KJlvTSFRKuJWg9DYrf7B0u5Z7tzSoA>
    <xmx:J38fYS6WwHb9ChfXeM0FgM95KAQt4h6hrZjfJxUdtIS4g5WBRse6zw>
    <xmx:J38fYX-iGgWMITi8U0M1noEshS_bvZyueCKA6Pd3izAmD7fhIAy18w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Aug 2021 06:08:39 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 39dda667 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 20 Aug 2021 10:08:38 +0000 (UTC)
Date:   Fri, 20 Aug 2021 12:08:37 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] connected: refactor iterator to return next object ID
 directly
Message-ID: <3bdad7bc8b0debd44138a4d3df5744d5a245475d.1629452412.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0v4Rf7QIe2MRJmQq"
Content-Disposition: inline
In-Reply-To: <cover.1629452412.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0v4Rf7QIe2MRJmQq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The object ID iterator used by the connectivity checks returns the next
object ID via an out-parameter and then uses a return code to indicate
whether an item was found. This is a bit roundabout: instead of a
separate error code, we can just retrun the next object ID directly and
use `NULL` pointers as indicator that the iterator got no items left.
Furthermore, this avoids a copy of the object ID.

Refactor the iterator and all its implementations to return object IDs
directly. While I was honestly hoping for a small speedup given that we
can now avoid a copy, both versions perform the same. Still, the end
result is easier to understand and thus it makes sense to keep this
refactoring regardless.

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
index a74558f30c..817a651936 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -544,7 +544,7 @@ static void write_followtags(const struct ref *refs, co=
nst char *msg)
 	}
 }
=20
-static int iterate_ref_map(void *cb_data, struct object_id *oid)
+static struct object_id *iterate_ref_map(void *cb_data)
 {
 	struct ref **rm =3D cb_data;
 	struct ref *ref =3D *rm;
@@ -555,13 +555,11 @@ static int iterate_ref_map(void *cb_data, struct obje=
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
index 5fd0f7c791..76ce73ccf5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -962,7 +962,7 @@ static int update_local_ref(struct ref *ref,
 	}
 }
=20
-static int iterate_ref_map(void *cb_data, struct object_id *oid)
+static struct object_id *iterate_ref_map(void *cb_data)
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
index a419de5b38..0abda033bc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1307,7 +1307,7 @@ static void refuse_unconfigured_deny_delete_current(v=
oid)
 	rp_error("%s", _(refuse_unconfigured_deny_delete_current_msg));
 }
=20
-static int command_singleton_iterator(void *cb_data, struct object_id *oid=
);
+static struct object_id *command_singleton_iterator(void *cb_data);
 static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 {
 	struct shallow_lock shallow_lock =3D SHALLOW_LOCK_INIT;
@@ -1725,16 +1725,15 @@ static void check_aliased_updates(struct command *c=
ommands)
 	string_list_clear(&ref_list, 0);
 }
=20
-static int command_singleton_iterator(void *cb_data, struct object_id *oid)
+static struct object_id *command_singleton_iterator(void *cb_data)
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
@@ -1764,7 +1763,7 @@ struct iterate_data {
 	struct shallow_info *si;
 };
=20
-static int iterate_receive_command_list(void *cb_data, struct object_id *o=
id)
+static struct object_id *iterate_receive_command_list(void *cb_data)
 {
 	struct iterate_data *data =3D cb_data;
 	struct command **cmd_list =3D &data->cmds;
@@ -1775,13 +1774,11 @@ static int iterate_receive_command_list(void *cb_da=
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
index b5f9523a5f..374b145355 100644
--- a/connected.c
+++ b/connected.c
@@ -24,7 +24,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	struct child_process rev_list =3D CHILD_PROCESS_INIT;
 	FILE *rev_list_in;
 	struct check_connected_options defaults =3D CHECK_CONNECTED_INIT;
-	struct object_id oid;
+	struct object_id *oid;
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
index 8d5a6b3ad6..56cc95be2d 100644
--- a/connected.h
+++ b/connected.h
@@ -9,7 +9,7 @@ struct transport;
  * When called after returning the name for the last object, return -1
  * to signal EOF, otherwise return 0.
  */
-typedef int (*oid_iterate_fn)(void *, struct object_id *oid);
+typedef struct object_id *(*oid_iterate_fn)(void *);
=20
 /*
  * Named-arguments struct for check_connected. All arguments are
diff --git a/fetch-pack.c b/fetch-pack.c
index 0bf7ed7e47..1a6242cd71 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1912,16 +1912,15 @@ static void update_shallow(struct fetch_pack_args *=
args,
 	oid_array_clear(&ref);
 }
=20
-static int iterate_ref_map(void *cb_data, struct object_id *oid)
+static struct object_id *iterate_ref_map(void *cb_data)
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


--0v4Rf7QIe2MRJmQq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEffyQACgkQVbJhu7ck
PpTKEQ//UgLmDquMCM30BYeuzZh4sNOyyI0oBAg0G3U5LASbUuFzOUtcq3X+Zyyj
NuDNbLGwr6tT2eeWP6TJLcsiJQphEtB6RTOq4O+hoACPxqFKJBOH5muwakbmMi1m
dZeVHIMd/pcPmC5MAK+C6p5qCtuDzIxn89vS7JGfY2WlV/2tpn/F9C576H5VSRAw
rQ+9NADkFE5y8UFvs26xtvQf+jB3JHtuh3n8tFgpe7bX6ig0Gxm4YNgVv334xtFP
10OXTgXT30QYJzgGqTC+6q1oFdVVdFzix/3gN3iZOruE00hXQcjPacwg0sV73kik
tWS5zWSuX3MouxfNmQLFILbwvOSeH6CKDda9pSN7aRZKHtHVJpsSZxjKDr1YbGJa
87Gbp/iZLhaoR8Ct8EwF6p201hXSnrljCliPOLUVQiZJi+iPGWr4BbEMX9JNxqAy
vdXdbv3Vry05vMgMWYWPv+YUq64gn5ykMnKtMluB+yURdTRbxlVfHzQiDhj4lZKW
OFj07Q6tTDAysFo9pkpIlMibjQrzFTmQWi/z04Mj9byL8TBTcULVZRvBBC5iMEpD
2zj4OHVwnXR+KpGvZSqnI7iUEycr5cXkcjpkcJyS7ZWFHpHhV/znI10WHH4EHb4p
SUF7QH3bK84PY+12/iWTPK6gQ7zLjjbirv7EVxGzZ5FpzLHKqlM=
=Wxhx
-----END PGP SIGNATURE-----

--0v4Rf7QIe2MRJmQq--
