Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C8EC433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 12:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4C52231F
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 12:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391789AbhARMvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 07:51:31 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60167 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404304AbhARMt5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Jan 2021 07:49:57 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6C6345C0117;
        Mon, 18 Jan 2021 07:49:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 18 Jan 2021 07:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=8WA4m6UMhrmX3igCCbYqY0uV+mD
        y3FIYa/YN5whvoCY=; b=JRih61xLwjNtFsLKZII70gOk9yfrDhNSFCJ8xT0hID+
        Ys4Vear5ccr6wXCIy45vCQGoDaYq5JQGYrmtnX20nsPgLSRBuUFSitqgNXBut2U4
        O0YpgcyTpy9CY41c3pRPpxDC0Y2atAp5KaeS8dmLK6N1wuQ9RufqQlRuah06I6kV
        pnxQVNNekMKJw7CantguFlmiicqapvTGoGkOnn/FlXGzIziIyJJx8X1mLIngdY+C
        Ks/lg9wIbYFuporSlRL3z8Dotx2EIDboUHectEKHy9xiRij6v8jYax7r+zwUhceO
        OXQgKu1+uXOLfc026IUPCN2XPASzKxB6lcq0NWxE7rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=8WA4m6
        UMhrmX3igCCbYqY0uV+mDy3FIYa/YN5whvoCY=; b=CqygkA2mtWrUrqO1oXxxC3
        GOMN5vhtw9E/Y6wxYtuwN5WSKAoabB+TaubCVqMlvVdNQXmR+uJzhwf91JUaJ8cp
        pwdLPOt5DXGf/tw4aNIYiQHF7iftK4Zp+3uvFc1X7dsaU+fI9FijcTdR5tNy8ttL
        CmT9LllRCEtZL6TN2haBuElC62/cUCCfLmBIfcNfHiEriEwo49lBCiVTLgcpy0C2
        wIOd39/+jQVKLvF9emB3BvvCsYxxrYgnehsizQBbbMEq5C4hlh2wsd3iN4rlpksa
        svzUwtwu9LMbjtkzrHr5LzYqycc9SnAbFj9N4/6yHMnl6eNSjBsSpni224BbmuNg
        ==
X-ME-Sender: <xms:xIMFYMt-ejZcdS7mDcr2x24R55C0qLakMpRX7nxqkGwQv2Cm5EEfTw>
    <xme:xIMFYJd6LHXC5x4qhVhbibJPE8NDQo144Fq33M4rhC2XdvNJ4hX2Q1Ns0w7_2LOJR
    CYCgs04-vcFw0FuHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucfkphepjeekrdehhedrheeirddukedvnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:xIMFYHw0qMaRY8Y1BuVaW_uFTc5MxljTqNt1AFtOfZWgyZeKeUknyw>
    <xmx:xIMFYPMs-eOAmdya9ZZnInPUQF2ejx-76grAFMCrRD0WtAv1Mprw9g>
    <xmx:xIMFYM85wlWY0QDjgGR20qWC2k8g2MDFNcLFpOmFsFMSRP2O8BTN1Q>
    <xmx:xIMFYKnDf61YprytzNCdwdIYG4z1W7xJ0Wn1U6q4dRGMO8VMzz9Hkg>
Received: from vm-mail.pks.im (dynamic-078-055-056-182.78.55.pool.telefonica.de [78.55.56.182])
        by mail.messagingengine.com (Postfix) with ESMTPA id 743E51080057;
        Mon, 18 Jan 2021 07:49:07 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9e86e0de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 18 Jan 2021 12:49:06 +0000 (UTC)
Date:   Mon, 18 Jan 2021 13:49:05 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, gitster@pobox.com
Subject: [PATCH RESEND] refs: Always pass old object name to reftx hook
Message-ID: <ae5c3b2b783f912a02b26142ecd753bf92530d2f.1610974040.git.ps@pks.im>
References: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iIa9f+Fa0ope8NUB"
Content-Disposition: inline
In-Reply-To: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iIa9f+Fa0ope8NUB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Inputs of the reference-transaction hook currently depends on the
command which is being run. For example if the command `git update-ref
$REF $A $B` is executed, it will receive "$B $A $REF" as input, but if
the command `git update-ref $REF $A` is executed without providing the
old value, then it will receive "0*40 $A $REF" as input. This is due to
the fact that we directly write queued transaction updates into the
hook's standard input, which will not contain the old object value in
case it wasn't provided.

While this behaviour reflects what is happening as part of the
repository, it doesn't feel like it is useful. The main intent of the
reference-transaction hook is to be able to completely audit all
reference updates, no matter where they come from. As such, it makes a
lot more sense to always provide actual values instead of what the user
wanted. Furthermore, it's impossible for the hook to distinguish whether
this is intended to be a branch creation or a branch update without
doing additional digging with the current format.

Fix the issue by storing the old object value into the queued
transaction update operation if it wasn't provided by the caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/githooks.txt       |  6 ++++++
 refs/files-backend.c             |  8 ++++++++
 refs/packed-backend.c            |  2 ++
 t/t1416-ref-transaction-hooks.sh | 12 ++++++------
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 1f3b57d04d..e7baf0e2a0 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -492,6 +492,12 @@ receives on standard input a line of the format:
=20
   <old-value> SP <new-value> SP <ref-name> LF
