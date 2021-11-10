Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DD1C433FE
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 11:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D278261152
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 11:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhKJLoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 06:44:11 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35795 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230440AbhKJLoK (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Nov 2021 06:44:10 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E8E5C5C014F;
        Wed, 10 Nov 2021 06:41:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 10 Nov 2021 06:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=6WTQzSMvK+xPUV3rDpoZhrJ1O3M
        7bH99gMwKIaED3NY=; b=CWmRUoHFDOsrlrr8NhLYuKm57ovAIao/1iABGhYjhTF
        y5v4sZPl4/RmmmK0moyV8wwqxojtG4l3C61+T+JlR2zzyczHPCsTBLZb+cT3SC3g
        ml9IeLpDNmL7tWt0rtTP5AlzIh1+7xAU7ClbnNYym/VNegUrOVOm1Z7Lv9Ho69Rw
        jwklk7YWu+RKLs6FqDdvFEZkruqygL/czZbtEckARCmQns7MsqNhRn9ET+mthb/U
        wW9VKO7lsGEVHkwg01CGuILthYezLmCKBU/d0z3OWqdwcyIgCIUndxFXcoyENUcz
        2VMdpRjxvs8xlwb8is1l4BWWeshUXv+xEa+f510i/bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6WTQzS
        MvK+xPUV3rDpoZhrJ1O3M7bH99gMwKIaED3NY=; b=UB4HJ+ehXwdTkr89MxW9oV
        lmxfA4ElLDHhBhQXQqdZXowUYyDVNW89/ztIfT09aruuYi8tSmA6CqQYrLpHxY+A
        BlOgZ53A9tSypnzIHQp4qn2t4gNHxm0Ar3d3IwSojojXB9woGaV72VmU4A9CO/He
        QpHU0Q5K0/1GRhraRAwJCycLh1s7+vNTOcYYQ+zamWbhQrjXsf3O27W2R1ZY2PQg
        4RUh0zuU9FrnsxbCmTWL1lAWvAVfLGefIdn1qwM15SbzaweyRN+hY4QoHKrKHAZ5
        AloA7w4VchA3nrx1Kwufxm5zbpyw1zlXnaCgsatUqdVIKY1ovTCSF4ftxVHL/wcw
        ==
X-ME-Sender: <xms:4q-LYVFuaawJymV-PI8BL6Ps1OYotEm3m4lpLWh0l2QD3PsQC3fMXw>
    <xme:4q-LYaXaolo6FZIkXd-oR2Cr-aMMfwT-WUE8MlVw9iyJIbWExGlHGLc9O_SsLXrtn
    Eq3t6xhpGMZbBg9UA>
X-ME-Received: <xmr:4q-LYXKuQ4VSjhB48EFgAGXxO3FDEuySPu-VeW30Pg5sHxrU__yWUL-pTIF7aLGLqeGe5vW_thL85MoSup8m6FHjaPw-kCe4Ky9l4sox6MtKAEd9R1d_Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:4q-LYbEeh34rUC550-7EGWXFGoCiQc7todw1R3QGHi3d76u2U1zfLA>
    <xmx:4q-LYbXbikrvJLKR5LxOGuMN3l1pUVQIXdrRfTW1JGhc_k0zy-3ZyQ>
    <xmx:4q-LYWPGRoAypcTl_uTkhhjYdkaOx4JHGZq2HEKf4tFbmqS8BbHHHw>
    <xmx:4q-LYRchHGlLbJOoUkpCC5I59KsY9YR87sU9ECwliiDAJiLQWQrDUA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 06:41:21 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 723f5b5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 Nov 2021 13:26:32 +0000 (UTC)
Date:   Wed, 10 Nov 2021 12:40:59 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: [PATCH v2 2/3] wrapper: provide function to sync directories
Message-ID: <3ac9d4d7abd224a4c0991f1036f2d95eedb9ceac.1636544377.git.ps@pks.im>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <cover.1636544377.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lvPV2hy4tZECEMyd"
Content-Disposition: inline
In-Reply-To: <cover.1636544377.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lvPV2hy4tZECEMyd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In ec983eb5d2 (core.fsyncobjectfiles: batched disk flushes, 2021-10-04),
we have introduced batched syncing of object files. This mode works by
only requesting a writeback of the page cache backing the file on
written files, followed by a single hardware-flush via a temporary file
created in the directory we want to flush. Given modern journaling file
systems, this pattern is expected to be durable.

While it's possible to reuse the `git_fsync()` helper to synchronize the
page cache only, there is no helper which would allow for doing a
hardware flush of a directory by creating a temporary file. Other
callers which want to follow the same pattern would thus have to repeat
this logic.

Extract a new helper `git_fsync_dir()` from the object files code which
neatly encapsulates this logic such that it can be reused.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bulk-checkin.c    | 13 +++----------
 git-compat-util.h |  7 +++++++
 wrapper.c         | 21 +++++++++++++++++++++
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 4deee1af46..e6ebdd1db5 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -98,16 +98,9 @@ static void do_batch_fsync(void)
 	 * hardware.
 	 */
=20
-	if (needs_batch_fsync) {
-		struct strbuf temp_path =3D STRBUF_INIT;
-		struct tempfile *temp;
-
-		strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", get_object_directory());
-		temp =3D xmks_tempfile(temp_path.buf);
-		fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
-		delete_tempfile(&temp);
-		strbuf_release(&temp_path);
-	}
+	if (needs_batch_fsync &&
+	    git_fsync_dir(get_object_directory()) < 0)
+		die_errno("fsyncing object directory");
=20
 	if (bulk_fsync_objdir)
 		tmp_objdir_migrate(bulk_fsync_objdir);
diff --git a/git-compat-util.h b/git-compat-util.h
index 97f97178e7..f890bd07fd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1221,6 +1221,13 @@ enum fsync_action {
=20
 int git_fsync(int fd, enum fsync_action action);
=20
+/*
+ * Issue a full hardware flush against a temporary file in the given direc=
tory
+ * to ensure that all files inside that directory are durable before any r=
enames
+ * occur.
+ */
+int git_fsync_dir(const char *path);
+
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Returns 0 on success, which includes trying to unlink an object that do=
es
diff --git a/wrapper.c b/wrapper.c
index e20df4f3a6..6c6cc8b74f 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "tempfile.h"
=20
 static int memory_limit_check(size_t size, int gentle)
 {
@@ -601,6 +602,26 @@ int git_fsync(int fd, enum fsync_action action)
 	return 0;
 }
=20
+int git_fsync_dir(const char *path)
+{
+	struct strbuf temp_path =3D STRBUF_INIT;
+	struct tempfile *temp;
+
+	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", path);
+
+	temp =3D mks_tempfile(temp_path.buf);
+	if (!temp)
+		return -1;
+
+	if (git_fsync(get_tempfile_fd(temp), FSYNC_HARDWARE_FLUSH) < 0)
+		return -1;
+
+	delete_tempfile(&temp);
+	strbuf_release(&temp_path);
+
+	return 0;
+}
+
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
 	int err;
--=20
2.33.1


--lvPV2hy4tZECEMyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGLr8oACgkQVbJhu7ck
PpQX+A//d+A3wvOgdLDsUFb3IB74PUZy3aWFd2ZANC1ZbwUED1mxMJXEFGHvGLGi
FoBv0IWqNBMctwJLycSMrgSE/GEEl7QCFlX9yWrMeCMUSiIteE/MaC2QHZ+hTaih
N089DtdmPWCC+A6bjYaifb5VUPNGj3fUrt9abfb5l+/mW96m7Q+d7fz8zDUXhMze
65iruA7eGNgo7BjSGxjTZEWrabQEHqMtx98iWwn/ECy2C13dUAc9R2DNGXWdWfgp
/Oezm6pcG0DJeZZVmWVR/vRt55C9Z97d+rpZpYUp8cGaeay/UtKYgmLEs7+QJ+GL
78kzAOOINmQNzXPm7aALI+mE29PzGkJ7Gl1EmOKuNggePkdXfATiPia1g0hoqZm5
pGsE7SR1DI+tVLsIH3KzGeu++Fb9uT9E5L2+JYiBTLHXPC4fYHf7E3/TRF9/6dlD
eoFWtPqeAAHY3mmxTWPFIr+FuRvqvF5SN7qUA2635scTbhgBfryyqkaQkstbP+Zp
OABWKGiDw7g4Usn4WVrUKcfP9bEEuslq5g7quS+WSRjXp21V5iweeOSvufu10Jz8
+b0h2rrG1FaqhRev0M7cvQFf7NRBMv7TSxKRJ4qDTa+X98AJz8Rb+unfU5WAsh4P
k8eSw4HjW5NfZTLRvp99WmRVKyUUwufiXjpRNY2cspGc/3DAJjU=
=tWD3
-----END PGP SIGNATURE-----

--lvPV2hy4tZECEMyd--
