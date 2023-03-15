Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A757DC61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 11:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjCOLXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 07:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjCOLWq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 07:22:46 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B0678C95
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 04:21:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D67E75C05C6
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 15 Mar 2023 07:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678879282; x=1678965682; bh=RG
        W26SgtY5j4EHoXnXGZP8wfmFh80+DA1E8NHkgVm/A=; b=CoMPiPZkJOmh9wVGNL
        kE76q8CtgZuJLrvVEIJFcvUEIodou6cNCyZRbMvQE8ydlbUuqjoaYqh7Xk+Kanba
        oJccy5gJyUY+1TGhBMsePpb+ojC09w6VISP5y3ILxjfr9ZtXWkb9xfiN5u5m19U1
        x8fDYNNo+SgSrQuu+gfCKwVHwSIJ2fHLGLRddht7n7Y+yHTnRsyQ61RzHFJQ6Eae
        dZaa5iKgAPuZHUed8gyplpQM5ohZNM8wmEuaYwE0q3Vr4lJ1KjMrFdaGsvGju5/1
        1bKxL66B0MlaVryRWW4aa9TVGg8jaiVov5B6Z/tNRNCfIP19J4jygYCGRMBglv7B
        Igbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678879282; x=1678965682; bh=RGW26SgtY5j4E
        HoXnXGZP8wfmFh80+DA1E8NHkgVm/A=; b=aWezpxZqeyv9aHUJgMORrfID/r3Ty
        Q30U4k8zpDd+xqLfItQDJSXjrd9HdK3mw5bJlfKo5l5tPF6UnrHslXfNVuAYQpgg
        yx4RHiQaUxX1qRCy8xw/LA86jeO7DUSBzY77LSp7T6TAsSIGO7cR6AIUcOzva3Ir
        h/qaOYW9giP+giHBXqYCmK9DZSAhMokXRErSlAn5n2qjAE0Vb1QDGAkyAn3Gnos2
        FQiZq7LTvbn+AMS0Nc0/M4YPxdiTCGT4ctB7mAZ5hyiR8zDHs60izqgjnwoT8ACA
        EIYus/VnkCDBEGGmqgV3N5SbEiA6LFH2J3jQGoCE+qacTLAP9KASwmp8w==
X-ME-Sender: <xms:MqoRZM4kPN3r4Op7raB8pKjxgH4uQr72PYMWIQ_ZNSZpQQDQXurnxw>
    <xme:MqoRZN7bihXzUXgbR0mM-vYm29HOpzCOESzD-7OedBVjYEVmzvZZ4CeYXfPXx5fmF
    Vdt4RwIf0fPR6Emqg>
X-ME-Received: <xmr:MqoRZLdpsRlnysxkqmug0-kb3g-_LLAl9iz9bnlfOu13qTIqUAMq56YmIQ77KxK4x4iA5OoDY1m0SM6h7_hof13eSM5y1X5JxU3_u25VFW8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:MqoRZBLZG8FNFWI8SiCuqi7YtOqCHdUARbPmcvNZr5UPYMwBoMOqGw>
    <xmx:MqoRZAJdvTIphE1f4ixw8yzoPfUkaf521lTz1aoRT9kY1Sx1lVRPVA>
    <xmx:MqoRZCwC77YARMsN2RzyMCN-dZSWk0OOS9YC9pAwE2huVdAGWLL2mg>
    <xmx:MqoRZHlsTx563Jw8sxBX3FDa8jp_rNqS5nYhJNQaqHRaTIuuljRVmQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:22 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 45aef263 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 15 Mar 2023 11:20:59 +0000 (UTC)
Date:   Wed, 15 Mar 2023 12:21:19 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 4/8] fetch: pass the full local reference name to
 `format_display`
Message-ID: <0998173b57e8d7aea7a77673fa8e54dc54538a9b.1678878623.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mL4ss3sJwgFWS3on"
Content-Disposition: inline
In-Reply-To: <cover.1678878623.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mL4ss3sJwgFWS3on
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
index f9ed9dac32..bf2f01245a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -887,9 +887,9 @@ static void format_display(struct display_state *displa=
y,
=20
 	strbuf_addf(display_buffer, "%c %-*s ", code, width, summary);
 	if (!display->compact_format)
-		print_remote_to_local(display, display_buffer, remote, local);
+		print_remote_to_local(display, display_buffer, remote, prettify_refname(=
local));
 	else
-		print_compact(display, display_buffer, remote, local);
+		print_compact(display, display_buffer, remote, prettify_refname(local));
 	if (error)
 		strbuf_addf(display_buffer, "  (%s)", error);
 }
