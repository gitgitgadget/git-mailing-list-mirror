Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34B3C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 11:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D480B611BF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 11:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhKJLoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 06:44:08 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59013 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230440AbhKJLoG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Nov 2021 06:44:06 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6816F5C020F;
        Wed, 10 Nov 2021 06:41:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 10 Nov 2021 06:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=MShJwPBeKt0Sc41wjqCPpBdkteI
        dXABJdu8HFg3o2UI=; b=HDZ56wgIrPMc/d2xEc+hKNES9XjhQ+6cBikl36wJIqV
        MKC3rJIE9w/49vzzq12rvwQHLfwB7xOHP8QDG8+uJ+T8HyhpdDTyudCx5WJ2K67u
        9TmVVN9cFan5Vju5ZijwX1V4cOU4LQBIDa3nQy+SAzU90b26NF7lic8gqtGT0bDZ
        kPRY55VzM6aqVbIg2A4gd41oWGOnA4Fchrdrb6Jgi3mGsessXqUs7xZRzQXmGpSi
        wlS69hvIQXnApyD9wji2keVYzBVQ0+fTFGjO73U7bgwPTR0Xr2wfbOVbq7XhuoAj
        DoifLQ3HqBqoWMQgCNKd4WUklgUAhgV9xfpv61fLJSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MShJwP
        BeKt0Sc41wjqCPpBdkteIdXABJdu8HFg3o2UI=; b=ZiMMw0QDLeIcstSvCCKmdS
        TwnRhAmZ0gqv8EN2ZnEWPyYP04JpbvzCiQ16hSA5rUCtVZ1vG4CzhseeQpp4dS6G
        jMgCetjx1KzkdrrW/0dz3gNmwIPOc+Qmq9O42aRleZaCfP6fSTOdzN0wag9wDCTp
        eXQt7QwSW8h+cuqECjcG0fhuRsUKY9jBuV4bMjAUbtSIDWeJSxA5odgBYkc8BY0I
        X50AQ0xcoz1L9QmP1wIXCnlRCN5MMUpaIT+oCC6cfBipqbghfX7eRZqa8X46LxfA
        w/Yjkw3b/otF4T6IucMh0BW3jigRdgv/CXWdUK6vxWambmbVK6TS70QgmlhkRocQ
        ==
X-ME-Sender: <xms:3q-LYSZN8iGbJJZX7zdaJuA7adQMvp24vZCUm9D6sFcS6MjmCgvVzw>
    <xme:3q-LYVYZeYC56RWJopy396-aYWsJfepa9m2LkLil6tOz8RFykbwxBkCis1UB4IK9M
    AApM7HPAQHKH-gaQQ>
X-ME-Received: <xmr:3q-LYc9l-2bsOCQXdE6ItnAkNenzTGZ6LlAzR8dWEJWUzVubqcWqrW7g2fbnY8TnaykB5rahSCyJuQ22dPF3wmAqp-PDD_svNMDgb-gDR-7MDJpWmsWLVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:3q-LYUq_OVi0kh4AMxxOmSNjHoHsjY5GlmqZdgq0cP6OUfNvnwj1Hw>
    <xmx:3q-LYdqy7jIZCYp7ExDIdcaqGQdjGpVnklVPFVaCqGQQG7Tfhr0mQA>
    <xmx:3q-LYSSfMJInGqyrGjdPFzJvDvUI_lS8o5BTf7VF3u4cRRILk-IG-A>
    <xmx:3q-LYWAuQdARZD_-9WWmAOb3fSFxY2P6UKUb_zWb1_l9gpXED9b1TQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 06:41:17 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ed12fa1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 Nov 2021 13:26:27 +0000 (UTC)
Date:   Wed, 10 Nov 2021 12:40:54 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: [PATCH v2 1/3] wrapper: handle EINTR in `git_fsync()`
Message-ID: <0c8e98295e91b656a89e1db53bfe02e7c7fc8432.1636544377.git.ps@pks.im>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <cover.1636544377.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zXiMRN/guOfsu/ok"
Content-Disposition: inline
In-Reply-To: <cover.1636544377.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zXiMRN/guOfsu/ok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While we already have a wrapper around `git_fsync()`, this wrapper
doesn't handle looping around `EINTR`. Convert it to do so such that
callers don't have to remember doing this everywhere.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 wrapper.c      | 9 ++++++++-
 write-or-die.c | 6 ++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index ece3d2ca10..e20df4f3a6 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -546,7 +546,7 @@ int xmkstemp_mode(char *filename_template, int mode)
 	return fd;
 }
=20
-int git_fsync(int fd, enum fsync_action action)
+static int git_fsync_once(int fd, enum fsync_action action)
 {
 	switch (action) {
 	case FSYNC_WRITEOUT_ONLY:
@@ -591,7 +591,14 @@ int git_fsync(int fd, enum fsync_action action)
 	default:
 		BUG("unexpected git_fsync(%d) call", action);
 	}
+}
=20
+int git_fsync(int fd, enum fsync_action action)
+{
+	while (git_fsync_once(fd, action) < 0)
+		if (errno !=3D EINTR)
+			return -1;
+	return 0;
 }
=20
 static int warn_if_unremovable(const char *op, const char *file, int rc)
diff --git a/write-or-die.c b/write-or-die.c
index cc8291d979..e61220aa2d 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -57,10 +57,8 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
=20
 void fsync_or_die(int fd, const char *msg)
 {
-	while (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0) {
-		if (errno !=3D EINTR)
-			die_errno("fsync error on '%s'", msg);
-	}
+	if (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0)
+		die_errno("fsync error on '%s'", msg);
 }
=20
 void write_or_die(int fd, const void *buf, size_t count)
--=20
2.33.1


--zXiMRN/guOfsu/ok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGLr8UACgkQVbJhu7ck
PpRGRw//f/EQL/0aRJLHys4o/YhwJwiMGh0HhsUtMQ5hxfhhDHGJrcrZsPVdSsUJ
VX0VkdXWuIugeskQX57NL8lFxYiku/y347TKJ+umLu4Lqi4zGf94EjFunHOno6vk
L+D299fGr9uQU4jrYQyOW6QC1mqI6hSGLlergzHZeaDny1N/E/hCNE1k6iM+i6WO
dnqdm5WeXEI7GGWxo65uOXUwPf2sxVKuyf1Yr4BKt81lpW48QP677UgF03WJ8fHP
oFiU8fuK48vY+qo/g/gA/9kWukidk+I4b3wUHNwe6yNof97qUVI1w7y9b1Ugn3Ny
a1CCMHBN6ZIX3R2+0RKr7aHJQDZ6M4CzZT7DfZjGQSYmeY/aADSQf9Qh64biGVPc
1U+L1ihmr21BXw30RItDXsI5926dR18MrMBeNChxSIdFMd9RvvGHOubPXu+O16aF
yVosx73qpEgi84NqCrWIhiKKrcUQFzTS5/p1779BmcTseb31GcYjWf0jYPYABD26
0Fjt0Ri7CvpFe0Uvt6rdIfKAIga3H98S5TLBWLp+Tw0ODkZChPWOlO6UoP7WobH8
H9yVSqQ8woG7qk3PnuWsIraa15yQuNZ4sNTbS/rmBiZ00BgqPzwoKQp7jf6+3SW2
NqZt0qMPXJQwRGP37quWl8JldmD2U1m8RiMNYv21uCpcvkgw7/s=
=PchW
-----END PGP SIGNATURE-----

--zXiMRN/guOfsu/ok--