=20
+where `<old-value>` is the old object name stored in the ref,
+`<new-value>` is the new object name to be stored in the ref and
+`<ref-name>` is the full name of the ref.
+When creating a new ref, `<old-value>` is 40 `0`.
+When deleting an old ref, `<new-value>` is 40 `0`.
+
 The exit status of the hook is ignored for any state except for the
 "prepared" state. In the "prepared" state, a non-zero exit status will
 cause the transaction to be aborted. The hook will not be called with
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 04e85e7002..5b10d3822b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2452,6 +2452,9 @@ static int lock_ref_for_update(struct files_ref_store=
 *refs,
 				ret =3D TRANSACTION_GENERIC_ERROR;
 				goto out;
 			}
+
+			if (!(update->flags & REF_HAVE_OLD))
+				oidcpy(&update->old_oid, &lock->old_oid);
 		} else {
 			/*
 			 * Create a new update for the reference this
@@ -2474,6 +2477,9 @@ static int lock_ref_for_update(struct files_ref_store=
 *refs,
 			goto out;
 		}
=20
+		if (!(update->flags & REF_HAVE_OLD))
+			oidcpy(&update->old_oid, &lock->old_oid);
+
 		/*
 		 * If this update is happening indirectly because of a
 		 * symref update, record the old OID in the parent
@@ -2484,6 +2490,8 @@ static int lock_ref_for_update(struct files_ref_store=
 *refs,
 		     parent_update =3D parent_update->parent_update) {
 			struct ref_lock *parent_lock =3D parent_update->backend_data;
 			oidcpy(&parent_lock->old_oid, &lock->old_oid);
+			if (!(parent_update->flags & REF_HAVE_OLD))
+				oidcpy(&parent_update->old_oid, &lock->old_oid);
 		}
 	}
=20
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b912f2505f..08f0feee3d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1178,6 +1178,8 @@ static int write_with_updates(struct packed_ref_store=
 *refs,
 						    oid_to_hex(&update->old_oid));
 					goto error;
 				}
+			} else {
+				oidcpy(&update->old_oid, iter->oid);
 			}
=20
 			/* Now figure out what to use for the new value: */
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hoo=
ks.sh
index f6e741c6c0..111533682a 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -52,12 +52,12 @@ test_expect_success 'hook gets all queued updates in pr=
epared state' '
 		fi
 	EOF
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/master
+		$PRE_OID $POST_OID HEAD
+		$PRE_OID $POST_OID refs/heads/master
 	EOF
 	git update-ref HEAD POST <<-EOF &&
-		update HEAD $ZERO_OID $POST_OID
-		update refs/heads/master $ZERO_OID $POST_OID
+		update HEAD $PRE_OID $POST_OID
+		update refs/heads/master $PRE_OID $POST_OID
 	EOF
 	test_cmp expect actual
 '
@@ -75,8 +75,8 @@ test_expect_success 'hook gets all queued updates in comm=
itted state' '
 		fi
 	EOF
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/master
+		$PRE_OID $POST_OID HEAD
+		$PRE_OID $POST_OID refs/heads/master
 	EOF
 	git update-ref HEAD POST &&
 	test_cmp expect actual
--=20
2.30.0


--iIa9f+Fa0ope8NUB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmAFg8AACgkQVbJhu7ck
PpR1Pw/+MPrKcTzsf1fjqzp2hF82OfCOdpqMLVqc2GOsJ/DYrfktldVd53HXOF43
RurTsADMxU9hLmBVywhJ7Il6Xv8Qers1+6Cm3ATTG6834/YuHTrpXHj9ksRypHh6
XTydw54FJzmZZVpqxINy2u1NZ/wc6f9enew3Qf5ewgTP0vWANFs4wmSQI1WJbjze
dIqmOKHUtm+p291EJvdKhyAGhj88P0viHOC0N6qsZaE8MMrdEebckBiZPgHwWGxu
VfbdH6Dr57tLFwsiRPfzUJ3e9DIjs8VAXVAWx6gTXWPWLYs4v1MTplPfdvC23nrY
EG2AoSAD+2Amo/uRjk0U/7zLzFEPatFFYY3B2nwiKxoMcBY4KeisDNq+Pu1t7Vx7
rKrwZhhY9JBTQH69T7KcYGCOlmj6+stSRwTFB6G5B0CX6quq83qvk3S4hj+6g9N4
IJmHZlkU6ziiQscErM/Y9LRncGOQj3uY8hO2o+W9sZTfFKV9SYVm+QHD4qYISwkm
FVOOd+9nplj5aEV1GYserAr64h0FPwNwkGXpV3QhjYbDOqDu26aDfikXogdi1dJB
gNGWzKCSQ3e4pAuR5Ut0lTNSR1+7s7Lisd2kxn/T4mnoCG2/PrNk91QaTrPHeGNg
6Fenw/tBakYZ5suV9TSnqUKup6WxLSTZi2zVByBcNL3WwGSsxK0=
=dfcV
-----END PGP SIGNATURE-----

--iIa9f+Fa0ope8NUB--
