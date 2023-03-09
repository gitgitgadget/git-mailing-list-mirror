Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3051C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 13:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCINJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 08:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjCINJf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 08:09:35 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1242B2449F
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 05:09:33 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 906025C011B
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 08:09:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 09 Mar 2023 08:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1678367371; x=1678453771; bh=XNnIbWFj7uXrJPNbh97LFvKJZ
        AAYggJuWibPI81hKVg=; b=YCLmWiAPkofT7tkM+GESV5ynrTzgMsErC8T57wa3Z
        44JTlk0cU1B5DurmmuR+0+lqyPxlQoRb7mMIWkju9JMuFr4em4C8IRjXSKV9U7hK
        430IlEOuN1kbXxSvqr4Su7OrUjQCj0eeOW/IW+dB5/u5mJ17BwiIsknyOEmUntKh
        ahNVv+4Fm/ZIgtYHjefeeIhwDWLLDiS89Yjt3udtYNs93Q0MKqrIr6O0Qk3nXNxV
        wSpth1XhhxicQPTiPMtRX+AW2z18jU4y0pXAU/3FPQod/4pUbqaAjKsX7DB8TgQq
        Q5kkwFpdXRkO58YNiXqhN7UehwRIdtdwkhbHjI6shPRUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1678367371; x=1678453771; bh=XNnIbWFj7uXrJPNbh97LFvKJZAAYggJuWib
        PI81hKVg=; b=l3ufzN/ynBAt61IEn0WO6dmApx5cKnmMLn5o+4Iw+TKwI3qKVrC
        N+PUylziHFbiYs/gSwzg3gDXeEF451i9+BrgNl8EHTq78WJLcpPh/5pWmjKtugYZ
        +3PZnsTC5erQQo0HJhdPASpt0Ro0R4foBJsPTSFzaOq5wUiLErz3sswvhrWIhp1d
        FbPuN5qyXUBM8mj44IGkqaQ69y168nskM+Ll0+16hhl6pcZqqlNnWFlbkaVL1UGQ
        TXQVe+tOSkoQB6Tv7Bfnxn5JSITXiyz7ZqjPdV8a8Cq1bp8RtuR30kDxzBXEEwOA
        9ibKCLthdvBdiyaS1rOm0rjKVRGIl8tTAxg==
X-ME-Sender: <xms:i9oJZNCxnyUFjxa85PlxQYGqAiyex96uY30Q6x-RQh7hpPkEu_UcyQ>
    <xme:i9oJZLixdRJAcvIn2SGCV3HGvJZ63IiehsdkZxO2DS35OTGWTkvT2FLJDMmBv0bw9
    r1hYvvK7bnR5jcdFA>
X-ME-Received: <xmr:i9oJZIlTyPa3HFqRq24Z6Alq3TicAINA6bINuqnO4Tn9lBoXw2TdM4WKbDpRU0hol7kjU67jqR2RzGCDqayW2QR5Mqs66H9TScKpwgrNZj41NsY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduiedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:i9oJZHwTiCNVJphWKZKVi6hCkbZy3GRkPEH2J-z10jy3UYqxh8pizA>
    <xmx:i9oJZCR4BR1H5LxubbX3s41GTrIG031xBRWSxDxTKZTTEVzSrldjXQ>
    <xmx:i9oJZKYbW7_WQFrvhJmfP7Q5jg2KzR8qqQPVc01kbRqGPeZBPcwH5Q>
    <xmx:i9oJZJNj6eFOkPBuxkIO_Rv6cI9pQ6So8q5UeJcWqkAm7tzX1lqYcg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Mar 2023 08:09:30 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 081bda30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Thu, 9 Mar 2023 13:09:17 +0000 (UTC)
Date:   Thu, 9 Mar 2023 14:09:23 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] receive-pack: fix stale packfile locks when dying
Message-ID: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v4NCy6+qyIPH+hXE"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--v4NCy6+qyIPH+hXE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When accepting a packfile in git-receive-pack(1), we feed that packfile
into git-index-pack(1) to generate the packfile index. As the packfile
would often only contain unreachable objects until the references have
been updated, concurrently running garbage collection might be tempted
to delete the packfile right away and thus cause corruption. To fix
this, we ask git-index-pack(1) to create a `.keep` file before moving
the packfile into place, which is getting deleted again once all of the
reference updates have been processed.

Now in production systems we have observed that those `.keep` files are
sometimes not getting deleted as expected, where the result is that
repositories tend to grow packfiles that are never deleted over time.
This seems to be caused by a race when git-receive-pack(1) is killed
after we have migrated the kept packfile from the quarantine directory
into the main object database. While this race window is typically small
it can be extended for example by installing a `proc-receive` hook.

Fix this race by installing an atexit(3P) handler that unlinks the keep
file.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/receive-pack.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cd5c7a28ef..0a6030d775 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2186,6 +2186,12 @@ static const char *parse_pack_header(struct pack_hea=
der *hdr)
=20
 static const char *pack_lockfile;
=20
+static void unlink_pack_lockfile(void)
+{
+	if (pack_lockfile)
+		unlink(pack_lockfile);
+}
+
 static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 {
 	strvec_pushf(args, "--pack_header=3D%"PRIu32",%"PRIu32,
@@ -2281,6 +2287,7 @@ static const char *unpack(int err_fd, struct shallow_=
info *si)
 		if (status)
 			return "index-pack fork failed";
 		pack_lockfile =3D index_pack_lockfile(child.out, NULL);
+		atexit(unlink_pack_lockfile);
 		close(child.out);
 		status =3D finish_command(&child);
 		if (status)
--=20
2.40.0.rc0


--v4NCy6+qyIPH+hXE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQJ2oIACgkQVbJhu7ck
PpSE5g//UoyvXcNpWsbQ2aDkeAPGCdw/ThrIPttjcG266j4NEMJfQHPEjnPXbVZX
gZF9vLZWQi1mbgVa01uRF/40V4LnKq11NYw//cvwoLxICjzkBX0H2Y6qynJmcYJz
hnLB7GfABqxTnlhUb4oqsBl5twWnA8KVLDA7tYlTI0IdW6EkDzCtGNP35iU4jK4A
D2hXTDnWmq0iGrRL9NXNLYvW5bv1zdCeqvAMVVcyD6HCvJRb4eE3TzLmJgUzlyZ7
qQXIMyl3lHr3C5NhqXPPTfak1QQvorqzNh6aa8emhGgLhUIYcwdkZQhf8WvxFpjy
L8y9rK1vt5eEQ144RTAshALqZNRRqkVj9h6kwZIPgZyflzpY1RWscbH4sagjl7P9
OJergYQG6cpPQobmeZ8C9CN3UvVJpUkRf9rOzocHkMK/9AqBrwPf39R/JwEl3SSZ
TlFFjH8c98J4q91VYw1VWVR0sXAhQioNMkXIJmXVcl9GbpmRNjM42GkenLv8u4zL
bmwkpjjfzXUItouueXEzb77y4FdvksNEZXUB4QCdqEqA5RFn3sGTpG3atX5iIBkw
EtqnqZn0hQ0XZjYCLTllXSHmFAFMV+z4bZWLMuPvn1WRn1Z9u/MzC4R8SIVWgzRJ
DUfcqa9WA8bTIjZdgQplAQFNJ1xyvkX48qy5k6UTxMMQ1XE9lZA=
=dafv
-----END PGP SIGNATURE-----

--v4NCy6+qyIPH+hXE--
