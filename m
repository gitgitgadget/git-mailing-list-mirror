Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB88C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 11:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347377AbiAGL4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:56:05 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51401 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347371AbiAGLzw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Jan 2022 06:55:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 733305C019A;
        Fri,  7 Jan 2022 06:55:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 07 Jan 2022 06:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=nr1SmAtOy3GBx/lE6TSBncnlDJA
        AJ/LeDEHRVB1mL90=; b=ZOCVgGJDEDCsHgLTdWwQ5sv8wqs2AnJ0dLQd4Dgr+lB
        Kazwy3d1XF08DjckY6lBDs+n/T7eJqddqCrpYbL9xOLtoxZPu5ibvbyUrJk7xJdF
        EohSeKdbhxNprpifQalBrH5lSgej45J2DSURh+qomn5bcyoZaGMjVenekU41jeqE
        1TOQ3uS3AzQw9qcGDSNbbRhHwALOHJEaWLTQdugUvzoacJ1kSnPx+eJ8QM9a3ZxW
        i894m8WLsULZ8ku7zah4N/eKZa/gkHj4O5kflZnAmPQkMIAolrl5l301rTdP35Ow
        bhvZS26Xh24gmlm3AEveAc/Qqdo5VEz/qOvZL/UZaDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nr1SmA
        tOy3GBx/lE6TSBncnlDJAAJ/LeDEHRVB1mL90=; b=GroOMtU4opPQUtfsU+p3a9
        OiMHYZ4cq6Ky3b70o4Fc08SYp5eUMhVtKl6vzEvLb5EG5kKa4rcG0Z/GA9vi8wtc
        StblUpye4SztDQdHmsOuWBIiHzcDMcRD3QgTtr6h++M5BJiAEWXjtI0TMgp3Kivt
        6GUhFEMTzj0dRk8YYJpIhGMNWKgOFksRR3xw5t37eU8Mf2gpfEmX7eeBH9IeslDO
        JukunxPOd7MQY+NEDDOX5HzqziR6pPCl4zLGGfHw1O0GKNsMjvTEi1pRmDlE+oXk
        hNQIV6U22bdqUEjNGQwnViuCgNWQGWz9TFwVP/2XVXx5wDQxrwLB2zr3QQrN5XXw
        ==
X-ME-Sender: <xms:RyrYYRT_pgO0I2y64Se2zDDO35QyDo-pRhaPIIXQNZ2mUaCckcDveg>
    <xme:RyrYYayvrF3wXjjTLwaCn0eDzgvnvdEzLi_lbusFQyOrHHKlorZWnlCTwqd9c_sdJ
    A_ksYfO5uqWiYyySg>
X-ME-Received: <xmr:RyrYYW2sSxo9b41jzDidltzn7anh0XLI9LVlIriDTULJHkyQo6XJDT4xCOVWJEwC-SkcBus0Dt7ewUCFtGxIPt1AjU2-eAq3_4iQ_uZt2DQaF1NnSmmwDQD3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:RyrYYZDEge48gkYNOOrZ-kU0VmRbxOW0K4xOng3QWxJ3pZFnrzWfew>
    <xmx:RyrYYajV3XT-ua7A2vemo9f53cWh7xG_PqfMXdtnvRi9rCv2dw3hkQ>
    <xmx:RyrYYdqELzjXnfPlXDgFK39aRfexUhltPwC2QFmroLyBPEpF8XGuxg>
    <xmx:RyrYYdvvXs4c7eSolOlYgCpegv4f2RW-udzMVTFJEEGYF3vNOdrECw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 06:55:50 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 72a2aee5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Jan 2022 11:55:49 +0000 (UTC)
Date:   Fri, 7 Jan 2022 12:55:26 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: [PATCH v2 4/6] refs: demonstrate excessive execution of the
 reference-transaction hook
Message-ID: <b52e59cdac75e6c4530cb39f7dcb41bb327f50e2.1641556319.git.ps@pks.im>
References: <cover.1638874287.git.ps@pks.im>
 <cover.1641556319.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eNaK6z0pM8Rvbchh"
Content-Disposition: inline
In-Reply-To: <cover.1641556319.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eNaK6z0pM8Rvbchh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add tests which demonstate which demonstrates that we're executing the
reference-transaction hook too often in some cases, which thus leaks
implementation details about the reference store's implementation
itself. Behaviour will be fixed in follow-up commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1416-ref-transaction-hooks.sh | 64 ++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hoo=
ks.sh
index 6c941027a8..0567fbdf0b 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -136,4 +136,68 @@ test_expect_success 'interleaving hook calls succeed' '
 	test_cmp expect target-repo.git/actual
 '
