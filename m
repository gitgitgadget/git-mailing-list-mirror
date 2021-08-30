Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D90C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 10:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12B8610FD
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 10:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhH3Kz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 06:55:29 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:59513 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235818AbhH3Kz2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Aug 2021 06:55:28 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6DB6532007D7;
        Mon, 30 Aug 2021 06:54:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 30 Aug 2021 06:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Y6eMxXdqnmdzMQaPnP/Zbe4v2n9
        oCTT7o+goI34gEzY=; b=UO9Ig7ehA1DVlMZjoW9VOuZ7hrldGJFpbUgoDnCO/s1
        GRPabAU2mUk1yCQ06Rb/8Dswf00Ka9KiQ/O8EPUNwVHxmImy584q6OCB5DO0HEGc
        dBJUEiMIrm39YZZbTBIKeqftfSDUw39HI7gzR1798JO7tNs9Pgjz6DzM9NzUKyeq
        Z7rmsbmR4YijoyLGl/QHye68oFIh5uKDsZrbJUH1UPVvzZJ1p1Hj8f0TxT3b1d1K
        xp3q3gx6m/9+MGgqrTO0WOgV/1+eWbp1XpYuwL3vCH4+0oCiyI4FyWUx/ekFmuxT
        mfpAlEyBwLi2zUTQHqjuk3g5KAby7sdsaBkc68a45Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Y6eMxX
        dqnmdzMQaPnP/Zbe4v2n9oCTT7o+goI34gEzY=; b=ljPLJvxcOKk4F83I4w5xOA
        Eyp3GGJVz05F8N4meDEg1rdxTbnONqFSTm8Seawo4U5c/sNTo1XcwUcvUV7PYj0d
        6BiCGJqNh+eA42F5NGilC9a78bQAaA6oPOpH+dyUZXJwfJje6KJp6tMu0V+F5AWY
        Sqm+bioGaj+QJGpT+Wy9+HeITvSYqeHy5B7IC90T01CaYU4USFYXQsnK/K2qQlE1
        AsbWeTglj8Hmgi0lMaX31U8UZfLMQNoqMyYkTqDk0Vba/uqJe/34ljwBnXfKQHvR
        cGjr8/B4DZSbzkvnfJFlA5N8KHmXReZB8ua7LN/YeOTSBrcR7fPuTAYP80PRVX2w
        ==
X-ME-Sender: <xms:6bgsYSf9DCHkMqkt8DbulIa1n5PbGykHr5Tw4uiANhMAFNxenqAadQ>
    <xme:6bgsYcPv4jdQsErB9P3Rgys6OlerlWSgW30hKmtzTV76LFSZC_PvxIObSbQbDiPNl
    XvmcOq-CEpMLINdIQ>
X-ME-Received: <xmr:6bgsYTigLchjAdiZfWqXxs3HM2qlzdu0v3zwp9X4yUtclzyg7xq4MwKY_RulUt7X7K9SL6NP9dtYcYf3xK_UraET3v8BKkyel5Zm6U4rCFDqNLD7SPRG3Mc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduledgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6bgsYf_z4sH9dOY8G4HcRPsF_8ifSxXkzVLee5Z6mq3Q4BKusScyLw>
    <xmx:6bgsYevBMMKQbna1QhiHwBqXaq-XM0IOlLCVlCbXNosQDsLGMzJueQ>
    <xmx:6bgsYWFPhow-6_-2KVZqR71O9kGUFxbAykhQWRkE0lUoFB5fVN7aqg>
    <xmx:6rgsYTXg_rMfJfAFwZY1lZ1HMiYCuyq9G41dYxKU5kOm51Ru4Fq1Gg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Aug 2021 06:54:32 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8deab7d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Aug 2021 10:54:27 +0000 (UTC)
Date:   Mon, 30 Aug 2021 12:54:26 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2] fetch: skip formatting updated refs with `--quiet`
Message-ID: <e5ffa17753d4aca57d486d500a2d114290361ea7.1630320848.git.ps@pks.im>
References: <40c385048a023dbd447c5f0b4c95ff32485e1e23.1629906005.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v5GcIfGv84ocCkQg"
Content-Disposition: inline
In-Reply-To: <40c385048a023dbd447c5f0b4c95ff32485e1e23.1629906005.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--v5GcIfGv84ocCkQg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When fetching, Git will by default print a list of all updated refs in a
nicely formatted table. In order to come up with this table, Git needs
to iterate refs twice: first to determine the maximum column width, and
a second time to actually format these changed refs.

