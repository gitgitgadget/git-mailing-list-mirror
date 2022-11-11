Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386C9C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 06:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiKKGuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 01:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiKKGuH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 01:50:07 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784F272989
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 22:50:06 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id ADEBD3200938;
        Fri, 11 Nov 2022 01:50:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 11 Nov 2022 01:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668149405; x=1668235805; bh=4PqcJpHMSp
        wNyuIi+2ZF/4YiCLW6D8Sgw1/clclBzfs=; b=a33P3WbJfXopiuQvhbyRLCprC0
        0n5wsqnT3L6hlpF2t92I55rWNnQOfqvOESWCD6iyapZlNnmXp+Mzw2UMAqv16oUW
        Znx0VT6h24CSDMNKiC0/tAcN6SkGdx8qjxKMiZGwkicBO+LZODr71IHSaHUdZIYm
        ClzXTcVjbwVOk7UP8qXcPZcxEJcbDFuoYAyhbCe7OJIGDrrTvz2A1/lNEWGva9SI
        I3JlHkMjxKMbpsJ1uxpbTraBm3tq4JKn+g3p2IcYpcdZBfHbz3P2rGMLecBL1JSl
        JeEiky2BSjdqYaW9Mpu5xRa2VdleMCNPPUwxw0KdT6DN9HWhU0fI1vNwNFRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668149405; x=1668235805; bh=4PqcJpHMSpwNyuIi+2ZF/4YiCLW6
        D8Sgw1/clclBzfs=; b=tHJqAURhoPyVoh4CdtdQIV3J5yD+NG69e2+nAtR8vY3Z
        AuDZZoqWjimRwnNPk2/fBOPd6BVM/JIfMp7FxI49m2Dkzb+wSEOO4YDphMLYm/6p
        rO6V6I/K6DNFARbtwWUzkdKGm1rLoghK5a6VvA/11/2uuhigWusig6S+qiSIc3Mb
        yr2QHGTW5lEO6x99NPjj+FzBVxeJN9dSeN9GSOe9ZInndhZzuP1p7YlPN5aDmr0Z
        6IvNtL+ryGf9D1uumfw+tcsotB4C+6+W7pQbMFs3aTBkS1XJ0JSS/IAkjanYuZli
        VUMSVdDeD9i2mCeP+UQgaYI1D6dhOKmNO5gSSh/+Dw==
X-ME-Sender: <xms:nfBtY6ecaBv3VqfRuHKHNpJGtkxI0T5hnDXqdH0HvjN5iLl9gQD8sw>
    <xme:nfBtY0PZMiyPcT_yveki33nQJoir8rcx2tpfFjomBBaf9CWIkKjtS8zGUTDr60Ytd
    CNl3ThChW4dfjrytQ>
X-ME-Received: <xmr:nfBtY7gL_dtIRi2s9_3UiFOZ8HkK8OqhT7LMcGoQYNKX0BPV57_3KX_p9judgKsVGuD9w6cAZ1y4gpEJwEHh3UQfKlOl4D4f0iDX-rflmulQ_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeehgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:nfBtY3-5yKUhqhijCIM3F8GHSOSytuJKoQVYcnCjrD8A-kykIFebtA>
    <xmx:nfBtY2vZdkzFSwUCZsHh_a-BQ6flxhlSVpsdX0HFcZ26XY6qcAzsXw>
    <xmx:nfBtY-FQew87wMwiLvVjhy9mPhurSt2YsP9J0oGg7QZ0Tr2E0gn6NQ>
    <xmx:nfBtY6KRTuuzgVtKUkNPELoJDtkE9J_W5PrgEieIdKXu6j0_NDErBg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Nov 2022 01:50:03 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f196d6d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Nov 2022 06:50:02 +0000 (UTC)
Date:   Fri, 11 Nov 2022 07:50:02 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 3/7] revision: move together exclusion-related functions
Message-ID: <93a627fb7f79610f67a7eefb29aac6191ea201b0.1668149149.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668149149.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+uuRyUdNrhS+a4ed"
Content-Disposition: inline
In-Reply-To: <cover.1668149149.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+uuRyUdNrhS+a4ed
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


--+uuRyUdNrhS+a4ed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNt8JkACgkQVbJhu7ck
PpTPfA/9GGcMvXW2L58JuycdElPlMVmdN1q6FyvBwsvRh/6QCmu+WPIk8IOJWhk5
CQGEVvMVIM5FCQpNLQ9fMhSlXOlLhDNwkLqYKUT3uEIg2NWvBk6N1Peep6iTsfQ6
bXAb5AX6XxUGt57iFQwSs9aoYDbXfoihD3+kPA3lnCJsQfUJgbcUSneXkNbR4Fyc
c4RuvMjt7qP5pvw7NBFxY+upxHfmd+BdtKgmYNVIPBSEQ2bGuEJk3uhyrVRe3V0s
87oNqD48Jlz9bf5xHq/PSdk5ig7CgonNTK4LvUzjLIjtsS5hWHFv+Zmw35iC3f/B
9TIjADJV1kmZTz2HgFuVhJDHeOkjUSdq5SYNbbWej2WFY7RFa9zpU924l/SM/SYU
1rK3xvO7Syd8I/3obmCr5Vff/CyoydENzEVhl0y4rsZYCg+5Br8mjDK49OcdpW3T
jp36iYwMihmedj11+KOMjaJoOpbHca7Y0BYatZFoBtfsu1rblw9lKky5n17SdJgw
zCWiMbMtX4cJk9WRiLrCj/j6X/ztz2Y4oQ0SCz4pECxnxrR3aXs4Ddyu2s6PJXTJ
k10nPDFh7wZAGMXz+p2lW3RRoVer33q4XAtrpdWQMEmPCFCc2VQSaY1DbRArAmto
2vt2PtafAiiaC1PIuY+qUkr2maQi4bJtE+4bEAcVG2sQ49cVUMQ=
=NwyE
-----END PGP SIGNATURE-----

--+uuRyUdNrhS+a4ed--
