Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED0BC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 09:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbiCJJy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 04:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241151AbiCJJyq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 04:54:46 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAA598F59
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 01:53:25 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 903FC5C01E6;
        Thu, 10 Mar 2022 04:53:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 10 Mar 2022 04:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=FFDMiVkOU7xGuOqudTofeRfhNKddc6mIXPHPCc
        XA4uM=; b=tAIZln4kA5jnzNLvUJdCFGGU9vefXkJaEK9LvLiWg3kS81rY7kQwTi
        CUEHEDN42MtUUWFkYqk/YhZEoqTp5d9XBze9kpHSjs7ySPe9diOdjvFY46hiQtFb
        XBC4zSwD8+DxjIr2wIrOc9TwojDLfPsQ4pJqcWMZbcEG704d2iKQjB/hd5q/Vy2j
        +Gflm/n06eQk5zbKa0aPBbTxPz54g2NeG1m2kkW7rsP6CxjhRE+Szq/DRhiY+4SY
        TfGxeq4274hNX9EvXkTT4TnEX2HwpFvfzLnZJAE1ytTjK2YUJPDeZpKj6sIdcW5D
        t2zguKNXpYGT0g9aZPGSyTlRT05j350Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=FFDMiVkOU7xGuOqud
        TofeRfhNKddc6mIXPHPCcXA4uM=; b=MOABwtW3BTBS4W+V22HyFb6Mn2bUH84yM
        NsG6KLvWRun4+/PhqxmnKkOdopBP0IlN41XPu9BmlM+jQX15YG9OrY0UnCj91Nw0
        PPoaB5BKAo0KSb3ZVTLhzMIdsGgRZkKiFMKcg7g/JVmIaNyWPFWzoSSTt8GI0fdp
        90e5L9QTyaZBnuMpfpiljIXDCi1wkkEdseVeDPiiYpeY+QGoia3QKRKHBV/YoDnR
        /f51xryXefIpzj5viOZik1c7aqWsP9GmrMiYzlYr2W/0REAgppabjq+0QdBuxIQI
        khUINEW7yFywexG38U4iwgVTFG1JVDRZ43Lg54mq98JiGRRm+bXQQ==
X-ME-Sender: <xms:lMopYt81AsBo0sRdE8mo4E8DiVbGU4G_yiWI2swoyeuSbKN8gB-B3w>
    <xme:lMopYhtm4RA1E2MT0g_3KkWhyghXO5WBMzOkD6myjbd2dNC4XukEkYxp1_0UfYoNR
    K_hAlwuIQiKih63XA>
X-ME-Received: <xmr:lMopYrAT-TOw1wO38bf7Lo-m4l4nckMcyktA1MWg8MJU-vvRHDIlxraDpiLBDmUKT9uPIEW13eNACNJciE4yHoTFt4EodHcud_kbNpLbKaLT2_KEl15uY-YD5DU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvtddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetteegffefgfffjeehjeehjedvlefhkedtffegvdekfeevkeettdefudduffegieen
    ucffohhmrghinhepthhhuhhnkhdrohhrghdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:lMopYhfu4PPIS5LxIB8SCx7uDXAEG9DD4YUXT4lgp6w-8IGQ-pHX6Q>
    <xmx:lMopYiPOJZhgVusSjdd80Qc2d5eGk_or5A3ubPzW_zg_rEHyoSr2Gw>
    <xmx:lMopYjnTdqJOtcVrS88Buz790hqBiusMvbByli5dO2clWDCHeXTHsw>
    <xmx:lMopYhetrGI8l-iL26MrooPnhDu2sOjfvvdPaw4ZGHA0H9ZLoFH-5A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Mar 2022 04:53:22 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8abfc7a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 10 Mar 2022 09:53:22 +0000 (UTC)
