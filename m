Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70EDC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 09:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347657AbiCKKAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 05:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243470AbiCKKAI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 05:00:08 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC1E28E3F
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 01:59:04 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A59E5C0287;
        Fri, 11 Mar 2022 04:59:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 11 Mar 2022 04:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=N7+A+CrNO4hE3v1uMRff/VVONSDTjV85XznBL1
        IL0pk=; b=CJXG6ollsq4b5weIhigPt0RkUgq3MIXWPsLnrtZtuCh4YiMdQK1tUB
        06R1xvok8IBD6jB/sRA55iGzAdcMiDvGljswfUTvCHtKKHk3fb5621xAfDzegKKD
        fs0hRSkCi4+y7eh1p97ulswVQlUZxFgXz7iQbJW8L85fZ9iKI9wsaLnzdiy8Bx9m
        788WE9eEr9inkt5Jfup1+fikpcCRSQwp0wwj7x/g4zHcolvrf3zMj+Bk/rw3z8V2
        2ztav8Wxf/OmMnzSntGu/ml3YKA3Jd7EmmbRjMgWdbqAlybVxKKFMQQgN4upTcn8
        xnjCZFP8QHi2rwVPWsjIVuwM0HS6coOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=N7+A+CrNO4hE3v1uM
        Rff/VVONSDTjV85XznBL1IL0pk=; b=b5jaGnm/aUdbCw9TCcVDXS+OEg2mzjAOM
        Jti77vGtuPHG3Ymq5I8FFzlIIDue56UUht6qya/NxJZ7FTKzEOmkVlmVs8an88G3
        PP96UX/K0YmnrgRhQKUJ+i3rthngups/VoQEHlH8/zRPHmTqzH+jsldWiVdXJpaM
        E085CUINhQbIlbOKC0GOHPbCW2epteFGbefMOFz4pWliJ0drJ5vj/w9QxZT9s072
        LvDHIIySdW/z52OVdPZIUhCwTKOuNBYh/gBghMe/nFHPtt+Zmvj2X7+QkVeDwmfN
        PYgK6M3EPtg/Cc1qypto/N1G8qZBpu1K9fyHUxWRh9YFYoCebopvQ==
X-ME-Sender: <xms:Zx0rYgfYrQNusmqHser0lokG_re98SlEmpxpO8Wup7Je_2Fg2tEEDw>
    <xme:Zx0rYiNhhUHmQ3PSo7vHSxvkc8seoCgUU6xbaHx-D31pNOi8zst3mpMX5DyNhbwfY
    y4iLGDAvKtMn86_Bg>
X-ME-Received: <xmr:Zx0rYhgmtJi02upvSZO03dSDePvsieYmjZ5Y_s6QadwkPAcoC3_kv7k2LweQvXNfBC_d1OOegvgdmX5hy9PG1uZhzgx5j3ZzCxBZdtlK8-VAlnycRBE20r6R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvvddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetteegffefgfffjeehjeehjedvlefhkedtffegvdekfeevkeettdefudduffegieen
    ucffohhmrghinhepthhhuhhnkhdrohhrghdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:aB0rYl808RF5udWkcBRgyz3yNQ9GROkq8GcYR8HxMVa2whCRO4wNBA>
    <xmx:aB0rYstqmD65kCY8OJxcnlERAX52uvNXUQqO9ENiwMtJwO03pjhABg>
    <xmx:aB0rYsF24pRQhmmsBf4lHls2-raSPkr7b1hI1EKG7pMtTXytVEymjQ>
    <xmx:aB0rYh965cM1YjarIWMCWgKQ787DB17bmpayNl-WVALl8QwUSxyX9g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Mar 2022 04:59:02 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ede7a3f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Mar 2022 09:59:00 +0000 (UTC)