While this table will not be printed in case the user passes `--quiet`,
we still go out of our way and do all these steps. In fact, we even do
more work compared to not passing `--quiet`: without the flag, we will
skip all references in the column width computation which have not been
updated, but if it is set we will now compute widths for all refs.

Fix this issue by completely skipping both preparation of the format and
formatting data for display in case the user passes `--quiet`, improving
performance especially with many refs. The following benchmark shows a
nice speedup for a quiet mirror-fetch in a repository with 2.3M refs:

    Benchmark #1: HEAD~: git-fetch
      Time (mean =C2=B1 =CF=83):     26.929 s =C2=B1  0.145 s    [User: 24.=
194 s, System: 4.656 s]
      Range (min =E2=80=A6 max):   26.692 s =E2=80=A6 27.068 s    5 runs

    Benchmark #2: HEAD: git-fetch
      Time (mean =C2=B1 =CF=83):     25.189 s =C2=B1  0.094 s    [User: 22.=
556 s, System: 4.606 s]
      Range (min =E2=80=A6 max):   25.070 s =E2=80=A6 25.314 s    5 runs

    Summary
      'HEAD: git-fetch' ran
        1.07 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'

While at it, this patch also fixes `adjust_refcol_width()` such that it
skips unchanged refs in case the user passed `--quiet`, where verbosity
will be negative. While this function won't be called anymore if so,
this brings the comment in line with actual code. Furthermore, needless
`verbosity >=3D 0` checks are now removed in `store_updated_refs()`: we
never print to the `note` buffer anymore in case `verbosity < 0`, so we
won't end up in that code block anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Range-diff against v1:
1:  40c385048a ! 1:  e5ffa17753 fetch: skip formatting updated refs with `-=
-quiet`
    @@ Commit message
               'HEAD: git-fetch' ran
                 1.07 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'
    =20
    +    While at it, this patch also fixes `adjust_refcol_width()` such th=
at it
    +    skips unchanged refs in case the user passed `--quiet`, where verb=
osity
    +    will be negative. While this function won't be called anymore if s=
o,
    +    this brings the comment in line with actual code. Furthermore, nee=
dless
    +    `verbosity >=3D 0` checks are now removed in `store_updated_refs()=
`: we
    +    never print to the `note` buffer anymore in case `verbosity < 0`, =
so we
    +    won't end up in that code block anyway.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/fetch.c ##
    +@@ builtin/fetch.c: static void adjust_refcol_width(const struct ref *=
ref)
    + 	int max, rlen, llen, len;
    +=20
    + 	/* uptodate lines are only shown on high verbosity level */
    +-	if (!verbosity && oideq(&ref->peer_ref->old_oid, &ref->old_oid))
    ++	if (verbosity <=3D 0 && oideq(&ref->peer_ref->old_oid, &ref->old_oid=
))
    + 		return;
    +=20
    + 	max    =3D term_columns();
     @@ builtin/fetch.c: static void prepare_format_display(struct ref *ref=
_map)
    - 		die(_("configuration fetch.output contains invalid value %s"),
    - 		    format);
    + 	struct ref *rm;
    + 	const char *format =3D "full";
     =20
     +	if (verbosity < 0)
     +		return;
     +
    - 	for (rm =3D ref_map; rm; rm =3D rm->next) {
    - 		if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
    - 		    !rm->peer_ref ||
    + 	git_config_get_string_tmp("fetch.output", &format);
    + 	if (!strcasecmp(format, "full"))
    + 		compact_format =3D 0;
     @@ builtin/fetch.c: static void format_display(struct strbuf *display,=
 char code,
      			   const char *remote, const char *local,
      			   int summary_width)
    @@ builtin/fetch.c: static void format_display(struct strbuf *display, =
char code,
     =20
      	strbuf_addf(display, "%c %-*s ", code, width, summary);
      	if (!compact_format)
    +@@ builtin/fetch.c: static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
    + 					       "FETCH_HEAD", summary_width);
    + 			}
    + 			if (note.len) {
    +-				if (verbosity >=3D 0 && !shown_url) {
    ++				if (!shown_url) {
    + 					fprintf(stderr, _("From %.*s\n"),
    + 							url_len, url);
    + 					shown_url =3D 1;
    + 				}
    +-				if (verbosity >=3D 0)
    +-					fprintf(stderr, " %s\n", note.buf);
    ++				fprintf(stderr, " %s\n", note.buf);
    + 			}
    + 		}
    + 	}

 builtin/fetch.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e064687dbd..fc7b6bb84e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -712,7 +712,7 @@ static void adjust_refcol_width(const struct ref *ref)
 	int max, rlen, llen, len;
