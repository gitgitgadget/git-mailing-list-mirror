Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36024C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 141BF6108D
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhESTPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 15:15:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39053 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231939AbhESTPF (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 May 2021 15:15:05 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C2B35C01CE
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 19 May 2021 15:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm1; bh=XBE2DKNW8XYwAnCyazi/JQgjabzUqmqn1KFXWTbZ
        7+0=; b=FJdV7OVIDWcPW65bZfCOY5e77sVMXq2zi8kbWswbCkBuRBwvR4YYhUJg
        e2aWBrE/m4k1acvBHjx+SVYx/AalSRVqHVcaxgsO6Wju6WDxSmKseVndzYHuqLEa
        FHUHMZiGQMHpR3PKS3uiLFI3vv692/m+7f+90ACmQ89MxvQH9eUbT4qMyXHmqU59
        p5r6Xne9EaElR2d95mJTogU8q6hgXWsikONN0PljNTk96Wk+ZdOoI+43MODAXutF
        TzlBcDsJUXUiZ6nNqoJYsBVshZ0xzDV4pRU6jkFwzybuBzUoE+7rHs0MCnmZuaG+
        v7Ucrnwlfj6xGkapWYWxfeAPmiFHIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=XBE2DK
        NW8XYwAnCyazi/JQgjabzUqmqn1KFXWTbZ7+0=; b=BmS8PEjn1eaeguXJJL9WoJ
        6wKHgpFNXFOKn2MB5YswPzP51JHGT04hPgOs5ijbRpBlcu92Y7vRyaXCBuP+VsPa
        WwGgfAl0Hsv6CSVT5Jl9MeJtVL/1qbmYbMGs/l5d+s6dVfdfRbrZ0cPJdYJ7WCnt
        MCInGxvYkPBk6rfzBdNRQKoyhEXKWMSmf5pJzj+GKTQPN+RghrYi2arpr3HAIOEF
        kpKPDWeijKL3brFa8ZWfK1yV0nQORAr+XH90ny44AGNgWKNQZcK5udfYgBmoZ9Sm
        jNQC872peDn/5sZhNz0MT7QmT+n0t7TBDjVU81VcaKW2AuTgnnoT5CjA6b6c6g0w
        ==
X-ME-Sender: <xms:aWOlYO7MZ9N1xuX3jOwm53r078fBKYSb-Corc2mBiFjzJceQ1NQ9dA>
    <xme:aWOlYH4xrtxGi_udyWx3tsWMksy_tC16_iZ5BRhcMndwejDBLbsVRtH8BkQyrdYOs
    5VlxZREm_9ZVAU0rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiledgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrddukeefrdefjedrudehieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:aWOlYNeeKlItUNc-zmuxIKuS-CMyGogOIH5e6QS30AWtsptZKUmLqw>
    <xmx:aWOlYLI38ms4k83nX3agXK-DaW-nRegdMetnEWkhTrbJUb-HpaEoiw>
    <xmx:aWOlYCJnh4SLuwmNzTeRG2be14Iz2bg-Rxr0BjxWDZ82RW64Q7OdEQ>
    <xmx:aWOlYHWnX7Wjxjk6mqPod6vLbZU7EEqu4VLAaEML7gYBosXImzkw8A>
Received: from vm-mail.pks.im (x4db7259c.dyn.telefonica.de [77.183.37.156])
        by mail.messagingengine.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:44 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 36817fdd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 19 May 2021 19:13:44 +0000 (UTC)
Date:   Wed, 19 May 2021 21:13:43 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 6/8] connected: implement connectivity check via temporary
 object dirs
Message-ID: <d01685a3ec82c3415654779c122927388fc433db.1621451532.git.ps@pks.im>
References: <cover.1621451532.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eZGG9RXSxauXEirZ"
Content-Disposition: inline
In-Reply-To: <cover.1621451532.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eZGG9RXSxauXEirZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The connectivity checks are currently implemented via git-rev-list(1):
we simply ignore any preexisting refs via `--not --all`, and pass all
new refs which are to be checked via its stdin. While this works well
enough for repositories which do not have a lot of references, it's
clear that `--not --all` will linearly scale with the number of refs
which do exist: for each reference, we'll walk through its commit as
well as its five parent commits (defined via `SLOP`). Given that many
major hosting sites which use a pull/merge request workflow keep refs to
the request's HEAD, this effectively means that `--not --all` will do a
nearly complete graph walk.

We can compute the set of pushed objects much more easily though. We
know exactly which objects were just received, which is the set of
objects which are in git-receive-pack(1)'s object quarantine directory.
While this may overshoot new objects because the client may have sent
objects which we already know, it lets us avoid doing a graph walk of
preexisting commits.

The implementation of this is quite simple: we iterate through all loose
and packed objects in the object directory, and for each object we check
whether its immediate referenced objects exist. There is no need to do a
walk beyond these direct links: if the receiving repository already has
the directly referenced object, then it's not a new object in the first
place and thus does not need a re-check. If the referenced object is a
new one and we can load it, then we know that it will eventually be
checked via the quarantined objects walk, too.