Date:   Thu, 10 Mar 2022 10:53:21 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/8] core.fsync: new option to harden loose references
Message-ID: <f1e8a7bb3bf0f4c0414819cb1d5579dc08fd2a4f.1646905589.git.ps@pks.im>
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cMW8fHm5nx70gSQA"
Content-Disposition: inline
In-Reply-To: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cMW8fHm5nx70gSQA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When writing loose references to disk we first create a lockfile, write
the updated value of the reference into that lockfile, and on commit we
rename the file into place. According to filesystem developers, this
behaviour is broken because applications should always sync data to disk
before doing the final rename to ensure data consistency [1][2][3]. If
applications fail to do this correctly, a hard crash of the machine can
easily result in corrupted on-disk data.

This kind of corruption can in fact be easily observed with Git when the
machine hard-crashes shortly after writing loose references to disk. On
machines with ext4, this will likely lead to the "empty files" problem:
the file has been renamed, but its data has not been synced to disk. The
result is that the references is corrupt, and in the worst case this can
lead to data loss.

Implement a new option to harden loose references so that users and
admins can avoid this scenario by syncing locked loose references to
disk before we rename them into place.

[1]: https://thunk.org/tytso/blog/2009/03/15/dont-fear-the-fsync/
[2]: https://btrfs.wiki.kernel.org/index.php/FAQ (What are the crash guaran=
tees of overwrite-by-rename)
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/admin-guide/ext4.rst (see auto_da_alloc)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/core.txt |  2 ++
 cache.h                       |  6 +++++-
 config.c                      |  2 ++
 refs/files-backend.c          | 29 +++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 973805e8a9..b67d3c340e 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -564,8 +564,10 @@ core.fsync::
 * `pack-metadata` hardens packfile bitmaps and indexes.
 * `commit-graph` hardens the commit graph file.
 * `index` hardens the index when it is modified.
+* `loose-ref` hardens references modified in the repo in loose-ref form.
 * `objects` is an aggregate option that is equivalent to
   `loose-object,pack`.
+* `refs` is an aggregate option that is equivalent to `loose-ref`.
 * `derived-metadata` is an aggregate option that is equivalent to
   `pack-metadata,commit-graph`.
 * `default` is an aggregate option that is equivalent to
diff --git a/cache.h b/cache.h
index 63a95d1977..b56a56f539 100644
--- a/cache.h
+++ b/cache.h
@@ -1005,11 +1005,14 @@ enum fsync_component {
 	FSYNC_COMPONENT_PACK_METADATA		=3D 1 << 2,
 	FSYNC_COMPONENT_COMMIT_GRAPH		=3D 1 << 3,
 	FSYNC_COMPONENT_INDEX			=3D 1 << 4,
+	FSYNC_COMPONENT_LOOSE_REF		=3D 1 << 5,
 };
=20
 #define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
 				  FSYNC_COMPONENT_PACK)
=20
+#define FSYNC_COMPONENTS_REFS (FSYNC_COMPONENT_LOOSE_REF)
+
 #define FSYNC_COMPONENTS_DERIVED_METADATA (FSYNC_COMPONENT_PACK_METADATA |=
 \
 					   FSYNC_COMPONENT_COMMIT_GRAPH)
