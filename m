Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF22C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 07:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6FB6221E5
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 07:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="raqF7Iuj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I11BhHk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgHGHGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:06:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37891 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgHGHGE (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Aug 2020 03:06:04 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B6AAC5C01E4
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 03:06:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:mime-version:content-type; s=fm1;
         bh=388xvlQIGgD2MtKKcv7albsz5H75FohzfK/5xpsbSHk=; b=raqF7Iuj5LDh
        IOxBLFJu9A90jtCvdoF6ufSDZRtonm+Tpo2v37/3JXA5WazbTXaf06gRbnhUVB7+
        z68z8aZmUa5v2cqLmtAPYV+FedwyJLkM1555YUmbyZpsbM9kQIwvqkOj/ClkhnO8
        /8jLQWQf9OKj9DCUuGWKAcqswuGBqHq+D/3LYzDLPbRWfqGIxvG2SPeyMAEbySSi
        6McLkuEoP3pVdgvd8jdwiZyJjp+XV61eXSjT/x2XSBgSlpCGvcQLe1R6rgeZnPnp
        yaQiF8nqBtWwdnTGkOElkKlRhtL/gAblTLY6IlY/FR6nfs4oQ6jIQ0uRrGnHpzqN
        OJOTcMD80Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=388xvlQIGgD2MtKKcv7albsz5H75F
        ohzfK/5xpsbSHk=; b=I11BhHk1mzTB6lBJs7M05GLSWIqYyPF+/1ZkkvPBPCZ0z
        k1PmH8wIe5WHyLxr3NYmi6Pkw9udqyLOnNe/aC1RkFOxFNNT5b006vmBwsfC3vce
        sWaCtP+xkI+UcyyqmyZ6YV+fHp93hvQfVHb4zNLQOIMTPJ69bLaAqJheEJ1yyu36
        vz2Z/HEmHbR+PhsZR1rMXt+pkHV7rB/19WlFGpUcSt0+Z+DjkYTAuGq5fPvgCttZ
        dU2fhRTfQF5aILQPgAZCwVBy/d/yogWMTozVLbnDIQ/4OUg97TiIJbjWaAXiWlir
        akvnskawDay89mcdh8MItcWOiX2v7LCVzEJehNgqA==
X-ME-Sender: <xms:Wv0sX9xpkjGu0lX0mjM3AfDDEB89SjH4aZSDkVNfC8fqDR4Z9ZSkVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecukfhppeejjedrudekfedrvdeirddugedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:Wv0sX9TWOE01xZVgrQRfuE5rAjsFtOM_ZwqgsyYetn7eWrqhsmEAew>
    <xmx:Wv0sX3VIBs21frlCVOzG_9Fm8--ja3qVl4jXO_0FuneddZrPqvqwWQ>
    <xmx:Wv0sX_hjhXc6m-SmI26rHqE0C68-pVE1GUIIVbA2lIxgqxuNLjpNMg>
    <xmx:Wv0sXzxWwfGVKaOvEHCpj7WUunfw02PCVBB9Hbr3C16IfD4CoHB8dA>
Received: from vm-mail.pks.im (x4db71a8c.dyn.telefonica.de [77.183.26.140])
        by mail.messagingengine.com (Postfix) with ESMTPA id CE82130600A3
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 03:06:01 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ac177629 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 7 Aug 2020 07:05:59 +0000 (UTC)
Date:   Fri, 7 Aug 2020 09:05:58 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] refs: fix interleaving hook calls with reference-transaction
 hook
Message-ID: <63fb363375b515b903ed1269d10124b727c1d1cc.1596783732.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to not repeatedly search for the reference-transaction hook in
case it's getting called multiple times, we use a caching mechanism to
only call `find_hook()` once. What was missed though is that the return
value of `find_hook()` actually comes from a static strbuf, which means
it will get overwritten when calling `find_hook()` again. As a result,
we may call the wrong hook with parameters of the reference-transaction
hook.

