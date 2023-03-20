Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA535C7618D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 12:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjCTMfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 08:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjCTMfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 08:35:37 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E7B25E3F
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 05:35:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6707F5C0131;
        Mon, 20 Mar 2023 08:35:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 20 Mar 2023 08:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679315731; x=1679402131; bh=BR
        uIpMH3CafjO0UcNT8YNKhcmfP39jg6jFYc0/V2bQA=; b=GCBhSSMhfTUhm+7Uim
        EvCb6kUbrhWzozqbQhsfrgDCxL+XZidfJeyShHfOOWs0+aewEVQ64Zlvfg45tYma
        c7Zy3uky65atuwfziZGcHJ5oDPP+WBahClyNdbbY2M8msay7MkJcEX1nQwOr2YSR
        caNVo7t8rBfy4m7krJuYT2AJDqH5RTTF3j+CcYz0cfELKj/jLqIbWxigckt4lVYp
        cdQq2aoGQTASdcLQILgwzKog2cWpCGPo1sS824lrEGddnOxYKggK9Z50VUeSK1aY
        /i4Gq2bj+jH7XLTspEaEJvrNEDSUDI+SppyJQu1mdI08Xx6Q6A84KkrIu6HLPXVs
        hFHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679315731; x=1679402131; bh=BRuIpMH3CafjO
        0UcNT8YNKhcmfP39jg6jFYc0/V2bQA=; b=ValJ+5cBblS6o6kG6PnEylY+0aVvn
        y+p4NOVkA6sXBDTOUFxr5N1s0y57iG8tYnSQYWwSgJFnrSePXM4rlCPS6fO8muc5
        bVB9bJdN1GrbDyV0S62fS2DllgnXZcFdFjf380GAjxYsHDITNpq7THiHb5KAb7rd
        11vVtmrE3CnRM6bc/bMg450ZVo5mBS06zTbpzKdVpTJAVsMEGHQn4EnR6YI2hFWH
        WNMattF9lnEFzHYZJytu9c0q/zDnnoQqqi19GvIw8Sfb9rr0ges2MY363QALBQ80
        90h0tFGIyHS/Ig6KhLHucAFCB6LVPMjMQuMFUkc9AK3dz1dNAUtX5qGdg==
X-ME-Sender: <xms:E1MYZGw3-GhyO3IO6gr53s9oTlznjgySdSLZMjBToVqCxglw98xcMw>
    <xme:E1MYZCS9ALu6aof2X247B3Y3YADA1Do_TOI4zkWiRiKqWmygeGbR0R8Dq5ySUGmTa
    mFh_LxfkSekgR11pg>
X-ME-Received: <xmr:E1MYZIU4z9X6FlUGoQi7VgC_kI5UgvbMEcKB-m91hZGMT4lBjOX_D_p9vGSnVwp8lf4vxcyoXHwAq1tJ8Zwxb6LaZ4WIF6qAMvKPXlZ8BMJM-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:E1MYZMj6getpFPuf-lFVYPY42rHAxp6mB1xeWkwd1jb6s6XsdmPKkw>
    <xmx:E1MYZIA7S-rFuAmcNuAZIjAI_I2n2PbgOB3NwA0m5AtH6CeEcGyf8A>
    <xmx:E1MYZNLxY7ShWDkpER5mwVLZJeG0jq8fItzXNi-5E66X-sCX2vQOMg>
    <xmx:E1MYZB6XwqgIzojIghMWDv3qJPVfpN95L3HHTDm_Two5ufH4pZbNxg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 08:35:30 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id a95865ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 20 Mar 2023 12:34:57 +0000 (UTC)
Date:   Mon, 20 Mar 2023 13:35:28 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 3/6] fetch: pass the full local reference name to
 `format_display`
Message-ID: <ec355b8b8d3de445a69559b75db840b26f4fb3cc.1679315383.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
 <cover.1679315383.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PPjOiU65DaC4cnhq"
Content-Disposition: inline
In-Reply-To: <cover.1679315383.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PPjOiU65DaC4cnhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Before printing the name of the local references that would be updated
by a fetch we first prettify the reference name. This is done at the
calling side so that `format_display()` never sees the full name of the
local reference. This restricts our ability to introduce new output
formats that might want to print the full reference name.

Right now, all callsites except one are prettifying the reference name
anyway. And the only callsite that doesn't passes `FETCH_HEAD` as the
hardcoded reference name to `format_display()`, which would never be
changed by a call to `prettify_refname()` anyway. So let's refactor the
code to pass in the full local reference name and then prettify it in
the formatting code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6d6146b0f0..81ba3900cb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -887,9 +887,9 @@ static void format_display(struct display_state *displa=
y_state,
=20
 	strbuf_addf(display_buffer, "%c %-*s ", code, width, summary);
 	if (!display_state->compact_format)
-		print_remote_to_local(display_state, display_buffer, remote, local);
+		print_remote_to_local(display_state, display_buffer, remote, prettify_re=
fname(local));
 	else
-		print_compact(display_state, display_buffer, remote, local);
+		print_compact(display_state, display_buffer, remote, prettify_refname(lo=
cal));
 	if (error)
 		strbuf_addf(display_buffer, "  (%s)", error);
 }