@@ -901,7 +901,6 @@ static int update_local_ref(struct ref *ref,
 			    struct strbuf *display_buffer, int summary_width)
 {
 	struct commit *current =3D NULL, *updated;
-	const char *pretty_ref =3D prettify_refname(ref->name);
 	int fast_forward =3D 0;
=20
 	if (!repo_has_object_file(the_repository, &ref->new_oid))
@@ -910,7 +909,7 @@ static int update_local_ref(struct ref *ref,
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
 			format_display(display, display_buffer, '=3D', _("[up to date]"), NULL,
-				       remote, pretty_ref, summary_width);
+				       remote, ref->name, summary_width);
 		return 0;
 	}
=20
@@ -923,7 +922,7 @@ static int update_local_ref(struct ref *ref,
 		 */
 		format_display(display, display_buffer, '!', _("[rejected]"),
 			       _("can't fetch into checked-out branch"),
-			       remote, pretty_ref, summary_width);
+			       remote, ref->name, summary_width);
 		return 1;
 	}
=20
@@ -934,12 +933,12 @@ static int update_local_ref(struct ref *ref,
 			r =3D s_update_ref("updating tag", ref, transaction, 0);
 			format_display(display, display_buffer, r ? '!' : 't', _("[tag update]"=
),
 				       r ? _("unable to update local ref") : NULL,
-				       remote, pretty_ref, summary_width);
+				       remote, ref->name, summary_width);
 			return r;
 		} else {
 			format_display(display, display_buffer, '!', _("[rejected]"),
 				       _("would clobber existing tag"),
-				       remote, pretty_ref, summary_width);
+				       remote, ref->name, summary_width);
 			return 1;
 		}
 	}
@@ -972,7 +971,7 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref(msg, ref, transaction, 0);
 		format_display(display, display_buffer, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
-			       remote, pretty_ref, summary_width);
+			       remote, ref->name, summary_width);
 		return r;
 	}
=20
@@ -994,7 +993,7 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref("fast-forward", ref, transaction, 1);
 		format_display(display, display_buffer, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
-			       remote, pretty_ref, summary_width);
+			       remote, ref->name, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
@@ -1006,12 +1005,12 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref("forced-update", ref, transaction, 1);
 		format_display(display, display_buffer, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
-			       remote, pretty_ref, summary_width);
+			       remote, ref->name, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else {
 		format_display(display, display_buffer, '!', _("[rejected]"), _("non-fas=
t-forward"),
-			       remote, pretty_ref, summary_width);
+			       remote, ref->name, summary_width);
 		return 1;
 	}
 }
@@ -1431,7 +1430,7 @@ static int prune_refs(struct display_state *display,
 				shown_url =3D 1;
 			}
 			format_display(display, &sb, '-', _("[deleted]"), NULL,
-				       _("(none)"), prettify_refname(ref->name),
+				       _("(none)"), ref->name,
 				       summary_width);
 			fprintf(stderr, " %s\n",sb.buf);
 			strbuf_release(&sb);
--=20
2.40.0


--mL4ss3sJwgFWS3on
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQRqi4ACgkQVbJhu7ck
PpTlSw//YLGRLQOPPXhW6wpZ31fSp9YSRTZUadzjcIaduaAWLhPLwlkzWTb5gD1P
MxSDWT61108IdPXl8WaYc9Uy4DyoCOYx8wMbTSauna2AvkDMd+gyVUhNrUGi/9FL
iNSJa1TRgCaDeDmEh3qkSQZtAKiJAEVbOCZKYR23bjS9PvzJLfnJsINLIDFvPakQ
WZ9c6p1nF6J+tUYR5AYTFOo9S9yjiwDWUdD4eUEMWJ7Egaavxunj1sT+OAa/u30v
ltGnuFmCxO97D7tjYE64rNjsTzg9CcUg+xTaTrtukV/wfbm+rl2I2TKm+w6fZZEP
eUlb7ekXeRodPAGNPkBXz4z53JjLjuhGXlQU/dkNYBg/9tUJ0/m+vi3Yq+kua1LH
Z+W9PmJC6i1YHrFm/Jc0NRIfV7IvJenT1RlrnOs43DQuNKriEfMknng2XXyExn2A
jiDC6KlyZ2nkjiV8DrLHe/wEKcSlHlgU8XF09mlOC69HppjE3Z7uSoayo1UfEKUX
BQ+PxjitxCuAzMmRpkF2bPb9ksWFqWgcQGo6upCkAZf9oR6hpinJ9QcBQNwir15F
NcJa2nxyyJXarGkDsNuXy78VUqIrb7DiUHvX2CYqs1+Cq1hLvVppeiyGNHrlruyw
JZ4Cn1saJ1AchIlkWRvFarjk9ToiFERFgZ6GSHsiZ2cz9aeZ0LA=
=m2Zv
-----END PGP SIGNATURE-----

--mL4ss3sJwgFWS3on--
