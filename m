Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2097EC433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 05:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbiKQFrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 00:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239165AbiKQFqx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 00:46:53 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507386DCC8
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 21:46:52 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 87CE13201B62;
        Thu, 17 Nov 2022 00:46:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Nov 2022 00:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668664011; x=1668750411; bh=qtH7VbMmms
        GFeinUR1MSz0ml5uPXrwh18MTncSmrldk=; b=NTRfnm9CE1fVH2RXcGN391csoB
        TNiyipYqPv24lCRSZWo9PfWkRLGr6Xcvcu7pU41yolF95/AivOdmZIdwsmRg+09T
        QkYMCciL0WF77yqxnfqzSwLwFORNchyYFGEG2uIg0iKMRcTIF3VGIOkTDT/ReMK0
        B+kZu5BZW4Gn/01mtnmmIMEOllCEgy8v+vrtVKG1Iale93rBGM7r1HiswAXPQQ/r
        OHArlxe8+DtgOKCsSbh6BvLHIL+ga+plbN8BTuRPElXijCtsGjb09dQ0zGV+A89o
        v8YUF9xcxg5s+2eoAsLu9vf/HkVVFdQggfZ3WsZErLPpGeAz7R/92RglW7/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668664011; x=1668750411; bh=qtH7VbMmmsGFeinUR1MSz0ml5uPX
        rwh18MTncSmrldk=; b=IKYZ2KKCWoFbyYM6dRWeK+5IhK/zYDQ9hL0i7vvpTY3+
        vwBMlIaR8r85VZ4rz9/yWMeUyVBkeAHd8I51vdTppZ7mLJXKEN+BRgUNpBBD/AbE
        ioUfl+jlvuIdq2jisey7eRHZJnYhh72MjWAQk/g2BVcn4WcR5kuFJLomPpmea4hw
        1bwHYfq9Icv9KUgJwRFnrEGuDZhuiCd/yzrNTVPMWpMF7KOAuSOkezmFpv0rYpxE
        N7ubKbLp5WcFYHNHSFVDbKkFsz1b57PQJ9K1MdA/ymQYWB0bPwkqZJkjUJj8o0l0
        d5qT+YpefBrmaOTOvlw5qGbylP5/XMP38bIvaVfPHw==
X-ME-Sender: <xms:y8p1Y7FsbcNOT49wpO5la2dQHVHhVdSoe5W1lUopPBi3anTSNymQHQ>
    <xme:y8p1Y4VpYH4kC7xnwvA0wm8p6LQaO1xUu12GZsaDV7SpbXy-mv7G-hejeHL6JrqBa
    rtfM16AFCUK18iV4A>
X-ME-Received: <xmr:y8p1Y9LD1gF0MTlrR6e7C09ZgvEJ3ai6o5d8Dmjtl5k8aqQ4tQdoevkca2jRgsuCxN1pePtzpp0COi9VU-oHNjk1NmN0JY8VUAV01oceEGPIUEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeejgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:y8p1Y5F426Llqweh62TGS-UPjh3HDMRKnNvbKxfLmYMsC6bOXOe81g>
    <xmx:y8p1YxVgtKVBOlqpnP48F7c-8tlRQmOIuQH3sL0RTYhsXPzNbUAlbg>
    <xmx:y8p1Y0NjYubTbYEeqqNrVwWVWL46wK78nlbCggsf5cwEMje8mo9jug>
    <xmx:y8p1Y0TOrKnKSu9uTcdNxBIzpnUKt1Crb2JyjDL0FvUbr3hoNr2Lxg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Nov 2022 00:46:49 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 173e13e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Nov 2022 05:46:35 +0000 (UTC)
Date:   Thu, 17 Nov 2022 06:46:47 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v6 3/7] revision: move together exclusion-related functions
Message-ID: <3827d6a2fcc9f3a14c6ebd2cca47d53d2d6cfa5f.1668663796.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668663795.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dLTwcLsY2MA+hzv0"
Content-Disposition: inline
In-Reply-To: <cover.1668663795.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dLTwcLsY2MA+hzv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move together the definitions of functions that handle exclusions of
refs so that related functionality sits in a single place, only.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/revision.c b/revision.c
index 0760e78936..be755670e2 100644
--- a/revision.c
+++ b/revision.c
@@ -1517,14 +1517,6 @@ static void add_rev_cmdline_list(struct rev_info *re=
vs,
 	}
 }