=20
 	/* uptodate lines are only shown on high verbosity level */
-	if (!verbosity && oideq(&ref->peer_ref->old_oid, &ref->old_oid))
+	if (verbosity <=3D 0 && oideq(&ref->peer_ref->old_oid, &ref->old_oid))
 		return;
=20
 	max    =3D term_columns();
@@ -748,6 +748,9 @@ static void prepare_format_display(struct ref *ref_map)
 	struct ref *rm;
 	const char *format =3D "full";
=20
+	if (verbosity < 0)
+		return;
+
 	git_config_get_string_tmp("fetch.output", &format);
 	if (!strcasecmp(format, "full"))
 		compact_format =3D 0;
@@ -827,7 +830,12 @@ static void format_display(struct strbuf *display, cha=
r code,
 			   const char *remote, const char *local,
 			   int summary_width)
 {
-	int width =3D (summary_width + strlen(summary) - gettext_width(summary));
+	int width;
+
+	if (verbosity < 0)
+		return;
+
+	width =3D (summary_width + strlen(summary) - gettext_width(summary));
=20
 	strbuf_addf(display, "%c %-*s ", code, width, summary);
 	if (!compact_format)
@@ -1202,13 +1210,12 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 					       "FETCH_HEAD", summary_width);
 			}
 			if (note.len) {
-				if (verbosity >=3D 0 && !shown_url) {
+				if (!shown_url) {
 					fprintf(stderr, _("From %.*s\n"),
 							url_len, url);
 					shown_url =3D 1;
 				}
-				if (verbosity >=3D 0)
-					fprintf(stderr, " %s\n", note.buf);
+				fprintf(stderr, " %s\n", note.buf);
 			}
 		}
 	}
--=20
2.33.0


--v5GcIfGv84ocCkQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEsuOEACgkQVbJhu7ck
PpQDbg//Uh27hzS4kuyi1U5TvBhL35ROrjDwSE3TGZ/Iz9ZpPzfgvKDuhp6Uv/Y3
VW+UyS5CvHQBDghBCFenSd6KmkoTd9xJCctLCtzGXD7maS+x9aImDidnRUe2oZU9
YA0GCIpMWwj5Uv+JzZuP8YYbXrNXtP9OYvmIDzwtbKzcFP0Dkf9qmKt6DDJolHCe
ieNeIbHT6YXnDBNLg8zOQ6NR1+p6FHInRbduJf4ZCy4npIe0+QV1lI5/fLvzS69x
Fyc4qSn5vzfoeihydMp0N3jDdzxeywTYd2XXCQW+9jNgVIJs02/3l3EG41dmxN1w
0nMA7Ps7n610FwLl6MYwO1oIqDlvIOpu3Y6hCUsiU+8ope2XwIdTCztvWcIOpRV3
29maoYWO1NmV8YQIGic+ZCVbJKOl4TdPj5Vi8aaBfhb27GE62N5Bg1J5L+j54RNq
gcsIBW+yXPtUVFkeeUKdB8tRZamFgDdRGzhCi94osNAw9pFhFXot73LFQx0j2lD/
Y5DcqLkWOw32aS2tI7DWUJmzfVleAdw+rZVqr0KxwYZQ7ePPrqaHJaHmZG6D3omv
g4hsBMXCzupaccY60jlSn/ln3hUWAt1vf1TbkVKKz/YLY7Nna6bAE1Gt9t/gx8cW
xa0jZ6yqDU1thWepAvn8z7r0vs4aucnXx0HCpxO/mBlWC4mH/PA=
=eka4
-----END PGP SIGNATURE-----

--v5GcIfGv84ocCkQg--
