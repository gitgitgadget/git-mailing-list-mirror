Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA4BC4320A
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 13:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC95610D2
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 13:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbhHYNus (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 09:50:48 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:47943 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233490AbhHYNur (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Aug 2021 09:50:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 884513200A11
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 09:50:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 25 Aug 2021 09:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:mime-version:content-type; s=fm1;
         bh=j30bBLoSbHF9o+qm//Dklb+2jQcFzP+3fYS8JGrpkqE=; b=s1YUx31vdrVb
        Y3IWPM8Y4khwsqyatCcYyRzMIzjSbjjMIVvVtV05hw4dWAP+f4vJcB5ZsoloqUoA
        2De/9+t6/VNTQhFhb7LOGf68mQE927oUQNWSK7C6SbwFfXNj9r1O/R5fwPLR4XO5
        eJjhP5m3jRIGW6p+jzorXjz1FzFMxWM3YkQhIlzHtVEFTXL4WbFT0F2TD7VJdQBd
        MzNkh5eVw0ioGmxgOVm0m3vkam7pflnb5hLDCoiGN7HWOvNFDL6GKC/cPRS67/L/
        6hS6/ihbGjREChrFHB4p8gS3zxqwKO3+uKpC8FW/+D+df7VeJW1BUICDnHfEO8zK
        1kx7JQ7WbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=j30bBLoSbHF9o+qm//Dklb+2jQcFz
        P+3fYS8JGrpkqE=; b=EjVOLRUenbPSKKGd8wp+9WDSEF3WeaHjjA6wcSxcKMAUT
        lvvysTorXGG3PzIZkX+X1tFcbMKEtnZMjEePx6Kbq3yYg/L5QzO6uUjKBksH+sTL
        A3W61CYvFjeZNav0FxJ6u5RC6FOe7rCwR1kWqOXyCmE59c+awFhoC2AkzGCjAkco
        x5ClhFCm7HUksXXRvd2ecgriMx2benmoVgOFOfa+jYSBNgRPDyfe95lx6Ns+FQvC
        HHLNPukCXt7FDncgrI7i9oc3zgj8UHSgeWIwRiRkPGa32DKYdJDvfe8ui4PTYinS
        1gX9KiTVEMbCcuEczq/qe7G+KZA7wtdE89bw/79FA==
X-ME-Sender: <xms:iEomYXmCsOYsueHL7ppSVH43TemLd1xKi5LK7w8o2MCmz17m-6D7vg>
    <xme:iEomYa1f4kuzDTR9HcggIEcCvtXTH1AfefGPulXtZy7XSCjdnFG42Q5BwbCu79xS5
    HrL-t80vUe39s-xvw>
X-ME-Received: <xmr:iEomYdqCNOJknFjDa0UbVhKhKDu-8_Vb9ER9oIjkh-Tc7yx1fZa_qIXTSJgWqDdH03rCoUcvTIWoRRLrESBMneakhigvFPXD1MLPjzo9Qrb2NPzR_-F9FBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjedtfefftedugfevvdejtdehjefgtddvvdethe
    eiteduuedtteeileetkefhfeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:iEomYfn-xm9vR6SI9WY6__tBNz8ItsdjnX9aOXISHMUHcNnMpdCNvA>
    <xmx:iEomYV0KnphCWhCrpbOQLBsNCn0ta-DNGZC1ADxkvfN3xcRUjdc0XA>
    <xmx:iEomYeuTPK13BbJAtxo82GHuOsrc4xqmKUmONepT4SR09v9-eIii3A>
    <xmx:iUomYSj7Xxj39ZIvuL64P0EDy6b4suViwyEu0GSa_JiEu9AWxu1yyA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 25 Aug 2021 09:49:59 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b841d9be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 25 Aug 2021 13:49:52 +0000 (UTC)
Date:   Wed, 25 Aug 2021 15:49:51 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] ls-refs: reuse buffer when sending refs
Message-ID: <ccd03e685af0f5cf25c68272a758fc88d115e37a.1629899211.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PKXEDhSIIysWFZaW"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PKXEDhSIIysWFZaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In the initial reference advertisement, the Git server will first
announce all of its references to the client. The logic is handled in
`send_ref()`, which will allocate a new buffer for each refline it is
about to send. This is quite wasteful: instead of allocating a new
buffer each time, we can just reuse a buffer.

Improve this by passing in a buffer via the `ls_refs_data` struct which
is then reused on each reference. In a repository with about 2.3M refs,
this speeds up local mirror fetches by about 2%:

    Benchmark #1: HEAD~: git-fetch
      Time (mean =C2=B1 =CF=83):     25.415 s =C2=B1  0.131 s    [User: 22.=
722 s, System: 4.740 s]
      Range (min =E2=80=A6 max):   25.240 s =E2=80=A6 25.543 s    5 runs

    Benchmark #2: HEAD: git-fetch
      Time (mean =C2=B1 =CF=83):     24.922 s =C2=B1  0.110 s    [User: 22.=
404 s, System: 4.476 s]
      Range (min =E2=80=A6 max):   24.825 s =E2=80=A6 25.081 s    5 runs

    Summary
      'HEAD: git-fetch' ran
        1.02 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'

Signed-off-by: Patrick Steinhardt <ps@kps.im>
---

Note that while this topic applies on top of "master", I've done the
benchmark on top of my other optimizations for fetches. It's cheating a
bit, but it's easier to see that the optimization does something when
the remaining constant part is lower.

 ls-refs.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index 88f6c3f60d..84021416ca 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -65,6 +65,7 @@ struct ls_refs_data {
 	unsigned peel;
 	unsigned symrefs;
 	struct strvec prefixes;
+	struct strbuf buf;
 	unsigned unborn : 1;
 };
=20
@@ -73,7 +74,8 @@ static int send_ref(const char *refname, const struct obj=
ect_id *oid,
 {
 	struct ls_refs_data *data =3D cb_data;
 	const char *refname_nons =3D strip_namespace(refname);
-	struct strbuf refline =3D STRBUF_INIT;
+
+	strbuf_reset(&data->buf);
=20
 	if (ref_is_hidden(refname_nons, refname))
 		return 0;
@@ -82,9 +84,9 @@ static int send_ref(const char *refname, const struct obj=
ect_id *oid,
 		return 0;
=20
 	if (oid)
-		strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
+		strbuf_addf(&data->buf, "%s %s", oid_to_hex(oid), refname_nons);
 	else
-		strbuf_addf(&refline, "unborn %s", refname_nons);
+		strbuf_addf(&data->buf, "unborn %s", refname_nons);
 	if (data->symrefs && flag & REF_ISSYMREF) {
 		struct object_id unused;
 		const char *symref_target =3D resolve_ref_unsafe(refname, 0,
@@ -94,20 +96,19 @@ static int send_ref(const char *refname, const struct o=
bject_id *oid,
 		if (!symref_target)
 			die("'%s' is a symref but it is not?", refname);
=20
-		strbuf_addf(&refline, " symref-target:%s",
+		strbuf_addf(&data->buf, " symref-target:%s",
 			    strip_namespace(symref_target));
 	}
=20
 	if (data->peel && oid) {
 		struct object_id peeled;
 		if (!peel_iterated_oid(oid, &peeled))
-			strbuf_addf(&refline, " peeled:%s", oid_to_hex(&peeled));
+			strbuf_addf(&data->buf, " peeled:%s", oid_to_hex(&peeled));
 	}
=20
-	strbuf_addch(&refline, '\n');
-	packet_write(1, refline.buf, refline.len);
+	strbuf_addch(&data->buf, '\n');
+	packet_write(1, data->buf.buf, data->buf.len);
=20
-	strbuf_release(&refline);
 	return 0;
 }
=20
@@ -145,6 +146,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
=20
 	memset(&data, 0, sizeof(data));
 	strvec_init(&data.prefixes);
+	strbuf_init(&data.buf, 0);
=20
 	ensure_config_read();
 	git_config(ls_refs_config, NULL);
@@ -173,6 +175,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
 				     send_ref, &data, 0);
 	packet_flush(1);
 	strvec_clear(&data.prefixes);
+	strbuf_release(&data.buf);
 	return 0;
 }
=20
--=20
2.33.0


--PKXEDhSIIysWFZaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEmSn4ACgkQVbJhu7ck
PpTDVQ//UH4t4A0z8iixtusmqzwl7vOgYylggaJX6NT2Y7FgJKIngIfHkJU8RVX0
e2QMXBx3LKcwNGgxQAf0bAB8Nkw+vfzqY6pH6geCGF1OCKGvnz27mDujbHguPug4
8oIXWPXiqkpJ+qngrB+hjGrUG52zIdmdpl5AOIQZ2wTNs8ajANrlnpJKJ/vV0r7r
LWzwAHayoxeneDxqcJg59ZoZrDHUy752RarogdH4JPZ6YqklC96zfRu5NQ3ucw1T
CL0bcAMxMvFG2QL1SsD5LPrWJBqowJKay1xuUiB2lal+Qkfm628dchxM2xFq0yht
CNLriMMKs/aD9XrUt73OYkGrnlo7GWBdL703FBsWnoThDJUzw88Ib7uGIb5ntNlq
oCrmUHlxupA+wKejhccddkdXqGP41lcVyBoGVSWMZkvWOSDRT300qZur4sfta9/P
HrcOA0dHjXiVKyFe1StsKG8bOX1N3wZ+1LV9WCMQt31K6MDPVpscV/PjjslcoNvB
TVkAdentvQPrTwPh2mLe4V1oWRT8uBxzzR6uU1WltZubyJVPcVfFQIi0bC/QA5F3
QA87nEmVouCqu6D3k1zGdV+p4sKeqSZ7A2smu/QAt7K9QRYjNa4vIBmpSUbX35Ka
LKGHM2rGFyF5jkZMAgkBAEhwpOTBHzelqjE2VxlNYFD8pHdXgmg=
=kLJb
-----END PGP SIGNATURE-----

--PKXEDhSIIysWFZaW--