Date:   Fri, 11 Mar 2022 10:58:59 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] core.fsync: new option to harden references
Message-ID: <47dd79106b93bb81750320d50ccaa74c24aacd28.1646992380.git.ps@pks.im>
References: <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f6gA11ZyWQh/fgCg"
Content-Disposition: inline
In-Reply-To: <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--f6gA11ZyWQh/fgCg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When writing both loose and packed references to disk we first create a
lockfile, write the updated values into that lockfile, and on commit we
rename the file into place. According to filesystem developers, this
behaviour is broken because applications should always sync data to disk
before doing the final rename to ensure data consistency [1][2][3]. If
applications fail to do this correctly, a hard crash of the machine can
easily result in corrupted on-disk data.

This kind of corruption can in fact be easily observed with Git when the
machine hard-resets shortly after writing references to disk. On
machines with ext4, this will likely lead to the "empty files" problem:
the file has been renamed, but its data has not been synced to disk. The
result is that the reference is corrupt, and in the worst case this can
lead to data loss.

Implement a new option to harden references so that users and admins can
avoid this scenario by syncing locked loose and packed references to
disk before we rename them into place.

[1]: https://thunk.org/tytso/blog/2009/03/15/dont-fear-the-fsync/
[2]: https://btrfs.wiki.kernel.org/index.php/FAQ (What are the crash guaran=
tees of overwrite-by-rename)
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/admin-guide/ext4.rst (see auto_da_alloc)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Hi,

here's my updated patch series which implements syncing of refs. It
applies on top of Neeraj's v6 of "A design for future-proofing fsync()
configuration".

I've simplified these patches a bit:

    - I don't distinguishing between "loose" and "packed" refs anymore.
      I agree with Junio that it's probably not worth it, but we can
      still reintroduce the split at a later point without breaking
      backwards compatibility if the need comes up.

    - I've simplified the way loose refs are written to disk so that we
      now sync them when before we close their files. The previous
      implementation I had was broken because we tried to sync after
      closing.

Because this really only changes a few lines of code I've also decided
to squash together the patches into a single one.

Patrick

 Documentation/config/core.txt | 1 +
 cache.h                       | 7 +++++--
 config.c                      | 1 +
 refs/files-backend.c          | 1 +
 refs/packed-backend.c         | 3 ++-
 5 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 37105a7be4..812cca7de7 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -575,6 +575,7 @@ but risks losing recent work in the event of an unclean=
 system shutdown.
 * `index` hardens the index when it is modified.
 * `objects` is an aggregate option that is equivalent to
   `loose-object,pack`.
+* `reference` hardens references modified in the repo.
 * `derived-metadata` is an aggregate option that is equivalent to
   `pack-metadata,commit-graph`.
 * `committed` is an aggregate option that is currently equivalent to
diff --git a/cache.h b/cache.h
index cde0900d05..033e5b0779 100644
--- a/cache.h
+++ b/cache.h
@@ -1005,6 +1005,7 @@ enum fsync_component {
 	FSYNC_COMPONENT_PACK_METADATA		=3D 1 << 2,
 	FSYNC_COMPONENT_COMMIT_GRAPH		=3D 1 << 3,
 	FSYNC_COMPONENT_INDEX			=3D 1 << 4,
+	FSYNC_COMPONENT_REFERENCE		=3D 1 << 5,
 };
=20
 #define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
@@ -1017,7 +1018,8 @@ enum fsync_component {
 				  FSYNC_COMPONENTS_DERIVED_METADATA | \
 				  ~FSYNC_COMPONENT_LOOSE_OBJECT)
=20
-#define FSYNC_COMPONENTS_COMMITTED (FSYNC_COMPONENTS_OBJECTS)
+#define FSYNC_COMPONENTS_COMMITTED (FSYNC_COMPONENTS_OBJECTS | \
+				    FSYNC_COMPONENT_REFERENCE)
=20
 #define FSYNC_COMPONENTS_ADDED (FSYNC_COMPONENTS_COMMITTED | \
 				FSYNC_COMPONENT_INDEX)