=20
@@ -1026,7 +1029,8 @@ enum fsync_component {
 			      FSYNC_COMPONENT_PACK | \
 			      FSYNC_COMPONENT_PACK_METADATA | \
 			      FSYNC_COMPONENT_COMMIT_GRAPH | \
-			      FSYNC_COMPONENT_INDEX)
+			      FSYNC_COMPONENT_INDEX | \
+			      FSYNC_COMPONENT_LOOSE_REF)
=20
 /*
  * A bitmask indicating which components of the repo should be fsynced.
diff --git a/config.c b/config.c
index f03f27c3de..b5d3e6e404 100644
--- a/config.c
+++ b/config.c
@@ -1332,7 +1332,9 @@ static const struct fsync_component_entry {
 	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
 	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
 	{ "index", FSYNC_COMPONENT_INDEX },
+	{ "loose-ref", FSYNC_COMPONENT_LOOSE_REF },
 	{ "objects", FSYNC_COMPONENTS_OBJECTS },
+	{ "refs", FSYNC_COMPONENTS_REFS },
 	{ "derived-metadata", FSYNC_COMPONENTS_DERIVED_METADATA },
 	{ "default", FSYNC_COMPONENTS_DEFAULT },
 	{ "committed", FSYNC_COMPONENTS_COMMITTED },
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f59589d6cc..279316de45 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1392,6 +1392,15 @@ static int refs_rename_ref_available(struct ref_stor=
e *refs,
 	return ok;
 }
=20
+static int files_sync_loose_ref(struct ref_lock *lock, struct strbuf *err)
+{
+	int ret =3D fsync_component(FSYNC_COMPONENT_LOOSE_REF, get_lock_file_fd(&=
lock->lk));
+	if (ret)
+		strbuf_addf(err, "could not sync loose ref '%s': %s", lock->ref_name,
+			    strerror(errno));
+	return ret;
+}
+
 static int files_copy_or_rename_ref(struct ref_store *ref_store,
 			    const char *oldrefname, const char *newrefname,
 			    const char *logmsg, int copy)
@@ -1504,6 +1513,7 @@ static int files_copy_or_rename_ref(struct ref_store =
*ref_store,
 	oidcpy(&lock->old_oid, &orig_oid);
=20
 	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
+	    files_sync_loose_ref(lock, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
@@ -1524,6 +1534,7 @@ static int files_copy_or_rename_ref(struct ref_store =
*ref_store,
 	flag =3D log_all_ref_updates;
 	log_all_ref_updates =3D LOG_REFS_NONE;
 	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
+	    files_sync_loose_ref(lock, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -2819,6 +2830,24 @@ static int files_transaction_prepare(struct ref_stor=
e *ref_store,
 		}
 	}
=20
+	/*
+	 * Sync all lockfiles to disk to ensure data consistency. We do this in
+	 * a separate step such that we can sync all modified refs in a single
+	 * step, which may be more efficient on some filesystems.
+	 */
+	for (i =3D 0; i < transaction->nr; i++) {
+		struct ref_update *update =3D transaction->updates[i];
+		struct ref_lock *lock =3D update->backend_data;
+
+		if (!(update->flags & REF_NEEDS_COMMIT))
+			continue;
+
+		if (files_sync_loose_ref(lock, err)) {
+			ret  =3D TRANSACTION_GENERIC_ERROR;
+			goto cleanup;
+		}
+	}
+
 cleanup:
 	free(head_ref);
 	string_list_clear(&affected_refnames, 0);
--=20
2.35.1


--cMW8fHm5nx70gSQA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIpypAACgkQVbJhu7ck
PpSJXQ/+MpeNu8z5GcRy8zceSolKwH7WIQsRmqDxAWeQXzu5iPS5rN8HV4wTcYZB
r+WUAKGEyvZtc6zS3D7OdLo3r8MB5dQFvMmHDhKECRgUQtEzfCTSP10I7uMdlPYE
72M2+OjnE3AtY9JX10LIlCVZzN0V+2XwWCcYBFqQkq3Ouokl0Tblo1BSJIqLmRyU
rEsXflVNgCiFspvbGbr/4cQ4nkHZ32IlatWW6Z2Ikju11WWadHXuVSQ2byDCaT7L
au+lRd3eHKqw+C5cE9obD/0jX7DPokY0fuxt22sMxjkeoA66qjUYadfCzx9q7jql
SB4jYU8RLwBYoMGOUo654W4fK76fvpCDmBRzxZqr0Ya6TXSMpgWHP6NTMbg9IFgt
XnhfM/OnLs/CPHajx2j4tP/ZbyXKSZpIW0BwBzt6euvB3/13U3HjcPdr03sFxrv9
bHNUtCW+g/6gxUNLS/b0rmtoJ5fhtcOAMgz5Bc8gKzAzgtyZYaevn8ZZhGJV/pNh
Y9pE9wT1j/KS9RZDYmC8AR0JjS7CcBNB4+Wi8KioRt41J2rsWjgrV35U1UrFkuI2
sohIUIBIeplgkB7wuOwY0jCmnQLNLRUx/vuESWkDky24veCUTNJwIdm+5vysJWUf
sacG9uRQJBEi+f3QOGrdpIYk2HzjTQE0vRRa0xKZBw7QrN0aui4=
=XkcI
-----END PGP SIGNATURE-----

--cMW8fHm5nx70gSQA--
