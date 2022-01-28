Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FE2C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 10:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347818AbiA1KTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 05:19:34 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:45597 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347815AbiA1KTd (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jan 2022 05:19:33 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 41B0F32020BB
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 05:19:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 28 Jan 2022 05:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=NAeNbJ6bC/xiLnoPh/WWWHVUMaK3yxFOs0CwOR
        UQjs0=; b=S0/oK9ZdHELb9pSlDp1tVzfO1RsgbC3efznJaF2iU1Fvpt+JxDKLzA
        Qjx2TYS3BNqou426hT1WV2j6j6dFIq2YSavtrs57+WQRj/8INbfSenyUwtDWkAGo
        N3/3wuv0egd1ylh9R+BEaLs4RP6ashtvm6fbY5c9X5XuEcmzVBgau+VoLuLvuRxf
        N6qlowckRlvMBAixHnAYQJ4ij+M494ewpmdvD4eO8XDkwTyKQZdr9/vzPFvU/NZf
        9Lc0+TVBP8UpkbsTuFwO4FhLZWdiDEDU3MHZ+3ohmmBwR9ADoqLevmg2yTD7U06X
        LlO+pLteOwZg/JX5YtEqEADtCOACd6Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=NAeNbJ6bC/xiLnoPh
        /WWWHVUMaK3yxFOs0CwORUQjs0=; b=P1qiXXTurVBYI8YnJRssa9h4t3wkta9OO
        kap6H1CtAJBxB8qYn14o8KnutoJNnOxHved6rr3Lzfk2rxf8yeV9JLd5/nm/Qk3D
        omVZutKzuGp0MJrJ+hUdwyscsDKIDXh+hGfmr4n9z74ToRZRDLDwzXW4+BU7zoAF
        AdayUOyRTVX4RDgBmIWErHWdAdVFtY17ey0/zl3XI8XhnqoTD6NVeH56v9GWYTfm
        Rc7am6ahKdHQgrpAusu77VFtQ205JRjo6sN8DeeB6aOyLMwfZtyg8YphkP9GTX99
        wRl3Jqjt4on6a+kJZVu+h0KASKvVbePrDCMFtc04lxUiSVKrOfUWQ==
X-ME-Sender: <xms:NMPzYUXVEqy3hMNlgrVsu10WrMILt34nZYMAcSIWtXhrzuzT6WI5WQ>
    <xme:NMPzYYnoMulHUzS7UebQOYtJUG497nop9C2e1Rn24M_Mfm_Gswe7aMMtoWf5DX_WM
    U3efSQl5mB3YIINiw>
X-ME-Received: <xmr:NMPzYYZwRCvaN9KXLwiU1JRRgLtnZ5Ev4tldEpyATv7qBKxVC5DLruOIK_pSa-imaAFSOZDHS2Na4LXdMquf8mRKV179fZgQRiZ-whJyBkywB8dPxO1a3gc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeehgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfeejie
    dvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NMPzYTW5px1k90L3koXlUzqsPDLaD7C0dnCql_dNAyJVb7_eIA3MAg>
    <xmx:NMPzYek97z9gYDAyy5fPlONZLWOaTl7YAQ1MynvjaHfxC76WEJKMEQ>
    <xmx:NMPzYYdOL8xxJdwJLovyZxwEjQAXpOpKOXqebZgCj0W590nHk6q6Og>
    <xmx:NMPzYYRDjtCadM5pY25JMYgExPRh0DBPr4QGKZmvDGUWgoKpUq5FTg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 28 Jan 2022 05:19:32 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b50b74bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 28 Jan 2022 10:19:31 +0000 (UTC)
Date:   Fri, 28 Jan 2022 11:19:30 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] fetch: skip computing output width when not printing
 anything
Message-ID: <5a3fd3232fd9e19e6f0054717a1f54c71bd8f272.1643364888.git.ps@pks.im>
References: <cover.1643364888.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KIxxj8IV7G/OvWBy"
Content-Disposition: inline
In-Reply-To: <cover.1643364888.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KIxxj8IV7G/OvWBy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When updating references via git-fetch(1), then by default we report to
the user which references have been changed. This output is formatted in
a nice table such that the different columns are aligned. Because the
first column contains abbreviated object IDs we thus need to iterate
over all refs which have changed and compute the minimum length for
their respective abbreviated hashes. While this effort makes sense in
most cases, it is wasteful when the user passes the `--quiet` flag: we
don't print the summary, but still compute the length.