@@ -901,7 +901,6 @@ static int update_local_ref(struct ref *ref,
 			    struct strbuf *display, int summary_width)
 {
 	struct commit *current =3D NULL, *updated;
-	const char *pretty_ref =3D prettify_refname(ref->name);
 	int fast_forward =3D 0;
=20
 	if (!repo_has_object_file(the_repository, &ref->new_oid))
@@ -910,7 +909,7 @@ static int update_local_ref(struct ref *ref,
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
 			format_display(display_state, display, '=3D', _("[up to date]"), NULL,
-				       remote, pretty_ref, summary_width);
+				       remote, ref->name, summary_width);
 		return 0;
 	}
=20
@@ -923,7 +922,7 @@ static int update_local_ref(struct ref *ref,
 		 */
 		format_display(display_state, display, '!', _("[rejected]"),
 			       _("can't fetch into checked-out branch"),
-			       remote, pretty_ref, summary_width);
+			       remote, ref->name, summary_width);
 		return 1;
 	}
=20
@@ -934,12 +933,12 @@ static int update_local_ref(struct ref *ref,
 			r =3D s_update_ref("updating tag", ref, transaction, 0);
 			format_display(display_state, display, r ? '!' : 't', _("[tag update]"),
 				       r ? _("unable to update local ref") : NULL,
-				       remote, pretty_ref, summary_width);
+				       remote, ref->name, summary_width);
 			return r;
 		} else {
 			format_display(display_state, display, '!', _("[rejected]"),
 				       _("would clobber existing tag"),
-				       remote, pretty_ref, summary_width);
+				       remote, ref->name, summary_width);
 			return 1;
 		}
 	}
@@ -972,7 +971,7 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref(msg, ref, transaction, 0);
 		format_display(display_state, display, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
-			       remote, pretty_ref, summary_width);
+			       remote, ref->name, summary_width);
 		return r;
 	}
=20
@@ -994,7 +993,7 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref("fast-forward", ref, transaction, 1);
 		format_display(display_state, display, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
-			       remote, pretty_ref, summary_width);
+			       remote, ref->name, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
@@ -1006,12 +1005,12 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref("forced-update", ref, transaction, 1);
 		format_display(display_state, display, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
-			       remote, pretty_ref, summary_width);
+			       remote, ref->name, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else {
 		format_display(display_state, display, '!', _("[rejected]"), _("non-fast=
-forward"),
-			       remote, pretty_ref, summary_width);
+			       remote, ref->name, summary_width);
 		return 1;
 	}
 }
@@ -1431,7 +1430,7 @@ static int prune_refs(struct display_state *display_s=
tate,
 				shown_url =3D 1;
 			}
 			format_display(display_state, &sb, '-', _("[deleted]"), NULL,
-				       _("(none)"), prettify_refname(ref->name),
+				       _("(none)"), ref->name,
 				       summary_width);
 			fprintf(stderr, " %s\n",sb.buf);
 			strbuf_release(&sb);
--=20
2.40.0


--PPjOiU65DaC4cnhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQYUw8ACgkQVbJhu7ck
PpRPiw/7BLlZn4rrbehgCnMFUK21QgPQri90i/cs0vdqSwishr0HYU/IS5aKxGYC
FxMK+rn0i4PQ5fbTdGiJz5LZ/Lji9e9lRASNQywAwcRu403rT5cfyy0W4DYNNfb+
i7yjL7O9ES1HO/X39vlQINory+0Dza2IHAiX131E6DheOF2Mh8l5gAa2Gf/+Ev/L
z+pH3SeAv2Ji6P5GlCSWrkLq6t+aNce4SLJpqpP/uV1LhpG43jifSGrDeyVCsNEg
kvVGUoACu7sqKp1i3/6WOG8ME/UHFQwxf3eBD3Zfbryl4wzeGcfxEelaJptz3Bxr
wSjyFiscZHnAjN6Kscirmfo4ov7R5knWg1S3LlzcAziuMrB1tUeLbcHJx2Imt0ii
f3sjF1A2lPmyVwb7dL1LxhwvXaEsxjt2klVvcGh2XaGlrOaUoJoI0yukLlxbQs3A
Qu7PleaC5eTCpebScofPusvHx+H4QdC11uFf4sQyrmIZG8/aR2TaKr9TzN4A12ZJ
ij72i0DgQWg50rr1L5ziuY/3ilfZkN2W6Yzc/4G604hUIVat5ytCWkdPC8PIIu6Y
KKC35CqXCw1DLIPrKDVIdXvqvcHAflXGPaWGup9lQHV7xZ7324fTFIt5mYvTaFAT
IY93JA+Df9P2q98zucsE/rEucIjdxVkllzQWr+aIwdYjQ9kSG9o=
=1XnD
-----END PGP SIGNATURE-----

--PPjOiU65DaC4cnhq--
