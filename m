Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1B1C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 08:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346785AbiBUIDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:03:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346775AbiBUICu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 03:02:50 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30785658C
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 00:02:26 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A7855C01C5;
        Mon, 21 Feb 2022 03:02:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 21 Feb 2022 03:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=guQrSiCNXZHeCa15jC0foN9AFRnZp2nmW4AG4f
        +xO/0=; b=Yxn1BQpXcH1mCRbp4k4T9yhpIXSeS0KiDxGZOtmBc1mttq3b+1BJTl
        ZIQJ+G2H0d/8m7TKC41denpzbbV9gD/b+atkJAuqEzkpDoXhjJ1aY3jqiVzyUe00
        ZY+cnP7lQNZcPcdYrZN0Kc4gF/UXz/pCRfa+KOUH5oKUu/ZZ0ClkzAQg6yowDMhb
        HSBubTtI0RZHvP3wbjnYC1LqXguzkdArhZlbS6Dr81XGFnRCiJQZYx4mqzeiAeaq
        fmYK2Qlrx7glfJz4SDgAa4WzgzumPmZVSGPbqAeWCMSFdg7X0sKb71Jx7rWK9Ltd
        Ol0k/BeA8Zt7nIK5nOt69yQnjaU8of3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=guQrSiCNXZHeCa15j
        C0foN9AFRnZp2nmW4AG4f+xO/0=; b=C+rs6n/WLrF05JNLPcoXgmTp7GPdddKZd
        k8WATQg9pbtZmIpROJ1iXEJekxk7QqKQG9x8asN8vJWIt1KeZ12AkHhBw0mVXvrY
        3uxjMpwyvy7NO/e9S1+wMULk0tPMdbXqmMBiLoD9oaJX46KcmXktHE2KWLI7X1vb
        v8vDAPVIuS6XFNFyvvgd2UAE5OCsuhnlrmP3IBrn/smA3hBzXa9Hf/J+MiFmA3rA
        xCAJ0CJSTnnXRrXfWzY5IZjddDmP3ClIneqVlXgnl2q0Uc4bXORdeaW5wkVkSOzI
        lGw0fWlqFNXlVZG2bx28X4aNQBB4w5fZNJOP9SYptfcYZIcaHxLOw==
X-ME-Sender: <xms:EUcTYqEz3gw-IaCqrMk3EOEWJLv-OWPLncBIZLZ1oxKjHPudEgDUDw>
    <xme:EUcTYrW9YJvzme5ZxLIYnR6rFLQIy0aLmPwt9jy5Vue1dAAfxu4IizKNFYCqLXgAf
    3MqNlMT7Vm1xMTPeg>
X-ME-Received: <xmr:EUcTYkK83eJdFqGPGrMS3-yhXod2KjFJpvuzzJlnHaBYD6BuTm27KoRKeIzs6xkYPVWWAvGXSX3UziFpcm_Sn8Ju184CrwEP2BnP0S3lDHx0LFQp0pEE8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeehgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:EUcTYkHgR91kxqkd_bhrZfgsQm5Wjx8rsCrrPK8yT_Uk49AUBtmIaA>
    <xmx:EUcTYgWmRCGma9n5ZM7VQ-LelpA54DGzH34OoDpGM1bDYy_aM_hoVQ>
    <xmx:EUcTYnPK5boIUAatZFK4PgDCv20F3S6orxXvBIMcdGdRa3eeYkXaxw>
    <xmx:EUcTYnTro2VB1_ofEOPH4doJndopjK7X_1GjwjFS3jQjTZI-Qysmtg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 03:02:24 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 19cb84a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Feb 2022 08:02:23 +0000 (UTC)
Date:   Mon, 21 Feb 2022 09:02:22 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/7] fetch: report errors when backfilling tags fails
Message-ID: <a7e005dd482fe620839fe02b74b4bc55ae5b8850.1645430423.git.ps@pks.im>
References: <cover.1645102965.git.ps@pks.im>
 <cover.1645430423.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P7Z+8beYc6YE4TAl"
Content-Disposition: inline
In-Reply-To: <cover.1645430423.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--P7Z+8beYc6YE4TAl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When the backfilling of tags fails we do not report this error to the
caller, but only report it implicitly at a later point when reporting
updated references. This leaves callers unable to act upon the
information of whether the backfilling succeeded or not.

Refactor the function to return an error code and pass it up the
callstack. This causes us to correctly propagate the error back to the
user of git-fetch(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c      | 26 ++++++++++++++++++--------
 t/t5503-tagfollow.sh |  4 +---
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f8adb40b45..d304314f16 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1495,12 +1495,12 @@ static struct transport *prepare_transport(struct r=
emote *remote, int deepen)
 	return transport;
 }