@@ -1026,7 +1028,8 @@ enum fsync_component {
 			      FSYNC_COMPONENT_PACK | \
 			      FSYNC_COMPONENT_PACK_METADATA | \
 			      FSYNC_COMPONENT_COMMIT_GRAPH | \
-			      FSYNC_COMPONENT_INDEX)
+			      FSYNC_COMPONENT_INDEX | \
+			      FSYNC_COMPONENT_REFERENCE)
=20
 /*
  * A bitmask indicating which components of the repo should be fsynced.
diff --git a/config.c b/config.c
index eb75f65338..3c9b6b589a 100644
--- a/config.c
+++ b/config.c
@@ -1333,6 +1333,7 @@ static const struct fsync_component_name {
 	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
 	{ "index", FSYNC_COMPONENT_INDEX },
 	{ "objects", FSYNC_COMPONENTS_OBJECTS },
+	{ "reference", FSYNC_COMPONENT_REFERENCE },
 	{ "derived-metadata", FSYNC_COMPONENTS_DERIVED_METADATA },
 	{ "committed", FSYNC_COMPONENTS_COMMITTED },
 	{ "added", FSYNC_COMPONENTS_ADDED },
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f59589d6cc..6521ee8af5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1787,6 +1787,7 @@ static int write_ref_to_lockfile(struct ref_lock *loc=
k,
 	fd =3D get_lock_file_fd(&lock->lk);
 	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
 	    write_in_full(fd, &term, 1) < 0 ||
+	    fsync_component(FSYNC_COMPONENT_REFERENCE, get_lock_file_fd(&lock->lk=
)) < 0 ||
 	    close_ref_gently(lock) < 0) {
 		strbuf_addf(err,
 			    "couldn't write '%s'", get_lock_file_path(&lock->lk));
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 27dd8c3922..9d704ccd3e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1262,7 +1262,8 @@ static int write_with_updates(struct packed_ref_store=
 *refs,
 		goto error;
 	}
=20
-	if (close_tempfile_gently(refs->tempfile)) {
+	if (fsync_component(FSYNC_COMPONENT_REFERENCE, get_tempfile_fd(refs->temp=
file)) ||
+	    close_tempfile_gently(refs->tempfile)) {
 		strbuf_addf(err, "error closing file %s: %s",
 			    get_tempfile_path(refs->tempfile),
 			    strerror(errno));
--=20
2.35.1


--f6gA11ZyWQh/fgCg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIrHWIACgkQVbJhu7ck
PpRQ0xAAk0pauH/4AblFbKi4gp2+B3cYOQLceq6MCQMm6hwbobQnTAe9Zv+5Coiz
qKKzmJXo6NUdaOl6vavXRKl/NXoBCNUeHrc+FIfGIjDrvfXrGVbr6MJU+5cLT8Zu
RSUrSJhkmZp8Efh6avH2PuxosHZGZfJZjmwdSB5lmcg7IX8+QaZvRZwH/eT478Ko
zkq4RmCit8EieMVcpbxZ1IdkgSFEyLkDzsCH4QPDFP3GO6tlAB9X8MwdiMFW5s6x
4coY1g5fedazo1edtAtTYCaeeNXQV7X2P2yy+v5e7cjNnM3XeQ4GzzTohA7Ib4cN
+2DIfdrMxKhEtV2E5OKn1IsS/9wDdPAK+K31WXvIGMSeg/0T1iFbhmgoFm2xhX7h
v2K55/nF60+sXp6mcuKTocNF+7SLmfVL7ZZEwjw1IxBNxS4Me4dW4UpCObdackUd
oMLA7P2JdG8iQR+MS2ULu4H5h58Ir0qM4tyP5MAiAQouQLLEpg1JURrVIiRJbs03
YJmeQMS2qYob4EW1u9JsmM54HzYaUkvBr5FA956QG8RdnUJqDbqYTVRj7LjMHV+D
FXSlPUZN8iMIl/l4Hs9y+u9Vi5IttM5BH2DqclJmIzWa7QBX+IzFE65C8i8QZQlX
+ejx/+drnMo+4dQnkfBvRKT6eIQoTPyR7kJFVkAMhK73zkHEf4k=
=DQq2
-----END PGP SIGNATURE-----

--f6gA11ZyWQh/fgCg--