Skip computing the summary width when the user asked for us to be quiet.
This gives us a small speedup of nearly 10% when doing a dry-run
mirror-fetch in a repository with thousands of references being updated:

    Benchmark 1: git fetch --prune --dry-run +refs/*:refs/* (HEAD~)
      Time (mean =C2=B1 =CF=83):     34.048 s =C2=B1  0.233 s    [User: 30.=
739 s, System: 4.640 s]
      Range (min =E2=80=A6 max):   33.785 s =E2=80=A6 34.296 s    5 runs

    Benchmark 2: git fetch --prune --dry-run +refs/*:refs/* (HEAD)
      Time (mean =C2=B1 =CF=83):     30.768 s =C2=B1  0.287 s    [User: 27.=
534 s, System: 4.565 s]
      Range (min =E2=80=A6 max):   30.432 s =E2=80=A6 31.181 s    5 runs

    Summary
      'git fetch --prune --dry-run +refs/*:refs/* (HEAD)' ran
        1.11 =C2=B1 0.01 times faster than 'git fetch --prune --dry-run +re=
fs/*:refs/* (HEAD~)'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

[Resend with correct In-Reply-To header.]

 builtin/fetch.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f06b21f8e..ebbde5d56d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1093,12 +1093,15 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 	struct ref *rm;
 	char *url;
 	int want_status;
-	int summary_width =3D transport_summary_width(ref_map);
+	int summary_width =3D 0;
=20
 	rc =3D open_fetch_head(&fetch_head);
 	if (rc)
 		return -1;
=20
+	if (verbosity >=3D 0)
+		summary_width =3D transport_summary_width(ref_map);
+
 	if (raw_url)
 		url =3D transport_anonymize_url(raw_url);
 	else
@@ -1344,7 +1347,6 @@ static int prune_refs(struct refspec *rs, struct ref =
*ref_map,
 	int url_len, i, result =3D 0;
 	struct ref *ref, *stale_refs =3D get_stale_heads(rs, ref_map);
 	char *url;
-	int summary_width =3D transport_summary_width(stale_refs);
 	const char *dangling_msg =3D dry_run
 		? _("   (%s will become dangling)")
 		: _("   (%s has become dangling)");
@@ -1373,6 +1375,8 @@ static int prune_refs(struct refspec *rs, struct ref =
*ref_map,
 	}
=20
 	if (verbosity >=3D 0) {
+		int summary_width =3D transport_summary_width(stale_refs);
+
 		for (ref =3D stale_refs; ref; ref =3D ref->next) {
 			struct strbuf sb =3D STRBUF_INIT;
 			if (!shown_url) {
--=20
2.35.0


--KIxxj8IV7G/OvWBy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHzwzEACgkQVbJhu7ck
PpT51g/+K1xg1wD+pyKUJKp8t2ny+PQltYBcTTZKr28el5iTbRt1lpK8EsDwswQv
wTPKYq8B8GZcR8W8FD3gQOhE3LEmgiU/rSxS9ElVVwYAkBIkjIMfxuD1rdTZoSqU
tcl6M917m6tTOJY+bNUHtpU2SD0g9P9AI9CrbFH6IDjw/rJkRV94bogUv6raL1q/
EV+r37Skap1nxHo2g1T4GG1OESpVu/Ts29Hnk/KZxZN3QnFgA8GrU9NBDSW9hGTB
qrXrNz3adsnRR0+cmtkr68ZWTpTKhhispCBcySUXtqdYtXn4R0PIiogktgnbDjU9
CC6zKcU5jY8gSTrdFM/hknZgHJyDXjj7KfQQ4sjJQdJn2ho4feAEd/4zxC3giXns
5HaYTa+K31zW8NoQrpKxRURKbEZxMCFK0td8mPJL4VzuLE5QUCMBS3KIE4bUciC7
7gX74PKNJIGhUgkCaG1t4oO9AC97h8yUUQL1pQwAmlRNF9zf/i+yrG+xLgwNbm/o
qdY2jcfJKnTJHb2Vd2yxs2mnhLdyX0BodjogUhrslM4KXnjS4PliOF6V4WP5v88Q
xfNfvAuE2Bvl01ohCvpjYUyDPHelPUjqR540V9bK+cUFvEsYItp+tfTia7nTN9kH
Jrbju1bOq9u/E+qb9V1l6v60YecOUISXpBA7KG4yEsRZaK2VBK0=
=/Qrx
-----END PGP SIGNATURE-----

--KIxxj8IV7G/OvWBy--
