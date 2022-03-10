Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1FDC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 09:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbiCJJyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 04:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbiCJJyc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 04:54:32 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874E4D271
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 01:53:21 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C1D725C02AF;
        Thu, 10 Mar 2022 04:53:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 10 Mar 2022 04:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=Qz18bNmdtCINU2zBuC2il/3KZTMz5KiJ1Gr4ts
        PN1Ag=; b=r3st5/IEcjnXhVqfVX0Di+wLOzRDQEXvjv2JCtk1JW6Yq0Z6cTAHnJ
        MfTk+u5HPw1GSRYIeA3mHn3dwLN/8SJimzEw2AUGd4PaEd2n3zQ1yxRI5wcV4/KA
        871zvcxD1j482MhJdYnvdEKbS2wMBskewFtf8M65XWKtX1CJWnQdWFX6KK+sJyaK
        Gda0cXSBd6kBoWY/Cm62U9kW6DiLjh5pbayLtvxUXVXVbVL0rCkz0UkXWnh1X6jA
        AslatHxKEwK6pr12a/IsyA4IlBeJw4Lwvaw9aSXZBFZvnI3rBpj0PQFv548fbnuP
        owgMhqwNWX6Tprehbo5J2bWR2V/8K/3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Qz18bNmdtCINU2zBu
        C2il/3KZTMz5KiJ1Gr4tsPN1Ag=; b=AR/LHDbWu85HKyRCqdZGlNUROL6uSbGCY
        C+RmFTAeoTarOukmzd5kofx6w31EdcqEwMkStljtrv33ToiaDMSIJopin/UfKCOc
        z5uu+HCCr1Czkh/WfqingIznKj/Gngwx14Yxbj7ygt3gdN/KZGeaiwfv3h7GJA3+
        heHKNCWVdVTP4fFc9gwMGOQxlHVWppB3IgmAQmsoITYYIeVKdchMCAITGbJLeoxs
        yWoEF4hKG7l2+dgQiBu04EXrrSBTMJmpUQdzPDnx6CgSR4/DvWc2V3+hLtd+jnhm
        DvVmciVQ4GFf5vLMPqNd+MIsKNnSo9mUp9jpg6RlJO8ZsYhaKw5uQ==
X-ME-Sender: <xms:kMopYvQR6MQjpUruYEgR0OrhKAcXqNbJDU_vryux1-cdBTBpMz1mhQ>
    <xme:kMopYgz51sNaCTgaOMTeLWIeivJBJCMbJn2bWXqX2zSGTsIa2i4pt_mUVnlwFleSV
    BZfVFG-cCcMzUSsAw>
X-ME-Received: <xmr:kMopYk0quXz2RkWwiMG8lJc4Sqo-sAZNDtpNdbWFxYYyUozRfWdMuvkMg2ywc9ZGo-w0rVyEBvP5Hd70wCkePS6EhOj-gPBOLgInw9HI7p52i8ot335RzOL58ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvtddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:kMopYvCct4Dgih5ltDre14EIpyVffSqlehFxBtrYA9QKu5u3dFnGbA>
    <xmx:kMopYog2sc4PJFLtwa-sx34J1bzU_U8tWkg7i5GFRDcgHgcELYmwSg>
    <xmx:kMopYjoEue5jaTZ92jUmgeZIcKXrN_IPdtR5J9srSWLpUCID91ac6A>
    <xmx:kMopYkjeYLO7pdCipVArjFw3eiYg72HlVKcOktITDD9bXtjFSjtQ0Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Mar 2022 04:53:19 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 78d412dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 10 Mar 2022 09:53:18 +0000 (UTC)
Date:   Thu, 10 Mar 2022 10:53:17 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/8] core.fsync: add `fsync_component()` wrapper which
 doesn't die
Message-ID: <50e39f698a7c0cc06d3bc060e6dbc539ea693241.1646905589.git.ps@pks.im>
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+DgjY3HdIEZSHXfa"
Content-Disposition: inline
In-Reply-To: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+DgjY3HdIEZSHXfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have a `fsync_component_or_die()` helper function which only syncs
changes to disk in case the corresponding config is enabled by the user.
This wrapper will always die on an error though, which makes it
insufficient for new callsites we are about to add.