Finally, after we have concluded that all quarantined objects are indeed
fully connected, the only thing left to check is whether all reference
updates reference an existing object.

This new connectivity check will be wired up in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 connected.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 connected.h |  19 ++++++
 2 files changed, 211 insertions(+)

diff --git a/connected.c b/connected.c
index b18299fdf0..ab0eb9f974 100644
--- a/connected.c
+++ b/connected.c
@@ -6,6 +6,13 @@
 #include "transport.h"
 #include "packfile.h"
 #include "promisor-remote.h"
+#include "object.h"
+#include "tree-walk.h"
+#include "commit.h"
+#include "tag.h"
+#include "progress.h"
+#include "tmp-objdir.h"
+#include "oidset.h"
=20
 /*
  * If we feed all the commits we want to verify to this command
@@ -151,3 +158,188 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	sigchain_pop(SIGPIPE);
 	return finish_command(&rev_list) || err;
 }
+
+struct connected_payload {
+	struct repository *repo;
+	struct progress *progress;
+	struct oidset seen;
+	size_t checked_objects;
+	size_t missing_objects;
+};
+
+static void check_missing(struct connected_payload *payload, const struct =
object_id *oid)
+{
+	if (oidset_contains(&payload->seen, oid))
+		return;
+	if (oid_object_info(payload->repo, oid, NULL) <=3D 0)
+		payload->missing_objects++;
+	oidset_insert(&payload->seen, oid);
+	display_progress(payload->progress, ++payload->checked_objects);
+}
+
+static int check_quarantined_object(const struct object_id *oid, enum obje=
ct_type type,
+				    void *content, unsigned long size, void *data)
+{
+	struct connected_payload *payload =3D data;
+	struct object *object;
+	int eaten;
+
+	object =3D parse_object_buffer(payload->repo, oid, type, size, content, &=
eaten);
+	if (!object) {
+		if (!eaten)
+			free(content);
+		error(_("could not parse quarantined object %s"), oid_to_hex(oid));
+		return -1;
+	}
+	if (!eaten)
+		free(content);
+
+	if (type =3D=3D OBJ_TREE) {
+		struct tree *tree =3D (struct tree *)object;
+		struct tree_desc tree_desc;
+		struct name_entry entry;
+
+		if (init_tree_desc_gently(&tree_desc, tree->buffer, tree->size))
+			return -1;
+		while (tree_entry_gently(&tree_desc, &entry))
+			check_missing(payload, &entry.oid);
+
+		free_tree_buffer(tree);
+	} else if (type =3D=3D OBJ_COMMIT) {
+		struct commit *commit =3D (struct commit *) object;
+		struct commit_list *parents;
+
+		check_missing(payload, get_commit_tree_oid(commit));
+		for (parents =3D commit->parents; parents; parents =3D parents->next)
+			check_missing(payload, &parents->item->object.oid);
+	} else if (type =3D=3D OBJ_TAG) {
+		check_missing(payload, get_tagged_oid((struct tag *) object));
+	} else {
+		error(_("unexpected object type"));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int loose_object_iterator(const struct object_id *oid,
+				 const char *path, void *_data)
+{
+	struct connected_payload *payload =3D _data;
+	enum object_type type;
+	unsigned long size;
+	void *content;
+
+	if (read_loose_object(path, oid, &type, &size, NULL) < 0)
+		return -1;
+
+	oidset_insert(&payload->seen, oid);
+	display_progress(payload->progress, ++payload->checked_objects);
+
+	if (type =3D=3D OBJ_BLOB)
+		return 0;
+	if (read_loose_object(path, oid, &type, &size, &content) < 0)
+		return -1;
+
+	return check_quarantined_object(oid, type, content, size, payload);
+}
+
+static int packed_object_iterator(const struct object_id *oid,
+				  struct packed_git *pack, uint32_t pos,
+				  void *_data)
+{
+	off_t off =3D nth_packed_object_offset(pack, pos);
+	struct connected_payload *payload =3D _data;
+	struct object_info oi =3D OBJECT_INFO_INIT;
+	enum object_type type;
+	unsigned long size;
+	void *content;
+
+	oi.typep =3D &type;
+	if (packed_object_info(payload->repo, pack, off, &oi) < 0)
+		return -1;
+
+	oidset_insert(&payload->seen, oid);
+	display_progress(payload->progress, ++payload->checked_objects);
+
+	if (type =3D=3D OBJ_BLOB)
+		return 0;
+
+	oi.contentp =3D &content;
+	oi.sizep =3D &size;
+
+	if (packed_object_info(payload->repo, pack, off, &oi) < 0)
+		return -1;
+
+	return check_quarantined_object(oid, type, content, size, payload);
+}
+
+static int pack_dir_iterator(const char *full_path, size_t full_path_len,
+			     const char *file_path, void *data)
+{
+	if (ends_with(full_path, ".idx")) {
+		struct packed_git *pack =3D add_packed_git(full_path, full_path_len, 1);
+		if (!pack) {
+			error(_("unable to add quarantined pack"));
+			return -1;
+		}
+
+		if (for_each_object_in_pack(pack, packed_object_iterator, data,
+					    FOR_EACH_OBJECT_PACK_ORDER) < 0) {
+			error(_("unable to iterate packed objects"));
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+int check_connected_quarantine(struct repository *repo,
+			       struct tmp_objdir *quarantine,
+			       oid_iterate_fn fn, void *cb_data)
+{
+	struct connected_payload payload =3D {
+		.repo =3D repo,
+		.seen =3D OIDSET_INIT,
+	};
+	struct object_id oid;
+	int ret;
+
+	payload.progress =3D start_delayed_progress("Checking connectivity", 0);
+
+	/*
+	 * Iterate through all loose and packed objects part of the object
+	 * quarantine and verify that for each of them, all directly referenced
+	 * objects exist.
+	 */
+	if (for_each_loose_file_in_objdir(tmp_objdir_path(quarantine),
+					  loose_object_iterator, NULL,
+					  NULL, &payload) < 0) {
+		error(_("unable to check quarantined loose objects"));
+		ret =3D -1;
+		goto out;
+	}
+
+	if (for_each_file_in_pack_dir(tmp_objdir_path(quarantine),
+				      pack_dir_iterator, &payload) < 0) {
+		error(_("unable to check quarantined packed objects"));
+		ret =3D -1;
+		goto out;
+	}
+
+	/*
+	 * After we've verified that all quarantined objects are indeed
+	 * connected, we need to verify that all new tips are contained in the
+	 * repository, too.
+	 */
+	while (!fn(cb_data, &oid)) {
+		if (oid_object_info(repo, &oid, NULL) <=3D 0)
+			payload.missing_objects++;
+		display_progress(payload.progress, ++payload.checked_objects);
+	}
+
+out:
+	stop_progress(&payload.progress);
+	oidset_clear(&payload.seen);
+	return ret || payload.missing_objects !=3D 0;
+}
diff --git a/connected.h b/connected.h
index 8d5a6b3ad6..336b6f362e 100644
--- a/connected.h
+++ b/connected.h
@@ -3,6 +3,7 @@
=20
 struct object_id;
 struct transport;
