Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163A2C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 07:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347814AbiBKHrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 02:47:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347487AbiBKHrD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 02:47:03 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573C9B38
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 23:47:03 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9D93A3201D9C
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 02:47:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 11 Feb 2022 02:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=BMZ9o2dZnbMjLW+unbLzORyXeZALgaOiIEgHYL
        rSM0E=; b=VEY8+hzUfA8nzGN/kzqLoBbovgwOsjpsrSeiw+cfrOdDqU9HJCNneN
        fOoSq31vjMo/MqOwT614cdDQtQu9u3B85OQLwtz7XXvofO65i9lhosneGNmPVfhu
        fCOizxB6sM6mG0uqSQ6Imc80mngv1p99xBUGtqujnkvquKLWszYUl3kHHEMAyDyW
        LPbq4cp+DU6V2uBlfhIOSMZ+GceI2OKhRmaupq58AURDhkpLfBR98QOo01tmvzRU
        0WZriDFi5La1ujQM+ivqufftG1MZVjesxjD39FLAFd7sUaUxmtpFSNZCLFM4IRA1
        yNPhuOjm6/NMvHFKdNDBsfpMzWH0duNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BMZ9o2dZnbMjLW+un
        bLzORyXeZALgaOiIEgHYLrSM0E=; b=McvJPbXiBwwh/9ZjeKbg2RRJZ6qdeVcvz
        YkV9wsHmUS2DJoIB03RZc3eI+GWUEnKVmyZvnj6b9v1kzQbBkyjwGjJrD2MIu8DB
        0+4jULcnPE9jxGBcn7lQNK9lhMIhlPQXQANdYm6FU3OWlAGpTxBfC+1zdB6/9S4l
        FJA6T8JVQ1GfZz44toUpPexU1T0kJ7V2Hw/VIZvtK6sRE1hiCtZGnYIeskRfiV2W
        /onT2x7NJDTZcV6KGUdN+8HQkTsjMmyzJOpCKf1V61zL6izMT435333UbW3WbOxw
        SQfyyS59pmCNUp7eN23ShFm7hhtQX8z0ZPcRKSk2+o+zGRT+PTWog==
X-ME-Sender: <xms:dRQGYn7705lQnBqMLqns9TMfCiXJMGmhI_BUEofd-TFkwY991U9_dw>
    <xme:dRQGYs5kU1cWavP8h-IxpCLKc1ZssY_oyNOtmrNoZ9UlI9R1cN_36Q6zy3ECVyILi
    Gz0Gd3XRGjc9pWgxg>
X-ME-Received: <xmr:dRQGYudXW6QFrDbqOJEsq2JClohHyC37EAjC3MFgp16DHJ_z2MHD9mSVRJ02N344lqBh3Cw_gKDpXaE7aiTl-xTpBzilfU2p5amwabR7KcIFyUxhDHtkRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedvgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:dhQGYoJjtasfaSxKucFdhsOjEO1NozrLkur4hxUyiyLqFYXjT_CPhA>
    <xmx:dhQGYrLuvcfMJrxxdjlFv5cStSsmwY6tO5GWAjWsCmx88GS2dcNDaQ>
    <xmx:dhQGYhwqUZkLit1RX67TS0EB4vjbdrHuw1RVTZs7Zk5taM73Vcn47w>
    <xmx:dhQGYmkj5gD_r0aiRDPRvxLrXDAp9nwHonfKwBNvu9lqH84HLczcNg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Feb 2022 02:47:01 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 10438711 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 11 Feb 2022 07:47:00 +0000 (UTC)
Date:   Fri, 11 Feb 2022 08:46:59 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 4/6] fetch: report errors when backfilling tags fails
Message-ID: <54fdee845bea7f67f46817417f8e5a504bd39665.1644565025.git.ps@pks.im>
References: <cover.1644565025.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VRo1IOUYoqrRSk1t"
Content-Disposition: inline
In-Reply-To: <cover.1644565025.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VRo1IOUYoqrRSk1t
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
 builtin/fetch.c      | 29 +++++++++++++++++++++--------
 t/t5503-tagfollow.sh |  4 +---
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 627847e2f8..1eda0b68ff 100644
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
@@ -1628,8 +1630,19 @@ static int do_fetch(struct transport *transport,
 		struct ref *tags_ref_map =3D NULL, **tail =3D &tags_ref_map;
=20
 		find_non_local_tags(remote_refs, &tags_ref_map, &tail);
-		if (tags_ref_map)
-			backfill_tags(transport, tags_ref_map, &fetch_head, worktrees);
+		if (tags_ref_map) {
+			/*
+			 * If backfilling tags succeeds we used to not return
+			 * an error code to the user at all. Instead, we
+			 * silently swallowed that error and updated the local
+			 * state of the repository. We now notify the user of
+			 * any such errors, but we continue to make sure that
+			 * FETCH_HEAD and the upstream branch are configured as
+			 * expected.
+			 */
+			if (backfill_tags(transport, tags_ref_map, &fetch_head, worktrees))
+				retcode =3D 1;
+		}
=20
 		free_refs(tags_ref_map);
 	}
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 888305ad4d..549f908b90 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -237,9 +237,7 @@ test_expect_success 'backfill failure causes command to=
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


--VRo1IOUYoqrRSk1t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIGFHIACgkQVbJhu7ck
PpQa5BAAhDHA1pzaknnrGchtqDa9HIgZpJeFclsst3MvSNBc8fkjS1ac+0/kHS+K
seTTA1k24vSCm3fS7InauJ8MECQSSomHzMmwWxJnfKm5UI8HkUNt3v0QNzI1K7ic
R6ZpX+vVWGXumcKjcTZmiqL0hZLY6wXpXkUH/id/q/6YGS9Nun2F+VOZk+I0U72h
4vqjXUFBxjpjto6B4w6Pi3BdGCDSh654icytkJXLsIIMxxVBlyl2T0IwreDtXQLY
DrPjbSr96RSs2VUPKrNDkBkx0ATnMfl3Ll1T2dmFCDrGwl3jN1nZh2JyVYrvoAKf
FififzCdpnWXZRV/Gke7bbw2+Aac6ZexKVlvfAhP8sMYdYEmEVQMIfqo+OvvsB9a
I443ot+ZancaupwxsN9f9ADzXT1RbuHfOUfHB45UjHhtnxovAm8nPWVe0m/5uHEG
yXOb6NyRW4HxF0bG0Y7Gj6XPmZtqiq03xRijIHk1nfhN72hjMfGPUFBCOT/LKdFx
hf+Z+k3I2CBBm0iyj4ImDSvGV77SWDzBaNKfhtDwVUXu6KGSQMv6mgvQOOnrSEtf
ABAv0a2fIWzt4NFOz7EqihLnS19A0qGeqT6cLItYpB6f4R8/1sJwM8b1s52FUPh1
xp7WnRTqT11Z3rDTwR6lDm9JgpK5dXe/jq2Giq6kmCODsFE1JFs=
=GH/N
-----END PGP SIGNATURE-----

--VRo1IOUYoqrRSk1t--