=20
+test_expect_success 'hook does not get called on packing refs' '
+	# Pack references first such that we are in a known state.
+	git pack-refs --all &&
+
+	write_script .git/hooks/reference-transaction <<-\EOF &&
+		echo "$@" >>actual
+		cat >>actual
+	EOF
+	rm -f actual &&
+
+	git update-ref refs/heads/unpacked-ref $POST_OID &&
+	git pack-refs --all &&
+
+	# We only expect a single hook invocation, which is the call to
+	# git-update-ref(1). But currently, packing refs will also trigger the
+	# hook.
+	cat >expect <<-EOF &&
+		prepared
+		$ZERO_OID $POST_OID refs/heads/unpacked-ref
+		committed
+		$ZERO_OID $POST_OID refs/heads/unpacked-ref
+		prepared
+		$ZERO_OID $POST_OID refs/heads/unpacked-ref
+		committed
+		$ZERO_OID $POST_OID refs/heads/unpacked-ref
+		prepared
+		$POST_OID $ZERO_OID refs/heads/unpacked-ref
+		committed
+		$POST_OID $ZERO_OID refs/heads/unpacked-ref
+	EOF
+
+	test_cmp expect actual
+'
+
+test_expect_success 'deleting packed ref calls hook once' '
+	# Create a reference and pack it.
+	git update-ref refs/heads/to-be-deleted $POST_OID &&
+	git pack-refs --all &&
+
+	write_script .git/hooks/reference-transaction <<-\EOF &&
+		echo "$@" >>actual
+		cat >>actual
+	EOF
+	rm -f actual &&
+
+	git update-ref -d refs/heads/to-be-deleted $POST_OID &&
+
+	# We only expect a single hook invocation, which is the logical
+	# deletion. But currently, we see two interleaving transactions, once
+	# for deleting the loose refs and once for deleting the packed ref.
+	cat >expect <<-EOF &&
+		prepared
+		$ZERO_OID $ZERO_OID refs/heads/to-be-deleted
+		prepared
+		$POST_OID $ZERO_OID refs/heads/to-be-deleted
+		committed
+		$ZERO_OID $ZERO_OID refs/heads/to-be-deleted
+		committed
+		$POST_OID $ZERO_OID refs/heads/to-be-deleted
+	EOF
+
+	test_cmp expect actual
+'
+
 test_done
--=20
2.34.1


--eNaK6z0pM8Rvbchh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHYKi0ACgkQVbJhu7ck
PpTHkhAAl5wkQS/WmgoM+CgSrSrrN42ov9BwWllcnPiP7s8nQ6OArPbyHd8HH5rh
uq/PXmHAPVVusR7laabZvukeCfKCYgGVYjQVzrq8zFMlgN4VaSNilA2D6haZSZpz
jx5vnQqq/NTNbvIbcnwICp5ock5cDJs8hvDEqcIr4GS+aqcNB1rLDpmvjkfxK2O9
SDV9qwbcK97IwM3pBn4c/AFgxw/qminG5yRKIAxob7uRJw52vz1BgXLSYBzedONr
IPxTr9JwvjHUV+8PNaYbsz6tvmJatUoxL1R7Amqe9b+TR2gNdzfyDcZGesMa5L37
bw9nrpMwZqa0twOP4M1gxW/15UOddfjMoaymNi7d/jAtkR3Q8Qc3q0IMKpaW052W
0hi/aoH5MOU6hjxjQmXPr6Eft34FZLpFGRFCXOjdkD4ytTmuaJJwbgwmE6jyYy4T
XzbFbjzzCSUqp3Q4D84WWArKWqhTJFM5TBdKjp0Hr37QimuIBIpy01UfzLE4yqwD
cIpt/U6v2Sq9ahQU8WvOlFin0q76G2kavHiJVAXEgbYThACuR4oIwOJrmjC1BlbA
xHa0KCOnrdU5cGHIww7t1+lXPgvevfjlf9cWkzJ8FSmsRamrcFNvqcWBSzHTVYwS
E5syPbVoR/Yc6TFAu7SLCaLL2L6lTA7w5llEs3/LaIMUhEm69uo=
=YeEL
-----END PGP SIGNATURE-----

--eNaK6z0pM8Rvbchh--