+struct tmp_objdir;
=20
 /*
  * Take callback data, and return next object name in the buffer.
@@ -62,4 +63,22 @@ struct check_connected_options {
 int check_connected(oid_iterate_fn fn, void *cb_data,
 		    struct check_connected_options *opt);
=20
+/*
+ * Make sure that all objects in the given quarantine directory are connec=
ted
+ * and that all OIDs returned by the given callback are backed by an exist=
ing
+ * object. The quarantine directory must have been made available to the
+ * repository via `add_to_alternates_memory()`.
+ *
+ * Given that objects are enumerated via the quarantine directory directly,
+ * this check should in general be more efficient than `check_connected()`
+ * while being more pedantic at the same time (e.g. quarantined objects wh=
ich
+ * aren't referenced by anything but which do have missing links would get
+ * rejected).
+ *
+ * Return 0 if Ok, non zero otherwise (i.e. some missing objects)
+ */
+int check_connected_quarantine(struct repository *repo,
+			       struct tmp_objdir *quarantine,
+			       oid_iterate_fn fn, void *cb_data);
+
 #endif /* CONNECTED_H */
--=20
2.31.1


--eZGG9RXSxauXEirZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmClY2YACgkQVbJhu7ck
PpSL0A/8Ca5NCZBe1qiuzP/Rv9f13QKTg8KcEHGbsepnSd+QTtEYRDt2kfJfP6kk
Bo+MgzhIES2irvsdRbteHQN7exDv16Q/fMbe/SgbkU2PxUozuhQmlWitWbkeLH90
l7+2dwHsYbR9FJFG4QsfeFSarmRfCLiYAvTsDqxP3sfRh1YPRPyYx3s/kHI+SUxZ
tulI8AHHmeK9v3uSkWyF+shm/aXK8ZqPbnIvPv1tQNcWi2gh6Fz8QP4d2B6TTzyk
69PR8hkcUbnk4124MnOy6yyBAsjzHcItVPbQu8aDi4MI4uPAw32IWtiqvP9TEtXQ
QDYSg5h4mxsT2XDTslf3TsnOBoaD+FSbSqwq/D021FTNtYiaevyVHQXheB5hgx2V
Mui0ohjZ4QiNXhr6Y3sip4WFKn0GfcKxutFCnKWQioTC4xktvGjCUNgZd7RrjlDb
XzSdSueBpWpW+Tq8vQ4yShW0pqx6eSqpRKhWaje2WJOA9ESfAaN4T6dS0TGBvU9h
2fDsCCYfncd7pePsM3wizZGM6lHjsDFPbcflgtzRgPWJJ/SMitD8wNPSFKoHi1mS
hHAK4GfPoQIJRFIVvMtsW+rTpcR23hawgPKggWUDvOkg6TyeDWgob7E6LBlGAnJe
VkKZ/X9HdyWbxYo9ypRbJZ4LxyGlxr9FF5iNrzQ4Z6xcEEwQPQ4=
=GdoT
-----END PGP SIGNATURE-----

--eZGG9RXSxauXEirZ--
