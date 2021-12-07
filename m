Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DC2C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 10:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbhLGLAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:00:25 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33625 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235472AbhLGLAY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Dec 2021 06:00:24 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 739CC5C019E;
        Tue,  7 Dec 2021 05:56:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 Dec 2021 05:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=HemMUxYexzt6UrZS38Rast9rIRK
        q0c+cXxe7osGeW7E=; b=IfxjitxKIM73KzO/cMFdxDWlI1tPF9rRvAsf+Z1WUzr
        xJyZtIQhL+bAxboGBp+Z5xKm/8vOd6LQLPZll1zjwPOM5Ayqz6v9d0AEbyg6uf4v
        By494wof8WHltq/G6gvge+MVUfyrIeSaQv98qTmtG7i1x7ulOILnV+OWKHcDLCHq
        QBiwusNgpWDPyYPKqegRE0aZQjWUOagm5t7DDqCzcVezxRDEwgLlHAj2M/pP0z4w
        heqovm+PVPtrHh3eQKWcbwLT2JtFrATiA8fYV+glnKDlK6IwGnPqiylDale1o2al
        Fn1KiUZM+4Vf3SOG9msrR0rTvTw434uss8wMy372gjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HemMUx
        Yexzt6UrZS38Rast9rIRKq0c+cXxe7osGeW7E=; b=XWmQAfwvcrvve3Hb4YidQt
        3XnNJlOqmsopJwhV4WLL+KFVTpB5GZZv3dtxeC14etxQDVMTws+/7n03as6HmMwY
        8ivK9erkDObyIZur13HzoDwvh5vuX3UhuhzCcUcwjWaPz6lI2YuySnDJ0A6LDT78
        BvS+IByZCg1/tESrfEo0bhVENf50F8ZtSLoqqCvqr6Wcjwl+ToNveM96TikODG43
        kRlcKbQ5vBg0WU7s0YMDAudaFJD0dR1z+w2K0KaHqhdn2CWFMRMhuwBFk/Q7NBm5
        RGuvzNf66suCcNJMyNB9aERGkfzIRiS5W6cgSpo4fXin+SA70jPrYAeAM4Po3xeA
        ==
X-ME-Sender: <xms:9j2vYXFbKvOxq68z4zkDufrgEtyIZ_F1QJef8_JNnfhgXOe4-qoNlg>
    <xme:9j2vYUWRUil_AgKWAOoAMUdo_HlQPCq653ykk9B8ZvwgN1HlLn2SFs_iiGEgHVUYw
    I4iJQISEf69iFAVRg>
X-ME-Received: <xmr:9j2vYZIwqH9A44eqU9FfNtp4GyCmnJhrzTOVuKXJaCuIdmo2oje6pfeokghYByQ09AhbMGo7r0zEyutYSjzZNjZsjoBdut4yvuRtHzpRA1yUepsS1-Y_tCG3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:9j2vYVFGux20-k7Wa2pmMLbprm3EGYqji88XMb8WpdMkxG32gZqqyA>
    <xmx:9j2vYdV62TapZgzBHCccugEYfdw0thCltzh7YRTdcW_70zHhGwj0Kg>
    <xmx:9j2vYQNHNzIcMrxd0NPTBkDRH1wx8SVynOd5UyxFlx6wvFq1D--ohg>
    <xmx:9j2vYagt5-0Pam08TneoBGhxLysJcrTFgVd-F-aLeJrMPgYNxC5zCA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 05:56:53 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 87838cd9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 7 Dec 2021 12:26:32 +0000 (UTC)
Date:   Tue, 7 Dec 2021 11:56:13 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: [PATCH 5/6] refs: do not execute reference-transaction hook on
 packing refs
Message-ID: <e2120adf57f0c8b00a9ee66faad01325300a5254.1638874287.git.ps@pks.im>
References: <cover.1638874287.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="etWwP27+0XZjiBeO"
Content-Disposition: inline
In-Reply-To: <cover.1638874287.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--etWwP27+0XZjiBeO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reference-transaction hook is supposed to track logical changes to
references, but it currently also gets executed when packing refs in a
repository. This is unexpected and ultimately not all that useful:
packing refs is not supposed to result in any user-visible change to the
refs' state, and it ultimately is an implementation detail of how refs
stores work.

