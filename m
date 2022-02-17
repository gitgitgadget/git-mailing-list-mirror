Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3426BC433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbiBQNEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:04:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240653AbiBQNEq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:04:46 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565112AAB0C
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:04:32 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A03633201F1A;
        Thu, 17 Feb 2022 08:04:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 17 Feb 2022 08:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=ojpnatN9COzHUpgWNPQvrM4iHs6kgHeiqlXYaF
        PjvlA=; b=SXLKmxizVv4u3RhLraVGLWhmlseZwmTGkR69wYbSoL4TcpRvb77hGV
        khxD97fXimw8QFrCkaPdzCiW564SKp6zH6kPE4ncrWuIqBZfrSvZm+QOF3cJOFIQ
        hmlI3Q+En0FuSV7FDcB1LIeuBbzBXaHObc3exmA0oqITZG4lnt6QrLbIaBOESK5D
        MNldc/fKGMeq2XGn9lNibFlXJsSavKwO3Fm2+rarnZD+xBJUhB48KaZvtNL0YfRx
        IVcogZv977FgTXka0u3LNv/g5FDWi57kA4LbMMF4sRhsYUfulTqYhHflhiGXK0oT
        otwRG9/SVd3GEX3jrEHBfjHSijmLRazQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ojpnatN9COzHUpgWN
        PQvrM4iHs6kgHeiqlXYaFPjvlA=; b=h08oGFG5udvC0FSMaY0eUhbAHe/c1EfAJ
        rWbeEqAN70G2jOd7+rDRGBwpj78G/DD8OiYgQhYA9IyU+3G1tdQhZmw66HsyRE1o
        RHb1qDhlchZO8UHVaNPXK//d+vlpkEdSBcPIVbn9appvvlMNVLsrxuK6RSCmV1a7
        mv2KoJgvXiSho+WY+3Wvb80GUDX1l1aWIIRaRz5drXyB6/QdPS0BhrzTf7h+Oqbz
        eu82F1gA69UOOS9kX6nyvJoinzugPlLRFmC7Evbe8NMglCjYxhSjyXbMpb1NvXGa
        pjAYPsh283wHLz/nV0K6OPh1oko7LAmUO/6aSIeQZjqVFHjShdKbA==
X-ME-Sender: <xms:30cOYlT26LQ0450Ow8uQhyjmFHOrxEoEyruP8u57xYhSzeiMuGOOBg>
    <xme:30cOYux15okl8nHhhlhLl9TfpIOsFheXxmrXNEuCe7NRpW4i5t99KjsF8i4x0P4Yb
    8ILMCkfe6iWQiKAeQ>
X-ME-Received: <xmr:30cOYq2VAhp_eSojfXyU8p7uFHKh4fb6I5ciX4m5FQ834xp0oEz-ZUXPDk66u9Dr2zmAqJzwmNzPLWD6kk5IvbA2nl9zAZRAuh6YEy-boI2u6hBYO70WXG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:30cOYtCU8quc5eyHU-8OwtSEl_HemwWjexRTMhwOYNITvqyiQkQByQ>
    <xmx:30cOYugAAPSFIAQHBEZKQaLtKRNM3l1E7H3RXHvIjFKNCUY2KM6uLw>
    <xmx:30cOYhpvl2tqCMoOJNaRYXnak5vH7yLx_BIOXV8_lhm9_vcYDLb70w>
    <xmx:30cOYhtD42r-l2_Zhb2afdQy0gjLBFBxZkbmV0QTFrdLOXbvQwCgXA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 08:04:30 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0d24620c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 13:04:29 +0000 (UTC)
Date:   Thu, 17 Feb 2022 14:04:28 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 4/7] fetch: report errors when backfilling tags fails
Message-ID: <bc1e396ae0ad380dffd7962cc223cc63e6facffe.1645102965.git.ps@pks.im>
References: <cover.1645102965.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cWCeKSp2fQzZ+L0z"
Content-Disposition: inline
In-Reply-To: <cover.1645102965.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cWCeKSp2fQzZ+L0z
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
index 6ffe2a5719..c057c49e80 100755
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


--cWCeKSp2fQzZ+L0z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOR9sACgkQVbJhu7ck
PpT24Q/+MK1loxLVKgqn0tLZbDU7BlzSSuU3FEdGag228rpxKAiYyXJBGXuoZsT2
L0ZxOysf4K+Jz9ODOtuwik6GiERWIr+tYlr7WUdMnzWWHpleZ1gGBbo4/IJTL9Lb
ErRDQ3xvAmRc5WkguZufoQJVE3e40EKD/hhKF1y+TMcRhBkZYX/4Nsufoup/mR04
SOki305+YligrYMwOQiepWd+BNN9ofVm/EzdZTwCtkFMBncmo1F5IDgv96Ly9IxA
mgSuzw4Wgho5nwzzTw8iro7R/aWbob2QoOUoS10NvXX83khVw/PG11UKBgAjb5Zg
M8vny8AWdRvfW/VIhc1iDmypA9l6rhNisXU0ShTuMzcPX7rc3Z6l0TXN2+BqlimI
MUV+3XWrdmwJKawAOcc9REbGQmqspNmfPnKH/Umvn0bw1EY+2m3nS5r0aDV9Qgt7
6ZliwwReU2lsL3j9xRLXuXG9YzJL/ed+8nhRi4VX2Il4pfo2sBgly1LT6jfoICOh
/uvK72ZZjrbQHEceID97GLoRF+fhwYq8gHijuo4RsZaauRb8n0d7fuzfMWLh82uN
HhHH01PuW1wroFH9x239VZ1rxXo2M8ylVy3EolqxDtRnJy7ADZYIKIRGJ+ZhPM3H
47+6bTxy1yhl/iNvH6HFvk359dTRiW98mkZaWwBMm27IFGgcYVY=
=XuDJ
-----END PGP SIGNATURE-----

--cWCeKSp2fQzZ+L0z--
