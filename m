Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EA8C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 12:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DAB5613FF
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 12:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbhD2Myh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 08:54:37 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:53173 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237233AbhD2Myg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Apr 2021 08:54:36 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 32871165F;
        Thu, 29 Apr 2021 08:53:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 29 Apr 2021 08:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=rhnVOzZ1fX2Vj5uOyShZyr4g/i2
        bE0yYlrfg10LV5iY=; b=ZTKjOSlDtsY8M+Gv6rrNm1Tcnq72bgVP5dAXwccsoQU
        /GslVFmMF6/CpfFTS3UwQYLuACtV3fn0a23rGA7VxBtF4kWcWGsK4wIQX562nOvt
        rpdHjhbs/IWBQKIbp/E1Bzisz+Ju1EBPn9OtAi6X7ZB/stiYAvgj73I93iHdBe3B
        2+q8Lo0WsN8xPlh98NVJ0ZmzPnwjfjRov12+Wd2sjEGhk1UivG4RNElhGm3Gu72D
        YQCmWIgtAS6AVDAYX9ih+kll8w8MUbI+GZUEG0NgE3QWjL/kQ4ifCMO88x8Ad6PQ
        s3cW0nmJplxoJejiGtLKUwwTLsUk4BDyjDuiqZ55+9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=rhnVOz
        Z1fX2Vj5uOyShZyr4g/i2bE0yYlrfg10LV5iY=; b=KailSHptFp6QuEYQCcsruy
        gRZRWw0SpUDWExpH+nY3Vy0ua7ZEM85iApU6jdeQsb6mMXhKDIPxgzfv8zf1Ap/S
        a0jeL4C2pKRwG/rcq/c8Jp7Ko7P8AT+MWbbPjOST0euAMpMZzO+43sQYWetwkXzJ
        iQ3jDjQS1Tb+m5yjzwb9JMGgmNDmpt7JeXKw0ElsWYYjYp1cb1MOkXAkSfZABy0L
        K5vo189TJB3VOgMlCQ2v6qbzpPiEB8nZfP9mt/cwWzNilr8eZgWbJtOo/9QCQK7h
        gGsJd+X8++iP7rbN3lQzCGdVqsLqaDpkfuT/Qv9E94ofsXCbs2iM5bAIc8YIuJ0Q
        ==
X-ME-Sender: <xms:W6yKYMR5XWNWe7Hc39ma4Cs9D912Ae36FBnZ3JNJr6eEGM1W0OEuSw>
    <xme:W6yKYJwM2crXzLNp4WiSuVh3jx_tlMBEwalV7adCoBmw4XsK0qh7Nm8hzduAJFQCS
    T80fvQcRy4e8wI6Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvgedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnheptdffjeeiudduleehvdfgteeifeelheejte
    dvteduiedttedvtdffffefhfdvgffgnecukfhppeejkedrheehrdefgedrkeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:W6yKYJ3e7j41cPijsgDYKA7QvOGgdtfQvD6XXtk22byA4DpgN98W7A>
    <xmx:W6yKYABDVQsELILQBxkrAixspdGPodUhqqxjacpnH6T3d2y-X1q6mg>
    <xmx:W6yKYFhLw210JfrzTHl0mdf93fXqvkkfYDPMOTAcoAliTZ9wV9et_g>
    <xmx:W6yKYFJSDFFU2fxsUTZJHrQVHtcxkVKa0BCjqX8i6gmwMfZgVIsFRw>
Received: from vm-mail.pks.im (dynamic-078-055-034-087.78.55.pool.telefonica.de [78.55.34.87])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 29 Apr 2021 08:53:47 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f76a7432 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 29 Apr 2021 12:53:44 +0000 (UTC)
Date:   Thu, 29 Apr 2021 14:55:29 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] git.txt: fix synopsis of `--config-env` missing the
 equals sign
Message-ID: <08049f3b1088a301ea87db9a69454a2516b9525b.1619700731.git.ps@pks.im>
References: <cover.1618847606.git.ps@pks.im>
 <cover.1619700731.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i1YnONXanHFwJa+B"
Content-Disposition: inline
In-Reply-To: <cover.1619700731.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--i1YnONXanHFwJa+B
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When executing `git -h`, then the `--config-env` documentation rightly
lists the option as requiring an equals between the option and its
argument: this is the only currently supported format. But the git(1)
manpage incorrectly lists the option as taking a space in between.

Fix the issue by adding the missing space.

Reported-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
Signed-of-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3a9c44987f..ba5c8e9d98 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -13,7 +13,7 @@ SYNOPSIS
     [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<name>]
-    [--super-prefix=3D<path>] [--config-env <name>=3D<envvar>]
+    [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]
     <command> [<args>]
=20
 DESCRIPTION
--=20
2.31.1


--i1YnONXanHFwJa+B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmCKrMEACgkQVbJhu7ck
PpR/1w/+OWfY3mcmKufi0Mib7esl+upuSom+QM0gXlQqeRsZwCXPQKnJ1srxKp2A
lz+5SJQn2wjSygAL9JDZeUVAmhzeekm43sshgg86K5ldpnJP8LlsdvYSK8Vx+rc5
n40Zv4SJSrsEfeDnWEHc/VqHtPqLoysv/xfG7OMdDZ75pQnHsGlONHfasy+bpC3d
F8jaPk79SVPuYSMJ/tJO2jdgJ3sFDf+RW32+Bqk6A4gBof2bSmU/ERA1OeP3LUcO
1S9WqSTkdI5IEbS/crlo8MUJYewSX9As/ZnPDnqcHzqKJITXTjdW8kb7EprXiIES
nlWDBSL9XFVy6dlmPklwdzRZE3dQeZbI/Z02HVO/6EkuGnwErTtOGjrFiphUG2nP
jpTpSdciyPRrEBxVmkwQL91i+ZXoEEWNSyfCc991SlanCUvW2VbiuFzzysZmZQfc
55ObiKMftemIU5iAagZLHAKVb+lp3wnMlfUPnJkeJe5pd4WLIBWc7tkMzWJYgpVH
Eckz1M5hUBjfM02JhezP+ZrRRcSBXZDm/cCZSrCeIXRl4T01jwZ1JIgjmWDj+clw
7PIeaTDSN4LkTtCfD3gHAtVxFC8esbdwct8Ax+mWBE3N6bw2OxsHHL/Ml8w0vXX2
roYI5XTmQF/ZYhQo6j7do/IrBkT/jnPbEg0Q/1rKo4yI8Hl/EbM=
=Fn55
-----END PGP SIGNATURE-----

--i1YnONXanHFwJa+B--