=20
-static void backfill_tags(struct transport *transport,
-			  struct ref *ref_map,
-			  struct fetch_head *fetch_head,
-			  struct worktree **worktrees)
+static int backfill_tags(struct transport *transport,
+			 struct ref *ref_map,
+			 struct fetch_head *fetch_head,
+			 struct worktree **worktrees)
 {
-	int cannot_reuse;
+	int retcode, cannot_reuse;
=20
 	/*
 	 * Once we have set TRANS_OPT_DEEPEN_SINCE, we can't unset it
@@ -1519,12 +1519,14 @@ static void backfill_tags(struct transport *transpo=
rt,
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	fetch_and_consume_refs(transport, ref_map, fetch_head, worktrees);
+	retcode =3D fetch_and_consume_refs(transport, ref_map, fetch_head, worktr=
ees);
=20
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
 		gsecondary =3D NULL;
 	}
+
+	return retcode;
 }
=20
 static int do_fetch(struct transport *transport,
@@ -1632,8 +1634,16 @@ static int do_fetch(struct transport *transport,
 		struct ref *tags_ref_map =3D NULL, **tail =3D &tags_ref_map;
=20
 		find_non_local_tags(remote_refs, &tags_ref_map, &tail);
-		if (tags_ref_map)
-			backfill_tags(transport, tags_ref_map, &fetch_head, worktrees);
+		if (tags_ref_map) {
+			/*
+			 * If backfilling of tags fails then we want to tell
+			 * the user so, but we have to continue regardless to
+			 * populate upstream information of the references we
+			 * have already fetched above.
+			 */
+			if (backfill_tags(transport, tags_ref_map, &fetch_head, worktrees))
+				retcode =3D 1;
+		}
=20
 		free_refs(tags_ref_map);
 	}
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 7dadaafd4b..27a1dfa3c0 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -233,9 +233,7 @@ test_expect_success 'backfill failure causes command to=
 fail' '
 		done
 	EOF
=20
-	# Even though we fail to create refs/tags/tag1 the below command
-	# unexpectedly succeeds.
-	git -C clone5 fetch .. $B:refs/heads/something &&
+	test_must_fail git -C clone5 fetch .. $B:refs/heads/something &&
 	test $B =3D $(git -C clone5 rev-parse --verify refs/heads/something) &&
 	test $S =3D $(git -C clone5 rev-parse --verify tag2) &&
 	test_must_fail git -C clone5 rev-parse --verify tag1
--=20
2.35.1


--P7Z+8beYc6YE4TAl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmITRw0ACgkQVbJhu7ck
PpSddRAArQyDV6KObVzoOvkmA8XlM+e8wH1sO2O/orG9JG6JqChCkUvbtryFD15X
r8nBXJn9HgmGokrc5fpKEsjGJSEV2nPu/AVE/9SxS9rAGyMC5XnyUuBk5pB4Q59M
Z7l30cTBs52xxXYlp/NcL4Q16xTDJMXV3QGNYokfb3uEsom0BC/GxbubyVbUTIR3
AUCFMWtwiFVVvMA0S7+kcVx27ygMnLmgeBqbA8XeUqWF80zAMsyXPfW7Izs7Qy9g
nLgJc+c2la6s87yFMacOgYNXdJq1OGrmE39MJFP/aypSgrDyyRqzWWlmKNvcRltj
wI+W8viV9eWt16UZkTLnxXZex0HceVTEdmMHYN+7nVCb6ouHUfo/lkGt3jN4HPzP
p0Ya7IB0mtqv4Mf0eJCBqPuPTKEdN2KH2BBWKa6B05maI3H5X+tBbEBBHpZR74Ro
5me7S2tFxgyYxM3dm7S1Qga9DHn7oTbdinxkBKd3wd72ye8GaesagP76MBSglbdb
364McUbZ2giG1YfHWCFdU4KtCOhsy1XospXdXyv0Ps2Vav/wkwAqNJqIruGuzi5y
NjJ+IKjahgxz/kTwle1LKUYN2ihr5Lo12j5lyQobCM94EF/ZbymWerrI2sy6nB4L
dDBVcw/rnKH6MUFKGbBE0Sog863Z+CQBUg6Tn+cHP5vfYuoaSs4=
=sTYd
-----END PGP SIGNATURE-----

--P7Z+8beYc6YE4TAl--