Add a new `fsync_component()` wrapper which returns an error code
instead of dying.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 cache.h        | 13 ++++++++++---
 write-or-die.c | 10 ++++++----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index f307e89516..63a95d1977 100644
--- a/cache.h
+++ b/cache.h
@@ -1745,12 +1745,19 @@ int copy_file(const char *dst, const char *src, int=
 mode);
 int copy_file_with_time(const char *dst, const char *src, int mode);
=20
 void write_or_die(int fd, const void *buf, size_t count);
-void fsync_or_die(int fd, const char *);
+int maybe_fsync(int fd);
+
+static inline int fsync_component(enum fsync_component component, int fd)
+{
+	if (fsync_components & component)
+		return maybe_fsync(fd);
+	return 0;
+}
=20
 static inline void fsync_component_or_die(enum fsync_component component, =
int fd, const char *msg)
 {
-	if (fsync_components & component)
-		fsync_or_die(fd, msg);
+	if (fsync_component(component, fd) < 0)
+		die_errno("fsync error on '%s'", msg);
 }
=20
 ssize_t read_in_full(int fd, void *buf, size_t count);
diff --git a/write-or-die.c b/write-or-die.c
index 9faa5f9f56..4a5455ce46 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -56,19 +56,21 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
 	}
 }
=20
-void fsync_or_die(int fd, const char *msg)
+int maybe_fsync(int fd)
 {
 	if (use_fsync < 0)
 		use_fsync =3D git_env_bool("GIT_TEST_FSYNC", 1);
 	if (!use_fsync)
-		return;
+		return 0;
=20
 	if (fsync_method =3D=3D FSYNC_METHOD_WRITEOUT_ONLY &&
 	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >=3D 0)
-		return;
+		return 0;
=20
 	if (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0)
-		die_errno("fsync error on '%s'", msg);
+		return -1;
+
+	return 0;
 }
=20
 void write_or_die(int fd, const void *buf, size_t count)
--=20
2.35.1


--+DgjY3HdIEZSHXfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIpyowACgkQVbJhu7ck
PpQieQ//fsqIz16NBUIc3jdQZrYn0VPZsguq1pKCy3yMVH8mYEVWBkYz5GwK2WaO
R97q4U4BxXBOmdvJlAADIAgkn7UwXtE/tvSvxSMWttanUMJpvyXUFdywGD2izv8O
0TE2YuvdY9ad63GcAw6TiIS0W1dmTrLCpMVcGL1mFPDzBEZyQF6FWeF5I8PKnxR9
g16duTq6m7L29AVMyR386PfZ9lLuzzs8XTZhyzjWGo2brIxyUGx4XoX89B6C5gBh
DNtOwyRWdHL318Ym4h/ee7O+AU3kWin2Z/qbOI05Pt7JA1LQ52+ncSgWLtfpz72y
Notded1mv//cfF1JIOoL0fYt+FQYeBIOkgI1WpxjICGSLY9WX9Jf1wjZV/UjG6Qk
oZ7WuItwds3XSUF0wMkpwAGdtdt5AZNjbIdmhFXz7amc1jJlq65G/fA1C9J96YHr
W46gRzLH5+jajpLIrmmjCwC46W/f+KrbLNEz5f+R1bpujyXSPMPoJCv2BGZVtAH/
Kf82gl6xn/PLQi4VQkBCXT7RMmlGSHgvBOAi3eRYTwwMGk/28rsSxUNTP7f7WwMf
xfi4xuKkkjFt1znoO1e7pwQvhhuQe01gGCDaKyZNAi8s5lhg1HHD5KFoQaWgMdB1
KhNZvl4mBn28epjYoUmTwVeNf+1asPLkOrriwU9q2P7IyvKqQLQ=
=2nSU
-----END PGP SIGNATURE-----

--+DgjY3HdIEZSHXfa--