Fix this excessive execution of the hook when packing refs.

Reported-by: Waleed Khan <me@waleedkhan.name>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c             |  6 ++++--
 t/t1416-ref-transaction-hooks.sh | 11 +----------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 95583dcd00..f2bc72f81b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1122,7 +1122,8 @@ static void prune_ref(struct files_ref_store *refs, s=
truct ref_to_prune *r)
 	if (check_refname_format(r->name, 0))
 		return;
=20
-	transaction =3D ref_store_transaction_begin(&refs->base, 0, &err);
+	transaction =3D ref_store_transaction_begin(&refs->base,
+						  REF_TRANSACTION_SKIP_HOOK, &err);
 	if (!transaction)
 		goto cleanup;
 	ref_transaction_add_update(
@@ -1193,7 +1194,8 @@ static int files_pack_refs(struct ref_store *ref_stor=
e, unsigned int flags)
 	struct strbuf err =3D STRBUF_INIT;
 	struct ref_transaction *transaction;
=20
-	transaction =3D ref_store_transaction_begin(refs->packed_ref_store, 0, &e=
rr);
+	transaction =3D ref_store_transaction_begin(refs->packed_ref_store,
+						  REF_TRANSACTION_SKIP_HOOK, &err);
 	if (!transaction)
 		return -1;
=20
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hoo=
ks.sh
index 0567fbdf0b..f9d3d5213f 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -150,21 +150,12 @@ test_expect_success 'hook does not get called on pack=
ing refs' '
 	git pack-refs --all &&
=20
 	# We only expect a single hook invocation, which is the call to
-	# git-update-ref(1). But currently, packing refs will also trigger the
-	# hook.
+	# git-update-ref(1).
 	cat >expect <<-EOF &&
 		prepared
 		$ZERO_OID $POST_OID refs/heads/unpacked-ref
 		committed
 		$ZERO_OID $POST_OID refs/heads/unpacked-ref
-		prepared
-		$ZERO_OID $POST_OID refs/heads/unpacked-ref
-		committed
-		$ZERO_OID $POST_OID refs/heads/unpacked-ref
-		prepared
-		$POST_OID $ZERO_OID refs/heads/unpacked-ref
-		committed
-		$POST_OID $ZERO_OID refs/heads/unpacked-ref
 	EOF
=20
 	test_cmp expect actual
--=20
2.34.1


--etWwP27+0XZjiBeO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGvPcwACgkQVbJhu7ck
PpQLFhAAoCX1xHf6d/fAPUnkMe5k+HOLUVppDTyMUJkTt43+XHlpF5ixjCI1Hla/
6mrwKoT+JZ1w+Vy15bSPfL6BNTqm8en67ARap/rdD+EXt7QhNsl07kLNwVSKXZWN
pV/7e8Ec8ZH7wUwayxIcHFFron2tdtMKu6HlCitZWaRPDoQlZg2x7A/dTEaHbSTM
qTMN8EVeXDdo7dmMIqKVDtUiZuQ6qbto0Pdoeyn3TDeVjFDotLUbJphhGE4d5VTd
HrLqw3T6DIDoa9QdSGw7fVWwNoCnrLansqVPxa7JSCJV5I1x5f9zuSTjrRSshRKP
0ihGTwbOxgtGgKn4hmxQ7EOISqKeul74QMOnTGOIEwXKkuUynxf5zAUQVnOLg76S
TDuSH1Kl6Zise3OU5m+RRNQhKC4imNwO7hEJxPa9qROxhYNHCcgQ1xb19AK4G3ne
iL4zn4KjMMqrrhIQZnUFTcwAr5V7PQid0h0PlnDaWqcyM+lFtNpm/qLAevRBJ60L
hKR5gBpQIKvmxveWiT0VmSVSPvR1Fe1gtWLIDjolZSiusmdYhv9WzMuxc6VmrFkA
OL1dTIA5UlkLqypV1bR6m/6mwW+w2GnOjSU81cB20J9Z1hMKbcU+1V2XGkImXT4G
rIfUPzStxaKQ7aKAgM7tY73ajg1N69JBSfg1juGNYVk0U6ejF4Y=
=W3PJ
-----END PGP SIGNATURE-----

--etWwP27+0XZjiBeO--