This scenario was spotted in the wild when executing a git-push(1) with
multiple references, where there are interleaving calls to both the
update and the reference-transaction hook. While initial calls to the
reference-transaction hook work as expected, it will stop working after
the next invocation of the update hook. The result is that we now start
calling the update hook with parameters and stdin of the
reference-transaction hook.

This commit fixes the issue by storing a copy of `find_hook()`'s return
value in the cache.
---
 refs.c                           |  2 +-
 t/t1416-ref-transaction-hooks.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 2dd851fe81..17e515b288 100644
--- a/refs.c
+++ b/refs.c
@@ -2044,7 +2044,7 @@ static int run_transaction_hook(struct ref_transactio=
n *transaction,
 	if (hook =3D=3D &hook_not_found)
 		return ret;
 	if (!hook)
-		hook =3D find_hook("reference-transaction");
+		hook =3D xstrdup_or_null(find_hook("reference-transaction"));
 	if (!hook) {
 		hook =3D &hook_not_found;
 		return ret;
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hoo=
ks.sh
index da58d867a5..d4d19194bf 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -106,4 +106,30 @@ test_expect_success 'hook gets all queued updates in a=
borted state' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'interleaving hook calls succeed' '
+	test_when_finished "rm -r target-repo.git" &&
+
+	git init --bare target-repo.git &&
+
+	write_script target-repo.git/hooks/reference-transaction <<-\EOF &&
+		echo $0 "$@" >>actual
+	EOF
+
+	write_script target-repo.git/hooks/update <<-\EOF &&
+		echo $0 "$@" >>actual
+	EOF
+
+	cat >expect <<-EOF &&
+		hooks/update refs/tags/PRE 0000000000000000000000000000000000000000 63ac=
8e7bcdb882293465435909f54a96de17d4f7
+		hooks/reference-transaction prepared
+		hooks/reference-transaction committed
+		hooks/update refs/tags/POST 0000000000000000000000000000000000000000 99d=
53161c3a0a903b6561b9f6c0c665b3a476401
+		hooks/reference-transaction prepared
+		hooks/reference-transaction committed
+	EOF
+
+	git push ./target-repo.git PRE POST &&
+	test_cmp expect target-repo.git/actual
+'
+
 test_done
--=20
2.28.0


--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl8s/VUACgkQVbJhu7ck
PpQzIg//ZRmj5w5BuR37zg1LZcT39hV9psVWtU1ViDWea85PvVC+xo55tVADQR4w
dfG/D4hlswfxxujTAnqqBLq+u2YUgK4LrJBKWqCNjqZeATUosJYWsRmxw6NUj8bi
CTZj8efGF94wMtPB2z9YejSPNL895M8a26oIwfoguDtJP+c3x0/v9Merv3zyuZ3l
vTYFbuc1IszUbfD+dHkhqEsmgVrAgBW6+dqBOmEPjsY9Mf5JenswUVP6sQtEnub6
W/j7nkikhK2byLteMtGv5XpuxD3a2Og1pGEPOlo46sw4PpRYeELxs0qREcnlI29S
ihKoM2ONO4O92kDNOrkV6IWsY948JM5z55EKSIMBw/EvZUrLUd0z3hHc+v1HLdRg
M/yXfKLfLAqpydvYuAsU5c47QE9iEoDBDbUDj4VC8JKHkb7B+q6GKxmsmsU65aEs
KMVLYvABsbZ/O5pssVF6/HUMmP9o5wTcdwfUAlhkJ9Dk3HqqdrYd6WR/7CumN2Sd
E57BqyPGLEcysCrNYXgVBos5JMtKoGGdT6bmGi1HxKZKzFe36DOR6bQgMLA9T5y9
uoUBkBmdSy0XLY9HlocXwTXrBoD2XRXsBnVhVDBJXtwizfwtJSuFg/i9EQhBBt8H
CEi1xKbQ4i5uKMxx3p473RTan67WWXmhApN2LPuNYlUJh1JVv4U=
=r75O
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