=20
-struct all_refs_cb {
-	int all_flags;
-	int warned_bad_reflog;
-	struct rev_info *all_revs;
-	const char *name_for_errormsg;
-	struct worktree *wt;
-};
-
 int ref_excluded(struct string_list *ref_excludes, const char *path)
 {
 	struct string_list_item *item;
@@ -1538,6 +1530,32 @@ int ref_excluded(struct string_list *ref_excludes, c=
onst char *path)
 	return 0;
 }
=20
+void clear_ref_exclusion(struct string_list **ref_excludes_p)
+{
+	if (*ref_excludes_p) {
+		string_list_clear(*ref_excludes_p, 0);
+		free(*ref_excludes_p);
+	}
+	*ref_excludes_p =3D NULL;
+}
+
+void add_ref_exclusion(struct string_list **ref_excludes_p, const char *ex=
clude)
+{
+	if (!*ref_excludes_p) {
+		CALLOC_ARRAY(*ref_excludes_p, 1);
+		(*ref_excludes_p)->strdup_strings =3D 1;
+	}
+	string_list_append(*ref_excludes_p, exclude);
+}
+
+struct all_refs_cb {
+	int all_flags;
+	int warned_bad_reflog;
+	struct rev_info *all_revs;
+	const char *name_for_errormsg;
+	struct worktree *wt;
+};
+
 static int handle_one_ref(const char *path, const struct object_id *oid,
 			  int flag UNUSED,
 			  void *cb_data)
@@ -1563,24 +1581,6 @@ static void init_all_refs_cb(struct all_refs_cb *cb,=
 struct rev_info *revs,
 	cb->wt =3D NULL;
 }
=20
-void clear_ref_exclusion(struct string_list **ref_excludes_p)
-{
-	if (*ref_excludes_p) {
-		string_list_clear(*ref_excludes_p, 0);
-		free(*ref_excludes_p);
-	}
-	*ref_excludes_p =3D NULL;
-}
-
-void add_ref_exclusion(struct string_list **ref_excludes_p, const char *ex=
clude)
-{
-	if (!*ref_excludes_p) {
-		CALLOC_ARRAY(*ref_excludes_p, 1);
-		(*ref_excludes_p)->strdup_strings =3D 1;
-	}
-	string_list_append(*ref_excludes_p, exclude);
-}
-
 static void handle_refs(struct ref_store *refs,
 			struct rev_info *revs, unsigned flags,
 			int (*for_each)(struct ref_store *, each_ref_fn, void *))
--=20
2.38.1


--dLTwcLsY2MA+hzv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmN1ysYACgkQVbJhu7ck
PpRxExAAlmxr51OhjevcKjfwgMGn6BD9XD/9PaHZxcCSjQeagVDKtCoxj9bpSi2o
lLK3fyRTYrfnhPsmxqaV/TWTClzuzGVs4QAMs0+8YGjds0/0lAGTUs0TB2v1giUR
2Puc1eEquQostZKkObL0FcVryTPjnJRdJ4NVLVN1tBgHi0C37+vPNHhMcxtO/I+C
85UiBzZvUJbEjdEkZce+OLWnAweuqltSFAg++vtIjEchqzBgVsFafTbOVx3IPuHW
J1OSdu7ndYQERW21+3J3CwHpBCweQqajPtFZ2RCu3GMH13QYu5BE+SjuGXJrrY8n
0mRqRO0D4W8w/XyosNeO94+t9FVWPKE6AVUZKVkI3ofH6uP97Q7D5YUc+mZV1YvP
Rek5e/DWqzlvd6CnYOnNhScmAZLnaBISgi0NnnewWXt8MohM+GGXPyIBA3KJCjq/
GqEnzMTq8liavT+JfDj70T66XNsCqth0rvx9W2aWAv90piBQJ3V57ErLJsTqXUEj
nLZ8EiYsDm1X1XSTr/TufDSRuMSn1v9jcB97o85u5d6gAvnNbtfUdR+eILz0oZox
oG/rOsNAEy7B3baq+7dA1oHyS7wN+uN0p+V3c7bOzcQfeRBZ8QDyrKp5vNlYyqmm
jACD1SKX98utQIeSmJm3N25oPjCRwPJwm20qMQn3+vmoCRjT8A8=
=znwa
-----END PGP SIGNATURE-----

--dLTwcLsY2MA+hzv0--
